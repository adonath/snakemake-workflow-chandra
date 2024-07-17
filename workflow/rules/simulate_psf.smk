
def get_simulate_psf_args(wildcards):
    from astropy.table import Table
    config_psf = config_obj.irfs[wildcards.irf_label].psf
    
    # This is a workaround for the HETG grating, see https://github.com/cxcsds/ciao-contrib/issues/882 
    table = Table.read(f"data/{wildcards.obs_id}/oif.fits")
    grating = table.meta["GRATING"]

    numsig_current = config_psf.numsig
    
    if grating == "HETG":
        config_psf.numsig = 1.

    args = config_psf.to_cmd_args()

    config_psf.numsig = numsig_current

    return args

rule simulate_psf:
    input:
        infile="results/{config_name}/{obs_id}/events/{config_name}-{obs_id}-events.fits",
        spectrum="results/{config_name}/spectral-fit/{irf_label}/{config_name}-{irf_label}-source-flux-chart.dat",
    output:
        filename_psf="results/{config_name}/{obs_id}/psf/{irf_label}/{psf_simulator}/{psf_simulator}.psf",
        filename_rays="results/{config_name}/{obs_id}/psf/{irf_label}/{psf_simulator}/{psf_simulator}_projrays.fits",
    log: 
        "logs/{config_name}/{obs_id}/psf/{irf_label}/{psf_simulator}/simulate-psf.log"
    conda:
        "../envs/ciao-4.16.yaml"
    params:
        args = lambda wildcards: get_simulate_psf_args(wildcards),
        parfolder = "logs/{config_name}/{obs_id}/psf/{irf_label}/{psf_simulator}/params",
        outroot = lambda wildcards, output: output.filename_psf.replace(".psf", ""),
    shell:
        'mkdir -p {params.parfolder};'
        'PFILES="{params.parfolder};$CONDA_PREFIX/contrib/param:$CONDA_PREFIX/param";'
        'export MARX_ROOT=$CONDA_PREFIX;'
        'simulate_psf infile={input.infile} outroot={params.outroot} spectrum={input.spectrum} {params.args}'
