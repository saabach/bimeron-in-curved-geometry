import LeanVerification.Geometry
noncomputable section
namespace IC
/-- revisaobib.tex, Heisenberg: custo de desalinhamento de spins unitários. -/
theorem heisenberg_difference (a b : V3) (J : ℝ)
    (ha : normSq a=1) (hb : normSq b=1) :
    -J*dot a b - (-J) = J/2*normSq (sub a b) := by
  simp only [normSq,dot] at ha hb
  simp only [normSq,sub,dot]; linear_combination -(J/2)*ha - (J/2)*hb
/-- revisaobib.tex, M=Ms m. -/
theorem magnetization_norm (m : V3) (Ms : ℝ) (hm : normSq m=1) :
    normSq (scale Ms m)=Ms^2 := by
  simp only [normSq,dot] at hm
  simp only [normSq,dot,scale]; nlinarith [sq_nonneg Ms]
/-- revisaobib.tex, eq:energia: definição reduzida; integrais não construídas. -/
def energy (ex an dm zee ms : ℝ) := ex+an+dm+zee+ms
/-- revisaobib.tex, eq:energia, aditividade das contribuições reduzidas. -/
theorem energy_additivity (e a d z m δ : ℝ) :
    energy (e+δ) a d z m = energy e a d z m+δ := by unfold energy; ring
/-- revisaobib.tex, anisotropia: projeção em eixo unitário limitada por 1. -/
theorem easy_axis_bound (K u : ℝ) (hK : 0≤K) (hu : u^2≤1) : -K ≤ -K*u^2 := by nlinarith
/-- revisaobib.tex, anisotropia de plano fácil. -/
theorem easy_plane_nonnegative (K u : ℝ) (hK : 0≤K) : 0≤K*u^2 := mul_nonneg hK (sq_nonneg u)
/-- revisaobib.tex, eq:energia: Zeeman é ímpar com campo mantido. -/
theorem zeeman_reversal (c H m : ℝ) : -c*H*(-m) = -(-c*H*m) := by ring
/-- revisaobib.tex, eq:dipolar: a integração por partes é hipótese explícita. -/
theorem dipolar_energy_identity (μ I MH : ℝ) (h : MH = -I) :
    -(μ/2)*MH=μ/2*I := by rw [h]; ring
/-- revisaobib.tex, eq:dmivol, operadores lineares também revertidos. -/
theorem bulk_dmi_reversal (m curlm : V3) (D : ℝ) :
    D*dot (scale (-1) m) (scale (-1) curlm)=D*dot m curlm := by
  simp only [dot,scale]; ring
/-- revisaobib.tex, eq:dmiint, bilinearidade da densidade. -/
theorem interface_dmi_reversal (D n divt tx ty nx ny : ℝ) :
    D*((-n)*(-divt)-((-tx)*(-nx)+(-ty)*(-ny)))=D*(n*divt-(tx*nx+ty*ny)) := by ring
/-- revisaobib.tex, eq:comprimentos, quadrado do comprimento de troca. -/
theorem exchange_length_balance (A μ M : ℝ) (hA : 0≤A) (hμ : 0<μ) (hM : M≠0) :
    (Real.sqrt (2*A/(μ*M^2)))^2*(μ*M^2)=2*A := by
  rw [Real.sq_sqrt (div_nonneg (by positivity) (by positivity))]
  field_simp
/-- revisaobib.tex, eq:comprimentos, balanço troca/anisotropia. -/
theorem anisotropy_length_balance (A K : ℝ) (hA : 0≤A) (hK : K≠0) :
    (Real.sqrt (A/|K|))^2*|K|=A := by
  rw [Real.sq_sqrt (div_nonneg hA (abs_nonneg _))]; field_simp
/-- revisaobib.tex, eq:comprimentos, balanço troca/DMI. -/
theorem dmi_length_balance (A D : ℝ) (hD : D≠0) : A / |D| * |D|=A := by field_simp
/-- revisaobib.tex, equilíbrio: campo paralelo implica torque nulo. -/
theorem parallel_field_zero_torque (m : V3) (c : ℝ) : cross m (scale c m)=⟨0,0,0⟩ := by
  ext <;> simp [cross,scale] <;> ring
end IC
