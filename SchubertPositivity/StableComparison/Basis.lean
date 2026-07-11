import SchubertPositivity.StableComparison.Basic

/-!
Generic coefficient uniqueness for a chosen basis expansion.

This file contains no Schubert geometry.  It records the elementary fact used
in the finite Kim quotient: if two coefficient functions give the same basis
expansion, then their coefficients are equal term by term.
-/

namespace SchubertPositivity
namespace StableComparison

structure BasisExpansion (ι R M : Type) where
  basisVec : ι → M
  coeff : M → ι → R
  linearCombination : (ι → R) → M
  coeff_linearCombination :
    ∀ (F : ι → R) (i : ι), coeff (linearCombination F) i = F i

namespace BasisExpansion

theorem coefficients_eq_of_expansion_eq
    {ι R M : Type} (B : BasisExpansion ι R M)
    {F G : ι → R}
    (h : B.linearCombination F = B.linearCombination G)
    (i : ι) :
    F i = G i := by
  have hcoeff :
      B.coeff (B.linearCombination F) i =
        B.coeff (B.linearCombination G) i := by
    rw [h]
  rw [B.coeff_linearCombination F i, B.coeff_linearCombination G i] at hcoeff
  exact hcoeff

end BasisExpansion

end StableComparison
end SchubertPositivity
