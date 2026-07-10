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
opaque Cycle : Type

abbrev QuantumPoly : Type := Degree → Coeff

opaque StableCoeff : Perm → Perm → Perm → QuantumPoly
opaque TwistedGWCoeff : Nat → Perm → Perm → Perm → Degree → Coeff
opaque IncidenceCycle : Nat → Perm → Perm → Degree → Cycle
opaque SchubertCoeffOfCycle : Cycle → Perm → Coeff

def IncidenceCycleCoeff (n : Nat) (u v w : Perm) (d : Degree) : Coeff :=
  SchubertCoeffOfCycle (IncidenceCycle n u v d) w

def FiniteTwistedCoeff (n : Nat) (u v w : Perm) : QuantumPoly :=
  TwistedGWCoeff n u v w

opaque CoeffPositive : Coeff → Prop
opaque EffectiveCycle : Cycle → Prop
opaque BminusTauInvariantCycle : Nat → Cycle → Prop

def EffectiveBminusTauInvariant (n : Nat) (Z : Cycle) : Prop :=
  EffectiveCycle Z ∧ BminusTauInvariantCycle n Z

def InPositiveCone (P : QuantumPoly) : Prop :=
  ∀ d : Degree, CoeffPositive (P d)

/- External Lam--Shimozono input behind manuscript Proposition
   `prop:stable-finite`: stable Schubert representatives, finite-rank
   specialization, basis uniqueness, and finite support for the coefficient.
-/
axiom lam_shimozono_stable_finite_comparison :
    ∀ u v w : Perm,
      ∃ n : Nat, 0 < n ∧
        StableCoeff u v w = FiniteTwistedCoeff n u v w

/- Manuscript Proposition `prop:stable-finite`, exposed under the paper label. -/
theorem stable_finite_comparison :
    ∀ u v w : Perm,
      ∃ n : Nat, 0 < n ∧
        StableCoeff u v w = FiniteTwistedCoeff n u v w := by
  exact lam_shimozono_stable_finite_comparison

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

/- External/standard intersection-theoretic input used in manuscript
   Proposition `prop:incidence-expression`: Mihalcea's projection formula,
   equivariant pushforward compatibility for cycles, and equivariant Poincare
   duality, all translated to the coefficient form used below.
-/
axiom mihalcea_projection_duality_coefficient :
    ∀ (n : Nat) (u v w : Perm) (d : Degree),
      TwistedGWCoeff n u v w d = IncidenceCycleCoeff n u v w d

/- Manuscript Proposition `prop:incidence-expression`, coefficient form. -/
theorem incidence_expression_coefficient :
    ∀ (n : Nat) (u v w : Perm) (d : Degree),
      TwistedGWCoeff n u v w d = IncidenceCycleCoeff n u v w d := by
  exact mihalcea_projection_duality_coefficient

/- Effectivity part of manuscript Proposition `prop:invariance`.
   Geometric inputs: reduced incidence scheme from Theorem `thm:incidence` and
   proper pushforward preserving effective cycles.
-/
axiom incidence_cycle_effective :
    ∀ (n : Nat) (u v : Perm) (d : Degree),
      0 < n →
        EffectiveCycle (IncidenceCycle n u v d)

/- Invariance part of manuscript Proposition `prop:invariance`.
   Geometric inputs: equivariance of the evaluation maps, stability of
   `tau X_u` and `X_v`, and connectedness of `B^-(tau)`.
-/
axiom incidence_cycle_bminus_tau_invariant :
    ∀ (n : Nat) (u v : Perm) (d : Degree),
      0 < n →
        BminusTauInvariantCycle n (IncidenceCycle n u v d)

/- Manuscript Proposition `prop:invariance`, assembled from its two parts. -/
theorem incidence_cycle_effective_invariant :
    ∀ (n : Nat) (u v : Perm) (d : Degree),
      0 < n →
        EffectiveBminusTauInvariant n (IncidenceCycle n u v d) := by
  intro n u v d hn
  constructor
  · exact incidence_cycle_effective n u v d hn
  · exact incidence_cycle_bminus_tau_invariant n u v d hn

/- External Gao--Xiong refined Graham positivity, after the already-proved
   Lemma `lem:inversions` identifies their root cone with the manuscript's
   variables `t_i-y_j`.
-/
axiom gao_xiong_refined_graham_positive :
    ∀ (n : Nat) (Z : Cycle) (w : Perm),
      0 < n →
        EffectiveBminusTauInvariant n Z →
          CoeffPositive (SchubertCoeffOfCycle Z w)

/- Manuscript Proposition `prop:refined`, coefficient form. -/
theorem refined_graham_incidence_positive :
    ∀ (n : Nat) (u v w : Perm) (d : Degree),
      0 < n →
        CoeffPositive (IncidenceCycleCoeff n u v w d) := by
  intro n u v w d hn
  unfold IncidenceCycleCoeff
  apply gao_xiong_refined_graham_positive
  · exact hn
  · exact incidence_cycle_effective_invariant n u v d hn

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
