##########################################################################################
##
##  CohomologyWithSpasm.gd             SheafCohomologyOnToricVarieties package
##
##  Copyright 2020                     Martin Bies,       University of Oxford
##
#! @Chapter Sheaf cohomology computations (https://arxiv.org/abs/1802.08860) with Spasm
##
#########################################################################################

#############################################################
##
#! @Section Cohomology from Spasm, Linbox and Singular
##
#############################################################

#! @Description
#! Given a variety $V$ and an f.p. graded $S$-module $M$ ($S$ being
#! the Cox ring of $V$), this method computes $H^0( V, \tilde{M} )$.
#! It uses a combination of Singular and Spasm to perform this task.
#! The latter operates in a finite field. By default we use the 
#! field modulo 42013. However, a prime can be specified as third
#! argument to overwrite this choice. In addition, the boolean 'false'
#! can be specified as fourth argument to suppress output during the
#! computation.
#! @Returns a vector space
#! @Arguments V, M, prime p, boolean b
DeclareOperation( "H0ParallelBySpasm",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject ] );

DeclareOperation( "H0ParallelBySpasm",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsInt ] );

DeclareOperation( "H0ParallelBySpasm",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsInt, IsBool ] );


#############################################################
##
#! @Section Computation of truncated internal hom
##
#############################################################

DeclareOperation( "TruncateIntHomToZeroInParallelBySpasm",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsFpGradedLeftOrRightModulesObject, IsInt, IsBool ] );


#############################################################
##
#! @Section Truncation to sparse matrices
##
#############################################################

#! @Description
#! Truncates a morphism alpha of f.p. graded left or right modules over
#! the Cox ring of a toric variety V and returns a list of 3 sparse matrices.
#! The boolean b at third position specifies whether information is printed
#! whilst running this computation.
#! @Returns a list of 3 sparse matrices
#! @Arguments V, alpha, b
DeclareOperation( "TruncateFPGradedModuleMorphismToZeroInParallelToSparseMatrices",
                  [ IsToricVariety, IsFpGradedLeftOrRightModulesMorphism, IsBool ] );
