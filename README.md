# MRI Preprocessing Scripts

Welcome to the MRI Preprocessing Scripts repository! This repository is dedicated to providing robust tools for the preprocessing of Magnetic Resonance Imaging (MRI) data. These scripts are designed to simplify and automate the preparation and preprocessing of MRI scans, enhancing both research and clinical workflows.

## About

This repository houses scripts that facilitate the standard preprocessing steps required for MRI data analysis, including skull stripping, normalization, segmentation, and registration. These tools are particularly useful in handling data from multi-site studies, which often suffer from batch effects due to varied acquisition parameters and scanner types.

## Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:
- Python 3.x
- Required Python libraries: `nibabel`, `numpy`, `scipy`
- MRI analysis software (if applicable per script): FSL, SPM, FreeSurfer

### Installation

Clone this repository to your local machine using:

    ```bash
    git clone https://github.com/mansoorbalouch/MRI-Preprocessing-Scripts.git
    cd MRI-Preprocessing-Scripts

## Features

### Automated File Preparation
Handling scattered MRI datasets often involves consolidating and organizing data, which can be tedious and error-prone. This repository includes scripts that:

- Automatically detect and organize MRI files from scattered directories.
- Rename and reformat files according to standard conventions.
- Prepare data for preprocessing by sorting into appropriate structures for further analysis.

### Preprocessing Utilities
The scripts provided in this repository cover a wide range of preprocessing needs:

- Skull Stripping: Remove non-brain tissue from MRI scans.
- Image Normalization: Standardize intensity values across different scans.
- Segmentation: Segment brain tissues into gray matter, white matter, and cerebrospinal fluid.
- Registration: Align images to a standard space for comparative studies.
