import Std

/-!
Finite-support quantum series and coefficientwise positivity.

This module is deliberately elementary: it uses only lists and integers.  It is
the algebraic bookkeeping layer behind the manuscript's step from positivity of
each Gromov-Witten coefficient to positivity of the finite quantum coefficient.
-/

namespace SchubertPositivity
namespace FiniteSupport

/-- A monomial is represented by an exponent vector. -/
abbrev Monomial : Type := List Nat

/-- Sparse integer polynomial. Repeated monomials are allowed. -/
structure SparsePoly where
  terms : List (Monomial × Int)
deriving Repr, BEq

namespace SparsePoly

def Positive (p : SparsePoly) : Prop :=
  ∀ term ∈ p.terms, 0 ≤ term.2

def zero : SparsePoly :=
  { terms := [] }

def add (p q : SparsePoly) : SparsePoly :=
  { terms := p.terms ++ q.terms }

theorem zero_positive : Positive zero := by
  intro term hterm
  simp [zero] at hterm

theorem add_positive {p q : SparsePoly}
    (hp : Positive p) (hq : Positive q) : Positive (add p q) := by
  intro term hterm
  simp [add] at hterm
  cases hterm with
  | inl hmem => exact hp term hmem
  | inr hmem => exact hq term hmem

end SparsePoly

structure QuantumTerm where
  degree : Nat
  coeff : SparsePoly
deriving Repr, BEq

structure QuantumSeries where
  terms : List QuantumTerm
deriving Repr, BEq

namespace QuantumSeries

def DegreewisePositive (Q : QuantumSeries) : Prop :=
  ∀ term ∈ Q.terms, term.coeff.Positive

def coeffAt (Q : QuantumSeries) (d : Nat) : SparsePoly :=
  Q.terms.foldl
    (fun acc term =>
      if term.degree = d then SparsePoly.add acc term.coeff else acc)
    SparsePoly.zero

def InPositiveCone (Q : QuantumSeries) : Prop :=
  ∀ d : Nat, (Q.coeffAt d).Positive

private theorem coeffAt_fold_positive (d : Nat) :
    ∀ (terms : List QuantumTerm) (acc : SparsePoly),
      acc.Positive →
      (∀ term ∈ terms, term.coeff.Positive) →
        (terms.foldl
          (fun acc term =>
            if term.degree = d then SparsePoly.add acc term.coeff else acc)
          acc).Positive := by
  intro terms
  induction terms with
  | nil =>
      intro acc hacc _hterms
      simpa using hacc
  | cons term rest ih =>
      intro acc hacc hterms
      apply ih
      · by_cases hdeg : term.degree = d
        · simp [hdeg]
          exact SparsePoly.add_positive hacc (hterms term (by simp))
        · simpa [hdeg] using hacc
      · intro term' hmem
        exact hterms term' (List.mem_cons_of_mem term hmem)

theorem degreewise_positive_implies_quantum_positive
    (Q : QuantumSeries) :
    Q.DegreewisePositive → Q.InPositiveCone := by
  intro hQ d
  unfold InPositiveCone coeffAt
  exact coeffAt_fold_positive d Q.terms SparsePoly.zero
    SparsePoly.zero_positive hQ

end QuantumSeries
end FiniteSupport
end SchubertPositivity
