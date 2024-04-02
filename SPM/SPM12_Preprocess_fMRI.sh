#!/bin/bash

# Path to SPM12 executable
SPM_PATH=/path/to/spm12

# Path to the directory containing your fMRI datasets
DATA_DIR=/path/to/fmri_data

# List of subject IDs or directories
SUBJECTS=("subject1" "subject2" "subject3")

# Loop through each subject
for subject in "${SUBJECTS[@]}"; do
    echo "Preprocessing ${subject}..."
    
    # Path to the subject's fMRI data
    SUBJECT_DIR="${DATA_DIR}/${subject}"
    
    # Navigate to the SPM directory
    cd "$SPM_PATH"

    # Start MATLAB with SPM
    matlab -nodesktop -r "addpath('$SPM_PATH'); spm_jobman('initcfg'); run_your_preprocessing_script('$SUBJECT_DIR'); exit;"

    echo "${subject} preprocessing complete."
done

echo "All subjects preprocessed."
