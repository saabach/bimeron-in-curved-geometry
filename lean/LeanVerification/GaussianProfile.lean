import LeanVerification.Geometry
noncomputable section
namespace IC

def profile (h σ ρ : ℝ) := h*Real.exp (-(ρ^2)/(2*σ^2))
def profileD (h σ ρ : ℝ) := (-h/σ^2)*ρ*Real.exp (-(ρ^2)/(2*σ^2))
def profileDD (h σ ρ : ℝ) := h*(ρ^2/σ^4-1/σ^2)*Real.exp (-(ρ^2)/(2*σ^2))
def metricB (h σ ρ : ℝ) := 1+(profileD h σ ρ)^2
def kr (h σ ρ : ℝ) := profileDD h σ ρ/(metricB h σ ρ*Real.sqrt (metricB h σ ρ))
-- Extensão regular da curvatura azimutal; evita dividir por rho no ápice.
def ka (h σ ρ : ℝ) := -h*Real.exp (-(ρ^2)/(2*σ^2))/(σ^2*Real.sqrt (metricB h σ ρ))
/-- metodologia.tex, eq:perfilgaussiano: derivada real completa. -/
theorem profile_derivative (h σ x : ℝ) : HasDerivAt (profile h σ) (profileD h σ x) x := by
  convert ((((hasDerivAt_id x).pow 2).neg.div_const (2*σ^2)).exp.const_mul h) using 1 ;
    dsimp [profile,profileD] ; ring
/-- metodologia.tex, eq:curvgauss: segunda derivada real completa. -/
theorem profile_second_derivative (h σ x : ℝ) : HasDerivAt (profileD h σ) (profileDD h σ x) x := by
  convert (((hasDerivAt_id x).const_mul (-h/σ^2)).mul
    (((hasDerivAt_id x).pow 2).neg.div_const (2*σ^2)).exp) using 1 ;
    dsimp [profileD,profileDD] ; ring
/-- metodologia.tex, métrica regular. -/
theorem metric_positive (h σ ρ : ℝ) : 0 < metricB h σ ρ := by unfold metricB; positivity
/-- metodologia.tex, normal e tangente de um gráfico de revolução. -/
theorem graph_frame (u c s : ℝ) (ht : c^2+s^2=1) :
    dot ⟨-u*c,-u*s,1⟩ ⟨c,s,u⟩=0 ∧ normSq (⟨-u*c,-u*s,1⟩ : V3)=1+u^2 := by
  simp only [dot,normSq]; constructor
  · linear_combination -u*ht
  · linear_combination u^2*ht
/-- metodologia.tex, curvatura azimutal fora do ápice. -/
theorem azimuthal_extension (h σ ρ : ℝ) (hρ : ρ≠0) (hs : σ≠0) :
    profileD h σ ρ/(ρ*Real.sqrt (metricB h σ ρ))=ka h σ ρ := by
  have hn := Real.sqrt_ne_zero'.mpr (metric_positive h σ ρ)
  unfold profileD ka; field_simp [hρ,hs,hn]; ring
/-- metodologia.tex, eq:curvgauss: produto das curvaturas; exponencial ao quadrado. -/
theorem gaussian_curvature_product (h σ ρ : ℝ) (hs : σ≠0) :
    kr h σ ρ*ka h σ ρ=
    h^2*(Real.exp (-(ρ^2)/(2*σ^2)))^2*(1-ρ^2/σ^2)/(σ^4*(metricB h σ ρ)^2) := by
  have hb := metric_positive h σ ρ
  have hn := Real.sqrt_ne_zero'.mpr hb
  have hsq := Real.sq_sqrt (le_of_lt hb)
  unfold kr ka profileDD
  field_simp [hs,hn,ne_of_gt hb]
  ring_nf
  rw [hsq]
  ring
/-- metodologia.tex, exponencial duplicado na expressão de KG. -/
theorem exponential_square (σ ρ : ℝ) :
    (Real.exp (-(ρ^2)/(2*σ^2)))^2=Real.exp (-(ρ^2)/σ^2) := by
  rw [pow_two, ← Real.exp_add]; congr 1; ring
/-- resultados.tex, ápice regular. -/
theorem apex_curvatures (h σ : ℝ) : kr h σ 0 = -h/σ^2 ∧ ka h σ 0 = -h/σ^2 := by
  simp [kr,ka,profileDD,metricB,profileD]; ring
