import LeanVerification.Geometry
noncomputable section
namespace IC
/-- modelos_algoritmos.tex, eq:carga; densidade cartesiana, sem teorema global de grau. -/
theorem topological_density_reversal (m u v : V3) :
    triple (scale (-1) m) (scale (-1) u) (scale (-1) v) = -triple m u v := by
  simp only [triple,dot,cross,scale]; ring
/-- modelos_algoritmos.tex, campo axial: norma unitária. -/
theorem axial_unit (θ φ : ℝ) :
    (Real.sin θ*Real.cos φ)^2+(Real.sin θ*Real.sin φ)^2+(Real.cos θ)^2=1 := by
  nlinarith [Real.sin_sq_add_cos_sq θ,Real.sin_sq_add_cos_sq φ]
/-- modelos_algoritmos.tex, eq:ansatz: contração das derivadas radiais/angulares. -/
theorem axial_density (θ φ dθ q : ℝ) :
    triple ⟨Real.sin θ*Real.cos φ,Real.sin θ*Real.sin φ,Real.cos θ⟩
      ⟨dθ*Real.cos θ*Real.cos φ,dθ*Real.cos θ*Real.sin φ,-dθ*Real.sin θ⟩
      ⟨-q*Real.sin θ*Real.sin φ,q*Real.sin θ*Real.cos φ,0⟩ = q*dθ*Real.sin θ := by
  simp only [triple,dot,cross]
  calc
    _ = q*dθ*Real.sin θ*((Real.sin θ)^2+(Real.cos θ)^2)*
        ((Real.sin φ)^2+(Real.cos φ)^2) := by ring
    _ = _ := by rw [Real.sin_sq_add_cos_sq,Real.sin_sq_add_cos_sq]; ring
/-- modelos_algoritmos.tex, primitiva da densidade radial. -/
theorem radial_primitive (θ : ℝ → ℝ) (x θ' : ℝ) (h : HasDerivAt θ θ' x) :
    HasDerivAt (fun r => -Real.cos (θ r)) (Real.sin (θ x)*θ') x := by
  convert h.cos.neg using 1 ; ring
/-- modelos_algoritmos.tex, eq:ansatz; integral radial I e seus limites são hipótese. -/
theorem radial_charge (q c₀ cEnd I : ℝ) (h : I=c₀-cEnd) : q/(4*Real.pi)*(2*Real.pi*I)=q/2*(c₀-cEnd) := by
  rw [h]; field_simp; ring
/-- modelos_algoritmos.tex, skyrmion axial. -/
theorem skyrmion_charge (q : ℝ) : q/2*(Real.cos Real.pi-Real.cos 0) = -q := by simp; ring
/-- modelos_algoritmos.tex, meron com contorno equatorial. -/
theorem meron_charge (q p : ℝ) : q/2*(p-0)=p*q/2 := by ring
/-- modelos_algoritmos.tex, par de enrolamentos e polaridades opostos. -/
theorem bimeron_charge (p : ℝ) : p*1/2+(-p)*(-1)/2=p := by ring
/-- modelos_algoritmos.tex, polaridades iguais. -/
theorem equal_polarities (p : ℝ) : p*1/2+p*(-1)/2=0 := by ring

def rotateY (v : V3) : V3 := ⟨v.z,v.y,-v.x⟩
/-- modelos_algoritmos.tex, rotação própria Ry(pi/2). -/
theorem rotation_norm (v : V3) : normSq (rotateY v)=normSq v := by simp only [normSq,dot,rotateY]; ring
/-- modelos_algoritmos.tex, invariância pontual da densidade topológica. -/
theorem rotation_triple (a b c : V3) : triple (rotateY a) (rotateY b) (rotateY c)=triple a b c := by
  simp only [triple,dot,cross,rotateY]; ring
/-- Suplemento, antigo eq:ilustracao: identidade racional BP. -/
theorem bp_unit (x y l : ℝ) (hl : 0<l) :
    (2*l*x/(x^2+y^2+l^2))^2+(2*l*y/(x^2+y^2+l^2))^2+
    ((x^2+y^2-l^2)/(x^2+y^2+l^2))^2=1 := by
  have hd : x^2+y^2+l^2≠0 := ne_of_gt (by positivity)
  field_simp; ring
/-- Suplemento, BP girado, módulo normal no núcleo x=+l. -/
theorem bp_core_positive (l : ℝ) (hl : l≠0) : -(2*l*l/(l^2+0^2+l^2)) = (-1:ℝ) := by field_simp; ring
/-- Suplemento, BP girado, núcleo x=-l. -/
theorem bp_core_negative (l : ℝ) (hl : l≠0) : -(2*l*(-l)/((-l)^2+0^2+l^2)) = (1:ℝ) := by field_simp; ring
/-- modelos_algoritmos.tex, dilatação: Jacobiano e gradiente assumidos. -/
theorem exchange_scaling (l e : ℝ) (hl : l≠0) : l^2*((1/l)^2*e)=e := by field_simp
end IC
