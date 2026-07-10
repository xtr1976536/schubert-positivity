import SchubertPositivity.StableComparison.Basic

/-!
Bookkeeping for finite specialization.

The real Lam--Shimozono finite specialization sends variables above a chosen
rank to zero.  This file isolates only the formal consequence used in
`prop:stable-finite`: if every variable occurring in a coefficient is bounded by
the rank, specialization leaves that coefficient unchanged.
-/

namespace SchubertPositivity
namespace StableComparison

def Monomial.BoundedBy (N : Nat) (m : Monomial) : Prop :=
  ∀ i ∈ m, i ≤ N

theorem Monomial.variableBound_controls_terms
    (N : Nat) (m : Monomial) :
    Monomial.variableBound m ≤ N →
      Monomial.BoundedBy N m := by
  intro hm i hi
  unfold Monomial.variableBound at hm
  have hiBound := le_listNatMax_of_mem hi
  omega

opaque specializeMonomial : Nat → Monomial → Monomial

/- The only primitive specialization input retained at this layer.  It says
that a bounded monomial is unchanged by finite-rank specialization. -/
axiom specialization_act_on_bounded_monomial :
    ∀ (N : Nat) (m : Monomial),
      Monomial.BoundedBy N m →
        specializeMonomial N m = m

def specializeRawPoly (N : Nat) (p : RawPoly) : RawPoly :=
  p.map fun term => (term.1, specializeMonomial N term.2)

def RawPoly.BoundedBy (N : Nat) (p : RawPoly) : Prop :=
  ∀ term ∈ p, Monomial.BoundedBy N term.2

theorem RawPoly.variableBound_controls_terms
    (N : Nat) (p : RawPoly) :
    RawPoly.variableBound p ≤ N →
      RawPoly.BoundedBy N p := by
  intro hp term hterm
  apply Monomial.variableBound_controls_terms N term.2
  unfold RawPoly.variableBound at hp
  have htermBound : Monomial.variableBound term.2 ≤
      listNatMax (p.map fun term => Monomial.variableBound term.2) := by
    apply le_listNatMax_of_mem
    exact List.mem_map_of_mem (fun term => Monomial.variableBound term.2) hterm
  omega

theorem specializeRawPoly_eq_self_of_bounded
    (N : Nat) (p : RawPoly) :
    RawPoly.BoundedBy N p →
      specializeRawPoly N p = p := by
  intro hp
  induction p with
  | nil =>
      rfl
  | cons term rest ih =>
      have hterm : Monomial.BoundedBy N term.2 := hp term (by simp)
      have hrest : RawPoly.BoundedBy N rest := by
        intro term' hmem
        exact hp term' (List.mem_cons_of_mem term hmem)
      simp [specializeRawPoly, specialization_act_on_bounded_monomial N term.2 hterm,
        ih hrest]

def specializeQuantumPoly (N : Nat) (P : QuantumPoly) : QuantumPoly :=
  fun d => specializeRawPoly N (P d)

def QuantumPoly.BoundedBy (N : Nat) (P : QuantumPoly) : Prop :=
  ∀ d : Degree, RawPoly.BoundedBy N (P d)

theorem QuantumPoly.boundedBy_of_coeff_variableBound
    (N : Nat) (P : QuantumPoly) :
    (∀ d : Degree, RawPoly.variableBound (P d) ≤ N) →
      QuantumPoly.BoundedBy N P := by
  intro hP d
  exact RawPoly.variableBound_controls_terms N (P d) (hP d)

theorem specializeQuantumPoly_eq_self_of_bounded
    (N : Nat) (P : QuantumPoly) :
    QuantumPoly.BoundedBy N P →
      specializeQuantumPoly N P = P := by
  intro hP
  funext d
  exact specializeRawPoly_eq_self_of_bounded N (P d) (hP d)

end StableComparison
end SchubertPositivity
