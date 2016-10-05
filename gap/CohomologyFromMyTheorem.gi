#############################################################################
##
##  CohomologyViaGSForCAP.gi         ToricVarieties package
##
##  Copyright 2015- 2016, Sebastian Gutsche, TU Kaiserslautern
##                        Martin Bies,       ITP Heidelberg
##
##  Sheaf cohomology via the theorem of Greg. Smith for CAP
##
#############################################################################



#############################################################
##
## Section Specialised GradedHom methods
##
#############################################################

InstallMethod( InternalHomDegreeZeroOnObjects,
               " for a toric variety, a f.p. graded left S-module, a f.p. graded left S-module",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsGradedLeftOrRightModulePresentationForCAP, IsBool ],
  function( variety, a, b, display_messages )
      local range, source, map, Q, matrix1, matrix2, matrix3, new_mat, vec_space_morphism;

      # Let a = ( R_A --- alpha ---> A ) and b = (R_B --- beta ---> B ). Then we have to compute the kernel embedding of the
      # following map:
      #
      # A^v \otimes R_B -----------alpha^v \otimes id_{R_B} --------------> R_A^v \otimes R_B
      #       |                                                                      |
      #       |                                                                      |
      # id_{A^v} \otimes beta                                            id_{R_A^v} \otimes beta
      #       |                                                                      |
      #       v                                                                      v
      # A^v \otimes B -------------- alpha^v \otimes id_B -------------------> R_A^v \otimes B
      #

      # compute the map or graded module preseentations
      if display_messages then
        Print( Concatenation( "We will now compute the map of graded module presentations, ",
                              "whose kernel is the InternalHOM that we are interested in... \n" ) );
      fi;
      range := CAPPresentationCategoryObject( TensorProductOnMorphisms(
                                                      IdentityMorphism( DualOnObjects( Source( UnderlyingMorphism( a ) ) ) ),
                                                      UnderlyingMorphism( b ) )
                                                      );
      source := CAPPresentationCategoryObject( TensorProductOnMorphisms(
                                                      IdentityMorphism( DualOnObjects( Range( UnderlyingMorphism( a ) ) ) ),
                                                      UnderlyingMorphism( b ) )
                                                      );
      map := TensorProductOnMorphisms( DualOnMorphisms( UnderlyingMorphism( a ) ),
                                       IdentityMorphism( Range( UnderlyingMorphism( b ) ) )
                                      );
      map := CAPPresentationCategoryMorphism( source,
                                              map,
                                              range,
                                              CapCategory( source )!.constructor_checks_wished
                                             );
      map := ByASmallerPresentation( map );

      # inform that we have the graded module presentation morphism and will now try to truncate it
      if display_messages then
        Print( "Computed the map of graded module presentations. Will now truncate it... \n" );
      fi;

      # -> parallisation if possible! (speed up of up to factor 3 for this step)
      Q := HomalgFieldOfRationalsInMAGMA();

      matrix1 := UnderlyingMatrix( UnderlyingVectorSpaceMorphism( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                                                          variety,
                                                                          UnderlyingMorphism( Source( map ) ),
                                                                          TheZeroElement( DegreeGroup( CoxRing( variety ) ) ),
                                                                          Q,
                                                                          display_messages
                                                                          ) ) );
      if display_messages then
        Print( "\n \n" );
      fi;

      # if the source is isomorphic to the zero_vector_space, then also H0 will be zero
      if NrColumns( matrix1 ) = 0 then
        if display_messages then
          Print( "Syzygies computed, now computing the dimension of the cokernel object... \n" );
        fi;
        return ZeroMorphism( ZeroObject( CapCategory( VectorSpaceObject( 0, Q ) ) ), VectorSpaceObject( 0, Q ) );
      elif NrColumns( matrix1 ) - ColumnRankOfMatrix( matrix1 ) = 0 then
        if display_messages then
        Print( "Syzygies computed, now computing the dimension of the cokernel object... \n" );
        fi;
        return ZeroMorphism( ZeroObject( CapCategory( VectorSpaceObject( 0, Q ) ) ), VectorSpaceObject( 0, Q ) );
      fi;

      # otherwise also compute the other matrices
      matrix2 := UnderlyingMatrix( UnderlyingVectorSpaceMorphism( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                                                          variety,
                                                                          UnderlyingMorphism( map ),
                                                                          TheZeroElement( DegreeGroup( CoxRing( variety ) ) ),
                                                                          Q,
                                                                          display_messages
                                                                          ) ) );
      Print( "\n \n" );

      matrix3 := UnderlyingMatrix( UnderlyingVectorSpaceMorphism( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                                                          variety,
                                                                          UnderlyingMorphism( Range( map ) ),
                                                                          TheZeroElement( DegreeGroup( CoxRing( variety ) ) ),
                                                                          Q,
                                                                          display_messages
                                                                          ) ) );
      Print( "\n \n" );

      # inform that the matrices have been computed and we now compute the syzygies
      if display_messages then
        Print( "All matrices computed. Will now compute syzygies... \n" );
      fi;
      new_mat := SyzygiesOfRows( SyzygiesOfRows( matrix2, matrix3 ), matrix1 );

      # inform that syzygies have been computed and that we now compute the dimension of the cokernel object
      if display_messages then
      Print( "Syzygies computed, now computing the vector space morphism... \n" );
      fi;
      vec_space_morphism := VectorSpaceMorphism( VectorSpaceObject( NrRows( new_mat ), Q ),
                                                 new_mat,
                                                 VectorSpaceObject( NrColumns( new_mat ), Q )
                                                );

      # and return the result
      return vec_space_morphism;

