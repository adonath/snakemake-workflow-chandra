# Snakemake Workflow for Chandra Data Reduction

This is an example snakemake workflow for data reduction of Chandra data. 
The workflow will run the standrad `ciao` tools for a given configuration
and produce as output FITS files. Thereby it will handle the reduction of
 counts, exposure and point spread function (PSF).

## Getting Started

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
snakemake --cores 8
```

You can also create a report to see previews of the counts, exposure and PSF images:
```bash
snakemake --report report.html
open report.html
```