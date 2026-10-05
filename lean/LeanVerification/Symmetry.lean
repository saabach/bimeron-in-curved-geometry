import LeanVerification.Topology
import LeanVerification.CollectiveEnergy
import LeanVerification.Micromagnetics
noncomputable section
namespace IC
/-- Discussão: altura invertida com os mesmos pesos e fases locais. -/
theorem pair_height_reversal (Cv pv cv H Ca pa Δ phase : ℝ) :
    pairEnergy Cv pv cv (-H) Ca pa (-Δ) phase = -pairEnergy Cv pv cv H Ca pa Δ phase := by
  unfold pairEnergy; ring
/-- Discussão: gradientes e rigidezes do modelo linear são ímpares na curvatura. -/
theorem coefficient_reversal (v b H' D' c : ℝ) :
    v*(-H')-b*c*(-D') = -(v*H'-b*c*D') := by ring
/-- Discussão, eq:reversao: p e chi são ambos revertidos. -/
theorem polarity_phase_reversal (p χ : ℝ) : (-p)*Real.cos (χ+Real.pi)=p*Real.cos χ := by
  simp [Real.cos_add]
/-- Discussão, eq:reversao: energia total reduzida, todas as parcelas pares assumidas explicitamente. -/
theorem energy_reversal (ex an dm ms exR anR dmR msR : ℝ)
    (he : exR=ex) (ha : anR=an) (hd : dmR=dm) (hm : msR=ms) :
    energy exR anR dmR 0 msR=energy ex an dm 0 ms := by rw [he,ha,hd,hm]
/-- Discussão, eq:reversao: consequência para Q da linearidade do integral assumida. -/
theorem charge_reversal (I IR : ℝ) (h : IR = -I) : IR/(4*Real.pi) = -(I/(4*Real.pi)) := by rw [h]; ring
/-- Suplemento I: polinômio compatible com (X,Y,psi)->(X,-Y,-psi), Ypsi permitido. -/
theorem reflection_polynomial (U fx kx ky a c X Y ψ : ℝ) :
    U+fx*X+kx/2*X^2+ky/2*(-Y)^2+a/2*(-ψ)^2+c*(-Y)*(-ψ)=
    U+fx*X+kx/2*X^2+ky/2*Y^2+a/2*ψ^2+c*Y*ψ := by ring
/-- Suplemento I: reflexão xz combinada com reversão magnética, DMI de volume ímpar.
A transformação diferencial do curl fornece (-cx,cy,-cz). -/
theorem reflection_bulk (m c : V3) :
    dot ⟨m.x,-m.y,m.z⟩ ⟨-c.x,c.y,-c.z⟩ = -dot m c := by simp only [dot]; ring
/-- Suplemento I: DMI interfacial invariante sob a mesma reflexão. -/
theorem reflection_interface (D n divt tx ty nx ny : ℝ) :
    D*(n*divt-(tx*nx+(-ty)*(-ny)))=D*(n*divt-(tx*nx+ty*ny)) := by ring
/-- Suplemento I: reflexão dos spins e inversão da coordenada y preservam a carga. -/
theorem reflection_charge (m u v : V3) :
    triple ⟨m.x,-m.y,m.z⟩ ⟨u.x,-u.y,u.z⟩ ⟨-v.x,v.y,-v.z⟩=triple m u v := by
  simp only [triple,dot,cross]; ring
/-- Suplemento I: os coeficientes ímpares desaparecem quando o jet é simétrico. -/
theorem reflection_forbidden (fY τ kXY kXψ : ℝ)
    (hY : fY = -fY) (hτ : τ = -τ) (hXY : kXY = -kXY) (hXψ : kXψ = -kXψ) :
    fY=0 ∧ τ=0 ∧ kXY=0 ∧ kXψ=0 := by constructor; linarith; constructor; linarith; constructor <;> linarith
/-- Discussão: barreiras iguais apenas para estados/caminhos mapeados com energias iguais.
Não prova existência de um caminho minimax, prefator ou vida média. -/
theorem reversed_path_barrier (Emax Emin EmaxR EminR : ℝ) (hM : EmaxR=Emax) (hm : EminR=Emin) :
    EmaxR-EminR=Emax-Emin := by rw [hM,hm]
/-- Discussão: reverter uma energia troca as desigualdades mínimo/máximo. -/
theorem minimum_becomes_maximum (U U₀ : ℝ) (h : U₀≤U) : -U≤ -U₀ := neg_le_neg h
end IC
