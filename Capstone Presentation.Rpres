Data Science Capstone Presentation
========================================================
author: Kleanthis Mazarakis
date: 9-Jan-2018
autosize: true

"Next Word Predictor"

![](header.png)

Objective and links
========================================================


**The goal of this project was to build a shiny web application that is able to predict the next word, after typing the initial words of a sentence.**


Below you can find the links to the shiny web application and github repository containing the application files


- [Github Repo](https://github.com/kmazarakis/test-repo)

- [Shiny Web App](https://kmazarakis.shinyapps.io/next_word_predictor/)


Data Pre-processing
========================================================

**In order to get the training data ready, the initial datasets are processed and cleaned using the procedure described below:**


- Only 0.5 % of the original data is sampled, since the original files were too big to be processed and it was determined that 0.5 % of the data was enough for our predictions.
- At the next stage, the sampled data are cleaned by removing numbers, strip white space, transform to lowercase and remove punctuation.
- After cleaning the data, we are using the n-grams technique to create Unigrams, Bigrams, Trigrams and Quadgrams
- Next, the created N-gram tables are sorted according to their Frequency in descending order
- Finally, the sorted N-Grams are saved into R data files for further processing

Prediction Model
========================================================

**The next word predictor model is based on the Katz Back-off algorithm.**  
**Below you canb find detailed steps explaining how the algorithm works:**

- The data that was saved in files during the Data Pre-processing step is loaded
- Next, the user has to enter a tect input in the provided space in the web app
- The user input text is then cleaned, in the same way as the initial data files were cleaned (removing numbers, strip white space, transform to lowercase and remove punctuation)
- If the user enters 3 or more words, the last 3 words are used in conjuction with the Quadgrams table in order to predict the next word
- If there is no Quadgram match found, then the algorithm falls back to using the Trigrams table and so on.
- Similarly, if the user enters 2 words, Trigrams table will be used and if only 1 word is entered the algorithm will try to find a match starting from the bigrams table.
- If there is no match found in any of the tables, the algorithm returns "NA"

Shiny Web App Preview
========================================================

**In the image below, you can see a screenshot of the Shiny Web App that was described in the previous slides:**

<div align="left">
<img src = "Shiny_App_Preview.png">
</div>
