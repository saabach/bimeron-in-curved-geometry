"""Reproduce four author-generated scientific illustrations, without report assets.

Adapted from the project's Gaussian/pair plotting routines and analytic spin-rotation
example. No micromagnetic relaxation, simulation data or third-party artwork is used.
Run from the repository root: python scripts/generate_figures.py
"""
from pathlib import Path
import argparse
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.patches import Arc, Circle

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "figures"
BLUE, RED, DARK, GRAY = "#3B5FA9", "#B6474D", "#1D1D1D", "#6B6B72"
plt.rcParams.update({
    "font.family": "DejaVu Serif", "font.size": 12,
    "mathtext.fontset": "dejavuserif", "text.color": DARK,
    "axes.labelcolor": DARK, "axes.edgecolor": DARK,
    "xtick.color": DARK, "ytick.color": DARK,
    "axes.spines.top": False, "axes.spines.right": False,
    "svg.fonttype": "path", "svg.hashsalt": "bimeron-curved-geometry",
    "axes.facecolor": "white", "figure.facecolor": "white", "axes.linewidth": .9,
})


def save(fig, name, title):
    fig.savefig(OUT / f"{name}.svg", bbox_inches="tight", pad_inches=.06,
                metadata={"Title": title, "Date": None})
    svg = OUT / f"{name}.svg"
    svg.write_text("\n".join(line.rstrip() for line in svg.read_text().splitlines()) + "\n")
    plt.close(fig)


def gaussian_geometry():
    fig, ax = plt.subplots(figsize=(6.4, 4.6))
    # Orthographic projection drawn as vector polylines; z is normalized by h.
    def project(x, y, z):
        return .86*x-.51*y, -.25*x-.42*y+1.55*z
    u = np.linspace(-2.65, 2.65, 160)
    for s in np.linspace(-2.65, 2.65, 19):
        fixed = np.full_like(u, s)
        z = np.exp(-(u*u+s*s)/2)
        for x, y in ((u, fixed), (fixed, u)):
            ax.plot(*project(x, y, z), color=BLUE, lw=.8, alpha=.70)
    phi = np.linspace(0, 2*np.pi, 200)
    ax.plot(*project(np.cos(phi), np.sin(phi), np.full_like(phi, np.exp(-.5))),
            color=RED, lw=2.8)
    # A radial section gives the profile and a geometrical normal at the apex.
    ax.plot(*project(u, np.zeros_like(u), np.exp(-u*u/2)), color=DARK, lw=1.8)
    ax.annotate("", xy=(0, 2.2), xytext=(0, 1.55),
                arrowprops={"arrowstyle": "->", "color": DARK, "lw": 1.4})
    ax.text(0, 2.3, r"$\mathbf{n}$", ha="center", fontsize=19)
    ax.annotate(r"$\rho=\sigma$", xy=project(1, 0, np.exp(-.5)), xytext=(1.5, 1.5),
                color=RED, fontsize=18,
                arrowprops={"arrowstyle": "-", "color": RED, "lw": 1})
    ax.set_ylim(top=2.55)  # Keep the upward-normal arrow inside the axes.
    ax.set_aspect("equal")
    ax.axis("off")
    fig.tight_layout(pad=.1)
    save(fig, "gaussian_surface", "Gaussian profile: normalized height and upward normal")


def curvature_profiles():
    fig, ax = plt.subplots(figsize=(6.1, 4.5))
    u = np.linspace(0, 3.4, 601)
    H = (.5*u*u - 1)*np.exp(-u*u/2)
    D = .5*u*u*np.exp(-u*u/2)
    ax.axhline(0, color=GRAY, lw=.7)
    ax.axvline(1, color=GRAY, ls="--", lw=1)
    ax.plot(u, H, lw=2.8, color=BLUE, label=r"$H\sigma^2/h$")
    ax.plot(u, D, lw=2.8, color=RED, label=r"$\Delta\sigma^2/h$")
    ax.plot([0], [-1], "o", color=BLUE, ms=6)
    ax.plot([0], [0], "o", color=RED, ms=6)
    ax.text(.49, .61, r"$K_G>0$", ha="center", fontsize=16)
    ax.text(2.07, .61, r"$K_G<0$", ha="center", fontsize=16)
    ax.set(xlim=(-.04, 3.4), ylim=(-1.12, .75))
    ax.set_xlabel(r"Distance from axis, $\rho/\sigma$", fontsize=16)
    ax.tick_params(labelsize=16)
    ax.set_yticks([-1, -.5, 0, .5], ["−1", "−0.5", "0", "0.5"])
    ax.set_xticks([0, 1, 2, 3])
    ax.legend(loc="lower right", frameon=False, fontsize=18)
    fig.tight_layout(pad=.5)
    save(fig, "curvature_profiles", "Normalized curvatures in the small-slope limit")
    # Independent evaluation of exact geometric expressions and their limit.
    eps = 1.e-4
    fp = -eps*u*np.exp(-u*u/2)
    fpp = eps*(u*u-1)*np.exp(-u*u/2)
    kr = fpp/(1+fp*fp)**1.5
    ka = -eps*np.exp(-u*u/2)/np.sqrt(1+fp*fp)
    assert np.max(np.abs((kr+ka)/(2*eps)-H)) < 1.e-8
    assert np.max(np.abs((kr-ka)/(2*eps)-D)) < 1.e-8
    np.savetxt(OUT / "curvature_profiles.csv", np.column_stack([u, H, D]),
               delimiter=",", header="rho_over_sigma,H_sigma2_over_h,Delta_sigma2_over_h", comments="")


