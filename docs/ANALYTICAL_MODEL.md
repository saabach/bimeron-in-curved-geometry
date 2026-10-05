# Analytical model and conventions

This document fixes the conventions needed to read the public proofs and figures.
[Map IDs](CALCULATION_MAP.md) below identify calculation items; mathematical
formalization does not certify the physical validity of the approximation.

## Surface geometry and exchange — G01–G07, E01–E04

For an oriented immersion $\mathbf r(u,v)$, set
$g_{ab}=\partial_a\mathbf r\cdot\partial_b\mathbf r$,
$\mathbf n=(\partial_u\mathbf r\times\partial_v\mathbf r)/\sqrt{\det g}$ and
$b_{ab}=\mathbf n\cdot\partial_a\partial_b\mathbf r$.
The eigenvalues of $g^{-1}b$ are $\kappa_1,\kappa_2$; an outward-oriented sphere
has $\kappa_i=-1/R$ in this convention.

$$
H=\frac{\kappa_1+\kappa_2}{2},\qquad
\Delta=\frac{\kappa_1-\kappa_2}{2},\qquad
K_G=\kappa_1\kappa_2=H^2-\Delta^2.
$$

A shell has constant normal thickness $t$, small compared with magnetic variation
lengths and curvature radii. Magnetization has unit norm and is assumed uniform
through thickness. In a right-handed orthonormal frame, the skew connection is
$\Omega_{aij}=\mathbf e_i\cdot\partial_a\mathbf e_j$ and
$\mathcal D_a m_i=\partial_a m_i+\Omega_{aij}m_j$.
Expanding the exchange density gives a component-gradient square, a linear cross
term and a quadratic connection term. Extrinsic contributions scale as
$A\kappa$ and $A\kappa^2$. This is a decomposition of Cartesian exchange, not
permission to add these terms twice.

## Axial-core selection — T01–T06, E05–E09

Use $\theta=\theta(r)$, $\Phi=q\varphi+\chi$, $q=\pm1$,
$p=\cos\theta(0)=\pm1$ and an equatorial far field for the individual core.
The angle $\alpha$ points from the helicity reference axis to the first principal
direction. For approximately uniform curvature across a small core,

