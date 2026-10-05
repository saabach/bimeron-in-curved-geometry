# Formalization scope

Lean checks proofs of explicit mathematical statements. Interpreting those
statements as a model of a magnetic material requires additional physical input.
The algebraic identities and consequences used in the analysis were formally
verified when amenable to formalization, with assumptions and limitations
explicitly recorded in the [calculation map](CALCULATION_MAP.md).

## What is checked

- Relations between principal, mean, deviatoric and Gaussian curvatures;
  normal/height reversal and polynomial offset-area factors.
- Algebra of a local moving frame and the linear/quadratic exchange decomposition.
- Real trigonometric angular integrals selecting the two axial windings.
- Actual first and second derivatives of the Gaussian exponential profile,
  exact curvature identities and sign/parity consequences.
- The topological density and its rotations/reversal; axial boundary-charge algebra.
- Products of second-order jets, their reduced-energy coefficients, gradients,
  mixed derivatives and orientation derivatives under stated phase hypotheses.
- A necessary and sufficient positive-definiteness criterion for a real symmetric
  2×2 block, plus a Schur calculation with one positional direction and two
  coupled internal modes.
- Conditional algebra for magnetostatics, intrinsic geometry, energy reversal
  and dimensional exponents.

There are **145 `theorem` declarations and 0 `lemma` declarations** in 13 proof
modules. Two additional Lean files import the library and print logical axiom
dependencies, giving **15 source files** in total. All 145 declarations appear in
the map, which groups them into **71 calculation items**:

| Category | Items | Meaning at the scientific-calculation level |
|---|---:|---|
| A | 15 | Complete proof of the indicated mathematical identity/result |
| B | 21 | Proof with explicit mathematical or physical hypotheses |
| C | 16 | Algebraic verification after assuming the physical reduction |
| D | 19 | Full analytical/physical derivation not formalized; represented quantities and downstream consequences have proofs |

Categories classify calculation items, not numbers of theorems. Every Lean
theorem proves its own stated conclusion. A category-D row does not claim that
the entire associated physical calculation was certified.

## What is not automatically checked

The project does not establish the physical validity of the ferromagnetic
micromagnetic model, the thin-shell approximation, a material's parameters,
experimental realization, or a complete equilibrium/dynamical solution.

Specific interfaces matter:

- **Angular selection:** the sine/cosine integrals are formalized; the axial
  approximation and nearly uniform curvature across a core remain model assumptions.
- **Radial factor $I_1$:** the integrand's polarity reversal is checked, but
  convergence of the improper integral and its sign for a chosen profile are not
  proved globally. The energy lemma takes the sign relation as an explicit premise.
- **Gaussian/Taylor expansions:** derivatives and exact geometric identities are
  proved; jet coefficients do not prove bounds on the discarded Taylor remainders.
- **Thin-shell magnetostatics:** a polynomial thickness integral and local
  cancellations are proved. They do not establish the singular self-energy limit,
  full nonlocal pair magnitude, convergence, or a complete convolution theorem.
- **Topology:** density identities and boundary-charge algebra do not constitute
  a theorem about global degree for all admissible fields or all boundaries.
- **Rigid pair:** adding the two local core contributions does not recover the
  connecting region, background energy, material-dependent relaxation or all
  other interactions.
- **Schur complement:** the finite-dimensional result assumes a positive internal
  block at the same stationary state. It is not a functional-Hessian theorem and
  does not establish that the required stationary physical state exists.
- **Barriers and lifetimes:** conditional algebra for reversed paths does not
  construct a minimum-energy annihilation path, a barrier or thermal dynamics.

Lean verifies the mathematical statements that were explicitly formalized under
their stated assumptions; it does not by itself establish the full physical or
dynamical stability of a bimeron configuration.

## Auditing and reproducibility

Run the commands in the [README](../README.md). The public audit uses only the
Lean sources and this repository's map, with no report files. The axiom audit
checks every theorem, allowing only Lean/Mathlib's ordinary foundations:
`propext`, `Classical.choice` and `Quot.sound` (some declarations use fewer).
No local axiom or incomplete proof is introduced by the public adaptation.

The mathematical source files are identical to the selected research originals.
Portuguese comments and namespace `IC` are retained as provenance; they are not
external dependencies. Legacy equation labels and document filenames in comments
are identifiers only. The [analytical model](ANALYTICAL_MODEL.md) supplies the
principal conventions without requiring access to those documents.
