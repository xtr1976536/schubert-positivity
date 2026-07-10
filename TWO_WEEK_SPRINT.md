# Two-week formalization sprint

The target is a Lean project that checks the manuscript's complete logical
assembly.  All manuscript-owned combinatorial and algebraic steps should be
proved without `sorry`.  Deep external geometric theorems may remain as named
interfaces, but each interface must correspond to a precise theorem or
proposition in the manuscript's references.

## Current status

Completed and CI-checked:

- `a0_tau_a0_eq_w0`;
- `tau_inversion_forward`;
- `tau_inversion_backward`;
- `tau_inversion_iff`;
- `tauInversionRectangle_length`;
- `tauInversionRectangle_mem_iff`;
- Lean main theorem skeleton `quantum_positivity_main`.

The current external interfaces are:

- `stable_finite_comparison`, corresponding to manuscript Proposition
  `prop:stable-finite`;
- `coefficient_gw_preserves_positivity`, corresponding to manuscript
  Proposition `prop:coefficient-gw` plus coefficientwise positivity extraction;
- `twisted_gw_positive`, corresponding to manuscript Proposition
  `prop:twisted-positive`.

## Week 1

### Day 1

Finish the finite permutation layer.

- Keep `Permutations.lean` free of `sorry`.
- Add explicit one-line aliases for manuscript Lemma `lem:conjugation` and
  Lemma `lem:inversions`, so the Lean names match the paper.
- Add a no-axiom theorem recording `length(tau_n)=n^2` in the list-count sense.

### Day 2

Formalize the positivity semiring shell.

- Define an abstract polynomial type with addition, multiplication, and
  coefficientwise positive cone.
- Prove closure of the positive cone under finite sums and multiplication by
  nonnegative coefficients.
- Replace `coefficient_gw_preserves_positivity` by a proved lemma once the
  finite degree expansion is represented.

### Day 3

Formalize finite quantum expansion bookkeeping.

- Introduce finite support for degree expansions.
- Define the operation corresponding to
  `sum_d c^{w,d;tau}_{u,v}(a) q^d`.
- Prove that positivity of all degree coefficients implies positivity of the
  whole finite quantum coefficient.

### Day 4

Split `twisted_gw_positive` into manuscript-level interfaces.

Replace the single interface by:

- incidence-cycle expression;
- invariance/effectivity;
- refined Graham positivity;
- Schubert duality.

The Lean theorem `twisted_gw_positive` should then be proved from these four
interfaces plus the already proved inversion lemma.

### Day 5

Formalize the stable comparison bookkeeping.

- Represent the finite specialization map abstractly.
- State finite support and basis uniqueness separately.
- Prove `stable_finite_comparison` from these smaller interfaces.

## Week 2

### Days 6-7

Align Lean names with the manuscript.

- Every manuscript theorem/proposition/lemma used in the final proof should
  have a Lean declaration with the same label in its docstring.
- No manuscript-owned step should be hidden inside an external axiom.

### Days 8-9

Audit all axioms.

For each remaining axiom, record:

- manuscript label;
- cited source;
- theorem number in the source;
- exact hypothesis;
- exact conclusion;
- reason it is external rather than manuscript-owned.

### Days 10-11

Remove weak interfaces.

- Eliminate any axiom that merely packages several manuscript steps.
- Keep only genuine external mathematical theorems as interfaces.

### Days 12-13

Produce final formalization report.

- State what is fully proved in Lean.
- State what remains external.
- State how each external theorem maps to a cited paper.
- Include CI badge/status and commit hash.

### Day 14

Final check.

- `lake build` must pass in GitHub Actions.
- `rg "sorry"` should return nothing.
- `rg "axiom"` should show only audited external theorem interfaces.
- The final theorem `quantum_positivity_main` should compile.
