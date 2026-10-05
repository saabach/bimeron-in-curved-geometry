import LeanVerification.CollectiveEnergy
noncomputable section
namespace IC
/-- resultados.tex: família XY a fundo fixo; duas helicidades variam com -psi. -/
theorem fixed_background_phases (γ ψ : ℝ) :
    HasDerivAt (fun u => γ-u-Real.pi) (-1) ψ ∧ HasDerivAt (fun u => γ-u) (-1) ψ := by
  constructor
  · convert ((hasDerivAt_const ψ γ).sub (hasDerivAt_id ψ)).sub_const Real.pi using 1 ; ring
  · convert (hasDerivAt_const ψ γ).sub (hasDerivAt_id ψ) using 1 ; ring

def central (Bv Ba χv χa η u : ℝ) := -Bv*Real.cos (χv-η*u)-Ba*Real.cos (χa-η*u)
def centralD (Bv Ba χv χa η u : ℝ) := -η*(Bv*Real.sin (χv-η*u)+Ba*Real.sin (χa-η*u))
/-- resultados.tex, eq:orientprimeira: torque conjugado é o negativo desta derivada. -/
theorem central_derivative (Bv Ba χv χa η u : ℝ) :
    HasDerivAt (central Bv Ba χv χa η) (centralD Bv Ba χv χa η u) u := by
  convert ((((hasDerivAt_const u χv).sub ((hasDerivAt_id u).const_mul η)).cos.const_mul (-Bv)).sub
    (((hasDerivAt_const u χa).sub ((hasDerivAt_id u).const_mul η)).cos.const_mul Ba)) using 1 ;
    dsimp [central,centralD] ; ring
/-- resultados.tex, eq:orientprimeira, a1=-eta² Uc. -/
theorem central_second_derivative (Bv Ba χv χa η u : ℝ) :
    HasDerivAt (centralD Bv Ba χv χa η) (-η^2*central Bv Ba χv χa η u) u := by
  convert (((((hasDerivAt_const u χv).sub ((hasDerivAt_id u).const_mul η)).sin.const_mul Bv).add
    (((hasDerivAt_const u χa).sub ((hasDerivAt_id u).const_mul η)).sin.const_mul Ba)).const_mul (-η)) using 1 ;
    dsimp [central,centralD] ; ring
/-- Suplemento H.4: regra da cadeia de segunda ordem para fase geral. -/
theorem phase_chain_second (χ χd : ℝ → ℝ) (B u v a : ℝ)
    (hχ : HasDerivAt χ v u) (hd : HasDerivAt χd a u) (he : χd u=v) :
    HasDerivAt (fun x => B*Real.sin (χ x)*χd x)
    (B*(Real.cos (χ u)*v^2+Real.sin (χ u)*a)) u := by
  convert (hχ.sin.const_mul B).mul hd using 1 ; simp only [he] ; ring
/-- resultados.tex: U_X(psi)=fP(psi)cos psi-fT(psi)sin psi. -/
theorem mixed_X_orientation (fP fT : ℝ → ℝ) (dP dT : ℝ)
    (hp : HasDerivAt fP dP 0) (ht : HasDerivAt fT dT 0) :
    HasDerivAt (fun ψ => fP ψ*Real.cos ψ-fT ψ*Real.sin ψ) (dP-fT 0) 0 := by
  convert (hp.mul (Real.hasDerivAt_cos 0)).sub (ht.mul (Real.hasDerivAt_sin 0)) using 1 ; simp
/-- resultados.tex: U_Y(psi)=fP(psi)sin psi+fT(psi)cos psi. -/
theorem mixed_Y_orientation (fP fT : ℝ → ℝ) (dP dT : ℝ)
    (hp : HasDerivAt fP dP 0) (ht : HasDerivAt fT dT 0) :
    HasDerivAt (fun ψ => fP ψ*Real.sin ψ+fT ψ*Real.cos ψ) (fP 0+dT) 0 := by
  convert (hp.mul (Real.hasDerivAt_sin 0)).add (ht.mul (Real.hasDerivAt_cos 0)) using 1 ; simp
/-- resultados.tex: fases Néel alinhadas, polaridades opostas já incluídas em Ba. -/
theorem neel_orientation (Cv Ca p H D η : ℝ) :
    central (Cv*p*H) (Ca*(-p)*D) (-Real.pi) 0 η 0 = p*(Cv*H+Ca*D) ∧
    centralD (Cv*p*H) (Ca*(-p)*D) (-Real.pi) 0 η 0 = 0 := by
  simp [central,centralD]; ring
/-- resultados.tex: fases Bloch perpendiculares ao fundo. -/
theorem bloch_orientation (Cv Ca p H D η : ℝ) :
    central (Cv*p*H) (Ca*(-p)*D) (-Real.pi/2) (Real.pi/2) η 0=0 ∧
    centralD (Cv*p*H) (Ca*(-p)*D) (-Real.pi/2) (Real.pi/2) η 0=η*p*(Cv*H+Ca*D) := by
  simp [central,centralD,neg_div]; ring
/-- resultados.tex: resposta angular harmônica com referência rígida positiva. -/
theorem angular_response (a lam τ : ℝ) (ha : 0<a) : a*(-lam*τ/a)+lam*τ=0 := by
  field_simp [ne_of_gt ha]; ring
end IC
