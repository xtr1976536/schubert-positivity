import Std

/-!
A concrete finite-support replacement sketch for the abstract
`Coeff`/`CoeffPositive` layer in `ExternalTheorems.lean`.

This file is intentionally not imported by the main development yet.  It keeps
the dependency footprint at `Std` and gives a small executable model of:

* coefficients as sparse polynomials with integer coefficients;
* positivity as coefficientwise nonnegativity;
* quantum polynomials/series as finite lists of degree-indexed coefficients;
* extraction of the coefficient at a fixed quantum degree by finite summation.

The main bridge lemma is
`QuantumSeries.degreewise_positive_implies_quantum_positive`.
-/

namespace SchubertPositivity

/-- A monomial is represented by an exponent vector.  The intended variables
can later be specialized to the manuscript's `t_i - y_j` variables. -/
abbrev Monomial : Type := List Nat

/-- Sparse integer polynomial.  Repeated monomials are allowed in this draft;
`add` is therefore just concatenation of sparse terms. -/
structure SparsePoly where
  terms : List (Monomial × Int)
deriving Repr, BEq

namespace SparsePoly

/-- Coefficientwise nonnegativity for the sparse representation. -/
def Positive (p : SparsePoly) : Prop :=
  ∀ term ∈ p.terms, 0 ≤ term.2

def zero : SparsePoly :=
  { terms := [] }

/-- Addition in the sparse presentation.  Normalization can be added later
without changing the positivity interface. -/
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
  | inl hmem =>
      exact hp term hmem
  | inr hmem =>
      exact hq term hmem

end SparsePoly

/-- A single finite-support quantum term.  Degrees are concrete natural
numbers here; if the manuscript later needs multidegrees, replace this field
with `List Nat` and keep the same fold-based proof shape. -/
structure QuantumTerm where
  degree : Nat
  coeff : SparsePoly
deriving Repr, BEq

/-- A finite-support quantum polynomial/series represented by its nonzero
degree terms.  Repeated degrees are permitted and are summed by `coeffAt`. -/
structure QuantumSeries where
  terms : List QuantumTerm
deriving Repr, BEq

namespace QuantumSeries

/-- Every stored degree coefficient is positive. -/
def DegreewisePositive (Q : QuantumSeries) : Prop :=
  ∀ term ∈ Q.terms, term.coeff.Positive

/-- The coefficient at a fixed quantum degree, computed by finite summation. -/
def coeffAt (Q : QuantumSeries) (d : Nat) : SparsePoly :=
  Q.terms.foldl
    (fun acc term =>
      if term.degree = d then SparsePoly.add acc term.coeff else acc)
    SparsePoly.zero

/-- Positivity of the whole finite-support quantum polynomial, after extracting
the coefficient at any quantum degree. -/
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

/-- Concrete replacement for the current definition-level positivity step:
if each finite degree coefficient is coefficientwise nonnegative, then the
finite-support quantum polynomial lies in the positive cone. -/
theorem degreewise_positive_implies_quantum_positive
    (Q : QuantumSeries) :
    Q.DegreewisePositive → Q.InPositiveCone := by
  intro hQ d
  unfold InPositiveCone coeffAt
  exact coeffAt_fold_positive d Q.terms SparsePoly.zero
    SparsePoly.zero_positive hQ

end QuantumSeries

end SchubertPositivity
