# Load necessary libraries
# If you don't have 'dplyr' installed, uncomment the line below and run it:
# install.packages("dplyr")
library(dplyr)
library(tidyr) # For pivot_wider if needed, but not strictly necessary for this structure

# --- 1. Define Parameters ---
n_participants_per_group <- 50 # Number of participants in each group
n_observations_per_participant <- 4 # Number of observations per participant
set.seed(123) # For reproducibility

# --- 2. Generate Participant-level Data ---
# Create unique participant IDs
participant_ids <- 1:(n_participants_per_group * 2)

# Randomly assign participants to 'Experimental' or 'Control' group
groups <- sample(c("Experimental", "Control"),
                 size = n_participants_per_group * 2,
                 replace = TRUE,
                 prob = c(0.5, 0.5))

# Generate age (e.g., normally distributed around 40, with some variation)
age <- round(rnorm(n_participants_per_group * 2, mean = 40, sd = 10))
age[age < 18] <- 18 # Ensure age is at least 18

# Generate sex (e.g., 50/50 split)
sex <- sample(c("Male", "Female"),
              size = n_participants_per_group * 2,
              replace = TRUE,
              prob = c(0.5, 0.5))

# Create a data frame for participant-level information
participant_data <- data.frame(
  participant_id = participant_ids,
  group = groups,
  age = age,
  sex = sex
)

# --- 3. Generate Time-series Data and Simulate Dependent Variables ---

# Initialize an empty data frame to store all observations
all_observations <- data.frame()

# Loop through each participant to generate their 4 observations
for (i in 1:nrow(participant_data)) {
  current_participant_id <- participant_data$participant_id[i]
  current_group <- participant_data$group[i]
  
  # Create time points for each participant
  time_points <- 0:(n_observations_per_participant - 1) # 0 = Baseline, 1, 2, 3 = Post-intervention
  
  # Simulate y1 and y2
  y1_values <- numeric(n_observations_per_participant)
  y2_values <- numeric(n_observations_per_participant)
  
  # Baseline values (time_point = 0) - no group difference
  baseline_y1_mean <- 20
  baseline_y2_mean <- 40
  sd_y <- 6 # Standard deviation for random noise
  
  y1_values[1] <- rnorm(1, mean = baseline_y1_mean, sd = sd_y)
  y2_values[1] <- rnorm(1, mean = baseline_y2_mean, sd = sd_y)
  
  # Post-intervention values (time_point = 1, 2, 3)
  for (t in 2:n_observations_per_participant) {
    # y1 simulation: reduces in experimental group, no change in control
    if (current_group == "Experimental") {
      # Gradual reduction for experimental group over time
      # Example: -5 for time_point 1, -10 for time_point 2, -15 for time_point 3
      reduction_effect <- (t - 1) * 3 # Or any other desired reduction pattern
      y1_values[t] <- rnorm(1, mean = baseline_y1_mean - reduction_effect, sd = sd_y)
    } else { # Control group
      y1_values[t] <- rnorm(1, mean = baseline_y1_mean, sd = sd_y) # No change
    }
    
    # y2 simulation: no change for either group
    y2_values[t] <- rnorm(1, mean = baseline_y2_mean, sd = sd_y)
  }
  
  # Ensure values don't go below a reasonable minimum (e.g., 0)
  y1_values[y1_values < 0] <- 0
  y2_values[y2_values < 0] <- 0
  
  # Create a temporary data frame for the current participant's observations
  participant_observations <- data.frame(
    participant_id = current_participant_id,
    time_point = time_points,
    y1 = y1_values,
    y2 = y2_values
  )
  
  # Append to the main data frame
  all_observations <- rbind(all_observations, participant_observations)
}

# --- 4. Combine Data ---
# Merge participant-level data with time-series observations
artificial_database <- left_join(all_observations, participant_data, by = "participant_id")

# Reorder columns for better readability
artificial_database <- artificial_database %>%
  select(participant_id, group, age, sex, time_point, y1, y2) %>%
  arrange(participant_id, time_point)

# --- 5. Display a sample of the data ---
cat("--- Sample of the Artificial Database ---\n")
print(head(artificial_database))
cat("\n")

# --- 6. Verify Baseline Differences (Optional but Recommended) ---
cat("--- Baseline (time_point = 0) Summary Statistics by Group ---\n")
baseline_data <- artificial_database %>% filter(time_point == 0)

print(baseline_data %>%
        group_by(group) %>%
        summarise(
          mean_y1 = mean(y1), sd_y1 = sd(y1),
          mean_y2 = mean(y2), sd_y2 = sd(y2),
          mean_age = mean(age), sd_age = sd(age),
          male_count = sum(sex == "Male"), female_count = sum(sex == "Female")
        ))
cat("\n")

# --- 7. Verify Post-Intervention Differences (Optional but Recommended) ---
cat("--- Post-Intervention (e.g., time_point = 3) Summary Statistics by Group ---\n")
post_intervention_data <- artificial_database %>% filter(time_point == 3)

print(post_intervention_data %>%
        group_by(group) %>%
        summarise(
          mean_y1 = mean(y1), sd_y1 = sd(y1),
          mean_y2 = mean(y2), sd_y2 = sd(y2)
        ))
cat("\n")

write.csv(artificial_database, "ejercicio_final.csv", row.names = F)

