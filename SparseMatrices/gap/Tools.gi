#############################################################################
##
##  Tools.gi            SparseMatrices package
##                      Martin Bies
##
##  Copyright 2020      University of Oxford
##
##  A package to handle sparse matrices in gap
##
#############################################################################



##############################################################################################
##
## Section Find the SmastoDirectory
##
##############################################################################################


InstallMethod( FindSmastoDirectory,
               "",
               [ ],
  function( )
  local smasto_directory, package_directory, s, file, sys_programs, which, path, output, input, path_steps;
    
    # Initialse spasm_directory with fail and try in the following to do better
    smasto_directory := fail;
    
    # There might be a file in the PackageFolder in which the path to Spasm is noted down
    # So try to set up a stream to that file
    package_directory := DirectoriesPackageLibrary( "SparseMatrices", "gap" );
    if Length( package_directory ) > 1 then
        # If there are at least two versions, then we cannot find the SpasmDirectory uniquely
        Error( "Found at least two versions of SparseMatrices - unable to determine SmastoDirectory" );
        return;
    fi;
    package_directory := package_directory[ 1 ];
    smasto_directory := Directory( ReplacedString( Filename( package_directory, "" ), "gap/", "bin/" ) );
    
    # return the result
    return smasto_directory;
    
end );

InstallMethod( SetSmastoDirectory,
               "a string",
               [ IsString ],
  function( path )
    local package_directory, file;

    # We want to write a file to the PackageFolder in which we store the location of Spasm
    package_directory := DirectoriesPackageLibrary( "SparseMatrices", "gap" );
    if Length( package_directory ) > 1 then
        # If there are at least two versions, then we cannot know in which folder to write
        Error( "Found at least two versions of SparseMatrices - unable to set SmastoDirectory" );
        return;
    fi;
    package_directory := package_directory[ 1 ];
    file := Filename( package_directory, "SmastoDirectory.txt" );
    
    # Now create this file/overwrite any existing such file
    PrintTo( file, path );
    
    # Signal sucess
    Print( "Smasto directory set successfully \n" );
    return true;
    
end );
