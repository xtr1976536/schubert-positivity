# Lean formalization plan

This directory is for a small Lean4 formalization of the finite combinatorial
part of the quantum positivity manuscript.

The realistic first-week target is not to formalize equivariant quantum
cohomology. Instead, we formalize the permutation computations used in the
geometric proof:

1. the block-swap permutation `tau`;
2. the auxiliary permutation `a0`;
3. the identity `a0^{-1} * tau * a0 = w0`;
4. the inversion set of `tau`;
5. length/codimension identities for embedded permutations.

These are the places where sign and indexing mistakes are most likely.

## Cloud usage

The intended workflow is GitHub Codespaces.

1. Create a new GitHub repository and upload the contents of this directory.
2. Open the repository in Codespaces.
3. In the Codespaces terminal, run:

```bash
lake build
```

At the moment several core statements are intentionally marked with `sorry`.
The first milestone is therefore not merely "the project builds"; it is to
replace the `sorry`s in `SchubertPositivity/Permutations.lean` by complete
proofs.

## First statements to close

The first three formal targets are:

```lean
a0_tau_a0_eq_w0
tau_inversion_forward
tau_inversion_backward
```

Once these are proved, the next file should introduce the finite length
function and prove:

```text
length(tau_n) = n^2
Inv(tau_n) = {(p,q) | p < n <= q}
```

After that, we can formalize the embedded-permutation codimension identities
that are used in the manuscript.
