import SchubertPositivity.ExternalTheorems
import SchubertPositivity.Permutations

/-!
Lean skeleton for the final positivity theorem.

This file mirrors the last proof of the manuscript.  The finite block-swap
combinatorics imported from `Permutations` is already proved without `sorry`.
The remaining imported assumptions are named interfaces for external geometric
or polynomial results.
-/

namespace SchubertPositivity

theorem quantum_positivity_main :
    ∀ u v w : Perm, InPositiveCone (StableCoeff u v w) := by
  intro u v w
  rcases stable_finite_comparison u v w with ⟨n, hn, hstable⟩
  rw [hstable]
  apply coefficient_gw_preserves_positivity
  intro d
  exact twisted_gw_positive n u v w d hn

end SchubertPositivity
