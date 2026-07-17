module

import EPR.Quantum.Core

/-!
# Quantum-core axiom audit

This diagnostic leaf prints the trusted axiom footprint of the principal
Stage 2 theorems.  It is not imported by the public `EPR` root.
-/

#print axioms EPR.Quantum.PureState.ne_zero
#print axioms EPR.Quantum.DensityState.ne_zero
#print axioms EPR.Quantum.PureState.toDensity
#print axioms EPR.Quantum.star_bornWeight
#print axioms EPR.Quantum.coe_outcomeProbability
#print axioms EPR.Quantum.outcomeProbability_eq_one_of_support
#print axioms EPR.Quantum.DensityState.sharpValue_unique
#print axioms EPR.Quantum.PureState.toDensity_sharpValue
#print axioms EPR.Quantum.ProjectiveOutcome.sharpValue_of_support
