import LeanVerification.Geometry
noncomputable section
namespace IC
/-- Resultados: coordenadas P,T obtidas por rotação própria. -/
theorem rotated_radius (X Y ψ : ℝ) :
    (X*Real.cos ψ+Y*Real.sin ψ)^2+(-X*Real.sin ψ+Y*Real.cos ψ)^2=X^2+Y^2 := by
  nlinarith [Real.sin_sq_add_cos_sq ψ,
    congrArg (fun z : ℝ => X^2*z) (Real.sin_sq_add_cos_sq ψ),
    congrArg (fun z : ℝ => Y^2*z) (Real.sin_sq_add_cos_sq ψ)]
/-- Resultados: posições dirigidas do vórtice ao antivórtice. -/
theorem pair_separation (R s : ℝ) : (R+s)-(R-s)=2*s := by ring
/-- resultados.tex, eq:parprimeira, com I_i=p_i |I_i| já separado. -/
def pairEnergy (Cv pv cv H Ca pa Δ phase : ℝ) := -Cv*pv*cv*H-Ca*pa*Δ*Real.cos phase
/-- resultados.tex, eq:parprimeira, hipótese física: aditividade dos dois núcleos. -/
theorem pair_energy_from_cores (Cv pv cv H Ca pa Δ χ ψ Θ : ℝ) :
    -Cv*pv*cv*H-Ca*pa*Δ*Real.cos (χ+2*ψ-2*Θ)=pairEnergy Cv pv cv H Ca pa Δ (χ+2*(ψ-Θ)) := by
  unfold pairEnergy
  rw [show χ+2*ψ-2*Θ=χ+2*(ψ-Θ) by ring]

/- Jets de ordem 2: pp,pt,tt são coeficientes monomiais, não entradas da Hessiana.
   Modelam Taylor truncado; a existência e os restos do desenvolvimento são externos. -/
structure Jet where
  c : ℝ
  p : ℝ
  t : ℝ
  pp : ℝ
  pt : ℝ
  tt : ℝ
  deriving Inhabited

def Jet.mul (a b : Jet) : Jet :=
  ⟨a.c*b.c,a.c*b.p+a.p*b.c,a.c*b.t+a.t*b.c,
   a.c*b.pp+a.p*b.p+a.pp*b.c,a.c*b.pt+a.p*b.t+a.t*b.p+a.pt*b.c,
   a.c*b.tt+a.t*b.t+a.tt*b.c⟩
def Jet.add (a b : Jet) : Jet := ⟨a.c+b.c,a.p+b.p,a.t+b.t,a.pp+b.pp,a.pt+b.pt,a.tt+b.tt⟩
def Jet.scale (k : ℝ) (a : Jet) : Jet := ⟨k*a.c,k*a.p,k*a.t,k*a.pp,k*a.pt,k*a.tt⟩
def Jet.eval (a : Jet) (P T : ℝ) := a.c+a.p*P+a.t*T+a.pp*P^2+a.pt*P*T+a.tt*T^2
/-- Suplemento H.3: raio sqrt((s+eP)^2+T²), coeficientes até grau 2. -/
theorem radial_jet_constraints (s e : ℝ) (hs : s≠0) (he : e^2=1) :
    let r : Jet := ⟨s,e,0,0,0,1/(2*s)⟩
    (r.mul r).c=s^2 ∧ (r.mul r).p=2*s*e ∧ (r.mul r).pp=1 ∧ (r.mul r).tt=1 := by
  dsimp [Jet.mul]; constructor; ring
  constructor; ring
  constructor; nlinarith
  field_simp; ring
/-- Suplemento H.3: jet de T/(s+P), origem de Theta=T/s-PT/s². -/
theorem angular_jet (s : ℝ) (hs : s≠0) :
    let x : Jet := ⟨s,1,0,0,0,0⟩
    let a : Jet := ⟨0,0,1/s,0,-1/s^2,0⟩
    (x.mul a).t=1 ∧ (x.mul a).pt=0 := by
  dsimp [Jet.mul]; constructor <;> field_simp ; ring

def pairJet (v b H H' H'' D D' D'' c z s : ℝ) : Jet :=
  (Jet.scale (-v) ⟨H,-H',0,H''/2,0,H'/(2*s)⟩).add
  (Jet.scale (-b) ((⟨D,D',0,D''/2,0,D'/(2*s)⟩ : Jet).mul
    ⟨c,0,2*z/s,0,-2*z/s^2,-2*c/s^2⟩))
