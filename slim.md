module purge && module load Miniconda3
source $(conda info --base)/etc/profile.d/conda.sh
export PYTHONNOUSERSITE=1
conda config --add pkgs_dirs /nesi/nobackup/uoo04226/spige432/conda_pkgs
conda create --prefix /nesi/project/uoo04226/admixture_env python=3.8
#use "y" and enter to proceed
conda activate /nesi/project/uoo04226/slim_env
conda install conda-forge::slim
#use "y" and enter to proceed
