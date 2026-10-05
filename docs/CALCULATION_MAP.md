# Calculation map / Inventário de cálculos e rastreabilidade

This inventory preserves the original scientific classifications and theorem names.
The table remains in Portuguese to retain its precise hypotheses and limitations.
Read [Formalization scope](FORMALIZATION_SCOPE.md) and
[Analytical model](ANALYTICAL_MODEL.md) for a standalone English introduction.

Legacy `.tex` filenames, equation labels and supplement sections below are provenance
identifiers, not files or runtime dependencies in this repository. No report sources or
PDFs are distributed. Historical equation numbers/pages are retained for traceability;
they are not a claim about pagination of a current document. All public Lean paths
point to the independent project under `lean/`.

Categorias: **A** prova matemática completa do enunciado indicado; **B** prova sob
hipóteses matemáticas/físicas explícitas; **C** álgebra final, sem certificar a redução física;
**D** formalização integral não realizada, acompanhada de modelo das grandezas e provas
das consequências utilizadas. Categoria A de uma identidade não certifica um modelo físico.
Os resultados históricos refutados não são metas de prova.

| ID | Equação ou resultado | Fonte `.tex` / label ou localização | Função científica | Hipóteses e limite | Categoria | Arquivo Lean | Teoremas efetivos (namespace IC) | Verificação local |
|---|---|---|---|---|---|---|---|---|
| M01 | Heisenberg e penalidade entre spins vizinhos | revisaobib.tex, em linha | Origem do contínuo | Spins unitários; expansão em gradientes não derivada de muitos corpos | D | [Micromagnetics.lean](../lean/LeanVerification/Micromagnetics.lean) | heisenberg_difference | Compilado; alcance limitado abaixo |
| M02 | M=Ms m; norma unitária | revisaobib.tex, em linha | Campo de ordem FM | Ms constante | A | [Micromagnetics.lean](../lean/LeanVerification/Micromagnetics.lean) | magnetization_norm | Compilado |
| M03 | Funcional micromagnético | revisaobib.tex, eq:energia | Reunir energias | Integrais e existência de estados assumidas | D | [Micromagnetics.lean](../lean/LeanVerification/Micromagnetics.lean) | energy_additivity | Compilado; alcance limitado abaixo |
| M04 | Anisotropias de eixo e plano fácil | revisaobib.tex, em linha | Seleção de direção | Coeficientes positivos | B | [Micromagnetics.lean](../lean/LeanVerification/Micromagnetics.lean) | easy_axis_bound, easy_plane_nonnegative | Compilado |
| M05 | Zeeman | revisaobib.tex, eq:energia | Acoplamento ao campo | Campo imposto | A | [Micromagnetics.lean](../lean/LeanVerification/Micromagnetics.lean) | zeeman_reversal | Compilado |
| M06 | Duas representações de Ed e Maxwell | revisaobib.tex, eq:dipolar | Energia não local | Identidade de integração por partes e condições no infinito assumidas | D | [Micromagnetics.lean](../lean/LeanVerification/Micromagnetics.lean) | dipolar_energy_identity | Compilado; alcance limitado abaixo |
| M07 | DMI de volume | revisaobib.tex, eq:dmivol | Quiralidade | Curl físico; derivadas modeladas | C | [Micromagnetics.lean](../lean/LeanVerification/Micromagnetics.lean) | bulk_dmi_reversal | Compilado |
| M08 | DMI interfacial | revisaobib.tex, eq:dmiint | Quiralidade da interface | Interface e operadores declarados | C | [Micromagnetics.lean](../lean/LeanVerification/Micromagnetics.lean) | interface_dmi_reversal | Compilado |
| M09 | Comprimentos ex, K, D | revisaobib.tex, eq:comprimentos | Balanços de energia | A, mu0, Ms positivos; K,D não nulos | B | [Micromagnetics.lean](../lean/LeanVerification/Micromagnetics.lean) | exchange_length_balance, anisotropy_length_balance, dmi_length_balance | Compilado |
| M10 | Campo efetivo e torque estacionário | revisaobib.tex, em linha | Estacionariedade versus mínimo | Derivada funcional e contornos não construídos | D | [Micromagnetics.lean](../lean/LeanVerification/Micromagnetics.lean) | parallel_field_zero_torque | Compilado; alcance limitado abaixo |
| T01 | Densidade e integral Q | modelos_algoritmos.tex, eq:carga | Topologia | Regularidade, compactificação e grau não demonstrados | D | [Topology.lean](../lean/LeanVerification/Topology.lean) | topological_density_reversal | Compilado; alcance limitado abaixo |
| T02 | Campo axial; Q=q(cos theta0-cos thetaInf)/2 | modelos_algoritmos.tex, eq:ansatz | Classificação dos núcleos | Redução radial/limites explícitos | B | [Topology.lean](../lean/LeanVerification/Topology.lean) | axial_unit, axial_density, radial_primitive, radial_charge | Compilado |
| T03 | Q skyrmion, meron e bimeron | modelos_algoritmos.tex, em linha | Cargas e polaridades | Contornos axial/equatorial; soma dos núcleos idealizados | B | [Topology.lean](../lean/LeanVerification/Topology.lean) | skyrmion_charge, meron_charge, bimeron_charge, equal_polarities | Compilado |
| T04 | Rotação própria preserva Q e troca | modelos_algoritmos.tex, em linha | Equivalência topológica | Rotação uniforme; no caso explícito Ry(pi/2) | B | [Topology.lean](../lean/LeanVerification/Topology.lean) | rotation_norm, rotation_triple | Compilado |
| T05 | Belavin–Polyakov e núcleos girados | resultados.tex, fig:rotacao; modelos_algoritmos.tex, chamada; eq:ilustracao recebida no suplemento | Exemplo pedagógico da rotação de spins | Escala positiva; prova de grau global separada | D | [Topology.lean](../lean/LeanVerification/Topology.lean) | bp_unit, bp_core_positive, bp_core_negative | Compilado; alcance limitado abaixo |
| T06 | Dilatação da troca bidimensional | modelos_algoritmos.tex, em linha | Ausência de escala na troca pura | Mudança de variáveis do integral assumida | D | [Topology.lean](../lean/LeanVerification/Topology.lean) | exchange_scaling | Compilado; alcance limitado abaixo |
| G01 | Métrica, determinante, área e normal | metodologia.tex, geometria | Medidas na superfície | Imersão regular; identidade de Gram local | B | [Geometry.lean](../lean/LeanVerification/Geometry.lean) | gram_identity, normalized_normal | Compilado |
| G02 | H, KG, Delta; recuperação de kappas | metodologia.tex, eq:curvaturas | Invariantes geométricos | Rótulos principais fixos | A | [Geometry.lean](../lean/LeanVerification/Geometry.lean) | recover_principal, mean_sq_sub_dev_sq | Compilado |
| G03 | Paridades sob inversão da normal | metodologia.tex, em linha | Convenção de sinais | Kappas mudam de sinal | A | [Geometry.lean](../lean/LeanVerification/Geometry.lean) | normal_reversal | Compilado |
| G04 | H²-Delta²=KG; comparação de módulos | metodologia.tex, em linha | Limite da regra por KG | Identidade algébrica | A | [Geometry.lean](../lean/LeanVerification/Geometry.lean) | magnitude_criterion | Compilado |
| G05 | Elemento de área deslocado | metodologia.tex, magnetostática | Áreas das faces | Regularidade da casca; fator de Jacobiano modelado | B | [Geometry.lean](../lean/LeanVerification/Geometry.lean) | offset_area, upper_face, lower_face | Compilado |
| G06 | Casca fina: integral em t e ausência de t² | metodologia.tex; suplemento | Momento distribuído | Teste suave; Taylor/remainder não é autoenergia singular | D | [Magnetostatics.lean](../lean/LeanVerification/Magnetostatics.lean) | thickness_primitive, thickness_polynomial_integral, thickness_integral | Compilado; alcance limitado abaixo |
| G07 | Conexão antissimétrica e derivada móvel | metodologia.tex, em linha | Derivar a base | Ortogonalidade diferenciada; geometria global assumida | B | [Geometry.lean](../lean/LeanVerification/Geometry.lean) | connection_skew, moving_product | Compilado |
| E01 | Troca superficial | metodologia.tex, eq:trocasuperficie | Redução dimensional | Uniformidade normal e casca fina | D | [Exchange.lean](../lean/LeanVerification/Exchange.lean) | thin_shell_energy | Compilado; alcance limitado abaixo |
| E02 | Expansão da derivada covariante | metodologia.tex, eq:expansao | Controle de dupla contagem | Métrica simétrica | A | [Exchange.lean](../lean/LeanVerification/Exchange.lean) | covariant_square | Compilado |
| E03 | Decomposição linear/quadrática com h12 | metodologia.tex, em linha | Origem geométrica da troca | Derivadas locais em base ortonormal | A | [Exchange.lean](../lean/LeanVerification/Exchange.lean) | moving_frame_exchange | Compilado |
| E04 | Parcela tangencial e diferença k1²-k2² | metodologia.tex, em linha | Anisotropia extrínseca | Magnetização tangente | A | [Exchange.lean](../lean/LeanVerification/Exchange.lean) | tangential_energy, anisotropy_difference | Compilado |
| E05 | Contração axial antes da média | metodologia.tex, eq:selecao; suplemento H.1 | Sinais e harmônicos | Núcleo axial; tensor uniforme | C | [Selection.lean](../lean/LeanVerification/Selection.lean) | axial_contraction, principal_harmonics, harmonic_arguments | Compilado |
| E06 | Seleção q=+1 e q=-1 | metodologia.tex/resultados.tex, eq:selecao | Resultado local principal | Média angular e curvatura uniforme | B | [Selection.lean](../lean/LeanVerification/Selection.lean) | mean_linearity, mean_zero, mean_two, mean_neg_two, selection_positive, selection_negative | Compilado |
| E07 | Covariância de chi-2alpha e ângulo do par | metodologia.tex; resultados.tex, eq:parprimeira | Convenções angulares | Rotação passiva | A | [Selection.lean](../lean/LeanVerification/Selection.lean) | passive_invariance, pair_angle | Compilado |
| E08 | I1, energia radial e polaridade | metodologia.tex, eq:fatorradial e em linha | Coeficiente de núcleo | Integrabilidade/sinal de I1 explicitamente assumidos | D | [Selection.lean](../lean/LeanVerification/Selection.lean) | radial_integrand_reversal, core_energy_polarity, radial_double_angle | Compilado; alcance limitado abaixo |
| E09 | Bloch positivo e antivórtice oblíquo | metodologia.tex, após eq:selecao | Limites da seleção | Helici­dade/eixos declarados | A | [Selection.lean](../lean/LeanVerification/Selection.lean) | bloch_positive_zero, principal_swap | Compilado |
| MS01 | Carga volumétrica -Ms divS mt+2Ms H mn | metodologia.tex, em linha | Geometria das cargas | Extensão normal constante | C | [Magnetostatics.lean](../lean/LeanVerification/Magnetostatics.lean) | volume_charge | Compilado |
| MS02 | Cancelamento faces-volume | metodologia.tex, em linha | Ausência de monopolo isolado | Taylor em espessura contra teste suave | C | [Magnetostatics.lean](../lean/LeanVerification/Magnetostatics.lean) | face_volume_cancellation | Compilado |
| MS03 | Ent e kernel normal local | metodologia.tex, eq:folhadipolos | Acoplamento não local | Integração por partes, contorno nulo, regularização assumidos | D | [Magnetostatics.lean](../lean/LeanVerification/Magnetostatics.lean) | cross_prefactor, normal_kernel_derivative, kernel_decomposition | Compilado; alcance limitado abaixo |
| MS04 | Seleção harmônica magnetostática | metodologia.tex, após eq:folhadipolos | Estrutura da energia | Convolução radial modelada por multiplicadores de Fourier; prova integral da diagonalização não construída | D | [Magnetostatics.lean](../lean/LeanVerification/Magnetostatics.lean) | axial_harmonic_consequence | Compilado; alcance limitado abaixo |
| MS05 | Jms(L), N(L), razão e fator 1/4 | metodologia.tex recebida; suplemento H.7 | Diagnóstico do auto-termo cortado | Coeficientes regulados, não do par completo | C | [Magnetostatics.lean](../lean/LeanVerification/Magnetostatics.lean) | cutoff_ratio, quarter_factor | Compilado |
| MS06 | Logaritmo e incremento ao dobrar corte | metodologia.tex recebida; suplemento H.7 | Limitação de convergência | Assintótica assumida; consequência algébrica do modelo log | D | [Magnetostatics.lean](../lean/LeanVerification/Magnetostatics.lean) | logarithmic_increment | Compilado; alcance limitado abaixo |
| D01 | Divergência 3D da DMI: -2DHmn² | metodologia.tex, em linha | Dependência do funcional | Divergência decomposta | C | [Exchange.lean](../lean/LeanVerification/Exchange.lean) | interface_extrinsic | Compilado |
| D02 | Curl extrínseco geral e principal | metodologia.tex, em linha; suplemento H.6 | Termo ausente na ponte | Extensão normal constante | C | [Exchange.lean](../lean/LeanVerification/Exchange.lean) | bulk_extrinsic, bulk_principal | Compilado |
| D03 | Eixo projetado: paridade e ordem h² | resultados.tex; suplemento E.3 | Hipóteses do fundo | Projeção não nula; série local assumida | D | [GaussianProfile.lean](../lean/LeanVerification/GaussianProfile.lean) | projected_axis_parity, scale_ratio | Compilado; alcance limitado abaixo |
| F01 | f gaussiana, f', f'' | metodologia.tex, eq:perfilgaussiano | Geometria escolhida | sigma>0 | A | [GaussianProfile.lean](../lean/LeanVerification/GaussianProfile.lean) | profile_derivative, profile_second_derivative | Compilado |
| F02 | Métrica B, normal, tangentes | metodologia.tex, em linha | Operadores locais | rho>0; B=1+f'² | B | [GaussianProfile.lean](../lean/LeanVerification/GaussianProfile.lean) | metric_positive, graph_frame | Compilado |
| F03 | Curvaturas exatas; KG explícito | metodologia.tex, eq:curvgauss | Distribuição espacial | Normal para cima; sigma>0 | B | [GaussianProfile.lean](../lean/LeanVerification/GaussianProfile.lean) | azimuthal_extension, gaussian_curvature_product, exponential_square, curvature_denominator | Compilado |
| F04 | Ápice e sinal de Delta | metodologia.tex, eq:curvgauss; resultados.tex, §5.1.2 e Discussão | Resposta diferente dos núcleos | Extensão regular em rho=0; h>0 | B | [GaussianProfile.lean](../lean/LeanVerification/GaussianProfile.lean) | apex_curvatures, deviation_formula, deviation_nonnegative | Compilado |
| F05 | Sinal de KG e anel rho=sigma | metodologia.tex, eq:curvgauss; resultados.tex, §5.1.2 e Discussão | Regiões do relevo | h não nulo, sigma>0 | B | [GaussianProfile.lean](../lean/LeanVerification/GaussianProfile.lean) | gaussian_sign, gaussian_curvature_sign, gaussian_ring | Compilado |
| F06 | Paridades em h | metodologia.tex, eq:curvgauss; resultados.tex, §5.1.2 e Discussão | Elevação/depressão | Mesmas componentes locais | A | [GaussianProfile.lean](../lean/LeanVerification/GaussianProfile.lean) | profile_odd, metric_even, curvatures_odd | Compilado |
| F07 | Séries H=-h/sigma²+2beta rho²; Delta=beta rho² | resultados.tex, eq:expansaoapice e em linha; suplemento H.5 | Expansão no ápice | Jets e resto explicitados; resto analítico separado | D | [GaussianProfile.lean](../lean/LeanVerification/GaussianProfile.lean) | curvature_jet, local_derivative_relation | Compilado; alcance limitado abaixo |
| C01 | Posições Rv, Ra e P,T | resultados.tex, em linha | Coordenadas coletivas | Par rígido projetado, s=d/2>0 | A | [CollectiveEnergy.lean](../lean/LeanVerification/CollectiveEnergy.lean) | rotated_radius, pair_separation | Compilado |
| C02 | Energia coletiva U1, Ci | resultados.tex, eq:parprimeira | Resultado variacional | Soma dos dois núcleos; não funcional completo | D | [CollectiveEnergy.lean](../lean/LeanVerification/CollectiveEnergy.lean) | pair_energy_from_cores | Compilado; alcance limitado abaixo |
| C03 | Expansão radial e angular em P,T | resultados.tex, expansão; suplemento H.3 | Derivar coeficientes | Derivadas radiais/jet de segunda ordem | C | [CollectiveEnergy.lean](../lean/LeanVerification/CollectiveEnergy.lean) | radial_jet_constraints, angular_jet | Compilado |
| C04 | Uc, fP, fT, kP, kT, kPT | resultados.tex, eq:forcas, eq:rigidezes e expansão | Gradiente e Hessiana | s não nulo; fases fixas na translação | C | [CollectiveEnergy.lean](../lean/LeanVerification/CollectiveEnergy.lean) | pair_jet_coefficients | Compilado |
| C05 | Gradientes e segundas derivadas do polinômio | resultados.tex, em linha | Força versus gradiente | Taylor truncado declarado | A | [CollectiveEnergy.lean](../lean/LeanVerification/CollectiveEnergy.lean) | energy_gradient_P, energy_gradient_T, mixed_derivative | Compilado |
| C06 | Coeficientes no ápice e cancelamentos | resultados.tex, após eq:forcas | Interpretação local | Séries de F07; não estacionariedade total | C | [CollectiveEnergy.lean](../lean/LeanVerification/CollectiveEnergy.lean) | apex_coefficients, apex_deviator_polynomial, neel_cancellation | Compilado |
| C07 | Família com fundo fixo / fase XY | resultados.tex, em linha; suplemento H.4 | Significado de psi e helicidade | Relações cinemáticas de fase declaradas | B | [Orientation.lean](../lean/LeanVerification/Orientation.lean) | fixed_background_phases | Compilado |
| C08 | tau1 e a1=-eta² Uc | resultados.tex, eq:orientprimeira | Resposta angular direta | Fases afins comuns; amplitudes constantes | B | [Orientation.lean](../lean/LeanVerification/Orientation.lean) | central_derivative, central_second_derivative | Compilado |
| C09 | Blocos mistos com fases variáveis | resultados.tex, em linha | Acoplamento posição-orientação | Mesma família de campos | B | [Orientation.lean](../lean/LeanVerification/Orientation.lean) | mixed_X_orientation, mixed_Y_orientation | Compilado |
| C10 | Regra geral Uc'' | resultados.tex recebida; suplemento H.4 | Limite da família afim | Fases duas vezes diferenciáveis | B | [Orientation.lean](../lean/LeanVerification/Orientation.lean) | phase_chain_second | Compilado |
| C11 | Casos Néel/Bloch e resposta -lambda tau/a0 | resultados.tex, em linha; suplemento H.4 | Exemplos físicos condicionais | a0>0; referência estacionária | B | [Orientation.lean](../lean/LeanVerification/Orientation.lean) | neel_orientation, bloch_orientation, angular_response | Compilado |
| C12 | Termo par: gradiente cancela, rigidez não | resultados.tex, último parágrafo | Limitação de simetrias | Pesos dos núcleos iguais, não inferidos de p | C | [CollectiveEnergy.lean](../lean/LeanVerification/CollectiveEnergy.lean) | even_core_pair | Compilado |
| S01 | Positividade do bloco Hessiano 2x2 | resultados.tex, após eq:forcas | Estabilidade posicional restrita | Avaliação física apenas em ponto estacionário | A | [Stability.lean](../lean/LeanVerification/Stability.lean) | positive_definite_iff | Compilado |
| S02 | Schur e redução da rigidez | resultados.tex, eq:schur | Relaxação dos modos internos | Dois modos internos acoplados e uma direção posicional; C positivo, sem modos nulos; versão geral/funcional não provada | B | [Stability.lean](../lean/LeanVerification/Stability.lean) | hessian_completion, schur_completion, internal_inverse, relaxed_le_frozen | Compilado |
| S03 | Eliminação harmônica, ordem lambda² | resultados.tex, Discussão; suplemento J | Mistura versus termos diretos | Denominadores rígidos; Taylor físico assumido | C | [Stability.lean](../lean/LeanVerification/Stability.lean) | harmonic_elimination, perturbative_order | Compilado |
| S04 | Dois termos da derivada g^T K^-1 g | PDF recebido p.21; suplemento J | Evitar Schur em ponto errado | Uma componente real g; soma diagonal por aditividade; K constante não nulo; não Hessiana funcional | B | [Stability.lean](../lean/LeanVerification/Stability.lean) | eliminated_second_derivative | Compilado |
| S05 | Determinante confinado com a1 kT | suplemento J | Preservar correção histórica | Modelo especial declarado | C | [Stability.lean](../lean/LeanVerification/Stability.lean) | confined_determinant | Compilado |
| S06 | Potencial intrínseco VG, monotonicidade | resultados.tex, Discussão; suplemento | Distinguir KG local de potencial global | Derivada do integral assumida; rho>0 | D | [Intrinsic.lean](../lean/LeanVerification/Intrinsic.lean) | potential_monotone_slope, potential_even, poisson_final_step, slope_positive_curvature_negative | Compilado; alcance limitado abaixo |
| S07 | Paridades da energia e coeficientes | resultados.tex, Discussão | Controle h -> -h | Mesmo ponto, fases e perfis | B | [Symmetry.lean](../lean/LeanVerification/Symmetry.lean) | pair_height_reversal, coefficient_reversal | Compilado |
| S08 | E[m]=E[-m], Q[-m]=-Q[m] | resultados.tex, eq:reversao | Limite de seleção absoluta | Campo nulo; fundo/contorno também revertidos | D | [Symmetry.lean](../lean/LeanVerification/Symmetry.lean) | energy_reversal, charge_reversal, polarity_phase_reversal | Compilado; alcance limitado abaixo |
| S09 | Reflexões e blocos proibidos | resultados.tex recebida; suplemento I | Restrições de simetria | Funcional/eixo/contornos compatíveis | C | [Symmetry.lean](../lean/LeanVerification/Symmetry.lean) | reflection_polynomial, reflection_forbidden, reflection_bulk, reflection_interface, reflection_charge | Compilado |
| S10 | Barreira e caminhos revertidos | PDF recebido p.23; suplemento | Localização versus destruição | Caminhos e extremos correspondentes | D | [Symmetry.lean](../lean/LeanVerification/Symmetry.lean) | reversed_path_barrier, minimum_becomes_maximum | Compilado; alcance limitado abaixo |
| U01 | Dimensões de C, gradientes e rigidezes | textos e suplemento K | Coerência de unidades | SI; ângulos adimensionais | C | [Dimensions.lean](../lean/LeanVerification/Dimensions.lean) | coefficient_dimensions, gradient_dimensions | Compilado |

