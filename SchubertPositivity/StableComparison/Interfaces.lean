import SchubertPositivity.StableComparison.Basic

/-!
Small Lam--Shimozono/Kim interfaces used to prove the stable-finite comparison.
-/

namespace SchubertPositivity
namespace StableComparison

opaque stableCoeff : Perm → Perm → Perm → QuantumPoly
opaque finiteTwistedCoeff : Nat → Perm → Perm → Perm → QuantumPoly

/- Lam--Shimozono finite support / triangularity input. -/
axiom LS_product_expansion_data :
    ∀ u v : Perm, StableExpansionData u v

/- The coefficient function in the support data is the stable product
coefficient. -/
axiom LS_expansion_coeff_eq :
    ∀ (u v z : Perm),
      (LS_product_expansion_data u v).coeff z = stableCoeff u v z

/- Finite specialization plus Kim-basis uniqueness: once the rank bounds all
objects and quantum variables, the finite twisted coefficient agrees with the
stable coefficient. -/
axiom Kim_finite_comparison_at_bound :
    ∀ (N : Nat) (u v w : Perm) (data : StableExpansionData u v),
      0 < N →
      PermInRank N u →
      PermInRank N v →
      PermInRank N w →
        stableCoeff u v w = finiteTwistedCoeff N u v w

theorem stable_finite_comparison_from_interfaces :
    ∀ u v w : Perm,
      ∃ n : Nat, 0 < n ∧
        stableCoeff u v w = finiteTwistedCoeff n u v w := by
  intro u v w
  let data := LS_product_expansion_data u v
  let n := comparisonBound u v w data
  refine ⟨n, comparisonBound_pos u v w data, ?_⟩
  apply Kim_finite_comparison_at_bound
  · exact comparisonBound_pos u v w data
  · exact u_in_comparisonBound u v w data
  · exact v_in_comparisonBound u v w data
  · exact w_in_comparisonBound u v w data

end StableComparison
end SchubertPositivity
