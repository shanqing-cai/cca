cca
===

Consonant context and adaptation

Note: this code cannot run on its own. It depends on 

1) Audapter-2.0. Write to Shanqing Cai to request it if needed.

2) The "commonmcode" repository of Shanqing Cai, located at: https://github.com/shanqing-cai/commonmcode

To get started, please study mcode/cca_example_1.m

This script loads a pre-recorded speech datum stored in Audapter's standard .mat format. The scripts loads two ASCII files into Audapter. The first file (e.g., "ost_1") sets the parameters for online setence tracking. The second file (e.g., "f1_up_f2_down.pcf") sets the perturbation parameter.

Note: the parameters in the ost_1 file are currently handcrafted. For real experiments, some heuristics need to be designed in order to automatize the online sentence tracking parameter selection. 

The pdf files "ostParams.pdf" and "PertCfgFileFormat.pdf" contain some brief description of the format of the two configraution files. The scripts generates a figure with two panels. The upper panel shows the input signal and the bottom panel shows the output. The script also plays the input and output sounds.


