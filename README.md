# ProjectData

1) How "run_analysis.R" works?

The script reads the Samsung data that are located in the same folder.

It creates a data frame for both the "training" and the "test" data set. 
Each of these two data frames includes all available variables, i.e. X, Y and subject and all the Inertial Signals included in the folder

All variables in the data frames are renamed, with identical names.

The data frames are then merged together into a new data frame.

The values of y refers to the activity labels and they are trasnformed from 1-6 into activity descriptors like WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.

At this point each of the elements of the measurement data variables, i.e. X, body_acc_x, body_acc_y,body_acc_z, body_gyro_x, body_gyro_y, body_gyro_z, total_acc_x, total_acc_y and total_acc_z is considered as a string value.
Inside each string there are multiple individual realizations of that variable, which are separated by a space " ".

These are the values for which we need to compute standard deviation and average value.

In order to do so, we have defined a function, called "data compact". This receives as inpout the measurement coloumn that we want to process, the total number of rows in that coloumn (in this case is the same for all), and the names that we want to give to the average and standard deviation variables.

The string is processed internally and the individual words (separated by " ") extracted and converted into a numeric vector used to extract the statistical data. 

Once an average is computed this is used to populate a tidy variable containing averages instead of the entire data set for the measurements.

2) Code book describing the variables

"user": It is the user ID (1-30), it comes from the data file "subject_test.txt" and "subject_train.txt" 

"mov_type": It is the "activity label" (1-6 or WALKING etc.), comes from the data files "y_test.txt" and "y_train.txt"

"X": A 561-feature vector with time and frequency domain variables, obtained from "X_test.txt" and "X_train.txt"

"acc_x": Estimated body acceleration in x direction

"acc_y": Estimated body acceleration in y direction

"acc_z": Estimated body acceleration in Z direction

"gyro_x": Angular velocity from the gyroscope, x component.

"gyro_y": Angular velocity from the gyroscope, y component.

"gyro_z": Angular velocity from the gyroscope, z component.

"total_x": Total acceleration from the accelerometer, x component.

"total_y": Total acceleration from the accelerometer, y component.

"total_z": Total acceleration from the accelerometer, z component.

All variables with prefix "avg_" and "std_" represent the average and standard deviation, respectively, for that measurement data.

For example "avg_total_x" represents the average value of the variable "total_x". Similarly "std_acc_y" indicated the standard deviation of the samples associated with the variable "acc_y" defined above.