## Alcance efetivamente certificado

A classificação vale para o **cálculo científico da linha**, não para a totalidade da física.
Uma linha D possui teoremas locais compilados; sua redução física/analítica integral
continua não formalizada. A hipótese de uma identidade de integração por partes em M06
é somente uma interface: o lema prova a substituição algébrica, não aquela identidade.
De modo semelhante, S08 assume invariância de cada parcela integrada, enquanto os
lemas de densidade em M07–M08 e T01 conferem a bilinearidade e o sinal topológico.

- **A:** identidades exatas de curvaturas, paridades, contrações polinomiais, derivadas
  gaussianas, derivadas do polinômio coletivo e positividade do bloco Hessiano 2x2.
- **B:** regularidade/denominadores, derivadas fornecidas para a regra da cadeia,
  limites radiais, perfis/fases e positividade do bloco interno são hipóteses explícitas.
  As integrais angulares de seno/cosseno estão construídas em Mathlib, sem hipótese
  do valor desejado; E06 é condicional apenas à redução axial e à geometria uniforme.
- **C:** contrações após redução física, produtos de jets, coeficientes de expansão,
  termo magnetostático regulado e determinante do modelo confinado. O produto de jets
  não prova a existência nem o tamanho de restos de Taylor.
- **D:** passagem microscópica ao contínuo; funcionais e condições de contorno;
  grau/integral imprópria global; convergência de I1; redução da casca com kernel singular;
  convolução magnetostática completa; assintótica logarítmica; controle dos restos;
  soma de núcleos como aproximação do bimeron; potencial intrínseco integral; minimax e
  dinâmica térmica. Faltam infraestrutura analítica e hipóteses materiais/de contorno,
  não identidades algébricas. Nenhum destes itens é apresentado como prova completa.