end );

InstallMethod( InternalHomDegreeZeroOnObjectsWrittenToFiles,
               " for a toric variety, a f.p. graded left S-module, a f.p. graded left S-module",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsGradedLeftOrRightModulePresentationForCAP ],
  function( variety, a, b )
      local range, source, map, matrix1, matrix2, matrix3, new_mat, vec_space_morphism;

      # Let a = ( R_A --- alpha ---> A ) and b = (R_B --- beta ---> B ). Then we have to compute the kernel embedding of the
      # following map:
      #
      # A^v \otimes R_B -----------alpha^v \otimes id_{R_B} --------------> R_A^v \otimes R_B
      #       |                                                                      |
      #       |                                                                      |
      # id_{A^v} \otimes beta                                            id_{R_A^v} \otimes beta
      #       |                                                                      |
      #       v                                                                      v
      # A^v \otimes B -------------- alpha^v \otimes id_B -------------------> R_A^v \otimes B
      #

      # compute the map or graded module preseentations
      Print( Concatenation( "We will now compute the map of graded module presentations, ",
                            "whose kernel is the InternalHOM that we are interested in... \n" ) );
      range := CAPPresentationCategoryObject( TensorProductOnMorphisms(
                                                      IdentityMorphism( DualOnObjects( Source( UnderlyingMorphism( a ) ) ) ),
                                                      UnderlyingMorphism( b ) )
                                                      );
      source := CAPPresentationCategoryObject( TensorProductOnMorphisms(
                                                      IdentityMorphism( DualOnObjects( Range( UnderlyingMorphism( a ) ) ) ),
                                                      UnderlyingMorphism( b ) )
                                                      );
      map := TensorProductOnMorphisms( DualOnMorphisms( UnderlyingMorphism( a ) ),
                                       IdentityMorphism( Range( UnderlyingMorphism( b ) ) )
                                      );
      map := CAPPresentationCategoryMorphism( source,
                                              map,
                                              range,
                                              CapCategory( source )!.constructor_checks_wished
                                             );
      map := ByASmallerPresentation( map );

      # inform that we have the graded module presentation morphism and will now try to truncate it
      Print( "Computed the map of graded module presentations. Will now truncate it... \n" );


      # -> parallisation if possible! (speed up of up to factor 3 for this step)
      # use e.g. MPI-gap!
      matrix1 := WriteDegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismToFileForMAGMA( variety,
                                                                          UnderlyingMorphism( Source( map ) ),
                                                                          TheZeroElement( DegreeGroup( CoxRing( variety ) ) ),
                                                                          "matrix1"
                                                                         );
      Print( "\n \n" );
      matrix2 := WriteDegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismToFileForMAGMA( variety,
                                                                          UnderlyingMorphism( map ),
                                                                          TheZeroElement( DegreeGroup( CoxRing( variety ) ) ),
                                                                          "matrix2"
                                                                         );
      Print( "\n \n" );
      matrix3 := WriteDegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphismToFileForMAGMA( variety,
                                                                          UnderlyingMorphism( Range( map ) ),
                                                                          TheZeroElement( DegreeGroup( CoxRing( variety ) ) ),
                                                                          "matrix3"
                                                                         );
      Print( "\n \n" );

      # inform that the matrices have been computed and we now compute the syzygies
      Print( "All matrices computed and written to files... \n" );

      # return that computation was successful
      return true;

end );

