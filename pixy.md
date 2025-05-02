```
module purge && module load Miniconda3
source $(conda info --base)/etc/profile.d/conda.sh
export PYTHONNOUSERSITE=1
conda config --add pkgs_dirs /nesi/nobackup/uoo04226/spige432/conda_pkgs
conda create --prefix /nesi/project/uoo04226/pixy python=3.8
conda activate /nesi/project/uoo04226/pixy
conda install conda-forge::pixy
```
```
module load Miniconda3
conda init
conda activate /nesi/project/uoo04226/pixy/
```
