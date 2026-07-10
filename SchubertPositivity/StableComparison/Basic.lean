import Std
import SchubertPositivity.Core
import SchubertPositivity.PositivePolynomials

/-!
Stable-to-finite comparison bookkeeping.

This module isolates the combinatorial bookkeeping in manuscript Proposition
`prop:stable-finite`: choose a finite rank large enough that no appearing
permutation or quantum variable is truncated.
-/

namespace SchubertPositivity
namespace StableComparison

abbrev QuantumPoly : Type := Degree → RawPoly

opaque permRankBound : Perm → Nat
opaque quantumVariableBound : QuantumPoly → Nat

def PermInRank (N : Nat) (w : Perm) : Prop :=
  permRankBound w ≤ N

structure StableExpansionData (u v : Perm) where
  support : List Perm
  qBound : Nat
  coeff : Perm → QuantumPoly
  support_complete : ∀ z : Perm, coeff z ≠ (fun _ => RawPoly.zero) → z ∈ support
  coeff_qBound : ∀ z : Perm, quantumVariableBound (coeff z) ≤ qBound

def listNatMax : List Nat → Nat
  | [] => 0
  | n :: ns => max n (listNatMax ns)

theorem le_listNatMax_of_mem {xs : List Nat} {x : Nat}
    (h : x ∈ xs) : x ≤ listNatMax xs := by
  induction xs with
  | nil => cases h
  | cons y ys ih =>
      simp [listNatMax] at h ⊢
      rcases h with hxy | hmem
      · omega
      · have hy := ih hmem
        omega

def supportRankBound (xs : List Perm) : Nat :=
  listNatMax (xs.map permRankBound)

theorem rank_le_supportRankBound_of_mem {xs : List Perm} {w : Perm}
    (h : w ∈ xs) : permRankBound w ≤ supportRankBound xs := by
  unfold supportRankBound
  apply le_listNatMax_of_mem
  exact List.mem_map_of_mem permRankBound h

def comparisonBound (u v w : Perm) (data : StableExpansionData u v) : Nat :=
  max 1
    (max (permRankBound u)
      (max (permRankBound v)
        (max (permRankBound w)
          (max (supportRankBound data.support) data.qBound))))

theorem comparisonBound_pos (u v w : Perm) (data : StableExpansionData u v) :
    0 < comparisonBound u v w data := by
  unfold comparisonBound
  omega

theorem u_in_comparisonBound (u v w : Perm) (data : StableExpansionData u v) :
    PermInRank (comparisonBound u v w data) u := by
  unfold PermInRank comparisonBound
  omega

theorem v_in_comparisonBound (u v w : Perm) (data : StableExpansionData u v) :
    PermInRank (comparisonBound u v w data) v := by
  unfold PermInRank comparisonBound
  omega

theorem w_in_comparisonBound (u v w : Perm) (data : StableExpansionData u v) :
    PermInRank (comparisonBound u v w data) w := by
  unfold PermInRank comparisonBound
  omega

theorem qBound_le_comparisonBound (u v w : Perm) (data : StableExpansionData u v) :
    data.qBound ≤ comparisonBound u v w data := by
  unfold comparisonBound
  omega

theorem support_in_comparisonBound {u v w z : Perm}
    (data : StableExpansionData u v)
    (hz : z ∈ data.support) :
    PermInRank (comparisonBound u v w data) z := by
  unfold PermInRank comparisonBound
  have hzle := rank_le_supportRankBound_of_mem hz
  omega

end StableComparison
end SchubertPositivity
