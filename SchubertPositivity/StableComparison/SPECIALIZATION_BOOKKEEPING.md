# Specialization Bookkeeping

This round reduces

```lean
finite_specialization_preserves_bounded_terms
```

from a coefficient-level axiom to a theorem.

The remaining primitive input is now only

```lean
specialization_act_on_bounded_monomial
```

in `Specialization.lean`: a monomial whose variables are all at most `N` is
unchanged by finite-rank specialization.

From that single input Lean proves:

```lean
specializeRawPoly_eq_self_of_bounded
specializeQuantumPoly_eq_self_of_bounded
finite_specialization_preserves_bounded_terms
```

The connection between a computed raw-polynomial bound and concrete variable
support is now Lean-proved:

```lean
Monomial.variableBound_controls_terms
RawPoly.variableBound_controls_terms
QuantumPoly.boundedBy_of_coeff_variableBound
quantumVariableBound_bounds_terms
```

The remaining input is no longer a generic support theorem.  It is the
Lam--Shimozono-specific assertion stored in `StableExpansionData`:

```lean
coeff_qBound : ∀ (z : Perm) (d : Degree),
  RawPoly.variableBound (coeff z d) ≤ qBound
```

This says that the chosen stable expansion bound dominates the computed
monomial support bound of every degree coefficient.
