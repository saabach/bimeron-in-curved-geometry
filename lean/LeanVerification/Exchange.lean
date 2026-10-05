import LeanVerification.Geometry
noncomputable section
namespace IC
/-- metodologia.tex, eq:trocasuperficie: redução uniforme na normal, integral J assumida. -/
theorem thin_shell_energy (A t J : ℝ) : A*(t*J)=A*t*J := by ring
/-- metodologia.tex, eq:expansao: contração com métrica simétrica 2x2, uma componente. -/
theorem covariant_square (g11 g12 g22 a b u v : ℝ) :
    g11*(a+u)^2+2*g12*(a+u)*(b+v)+g22*(b+v)^2 =
    (g11*a^2+2*g12*a*b+g22*b^2)+
    2*(g11*a*u+g12*(a*v+b*u)+g22*b*v)+(g11*u^2+2*g12*u*v+g22*v^2) := by ring
/-- metodologia.tex, troca: base móvel, h12 permitido, termos de ordem 0,1,2. -/
theorem moving_frame_exchange (a b c u v n ux uy vx vy nx ny : ℝ) :
    (ux-a*n)^2+(vx-c*n)^2+(nx+a*u+c*v)^2+
    (uy-c*n)^2+(vy-b*n)^2+(ny+c*u+b*v)^2 =
    ux^2+vx^2+nx^2+uy^2+vy^2+ny^2+
    2*(a*(u*nx-n*ux)+c*(v*nx+u*ny-n*(vx+uy))+b*(v*ny-n*vy))+
    (a*u+c*v)^2+(c*u+b*v)^2+(a^2+2*c^2+b^2)*n^2 := by ring
/-- metodologia.tex, anisotropia extrínseca tangencial. -/
theorem tangential_energy (A k₁ k₂ ζ : ℝ) :
    A*((k₁*Real.cos ζ)^2+(k₂*Real.sin ζ)^2)=A*(k₁^2*(Real.cos ζ)^2+k₂^2*(Real.sin ζ)^2) := by ring
/-- metodologia.tex, diferença das anisotropias principais. -/
theorem anisotropy_difference (a b : ℝ) : a^2-b^2=2*mean a b*(a-b) := by dsimp [mean]; ring
/-- metodologia.tex, DMI interfacial 3D versus intrínseca. -/
theorem interface_extrinsic (D n divt H mtgrad : ℝ) :
    D*(n*(divt-2*H*n)-mtgrad)-D*(n*divt-mtgrad) = -2*D*H*n^2 := by ring
/-- metodologia.tex, DMI volumétrica: contração do curl extrínseco geral. -/
theorem bulk_extrinsic (a b c u v : ℝ) :
    u*(c*u+b*v)-v*(a*u+c*v)=c*(u^2-v^2)+(b-a)*u*v := by ring
/-- metodologia.tex, DMI volumétrica em base principal. -/
theorem bulk_principal (a b u v : ℝ) : (b-a)*u*v = -2*dev a b*u*v := by dsimp [dev]; ring
end IC
