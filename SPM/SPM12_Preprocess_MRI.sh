#!/bin/bash

# Path to SPM12 installation
SPM_PATH="/path/to/spm12"

# Input and output directories
INPUT_DIR="/path/to/input/data"
OUTPUT_DIR="/path/to/output/data"

# Initialize SPM
matlab -nodisplay -nosplash -nodesktop <<EOF
addpath('${SPM_PATH}')
spm('defaults', 'PET');
EOF

# Loop through subjects
for subject_dir in ${INPUT_DIR}/*; do
    subject=$(basename ${subject_dir})
    
    echo "Processing subject: ${subject}"
    
    # Create subject's output directory
    mkdir -p ${OUTPUT_DIR}/${subject}
    
    # Run SPM12 preprocessing steps
    matlab -nodisplay -nosplash -nodesktop <<EOF
    addpath('${SPM_PATH}')
    spm_jobman('initcfg');
    
    matlabbatch{1}.spm.spatial.preproc.channel.vols = {'${subject_dir}/T1.nii'};
    matlabbatch{1}.spm.spatial.preproc.channel.biasreg = 0.001;
    matlabbatch{1}.spm.spatial.preproc.channel.biasfwhm = 60;
    matlabbatch{1}.spm.spatial.preproc.channel.write = [0 1];
    
    matlabbatch{2}.spm.spatial.preproc.tissue(1).tpm = {'${SPM_PATH}/tpm/TPM.nii,1'};
    matlabbatch{2}.spm.spatial.preproc.tissue(1).ngaus = 1;
    matlabbatch{2}.spm.spatial.preproc.tissue(1).native = [1 0];
    matlabbatch{2}.spm.spatial.preproc.tissue(1).warped = [0 0];
    
    matlabbatch{2}.spm.spatial.preproc.tissue(2).tpm = {'${SPM_PATH}/tpm/TPM.nii,2'};
    matlabbatch{2}.spm.spatial.preproc.tissue(2).ngaus = 1;
    matlabbatch{2}.spm.spatial.preproc.tissue(2).native = [1 0];
    matlabbatch{2}.spm.spatial.preproc.tissue(2).warped = [0 0];
    
    matlabbatch{2}.spm.spatial.preproc.tissue(3).tpm = {'${SPM_PATH}/tpm/TPM.nii,3'};
    matlabbatch{2}.spm.spatial.preproc.tissue(3).ngaus = 2;
    matlabbatch{2}.spm.spatial.preproc.tissue(3).native = [1 0];
    matlabbatch{2}.spm.spatial.preproc.tissue(3).warped = [0 0];
    
    matlabbatch{2}.spm.spatial.preproc.tissue(4).tpm = {'${SPM_PATH}/tpm/TPM.nii,4'};
    matlabbatch{2}.spm.spatial.preproc.tissue(4).ngaus = 3;
    matlabbatch{2}.spm.spatial.preproc.tissue(4).native = [1 0];
    matlabbatch{2}.spm.spatial.preproc.tissue(4).warped = [0 0];
    
    matlabbatch{2}.spm.spatial.preproc.tissue(5).tpm = {'${SPM_PATH}/tpm/TPM.nii,5'};
    matlabbatch{2}.spm.spatial.preproc.tissue(5).ngaus = 4;
    matlabbatch{2}.spm.spatial.preproc.tissue(5).native = [1 0];
    matlabbatch{2}.spm.spatial.preproc.tissue(5).warped = [0 0];
    
    matlabbatch{2}.spm.spatial.preproc.tissue(6).tpm = {'${SPM_PATH}/tpm/TPM.nii,6'};
    matlabbatch{2}.spm.spatial.preproc.tissue(6).ngaus = 2;
    matlabbatch{2}.spm.spatial.preproc.tissue(6).native = [0 0];
    matlabbatch{2}.spm.spatial.preproc.tissue(6).warped = [0 0];
    
    matlabbatch{2}.spm.spatial.preproc.warp.mrf = 1;
    matlabbatch{2}.spm.spatial.preproc.warp.cleanup = 1;
    matlabbatch{2}.spm.spatial.preproc.warp.reg = [0 0.001 0.5 0.05 0.2];
    matlabbatch{2}.spm.spatial.preproc.warp.affreg = 'mni';
    matlabbatch{2}.spm.spatial.preproc.warp.fwhm = 0;
    matlabbatch{2}.spm.spatial.preproc.warp.samp = 3;
    matlabbatch{2}.spm.spatial.preproc.warp.write = [0 1];
    
    matlabbatch{3}.spm.spatial.normalise.write.subj.def = {'${subject_dir}/y_T1.nii'};
    matlabbatch{3}.spm.spatial.normalise.write.subj.resample = {'${subject_dir}/c1T1.nii', '${subject_dir}/c2T1.nii', '${subject_dir}/c3T1.nii'};
    matlabbatch{3}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70; 78 76 85];
    matlabbatch{3}.spm.spatial.normalise.write.woptions.vox = [1 1 1];
    matlabbatch{3}.spm.spatial.normalise.write.woptions.interp = 1;
    
    matlabbatch{4}.spm.spatial.smooth.data(1) = {'${subject_dir}/wc1T1.nii,1'};
    matlabbatch{4}.spm.spatial.smooth.fwhm = [8 8 8];
    matlabbatch{4}.spm.spatial.smooth.dtype = 0;
    matlabbatch{4}.spm.spatial.smooth.im = 0;
    matlabbatch{4}.spm.spatial.smooth.prefix = 's';
    
    spm_jobman('run', matlabbatch);
EOF

    echo "Preprocessing complete for subject: ${subject}"
done

echo "All subjects processed."
