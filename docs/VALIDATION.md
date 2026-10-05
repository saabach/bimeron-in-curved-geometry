# Local validation record

Validation date: **2026-10-05**. This records checks on the standalone public
selection, not on the private report or the full physical micromagnetic model.

## Environment and dependency resolution

- Linux x86_64; Lean **4.19.0**, compiler commit `6caaee842e94`.
- Lake **5.0.0-6caaee8**.
- Toolchain: `leanprover/lean4:v4.19.0`.
- Mathlib **v4.19.0**, commit `c44e0c8ee63ca166450922a373c7409c5d26b00b`.
- The manifest pins Mathlib and eight transitive packages. Dependency sources and
  build caches are downloaded separately and are absent from the public tree.
- Python **3.12.13**, NumPy **2.5.0**, Matplotlib **3.11.0**, installed in a fresh
  virtual environment from the versions declared in `requirements.txt`.

A staging selection was assembled without private inputs. Its dependency pins
were resolved using `lake exe cache get`. A second isolated copy contained only
public files, then received those separately downloaded dependencies; no original
research-project build outputs were copied. The proof modules were compiled
individually to limit concurrent memory use, followed by the default `lake build`.
The temporary filesystem initially ran out of quota during dependency download;
the validation workspace was moved to disk and incomplete cache files were fetched
again. No mathematical statements or dependency versions were changed.

## Formal inventory and build

**`lake build`: exit 0, `Build completed successfully.`** The axiom audit also
passed for all 145 theorems, with no local axioms or incomplete proofs. A search
of the authored Lean sources found no proof placeholders. The 35-file selection
has zero `.tex` and zero `.pdf` files, and all 97 local links resolve.
The counts, dependency revisions and core-file hashes are recorded in
[validation.json](validation.json).
The public audit counts `theorem` and `lemma` declarations, checks each map entry,
checks coverage of every declaration and verifies that the library imports all
proof modules. It also verifies that `AuditAxioms.lean` covers every declaration.

The map contains 71 calculation items: A=15, B=21, C=16, D=19. It connects them to
145 theorem declarations and 22 historical numbered-equation identifiers. There
are 13 proof modules, 15 Lean source files and no separate lemma declarations.
Counts are different from the scope of physical verification; see
[Formalization scope](FORMALIZATION_SCOPE.md).

All 15 Lean sources were compared byte for byte with their selected research
originals. Project configuration, toolchain and dependency manifest were likewise
preserved. No proof or theorem statement was altered for this repository.

## Figure reproduction

The public generator was executed from the isolated copy with a separate output
directory. All three SVG files, the PNG and the CSV matched the distributed
versions **byte for byte** in the pinned Python environment.
The unit-spin and exact-versus-small-slope numerical checks passed. All images
were inspected visually; the Gaussian normal arrow is inside the view limits.
SVGs parse as XML and have no external image dependencies. The PNG contains only
plotting-software/title/resolution metadata, without personal contact or paths.

## Selection, copyright and privacy checks

- No `.tex`, `.pdf`, typesetting auxiliary, report template, document-production
  script, bibliography file, archive or dependency directory in the public selection.
- No third-party artwork, papers, supplementary files, logos or private datasets.
  Each retained image is regenerated from project-owned formula/drawing routines;
  its source and interpretation are recorded in [figure provenance](../figures/README.md).
- Text and image metadata checked for credentials, tokens, contact addresses,
  local absolute paths and unrelated project names. Academic names and affiliation
  are intentionally retained. No personal email is needed in the initial commit.
- Local Markdown and HTML image links checked against the isolated public tree.
  DOI references are links only; no article files are distributed.
- No license selected. Public publication remains a separate decision.

These are scoped code/content checks, not a legal certification or a proof of
physical validity. Dependency licenses apply to their separate distributions.

## Repeat the principal checks

```sh
cd lean
lake exe cache get
lake build
cd ..
python3 scripts/audit_formalization.py --check-axioms
python scripts/generate_figures.py --output-dir figures-reproduced
```

Use the Python environment described in the README for the last command.
The formalization audit does not inspect any report sources. Its optional
`--check-axioms` mode invokes Lean and accepts only the ordinary dependencies
`propext`, `Classical.choice` and `Quot.sound` for all printed declarations.
