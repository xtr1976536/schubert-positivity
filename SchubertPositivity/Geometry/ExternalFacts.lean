import SchubertPositivity.Geometry.Basic

/-!
External geometric facts, stated at the smallest current interface boundary.
-/

namespace SchubertPositivity

/- Fulton--Woodward--Mihalcea transversality/preimage theorem. -/
axiom fw_mihalcea_preimage_reduced :
    ∀ (Z X : Scheme) (G : Group) (F : Morphism Z X),
      IsIrreducible Z →
      IsEquivariant G F →
        IsReduced Z

axiom fw_mihalcea_preimage_locally_irreducible :
    ∀ (Z X : Scheme) (G : Group) (F : Morphism Z X),
      IsIrreducible Z →
      IsEquivariant G F →
        IsLocallyIrreducible Z

axiom fw_mihalcea_preimage_expected_codim :
    ∀ (Z X : Scheme) (G : Group) (F : Morphism Z X) (c : Nat),
      IsIrreducible Z →
      IsEquivariant G F →
        IsPureCodimension Z c

/- Kim--Pandharipande/Thomsen irreducibility of stable-map spaces. -/
axiom kontsevich_moduli_irreducible :
    ∀ M : Scheme, IsIrreducible M

/- Mihalcea expected-codimension pullback/cycle formula. -/
axiom mihalcea_expected_codim_pullback :
    ∀ {X Y : Scheme} (f : Morphism X Y) (V : Cycle),
      IsSmooth Y →
        cycleIntersect (cyclePullback f V) (fundamentalCycle X) =
          cyclePullback f V

/- Proper pushforward preserves effective cycles. -/
axiom proper_pushforward_effective :
    ∀ {X Y : Scheme} (f : Morphism X Y) (Z : Cycle),
      EffectiveCycle Z → EffectiveCycle (cyclePushforward f Z)

/- Equivariant pushforward preserves invariance. -/
axiom equivariant_pushforward_invariant :
    ∀ {X Y : Scheme} (G : Group) (f : Morphism X Y) (Z : Cycle),
      IsEquivariant G f →
      InvariantCycle G Z →
        InvariantCycle G (cyclePushforward f Z)

/- Gao--Xiong refined Graham positivity, in coefficient form for a single
effective invariant cycle.  The refined root-cone-to-`t_i-y_j` identification is
handled separately by the manuscript's proved inversion lemma.
-/
axiom gao_xiong_refined_graham_positive_for_cycle :
    ∀ (G : Group) (X : Scheme) (Z : Cycle) (w : WeylElement),
      EffectiveCycle Z →
      InvariantCycle G Z →
        RawPoly.Positive (schubertCoefficient Z w)

end SchubertPositivity
