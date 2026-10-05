import LeanVerification.Selection
noncomputable section
namespace IC
/-- metodologia.tex, cargas: divergência decomposta é a hipótese física. -/
theorem volume_charge (M divt H n : ℝ) : -M*(divt-2*H*n) = -M*divt+2*M*H*n := by ring
/-- metodologia.tex, teste suave: cancelamento faces-volume até primeira ordem. -/
theorem face_volume_cancellation (M n H t G Gn : ℝ) :
    M*n*((1-H*t)*(G+t/2*Gn)-(1+H*t)*(G-t/2*Gn))+2*M*H*n*t*G = M*t*n*Gn := by ring
/-- Suplemento H.7: primitiva exata do momento polinomial; resto e singularidades excluídos. -/
def momentPrimitive (H K F₀ F₁ F₂ z : ℝ) :=
    F₀*z+(F₁-2*H*F₀)*z^2/2+(F₂/2-2*H*F₁+K*F₀)*z^3/3+
    (-H*F₂+K*F₁)*z^4/4+K*F₂*z^5/10
/-- Suplemento H.7: a função acima é uma primitiva do integrando de Taylor. -/
theorem thickness_primitive (H K F₀ F₁ F₂ z : ℝ) :
    HasDerivAt (momentPrimitive H K F₀ F₁ F₂)
    ((1-2*H*z+K*z^2)*(F₀+F₁*z+F₂*z^2/2)) z := by
  unfold momentPrimitive
  convert (((((hasDerivAt_id z).const_mul F₀).add
    ((((hasDerivAt_id z).pow 2).const_mul (F₁-2*H*F₀)).div_const 2)).add
    ((((hasDerivAt_id z).pow 3).const_mul (F₂/2-2*H*F₁+K*F₀)).div_const 3)).add
    ((((hasDerivAt_id z).pow 4).const_mul (-H*F₂+K*F₁)).div_const 4)).add
    ((((hasDerivAt_id z).pow 5).const_mul (K*F₂)).div_const 10) using 1 ; simp only [id_eq] ; ring
/-- Suplemento H.7: integral pelo valor da primitiva, sem termo t². -/
theorem thickness_polynomial_integral (H K F₀ F₁ F₂ t : ℝ) :
    momentPrimitive H K F₀ F₁ F₂ (t/2)-momentPrimitive H K F₀ F₁ F₂ (-t/2)=
    t*F₀+t^3*(F₀*K/12-F₁*H/6+F₂/24)+F₂*K*t^5/160 := by unfold momentPrimitive; ring
/-- Suplemento H.7: integral de intervalo efetivamente construída, não apenas primitiva. -/
theorem thickness_integral (H K F₀ F₁ F₂ t : ℝ) :
    (∫ z in (-t/2)..(t/2), (1-2*H*z+K*z^2)*(F₀+F₁*z+F₂*z^2/2)) =
    t*F₀+t^3*(F₀*K/12-F₁*H/6+F₂/24)+F₂*K*t^5/160 := by
  rw [intervalIntegral.integral_eq_sub_of_hasDerivAt
    (fun z _ => thickness_primitive H K F₀ F₁ F₂ z)
    ((by fun_prop : Continuous (fun z : ℝ => (1-2*H*z+K*z^2)*(F₀+F₁*z+F₂*z^2/2))).intervalIntegrable _ _)]
  exact thickness_polynomial_integral H K F₀ F₁ F₂ t
/-- metodologia.tex, eq:folhadipolos: fator do termo cruzado de uma energia quadrática. -/
theorem cross_prefactor (μ M t I : ℝ) : μ/(8*Real.pi)*(M*t)^2*(-2*I) = -μ*(M*t)^2/(4*Real.pi)*I := by ring
/-- metodologia.tex: derivada normal exata do kernel, longe da singularidade.
R=|x-x'|>0, N=n' dot (x-x'); deslocar x' por t n' dá distância² R²-2Nt+t². -/
theorem normal_kernel_derivative (R N : ℝ) (hR : 0<R) :
    HasDerivAt (fun t : ℝ => (Real.sqrt (R^2-2*N*t+t^2))⁻¹) (N/R^3) 0 := by
  have hq : HasDerivAt (fun t : ℝ => R^2-2*N*t+t^2) (-2*N) 0 := by
    convert ((hasDerivAt_const 0 (R^2)).sub ((hasDerivAt_id 0).const_mul (2*N))).add
      ((hasDerivAt_id 0).pow 2) using 1 ; simp
  have hqn : R^2-2*N*0+0^2≠0 := by nlinarith
  have hsqrt : Real.sqrt (R^2-2*N*0+0^2)=R := by simp [Real.sqrt_sq (le_of_lt hR)]
  have hd := (hq.sqrt hqn).inv (by rw [hsqrt]; exact ne_of_gt hR)
  convert hd using 1
  rw [hsqrt]
  field_simp
  ring
/-- metodologia.tex, kernel principal; c=cos(theta), s=sin(theta). -/
theorem kernel_decomposition (a b θ : ℝ) :
    a*(Real.cos θ)^2+b*(Real.sin θ)^2 = mean a b+dev a b*Real.cos (2*θ) := by
  rw [Real.cos_two_mul]; unfold mean dev
  linear_combination b*(Real.sin_sq_add_cos_sq θ)
/-- metodologia.tex: convolução radial representada por multiplicadores de Fourier.
A diagonalização da convolução é hipótese de modelagem, não teorema deste arquivo. -/
theorem axial_harmonic_consequence (c₀ c₂ H Δ χ α : ℝ) :
    c₀*H*angularMean 0 χ+c₂*Δ*angularMean 2 (χ-2*α)=c₀*H*Real.cos χ := by
  rw [mean_zero,mean_two]; ring
/-- Suplemento H.7: N(L) e quociente regulado; não coeficiente do par completo. -/
theorem cutoff_ratio (J I rc : ℝ) (hI : I≠0) (hr : rc≠0) :
    (2*J/(I*rc))*rc*I=2*J := by field_simp; ring
/-- Suplemento H.7: fator 1/4 usando lex²=2A/(mu M²). -/
theorem quarter_factor (μ M t rc A N : ℝ) (hA : A≠0) :
    (t*rc/(2*A/(μ*M^2)))*N/4 = μ*M^2*t*rc*N/(8*A) := by field_simp; ring
/-- Suplemento H.7: incremento do modelo logarítmico, não prova da assintótica. -/
theorem logarithmic_increment (F L rc : ℝ) (hL : L≠0) (hr : rc≠0) :
    F/2*Real.log (2*L/rc)-F/2*Real.log (L/rc)=F/2*Real.log 2 := by
  rw [show 2*L/rc=2*(L/rc) by ring,Real.log_mul (by norm_num) (div_ne_zero hL hr)]
  ring
end IC