/-- resultados.tex, eq:expansaoapice: forma exata útil para o sinal de Delta. -/
theorem deviation_formula (h σ ρ : ℝ) :
    dev (kr h σ ρ) (ka h σ ρ) =
    h*Real.exp (-(ρ^2)/(2*σ^2))*(ρ^2/σ^4+(profileD h σ ρ)^2/σ^2)/
    (2*metricB h σ ρ*Real.sqrt (metricB h σ ρ)) := by
  have hb := ne_of_gt (metric_positive h σ ρ)
  have hn := Real.sqrt_ne_zero'.mpr (metric_positive h σ ρ)
  unfold dev kr ka profileDD
  by_cases hs : σ=0
  · simp [hs]
  · field_simp [hs,hb,hn]
    unfold metricB; ring
/-- resultados.tex, sinal da parte desviadora para elevação. -/
theorem deviation_nonnegative (h σ ρ : ℝ) (hh : 0≤h) : 0 ≤ dev (kr h σ ρ) (ka h σ ρ) := by
  rw [deviation_formula]
  have := le_of_lt (metric_positive h σ ρ)
  positivity
/-- resultados.tex, sinal de KG, enunciado para o fator positivo explicitado. -/
theorem gaussian_sign (c σ ρ : ℝ) (hc : 0<c) :
    0 < c*(1-ρ^2/σ^2) ↔ ρ^2/σ^2<1 := by constructor <;> intro h <;> nlinarith
/-- resultados.tex: sinal da expressão exata de KG, h e sigma não nulos. -/
theorem gaussian_curvature_sign (h σ ρ : ℝ) (hh : h≠0) (hs : σ≠0) :
    0 < kr h σ ρ*ka h σ ρ ↔ ρ^2/σ^2<1 := by
  rw [gaussian_curvature_product h σ ρ hs]
  have hb := metric_positive h σ ρ
  rw [div_pos_iff_of_pos_right (by positivity),mul_pos_iff_of_pos_left (by positivity)]
  constructor <;> intro h <;> linarith
/-- resultados.tex, anel de curvatura gaussiana nula. -/
theorem gaussian_ring (c σ : ℝ) (hs : σ≠0) : c*(1-σ^2/σ^2)=0 := by field_simp [hs]
/-- Discussão, controle h -> -h. -/
theorem profile_odd (h σ ρ : ℝ) : profile (-h) σ ρ = -profile h σ ρ := by unfold profile; ring
/-- Discussão, controle h -> -h. -/
theorem metric_even (h σ ρ : ℝ) : metricB (-h) σ ρ = metricB h σ ρ := by unfold metricB profileD; ring
/-- Discussão, controle h -> -h, normal sempre para cima. -/
theorem curvatures_odd (h σ ρ : ℝ) : kr (-h) σ ρ = -kr h σ ρ ∧ ka (-h) σ ρ = -ka h σ ρ := by
  simp only [kr,ka,metric_even,profileDD]; constructor <;> ring
/-- resultados.tex, eq:expansaoapice: coeficientes dos jets, não estimativa dos restos. -/
theorem curvature_jet (h σ : ℝ) :
    let β := h/(2*σ^4)*(1+h^2/σ^2)
    let r₂ := 3*h/(2*σ^4)+3*h^3/(2*σ^6)
    let a₂ := h/(2*σ^4)+h^3/(2*σ^6)
    (r₂+a₂)/2=2*β ∧ (r₂-a₂)/2=β := by dsimp; constructor <;> ring
/-- resultados.tex, relação das derivadas dos polinômios quadráticos locais. -/
theorem local_derivative_relation (β ρ : ℝ) : 4*β*ρ=2*(2*β*ρ) := by ring
/-- Suplemento E.3: projeção normal depende quadraticamente da inclinação. -/
theorem projected_axis_parity (u c : ℝ) : 1-((-u)*c)^2/(1+(-u)^2)=1-(u*c)^2/(1+u^2) := by ring
/-- Suplemento E.3: razão de escalas perto do ápice, denominadores não nulos. -/
theorem scale_ratio (A t d h rc σ : ℝ)
    (hA : A≠0) (ht : t≠0) (hd : d≠0) (hh : h≠0) (hr : rc≠0) (hs : σ≠0) :
    (A*t*d*h^2/σ^4)/(A*t*rc*h*d/σ^4)=h/rc := by field_simp; ring
/-- metodologia.tex, eq:curvgauss: equivalência entre B^(3/2) e B sqrt B. -/
theorem curvature_denominator (B : ℝ) (hB : 0<B) :
    B ^ (3/(2:ℝ))=B*Real.sqrt B := by
  rw [show (3/(2:ℝ))=1+1/2 by norm_num,Real.rpow_add hB,Real.rpow_one,Real.sqrt_eq_rpow]
end IC