InstallMethod( InternalHomDegreeZeroOnMorphisms,
               " for a toric variety, a f.p. graded left S-module, a f.p. graded left S-module",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsBool ],
  function( variety, mor1, mor2, display_messages )
      local range, source, map, Q, matrix1, matrix2, matrix3, source_vec_space_pres, range_vec_space_pres, map_vec_space_pres,
           ker1, ker2, bridge;

      # Let mor1: A -> A' and mor2: B -> B' and let A = (R_A - \rho_A G_A ) and alike for the others. Then we need to compute the 
      # morphism Hom( A', B ) -> Hom( A, B' ). 


      # STEP1: Hom( A', B ):
      # STEP1: Hom( A', B ):

      # We have the following map
      #
      # G_{A'}^v \otimes R_B -----------rho_{A'}^v \otimes id_{R_B} --------------> R_{A'}^v \otimes R_B
      #       |                                                                      |
      #       |                                                                      |
      # id_{G_{A'}^v} \otimes rho_B                                            id_{R_{A'}^v} \otimes rho_B
      #       |                                                                      |
      #       v                                                                      v
      # G_{A'}^v \otimes G_B ---------- rho_{A'}^v \otimes id_{G_B} ------------> R_{A'}^v \otimes G_B
      #

      # compute the map or graded module preseentations
      if display_messages then
        Print( "Step1: \n" );
        Print( "------ \n" );
        Print( Concatenation( "We will now compute the map of graded module presentations, ",
                              "whose kernel is GradedHom( Range( mor1 ), Source( mor2 ) )... \n" ) );
      fi;
      range := CAPPresentationCategoryObject( TensorProductOnMorphisms(
                                                      IdentityMorphism( DualOnObjects( Source( UnderlyingMorphism( Range( mor1 ) ) ) ) ),
                                                      UnderlyingMorphism( Source( mor2 ) ) )
                                                      );
      source := CAPPresentationCategoryObject( TensorProductOnMorphisms(
                                                      IdentityMorphism( DualOnObjects( Range( UnderlyingMorphism( Range( mor1 ) ) ) ) ),
                                                      UnderlyingMorphism( Source( mor2 ) ) )
                                                      );
      map := TensorProductOnMorphisms( DualOnMorphisms( UnderlyingMorphism( Range( mor1 ) ) ),
                                       IdentityMorphism( Range( UnderlyingMorphism( Source( mor2 ) ) ) )
                                      );
      map := CAPPresentationCategoryMorphism( source,
                                              map,
                                              range,
                                              CapCategory( source )!.constructor_checks_wished
                                             );
      map := ByASmallerPresentation( map );

      # inform that we have the graded module presentation morphism and will now try to truncate it
      if display_messages then
        Print( Concatenation( "Computed the map of graded module presentations whose kernel is GradedHom( Range( mor1 ), Source( mor2 ) ).",
                              "Will now truncate it... \n \n" ) );
      fi;

      # Set up rationals in MAGMA, so that we can compute the kernels and so on of matrices with MAGMA
      Q := HomalgFieldOfRationalsInMAGMA();

      source_vec_space_pres := CAPPresentationCategoryObject(
                                    UnderlyingVectorSpaceMorphism( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                                                          variety,
                                                                          UnderlyingMorphism( Source( map ) ),
                                                                          TheZeroElement( DegreeGroup( CoxRing( variety ) ) ),
                                                                          Q,
                                                                          display_messages
                                                                          ) ) );
      if display_messages then
        Print( "\n \n" );
      fi;
      map_vec_space_pres := UnderlyingVectorSpaceMorphism( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                                                          variety,
                                                                          UnderlyingMorphism( map ),
                                                                          TheZeroElement( DegreeGroup( CoxRing( variety ) ) ),
                                                                          Q,
                                                                          display_messages
                                                                          ) );
      if display_messages then
        Print( "\n \n" );
      fi;
      range_vec_space_pres := CAPPresentationCategoryObject( 
                                   UnderlyingVectorSpaceMorphism( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                                                          variety,
                                                                          UnderlyingMorphism( Range( map ) ),
                                                                          TheZeroElement( DegreeGroup( CoxRing( variety ) ) ),
                                                                          Q,
                                                                          display_messages
                                                                          ) ) );
      if display_messages then
        Print( "\n \n" );
      fi;
      ker1 := KernelEmbedding( CAPPresentationCategoryMorphism( source_vec_space_pres,
                                                                map_vec_space_pres,
                                                                range_vec_space_pres,
                                                                CapCategory( source )!.constructor_checks_wished
                                                               ) );


      # STEP2: Hom( A, B' ):
      # STEP2: Hom( A, B' ):

      # We have the following map
      #
      # G_{A}^v \otimes R_{B'} -------rho_{A}^v \otimes id_{R_{B'}} ----------> R_{A}^v \otimes R_{B'}
      #       |                                                                      |
      #       |                                                                      |
      # id_{G_{A}^v} \otimes rho_{B'}                                       id_{R_{A}^v} \otimes rho_{B'}
      #       |                                                                      |
      #       v                                                                      v
      # G_{A}^v \otimes G_{B'} ---------- rho_{A}^v \otimes id_{G_{B'}} ---------> R_{A}^v \otimes G_{B'}
      #

      # compute the map or graded module preseentations
      if display_messages then
        Print( "\n \n" );
        Print( "Step2: \n" );
        Print( "------ \n" );
        Print( Concatenation( "We will now compute the map of graded module presentations, ",
                              "whose kernel is GradedHom( Source( mor1 ), Range( mor2 ) )... \n" ) );
      fi;
      range := CAPPresentationCategoryObject( TensorProductOnMorphisms(
                                                      IdentityMorphism( DualOnObjects( Source( UnderlyingMorphism( Source( mor1 ) ) ) ) ),
                                                      UnderlyingMorphism( Range( mor2 ) ) )
                                                      );
      source := CAPPresentationCategoryObject( TensorProductOnMorphisms(
                                                      IdentityMorphism( DualOnObjects( Range( UnderlyingMorphism( Source( mor1 ) ) ) ) ),
                                                      UnderlyingMorphism( Range( mor2 ) ) )
                                                      );
      map := TensorProductOnMorphisms( DualOnMorphisms( UnderlyingMorphism( Source( mor1 ) ) ),
                                       IdentityMorphism( Range( UnderlyingMorphism( Range( mor2 ) ) ) )
                                      );
      map := CAPPresentationCategoryMorphism( source,
                                              map,
                                              range,
                                              CapCategory( source )!.constructor_checks_wished
                                             );
      map := ByASmallerPresentation( map );

      # inform that we have the graded module presentation morphism and will now try to truncate it
      if display_messages then
        Print( Concatenation( "Computed the map of graded module presentations whose kernel is GradedHom( Source( mor1 ), Range( mor2 ) ).",
                              "Will now truncate it... \n \n" ) );
      fi;

      source_vec_space_pres := CAPPresentationCategoryObject(
                                    UnderlyingVectorSpaceMorphism( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                                                          variety,
                                                                          UnderlyingMorphism( Source( map ) ),
                                                                          TheZeroElement( DegreeGroup( CoxRing( variety ) ) ),
                                                                          Q,
                                                                          display_messages
                                                                          ) ) );
      if display_messages then
        Print( "\n \n" );
      fi;
      map_vec_space_pres := UnderlyingVectorSpaceMorphism( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                                                          variety,
                                                                          UnderlyingMorphism( map ),
                                                                          TheZeroElement( DegreeGroup( CoxRing( variety ) ) ),
                                                                          Q,
                                                                          display_messages
                                                                          ) );
      if display_messages then
        Print( "\n \n" );
      fi;
      range_vec_space_pres := CAPPresentationCategoryObject( 
                                    UnderlyingVectorSpaceMorphism( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                                                          variety,
                                                                          UnderlyingMorphism( Range( map ) ),
                                                                          TheZeroElement( DegreeGroup( CoxRing( variety ) ) ),
                                                                          Q,
                                                                          display_messages
                                                                          ) ) );
      if display_messages then
        Print( "\n \n" );
      fi;
      ker2 := KernelEmbedding( CAPPresentationCategoryMorphism( source_vec_space_pres,
                                                                map_vec_space_pres,
                                                                range_vec_space_pres,
                                                                CapCategory( source )!.constructor_checks_wished
                                                               ) );


      # STEP3: The bridge map
      # STEP3: The bridge map

      # compute the map or graded module preseentations
      if display_messages then
        Print( "\n \n" );
        Print( "Step3: \n" );
        Print( "------ \n" );
        Print( "We will now compute the bridge map... \n" );
      fi;
      map := TensorProductOnMorphisms( DualOnMorphisms( UnderlyingMorphism( mor1 ) ),
                                       UnderlyingMorphism( mor2 )
                                      );
      if display_messages then
        Print( "and truncate it... \n \n" );
      fi;
      map_vec_space_pres := UnderlyingVectorSpaceMorphism( DegreeXLayerOfProjectiveGradedLeftOrRightModuleMorphism(
                                                                          variety,
                                                                          map,
                                                                          TheZeroElement( DegreeGroup( CoxRing( variety ) ) ),
                                                                          Q,
                                                                          display_messages
                                                                          ) );

      bridge := CAPPresentationCategoryMorphism( Range( ker1 ),
                                                 map_vec_space_pres,
                                                 Range( ker2 ),
                                                 CapCategory( source )!.constructor_checks_wished
                                                );


      # STEP3: The bridge map
      # STEP3: The bridge map

      # compute the lift
      if display_messages then
        Print( "\n \n \n" );
        Print( "Step4: \n" );
        Print( "------ \n" );
        Print( "We will compute the necessary lift and return it... \n \n \n \n" );
      fi;

      return Lift( PreCompose( ker1, bridge ), ker2 );

