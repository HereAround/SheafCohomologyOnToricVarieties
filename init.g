#############################################################################
##
##  init.g              SheafCohomologyOnToricVarieties package
##                      Martin Bies
##
##  Copyright 2016      ITP Universität Heidelberg
##
##  A package to compute sheaf cohomology on toric varieties
##
#############################################################################

# the cohomology pieces
ReadPackage( "SheafCohomologyOnToricVarieties", "gap/ToricVarietiesAdditionalPropertiesForCAP.gd" );
ReadPackage( "SheafCohomologyOnToricVarieties", "gap/ICTCurves.gd" );
ReadPackage( "SheafCohomologyOnToricVarieties", "gap/NefAndMoriCone.gd" );

ReadPackage( "SheafCohomologyOnToricVarieties", "gap/cohomCalg.gd" );

ReadPackage( "SheafCohomologyOnToricVarieties", "gap/VanishingSets.gd" );
ReadPackage( "SheafCohomologyOnToricVarieties", "gap/DegreeXLayer.gd" );

ReadPackage( "SheafCohomologyOnToricVarieties", "gap/CohomologyOnPn.gd" );
ReadPackage( "SheafCohomologyOnToricVarieties", "gap/CohomologyFromCohomCalg.gd" );
ReadPackage( "SheafCohomologyOnToricVarieties", "gap/CohomologyFromResolution.gd" );
ReadPackage( "SheafCohomologyOnToricVarieties", "gap/CohomologyFromBTransform.gd" );
ReadPackage( "SheafCohomologyOnToricVarieties", "gap/CohomologyFromMyTheorem.gd" );

ReadPackage( "SheafCohomologyOnToricVarieties", "gap/MapsInResolution.gd" );
