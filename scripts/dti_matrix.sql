-- To Filter the data from ChEMbL database, run the following queries 

-- 1. Filter Activities Table for IC50 Values
CREATE TABLE FilteredActivities AS
SELECT
    ACTIVITY_ID,
    ASSAY_ID,
    MOLREGNO,
    STANDARD_VALUE,
    STANDARD_TYPE,
    DATA_VALIDITY_COMMENT
FROM
    Activities
WHERE
    STANDARD_TYPE = 'IC50'
    AND DATA_VALIDITY_COMMENT = 'Manually validated'; -- Adjust the filter for your confidence criteria

-- 2. Filter Assays for High Confidence

CREATE TABLE HighConfidenceAssays AS
SELECT
    ASSAY_ID,
    TID,
    CONFIDENCE_SCORE
FROM
    Assays
WHERE
    CONFIDENCE_SCORE >= 8; -- Set a threshold for high confidence

-- 3. Map Targets to ENSEMBL IDs
CREATE TABLE ProteinTargets AS
SELECT
    TID,
    PREF_NAME,
    ORGANISM,
    CHEMBL_ID,
    TAX_ID
FROM
    Target_Dictionary
WHERE
    TARGET_TYPE = 'SINGLE PROTEIN'
    AND ORGANISM = 'Homo sapiens';

-- 4. Filter Compounds
CREATE TABLE FilteredCompounds AS
SELECT
    cs.MOLREGNO,
    cs.CANONICAL_SMILES
FROM
    Compound_Structures cs
WHERE
    cs.CANONICAL_SMILES IS NOT NULL; -- Ensure valid SMILES representation

-- 5. Join Tables to Build Drug-Target Interaction Matrix

CREATE TABLE DrugTargetInteractions AS
SELECT
    fa.MOLREGNO,
    fa.STANDARD_VALUE AS IC50,
    cs.ACCESSION AS Target_ENSMBL_ID
FROM
    FilteredActivities fa
JOIN
    HighConfidenceAssays ha ON fa.ASSAY_ID = ha.ASSAY_ID
JOIN
    Target_Components tc ON ha.TID = tc.TID
JOIN
    Component_Sequences cs ON tc.COMPONENT_ID = cs.COMPONENT_ID
WHERE
    cs.ACCESSION IS NOT NULL; -- Ensure only targets with valid ENSEMBL IDs are included
