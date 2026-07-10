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
opaque IncidenceScheme : Nat → Perm → Perm → Degree → Scheme
opaque ev3 : (n : Nat) → (u v : Perm) → (d : Degree) →
  Morphism (IncidenceScheme n u v d) (StableMapSpace n d)

def IncidenceCycleGeom (n : Nat) (u v : Perm) (d : Degree) : Cycle :=
  cyclePushforward (ev3 n u v d) (fundamentalCycle (IncidenceScheme n u v d))

opaque IncidenceGroup : Nat → Group

/- Reducedness part supplied by the incidence theorem. -/
axiom incidenceSchemeReduced :
    ∀ (n : Nat) (u v : Perm) (d : Degree),
      0 < n →
        IsReduced (IncidenceScheme n u v d)

theorem incidenceFundamentalCycleEffective :
    ∀ (n : Nat) (u v : Perm) (d : Degree),
      0 < n →
        EffectiveCycle (fundamentalCycle (IncidenceScheme n u v d)) := by
  intro n u v d hn
  apply fundamental_cycle_effective_of_reduced
  exact incidenceSchemeReduced n u v d hn

axiom incidenceFundamentalCycleInvariant :
    ∀ (n : Nat) (u v : Perm) (d : Degree),
      0 < n →
        InvariantCycle (IncidenceGroup n)
          (fundamentalCycle (IncidenceScheme n u v d))

axiom ev3_equivariant :
    ∀ (n : Nat) (u v : Perm) (d : Degree),
      IsEquivariant (IncidenceGroup n) (ev3 n u v d)

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
