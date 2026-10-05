# Original scientific figures

All four illustrations are generated from explicit formulas and drawing commands
by [generate_figures.py](../scripts/generate_figures.py). No third-party image,
report PDF, logo, scan, extracted figure or external dataset is an input.
They are scientific illustrations, not results of micromagnetic relaxation.

| Figure | Definition and interpretation | Formal trace |
|---|---|---|
| [Gaussian surface](gaussian_surface.svg) | Schematic orthographic wireframe of $z/h=\exp[-(x^2+y^2)/(2\sigma^2)]$, upward normal at the apex; the red ring is $\rho=\sigma$. Vertical projection is illustrative, not a material parameter. | F01–F05 |
| [Curvature profiles](curvature_profiles.svg) | With $u=\rho/\sigma$, leading small-slope expressions $H\sigma^2/h=(u^2/2-1)e^{-u^2/2}$ and $\Delta\sigma^2/h=(u^2/2)e^{-u^2/2}$. They are not exact finite-slope curves. $K_G$ changes sign at $u=1$ for nonzero height. | F03–F07; the numerical limiting comparison is not a separate Lean remainder theorem |
| [Pair coordinates](pair_coordinates.svg) | Schematic top view: $\mathbf R_v=\mathbf R-(d/2)\mathbf e_\psi$ and $\mathbf R_a=\mathbf R+(d/2)\mathbf e_\psi$. The direction runs from $q_v=+1$ to $q_a=-1$; their polarities are opposite. This is a coordinate diagram, not a relaxed texture. | C01–C02 |
| [Spin rotation](spin_rotation.png) | Analytic Belavin–Polyakov field with unit scale and its proper rotation $(m_x,m_y,m_z)\mapsto(m_z,m_y,-m_x)$. Colors show $m_z$ and arrows the in-plane components. The rotated field has normal components $-1$ and $+1$ at $(1,0)$ and $(-1,0)$. | T04–T05 |

For the spin field, writing $r^2=x^2+y^2$ in units of the positive scale $\lambda$,

$$
\mathbf m=\frac{(2x,2y,r^2-1)}{1+r^2}.
$$

This construction preserves the unit norm, topological density and isotropic
exchange under uniform proper spin rotation. It does not assert equality of
anisotropy, magnetostatic, DMI or Zeeman energies.

The map identifiers refer to [CALCULATION_MAP.md](../docs/CALCULATION_MAP.md).
The [CSV](curvature_profiles.csv) stores the 601 plotted curvature samples;
column names describe their dimensionless normalization.

## Reproduce

From the repository root, install `requirements.txt` and run:

```sh
python scripts/generate_figures.py
```

Use `--output-dir PATH` to write to another directory. The code checks the spin
norm and compares the curvature curves against the exact geometry at
$h/\sigma=10^{-4}$, with maximum absolute error below $10^{-8}$ in the normalized
curvatures. SVG dates are omitted and SVG IDs are deterministic. Numerical
sampling is not a formal proof of an asymptotic error bound.

## Provenance

The Gaussian surface, curvature curves and pair diagram adapt the author's
existing research plotting routines. The spin field adapts the author's analytic
texture script. The public adaptation changes English labels and output formats,
removes document-processing code and external asset inputs, and retains the
underlying formulas. The upward-normal arrow is explicitly kept inside the
view limits to avoid clipping. Mathematical concepts follow the literature cited in the
main README; the drawings themselves are original project outputs.
