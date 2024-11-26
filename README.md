# Redbox Software Decompilation Patches

These are patches to get an exported project to a compilable project

## Usage

These patches are created based on exports from dotPeek, this is becaues dotPeek provides the best and closest to original code. Therefore you will need to install dotPeek. Unfortunatly at this time, dotPeek does not support any form of command line automation, so some manual steps are required:

-   Install dotPeek and Git
-   Open dotPeek, drag the correct exe or dll into the left panel
-   Right click on the imported assembly, choose `Export to Project`
-   Destination folder should be set to the corisponding folder in this repo, ex: MSHALTester should be `<path to cloned repo>\MSHALTester\export`
-   Leave the `Project Name` field as it is
-   Make sure `Create *.sln file` is the only option that is checked
-   Click `Export`
-   On the bottom right, you will see something along the lines of `Generating`, wait until this is gone
-   In a powershell window, run `.\Patch <name of folder>`, ex: `.\Patch MSHALTester`
