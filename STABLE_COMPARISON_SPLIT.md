# Stable Comparison Split

This note records the current decomposition of the manuscript's
`prop:stable-finite` interface.

The previous interface

```lean
Kim_finite_comparison_at_bound
```

directly identified the stable coefficient with the finite twisted coefficient
at a sufficiently large rank.  It has now been reduced to a Lean theorem
obtained from three smaller interfaces.

## Remaining Interfaces

```lean
finite_specialization_preserves_bounded_terms
```

Specialization `sp_N^{qa}` does not change the coefficient when the rank bounds
the permutations and the quantum variables appearing in the stable expansion.

```lean
stable_product_specializes_to_finite_product
```

Lam--Shimozono stability identifies the specialized stable product with the
finite product in the Kim quotient at rank `N`.

```lean
kim_basis_unique_coefficients
```

Kim's quantum Schubert classes form a basis in the finite quotient, so equal
finite product expansions have equal coefficients.

## Lean-Proved Assembly

The theorem

```lean
Kim_finite_comparison_at_bound
```

is now proved by chaining the three interfaces above.  The theorem

```lean
stable_finite_comparison_from_interfaces
```

then chooses `comparisonBound u v w data`, proves it bounds `u`, `v`, `w`, and
`data.qBound`, and applies `Kim_finite_comparison_at_bound`.

## Next Reductions

The next target is to replace `finite_specialization_preserves_bounded_terms`
by a theorem about a concrete finite-support polynomial model.  After that,
`kim_basis_unique_coefficients` should be split into a generic basis uniqueness
lemma plus the external Kim-basis theorem.
