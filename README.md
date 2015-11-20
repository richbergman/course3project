# course3project
Project to read data and create a tidy dataset.

The script reads:
	1.  The variable names (features.txt)
	2.  The activity names - indicates the activity associated 
	     with the index number (activity_lables.txt).
	3.  The training dataset (x-train.txt)
	4.  The training column names (y-train.txt)
	5.  The subject numbers (subject_train.txt)

Steps 3-5 are repeated with the *_test.txt files.

 These files are assembled into a singe datafram "dat" by:
	1.  Inserting subject and activity vectors as columns 1,2 in the training dataset using cbind.
	2.  Repeating with the test data set.
	3.  Lastly, append the test data to the training data with rbind.
 
 To make the data tidy, replace activity numbers with activity labels. 

 Extract only mean and standard deviation variables by subsetting on variables with the character strings
	"mean" or "std".  This is the dataframe "datsum."

 Finally, reshape "datsum" by melting the dataframe under Subject and Activity.
 To get the means of the means and sd's grouped by Subject and Activity, cast the molten dataset variables against
	"Subject" and "Acivity" and write the output to "rpoj3out.txt."
