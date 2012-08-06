# Print charts of London population, by council, over the years
# Readme

#Set up

Before starting, you need to download 2 datasets
1. Download the 'Boundary-Line' dataset from https://www.ordnancesurvey.co.uk/opendatadownload/products.html
2. Download the Historic Census dataset in CSV from http://data.london.gov.uk/datastore/package/historic-census-population

Unzip the Boundary Line dataset, and place the files contained in the 'Data' folder in a folder
Then, copy the history-census-population file in the same folder


#Run the script

Run
createPopulationGraphs(dataDirectory, imagesDirectory, vectorOfYears)

where 
- dataDirectory points to the directory containing the datasets
- imagesDirectory points to an existing directory where images will be created
- vectorOfYears is a numeric vector specifying for which years the images will be created. Notice that available years are 1801, 1811, 1821, ... up to 2001

i.e.

createPopulationGraphs("/tmp/my-data-folder", "/tmp", c(1801,1901, 2001))

PNG files will be created in the specified 'imagesDirectory' folder