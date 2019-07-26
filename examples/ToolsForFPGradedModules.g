#! @Chapter Tools for FPGradedModules

#! @Section Example: Minimal free resolution and Betti table

LoadPackage( "SheafCohomologyOnToricVarieties" );

#! @Example
P2 := ProjectiveSpace( 2 );
#! <A projective toric variety of dimension 2>
IR := IrrelevantLeftIdealForCAP( P2 );;
IsWellDefined( IR );
#! true
resolution := MinimalFreeResolutionForCAP( IR );
#! <An object in Complex category of Category of graded
#! rows over Q[x_1,x_2,x_3] (with weights [ 1, 1, 1 ])>
BT := BettiTableForCAP( IR );
#! [ [ -1, -1, -1 ], [ -2, -2, -2 ], [ -3 ] ]
#! @EndExample
