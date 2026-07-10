# Formalization Status

Last updated in the Lean project after CI passed on `main`.

## Verified

- No `sorry` in the Lean files.
- CI builds successfully with `lake build`.
- The permutation block-swap computations are proved.
- The inversion rectangle and counted `n^2` form are proved.
- Coefficient positivity is now represented by a concrete positive-polynomial
  model.
- Finite-support quantum positivity bookkeeping has a concrete Lean module.
- The incidence cycle is defined as a pushforward.
- Incidence-cycle effectivity and invariance are Lean theorems derived from
  smaller geometric inputs.
- Gao--Xiong positivity is routed through a single geometric external theorem,
  not duplicated as a top-level manuscript axiom.

## Top-Level Manuscript Interfaces Remaining

- `lam_shimozono_stable_finite_comparison`;
- `mihalcea_projection_duality_coefficient`.

## Geometry Interfaces Remaining

- `incidence_theorem_properties`;
- `incidenceSchemeInvariant`;
- `incidenceInclusion_equivariant`;
- `stableMapEv3_equivariant`.

## General External/Infrastructure Interfaces Remaining

- FW--Mihalcea preimage theorem pieces;
- Kontsevich moduli irreducibility;
- Mihalcea expected-codimension pullback;
- proper pushforward preserves effectivity;
- fundamental cycle of reduced/invariant schemes;
- equivariant pushforward and composition;
- Gao--Xiong refined Graham positivity for one effective invariant cycle.

## Next Target

Prove `incidenceSchemeInvariant` from stability of the two incidence conditions
and equivariance of `(ev₁,ev₂)`.
