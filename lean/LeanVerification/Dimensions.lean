import Mathlib
namespace IC
/- Dimensões representadas pelo par (expoente de joule, expoente de metro).
   metodologia/resultados: A=(1,-1), t=(0,1), I1=(0,1), kappa=(0,-1).
   Não prova convergência da integral que define I1. -/
def dimA : ℤ × ℤ := (1,-1)
def dimt : ℤ × ℤ := (0,1)
def dimI : ℤ × ℤ := (0,1)
def dimκ : ℤ × ℤ := (0,-1)
/-- metodologia.tex, eq:fatorradial e resultados.tex, eq:parprimeira. -/
theorem coefficient_dimensions : dimA+dimt+dimI=(1,1) ∧ dimA+dimt+dimI+dimκ=(1,0) := by decide
/-- resultados.tex, eq:forcas/rigidezes: gradiente J/m, rigidez J/m². -/
theorem gradient_dimensions : ((1,0):ℤ×ℤ)-(0,1)=(1,-1) ∧ ((1,0):ℤ×ℤ)-(0,2)=(1,-2) := by decide
end IC