end );



#############################################################
##
## Section Specialised GradedExt methods
##
#############################################################


# compute H^0 by applying the theorem from Greg Smith
InstallMethod( GradedExtDegreeZeroOnObjects,
               " for a toric variety, a f.p. graded left S-module, a f.p. graded left S-module",
               [ IsInt, IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsGradedLeftOrRightModulePresentationForCAP, IsBool ],
  function( i, variety, module1, module2, display_messages )
    local left, mu, graded_hom_mapping;

    # check input
    left := IsGradedLeftModulePresentationForCAP( module1 );
    if i < 0 then
      Error( "the integer i must be non-negative" );
      return;
    elif IsGradedLeftModulePresentationForCAP( module2 ) <> left then
      Error( "the two modules must either both be left or both be right modules" );
      return;
    fi;

    # if we are given submodules, then turn them into presentations
    if IsGradedLeftOrRightSubmoduleForCAP( module1 ) then
      module1 := PresentationForCAP( module1 );
    fi;
    if IsGradedLeftOrRightSubmoduleForCAP( module2 ) then
      module2 := PresentationForCAP( module2 );
    fi;

    # now compute the extension module

    # step1:
    if display_messages then
      Print( "Step 0: \n" );
      Print( "------- \n");
      Print( "We will now extract the 'i-th' morphism \mu in the resolution of module1... \n" );
    fi;

    if i = 0 then
      mu := ZeroMorphism( module1, ZeroObject( CapCategory( module1 ) ) );
    else
      mu := UnderlyingZFunctorCell( MinimalFreeResolutionForCAP( module1 ) )!.differential_func( -i );
      mu := ApplyFunctor( EmbeddingOfProjCategory( CapCategory( mu ) ), mu );
      mu := KernelEmbedding( CokernelProjection( mu ) );
    fi;

    # step2:
    if display_messages then
      Print( "Next will now compute GradedHom( Range( mu ), module2 )_0 -> GradedHom( Source( mu ), module2 )_0... \n \n \n \n" );
    fi;
    graded_hom_mapping := InternalHomDegreeZeroOnMorphisms( variety, mu, IdentityMorphism( module2 ), display_messages );

    # (3) then return the cokernel object of this morphism (this is a vector space presentation)
    if display_messages then
      Print( "Step 5: \n" );
      Print( "------- \n");
      Print( "Finally, we now compute the cokernel of this morphism... \n \n" );
    fi;

    return UnderlyingMorphism( CokernelObject( graded_hom_mapping ) );

end );



