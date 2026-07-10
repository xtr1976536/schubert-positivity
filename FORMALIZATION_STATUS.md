# Formalization Status

Current status after the latest passing CI run on `main`.

## Verified

- No `sorry` in Lean files.
- GitHub Actions `lake build` passes.
- Block-swap permutation computations are proved.
- Lemma `lem:conjugation`, permutation part, is proved.
- Lemma `lem:inversions`, including the counted inversion rectangle, is proved.
- Coefficient positivity has a concrete positive-polynomial model.
- Finite-support quantum positivity bookkeeping has a concrete Lean module.
- `prop:stable-finite` is no longer a single axiom; it is proved from smaller
  Lam--Shimozono/Kim interfaces.
- The incidence scheme is defined as an equivariant preimage.
- The incidence theorem property package is proved from FW--Mihalcea and
  Kontsevich-type inputs.
- The incidence cycle is defined as a pushforward.
- Incidence-cycle effectivity and invariance are Lean theorems derived from
  smaller geometric inputs.
- Gao--Xiong positivity is routed through one geometric external theorem.
- `prop:twisted-positive` and `thm:main` are Lean theorems relative to the
  remaining external/geometric interfaces.

## Top-Level Manuscript Interface Remaining

- `mihalcea_projection_duality_coefficient`.

## Stable Comparison Interfaces Remaining

- `LS_product_expansion_data`;
- `LS_expansion_coeff_eq`;
- `finite_specialization_preserves_bounded_terms`;
- `stable_product_specializes_to_finite_product`;
- `kim_basis_unique_coefficients`.

## Incidence/Invariance Interfaces Remaining

- `incidenceConditionInvariant`;
- `stableMapEv12_equivariant`;
- `stableMapEv3_equivariant`.

## General External/Infrastructure Interfaces Remaining

- `fw_mihalcea_preimage`;
- `kontsevich_moduli_irreducible`;
- `mihalcea_expected_codim_pullback`;
- `proper_pushforward_effective`;
- `fundamental_cycle_effective_of_reduced`;
- `fundamental_cycle_invariant_of_invariant_scheme`;
- `equivariant_pushforward_invariant`;
- `equivariant_comp`;
- `invariant_preimage_of_equivariant`;
- `preimage_inclusion_equivariant`;
- `gao_xiong_refined_graham_positive_for_cycle`.

## Next Targets

1. Prove `incidenceConditionInvariant` from stability of the two factors
   `tau X_u` and `X_v`.
2. Prove `stableMapEv12_equivariant` and `stableMapEv3_equivariant` from the
   post-composition action on stable maps.
3. Split `mihalcea_projection_duality_coefficient` into projection formula,
   pushforward compatibility, and Poincare duality.
