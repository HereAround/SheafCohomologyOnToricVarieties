##########################################################################################
##
##  CohomologyFromResolution.gd        SheafCohomologyOnToricVarieties package
##
##  Copyright 2020                     Martin Bies,       University of Oxford
##
#! @Chapter Cohomology of coherent sheaves from resolution
##
#########################################################################################


#############################################################################################################
##
#! @Section Deductions On Sheaf Cohomology From Cohomology Of projective modules in a minimal free resolution
##
#############################################################################################################

#! @Description
#! Given a smooth and projective toric variety <M>vari</M> with Coxring <M>S</M> and a f. p.
#! graded S-modules <M>M</M>, this method computes a minimal free resolution of <M>M</M> and then the dimension of the cohomology
#! classes of the projective modules in this minimal free resolution.
#! @Returns a list of lists of integers
#! @Arguments vari, M
DeclareOperation( "CohomologiesList",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject ] );

#! @Description
#! Given a smooth and projective toric variety <M>vari</M> with Coxring <M>S</M> and a f. p.
#! graded S-modules <M>M</M>, this method computes a minimal free resolution of <M>M</M> and then the dimension of the cohomology
#! classes of the projective modules in this minimal free resolution. From this information we draw conclusions on the sheaf
#! cohomologies of the sheaf <M>\tilde{M}</M>.
#! @Returns a list
#! @Arguments vari, M
DeclareOperation( "DeductionOfSheafCohomologyFromResolution",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject, IsBool ] );

DeclareOperation( "DeductionOfSheafCohomologyFromResolution",
               [ IsToricVariety, IsFpGradedLeftOrRightModulesObject ] );

DeclareOperation( "AnalyseShortExactSequence",
                  [ IsList ] );
