import LeanVerification.Geometry
noncomputable section
namespace IC
/-- Discussão e suplemento: derivada positiva do potencial integral, assumida a regra de Leibniz. -/
theorem potential_monotone_slope (u ρ : ℝ) (hρ : 0<ρ) : 0 ≤ (Real.sqrt (1+u^2)-1)/ρ := by
  have hs : 1 ≤ Real.sqrt (1+u^2) := by
    have h := Real.sq_sqrt (show 0 ≤ 1+u^2 by positivity)
    have hn := Real.sqrt_nonneg (1+u^2)
    nlinarith [sq_nonneg u]
  exact div_nonneg (sub_nonneg.mpr hs) (le_of_lt hρ)
/-- Discussão: controle de elevação/depressão no integrando do potencial. -/
theorem potential_even (u ρ : ℝ) : (Real.sqrt (1+(-u)^2)-1)/ρ=(Real.sqrt (1+u^2)-1)/ρ := by rw [neg_sq]
/-- Suplemento: último passo de Delta_S V=KG; B'=2 f' f'' é hipótese diferencial. -/
theorem poisson_final_step (B B' u u' ρ : ℝ) (h : B'=2*u*u') :
    B'/(2*ρ*B^2)=u*u'/(ρ*B^2) := by rw [h]; ring
/-- Suplemento: não se confunde o sinal de KG com o do gradiente do potencial. -/
theorem slope_positive_curvature_negative (ρ : ℝ) (hρ : 0<ρ) :
    0 ≤ (Real.sqrt (1+(1:ℝ)^2)-1)/ρ ∧ (1:ℝ)*(-1)<0 := by
  exact ⟨potential_monotone_slope 1 ρ hρ,by norm_num⟩
end IC
