# B Geometry Stability and Restriction Split

This branch continues the geometry-interface reduction.

## Converted to internal theorems

- `translatedSchubertStable`
- `oppositeSchubertStable`
- `incidenceConditionProductInvariant`
- `incidenceConditionInvariant`
- `stableMapEv12_equivariant`
- `stableMapEv3_equivariant`

## New smaller interfaces

Schubert-factor stability now matches the manuscript proof:

- `tauXuStable`: stability of the translated Schubert variety `tau X_u`.
- `xvStable`: stability of the opposite/second Schubert factor `X_v`.
- `product_subscheme_invariant`: product stability for invariant subschemes.

Evaluation equivariance now uses one general restriction lemma:

- `IsRestrictedAction H G`
- `equivariant_of_restricted_action`
- `stableMapPostComposition_restricts_to_incidenceGroup`

Thus the former pair

- `incidenceGroup_from_postComposition_ev12`
- `incidenceGroup_from_postComposition_ev3`

has been replaced by one action-restriction interface that applies to both
evaluation maps.

## Next target

Split `tauXuStable` into:

- torus stability of `tau X_u`,
- `N^- ∩ tau N^- tau⁻¹` stability,
- the conjugation argument `n₀ = tau n' tau⁻¹`,
- stability of Schubert varieties under the relevant negative unipotent action.

Split `xvStable` into ordinary `B^-`-stability plus restriction from `B^-` to
`B^-(tau)`.
