##########################################################################################
##
##  CohomologyViaGSForCAP.gd         ToricVarieties package
##
##  Copyright 2015- 2016, Sebastian Gutsche, TU Kaiserslautern
##                        Martin Bies,       ITP Heidelberg
##
#! @Chapter Sheaf cohomology via the theorem of Greg. Smith for CAP
##
#########################################################################################



#############################################################
##
#! @Section Specialised InternalHom methods
##
#############################################################

#!
DeclareOperation( "InternalHomDegreeZeroOnObjects",
                [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsGradedLeftOrRightModulePresentationForCAP, IsBool ] );

#!
DeclareOperation( "InternalHomDegreeZeroOnObjectsWrittenToFiles",
                [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsGradedLeftOrRightModulePresentationForCAP ] );

#!
DeclareOperation( "InternalHomDegreeZeroOnMorphisms",
                [ IsToricVariety, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsGradedLeftOrRightModulePresentationMorphismForCAP, IsBool ] );

#!
DeclareOperation( "GradedExtDegreeZeroOnObjects",
                [ IsInt, IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsGradedLeftOrRightModulePresentationForCAP, IsBool ] );


#############################################################
##
#! @Section Computation of H0 by my theorem
##
#############################################################

#! @Description
#! Computation of sheaf cohomology from my own theorem
#! @Returns a list consisting of an integer and a vector space
#! @Arguments vari, M
DeclareOperation( "H0ByGSForCAP",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool, IsBool, IsBool ] );

DeclareOperation( "H0ByGSForCAP",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool, IsBool ] );

DeclareOperation( "H0ByGSForCAP",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool ] );

DeclareOperation( "H0ByGSForCAP",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ] );



#############################################################
##
#! @Section Computation of Hi by my theorem
##
#############################################################

#! @Description
#! Computation of sheaf cohomology from my own theorem
#! @Returns a list consisting of an integer and a vector space
#! @Arguments vari, M, i
DeclareOperation( "HiByGSForCAP",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool, IsBool, IsBool ] );

DeclareOperation( "HiByGSForCAP",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool, IsBool ] );

DeclareOperation( "HiByGSForCAP",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool ] );

DeclareOperation( "HiByGSForCAP",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt ] );



###################################################################################
##
#! @Section Computation of all sheaf cohomologies from my own theorem
##
###################################################################################

#! @Description
#! Computation of all sheaf cohomology classes from my theorem
#! @Returns a list of lists, which in turn consist each of an integer and a vector space
#! @Arguments vari, M
DeclareOperation( "AllCohomologiesByGSForCAP",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool, IsBool, IsBool ] );

DeclareOperation( "AllCohomologiesByGSForCAP",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool, IsBool ] );

DeclareOperation( "AllCohomologiesByGSForCAP",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool ] );

DeclareOperation( "AllCohomologiesByGSForCAP",
               [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ] );



#############################################################
##
#! @Section Check if H0 is greater than a given lower bound
##
#############################################################

#! @Description
#! Given a smooth and projective toric variety with Coxring <M>S</M> and a f. p. graded S-module <M>M</M>, this method uses a 
#! theorem by Greg Smith to check if <M>H^0 \left( X_\Sigma, \widetilde{M} \right)</M> on this toric variety is greater than 
#! a lower bound B.
#! To this end first the smallest ample bundle is computed (which is in turn achieved by considering the Nef cone).
#! Suppose the class of this bundle is <M>d</M>, then let <M>C \subseteq S</M> be the degree <M>d</M> layer. Then
#! <M>C^\prime := C \cdot S</M> is a f.p. graded <M>S</M>-module. Subsequently the algorithm tries to find an integer
#! <M> e </M> such that the degree zero layer of <M>\text{Hom} \left( {C^\prime}^{e}, M \right)</M> is isomorphic to
#! <M>H^0 \left( X_\Sigma, \widetilde{M} \right)</M>. The theorem of G. Smith is used as criterion to decide if an integer 
#! <M> e </M> satisfies this requirement. 
#! In case such an integer <M> e </M> is found, the method computes the vector space
#! <M> V( f ) := \text{Hom}_S \left( {C^\prime}^{f}, M \right)_0</M> for <M> 0 \leq f \leq e</M>. After every computation, 
#! it is checked if the dimension of <M>V(f)</M> is strctly greater than <M> B </M>. If this is the case the method returns
#! true and terminates. If not, the method continues till <M> f = e </M> and then returns if <M> dim( V(e) ) </M> is strictly
#! greater than the given lower bound <M> B</M>.
#! Note that a boolean $b$ can be provided as third argument to specify if the module should be saturated before the 
#! computation. $b = true$ will trigger the saturation, $b = false$ will prevent it. The default value is
#! $b = false$.
#! Another boolean $b2$ can be provided as fourth argument. It specifies if a fast algorithm for the InternalHom computation
#! should be applied. $b2 = true$ will trigger this fast algorithm, $b2 = false$ will prevent it. The default value is
#! $b2 = true$.
#! @Returns true or false
#! @Arguments vari, M, B
DeclareOperation( "H0GreaterThanLowerBoundByGSForCAP",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool, IsBool ] );

DeclareOperation( "H0GreaterThanLowerBoundByGSForCAP",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt, IsBool ] );

DeclareOperation( "H0GreaterThanLowerBoundByGSForCAP",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsInt ] );



#######################################################################
##
#! @Section Write matrices to be used for H0 computation via GS to files
##
#######################################################################

#!
DeclareOperation( "H0ByGSWritingMatricesUsedByFastInternalHomToFilesForCAP",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP, IsBool ] );

DeclareOperation( "H0ByGSWritingMatricesUsedByFastInternalHomToFilesForCAP",
                  [ IsToricVariety, IsGradedLeftOrRightModulePresentationForCAP ] );