G06 merece distinção: `thickness_integral` prova a integral real exata do **polinômio**
de Taylor. A aproximação de uma função geral e a autoenergia singular continuam D.
F07 verifica os coeficientes dos jets gaussianos, não os restos O(rho⁴)/O(rho³).
S02 cobre uma direção posicional arbitrária e dois modos internos com matriz simétrica
2x2, inclusive a inversa; não há formalização da Hessiana funcional ou de dimensão geral.
S04 confere a derivada de uma componente escalar da forma quadrática eliminada.

## Convenções cruzadas

| LaTeX | Lean | Conferência |
|---|---|---|
| H=(kappa1+kappa2)/2 | `mean` | Mesmo fator 1/2 |
| Delta=(kappa1-kappa2)/2 | `dev` | Ordem radial menos azimutal |
| KG=kappa1*kappa2 | produto de `kr`, `ka` | Normal para cima; KG par em h |
| B=1+f'² | `metricB` | Sempre positivo |
| B^(3/2) | B*sqrt B | Mesma raiz positiva |
| polaridade p | `p`, `pv`, `pa` | I1=p*abs I1 assumido uma única vez |
| cos[chi_a+2(psi-Theta_a)] | `pairEnergy`, `pair_angle` | Sinal positivo da conversão de referencial |
| v, b, c, z nos jets | Cv*pv*cos chi_v, Ca*pa, cos chi_a, sin chi_a | Abreviações do suplemento |
| fP,fT | derivadas primeiras | Força tem sinal oposto |
| kP,kT,kPT | 2*pp,2*tt,pt de `Jet` | Sem fator 2 extra no termo misto |
| tau1 | `centralD` | Torque conservativo = -tau1 |
| eta | `η` | Família afim comum, não lei derivada da DMI |
| lambda perturbativo | `lam` | Não é a escala BP da figura |
| h -> -h | `curvatures_odd`, `pair_height_reversal` | Mesmo ponto, fases e componentes locais |

