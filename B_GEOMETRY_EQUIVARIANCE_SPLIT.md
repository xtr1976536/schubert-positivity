# B Geometry Equivariance Split

This branch narrows the incidence-invariance interfaces.

## Converted to internal theorems

- `incidenceConditionInvariant` is now proved from:
  - `translatedSchubertStable`
  - `oppositeSchubertStable`
  - `product_subscheme_invariant`
- `stableMapEv12_equivariant` is now proved from the stable-map
  post-composition action interface.
- `stableMapEv3_equivariant` is now proved from the stable-map
  post-composition action interface.

## Remaining small interfaces

- `translatedSchubertStable`
- `oppositeSchubertStable`
- `stableMapPostCompositionEv12_equivariant`
- `stableMapPostCompositionEv3_equivariant`
- `incidenceGroup_from_postComposition_ev12`
- `incidenceGroup_from_postComposition_ev3`
- `product_subscheme_invariant`

These are intentionally smaller than the former manuscript-level interfaces.
The next B-line target is to split the two Schubert-stability inputs into
unipotent/Torus stability and the block-swap conjugation calculation.