def pair_coordinates():
    fig, ax = plt.subplots(figsize=(5.8, 3.8))
    ax.set_aspect("equal")
    origin = np.array([0., 0.])
    R = np.array([1.05, .92])
    psi = .26
    e = np.array([np.cos(psi), np.sin(psi)])
    v, a = R-.72*e, R+.72*e
    for r in [.65, 1.25, 1.85, 2.45]:
        ax.add_patch(Circle(origin, r, fill=False, ec=GRAY, alpha=.28, lw=.8))
    ax.annotate("", xy=(2.7, 0), xytext=(-.30, 0),
                arrowprops={"arrowstyle": "->", "color": GRAY, "lw": 1})
    ax.text(2.75, -.05, r"$x$", fontsize=18)
    ax.annotate("", xy=R, xytext=origin,
                arrowprops={"arrowstyle": "->", "color": DARK, "lw": 1.5})
    ax.text(.30, .38, r"$\mathbf{R}$", fontsize=20)
    ax.plot(*origin, "o", color=DARK, ms=3)
    ax.text(-.05, -.27, "apex", ha="center", fontsize=17)
    ax.plot([v[0], a[0]], [v[1], a[1]], color=DARK, lw=2)
    ax.plot(*v, "o", ms=15, color=BLUE)
    ax.plot(*a, "o", ms=15, color=RED)
    ax.plot(*R, "o", ms=5, color=DARK)
    ax.text(v[0]-.08, v[1]+.30, r"$q_v=+1$", color=BLUE, ha="center", fontsize=19)
    ax.text(a[0]+.12, a[1]+.30, r"$q_a=-1$", color=RED, ha="center", fontsize=19)
    ax.plot([R[0], R[0]+1], [R[1], R[1]], color=GRAY, lw=1, ls="--")
    ax.add_patch(Arc(R, .93, .93, theta1=0, theta2=np.degrees(psi), color=DARK, lw=1.2))
    ax.text(R[0]+.68, R[1]-.16, r"$\psi$", fontsize=21)
    eT = np.array([-e[1], e[0]])
    vv, aa = v-.62*eT, a-.62*eT
    ax.annotate("", xy=vv, xytext=aa, arrowprops={"arrowstyle": "<->", "color": DARK, "lw": 1.1})
    ax.text(*(R-.84*eT), r"$d$", ha="center", fontsize=20)
    ax.set(xlim=(-.45, 3.05), ylim=(-.55, 1.9))
    ax.axis("off")
    save(fig, "pair_coordinates", "Rigid-pair coordinates: schematic top view")


def spin_rotation():
    """Analytic BP field and its proper spin rotation Ry(pi/2), with lambda=1."""
    coord = np.linspace(-3, 3, 301)
    x, y = np.meshgrid(coord, coord)
    r2 = x*x + y*y
    mx, my, mz = 2*x/(1+r2), 2*y/(1+r2), (r2-1)/(r2+1)
    np.testing.assert_allclose(mx*mx + my*my + mz*mz, 1, atol=1.e-14)
    # The rotated field is (mz, my, -mx). At x=+/-1, y=0 its normal
    # component is respectively -1/+1; the background tends to +x.
    fig, axes = plt.subplots(1, 2, figsize=(7.6, 3.35), layout="constrained")
    for ax, (a, b, c), title in zip(
        axes, [(mx, my, mz), (mz, my, -mx)],
        ["(a) Perpendicular background", "(b) In-plane background"]
    ):
        im = ax.pcolormesh(x, y, c, cmap="coolwarm", vmin=-1, vmax=1, shading="auto")
        sl = (slice(10, None, 20), slice(10, None, 20))
        ax.quiver(x[sl], y[sl], a[sl], b[sl], color="black", scale=24,
                  pivot="mid", width=.004)
        ax.set(xlim=(-3, 3), ylim=(-3, 3), aspect="equal",
               xlabel=r"$x/\lambda$", ylabel=r"$y/\lambda$", title=title)
    fig.colorbar(im, ax=axes, label=r"$m_z$", shrink=.8, ticks=[-1, 0, 1])
    fig.savefig(OUT / "spin_rotation.png", dpi=200,
                metadata={"Title": "Analytic spin rotation; not a relaxed magnetic state"})
    plt.close(fig)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output-dir", type=Path, default=OUT)
    args = parser.parse_args()
    OUT = args.output_dir
    OUT.mkdir(parents=True, exist_ok=True)
    gaussian_geometry()
    curvature_profiles()
    pair_coordinates()
    spin_rotation()
    print("Generated three SVG figures, one PNG figure and curvature data; numerical checks passed.")
