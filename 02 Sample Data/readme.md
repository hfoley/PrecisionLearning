# Precision Learning - 02 Sample Data

The files in this location are the gzipped json files mimicked from VitalSource system documentation.  The ADLS Gen 2 storage account ending in "lake" will contain a raw container.  You'll upload these files below that raw container.  These files were generated from the public documentation for VitalSource (https://developer.vitalsource.com/hc/en-us/articles/115015721128).  You can upload them from within Synapse Studio, Storage Explorer, or whatever method you prefer.  A sample image of the Synapse Studio method is below.  

![alt text](https://github.com/hfoley/EDU/blob/master/images/UploadFiles.jpg?raw=true)

## Upload data and run pipeline
In this section we'll upload the sample VitalSource files to raw container location.  We'll then run the pipeline to process the raw files to parquet.  

1. Open the Synapse workspace within Azure.  You can then click the Open Synapse Studio or workspace url link.  Open the manage pane (tool box on left side).  
2. Navigate to Integrate pane.  Select the + and select pipeline.  Give it appropriate name. Tip: can click on properties in top right to move it out of the way.  
3. Expand Activities and select and drag to canvas to run a Data flow (Move & Transform section). 
4. Select settings for data flow - expand Data flow and choose VitalSourceDF. 
5. After you've created and updated setting for the pipeline - hit publish to save your changes to Synapse. 
6. We'll come back and run this pipeline after we've uploaded sample data in next section.  

Up next is to upload sample data files into our newly created ADLS Gen 2 data lake.  You can view and validate what's contained in the resource group.  Navigate to sample data folder below.  

* [02 Sample Data](https://github.com/hfoley/PrecisionLearning/tree/main/02%20Sample%20Data)   - contains the raw VitalSource extract data I mimicked from documentation (link above)



	
	

