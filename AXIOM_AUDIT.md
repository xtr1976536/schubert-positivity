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
- `finite_specialization_preserves_bounded_terms`;
- `stable_product_specializes_to_finite_product`;
- `kim_basis_unique_coefficients`.

## Geometry Axioms

### External Literature Inputs

- `fw_mihalcea_preimage`;
- `kontsevich_moduli_irreducible`;
- `mihalcea_projection_duality_coefficient`;
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
- `incidenceConditionInvariant`;
- `stableMapEv12_equivariant`;
- `stableMapEv3_equivariant`.

## Immediate Reduction Targets

1. Replace `incidenceConditionInvariant` by a theorem from factor stability and
   product stability.
2. Replace `stableMapEv12_equivariant` and `stableMapEv3_equivariant` by
   theorems from the post-composition action on stable maps.
3. Split `mihalcea_projection_duality_coefficient` into smaller Mihalcea
   projection/duality interfaces.