## Equações mapeadas — identificadores e paginação históricos

| Label | Número | Página física | Itens do inventário |
|---|---|---|---|
| `eq:energia` | 2.1 | 6 | M03,M05 |
| `eq:dipolar` | 2.2 | 7 | M06 |
| `eq:dmivol` | 2.3 | 7 | M07 |
| `eq:dmiint` | 2.4 | 7 | M08 |
| `eq:comprimentos` | 2.5 | 7 | M09 |
| `eq:carga` | 2.6 | 8 | T01 |
| `eq:ansatz` | 2.7 | 9 | T02,T03 |
| `eq:curvaturas` | 4.1 | 11 | G02,G03,G04 |
| `eq:trocasuperficie` | 4.2 | 12 | E01 |
| `eq:expansao` | 4.3 | 12 | E02,E03 |
| `eq:selecao` | 4.4 | 13 | E05,E06,E07,E09 |
| `eq:fatorradial` | 4.5 | 13 | E08 |
| `eq:folhadipolos` | 4.6 | 13 | MS03,MS04 |
| `eq:perfilgaussiano` | 4.7 | 14 | F01,F02 |
| `eq:curvgauss` | 4.8 | 14 | F03,F04,F05,F06 |
| `eq:expansaoapice` | 5.1 | 15 | F07 |
| `eq:parprimeira` | 5.2 | 16 | C01,C02,E08 |
| `eq:forcas` | 5.3 | 16 | C03,C04,C05,C06 |
| `eq:rigidezes` | 5.4 | 17 | C04,C05,S01 |
| `eq:orientprimeira` | 5.5 | 17 | C07,C08,C09,C10,C11 |
| `eq:schur` | 6.1 | 19 | S02,S03,S04 |
| `eq:reversao` | 6.2 | 20 | S08,T01 |

Todas as 22 equações numeradas estão mapeadas. Definições e resultados em linha
constam da tabela principal, mesmo quando não possuem label.
