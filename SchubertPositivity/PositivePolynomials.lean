import Std

/-!
A small concrete positive-cone model.

This file does not try to build a quotient polynomial ring.  It records the
piece of algebra needed by the manuscript's final positivity argument:
coefficients are positive if they admit an expression as a finite sum of
positive monomials, and this property is stable under the operations used in
finite quantum expansions.
-/

namespace SchubertPositivity

/-- A monomial is represented by the list of variables occurring in it. -/
abbrev Monomial := List Nat

/-- A raw polynomial is a finite signed list of monomials. -/
abbrev RawPoly := List (Int × Monomial)

def monomialMul (m₁ m₂ : Monomial) : Monomial :=
  m₁ ++ m₂

def RawPoly.zero : RawPoly :=
  []

def RawPoly.add (p q : RawPoly) : RawPoly :=
  p ++ q

def RawPoly.monomial (m : Monomial) : RawPoly :=
  [(1, m)]

def RawPoly.mul (p q : RawPoly) : RawPoly :=
  p.bind fun t₁ =>
    q.map fun t₂ =>
      (t₁.1 * t₂.1, monomialMul t₁.2 t₂.2)

def positiveRepresentation (ms : List Monomial) : RawPoly :=
  ms.map fun m => (1, m)

def RawPoly.Positive (p : RawPoly) : Prop :=
  ∃ ms : List Monomial, positiveRepresentation ms = p

theorem RawPoly.zero_positive : RawPoly.Positive RawPoly.zero := by
  refine ⟨[], ?_⟩
  rfl

theorem RawPoly.monomial_positive (m : Monomial) :
    RawPoly.Positive (RawPoly.monomial m) := by
  refine ⟨[m], ?_⟩
  rfl

theorem positiveRepresentation_append (ms ns : List Monomial) :
    positiveRepresentation (ms ++ ns) =
      RawPoly.add (positiveRepresentation ms) (positiveRepresentation ns) := by
  simp [positiveRepresentation, RawPoly.add]

theorem RawPoly.add_positive {p q : RawPoly}
    (hp : RawPoly.Positive p) (hq : RawPoly.Positive q) :
    RawPoly.Positive (RawPoly.add p q) := by
  rcases hp with ⟨ms, rfl⟩
  rcases hq with ⟨ns, rfl⟩
  refine ⟨ms ++ ns, ?_⟩
  exact positiveRepresentation_append ms ns

def positiveProductRepresentation (ms ns : List Monomial) : List Monomial :=
  ms.bind fun m => ns.map fun n => monomialMul m n

theorem positiveRepresentation_product (ms ns : List Monomial) :
    positiveRepresentation (positiveProductRepresentation ms ns) =
      RawPoly.mul (positiveRepresentation ms) (positiveRepresentation ns) := by
  simp [positiveProductRepresentation, positiveRepresentation, RawPoly.mul,
    monomialMul]

theorem RawPoly.mul_positive {p q : RawPoly}
    (hp : RawPoly.Positive p) (hq : RawPoly.Positive q) :
    RawPoly.Positive (RawPoly.mul p q) := by
  rcases hp with ⟨ms, rfl⟩
  rcases hq with ⟨ns, rfl⟩
  refine ⟨positiveProductRepresentation ms ns, ?_⟩
  exact positiveRepresentation_product ms ns

/-- A degree-indexed quantum series, represented extensionally. -/
abbrev QuantumSeries (Degree : Type) : Type :=
  Degree → RawPoly

def QuantumSeries.Positive {Degree : Type} (F : QuantumSeries Degree) : Prop :=
  ∀ d : Degree, RawPoly.Positive (F d)

theorem quantumSeries_positive_of_coefficients {Degree : Type}
    (F : QuantumSeries Degree)
    (h : ∀ d : Degree, RawPoly.Positive (F d)) :
    QuantumSeries.Positive F := by
  exact h

end SchubertPositivity
