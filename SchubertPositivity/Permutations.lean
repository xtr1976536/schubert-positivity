import Std

/-!
Finite permutation computations for the Schubert positivity manuscript.

We use `Fin m -> Fin m` rather than mathlib permutations, because the first
formalization target is only the explicit block-swap computation.
-/

namespace SchubertPositivity

def tau (n : Nat) : Fin (2*n) → Fin (2*n) :=
  fun i =>
    if h : (i : Nat) < n then
      ⟨(i : Nat) + n, by
        have hi : (i : Nat) < n := h
        omega⟩
    else
      ⟨(i : Nat) - n, by
        have hi2 : (i : Nat) < 2*n := i.isLt
        omega⟩

def a0 (n : Nat) : Fin (2*n) → Fin (2*n) :=
  fun i =>
    if h : (i : Nat) < n then
      i
    else
      ⟨3*n - 1 - (i : Nat), by
        have hi2 : (i : Nat) < 2*n := i.isLt
        omega⟩

def w0 (m : Nat) : Fin m → Fin m :=
  fun i => ⟨m - 1 - (i : Nat), by
    have hi : (i : Nat) < m := i.isLt
    omega⟩

/- The pointwise statement of `a0^{-1} tau a0 = w0`.
   Since `a0` is an involution, this is written as `a0 (tau (a0 i)) = w0 i`.
-/
theorem a0_tau_a0_eq_w0 (n : Nat) (hn : 0 < n) (i : Fin (2*n)) :
    a0 n (tau n (a0 n i)) = w0 (2*n) i := by
  apply Fin.ext
  simp [a0, tau, w0]
  split_ifs with h1 h2 h3 <;> omega

def inInversionSet {m : Nat} (w : Fin m → Fin m) (p q : Fin m) : Prop :=
  (p : Nat) < (q : Nat) ∧ (w p : Nat) > (w q : Nat)

theorem tau_inversion_forward (n : Nat) (hn : 0 < n)
    (p q : Fin (2*n)) :
    inInversionSet (tau n) p q →
      (p : Nat) < n ∧ n ≤ (q : Nat) := by
  intro h
  rcases h with ⟨hpq, hgt⟩
  simp [tau] at hgt
  split_ifs at hgt with hp hq <;> omega

theorem tau_inversion_backward (n : Nat) (hn : 0 < n)
    (p q : Fin (2*n)) :
    (p : Nat) < n → n ≤ (q : Nat) → (p : Nat) < (q : Nat) →
      inInversionSet (tau n) p q := by
  intro hp hq hpq
  constructor
  · exact hpq
  · simp [tau]
    split_ifs with hp' hq' <;> omega

end SchubertPositivity
