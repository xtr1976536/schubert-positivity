import SchubertPositivity.StableComparison.Specialization

/-!
Small Lam--Shimozono/Kim interfaces used to prove the stable-finite comparison.
-/

namespace SchubertPositivity
namespace StableComparison

opaque stableCoeff : Perm → Perm → Perm → QuantumPoly
opaque finiteTwistedCoeff : Nat → Perm → Perm → Perm → QuantumPoly
opaque finiteProductCoeff : Nat → Perm → Perm → Perm → QuantumPoly

def specializedStableCoeff (N : Nat) (u v w : Perm) : QuantumPoly :=
  specializeQuantumPoly N (stableCoeff u v w)

/- A computed coefficient bound controls the actual variable support of the
polynomial.  The only remaining Lam--Shimozono input is that the stable
expansion data stores a `qBound` above these computed coefficient bounds. -/
theorem quantumVariableBound_bounds_terms :
    ∀ (N : Nat) (P : QuantumPoly),
      (∀ d : Degree, RawPoly.variableBound (P d) ≤ N) →
        QuantumPoly.BoundedBy N P
    := by
  intro N P hP
  exact QuantumPoly.boundedBy_of_coeff_variableBound N P hP

/- Lam--Shimozono finite support / triangularity input. -/
axiom LS_product_expansion_data :
    ∀ u v : Perm, StableExpansionData u v

/- The coefficient function in the support data is the stable product
coefficient. -/
axiom LS_expansion_coeff_eq :
    ∀ (u v z : Perm),
      (LS_product_expansion_data u v).coeff z = stableCoeff u v z

/- Finite specialization does not change bounded stable coefficients.  This is
the part of Proposition `prop:stable-finite` where `sp_N^{qa}` kills no
appearing `x`, `a`, or `q` variable.  The proof is now pure bookkeeping from
the monomial-level specialization interface in `Specialization.lean`. -/
theorem finite_specialization_preserves_bounded_terms :
    ∀ (N : Nat) (u v w : Perm) (data : StableExpansionData u v),
      0 < N →
      PermInRank N u →
      PermInRank N v →
      PermInRank N w →
      data.coeff w = stableCoeff u v w →
      data.qBound ≤ N →
        stableCoeff u v w = specializedStableCoeff N u v w
    := by
  intro N u v w data _hN _hu _hv _hw hcoeff hq
  unfold specializedStableCoeff
  rw [← hcoeff]
  exact (specializeQuantumPoly_eq_self_of_bounded N (data.coeff w)
    (quantumVariableBound_bounds_terms N (data.coeff w)
      (fun d => Nat.le_trans (data.coeff_qBound w d) hq))).symm

/- Lam--Shimozono stability identifies the specialized stable product with the
finite product in the Kim quotient at the same rank. -/
axiom stable_product_specializes_to_finite_product :
    ∀ (N : Nat) (u v w : Perm) (data : StableExpansionData u v),
      0 < N →
      PermInRank N u →
      PermInRank N v →
      PermInRank N w →
      data.qBound ≤ N →
        specializedStableCoeff N u v w = finiteProductCoeff N u v w

/- Kim's quantum Schubert classes form a basis, so two finite quotient
expansions with the same product have identical coefficients. -/
axiom kim_basis_unique_coefficients :
    ∀ (N : Nat) (u v w : Perm),
      0 < N →
      PermInRank N u →
      PermInRank N v →
      PermInRank N w →
        finiteProductCoeff N u v w = finiteTwistedCoeff N u v w

/- The former one-step finite comparison is now an internal theorem obtained by
chaining finite specialization, product identification, and Kim-basis
uniqueness. -/
theorem Kim_finite_comparison_at_bound :
    ∀ (N : Nat) (u v w : Perm) (data : StableExpansionData u v),
      0 < N →
      PermInRank N u →
      PermInRank N v →
      PermInRank N w →
      data.coeff w = stableCoeff u v w →
      data.qBound ≤ N →
        stableCoeff u v w = finiteTwistedCoeff N u v w
    := by
  intro N u v w data hN hu hv hw hcoeff hq
  calc
    stableCoeff u v w = specializedStableCoeff N u v w :=
      finite_specialization_preserves_bounded_terms N u v w data hN hu hv hw hcoeff hq
    _ = finiteProductCoeff N u v w :=
      stable_product_specializes_to_finite_product N u v w data hN hu hv hw hq
    _ = finiteTwistedCoeff N u v w :=
      kim_basis_unique_coefficients N u v w hN hu hv hw

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
  · exact LS_expansion_coeff_eq u v w
  · exact qBound_le_comparisonBound u v w data

end StableComparison
end SchubertPositivity