#############################################################
##
## Section Parameter check
##
#############################################################

# this methods checks if the conditions in the theorem by Greg Smith are satisfied
BindGlobal( "SHEAF_COHOMOLOGY_INTERNAL_PARAMETER_CHECK",
  function( variety, ideal, module, Index )
    local betti_ideal, betti_module, L_ideal, L_module, u, j, k, l, diff, tester;

    # check if Index is meaningful
    if ( Index < 0 ) or ( Index > Dimension( variety ) )  then

      Error( "Index must be non-negative and must not exceed the dimension of the variety." );
      return;

    fi;

    # compute resolutions of both modules
    betti_ideal := BettiTableForCAP( ideal );
    betti_module := BettiTableForCAP( module );

    # extract the 'lengths' of the two ideals
    L_ideal := Length( betti_ideal ) - 1; # resolution indexed from F0 to F( L_ideal )
    L_module := Length( betti_module ) - 1; # same...

    # check condition 1
    # check condition 1
    if not (Minimum( L_ideal, Index - 1 ) < 0) then

      for u in [ 0 .. Minimum( L_ideal, Index - 1 ) ] do
        for j in [ 1 .. Length( betti_ideal[ u+1 ] ) ] do
          for k in [ 0 .. Minimum( Dimension( variety ) - Index + u, L_module ) ] do
            for l in [ 1 .. Length( betti_module[ k+1 ] ) ] do
              diff := UnderlyingListOfRingElements( betti_ideal[ u+1 ][ j ] ) -
                      UnderlyingListOfRingElements( betti_module[ k+1 ][ l ] );
              tester := PointContainedInVanishingSet( VanishingSets( variety ).( k+Index-u ), diff );
              if tester = false then
                return false;
              fi;
            od;
          od;
        od;
      od;

    fi;

    # check condition 2
    # check condition 2
    if not (Minimum( L_ideal, Index - 2 ) < 0) then

      for u in [ 0 .. Minimum( L_ideal, Index - 2 ) ] do
        for j in [ 1 .. Length( betti_ideal[ u+1 ] ) ] do
          for k in [ 0 .. Minimum( Dimension( variety ) - Index + u + 1, L_module ) ] do
            for l in [ 1 .. Length( betti_module[ k+1 ] ) ] do
              diff := UnderlyingListOfRingElements( betti_ideal[ u+1 ][ j ] ) -
                      UnderlyingListOfRingElements( betti_module[ k+1 ][ l ] );
              tester := PointContainedInVanishingSet( VanishingSets( variety ).( k+Index-u-1 ), diff );
              if tester = false then
                return false;
              fi;
            od;
          od;
        od;
      od;

    fi;

    # check condition 3
    # check condition 3
    if ( 0 < Index ) and ( Index < Length( betti_ideal ) ) then

      for j in [ 1 .. Length( betti_ideal[ Index ] ) ] do
        for u in [ 1 .. Minimum( L_module, Dimension( variety ) ) ] do
          for l in [ 1 .. Length( betti_module[ u+1 ] ) ] do
            diff := UnderlyingListOfRingElements( betti_ideal[ Index ][ j ] ) -
                    UnderlyingListOfRingElements( betti_module[ u+1 ][ l ] );
            tester := PointContainedInVanishingSet( VanishingSets( variety ).( u ), diff );
            if tester = false then
              return false;
            fi;
          od;
        od;
      od;

    fi;

    # check condition 4
    # check condition 4
    if ( Index + 1 < Length( betti_ideal ) ) then

      for j in [ 1 .. Length( betti_ideal[ Index + 1 ] ) ] do
        for u in [ 1 .. Minimum( L_module, Dimension( variety ) ) ] do
          for l in [ 1 .. Length( betti_module[ u+1 ] ) ] do
            diff := UnderlyingListOfRingElements( betti_ideal[ Index+1 ][ j ] ) -
                    UnderlyingListOfRingElements( betti_module[ u+1 ][ l ] );
            tester := PointContainedInVanishingSet( VanishingSets( variety ).( u ), diff );
            if tester = false then
              return false;
            fi;
          od;
        od;
      od;

    fi;

    # check condition 5
    # check condition 5
    if ( Index + 1 < Length( betti_ideal ) ) then

      for j in [ 1 .. Length( betti_ideal[ Index + 1 ] ) ] do
        for u in [ 2 .. Minimum( L_module, Dimension( variety ) + 1 ) ] do
          for l in [ 1 .. Length( betti_module[ u+1 ] ) ] do
            diff := UnderlyingListOfRingElements( betti_ideal[ Index+1 ][ j ] ) -
                    UnderlyingListOfRingElements( betti_module[ u+1 ][ l ] );
            tester := PointContainedInVanishingSet( VanishingSets( variety ).( u-1 ), diff );
            if tester = false then
              return false;
            fi;
          od;
        od;
      od;

    fi;

    # check condition 6
    # check condition 6
    if ( Index + 2 < Length( betti_ideal ) ) then
      for j in [ 1 .. Length( betti_ideal[ Index + 2 ] ) ] do
        for u in [ 2 .. Minimum( L_module, Dimension( variety ) + 1 ) ] do
          for l in [ 1 .. Length( betti_module[ u+1 ] ) ] do
            diff := UnderlyingListOfRingElements( betti_ideal[ Index+2 ][ j ] ) -
                    UnderlyingListOfRingElements( betti_module[ u+1 ][ l ] );
            tester := PointContainedInVanishingSet( VanishingSets( variety ).( u-1 ), diff );
            if tester = false then
              return false;
            fi;
          od;
        od;
      od;

    fi;

    # all tests passed, so return true
    return true;

end );



