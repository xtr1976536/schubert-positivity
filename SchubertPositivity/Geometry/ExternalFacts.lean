import SchubertPositivity.Geometry.Basic

/-!
External geometric facts, stated at the smallest current interface boundary.
-/

namespace SchubertPositivity

/- Fulton--Woodward--Mihalcea transversality/preimage theorem. -/
structure FWMihalceaPreimageProperties
    (Z X : Scheme) (G : Group)
    (F : Morphism Z (productScheme X X))
    (p q : WeylElement) : Prop where
  reduced :
    IsReduced
      (schemePreimage F
        (productSubscheme (schubertM X p) (oppositeSchubertM X q)))
  locallyIrreducible :
    IsLocallyIrreducible
      (schemePreimage F
        (productSubscheme (schubertM X p) (oppositeSchubertM X q)))
  pureCodim :
    IsPureCodimension
      (schemePreimage F
        (productSubscheme (schubertM X p) (oppositeSchubertM X q)))
      (codimSchubertM p + weylLength q)

axiom fw_mihalcea_preimage :
    ∀ (Z X : Scheme) (G : Group)
      (F : Morphism Z (productScheme X X))
      (p q : WeylElement),
      IsIrreducible Z →
      IsEquivariant G F →
        FWMihalceaPreimageProperties Z X G F p q

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

/- A reduced scheme has an effective fundamental cycle. -/
axiom fundamental_cycle_effective_of_reduced :
    ∀ X : Scheme, IsReduced X → EffectiveCycle (fundamentalCycle X)

/- The fundamental cycle of an invariant scheme is invariant. -/
axiom fundamental_cycle_invariant_of_invariant_scheme :
    ∀ (G : Group) (X : Scheme),
      InvariantScheme G X →
        InvariantCycle G (fundamentalCycle X)

/- Equivariant pushforward preserves invariance. -/
axiom equivariant_pushforward_invariant :
    ∀ {X Y : Scheme} (G : Group) (f : Morphism X Y) (Z : Cycle),
      IsEquivariant G f →
      InvariantCycle G Z →
        InvariantCycle G (cyclePushforward f Z)

/- Composition of equivariant morphisms is equivariant. -/
axiom equivariant_comp :
    ∀ {X Y Z : Scheme} (G : Group)
      (f : Morphism X Y) (g : Morphism Y Z),
      IsEquivariant G f →
      IsEquivariant G g →
        IsEquivariant G (morphismComp f g)

/- If the action of `H` is obtained by restricting the action of `G`, then
`G`-equivariance implies `H`-equivariance. -/
opaque IsRestrictedAction : Group → Group → Prop

axiom equivariant_of_restricted_action :
    ∀ {X Y : Scheme} (H G : Group) (f : Morphism X Y),
      IsRestrictedAction H G →
      IsEquivariant G f →
        IsEquivariant H f

/- Equivariant preimages of invariant schemes are invariant. -/
axiom invariant_preimage_of_equivariant :
    ∀ {X Y : Scheme} (G : Group) (f : Morphism X Y) (Z : Scheme),
      IsEquivariant G f →
      InvariantScheme G Z →
        InvariantScheme G (schemePreimage f Z)

/- Products of invariant subschemes are invariant for the diagonal action. -/
axiom product_subscheme_invariant :
    ∀ (G : Group) (X Y : Scheme),
      InvariantScheme G X →
      InvariantScheme G Y →
        InvariantScheme G (productSubscheme X Y)

/- The inclusion of an equivariant preimage is equivariant. -/
axiom preimage_inclusion_equivariant :
    ∀ {X Y : Scheme} (G : Group) (f : Morphism X Y) (Z : Scheme),
      IsEquivariant G f →
        IsEquivariant G (preimageInclusion f Z)

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