/-- resultados.tex, eq:forcas e eq:rigidezes: produto completo dos jets até grau 2. -/
theorem pair_jet_coefficients (v b H H' H'' D D' D'' c z s P T : ℝ) :
    (pairJet v b H H' H'' D D' D'' c z s).eval P T =
    -v*H-b*c*D+(v*H'-b*c*D')*P+(-2*b*z*D/s)*T+
    (-v*H''-b*c*D'')/2*P^2+
    (-2*b*z*(D'/s-D/s^2))*P*T+
    (-v*H'/s-b*c*D'/s+4*b*c*D/s^2)/2*T^2 := by
  dsimp [pairJet,Jet.scale,Jet.mul,Jet.add,Jet.eval]; ring

def quadraticEnergy (U fP fT kP kPT kT P T : ℝ) :=
  U+fP*P+fT*T+kP/2*P^2+kPT*P*T+kT/2*T^2
/-- resultados.tex: derivada parcial real, gradiente longitudinal. -/
theorem energy_gradient_P (U fP fT kP kPT kT P T : ℝ) :
    HasDerivAt (fun x => quadraticEnergy U fP fT kP kPT kT x T) (fP+kP*P+kPT*T) P := by
  unfold quadraticEnergy
  convert (((((hasDerivAt_const P U).add ((hasDerivAt_id P).const_mul fP)).add
    (hasDerivAt_const P (fT*T))).add (((hasDerivAt_id P).pow 2).const_mul (kP/2))).add
    (((hasDerivAt_id P).const_mul kPT).mul_const T)).add (hasDerivAt_const P (kT/2*T^2)) using 1 ; dsimp only [id_eq] ; ring
/-- resultados.tex: derivada parcial real, gradiente transversal. -/
theorem energy_gradient_T (U fP fT kP kPT kT P T : ℝ) :
    HasDerivAt (fun x => quadraticEnergy U fP fT kP kPT kT P x) (fT+kPT*P+kT*T) T := by
  unfold quadraticEnergy
  convert (((((hasDerivAt_const T U).add (hasDerivAt_const T (fP*P))).add
    ((hasDerivAt_id T).const_mul fT)).add (hasDerivAt_const T (kP/2*P^2))).add
    ((hasDerivAt_id T).const_mul (kPT*P))).add (((hasDerivAt_id T).pow 2).const_mul (kT/2)) using 1 ; dsimp only [id_eq] ; ring
/-- resultados.tex: kPT é derivada mista, não componente do gradiente. -/
theorem mixed_derivative (fP kP kPT P T : ℝ) :
    HasDerivAt (fun t => fP+kP*P+kPT*t) kPT T := by
  convert (hasDerivAt_const T (fP+kP*P)).add ((hasDerivAt_id T).const_mul kPT) using 1 ; dsimp only [id_eq] ; ring
/-- resultados.tex, eq:expansaoapice aplicada aos coeficientes do par. -/
theorem apex_coefficients (β s v b c z : ℝ) (hs : s≠0) :
    v*(4*β*s)-b*c*(2*β*s)=2*β*s*(2*v-b*c) ∧
    -2*b*z*(β*s^2)/s = -2*β*s*b*z ∧
    -2*b*z*((2*β*s)/s-(β*s^2)/s^2) = -2*β*b*z := by
  constructor; ring
  constructor <;> field_simp <;> ring
/-- resultados.tex: núcleo antivórtice no jet Delta=beta rho², sem singularidade angular. -/
theorem apex_deviator_polynomial (b β c z s P T : ℝ) :
    -b*β*(c*((s+P)^2-T^2)+2*z*(s+P)*T) =
    -b*β*c*s^2-2*b*β*c*s*P-2*b*β*z*s*T-b*β*c*P^2-2*b*β*z*P*T+b*β*c*T^2 := by ring
/-- Suplemento H.3: cancelamento Néel requer relação dos pesos, não apenas polaridades. -/
theorem neel_cancellation (β s ζ Cv Ca : ℝ) (hc : Ca=2*Cv) : 2*β*s*ζ*(2*Cv-Ca)=0 := by rw [hc]; ring
/-- resultados.tex: termo par com pesos iguais, gradiente central cancela. -/
theorem even_core_pair (Λ J G' G'' s : ℝ) :
    Λ*(J-J)*G'=0 ∧ -Λ*(J+J)*G'' = -2*Λ*J*G'' ∧
    -Λ*(J+J)*G'/s = -2*Λ*J*G'/s := by constructor; ring; constructor <;> ring
end IC
