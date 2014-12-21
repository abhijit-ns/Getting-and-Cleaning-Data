Program will first Read the List of Feature. 
Create the Data Frame by reading the training data set (X_train) and assign the Feature set as Column Names. 
Add the columns for Activity and the Subject , by doing an RBind from the respective files Y_test and subject_test 

Repeat the same for the Test data. 

Append both the data sets (train and Test)

Retain only the SD and Mean measurements buy removing all the other column

Perform the Aggregate to identify the average each Measurement Vs Subject Vs Activity 	
