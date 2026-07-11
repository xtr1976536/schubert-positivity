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
- Finite specialization of bounded coefficients is now a Lean theorem from
  monomial-level specialization bookkeeping.
- The incidence scheme is defined as an equivariant preimage.
- The incidence theorem property package is proved from FW--Mihalcea and
  Kontsevich-type inputs.
- The incidence cycle is defined as a pushforward.
- Incidence-cycle effectivity and invariance are Lean theorems derived from
  smaller geometric inputs.
- Gao--Xiong positivity is routed through one geometric external theorem.
- `prop:twisted-positive` and `thm:main` are Lean theorems relative to the
  remaining external/geometric interfaces.

## Top-Level Manuscript Interfaces Remaining

None as a single unsplit axiom.  The former
`mihalcea_projection_duality_coefficient` is now a theorem from two smaller
interfaces.

## Stable Comparison Interfaces Remaining

- `LS_product_expansion_data`;
- `LS_expansion_coeff_eq`;
- `stable_product_specializes_to_finite_product`;
- `kim_basis_unique_coefficients`.
- `specialization_act_on_bounded_monomial`.

## Incidence/Invariance Interfaces Remaining

- `tauXuStable`;
- `xvStable`;
- `stableMapPostCompositionEv12_equivariant`;
- `stableMapPostCompositionEv3_equivariant`;
- `stableMapPostComposition_restricts_to_incidenceGroup`.

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

1. Split `tauXuStable` and `xvStable` into Bruhat/Schubert stability lemmas.
2. Split post-composition evaluation equivariance into a general stable-map
   action interface.
3. Split `stable_product_specializes_to_finite_product` and
   `kim_basis_unique_coefficients` into smaller Kim/LS interfaces.
