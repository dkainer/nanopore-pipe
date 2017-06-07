# nanopore-pipe
A set of scripts for QC, alignment, assembly, variant calling of MinION nanopore data

These scripts are designed to run on the NCI Raijin cluster. They include PBS pro jobs that can be edited to run on other clusters (maybe?)

## Tools

### Albacore (1.1.1)
Installed and set up as a module. Here is the module file contents.
```
#%Module1.0#####################################################################
source /opt/Modules/extensions/extensions.tcl
proc ModulesHelp { } {
        puts stderr "\tAdds albacore bin directory to the path"
}
module-whatis "albacore"
soft-prereq python3/3.5.2
set albacoreversion 1.1.1
prepend-path PATH ~/apps/albacore/bin
prepend-path PYTHONPATH ~/apps/albacore/lib/python3.5/site-packages
```

To run Albacore:
```
$ module load albacore
$ read_fast5_basecaller.py <params>
```

### Poretools (0.6.0)
Installed and set up as a module. Here is the module file contents.
```
#%Module1.0#####################################################################
source /opt/Modules/extensions/extensions.tcl
proc ModulesHelp { } {
        puts stderr "\tAdds poretools bin directory to the path"
}
module-whatis "poretools"
soft-prereq python/2.7.11
soft-prereq python/2.7.11-matplotlib
set poretoolsversion 0.6.0
prepend-path PATH ~/apps/poretools/0.6.0/bin
prepend-path PYTHONPATH ~/apps/poretools/0.6.0/lib/python2.7/site-packages
```

to run Poretools:
```
$ module load poretools
$ poretools <params>
```
