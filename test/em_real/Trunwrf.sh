#!/bin/bash
#SBATCH --nodes=2
#SBATCH --time=00-06:00:00
#SBATCH --job-name="WRF"
#SBATCH --gres=gpu:v100:4
#SBATCH --cpus-per-task=14
#SBATCH --mem=125G
#SBATCH --mail-user=teelokup@gmail.com
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --account=def-yochen
module load arch/avx512 StdEnv/2018.3
srun ./wrf.exe
