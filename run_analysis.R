####### READING ALL DATA FROM THE TEST SET


sub  = read.csv("./UCI HAR Dataset/test/subject_test.txt")
X  = read.csv("./UCI HAR Dataset/test/X_test.txt")
y  = read.csv("./UCI HAR Dataset/test/y_test.txt")

# getting inertial signals

# acceleration
body_acc_x  = read.csv("./UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt")
body_acc_y = read.csv("./UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt")
body_acc_z = read.csv("./UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt")

# gyro
body_gyro_x = read.csv("./UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt")
body_gyro_y = read.csv("./UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt")
body_gyro_z = read.csv("./UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt")

# total acceleration
total_acc_x = read.csv("./UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt")
total_acc_y = read.csv("./UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt")
total_acc_z = read.csv("./UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt")

# composing a data.frame with all values
data_test = data.frame(sub,y,X,body_acc_x,body_acc_y,body_acc_z,body_gyro_x,body_gyro_y,body_gyro_z,total_acc_x,total_acc_y,total_acc_z)

# renaming the coloumns
colnames(data_test) <- c("user", "mov_type","X","acc_x","acc_y","acc_z","gyro_x","gyro_y","gyro_z","total_x","total_y","total_z")

####### READING ALL DATA FROM THE training SET

sub = read.csv("./UCI HAR Dataset/train/subject_train.txt")
X = read.csv("./UCI HAR Dataset/train/X_train.txt")
y = read.csv("./UCI HAR Dataset/train/y_train.txt")

# getting inertial signals

# acceleration
body_acc_x = read.csv("./UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt")
body_acc_y = read.csv("./UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt")
body_acc_z = read.csv("./UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt")

# gyro
body_gyro_x = read.csv("./UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt")
body_gyro_y = read.csv("./UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt")
body_gyro_z = read.csv("./UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt")

# total
total_acc_x = read.csv("./UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt")
total_acc_y = read.csv("./UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt")
total_acc_z = read.csv("./UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt")

# composing a data frame with all the collected variables
data_train = data.frame(sub,y,X,body_acc_x,body_acc_y,body_acc_z,body_gyro_x,body_gyro_y,body_gyro_z,total_acc_x,total_acc_y,total_acc_z)

# setting the coloumn names
colnames(data_train) <- c("user", "mov_type","X","acc_x","acc_y","acc_z","gyro_x","gyro_y","gyro_z","total_x","total_y","total_z")

# mergin all coloumn with identical names (all) into one data set containing all test and training data
merged_data = merge(data_test,data_train,all=TRUE)

########### converting the factor numbers into labels
merged_data$mov_type <- as.factor(merged_data$mov_type)
levels(merged_data$mov_type) <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")


size_mat <- dim(merged_data)
nume <- size_mat[1];

# this function is made to extract avergae and standard deviation for the measurements

data_compact <- function(input,rows,name1,name2) {
  
  # these vectores are storing the values for each of the elements
  avg_vect <- rep(0,rows)
  std_vect <- rep(0,rows)
  
  # this is done for all elements in a vector (measurement column)
  for (cc in 1:rows){
    
    # each element is considered as a single element string
    ele <- as.character(input[cc])
    # consecutive data points are separated by a space
    a<-strsplit(ele, " ")
    b<-matrix(unlist(a))
    c<- as.numeric(b)
    d <- c[!is.na(c)]
    
    avg_vect[cc] <- mean(d)
    std_vect[cc] <- sd(d)
    
  }
  
  # the output is passed as a data frame containing avg and std
  output<-data.frame(avg_vect,std_vect)
  colnames(merged_data_compact) <- c(name1,name2)
  return(output)
  
}


# after adding all i can remove all of the measurements
merged_data_compact <- subset(merged_data, select = - (X:total_z))

################# computing avg and std for X
output_X <- data_compact(merged_data$X,nume,"avg_X","std_X")

# to add a new coloumn
merged_data_compact$avg_X <- output_X[1]   
#merged_data_compact$std_X <- output_X[2]   

################# computing avg and std for acc X
output_acc_x <- data_compact(merged_data$acc_x,nume,"avg_acc_x","std_acc_x")

# to add a new coloumn
merged_data_compact$avg_acc_X <- output_acc_x[1]   
#merged_data_compact$std_acc_X <- output_acc_x[2]   

################# computing avg and std for acc y
output_acc_y <- data_compact(merged_data$acc_y,nume,"avg_acc_y","std_acc_y")

# to add a new coloumn
merged_data_compact$avg_acc_y <- output_acc_y[1]   
#merged_data_compact$std_acc_y <- output_acc_y[2]   

################# computing avg and std for acc z
output_acc_z <- data_compact(merged_data$acc_z,nume,"avg_acc_z","std_acc_z")

# to add a new coloumn
merged_data_compact$avg_acc_z <- output_acc_z[1]   
#merged_data_compact$std_acc_z <- output_acc_z[2]   

# ################# computing avg and std for gyro values along X
output_gyro_x <- data_compact(merged_data$gyro_x,nume,"avg_gyro_x","std_gyro_x")

# to add a new coloumn
merged_data_compact$avg_gyro_X <- output_gyro_x[1]   
#merged_data_compact$std_gyro_X <- output_gyro_x[2]   

# ################# computing avg and std for gyro values along y
output_gyro_y <- data_compact(merged_data$gyro_y,nume,"avg_gyro_y","std_gyro_y")

# to add a new coloumn
merged_data_compact$avg_gyro_y <- output_gyro_y[1]   
#merged_data_compact$std_gyro_y <- output_gyro_y[2]   

# ################# computing avg and std for gyro values along z
output_gyro_z <- data_compact(merged_data$gyro_z,nume,"avg_gyro_z","std_gyro_z")

# to add a new coloumn
merged_data_compact$avg_gyro_z <- output_gyro_z[1]   
#merged_data_compact$std_gyro_z <- output_gyro_z[2]   

# ################# computing avg and std for total acceleration values along X
output_total_x <- data_compact(merged_data$total_x,nume,"avg_total_x","std_total_x")

# to add a new coloumn
merged_data_compact$avg_total_X <- output_total_x[1]   
#merged_data_compact$std_total_X <- output_total_x[2]   

# ################# computing avg and std for total acceleration values along y
output_total_y <- data_compact(merged_data$total_y,nume,"avg_total_y","std_total_y")

# to add a new coloumn
merged_data_compact$avg_total_y <- output_total_y[1]   
#merged_data_compact$std_total_y <- output_total_y[2]   

# ################# computing avg and std for total acceleration values along z
output_total_z <- data_compact(merged_data$total_z,nume,"avg_total_z","std_total_z")

# to add a new coloumn
merged_data_compact$avg_total_z <- output_total_z[1]   
#merged_data_compact$std_total_z <- output_total_z[2]   




