-- Analysing Employee Performance for Hr Analytics Using SQL
Select *
From employesperformance;

-- Task#1: Find the average age of employees in each department and gender group. ( Round average  age up to two decimal places if needed)
-- 1.For Gender 
Select gender, Round(AVG(age),2) as Average_Age
From employesperformance
Group BY gender;
-- 2.For Department
Select department, Round(AVG(age),2) as Average_Age
From employesperformance
Group BY department;
-- 3. For Both
Select department, gender, Round(AVG(age),2) as Average_Age
From employesperformance
Group BY department, gender;

-- Task#2: List the top 3 departments with the highest average training scores. ( Round average scores up to two decimal places if needed)
Select TOP 3 department, Round(AVG(avg_training_score),2) as Average_training_score
From employesperformance
Group BY department
Order By 2 Desc;

-- Task#3: Find the percentage of employees who have won awards in each region. (Round percentages up to two decimal places if needed)
Select region, Round(Count(Case when awards_won > 0 then 1 End) * 100.0 / Count(*),2) as c
From employesperformance
Group By region;

-- Task#4: Show the number of employees who have met more than 80% of KPIs for each recruitment channel and education level
Select recruitment_channel, education, SUM(KPIs_met_more_than_80)
From employesperformance
Group By recruitment_channel, education;

-- Task#5: Find the average length of service for employees in each department, considering only employees with previous year ratings greater than or equal to 4. ( Round average length up to two decimal places if needed)
Select department, AVG(length_of_service) as Average_length_of_service
From employesperformance
Where previous_year_rating >=4
Group By department
Order By Average_length_of_service Desc;

-- Task#6: List the top 5 regions with the highest average previous year ratings. ( Round average ratings up to two decimal places if needed)
Select Top 5 region, Round(AVG(previous_year_rating),2) as average_previous_year_rating
From employesperformance
Group By region
Order By average_previous_year_rating DESC;

-- Task#7: List the departments with more than 100 employees having a length of service greater than 5 years.
Select department, Count(*) as no_employees
From employesperformance
Where length_of_service > 5
Group By department
Having Count(*) > 100;

-- Task#8: Show the average length of service for employees who have attended more than 3 trainings, grouped by department and gender. ( Round average length up to two decimal places if needed)
Select department, gender, Round(AVG(length_of_service),2) as average_length_of_service
From employesperformance
Where no_of_trainings > 3
Group By department,gender;

-- Task#9: Find the percentage of female employees who have won awards, per department. Also show the number of female employees who won awards and total female employees. ( Round percentage up to two decimal places if needed)
With tab1 As(	
	Select department, Sum(awards_won) as won_awards, Count(*) as total_females
	From employesperformance
	Where gender = 'f'
	Group By department
	)
Select *, Round(won_awards *100.0 / total_females,2) as award_won_percentage
From tab1;

