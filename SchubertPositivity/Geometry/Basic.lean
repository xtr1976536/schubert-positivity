import Std
import SchubertPositivity.PositivePolynomials

/-!
Minimal geometric vocabulary for the formalization.

These are abstract carriers for now.  The point of this layer is to prevent
manuscript propositions from being used as axioms: manuscript propositions
should be Lean theorems assembled from smaller external facts and general
geometric interfaces.
-/

namespace SchubertPositivity

opaque Scheme : Type
opaque Group : Type
opaque Morphism : Scheme → Scheme → Type
opaque Cycle : Type
opaque WeylElement : Type

opaque IsIrreducible : Scheme → Prop
opaque IsReduced : Scheme → Prop
opaque IsLocallyIrreducible : Scheme → Prop
opaque IsSmooth : Scheme → Prop
opaque IsPureCodimension : Scheme → Nat → Prop
opaque IsEquivariant {X Y : Scheme} : Group → Morphism X Y → Prop
opaque InvariantScheme : Group → Scheme → Prop

opaque EffectiveCycle : Cycle → Prop
opaque InvariantCycle : Group → Cycle → Prop

opaque fundamentalCycle : Scheme → Cycle
opaque cyclePushforward {X Y : Scheme} : Morphism X Y → Cycle → Cycle
opaque cyclePullback {X Y : Scheme} : Morphism X Y → Cycle → Cycle
opaque cycleIntersect : Cycle → Cycle → Cycle
opaque schubertCycle : Scheme → WeylElement → Cycle
opaque oppositeSchubertCycle : Scheme → WeylElement → Cycle
opaque schubertCoefficient : Cycle → WeylElement → RawPoly

end SchubertPositivity
