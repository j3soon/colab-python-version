# This script is intended to be used with a specially modified Colab notebook.
# i.e., https://colab.research.google.com/github/j3soon/colab-python-version/blob/main/notebooks/py38.ipynb
# For more information, see: https://github.com/j3soon/colab-python-version.

wget -O miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-py38_23.11.0-2-Linux-x86_64.sh
bash ./miniconda.sh -b -f -p /usr/local
conda install -q -y jupyter google-colab traitlets=5.5.0 -c conda-forge
python -m ipykernel install --name "py38" --user
rm ./miniconda.sh
