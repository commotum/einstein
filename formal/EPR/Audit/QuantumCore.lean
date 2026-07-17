module

public import EPR.Quantum.Core

/-!
# Quantum-core smoke checks

This diagnostic leaf exercises the generic Stage 2 API on two concrete qubit
basis states and the identity projector.  In particular, the identity outcome
contains two distinct states, so the checks do not accidentally rely on
one-dimensional projectors.
-/

open scoped ComplexOrder Matrix

@[expose] public section

namespace EPR.Audit.QuantumCore

open EPR.Quantum

/-- The computational basis state `|0⟩`, used only as an audit example. -/
def ketZero : QubitKet := Pi.single (0 : QubitIndex) 1

/-- The computational basis state `|1⟩`, used only as an audit example. -/
def ketOne : QubitKet := Pi.single (1 : QubitIndex) 1

def stateZero : PureState QubitIndex where
  ket := ketZero
  normalized := by simp [ketZero, dotProduct]

def stateOne : PureState QubitIndex where
  ket := ketOne
  normalized := by simp [ketOne, dotProduct]

example : stateZero.ket ≠ 0 := stateZero.ne_zero

example : stateZero.toDensity.matrix ≠ 0 := stateZero.toDensity.ne_zero

example : stateZero ≠ stateOne := by
  intro h
  have hket := congrArg PureState.ket h
  have := congrFun hket (0 : QubitIndex)
  simp [stateZero, stateOne, ketZero, ketOne] at this

/-- The identity observable, specialized to a qubit. -/
def identityObservable : Observable QubitIndex := Observable.identity

/-- Its full-space eigenprojector.  This is deliberately degenerate. -/
def identityOutcome : ProjectiveOutcome identityObservable where
  value := 1
  projector := Projection.identity
  nonzero := by
    intro h
    have := congrFun₂ h (0 : QubitIndex) (0 : QubitIndex)
    simp [Projection.identity] at this
  spectral := by simp [identityObservable, Observable.identity, Projection.identity]

example : stateZero.IsEigenstate identityObservable 1 := by
  simp [PureState.IsEigenstate, identityObservable, Observable.identity]

example : stateOne.IsEigenstate identityObservable 1 := by
  simp [PureState.IsEigenstate, identityObservable, Observable.identity]

example : identityOutcome.projector.Supports stateZero.toDensity := by
  simp [Projection.Supports, identityOutcome, Projection.identity]

example : identityOutcome.projector.Supports stateOne.toDensity := by
  simp [Projection.Supports, identityOutcome, Projection.identity]

example : outcomeProbability stateZero.toDensity identityOutcome.projector = 1 :=
  outcomeProbability_eq_one_of_support _ _ (by
    simp [Projection.Supports, identityOutcome, Projection.identity])

example : stateZero.toDensity.SharpValue identityObservable 1 :=
  PureState.toDensity_sharpValue (by
    simp [PureState.IsEigenstate, identityObservable, Observable.identity])

example : stateZero.toDensity.SharpValue identityObservable identityOutcome.value :=
  identityOutcome.sharpValue_of_support _ (by
    simp [Projection.Supports, identityOutcome, Projection.identity])

example {a b : ℝ}
    (ha : stateZero.toDensity.SharpValue identityObservable a)
    (hb : stateZero.toDensity.SharpValue identityObservable b) : a = b :=
  DensityState.sharpValue_unique ha hb

end EPR.Audit.QuantumCore
