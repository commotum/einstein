module

public import EPR.Examples.BellNoSignalling
public import EPR.Examples.BellEPR
public import EPR.Continuum.Idealized

/-!
# EPR public API

The public root exposes three deliberately distinct completed branches:

* reusable finite-dimensional states, projective conditioning, Bell steering,
  Pauli incompatibility, and directional operational no-signalling;
* the theory-neutral conditional EPR logic and its Bell/Pauli instantiation;
* the independent tempered-distribution/Schwartz-space audit of the paper's
  idealized position--momentum construction.

The incompleteness theorems assert no philosophical premise unconditionally.
Operational no-signalling is not ontic no-disturbance, noncommutation is not
used in place of the stronger no-joint-sharp-state result, and continuum
distributions are not finite normalized quantum states. Diagnostic modules
under `EPR.Audit` remain opt-in and are not re-exported here.
-/
