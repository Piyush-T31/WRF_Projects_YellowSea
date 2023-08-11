#!/bin/bash
#SBATCH --nodes=2
#SBATCH --time=00-06:00:00
#SBATCH --job-name="WRF"

#SBATCH --ntasks-per-node=32
#SBATCH --mem=128000M
#SBATCH --mail-user=teelokup@gmail.com
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --account=def-yochen
srun ./wrf.exe
