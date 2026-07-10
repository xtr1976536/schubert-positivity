# Kim Basis Uniqueness Split

This round reduces

```lean
kim_basis_unique_coefficients
```

from a direct external interface to a Lean theorem.

The generic module

```lean
Basis.lean
```

introduces

```lean
structure BasisExpansion (ι R M : Type)
```

with `basisVec`, `coeff`, and `linearCombination`.  Lean proves:

```lean
BasisExpansion.coefficients_eq_of_expansion_eq
```

If two coefficient functions have the same basis expansion, then their
coefficients agree termwise.

The remaining Kim-specific external interface is now:

```lean
kim_schubert_basis_expansion_eq
```

It states that the finite product expansion and the twisted Gromov-Witten
expansion represent the same element of the finite Kim quotient.  The passage
from equality of expansions to equality of coefficients is no longer an axiom.
