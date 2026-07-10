import Std

/-!
Interfaces for external geometric results used by the manuscript.

These declarations are intentionally abstract.  The two-week target is to
formalize all manuscript-owned combinatorics and all logical assembly steps,
while keeping deep external geometric theorems as sharply named interfaces.
-/

namespace SchubertPositivity

opaque Perm : Type
opaque Degree : Type
opaque Poly : Type

opaque StableCoeff : Perm → Perm → Perm → Poly
opaque FiniteTwistedCoeff : Nat → Perm → Perm → Perm → Poly
opaque TwistedGWCoeff : Nat → Perm → Perm → Perm → Degree → Poly

opaque InPositiveCone : Poly → Prop

/- Proposition `prop:stable-finite` in the manuscript.
   Source input: Lam--Shimozono stability and finite support of the product.
-/
axiom stable_finite_comparison :
    ∀ u v w : Perm,
      ∃ n : Nat, 0 < n ∧
        StableCoeff u v w = FiniteTwistedCoeff n u v w

/- Proposition `prop:coefficient-gw`, used only at the positivity level here.
   The detailed equality with the degree expansion will be unfolded after the
   polynomial/quantum-series layer is formalized.
-/
axiom coefficient_gw_preserves_positivity :
    ∀ (n : Nat) (u v w : Perm),
      (∀ d : Degree, InPositiveCone (TwistedGWCoeff n u v w d)) →
        InPositiveCone (FiniteTwistedCoeff n u v w)

/- Proposition `prop:twisted-positive`.
   Source input: incidence-cycle expression, invariance/effectivity, refined
   Graham positivity, and equivariant Schubert duality.
-/
axiom twisted_gw_positive :
    ∀ (n : Nat) (u v w : Perm) (d : Degree),
      0 < n →
        InPositiveCone (TwistedGWCoeff n u v w d)

end SchubertPositivity
