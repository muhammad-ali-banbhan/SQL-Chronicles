select * from  employees;

select * from city;

select Name, CountryCode, Population,
CASE 
	When Population  >= 1500000 then "High Population"
    When Population  >= 1000000 then  "Middle Population"
ELSE  
	"Low Population"
end as pop_wise_rank
from city;



select *  from country;


select * from  company;


-- CASE WHEN Practice – Set 1 (10 Questions)
Q1. Show job titles and a new column that ranks salaries as:

"High" if Salary_Annual ≥ 150000

"Medium" if between 100000–149999

"Low" otherwise.

Q2. List companies and job satisfaction scores, and classify satisfaction as:

"Happy" if Job_Satisfaction_Score > 7

"Neutral" if between 5–7

"Unhappy" if less than 5.

Q3. Show employees’ names and label experience level as:

"Veteran" if Years_of_Experience ≥ 10

"Mid-Level" if between 5–9

"Beginner" if less than 5.

Q4. For each job, add a new column that shows promotion status:

"Recently Promoted" if Last_Promotion_Years_Ago < 1

"Due for Promotion" if between 1–3

"Overdue" if > 3.

Q5. Create a remote work score label:

"Fully Remote" if Remote_Flexibility = 'Full'

"Hybrid" if = 'Partial'

"On-site" if = 'None'

Q6. Show job titles with a performance label:

"Top Industry" if Industry is in ('Tech', 'Finance', 'Healthcare')

"Other" otherwise.

Q7. Categorize Employment_Type into:

"Full-time" if = 'FT'

"Part-time" if = 'PT'

"Contractor" if = 'Contract'

"Other" otherwise.

Q8. Add a column showing if someone is "Experienced" (Years_of_Experience ≥ 8) or "Less Experienced".

Q9. Label currency types:

"USD" if Currency = 'USD'

"Non-USD" otherwise.

Q10. Create a column indicating tech involvement:

"Tech Role" if Tech_Stack IS NOT NULL

"Non-Tech" otherwise.