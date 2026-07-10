# Axiom Audit

This file tracks the current non-Lean assumptions.

## Already Lean-Checked Manuscript Steps

- Lemma `lem:conjugation`, permutation computation.
- Lemma `lem:inversions`, including the counted rectangle form.
- Positivity extraction from degreewise coefficients.
- Proposition `prop:stable-finite`, assembled from smaller LS/Kim interfaces.
- Theorem `thm:incidence`, property package, assembled from FW--Mihalcea and
  Kontsevich-type inputs.
- Proposition `prop:invariance`, after scheme-level invariance and evaluation
  equivariance inputs.
- Proposition `prop:refined`, coefficient form, routed through Gao--Xiong.
- Proposition `prop:twisted-positive`.
- Theorem `thm:main`.

## Stable Comparison Axioms

These replace the former single axiom `lam_shimozono_stable_finite_comparison`.

- `LS_product_expansion_data`;
- `LS_expansion_coeff_eq`;
- `stable_product_specializes_to_finite_product`;
- `kim_basis_unique_coefficients`.
- `specialization_act_on_bounded_monomial`.

## Geometry Axioms

### External Literature Inputs

- `fw_mihalcea_preimage`;
- `kontsevich_moduli_irreducible`;
- `mihalcea_projection_formula_coefficient`;
- `equivariant_poincare_duality_coefficient`;
- `mihalcea_expected_codim_pullback`;
- `gao_xiong_refined_graham_positive_for_cycle`.

### Infrastructure Still To Replace Or Justify

- `proper_pushforward_effective`;
- `fundamental_cycle_effective_of_reduced`;
- `fundamental_cycle_invariant_of_invariant_scheme`;
- `equivariant_pushforward_invariant`;
- `equivariant_comp`;
- `invariant_preimage_of_equivariant`;
- `preimage_inclusion_equivariant`;
- `product_subscheme_invariant`;
- `equivariant_of_restricted_action`;
- `tauXuStable`;
- `xvStable`;
- `stableMapPostCompositionEv12_equivariant`;
- `stableMapPostCompositionEv3_equivariant`;
- `stableMapPostComposition_restricts_to_incidenceGroup`.

## Immediate Reduction Targets

1. Replace `tauXuStable` and `xvStable` by theorems from Schubert stability.
2. Replace the post-composition evaluation-map axioms by a general stable-map
   action formalization.
3. Split `stable_product_specializes_to_finite_product` and
   `kim_basis_unique_coefficients`.
