module

public import EPR.Audit.Incompatibility

/-!
# Incompatibility signature and axiom audit

This diagnostic leaf checks the generic incompatibility vocabulary and
density-column bridges, the exact Pauli-X/Pauli-Z exclusions, and the
executable `Fin 3` counterexample. It is not part of the public `EPR` import
chain.
-/

namespace EPR.Audit.IncompatibilityAxioms

/-! ## Generic predicates and bridges -/

#check EPR.Quantum.Observable.Commutes
#check EPR.Quantum.Observable.Noncommutes
#check EPR.Quantum.Observable.IsEigenvector
#check EPR.Quantum.Observable.HasCommonEigenvector
#check EPR.Quantum.Observable.NoCommonEigenvector
#check EPR.Quantum.Observable.HasJointSharpState
#check EPR.Quantum.Observable.NoJointSharpState

#check EPR.Quantum.Observable.commutes_comm
#check EPR.Quantum.Observable.hasCommonEigenvector_comm
#check EPR.Quantum.Observable.hasJointSharpState_comm
#check EPR.Quantum.PureState.isEigenvector_iff_isEigenstate
#check EPR.Quantum.DensityState.exists_col_ne_zero
#check EPR.Quantum.DensityState.col_isEigenvector_of_sharpValue
#check EPR.Quantum.Observable.hasCommonEigenvector_of_jointlySharp
#check EPR.Quantum.Observable.hasCommonEigenvector_of_hasJointSharpState
#check EPR.Quantum.Observable.not_jointlySharp_of_noCommonEigenvector
#check EPR.Quantum.Observable.noJointSharpState_of_noCommonEigenvector

#print axioms EPR.Quantum.Observable.Commutes
#print axioms EPR.Quantum.Observable.Noncommutes
#print axioms EPR.Quantum.Observable.IsEigenvector
#print axioms EPR.Quantum.Observable.HasCommonEigenvector
#print axioms EPR.Quantum.Observable.NoCommonEigenvector
#print axioms EPR.Quantum.Observable.HasJointSharpState
#print axioms EPR.Quantum.Observable.NoJointSharpState

#print axioms EPR.Quantum.Observable.commutes_comm
#print axioms EPR.Quantum.Observable.hasCommonEigenvector_comm
#print axioms EPR.Quantum.Observable.hasJointSharpState_comm
#print axioms EPR.Quantum.PureState.isEigenvector_iff_isEigenstate
#print axioms EPR.Quantum.DensityState.exists_col_ne_zero
#print axioms EPR.Quantum.DensityState.col_isEigenvector_of_sharpValue
#print axioms EPR.Quantum.Observable.hasCommonEigenvector_of_jointlySharp
#print axioms EPR.Quantum.Observable.hasCommonEigenvector_of_hasJointSharpState
#print axioms EPR.Quantum.Observable.not_jointlySharp_of_noCommonEigenvector
#print axioms EPR.Quantum.Observable.noJointSharpState_of_noCommonEigenvector

/-! ## Pauli-X/Pauli-Z exclusions -/

#check EPR.Examples.PauliIncompatibility.pauliXZ_noncommutes
#check EPR.Examples.PauliIncompatibility.pauliXZ_commonEigenvector_eq_zero
#check EPR.Examples.PauliIncompatibility.pauliXZ_noCommonEigenvector
#check EPR.Examples.PauliIncompatibility.pauliXZ_noJointSharpState
#check EPR.Examples.PauliIncompatibility.pauliXZ_not_jointlySharp

#print axioms EPR.Examples.PauliIncompatibility.pauliXZ_noncommutes
#print axioms EPR.Examples.PauliIncompatibility.pauliXZ_commonEigenvector_eq_zero
#print axioms EPR.Examples.PauliIncompatibility.pauliXZ_noCommonEigenvector
#print axioms EPR.Examples.PauliIncompatibility.pauliXZ_noJointSharpState
#print axioms EPR.Examples.PauliIncompatibility.pauliXZ_not_jointlySharp

/-! ## Pauli executable sentinels -/

#check EPR.Audit.Incompatibility.pauliXZ_product_entry
#check EPR.Audit.Incompatibility.pauliXZ_arbitrary_commonEigenvector_zero
#check EPR.Audit.Incompatibility.pauliXZ_all_density_states

#print axioms EPR.Audit.Incompatibility.pauliXZ_product_entry
#print axioms EPR.Audit.Incompatibility.pauliXZ_arbitrary_commonEigenvector_zero
#print axioms EPR.Audit.Incompatibility.pauliXZ_all_density_states

/-! ## `Fin 3` Hermitian counterexample sentinels -/

#check EPR.Audit.Incompatibility.fin3AMatrix
#check EPR.Audit.Incompatibility.fin3BMatrix
#check EPR.Audit.Incompatibility.fin3A
#check EPR.Audit.Incompatibility.fin3B
#check EPR.Audit.Incompatibility.fin3A.isHermitian
#check EPR.Audit.Incompatibility.fin3B.isHermitian
#check EPR.Audit.Incompatibility.fin3_product_entry
#check EPR.Audit.Incompatibility.fin3_noncommutes
#check EPR.Audit.Incompatibility.fin3SharedState
#check EPR.Audit.Incompatibility.fin3SharedState_eigen_A
#check EPR.Audit.Incompatibility.fin3SharedState_eigen_B
#check EPR.Audit.Incompatibility.fin3_hasCommonEigenvector
#check EPR.Audit.Incompatibility.fin3_pureDensity_jointlySharp
#check EPR.Audit.Incompatibility.fin3_hasJointSharpState
#check EPR.Audit.Incompatibility.fin3_noncommuting_with_common_sharp_state

#print axioms EPR.Audit.Incompatibility.fin3AMatrix
#print axioms EPR.Audit.Incompatibility.fin3BMatrix
#print axioms EPR.Audit.Incompatibility.fin3A
#print axioms EPR.Audit.Incompatibility.fin3B
#print axioms EPR.Audit.Incompatibility.fin3_product_entry
#print axioms EPR.Audit.Incompatibility.fin3_noncommutes
#print axioms EPR.Audit.Incompatibility.fin3SharedState
#print axioms EPR.Audit.Incompatibility.fin3SharedState_eigen_A
#print axioms EPR.Audit.Incompatibility.fin3SharedState_eigen_B
#print axioms EPR.Audit.Incompatibility.fin3_hasCommonEigenvector
#print axioms EPR.Audit.Incompatibility.fin3_pureDensity_jointlySharp
#print axioms EPR.Audit.Incompatibility.fin3_hasJointSharpState
#print axioms EPR.Audit.Incompatibility.fin3_noncommuting_with_common_sharp_state

end EPR.Audit.IncompatibilityAxioms
