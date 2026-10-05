import LeanVerification.Geometry
noncomputable section
namespace IC
open MeasureTheory

def angularMean (k χ : ℝ) := (2*Real.pi)⁻¹ * ∫ φ in (0:ℝ)..2*Real.pi, Real.cos (k*φ+χ)
/-- metodologia.tex, eq:selecao: linearidade da média angular para funções integráveis. -/
theorem mean_linearity (f g : ℝ → ℝ) (a b : ℝ)
    (hf : IntervalIntegrable f volume 0 (2*Real.pi))
    (hg : IntervalIntegrable g volume 0 (2*Real.pi)) :
    (2*Real.pi)⁻¹*(∫ φ in (0:ℝ)..2*Real.pi, a*f φ+b*g φ) =
    a*((2*Real.pi)⁻¹*∫ φ in (0:ℝ)..2*Real.pi, f φ)+
    b*((2*Real.pi)⁻¹*∫ φ in (0:ℝ)..2*Real.pi, g φ) := by
  rw [intervalIntegral.integral_add (hf.const_mul a) (hg.const_mul b),
    intervalIntegral.integral_const_mul,intervalIntegral.integral_const_mul]
  ring
/-- metodologia.tex, eq:selecao: harmônico constante. -/
theorem mean_zero (χ : ℝ) : angularMean 0 χ=Real.cos χ := by
  simp [angularMean,intervalIntegral.integral_const]; field_simp; ring
/-- metodologia.tex, eq:selecao: integral real do harmônico +2. -/
theorem mean_two (χ : ℝ) : angularMean 2 χ=0 := by
  unfold angularMean
  rw [intervalIntegral.integral_comp_mul_add Real.cos (by norm_num : (2:ℝ)≠0), integral_cos]
  have hp : (2:ℝ)*(2*Real.pi)+χ=χ+2*(2*Real.pi) := by ring
  rw [hp]
  norm_num [Real.sin_add,Real.sin_two_mul,Real.cos_two_mul]
/-- metodologia.tex, eq:selecao: integral real do harmônico -2. -/
theorem mean_neg_two (χ : ℝ) : angularMean (-2) χ=0 := by
  unfold angularMean
  rw [intervalIntegral.integral_comp_mul_add Real.cos (by norm_num : (-2:ℝ)≠0), integral_cos]
  have hp : (-2:ℝ)*(2*Real.pi)+χ=χ-(2*(2*Real.pi)) := by ring
  rw [hp]
  norm_num [Real.sin_sub,Real.sin_two_mul,Real.cos_two_mul]
/-- Suplemento H.1: contração axial em base polar, S²+C²=1.
A transformação do tensor para os harmônicos é tratada separadamente. -/
theorem axial_contraction (S C θ' q r a b : ℝ) (h : S^2+C^2=1) :
    a*((S)*(-S*θ')-C*(C*θ'))-b*C*(q*S/r) = -a*θ'-b*q*S*C/r := by
  linear_combination -a*θ'*h
/-- Suplemento H.1: contração do tensor principal e harmônicos soma/diferença.
Aplicar u=q*phi+chi-alpha e phi=phi-alpha para os eixos girados. -/
theorem principal_harmonics (k₁ k₂ a b u φ : ℝ) :
    k₁*(a*Real.cos φ*Real.cos u+b*Real.sin φ*Real.sin u)+
    k₂*(a*Real.sin φ*Real.sin u+b*Real.cos φ*Real.cos u)=
    mean k₁ k₂*(a+b)*Real.cos (u-φ)+dev k₁ k₂*(a-b)*Real.cos (u+φ) := by
  simp only [Real.cos_sub,Real.cos_add,mean,dev]; ring
/-- Suplemento H.1: frequências q-1 e q+1 em eixos principais girados. -/
theorem harmonic_arguments (q φ χ α : ℝ) :
    (q*φ+χ-α)-(φ-α)=(q-1)*φ+χ ∧
    (q*φ+χ-α)+(φ-α)=(q+1)*φ+χ-2*α := by constructor <;> ring
/-- metodologia.tex, eq:selecao: média da expressão harmônica para q=+1. -/
theorem selection_positive (A H Δ θ' SC r χ α : ℝ) :
    -2*A*(H*(θ'+SC/r)*angularMean (1-1) χ+
      Δ*(θ'-SC/r)*angularMean (1+1) (χ-2*α)) =
    -2*A*(θ'+SC/r)*H*Real.cos χ := by
  norm_num only [sub_self,show (1:ℝ)+1=2 by norm_num]
  rw [mean_zero,mean_two]; ring
/-- metodologia.tex, eq:selecao: média da expressão harmônica para q=-1. -/
theorem selection_negative (A H Δ θ' SC r χ α : ℝ) :
    -2*A*(H*(θ'-SC/r)*angularMean (-1-1) χ+
      Δ*(θ'+SC/r)*angularMean (-1+1) (χ-2*α)) =
    -2*A*(θ'+SC/r)*Δ*Real.cos (χ-2*α) := by
  norm_num only [show (-1:ℝ)-1 = -2 by norm_num,show (-1:ℝ)+1=0 by norm_num]
  rw [mean_zero,mean_neg_two]; ring
/-- metodologia.tex, convenção passiva q=-1. -/
theorem passive_invariance (χ α δ : ℝ) : χ+(-1-1)*δ-2*(α-δ)=χ-2*α := by ring
/-- resultados.tex, eq:parprimeira: conversão do ângulo absoluto. -/
theorem pair_angle (χ ψ Θ : ℝ) : χ+2*ψ-2*Θ=χ+2*(ψ-Θ) := by ring
/-- metodologia.tex, eq:fatorradial: inversão do integrando; convergência não afirmada. -/
theorem radial_integrand_reversal (r θ θ' : ℝ) :
    r*(-θ')+Real.sin (Real.pi-θ)*Real.cos (Real.pi-θ) =
    -(r*θ'+Real.sin θ*Real.cos θ) := by simp [Real.sin_sub,Real.cos_sub]; ring
/-- metodologia.tex, eq:fatorradial: hipótese de sinal explicita I=p|I|. -/
theorem core_energy_polarity (A t I p G : ℝ) (hsign : I=p*|I|) :
    -2*A*t*I*G=-(2*A*t*|I|)*p*G := by nth_rw 1 [hsign]; ring
/-- metodologia.tex, vórtice Bloch. -/
theorem bloch_positive_zero (A F H : ℝ) : -2*A*F*H*Real.cos (Real.pi/2)=0 := by simp
/-- metodologia.tex, troca dos rótulos principais preserva a energia. -/
theorem principal_swap (Δ χ α : ℝ) :
    (-Δ)*Real.cos (χ-2*(α+Real.pi/2))=Δ*Real.cos (χ-2*α) := by
  rw [show χ-2*(α+Real.pi/2)=(χ-2*α)-Real.pi by ring]
  simp [Real.cos_sub]; ring
/-- metodologia.tex, sin(2 theta)/(2r)=sin(theta)cos(theta)/r. -/
theorem radial_double_angle (θ r : ℝ) : Real.sin (2*θ)/(2*r)=Real.sin θ*Real.cos θ/r := by
  rw [Real.sin_two_mul]; ring
end IC
