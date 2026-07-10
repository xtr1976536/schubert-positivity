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

/- Manuscript Lemma `lem:conjugation`, permutation-computation part. -/
theorem manuscript_lem_conjugation_permutation
    (n : Nat) (hn : 0 < n) :
    ∀ i : Fin (2*n), a0 n (tau n (a0 n i)) = w0 (2*n) i := by
  intro i
  exact a0_tau_a0_eq_w0 n hn i

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

theorem tau_inversion_iff (n : Nat) (hn : 0 < n)
    (p q : Fin (2*n)) :
    inInversionSet (tau n) p q ↔
      (p : Nat) < n ∧ n ≤ (q : Nat) ∧ (p : Nat) < (q : Nat) := by
  constructor
  · intro h
    rcases h with ⟨hpq, hgt⟩
    have hblock := tau_inversion_forward n hn p q ⟨hpq, hgt⟩
    exact ⟨hblock.1, hblock.2, hpq⟩
  · intro h
    exact tau_inversion_backward n hn p q h.1 h.2.1 h.2.2

def tauInversionRectangle (n : Nat) : List (Fin (2*n) × Fin (2*n)) :=
  (List.finRange n).bind fun p =>
    (List.finRange n).map fun r =>
      (⟨(p : Nat), by
          have hp : (p : Nat) < n := p.isLt
          omega⟩,
       ⟨n + (r : Nat), by
          have hr : (r : Nat) < n := r.isLt
          omega⟩)

theorem tauInversionRectangle_length (n : Nat) :
    (tauInversionRectangle n).length = n * n := by
  simp [tauInversionRectangle]

theorem tauInversionRectangle_mem_iff (n : Nat) (hn : 0 < n)
    (p q : Fin (2*n)) :
    (p, q) ∈ tauInversionRectangle n ↔ inInversionSet (tau n) p q := by
  constructor
  · intro h
    simp [tauInversionRectangle] at h
    rcases h with ⟨p0, hp0, r0, hr0, hpq⟩
    rcases hpq with ⟨hp, hq⟩
    subst hp
    subst hq
    apply tau_inversion_backward n hn
    · exact p0.isLt
    · omega
    · have hp0lt : (p0 : Nat) < n := p0.isLt
      omega
  · intro h
    have hiff := (tau_inversion_iff n hn p q).mp h
    rcases hiff with ⟨hp, hq, hpq⟩
    simp [tauInversionRectangle]
    refine ⟨⟨(p : Nat), hp⟩, by simp, ⟨(q : Nat) - n, ?_⟩, by simp, ?_⟩
    · have hq2 : (q : Nat) < 2*n := q.isLt
      omega
    · apply Prod.ext
      · apply Fin.ext
        simp
      · apply Fin.ext
        simp
        omega

/- Manuscript Lemma `lem:inversions`, finite-index form. -/
theorem manuscript_lem_inversions
    (n : Nat) (hn : 0 < n) (p q : Fin (2*n)) :
    inInversionSet (tau n) p q ↔
      (p : Nat) < n ∧ n ≤ (q : Nat) ∧ (p : Nat) < (q : Nat) := by
  exact tau_inversion_iff n hn p q

/- Manuscript Lemma `lem:inversions`, counted rectangle form. -/
theorem manuscript_lem_inversions_count (n : Nat) :
    (tauInversionRectangle n).length = n * n := by
  exact tauInversionRectangle_length n

end SchubertPositivity
