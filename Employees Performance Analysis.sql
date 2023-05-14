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

-- Task#10: Calculate the percentage of employees per department who have a length of service between 5 and 10 years. ( Round percentage up to two decimal places if needed)

SELECT department, ROUND(COUNT(CASE WHEN length_of_service >= 5 AND length_of_service <= 10 THEN 1 END) * 100.0 / COUNT(*), 2) AS percentage
FROM employesperformance
GROUP BY department;

-- Task#11: Find the top 3 regions with the highest number of employees who have met more than 80% of their KPIs and received at least one award, grouped by department and region.

Select Top 3 department, region, Count(*) as numer_of_employees
From employesperformance
Where awards_won >=1 AND KPIs_met_more_than_80 = 1
Group By department, region
Order BY numer_of_employees DESC;

-- Task#12: Calculate the average length of service for employees per education level and gender, considering only those employees who have completed more than 2 trainings and have an average training score greater than 75 ( Round average length up to two decimal places if needed)
Select education, gender, Round(AVG(length_of_service),2) as average_length_of_service
From employesperformance
Where no_of_trainings > 2 AND avg_training_score > 75
group by education, gender
Order By average_length_of_service desc;

-- Task#13: For each department and recruitment channel, find the total number of employees who have met more than 80% of their KPIs, have a previous_year_rating of 5, and have a length of service greater than 10 years.
Select department,recruitment_channel, Count(*) as total_number_of_employees
From employesperformance
Where KPIs_met_more_than_80 = 1 AND previous_year_rating = 5 And length_of_service > 10
Group BY department,recruitment_channel
Order By total_number_of_employees desc

-- Task#14: Calculate the percentage of employees in each department who have received awards, have a previous_year_rating of 4 or 5, and an average training score above 70, grouped by department and gender ( Round percentage up to two decimal places if needed).
Select department,gender,
	Round(Count(Case When awards_won = 1 AND previous_year_rating In(4,5) And avg_training_score > 70 then 1 END) * 100.0 / Count(*),2) as employees_percentage
From employesperformance
group by department,gender
Order By employees_percentage desc;

-- Task#15: List the top 5 recruitment channels with the highest average length of service for employees who have met more than 80% of their KPIs, have a previous_year_rating of 5, and an age between 25 and 45 years, grouped by department and recruitment channel. ( Round average length up to two decimal places if needed).
Select department,recruitment_channel, Round(AVG(length_of_service),2) as average_length_of_service
From employesperformance
Where KPIs_met_more_than_80 = 1 AND previous_year_rating = 5 AND age Between 25 And 45
Group By department,recruitment_channel
Order By average_length_of_service desc;
