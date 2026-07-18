module

public import Mathlib.Analysis.Complex.Order
public import Mathlib.LinearAlgebra.Matrix.Kronecker
public import Mathlib.LinearAlgebra.Matrix.PosDef
public import Mathlib.LinearAlgebra.Matrix.Trace

/-!
# Finite-dimensional representation foundations

This module fixes only basis-indexed carrier types. It deliberately does not
define physical states, observables, measurements, probabilities, locality, or
reality claims. The invariant-bearing finite definitions live in
`EPR.Quantum.*`; the interpretative vocabulary lives in `EPR.Logic.EPR`.
-/

@[expose] public section

namespace EPR

/-- The computational-basis index of a qubit. -/
abbrev QubitIndex := Fin 2

/-- A basis-indexed complex ket. Normalization is not implied. -/
abbrev Ket (ι : Type*) := ι → ℂ

/-- A basis-indexed complex linear operator. Hermiticity is not implied. -/
abbrev Operator (ι : Type*) := Matrix ι ι ℂ

/-- The ordered basis index for a bipartite system. -/
abbrev BipartiteIndex (ι κ : Type*) := ι × κ

/-- A raw one-qubit ket. Normalization is not implied. -/
abbrev QubitKet := Ket QubitIndex

/-- A raw two-qubit ket with subsystem order `A × B`. -/
abbrev TwoQubitKet := Ket (BipartiteIndex QubitIndex QubitIndex)

/-- A raw one-qubit operator. Hermiticity and positivity are not implied. -/
abbrev QubitOperator := Operator QubitIndex

/-- A raw two-qubit operator with subsystem order `A × B`. -/
abbrev TwoQubitOperator := Operator (BipartiteIndex QubitIndex QubitIndex)

end EPR
