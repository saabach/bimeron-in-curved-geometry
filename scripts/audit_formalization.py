"""Check public declarations and map/axiom-audit coverage; no private inputs.

Consistency checks are separate from proof validity: run lake build and the Lean
axiom audit as documented. This script never rewrites mathematical statements.
"""
from collections import Counter
from pathlib import Path
import argparse
import json
import subprocess
import re

ROOT = Path(__file__).resolve().parents[1]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--check-axioms', action='store_true',
                        help='Run Lean on every axiom query and check its logical dependencies')
    args = parser.parse_args()
    modules = sorted((ROOT / 'lean/LeanVerification').glob('*.lean'))
    declarations = {}
    counts = Counter()
    for source in modules:
        text = source.read_text()
        forbidden = re.findall(r'\b(?:sor' + r'ry|ad' + r'mit)\b|^\s*axiom\s', text, re.M)
        assert not forbidden, (source.name, 'unproved marker or local axiom')
        found = re.findall(r'^(theorem|lemma)\s+(\w+)', text, re.M)
        declarations[source.name] = {name for _, name in found}
        assert len(found) == len(declarations[source.name]), 'duplicate declaration'
        counts.update(kind for kind, _ in found)

    mapping = (ROOT / 'docs/CALCULATION_MAP.md').read_text()
    items, mapped = {}, set()
    categories = Counter()
    for line in mapping.splitlines():
        if not re.match(r'\| [A-Z]+\d+ \|', line):
            continue
        cells = [cell.strip() for cell in line.strip('|').split('|')]
        assert len(cells) == 9, cells
        ident, category = cells[0], cells[5]
        assert ident not in items and category in {'A', 'B', 'C', 'D'}
        module = re.fullmatch(r'\[(\w+\.lean)\]\(\.\./lean/LeanVerification/\1\)', cells[6])
        assert module, cells[6]
        for name in cells[7].split(', '):
            assert name in declarations[module[1]], (ident, name)
            mapped.add(name)
        items[ident] = cells
        categories[category] += 1

    equations = []
    for line in mapping.splitlines():
        if not line.startswith('| `eq:'):
            continue
        cells = [cell.strip() for cell in line.strip('|').split('|')]
        assert len(cells) == 4
        equations.append(cells[0].strip('`'))
        assert all(i in items for i in cells[3].split(','))
    assert len(equations) == len(set(equations)), 'duplicate equation identifier'

    all_names = set().union(*declarations.values())
    assert len(all_names) == sum(map(len, declarations.values()))
    assert mapped == all_names, ('unmapped declarations', sorted(all_names - mapped))
    printed = re.findall(r'^#print axioms IC\.(\w+)$',
                         (ROOT / 'lean/AuditAxioms.lean').read_text(), re.M)
    assert len(printed) == len(set(printed)) and set(printed) == all_names
    imported = re.findall(r'^import LeanVerification\.(\w+)$',
                          (ROOT / 'lean/LeanVerification.lean').read_text(), re.M)
    assert set(imported) == {p.stem for p in modules}
    if args.check_axioms:
        completed = subprocess.run(['lake', 'env', 'lean', 'AuditAxioms.lean'],
                                   cwd=ROOT/'lean', text=True, capture_output=True, check=True)
        output = completed.stdout
        inspected = set()
        for name, axioms in re.findall(r"'IC\.(\w+)' depends on axioms: \[([^\]]*)\]", output):
            used = {a.strip() for a in axioms.split(',') if a.strip()}
            assert used <= {'propext', 'Classical.choice', 'Quot.sound'}, (name, used)
            inspected.add(name)
        inspected.update(re.findall(r"'IC\.(\w+)' does not depend on any axioms", output))
        assert inspected == all_names, ('axiom inspection missing results', sorted(all_names-inspected), output)
    source_files = list((ROOT / 'lean').glob('*.lean')) + modules
    summary = {
        'lean_source_files': len(source_files), 'proof_modules': len(modules),
        'theorems': counts['theorem'], 'lemmas': counts['lemma'],
        'calculation_items': len(items), 'mapped_declarations': len(mapped),
        'legacy_numbered_equations': len(equations),
        'categories': dict(sorted(categories.items())),
        'declarations_by_module': {k: len(v) for k, v in declarations.items()},
        'unproved_markers_or_local_axioms': 0,
        'axiom_dependencies_checked_by_lean': args.check_axioms,
    }
    print(json.dumps(summary, indent=2))


if __name__ == '__main__':
    main()
