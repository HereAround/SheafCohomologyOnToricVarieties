################################################################################################
##
##  ToricVarietiesAdditionalPropertiesForCAP.gd        SheafCohomologyOnToricVarieties package
##
##  Copyright 2019                                     Martin Bies,       ULB Brussels
##
#! @Chapter Additional methods/properties for toric varieties
##
################################################################################################


######################
##
#! @Section Properties
##
######################

#! @Description
#! Returns if the given variety V is a valid input for cohomology computations.
#! If the variable SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_INTERNAL_LAZY is set to false (default),
#! then we just check if the variety is smooth, complete. In case of success we return true and
#! false otherwise. If however SHEAF_COHOMOLOGY_ON_TORIC_VARIETIES_INTERNAL_LAZY is set to true,
#! then we will check if the variety is smooth, complete or simplicial, projective. In case of
#! success we return true and false other.
#! @Arguments V
DeclareProperty( "IsValidInputForCohomologyComputations",
                  IsToricVariety );


######################
##
#! @Section Attributes
##
######################

#! @Description
#! Returns the irrelevant left ideal of the Cox ring of the variety <A>vari</A>, using the language of CAP.
#! @Returns a graded left ideal for CAP
#! @Arguments vari
DeclareAttribute( "IrrelevantLeftIdealForCAP",
                  IsToricVariety );

#! @Description
#! Returns the irrelevant right ideal of the Cox ring of the variety <A>vari</A>, using the language of CAP.
#! @Returns a graded right ideal for CAP
#! @Arguments vari
DeclareAttribute( "IrrelevantRightIdealForCAP",
                  IsToricVariety );

#! @Description
#! Returns the Stanley-Reißner left ideal of the Cox ring of the variety <A>vari</A>, using the langauge of CAP.
#! @Returns a graded left ideal for CAP
#! @Arguments vari
DeclareAttribute( "SRLeftIdealForCAP",
                 IsToricVariety );

#! @Description
#! Returns the Stanley-Reißner right ideal of the Cox ring of the variety <A>vari</A>, using the langauge of CAP.
#! @Returns a graded right ideal for CAP
#! @Arguments vari
DeclareAttribute( "SRRightIdealForCAP",
                 IsToricVariety );

#! @Description
#!  Given a toric variety <A>variety</A> one can consider the Cox ring $S$ of this variety, which is graded over the
#!  class group of <A>variety</A>. Subsequently one can consider the category of f.p. graded left $S$-modules. 
#!  This attribute captures the corresponding CapCategory.
#! @Returns a CapCategory
#! @Arguments variety
DeclareAttribute( "SfpgrmodLeft",
                 IsToricVariety );

#! @Description
#!  Given a toric variety <A>variety</A> one can consider the Cox ring $S$ of this variety, which is graded over the
#!  class group of <A>variety</A>. Subsequently one can consider the category of f.p. graded right $S$-modules. 
#!  This attribute captures the corresponding CapCategory.
#! @Returns a CapCategory
#! @Arguments variety
DeclareAttribute( "SfpgrmodRight",
                 IsToricVariety );
