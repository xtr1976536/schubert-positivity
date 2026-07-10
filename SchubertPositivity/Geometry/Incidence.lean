import SchubertPositivity.Core
import SchubertPositivity.Geometry.Basic
import SchubertPositivity.Geometry.ExternalFacts

/-!
Incidence schemes and incidence cycles.

This file begins turning manuscript objects into definitions.  The geometric
carriers are still abstract, but the incidence cycle is already defined as the
proper pushforward of the incidence fundamental cycle along `ev₃`.
-/

namespace SchubertPositivity

opaque StableMapSpace : Nat → Degree → Scheme
opaque FlagVariety : Nat → Scheme
def FlagProduct (n : Nat) : Scheme :=
  productScheme (FlagVariety n) (FlagVariety n)

opaque incidenceP : Nat → Perm → WeylElement
opaque incidenceQ : Nat → Perm → WeylElement

def IncidenceCondition (n : Nat) (u v : Perm) : Scheme :=
  productSubscheme
    (schubertM (FlagVariety n) (incidenceP n u))
    (oppositeSchubertM (FlagVariety n) (incidenceQ n v))

opaque stableMapEv12 : (n : Nat) → (d : Degree) →
  Morphism (StableMapSpace n d) (FlagProduct n)

def IncidenceScheme (n : Nat) (u v : Perm) (d : Degree) : Scheme :=
  schemePreimage (stableMapEv12 n d) (IncidenceCondition n u v)

def incidenceInclusion (n : Nat) (u v : Perm) (d : Degree) :
  Morphism (IncidenceScheme n u v d) (StableMapSpace n d)
  := preimageInclusion (stableMapEv12 n d) (IncidenceCondition n u v)
opaque stableMapEv3 : (n : Nat) → (d : Degree) →
  Morphism (StableMapSpace n d) (FlagVariety n)

def ev3 (n : Nat) (u v : Perm) (d : Degree) :
  Morphism (IncidenceScheme n u v d) (FlagVariety n)
  := morphismComp (incidenceInclusion n u v d) (stableMapEv3 n d)

def IncidenceCycleGeom (n : Nat) (u v : Perm) (d : Degree) : Cycle :=
  cyclePushforward (ev3 n u v d) (fundamentalCycle (IncidenceScheme n u v d))

opaque IncidenceGroup : Nat → Group

structure IncidenceProperties
    (n : Nat) (u v : Perm) (d : Degree) : Prop where
  reduced : IsReduced (IncidenceScheme n u v d)
  locallyIrreducible : IsLocallyIrreducible (IncidenceScheme n u v d)
  pureCodim : ∃ c : Nat, IsPureCodimension (IncidenceScheme n u v d) c

axiom stableMapEv12_equivariant :
    ∀ (n : Nat) (d : Degree),
      IsEquivariant (IncidenceGroup n) (stableMapEv12 n d)

/- Manuscript Theorem `thm:incidence`, geometric-property part. -/
theorem incidence_theorem_properties :
    ∀ (n : Nat) (u v : Perm) (d : Degree),
      0 < n →
        IncidenceProperties n u v d := by
  intro n u v d _hn
  have hfw := fw_mihalcea_preimage
    (StableMapSpace n d)
    (FlagVariety n)
    (IncidenceGroup n)
    (stableMapEv12 n d)
    (incidenceP n u)
    (incidenceQ n v)
    (kontsevich_moduli_irreducible (StableMapSpace n d))
    (stableMapEv12_equivariant n d)
  constructor
  · exact hfw.reduced
  · exact hfw.locallyIrreducible
  · exact ⟨codimSchubertM (incidenceP n u) + weylLength (incidenceQ n v),
      hfw.pureCodim⟩

theorem incidenceSchemeReduced
    (n : Nat) (u v : Perm) (d : Degree) (hn : 0 < n) :
    IsReduced (IncidenceScheme n u v d) :=
  (incidence_theorem_properties n u v d hn).reduced

theorem incidenceFundamentalCycleEffective :
    ∀ (n : Nat) (u v : Perm) (d : Degree),
      0 < n →
        EffectiveCycle (fundamentalCycle (IncidenceScheme n u v d)) := by
  intro n u v d hn
  apply fundamental_cycle_effective_of_reduced
  exact incidenceSchemeReduced n u v d hn

/- Stability of the incidence scheme under the relevant group. -/
axiom incidenceConditionInvariant :
    ∀ (n : Nat) (u v : Perm) (d : Degree),
      0 < n →
        InvariantScheme (IncidenceGroup n) (IncidenceCondition n u v)

theorem incidenceSchemeInvariant :
    ∀ (n : Nat) (u v : Perm) (d : Degree),
      0 < n →
        InvariantScheme (IncidenceGroup n) (IncidenceScheme n u v d) := by
  intro n u v d hn
  unfold IncidenceScheme
  apply invariant_preimage_of_equivariant
  · exact stableMapEv12_equivariant n d
  · exact incidenceConditionInvariant n u v d hn

theorem incidenceFundamentalCycleInvariant :
    ∀ (n : Nat) (u v : Perm) (d : Degree),
      0 < n →
        InvariantCycle (IncidenceGroup n)
          (fundamentalCycle (IncidenceScheme n u v d)) := by
  intro n u v d hn
  apply fundamental_cycle_invariant_of_invariant_scheme
  exact incidenceSchemeInvariant n u v d hn

theorem incidenceInclusion_equivariant :
    ∀ (n : Nat) (u v : Perm) (d : Degree),
      IsEquivariant (IncidenceGroup n) (incidenceInclusion n u v d) := by
  intro n u v d
  unfold incidenceInclusion
  apply preimage_inclusion_equivariant
  exact stableMapEv12_equivariant n d

axiom stableMapEv3_equivariant :
    ∀ (n : Nat) (d : Degree),
      IsEquivariant (IncidenceGroup n) (stableMapEv3 n d)

theorem ev3_equivariant :
    ∀ (n : Nat) (u v : Perm) (d : Degree),
      IsEquivariant (IncidenceGroup n) (ev3 n u v d) := by
  intro n u v d
  unfold ev3
  apply equivariant_comp
  · exact incidenceInclusion_equivariant n u v d
  · exact stableMapEv3_equivariant n d

theorem incidenceCycleGeom_effective
    (n : Nat) (u v : Perm) (d : Degree) (hn : 0 < n) :
    EffectiveCycle (IncidenceCycleGeom n u v d) := by
  unfold IncidenceCycleGeom
  apply proper_pushforward_effective
  exact incidenceFundamentalCycleEffective n u v d hn

theorem incidenceCycleGeom_invariant
    (n : Nat) (u v : Perm) (d : Degree) (hn : 0 < n) :
    InvariantCycle (IncidenceGroup n) (IncidenceCycleGeom n u v d) := by
  unfold IncidenceCycleGeom
  apply equivariant_pushforward_invariant
  · exact ev3_equivariant n u v d
  · exact incidenceFundamentalCycleInvariant n u v d hn

end SchubertPositivity
