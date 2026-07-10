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

The theorem is still abstract about the connection between the stored numerical
bound and the concrete variable support via

```lean
quantumVariableBound_bounds_terms
```

This declaration is the next reduction target.  It should eventually be
replaced by a concrete finite-support expansion model for `QuantumPoly`.
