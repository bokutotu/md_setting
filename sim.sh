
gmx pdb2gmx -f ../md_inputs/1d9v_remove_po4.pdb -o 1d9v.gro -ff charmm27 --water tip3p
gmx editconf -f 1d9v.gro -c -bt cubic -d 1.0 -o newbox.gro
gmx solvate -cp newbox.gro -cs ../md_inputs/spc216.gro -p topol.top -o solv.gro
gmx grompp -f ../md_inputs/ions.mdp -c solv.gro -p topol.top -o ions.tpr -maxwarn 1
echo 13 | gmx genion -s ions.tpr -o solv_ions.gro -p topol.top -nname CL -nn 1

gmx grompp -f ../md_inputs/minim.mdp -c solv_ions.gro -p topol.top -o em.tpr -maxwarn 1
gmx mdrun -v -deffnm em

gmx grompp -f ../md_inputs/nvt.mdp -c em.gro -p topol.top -r em.gro -o nvt.tpr -maxwarn 1
gmx mdrun -deffnm nvt

gmx grompp -f ../md_inputs/npt.mdp -c nvt.gro -p topol.top -r nvt.gro -o npt.tpr -maxwarn 1
gmx mdrun -deffnm npt

gmx grompp -f ../md_inputs/md.mdp -c npt.gro -t npt.cpt -p topol.top -o md_0_1.tpr -maxwarn 1
gmx mdrun -deffnm md_0_1

gmx grompp -f ../md_inputs/md.mdp -c md_0_1.gro -t md_0_1.cpt -p topol.top -o md_0_2.tpr -maxwarn 1
gmx mdrun -deffnm md_0_2

gmx grompp -f ../md_inputs/md.mdp -c md_0_2.gro -t md_0_2.cpt -p topol.top -o md_0_3.tpr -maxwarn 1
gmx mdrun -deffnm md_0_3

echo 1 | gmx trjconv -s md_0_1.tpr -f md_0_1.trr -o md_0_1_noPBC.trr -pbc mol -ur compact -b 1 -force
echo 1 | gmx trjconv -s md_0_2.tpr -f md_0_2.trr -o md_0_2_noPBC.trr -pbc mol -ur compact -b 1 -force
echo 1 | gmx trjconv -s md_0_3.tpr -f md_0_3.trr -o md_0_3_noPBC.trr -pbc mol -ur compact -b 1 -force

gmx dump -f md_0_1_noPBC.trr > md_0_1_noPBC3.trj
gmx dump -f md_0_2_noPBC.trr > md_0_2_noPBC3.trj
gmx dump -f md_0_3_noPBC.trr > md_0_3_noPBC3.trj