#############################################################
##
## Section Computation of H0
##
#############################################################

# compute H^0 by applying the theorem from Greg Smith
InstallMethod( H0,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool, IsBool ],
  function( variety, module, display_messages, very_detailed_output )
    local deg, e, module_presentation, ideal_generators, ideal_generators_power, B_power, zero,
         vec_space_morphism;

    # check that the input is valid to work with
    if not ( ( IsSmooth( variety ) and IsComplete( variety ) )
           or ( IsSimplicial( variety ) and IsProjective( variety ) ) ) then

      Error( "variety must either be (smooth, complete) or (simplicial, projective)" );
      return;

    fi;

    # unzip the module
    if IsGradedLeftOrRightSubmoduleForCAP( module ) then
      module_presentation := PresentationForCAP( module );
    else
      module_presentation := module;
    fi;

    # Step 0: compute the vanishing sets
    # Step 0: compute the vanishing sets
    if not HasVanishingSets( variety ) then

      if display_messages then
        Print( "(*) Compute vanishing sets... " );
      fi;
      VanishingSets( variety );
      if display_messages then
        Print( "finished \n" );
      fi;
    else
      if display_messages then
        Print( "(*) Vanishing sets known... \n" );
      fi;
    fi;

    # step 1: compute ideal B( e ) = < deg of smallest ample divisor >^e such that H0 = GradedHom( B(e), M )
    # step 1: compute ideal B( e ) = < deg of smallest ample divisor >^e such that H0 = GradedHom( B(e), M )
    if display_messages then
      Print( "(*) Determine ideal power... " );
    fi;
    deg := ClassOfSmallestAmpleDivisor( variety );
    e := 0;
    ideal_generators := DegreeXLayer( variety, deg );
    ideal_generators_power := List( [ 1 .. Length( ideal_generators ) ], k -> ideal_generators[ k ]^e );
    B_power := GradedLeftSubmoduleForCAP( TransposedMat( [ ideal_generators_power ] ), CoxRing( variety ) );
    while not SHEAF_COHOMOLOGY_INTERNAL_PARAMETER_CHECK( variety, B_power, module_presentation, 0 ) do

      e := e + 1;
      ideal_generators_power := List( [ 1 .. Length( ideal_generators ) ], k -> ideal_generators[ k ]^e );
      B_power := GradedLeftSubmoduleForCAP( TransposedMat( [ ideal_generators_power ] ), CoxRing( variety ) );

    od;
    if display_messages then
      Print( Concatenation( "finished - found: ", String( e ) , "\n" ) );
      Print( "(*) Computing GradedHom... \n" );
    fi;

    # step 2: compute GradedHom
    # step 2: compute GradedHom

    # we have a specialised algorithm for H0 of vector bundles
    zero := List( [ 1 .. Rank( ClassGroup( variety ) ) ], x -> 0 );
    if IsZeroForObjects( Source( UnderlyingMorphism( module_presentation ) ) ) then
      return [ e, UnderlyingVectorSpaceObject(
                             DegreeXLayerOfProjectiveGradedLeftOrRightModule(
                               variety,
                               Range( UnderlyingMorphism( module_presentation ) ),
                               zero
                               )
                                        ) ];
    fi;

    # compute H0 as a vector space presentation
    vec_space_morphism := TOOLS_FOR_HOMALG_GET_REAL_TIME_OF_FUNCTION_CALL(
                                  InternalHomDegreeZeroOnObjects,
                                            variety,
                                            PresentationForCAP( B_power ),
                                            module_presentation,
                                            very_detailed_output
                                  );

    # signal end of computation
    if display_messages then
      Print( "\n" );
      Print( Concatenation( "Computation finished after ", String( vec_space_morphism[ 1 ] ), 
                            " seconds. Summary: \n" ) );
      Print( Concatenation( "(*) used ideal power: ", String( e ), "\n" ) );
      Print( Concatenation( "(*) h^0 = ", String( Dimension( CokernelObject( vec_space_morphism[ 2 ] ) ) ), 
                            "\n \n" ) );
    fi;

    # return the cokernel object of this presentation
    return [ e, CokernelObject( vec_space_morphism[ 2 ] ) ];

    #return "Finished for now";

