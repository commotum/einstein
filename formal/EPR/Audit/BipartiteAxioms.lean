module

import EPR.Audit.Bipartite

/-!
# Bipartite-layer axiom audit

This diagnostic leaf prints the trusted axiom footprint of the principal
Stage 3 constructions and results. It is not imported by the public `EPR`
root.
-/

#check EPR.Quantum.LocalOperatorA
#check EPR.Quantum.LocalOperatorB
#check EPR.Quantum.LocalObservableA
#check EPR.Quantum.LocalObservableB
#check EPR.Quantum.LocalProjectionA
#check EPR.Quantum.LocalProjectionB
#check EPR.Quantum.traceOutALinear
#check EPR.Quantum.traceOutBLinear

#print axioms EPR.Quantum.PureState.tensor
#print axioms EPR.Quantum.DensityState.tensor
#print axioms EPR.Quantum.PureState.toDensity_tensor
#print axioms EPR.Quantum.kronecker_mulVec_tensorKet
#print axioms EPR.Quantum.traceOutA_posSemidef
#print axioms EPR.Quantum.traceOutB_posSemidef
#print axioms EPR.Quantum.traceOutALinear
#print axioms EPR.Quantum.traceOutBLinear
#print axioms EPR.Quantum.trace_traceOutA
#print axioms EPR.Quantum.trace_traceOutB
#print axioms EPR.Quantum.reducedA
#print axioms EPR.Quantum.reducedB
#print axioms EPR.Quantum.reducedA_tensor
#print axioms EPR.Quantum.reducedB_tensor
#print axioms EPR.Quantum.LocalOperatorA.lift_mul
#print axioms EPR.Quantum.LocalOperatorB.lift_mul
#print axioms EPR.Quantum.localA_mul_localB
#print axioms EPR.Quantum.localA_commute_localB
#print axioms EPR.Quantum.LocalOperatorA.lift_mul_tensorKet
#print axioms EPR.Quantum.LocalOperatorB.lift_mul_tensorKet
#print axioms EPR.Quantum.LocalProjectionA.lift
#print axioms EPR.Quantum.LocalProjectionB.lift
#print axioms EPR.Quantum.LocalObservableA.lift
#print axioms EPR.Quantum.LocalObservableB.lift
#print axioms EPR.Audit.Bipartite.rationalEntangledState_not_product
