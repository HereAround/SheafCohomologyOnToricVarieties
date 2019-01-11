#############################################################################
##
##  makedoc.g           SheafCohomologyOnToricVarieties package
##                      Martin Bies
##
##  Copyright 2019      ULB Brussels
##
##  A package to compute sheaf cohomology on toric varieties
##
#############################################################################

LoadPackage( "AutoDoc" );

AutoDoc( "SheafCohomologyOnToricVarieties" : scaffold := true, autodoc :=
             rec( files := [ "doc/Intros.autodoc",
                         "gap/VanishingSets.gd",
                         "examples/VanishingSets.g",
                         "gap/DegreeXLayer.gd",
                         "examples/DegreeXLayerVectorSpaces.g",
                         "gap/NefAndMoriCone.gd",
                         "examples/NefAndMori.g",
                         "gap/ICTCurves.gd",
                         "examples/ICTCurves.g",
                         "gap/CohomologyOnPn.gd",
                         "examples/CohomologyOnPn.g",
                         "gap/CohomologyFromMyTheorem.gd",
                         "examples/CohomologyFromMyTheorem.g",
                         "gap/CohomologyFromCohomCalg.gd",
                         "gap/CohomologyFromResolution.gd",
                         "gap/MapsInResolution.gd",
                         ],
             scan_dirs := []
             ),
         maketest := rec( folder := ".",
                          commands :=
                            [ "LoadPackage( \"IO_ForHomalg\" );",
                              "LoadPackage( \"GaussForHomalg\" );",
                              "LoadPackage( \"ToricVarieties\" );",
                              "LoadPackage( \"SheafCohomologyOnToricVarieties\" );",
                              "HOMALG_IO.show_banners := false;",
                              "HOMALG_IO.suppress_PID := true;",
                              "HOMALG_IO.use_common_stream := true;",
                             ]
                           )
);

QUIT;
