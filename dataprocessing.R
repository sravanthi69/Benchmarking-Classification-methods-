# Dataprocessing.R
# Goal: create processed 0/1 target as `label` for each dataset into ./processeddata/

library(readxl)

# Use relative paths so this works on any machine/repo
input_dir  <- "datasets2"                  # put your raw files here (relative)
output_dir <- file.path(input_dir, "processeddata")
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

# Helper: write CSV to processed dir
.write_proc <- function(df, name) {
  write.csv(df, file.path(output_dir, paste0(name, ".csv")), row.names = FALSE)
}

# ---- cell_samples ----
cell_samples <- read.csv(file.path(input_dir, "cell_samples.csv"))
cell_samples$label <- ifelse(cell_samples$Class == 2, 0, 1)
cell_samples$Class <- NULL
.write_proc(cell_samples, "cell_samples"); rm(cell_samples)

# ---- dsppd ----
dsppd <- read.csv(file.path(input_dir, "dsppd.csv"))
dsppd$label <- ifelse(dsppd$Outcome.Variable == "positive", 1, 0)
dsppd$Outcome.Variable <- NULL
.write_proc(dsppd, "dsppd"); rm(dsppd)

# ---- drug200 ----
drug200 <- read.csv(file.path(input_dir, "drug200.csv"))
drug200$label <- ifelse(drug200$Drug %in% c("drugY","drugX"), 1, 0)
drug200$Drug <- NULL
.write_proc(drug200, "drug200"); rm(drug200)

# ---- new_model ----
new_model <- read.csv(file.path(input_dir, "new_model.csv"))
new_model$label <- ifelse(new_model$Target %in% c("enrolled","graduate"), 1, 0)
new_model$Target <- NULL
.write_proc(new_model, "new_model"); rm(new_model)

# ---- student (xlsx) ----
student <- read_excel(file.path(input_dir, "student.xlsx"))
student$label <- ifelse(student$Target %in% c("enrolled","graduate"), 1, 0)
student$Target <- NULL
.write_proc(student, "student"); rm(student)

# ---- breast_cancer ----
breast_cancer <- read.csv(file.path(input_dir, "breast_cancer.csv"))
# Convert output to 1 (Class 3 or 4) / 0 (Class 1 or 2)
breast_cancer$label <- ifelse(breast_cancer$class >= 3, 1, 0)
# remove non-predictive column
breast_cancer$bare_nuclei <- NULL
# drop original target if present
breast_cancer$class <- NULL
.write_proc(breast_cancer, "breast_cancer"); rm(breast_cancer)

# ---- default ----
default <- read.csv(file.path(input_dir, "default.csv"))
default$label <- ifelse(default$default == "Yes", 1, 0)
default$default <- NULL
.write_proc(default, "default"); rm(default)

# ---- diabetes2 (semicolon sep) ----
diabetes2 <- read.csv(file.path(input_dir, "diabetes2.csv"), sep = ";")
# If this dataset already has target column, rename to label; else add your own logic:
# diabetes2$label <- <your condition>
# diabetes2$<old_target> <- NULL
.write_proc(diabetes2, "diabetes2"); rm(diabetes2)

# ---- liver patient ----
liver_pt <- read.csv(file.path(input_dir, "liver_patient.csv"))
liver_pt$label <- ifelse(liver_pt$disease == 2, 1, 0)
liver_pt$disease <- NULL
.write_proc(liver_pt, "liver_patient"); rm(liver_pt)

# ---- loan_data ----
loan_data <- read.csv(file.path(input_dir, "loan_data.csv"))
loan_data$label <- ifelse(loan_data$Loan_Status == "Y", 1, 0)
loan_data$Loan_Status <- NULL
loan_data <- loan_data[loan_data$Gender != "", ]
loan_data <- loan_data[loan_data$Self_Employed != "", ]
loan_data <- loan_data[loan_data$Dependents != "", ]
loan_data$Dependents <- gsub("\\+", "", loan_data$Dependents)    # fixed '+' regex
loan_data$Education  <- gsub(" ", "", loan_data$Education)
loan_data <- subset(loan_data, select = -c(Property_Area, Dependents))
.write_proc(loan_data, "loan_data"); rm(loan_data)

# ---- stroke ----
stroke <- read.csv(file.path(input_dir, "stroke.csv"))
stroke <- stroke[stroke$smoking_status != "", ]
# TODO: set the correct target column to `label` here:
# e.g., if the dataset has 'stroke' column (0/1), do:
# stroke$label <- stroke$stroke; stroke$stroke <- NULL
stroke <- subset(stroke, select = -c(work_type, smoking_status, Residence_type, ever_married, gender))
.write_proc(stroke, "stroke"); rm(stroke)

message("All processed datasets written to: ", output_dir)
