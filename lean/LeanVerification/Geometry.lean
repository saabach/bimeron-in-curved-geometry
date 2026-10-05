import Mathlib

/- Relatório: metodologia.tex, Eq. eq:curvaturas e definições da base móvel.
   As identidades locais abaixo não constroem uma imersão global. -/
noncomputable section
namespace IC
@[ext] structure V3 where
  x : ℝ
  y : ℝ
  z : ℝ

def dot (a b : V3) : ℝ := a.x*b.x+a.y*b.y+a.z*b.z
def normSq (a : V3) := dot a a
def scale (r : ℝ) (a : V3) : V3 := ⟨r*a.x,r*a.y,r*a.z⟩
def sub (a b : V3) : V3 := ⟨a.x-b.x,a.y-b.y,a.z-b.z⟩
def cross (a b : V3) : V3 :=
  ⟨a.y*b.z-a.z*b.y,a.z*b.x-a.x*b.z,a.x*b.y-a.y*b.x⟩
def triple (a b c : V3) := dot a (cross b c)
def mean (k₁ k₂ : ℝ) := (k₁+k₂)/2
def dev (k₁ k₂ : ℝ) := (k₁-k₂)/2

/-- metodologia.tex, geometria: determinante de Gram. -/
theorem gram_identity (a b : V3) :
    normSq (cross a b) = normSq a * normSq b - (dot a b)^2 := by
  simp only [normSq,dot,cross]; ring
/-- metodologia.tex, normal unitária; regularidade é a hipótese g>0. -/
theorem normalized_normal (a b : V3) (hg : 0 < normSq (cross a b)) :
    normSq (scale (1/Real.sqrt (normSq (cross a b))) (cross a b)) = 1 := by
  have hs := Real.sq_sqrt (le_of_lt hg)
  have hn := Real.sqrt_ne_zero'.mpr hg
  have scale_sq : ∀ (r : ℝ) (v : V3), normSq (scale r v) = r^2*normSq v := by
    intro r v; simp only [normSq,scale,dot]; ring
  rw [scale_sq, ← hs]; field_simp
/-- metodologia.tex, eq:curvaturas. -/
theorem recover_principal (a b : ℝ) :
    mean a b + dev a b = a ∧ mean a b - dev a b = b := by
  dsimp [mean,dev]; constructor <;> ring
/-- metodologia.tex, eq:curvaturas, identidade reutilizada na interpretação. -/
theorem mean_sq_sub_dev_sq (a b : ℝ) : (mean a b)^2-(dev a b)^2=a*b := by
  dsimp [mean,dev]; ring
/-- metodologia.tex, inversão da normal, rótulos principais mantidos. -/
theorem normal_reversal (a b : ℝ) :
    mean (-a) (-b) = -mean a b ∧ dev (-a) (-b) = -dev a b ∧ (-a)*(-b)=a*b := by
  dsimp [mean,dev]; constructor; ring; constructor <;> ring
/-- metodologia.tex, comparação de módulos via seus quadrados. -/
theorem magnitude_criterion (a b : ℝ) :
    (dev a b)^2 ≤ (mean a b)^2 ↔ 0 ≤ a*b := by
  have := mean_sq_sub_dev_sq a b; constructor <;> intro h <;> linarith
/-- metodologia.tex, Jacobiano da superfície paralela. -/
theorem offset_area (a b z : ℝ) :
    (1-a*z)*(1-b*z)=1-2*mean a b*z+a*b*z^2 := by dsimp [mean]; ring
/-- metodologia.tex, área da face superior z=t/2. -/
theorem upper_face (a b t : ℝ) :
    (1-a*(t/2))*(1-b*(t/2))=1-mean a b*t+a*b*t^2/4 := by dsimp [mean]; ring
/-- metodologia.tex, área da face inferior z=-t/2. -/
theorem lower_face (a b t : ℝ) :
    (1-a*(-t/2))*(1-b*(-t/2))=1+mean a b*t+a*b*t^2/4 := by dsimp [mean]; ring
/-- metodologia.tex, derivada da ortogonalidade fornecida como hipótese. -/
theorem connection_skew (ωij ωji : ℝ) (h : ωji+ωij=0) : ωij = -ωji := by linarith
/-- metodologia.tex, derivada de um vetor em base móvel: regra do produto. -/
theorem moving_product (m e : ℝ → ℝ) (m' e' x : ℝ)
    (hm : HasDerivAt m m' x) (he : HasDerivAt e e' x) :
    HasDerivAt (fun u => m u*e u) (m'*e x+m x*e') x := hm.mul he
end IC
