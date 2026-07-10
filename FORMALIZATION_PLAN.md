# Formalization targets

This note records the deliberately narrow Lean4 target for the first week.
The goal is to make the finite combinatorial core machine-checkable before
attempting any geometric formalization.

## Scope

We formalize only statements about finite permutations on `Fin m`:

- the block-swap permutation `tau_n` on `2n` letters;
- the auxiliary element `a0`;
- the longest element `w0`;
- inversion sets and lengths;
- the embedded-permutation length identities used by the manuscript.

We do not attempt, in this first stage, to formalize flag varieties,
equivariant quantum cohomology, Gromov-Witten invariants, or the Peterson
comparison theorem.

## Milestone 1

File: `SchubertPositivity/Permutations.lean`.

Close the following three statements without `sorry`:

```lean
a0_tau_a0_eq_w0
tau_inversion_forward
tau_inversion_backward
```

These three statements test exactly the block-swap/indexing computation that
the manuscript uses to identify the relevant finite Weyl group element.

## Milestone 2

Add a finite inversion-count definition and prove:

```text
Inv(tau_n) = {(p,q) | p < n <= q}
length(tau_n) = n^2
```

This turns the inversion-set computation into the codimension/length identity
needed in the paper.

## Milestone 3

Formalize the permutation embedding used in the manuscript and prove that the
length shift equals the claimed codimension shift. This should be the first
point at which the Lean file directly mirrors the manuscript's notation.
