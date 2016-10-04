#############################################################################
##
##  VanishingSets.gd     ToricVarieties       Martin Bies
##
##  Copyright 2015- 2016, Sebastian Gutsche, TU Kaiserslautern
##                        Martin Bies,       ITP Heidelberg
##
#! @Chapter Computation of vanishing sets
##
#############################################################################


#################################
##
#! @Section The GS-cone
##
#################################

#! For the computation of sheaf cohomology on toric varieties, knowledge about vanishing sets is important. One particular
#! such vanishing set is a cone $C$ in the class_group of the variety in question. For all points in $C$, the associated
#! coherent sheaf has vanishing $H^i$ for $i > 0$. As this cone was introduced in arXiv:math/0305214 we call it the 
#! Gregory-Smith-Cone and abbreviate it by \emph{GSCone}.
#! In this paper, we use Corollary 3.8 to identiy $C$ with $K^{\text{sat}}$. By the remark given
#! below example 2.7 we know that for smooth toric varieties we have $K = K^{\text{sat}}$. Finally we use the 
#! description given at the bottom of page 4 to compute the semigroup $K$. The following method performs this very computation.

#! @Description
#! Given a smooth toric variety <A>vari</A>, this method returns a ConeHPresentationList which defines the GS-cone.
#! @Returns a ConeHPresentationList
#! @Arguments vari
DeclareAttribute( "GSCone",
                 IsToricVariety );


###########################################
##
#! @Section GAP category for vanishing sets
##
###########################################

#! @Description
#! The GAP category of vanishing sets formed from affine semigroups.
DeclareCategory( "IsVanishingSet",
                 IsObject );



############################################
##
#! @Section Constructors
##
############################################

#! @Description
#! The argument is a toric variety, a list $L$ of AffineSemigroups and the cohomological index $i$. 
#! Alternatively a string $s$ can be used instead of $d$ to inform the user for which cohomology classes
#! this set identifies the 'vanishing twists'.
#! @Returns a vanishing set
#! @Arguments variety, L, d, i or s
DeclareOperation( "VanishingSet",
                  [ IsToricVariety, IsList, IsInt ] );
DeclareOperation( "VanishingSet",
                  [ IsToricVariety, IsList, IsString ] );



############################################
##
#! @Section Attributes
##
############################################

#! @Description
#! The argument is a vanishingSet $V$. We then return the underlying list of semigroups that form this vanishing set.
#! @Returns a list of affine semigroups
#! @Arguments V
DeclareAttribute( "ListOfUnderlyingAffineSemigroups",
                  IsVanishingSet );

#! @Description
#! The argument is a vanishingSet $V$. We then return the embedding dimension of this vanishing set.
#! @Returns a non-negative integer
#! @Arguments V
DeclareAttribute( "EmbeddingDimension",
                  IsVanishingSet );

#! @Description
#! The argument is a vanishingSet $V$. This vanishing set identifies those $D \in \text{Pic} \left( X_\Sigma \right)$
#! such that $H^i \left( X_\Sigma, \mathcal{O} \left( D \right) \right) = 0$. We return the integer $i$.
#! @Returns an integer between $0$ and $\text{dim} \left( X_\Sigma \right)$
#! @Arguments V
DeclareAttribute( "CohomologicalIndex",
                  IsVanishingSet );

#! @Description
#! The argument is a vanishingSet $V$. This could for example identify those $D \in \text{Pic} \left( X_\Sigma \right)$
#! such that $H^i \left( X_\Sigma, \mathcal{O} \left( D \right) \right) = 0$ for all $i > 0$. 
#! If such a specification is known, it will be returned by this method.
#! @Returns a string
#! @Arguments V
DeclareAttribute( "CohomologicalSpecification",
                  IsVanishingSet );

#! @Description
#! The argument is a vanishingSet $V$. We return the toric variety to which this vanishing set belongs.
#! @Arguments V
DeclareAttribute( "AmbientToricVariety",
                  IsVanishingSet );


############################################
##
#! @Section Property
##
############################################

#! @Description
#! The argument is a VanishingSet $V$. We then check if this vanishing set is empty.
#! @Arguments V
DeclareProperty( "IsFull",
                  IsVanishingSet );



#################################################
##
#! @Section Improved vanishing sets via cohomCalg
##
#################################################

#!
DeclareOperation( "TORIC_VARIETIES_INTERNAL_COHOMCALG_COMMAND_STRING",
                   [ IsToricVariety, IsList ] );

#!
DeclareOperation( "TORIC_VARIETIES_INTERNAL_COHOMCALG_COMMAND_STRING",
                   [ IsToricVariety ] );

#!
DeclareOperation( "ContributingDenominators",
                   [ IsToricVariety ] );

#!
DeclareOperation( "TurnDenominatorIntoShiftedSemigroup",
                   [ IsToricVariety, IsString ] );

#!
DeclareOperation( "VanishingSets",
                   [ IsToricVariety ] );
DeclareOperation( "VanishingSets",
                   [ IsToricVariety, IsBool ] );

#!
DeclareAttribute( "ImprovedVanishingSetForGS",
                   IsToricVariety );

#!
DeclareOperation( "PointContainedInVanishingSet",
                  [ IsVanishingSet, IsList ] );