end );

# convenience method
InstallMethod( H0,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool ],
  function( variety, module, display_messages )

    # by default never show very detailed output
    return H0( variety, module, display_messages, false );

end );

# convenience method
InstallMethod( H0,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ],
  function( variety, module )

    # by default show messages but not the very detailed output
    return H0( variety, module, true, false );

end );



#############################################################
##
#! @Section Computation of Hi
##
#############################################################


# compute H^i by applying my theorem
InstallMethod( Hi,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool, IsBool ],
  function( variety, module, index, display_messages, very_detailed_output )
    local module_presentation, deg, e, ideal_generators, ideal_generators_power, B_power, zero,
         vec_space_morphism;

    # check that the input is valid to work with
    if not ( ( IsSmooth( variety ) and IsComplete( variety ) )
           or ( IsSimplicial( variety ) and IsProjective( variety ) ) ) then

      Error( "variety must either be (smooth, complete) or (simplicial, projective)" );
      return;

    fi;

    # check if the index makes sense
    if ( index < 0 ) or ( index > Dimension( variety ) ) then

      Error( "the cohomological index must not be negative and must not exceed the dimension of the variety" );
      return;

    fi;

    # if we compute H0 hand it over to that method
    if index = 0 then
      return H0( variety, module, display_messages );
    fi;

    # unzip the module
    if IsGradedLeftOrRightSubmoduleForCAP( module ) then
      module_presentation := PresentationForCAP( module );
    else
      module_presentation := module;
    fi;

    # Step 0: compute the vanishing sets
    # Step 0: compute the vanishing sets
    if not HasVanishingSets( variety ) then

      if display_messages then
        Print( "(*) Compute vanishing sets... " );
      fi;
      VanishingSets( variety );
      if display_messages then
        Print( " finished \n" );
      fi;
    else
      if display_messages then
        Print( "(*) Vanishing sets known... \n" );
      fi;
    fi;

    # step 1: compute ideal B( e ) = < deg of smallest ample divisor >^e such that H0 = GradedHom( B(e), M )
    # step 1: compute ideal B( e ) = < deg of smallest ample divisor >^e such that H0 = GradedHom( B(e), M )
    if display_messages then
      Print( "(*) Determine ideal power... " );
    fi;
    deg := ClassOfSmallestAmpleDivisor( variety );
    e := 0;
    ideal_generators := DegreeXLayer( variety, deg );
    ideal_generators_power := List( [ 1 .. Length( ideal_generators ) ], k -> ideal_generators[ k ]^e );
    B_power := GradedLeftSubmoduleForCAP( TransposedMat( [ ideal_generators_power ] ), CoxRing( variety ) );
    while not SHEAF_COHOMOLOGY_INTERNAL_PARAMETER_CHECK( variety, B_power, module_presentation, index ) do

      e := e + 1;
      ideal_generators_power := List( [ 1 .. Length( ideal_generators ) ], k -> ideal_generators[ k ]^e );
      B_power := GradedLeftSubmoduleForCAP( TransposedMat( [ ideal_generators_power ] ), CoxRing( variety ) );

    od;
    if display_messages then
      Print( Concatenation( "finished - found: ", String( e ) , "\n" ) );
      Print( "(*) Computing GradedExt... \n" );
    fi;

    # step 2: compute GradedHom
    # step 2: compute GradedHom

    vec_space_morphism := TOOLS_FOR_HOMALG_GET_REAL_TIME_OF_FUNCTION_CALL(
                                  GradedExtDegreeZeroOnObjects,
                                            index,
                                            variety,
                                            PresentationForCAP( B_power ),
                                            module_presentation,
                                            very_detailed_output
                                  );

    # signal end of computation
    if display_messages then
      Print( "\n" );
      Print( Concatenation( "Computation finished after ", String( vec_space_morphism[ 1 ] ), 
                            " seconds. Summary: \n" ) );
      Print( Concatenation( "(*) used ideal power: ", String( e ), "\n" ) );
      Print( Concatenation( "(*) h^", String( index ), " = ", 
                            String( Dimension( CokernelObject( vec_space_morphism[ 2 ] ) ) ), 
                            "\n \n" ) 
                           );
    fi;

    # and return the result
    return [ e, CokernelObject( vec_space_morphism[ 2 ] ) ];

