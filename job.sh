#!/bin/bash
#$ -S /bin/bash
#$ -N gmx
#$ -cwd

singularity exec --nv ~/singularity_image/gromacs-2018.2-gpu.simg sh ../md_inputs/sim.sh
# singularity exec --nv ~/singularity_image/gromacs-2018.2-gpu.simg gmx pdb2grmx -f ../md_inputs/1d9v_remove_po4.pdb -o 1d9v.gro
# singularity exec --nv ~/singularity_image/gromacs-2018.2-gpu.simg gmx editconf -f 1d9v.gro -c -bt cubic -d 1.0 -o newbox.gro
# singularity exec --nv ~/singularity_image/gromacs-2018.2-gpu.simg gmx solvate -cp newbox.gro -cs ../md_inputs/spc216.gro -p topol.top -o solv.gro
# singularity exec --nv ~/singularity_image/gromacs-2018.2-gpu.simg gmx grompp -f ../md_inputs/ions.mdp -c solv.gro -p topol.top -o ions.tpr -maxwarn 1
# singularity exec --nv ~/singularity_image/gromacs-2018.2-gpu.simg echo 13 | gmx genion -s ions.tpr -o solv_ions.gro -p topol.top -nname CL -nn 1

# singularity exec --nv ~/singularity_image/gromacs-2018.2-gpu.simg gmx grompp -f ../md_inputs/minim.mdp -c solv_ions.gro -p topol.top -o em.tpr -maxwarn 1
# singularity exec --nv ~/singularity_image/gromacs-2018.2-gpu.simg gmx mdrun -v -deffnm em

# singularity exec --nv ~/singularity_image/gromacs-2018.2-gpu.simg gmx grompp -f ../md_inputs/nvt.mdp -c em.gro -p topol.top -r em.gro -o nvt.tpr -maxwarn 1
# singularity exec --nv ~/singularity_image/gromacs-2018.2-gpu.simg gmx mdrun -deffnm nvt

# singularity exec --nv ~/singularity_image/gromacs-2018.2-gpu.simg gmx grompp -f ../md_inputs/npt.mdp -c npt.gro -p topol.top -r npt.gro -o em.tpr -maxwarn 1
# singularity exec --nv ~/singularity_image/gromacs-2018.2-gpu.simg gmx mdrun -deffnm npt

# singularity exec --nv ~/singularity_image/gromacs-2018.2-gpu.simg gmx grompp -f ../md_inputs/md.mdp -c npt.gro -t npt.cpt -p topol.top -o md_0_1.tpr -maxwarn 1
# singularity exec --nv ~/singularity_image/gromacs-2018.2-gpu.simg gmx mdrun -deffnm md_0_1

# singularity exec --nv ~/singularity_image/gromacs-2018.2-gpu.simg gmx grompp -f ../md_inputs/md.mdp -c npt.gro -t npt.cpt -p topol.top -o md_0_2.tpr -maxwarn 1
# singularity exec --nv ~/singularity_image/gromacs-2018.2-gpu.simg gmx mdrun -deffnm md_0_2

# singularity exec --nv ~/singularity_image/gromacs-2018.2-gpu.simg gmx grompp -f ../md_inputs/md.mdp -c npt.gro -t npt.cpt -p topol.top -o md_0_2.tpr -maxwarn 1
# singularity exec --nv ~/singularity_image/gromacs-2018.2-gpu.simg gmx mdrun -deffnm md_0_3

