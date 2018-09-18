# Text-Analytics_LDA

## Objectives
1. Overview
2. Datasets/Codes
3. Process

## 1. Overview
This is a topic modelling analysis using Latent Dirichlet Allocation (LDA) model. There will be close to 1000 rows of data, and the aim is to find common topics from the different rows of free text. 

## 2. Datasets/Codes
 - The datasets are confidential. But in general, the dataset should be in any csv file, with 2 columns - docID and texttoclassify. Each row under texttoclassify will represent the text for topic modelling.  
 - The codes are used to represent the 

## 3. Process
### Loading dataset 
We will load the full raw text data. And zoom in to the columns of interest
### Cleaning the data 
We have to clean the text cleaning because we have to process manually since there are too many abbreviations.
Text cleaning is done by spilting the text into indicidual tokens, and replace the most occuring ones according to frequency. This is because there are 6000+ tokens, but we cant stem because there are too many abbreviation. eg: fos != for, but maybe stemmed tgt. 
### Topic Modelling
After cleaning, we mapped back to the original data and replace the tokens, and den we start on our topic modelling
### LDA Analysis
- In this LDA analysis, we will use a bi-gram probabilistic model to spilt the new cleaned data into 2 tokens/1 token depending on how they occur together. 
- Create a dtm from the new data. 
- Exploring the term frequency bsaed on the dtf
- Run the LDA in R
- Choosing the optimal model based on coherence value - i.e does it make sense if the words occur tgt. 
- We can also plot a dedrogram to see if the algorithm suggest anything about clustering the topics together. 

### Output from LDA analysis
- Each topic will have each word/2words with an assigned phi value (pr(word|topic)). So we only take into account the top 20 values per word in each topic. And the top 20 terms will describe what the topic is about. 
- There will be multiple topics, and we can try dendograms to find which are the topics that may be potentially related. 
- And if we want, we can manually assign labels to the different topics. 
- We can also make use of theta - (Pr(topic|document)) to find whats the probability of topic per document. 

### Visualisation of topics 
- word cloud in r



