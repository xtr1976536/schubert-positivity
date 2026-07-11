# B Geometry Schubert Stability Split

This branch reduces the two Schubert-factor stability interfaces.

## Converted to internal theorems

- `tauXuStable`
- `xvStable`

## New smaller interfaces

The translated factor now uses the explicit block-swap conjugation computation:

- `BlockSwapConjugationWitness`
- `blockSwapConjugationWitness`, proved from
  `manuscript_lem_conjugation_permutation`
- `tauXuStable_of_blockSwapConjugation`

The second factor now uses ordinary opposite-Schubert stability and subgroup
restriction:

- `OppositeBorelGroup`
- `oppositeSchubertStable_under_Bminus`
- `incidenceGroup_restricts_to_oppositeBorel`
- `invariant_scheme_of_restricted_action`

## Remaining target

The next reduction should split `tauXuStable_of_blockSwapConjugation` into:

- torus stability of the translated Schubert variety,
- the unipotent intersection condition
  `N^- ∩ tau N^- tau⁻¹`,
- the conjugation step `n₀ = tau n' tau⁻¹`,
- standard Schubert stability under the relevant negative unipotent action.

The next reduction for `xvStable` is to replace
`oppositeSchubertStable_under_Bminus` by the standard theorem that opposite
Schubert varieties are `B^-`-stable.