end );

InstallMethod( Hi,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool ],
  function( variety, module, index, display_messages )

    # by default never show very detailed output
    return Hi( variety, module, index, display_messages, false );

end );

InstallMethod( Hi,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt ],
  function( variety, module, index )

    # by default display messages but suppress the very detailed output
    return Hi( variety, module, index, true, false );

end );



###################################################################################
##
#! @Section My theorem implemented to compute all cohomology classes
##
###################################################################################

# compute all cohomology classes by my theorem
InstallMethod( AllHi,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ],
  function( variety, module )
    local cohoms, i;

    # check that the input is valid to work with
    if not ( ( IsSmooth( variety ) and IsComplete( variety ) )
           or ( IsSimplicial( variety ) and IsProjective( variety ) ) ) then

      Error( "variety must either be (smooth, complete) or (simplicial, projective)" );
      return;

    fi;

    # initialise variables
    cohoms := List( [ 1 .. Dimension( variety ) + 1 ] );

    # and iterate over the cohomology classes
    for i in [ 1 .. Dimension( variety ) + 1 ] do

      # inform about the status of the computation
      Print( Concatenation( "Computing h^", String( i-1 ), "\n" ) );
      Print(  "----------------------------------------------\n" );

      # make the computation - only display messages
      cohoms[ i ] := Hi( variety, module, i-1, true, false );

    od;

    # computation completely finished, so print summary
    Print( "Finished all computations. Summary: \n" );
    for i in [ 1 .. Dimension( variety ) + 1 ] do
      Print( Concatenation( "h^", String( i-1 ), " = ", String( Dimension( cohoms[ i ][ 2 ] ) ), "\n" ) );
    od;

    # and finally return the results
    return cohoms;

end );



#######################################################################
##
## Section Write matrices to be used for H0 computation via GS to files
##
#######################################################################

if false then

# compute H^0 by applying the theorem from Greg Smith
InstallMethod( H0ByGSWritingMatricesUsedByFastInternalHomToFilesForCAP,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool ],
  function( variety, module, saturation_wished )
    local deg, ideal_generators, B, mSat, e, B_power, vec_space_presentation;

    # check that the input is valid to work with
    if not IsSmooth( variety ) then

      Error( "Variety must be smooth" );
      return;

    elif not IsProjective( variety ) then

      Error( "Variety must be projective (which implies completness)" );
      return;

    fi;

    # compute smallest ample divisor via Nef cone
    deg := ClassOfSmallestAmpleDivisor( variety );

    # and the corresponding ideal in the Coxring that is generated by this degree layer
    ideal_generators := DegreeXLayer( variety, deg );
    B := GradedLeftSubmoduleForCAP( TransposedMat( [ ideal_generators ] ), CoxRing( variety ) );

    # saturate the module
    mSat := module;
    if saturation_wished then
      mSat := Saturate( module, B );
    fi;

    # turn into module presentation if needed
    if IsGradedLeftOrRightSubmoduleForCAP( mSat ) then
      mSat := PresentationForCAP( mSat );
    fi;

    # determine integer e that we need to perform the computation of the cohomology
    e := 0;
    while not TORIC_VARIETIES_INTERNAL_GS_PARAMETER_CHECK_FOR_CAP( variety, e, mSat, deg, 0 ) do
      e := e + 1;
    od;

    # inform the user that we have found a suitable e
    Print( Concatenation( "Found integer: ", String( e ) , "\n" ) );

    # compute the appropriate Frobenius power of the ideal B
    ideal_generators := List( [ 1 .. Length( ideal_generators ) ], k -> ideal_generators[ k ]^e );
    B_power := GradedLeftSubmoduleForCAP( TransposedMat( [ ideal_generators ] ), CoxRing( variety ) );

    # compute the necessary matrices and save them to files
    InternalHomDegreeZeroOnObjectsWrittenToFiles( variety, PresentationForCAP( B_power ), mSat );

    # return true
    return true;

end );

# compute H^0 by applying the theorem from Greg Smith
InstallMethod( H0ByGSWritingMatricesUsedByFastInternalHomToFilesForCAP,
               " for a toric variety, a f.p. graded S-module ",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ],
  function( variety, module )

    return H0ByGSWritingMatricesUsedByFastInternalHomToFilesForCAP( variety, module, false );

end );

fi;