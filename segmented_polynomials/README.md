# Construction of segmented polynomial stochastic simulation metamodels

Segmented polynomials can provide a simple representation for complex output behaviour by creating segments of distinct behaviour.
The best transition break points between segments can be optained through an iteractive process.
Besides identifying each segment behaviour with meaningful parameters (base, slope, curvature) these metamodels clearly identify where the behaviour changes (best break points).

1. Analyze the simulation model output for the region of interest. Define an experimental design, run enough replications at each design point to keep variance low.
2. Identify segments that can be modeled by low level polynomials and respective polynomial degrees. Flat areas should be modeled by linear or low degree polynomials. Each region should be easely represented by a low degree polynomial (cubic or less).
3. Identify break point zones between segments, where the system changes behaviour. These zone intervals can be rough areas since the algorithm will determine the best break point given the left-side and right-side polynomial degrees.
4. Run minCn to determine the best values for each break point. These points identify the input values where the original model changes behaviour.
5. plotCn can add to vizualise the metamodel behaviour for any set of input values (within the design region)

Running lsqCn by itself can be used to obtain estimator at any break point values.

(C) Pedro Reis dos Santos, DEI, IST, University of Lisbon, PT, 2020
(C) Isabel Reis dos Santos, DM, IST, University of Lisbon, PT, 2020
