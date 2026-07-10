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
opaque Coeff : Type

abbrev QuantumPoly : Type := Degree → Coeff

opaque StableCoeff : Perm → Perm → Perm → QuantumPoly
opaque TwistedGWCoeff : Nat → Perm → Perm → Perm → Degree → Coeff
opaque IncidenceCycleCoeff : Nat → Perm → Perm → Perm → Degree → Coeff

def FiniteTwistedCoeff (n : Nat) (u v w : Perm) : QuantumPoly :=
  TwistedGWCoeff n u v w

opaque CoeffPositive : Coeff → Prop

def InPositiveCone (P : QuantumPoly) : Prop :=
  ∀ d : Degree, CoeffPositive (P d)

/- Proposition `prop:stable-finite` in the manuscript.
   Source input: Lam--Shimozono stability and finite support of the product.
-/
axiom stable_finite_comparison :
    ∀ u v w : Perm,
      ∃ n : Nat, 0 < n ∧
        StableCoeff u v w = FiniteTwistedCoeff n u v w

/- Positivity extraction from Proposition `prop:coefficient-gw`.
   In the current abstraction a quantum polynomial is already represented by
   its degree-indexed coefficients, so this is a definition-level proof.
-/
theorem coefficient_gw_preserves_positivity :
    ∀ (n : Nat) (u v w : Perm),
      (∀ d : Degree, CoeffPositive (TwistedGWCoeff n u v w d)) →
        InPositiveCone (FiniteTwistedCoeff n u v w) := by
  intro n u v w h d
  exact h d

/- Proposition `prop:incidence-expression` plus Fact `fact:duality`, used in
   coefficient form.
-/
axiom incidence_expression_coefficient :
    ∀ (n : Nat) (u v w : Perm) (d : Degree),
      TwistedGWCoeff n u v w d = IncidenceCycleCoeff n u v w d

/- Proposition `prop:refined`, after applying Lemma `lem:inversions` to identify
   Gao--Xiong's ring with the manuscript's positive cone.
   External input inside this interface: Gao--Xiong refined Graham positivity.
-/
axiom refined_graham_incidence_positive :
    ∀ (n : Nat) (u v w : Perm) (d : Degree),
      0 < n →
        CoeffPositive (IncidenceCycleCoeff n u v w d)

/- Proposition `prop:twisted-positive`, now proved from the two preceding
   manuscript-level interfaces.
-/
theorem twisted_gw_positive :
    ∀ (n : Nat) (u v w : Perm) (d : Degree),
      0 < n →
        CoeffPositive (TwistedGWCoeff n u v w d) := by
  intro n u v w d hn
  rw [incidence_expression_coefficient n u v w d]
  exact refined_graham_incidence_positive n u v w d hn

end SchubertPositivity
