import LeanVerification.Geometry
noncomputable section
namespace IC

def PosDef2 (a b c : ℝ) := ∀ x y : ℝ, x≠0 ∨ y≠0 → 0<a*x^2+2*b*x*y+c*y^2
/-- resultados.tex, bloco Hessiano: completar quadrado. -/
theorem hessian_completion (a b c x y : ℝ) (ha : a≠0) :
    a*x^2+2*b*x*y+c*y^2=a*(x+b*y/a)^2+(a*c-b^2)/a*y^2 := by field_simp; ring
/-- resultados.tex: critério necessário e suficiente do bloco Hessiano 2x2. -/
theorem positive_definite_iff (a b c : ℝ) : PosDef2 a b c ↔ 0<a ∧ 0<a*c-b^2 := by
  constructor
  · intro h
    have ha : 0<a := by simpa using h 1 0 (Or.inl one_ne_zero)
    have hv := h (-b/a) 1 (Or.inr one_ne_zero)
    rw [hessian_completion a b c (-b/a) 1 (ne_of_gt ha)] at hv
    have hz : -b/a+b*1/a=0 := by ring
    rw [hz] at hv
    have hh : 0<(a*c-b^2)/a := by simpa using hv
    exact ⟨ha, (div_pos_iff_of_pos_right ha).mp hh⟩
  · rintro ⟨ha,hd⟩ x y hn
    rw [hessian_completion a b c x y (ne_of_gt ha)]
    have hp : 0<(a*c-b^2)/a := div_pos hd ha
    by_cases hy : y=0
    · subst y; simp only [mul_zero,zero_div,add_zero,zero_pow (by decide : 2≠0)]
      have hx : x≠0 := hn.resolve_right (by simp)
      exact mul_pos ha (sq_pos_of_ne_zero hx)
    · have hs := mul_pos hp (sq_pos_of_ne_zero hy)
      nlinarith [mul_nonneg (le_of_lt ha) (sq_nonneg (x+b*y/a))]
/-- Discussão, eq:schur: um deslocamento e dois modos internos acoplados.
C z=b define z=C^{-1}b sem presumir o resultado; vale para qualquer direção posicional. -/
theorem schur_completion (k a c d b₁ b₂ z₁ z₂ x y₁ y₂ : ℝ)
    (h₁ : a*z₁+c*z₂=b₁) (h₂ : c*z₁+d*z₂=b₂) :
    k*x^2+2*x*(b₁*y₁+b₂*y₂)+a*y₁^2+2*c*y₁*y₂+d*y₂^2 =
    (k-b₁*z₁-b₂*z₂)*x^2+a*(y₁+z₁*x)^2+
    2*c*(y₁+z₁*x)*(y₂+z₂*x)+d*(y₂+z₂*x)^2 := by
  rw [←h₁,←h₂]; ring
/-- Discussão, eq:schur: correção semidefinida positiva no mesmo estado. -/
theorem relaxed_le_frozen (k a c d b₁ b₂ z₁ z₂ : ℝ)
    (hC : PosDef2 a c d) (h₁ : a*z₁+c*z₂=b₁) (h₂ : c*z₁+d*z₂=b₂) :
    k-b₁*z₁-b₂*z₂ ≤ k := by
  have hz : 0≤a*z₁^2+2*c*z₁*z₂+d*z₂^2 := by
    by_cases h : z₁=0 ∧ z₂=0
    · simp [h.1,h.2]
    · exact le_of_lt (hC z₁ z₂ (by tauto))
  rw [←h₁,←h₂]; nlinarith [hz]
/-- Discussão, eq:schur: inverse explícita do bloco interno quando o determinante não zera. -/
theorem internal_inverse (a c d b₁ b₂ : ℝ) (h : a*d-c^2≠0) :
    a*((d*b₁-c*b₂)/(a*d-c^2))+c*((a*b₂-c*b₁)/(a*d-c^2))=b₁ ∧
    c*((d*b₁-c*b₂)/(a*d-c^2))+d*((a*b₂-c*b₁)/(a*d-c^2))=b₂ := by
  constructor <;> field_simp <;> ring
/-- Discussão: eliminação harmônica rígida em uma direção. -/
theorem harmonic_elimination (U k lam g : ℝ) (hk : k≠0) :
    U+k/2*(-lam*g/k)^2+lam*g*(-lam*g/k)=U-lam^2*g^2/(2*k) := by field_simp; ring
/-- Suplemento J: ordem quadrática surge do deslocamento linear. -/
theorem perturbative_order (lam g k : ℝ) : lam*g*(-lam*g/k) = -lam^2*g^2/k := by ring
/-- Suplemento J: os dois termos da segunda derivada de -lambda² g²/(2k). -/
theorem eliminated_second_derivative (g gd : ℝ → ℝ) (x v a lam k : ℝ)
    (hg : HasDerivAt g v x) (hd : HasDerivAt gd a x) (hv : gd x=v) :
    HasDerivAt (fun u => -lam^2/k*g u*gd u) (-lam^2/k*(v^2+g x*a)) x := by
  convert (hg.const_mul (-lam^2/k)).mul hd using 1 ; simp only [hv] ; ring
/-- Suplemento J: determinante confinado especial, incluindo o termo a1*kT.
Os termos físicos de ordem superior não são controlados por esta identidade. -/
theorem confined_determinant (a₀ ky kx a₁ kT f lam : ℝ) :
    (a₀+lam*a₁+lam^2*f^2/kx)*(ky+lam*kT)-(lam*f)^2 =
    a₀*ky+lam*(a₀*kT+a₁*ky)+lam^2*(a₁*kT+f^2*(ky/kx-1))+
    lam^3*f^2*kT/kx := by ring
end IC
