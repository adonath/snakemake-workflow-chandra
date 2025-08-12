[![DOI](https://zenodo.org/badge/602190503.svg)](https://doi.org/10.5281/zenodo.16813370)

# Snakemake Workflow for Chandra Data Reduction

This is an example snakemake workflow for data reduction of Chandra data. 
The workflow will run the standrad `ciao` tools for a given configuration
and produce as output FITS files. Thereby it will handle the reduction of
 counts, exposure and point spread function (PSF).

## Getting Started
### Use as Snakemake Module (recommended)

If you would like use this as Snakmake module you should add e.g. the following to your `Snakefile`:

```python3
module chandra_data_workflow:
    snakefile:
        # here, plain paths, URLs and the special markers for code hosting providers (see below) are possible.
        github("adonath/snakemake-workflow-chandra", path="workflow/Snakefile", branch="main")
    config: config["chandra-data"]

use rule * from chandra_data_workflow as chandra_data_*
```

See also https://snakemake.readthedocs.io/en/stable/snakefiles/modularization.html#modularization

### Setup Environment 
Start by cloning this repository to your local machine:
```bash
git clone https://github.com/adonath/snakemake-workflow-chandra.git
```

If you havn't done yet, please install [conda](https://www.anaconda.com/products/distribution)
or [mamba](https://mamba.readthedocs.io/en/latest/installation.html).

Now change to the directory of the repository:
```bash
cd snakemake-workflow-chandra/
```

And create the conda environment using:
```bash
mamba env create -f environment.yaml
```

Once the process is done you can activate the environment:

```bash
conda activate snakemake-workflow-chandra
```

### Configure and Run the Workflow
Now you should adapt the configuration in [config/config.yaml](config/config.yaml)
to match your data. 

Then you are ready to run the workflow, like:
```bash
snakemake --cores 8 --use-conda --configfile config/config.yaml
```

You can also create a report to see previews of the counts, exposure and PSF images:
```bash
snakemake --report report.html
open report.html
```

You can also create a directed acyclic graph (DAG) visualization of the workflow:

```bash
snakemake --dag | dot -Tpng > dag.png
```
