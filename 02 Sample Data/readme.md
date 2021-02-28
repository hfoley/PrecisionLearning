# Precision Learning - 02 Sample Data

The files in this location are the gzipped json files mimicked from VitalSource system documentation.  The ADLS Gen 2 storage account ending in "lake" will contain a raw container.  You'll upload these files below that raw container.  These files were generated from the public documentation for VitalSource (https://developer.vitalsource.com/hc/en-us/articles/115015721128).  You can upload them from within Synapse Studio, Storage Explorer, or whatever method you prefer.  A sample image of the Synapse Studio method is below.  

![alt text](https://github.com/hfoley/EDU/blob/master/images/UploadFiles.jpg?raw=true)

## Upload data and run pipeline
In this section we'll upload the sample VitalSource files to raw container location.  We'll then run the pipeline to process the raw files to parquet.  

1. Navigate to Data pane (left database icon). Selected Linked in left side navigation.  You will see 2 Azure Data Lake Storage Gen2 items listed.  The first one is one that is required for Synapse workspace.  I try to leave that account alone.  The one we'll use is one that ends in "lakeLS".  If you expand it you'll see 2 containers, raw and vitalsource. 
2. Select the raw container.  Here is where we'll load our sample data.  Upload the VitalSourceCaliperEvents04252017.json.gz file into raw. 
3. Navigate back to the pipeline we created and hit Debug (play button).  
4. After it's successfully run you'll see the parquet file in the vitalsource container.  You'll also see that the raw container now has a subfolder called processed.  Within that processed folder is a subfolder called vitalsource.  The file(s) process have been moved to this location after the parquet file is created.  This allows for a mild form of understanding what files have been processed.  It allows the raw container to be an unprocessed loading area.  


Up next is to create external table, view, and Power BI report pointing to the view.  Navigate to Precision Learning - 03 Work with Parquet Data folder below.  

* [Precision Learning - 03 Work with Parquet Data](https://github.com/hfoley/PrecisionLearning/tree/main/03%20Work%20With%20Parquet%20Data)   - contains the sample SQL Scripts and Power BI template.  


	
	