$$
\langle w_q^{\mathrm{ext}}\rangle_\varphi
=-2A\left(\theta'+\frac{\sin(2\theta)}{2r}\right)
\begin{cases}
H\cos\chi,&q=+1,\\
\Delta\cos(\chi-2\alpha),&q=-1.
\end{cases}
$$

The radial factor is
$I_1=2\pi\int_0^\infty(r\theta'+\sin\theta\cos\theta)\,dr$.
Its convergence and the relation $I_1=p|I_1|$ are explicit model inputs where used.
The angular integrals are formally computed; the general improper radial integral
is not. Helicity, polarity and winding are separate quantities.

The axial charge reduction is $Q=q[\cos\theta(0)-\cos\theta(\infty)]/2$.
An equatorial boundary gives $pq/2$. Opposite polarities and windings add to
$Q=\pm1$ in the idealized bimeron decomposition; equal polarities would instead
cancel. Proper uniform spin rotations preserve the density but not necessarily
the full magnetic energy.

## Gaussian geometry — F01–F07

For $f(\rho)=h e^{-\rho^2/(2\sigma^2)}$, $\sigma>0$, choose the upward normal,
$B=1+f'^2$, and fix $\kappa_1=\kappa_\rho$, $\kappa_2=\kappa_\varphi$:

$$
\kappa_\rho=\frac{f''}{B^{3/2}},\qquad
\kappa_\varphi=\frac{f'}{\rho\sqrt B},\qquad
K_G=\frac{h^2e^{-\rho^2/\sigma^2}(1-\rho^2/\sigma^2)}{\sigma^4 B^2}.
$$

The azimuthal expression extends regularly to $\rho=0$; both principal curvatures
there are $-h/\sigma^2$. Thus $\Delta(0)=0$, although $H(0)$ can be nonzero.
For $h>0$, $\Delta\geq0$. At nonzero height, $K_G$ changes sign at
$\rho=\sigma$. Under $h\mapsto-h$, the metric and $K_G$ are even, while
$\kappa_i,H,\Delta$ are odd.

Near the apex the physical Taylor expansion uses
$H=-h/\sigma^2+2\beta\rho^2+O(\rho^4)$ and
$\Delta=\beta\rho^2+O(\rho^4)$, where
$\beta=h(1+h^2/\sigma^2)/(2\sigma^4)$.
Lean checks the stated coefficient algebra, not the remainder estimates.
The plotted small-slope profiles additionally take $|h|/\sigma\ll1$; the exact
Gaussian definitions in Lean do not require that approximation.

## Rigid-pair energy — C01–C12

Let $\mathbf R_v=\mathbf R-(d/2)\mathbf e_\psi$ and
$\mathbf R_a=\mathbf R+(d/2)\mathbf e_\psi$, with
$q_v=+1$, $q_a=-1$, $p_a=-p_v$ and $C_i=2At|I_1[\theta_i]|$.
The first-order exchange contribution is

$$
U^{(1)}=-C_vp_v\cos\chi_v\,H(|\mathbf R_v|)
-C_ap_a\Delta(|\mathbf R_a|)\cos[\chi_a+2(\psi-\Theta_a)].
$$

Here $\chi_v$ is the absolute vortex helicity; $\chi_a$ is measured in the pair's
axes, so its absolute value is $\chi_a+2\psi$. The local radial direction at the
negative-winding core has angle $\Theta_a$ relative to fixed axes.
The angle sign agrees with `IC.pair_angle` and `IC.pair_energy_from_cores`.

Assume $r_c\ll d\ll L_{\mathrm{geo}}$ and $|\kappa|d\ll1$; horizontal projected
coordinates additionally require small slope. This expression adds core energies;
it is not the full micromagnetic energy of a connected bimeron.

For longitudinal and transverse displacements $P,T$ from the centered pair,
$U^{(1)}=U_c+f_PP+f_TT+k_PP^2/2+k_{PT}PT+k_TT^2/2+\cdots$.
At $s=d/2>0$, holding the translational phases fixed,

$$
\begin{aligned}
f_P&=C_vp_v\cos\chi_v H'-C_ap_a\cos\chi_a\Delta',\\
f_T&=-2C_ap_a\sin\chi_a\Delta/s,\\
k_P&=-C_vp_v\cos\chi_v H''-C_ap_a\cos\chi_a\Delta'',\\
k_T&=-C_vp_v\cos\chi_v H'/s-C_ap_a\cos\chi_a\Delta'/s
     +4C_ap_a\cos\chi_a\Delta/s^2,\\
k_{PT}&=-2C_ap_a\sin\chi_a(\Delta'/s-\Delta/s^2).
\end{aligned}
$$

All radial quantities are evaluated at $s$. The gradient is $(f_P,f_T)$; the
force is its negative. The mixed coefficient has no additional factor of two.
Orientational derivatives depend on how helicities and background are varied;
a common affine phase slope $-\eta$ gives $U_c''=-\eta^2U_c$.
That family is an explicit kinematic assumption, not a law derived from the DMI.

## Stability, magnetostatics and open questions — MS01–MS06, S01–S10

Positive definiteness of the positional 2×2 block is equivalent to
$k_P>0$ and $k_Pk_T-k_{PT}^2>0$. Physical use requires a stationary point of
the relevant energy. Relaxing internal coordinates can reduce stiffness via
$K_{\mathrm{rel}}=U_{XX}-U_{X\eta}C^{-1}U_{\eta X}$ with positive internal block
$C$. The formal Schur theorem covers one positional direction and two coupled
internal modes; it does not establish a functional minimum.

Curvature modifies both volume and surface magnetic charges. Local cancellations
and angular structure are modeled, with regularization and boundary assumptions.
The complete nonlocal magnetostatic magnitude for a bimeron has not been obtained.
Background, connecting region, internal relaxation and other interactions can
change the total gradient and Hessian. Localization, a full energy minimum,
annihilation barriers and lifetime are distinct questions.
