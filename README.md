<center>
<h2>Tech Sector Employment Diversity in Silicon Valley</h2>
<h4>CICS 197R Final Portfolio Project</h4>
</center>

<strong>AIM:</strong> To understand workplace diversity in the technology sector through the lens of an observational study of employment statistics centered around the Silicon Valley tech companies.

<strong>OBJECTIVES:</strong><br/>
<ul type="square">
    <li>Observe workplace diversity in terms of:
        <ul>
            <li>Gender: Male vs. Female (sex ratio)</li>
            <li>Race: White/Caucasian vs. Non-White (non-white ratio)</li>
            <li>Job Category: White Collar Jobs vs. Blue Collar Jobs (blue-collar ratio)</li>
        </ul>
    </li>
    <li>Draw bar graphs/pie charts of the factors:
        <ul>
            <li>Company Diversity</li>
            <li>Racial Diversity</li>
            <li>Gender Diversity</li>
            <li>Job Role Diversity</li>
        </ul>
    </li>
    <li>Deduce summary statistics on the figures of the aforementioned criteria:
        <ul>
            <li>Mean</li>
            <li>Median</li>
            <li>Standard Deviation</li>
            <li>Quantile Ranges</li>
        </ul>
    </li>
    <li>Draw histogram and plots of the factors’ spread:
        <ul>
            <li>Sex Ratio</li>
            <li>Non-White Ratio</li>
            <li>Blue-Collar Ratio</li>
        </ul>
    </li>
    <li>Generate and plot the model(s) to prove linear independence of the diversity factors.
    </li>
</ul>

<strong>THEORY:</strong><br/>
1. <b>Sex Ratio:</b> In this context, the sex ratio is calculated as the ratio of number of female employees to the total number of employees. This can also be used to calculate the <b>inverted sex ratio</b> (the ratio of number of male employees to the total number of employees).
2. <b>Non-White Ratio:</b> In this context, the non-white ratio is calculated as the ratio of number of non-white employees (American-Indian/Alaskan Native, Asian, Black/African- American, Hispanic/Latino, Native Hawaiian/Pacific Islander, Multiracial) to the total number of employees. This can also be used to calculate the <b>white ratio</b> (the ratio of number of white employees to the total number of employees).
3. <b>Blue-Collar Ratio:</b> In this context, the blue-collar ratio is calculated as the ratio of number of blue-collar employees (Craft Workers, Laborers/Helpers, Operatives, Service Workers, Technicians) to the total number of employees. This can also be used to calculate the <b>white-collar ratio</b> (the ratio of number of white-collar employees to the total number of employees)

    While it’s quite intuitive to imagine that the above 3 factors must be directly proportional or linearly related, this project aims to show that they are linearly independent of each other, especially relevant with the data from Silicon Valley.

<strong>DATASET METADATA:</strong><br/>
Source: https://github.com/cirlabs/Silicon-Valley-Diversity-Data/blob/master/Reveal_EEO1_for_2016.csv (Data is available under the Open Database License)

Credits: "Reveal from The Center for Investigative Reporting." https://www.revealnews.org/svdiversity

Cleaned Working Data:
<table style="margin:auto">
<thead>
    <tr>
        <th></th>
        <th>company</th>
        <th>race</th>
        <th>gender</th>
        <th>job_category</th>
        <th>count</th>
    </tr>
</thead>
<tbody>
    <tr>
        <td>1:</td>
        <td>23andMe</td>
        <td>Hispanic/Latino</td>
        <td>male</td>
        <td>Executives</td>
        <td>0</td>
    </tr>
    <tr>
        <td>2:</td>
        <td>23andMe</td>
        <td>Hispanic/Latino</td>
        <td>male</td>
        <td>Managers</td>
        <td>1</td>
    </tr>
    <tr>
        <td>3:</td>
        <td>23andMe</td>
        <td>Hispanic/Latino</td>
        <td>male</td>
        <td>Professionals</td>
        <td>7</td>
    </tr>
    <tr>
        <td>4:</td>
        <td>23andMe</td>
        <td>Hispanic/Latino</td>
        <td>male</td>
        <td>Technicians</td>
        <td>0</td>
    </tr>
    <tr>
        <td>5:</td>
        <td>23andMe</td>
        <td>Hispanic/Latino</td>
        <td>male</td>
        <td>Sales Workers</td>
        <td>0</td>
    </tr>
    <tr>
        <td>---</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>4121:</td>
        <td>Sanmina</td>
        <td>Overall Totals</td>
        <td>NA</td>
        <td>Operatives</td>
        <td>1660</td>
    </tr>
    <tr>
        <td>4122:</td>
        <td>Sanmina</td>
        <td>Overall Totals</td>
        <td>NA</td>
        <td>Laborers/Helpers</td>
        <td>4</td>
    </tr>
    <tr>
        <td>4123:</td>
        <td>Sanmina</td>
        <td>Overall Totals</td>
        <td>NA</td>
        <td>Service Workers</td>
        <td>57</td>
    </tr>
    <tr>
        <td>4124:</td>
        <td>Sanmina</td>
        <td>Overall Totals</td>
        <td>NA</td>
        <td>Totals</td>
        <td>5205</td>
    </tr>
    <tr>
        <td>4125:</td>
        <td>Sanmina</td>
        <td>Overall Totals</td>
        <td>NA</td>
        <td>Managers</td>
        <td>591</td>
    </tr>
</tbody>
</table>
<br/>

- company : the various companies centered around Silicon Valley<br/>25 levels: "23andMe", "Adobe", "Airbnb", "Apple", "Cisco", "eBay", "Facebook", "Google", "HP Inc.", "HPE", "Intel", "Intuit", "LinkedIn", "Lyft", "MobileIron", "NetApp", "Nvidia", "PayPal", "Pinterest", "Salesforce", "Sanmina", "Square", "Twitter", "Uber", "View"

- race : the race-wise distribution of employees
<br/> 8 levels: "American-Indian/Alaskan Native", "Asian", "Black/African-American", "Hispanic/Latino", "Native Hawaiian/Pacific Islander", "Overall Totals", "Multiracial", "White/Caucasian"

- gender : the gender-wise distribution of employees <br/> 3 levels: “male”, “female”, NA

- job_category : the job type classifications of employees<br/>
11 levels: "Administrative Support", "Craft Workers", "Executives", "Laborers/Helpers", "Managers", "Operatives", "Professionals", "Sales Workers", "Service Workers", "Technicians", "Totals"

Notes:
- The data is completely from the year 2016. It would be wise to mention this as the year column was removed during the cleaning of the data.

<strong>OBSERVATIONS & CONCLUSIONS:</strong>
<ol type="i">
<li>Categorical Data</li>
    <center>
        <br/>
        <img width="80%" src="./Plots:Charts/Categorical%20Data/Company%20Diversity%20Pie%20Chart.png">
        Figure 1: Company Diversity Pie Chart
        <br/><br/>
        <img width="80%" src="./Plots:Charts/Categorical%20Data/Company%20Diversity%20Table.png">
        Table 1: Company Diversity Table
        <br/><br/>
        <img width="80%" src="./Plots:Charts/Categorical%20Data/Gender%20Diversity%20Pie%20Chart.png">
        Figure 2: Gender Diversity Pie Chart
        <br/><br/>
        <img width="80%" src="./Plots:Charts/Categorical%20Data/Gender%20Diversity%20Table.png">
        Table 2: Gender Diversity Table
        <br/><br/>
        <img width="80%" src="./Plots:Charts/Categorical%20Data/Racial%20Diversity%20Pie%20Chart.png">
        Figure 3: Racial Diversity Pie Chart
        <br/><br/>
        <img width="80%" src="./Plots:Charts/Categorical%20Data/Racial%20Diversity%20Table.png">
        Table 3: Racial Diversity Table
        <br/><br/>
        <img width="80%" src="./Plots:Charts/Categorical%20Data/Job%20Role%20Diversity%20Pie%20Chart.png">
        Figure 4: Job Diversity Pie Chart
        <br/><br/>
        <img width="80%" src="./Plots:Charts/Categorical%20Data/Job%20Role%20Diversity%20Table.png">
        Table 4: Job Diversity Table
        <br/><br/>
        <img width="80%" src="./Plots:Charts/Categorical%20Data/Company%20Diversity%20Bar%20Chart.png">
        Figure 5: Bar Chart for Company Diversity
        <br/><br/>
        <img width="80%" src="./Plots:Charts/Categorical%20Data/Gender%20Diversity%20Bar%20Chart.png">
        Figure 6: Bar Chart for Gender Diversity
        <br/><br/>
        <img width="80%" src="./Plots:Charts/Categorical%20Data/Racial%20Diversity%20Bar%20Chart.png">
        Figure 7: Bar Chart for Racial Diversity
        <br/><br/>
        <img width="80%" src="./Plots:Charts/Categorical%20Data/Job%20Role%20Diversity%20Bar%20Chart.png">
        Figure 8: Bar Chart for Job Role Diversity
        <br/><br/>
    </center>
<li>Statistical Summaries</li>
    <center>
        <br/>
        <img width="80%" src="./Plots:Charts/Statistical%20Summaries/Statistical%20Summaries%201.png">
        <br/>
        <img width="80%" src="./Plots:Charts/Statistical%20Summaries/Statistical%20Summaries%202.png">
        <br/>
    </center>
<li>Discrete Distributions of Sex Ratio, Non-White Ratio and Blue-Collar Jobs Ratio</li>
    <center>
        <br/>
        <div style="display:flex">
            <img width="45%" src="./Plots:Charts/Discrete%20Data/Histogram%20of%20Sex%20Ratio.png">
            <img width="30%" src="./Plots:Charts/Discrete%20Data/Plot%20of%20Sex%20Ratio.png">
            </div>
        <br/>
        <div style="display:flex">
            <img width="45%" src="./Plots:Charts/Discrete%20Data/Histogram%20of%20Non-White%20Ratio.png">
            <img width="30%" src="./Plots:Charts/Discrete%20Data/Plot%20of%20Non-White%20Ratio.png">
        </div>
        <br/>
        <div style="display:flex">
            <img width="45%" src="./Plots:Charts/Discrete%20Data/Histogram%20of%20Blue-Collar%20Jobs%20Ratio.png">
            <img width="30%" src="./Plots:Charts/Discrete%20Data/Plot%20of%20Blue-Collar%20Jobs%20Ratio.png">
        </div>
        <br/>
    </center>
<li>Linear Models to Prove Linear Independence</li>
    <ol type="a">
        <li>Sex Ratio ~ Non-White Ratio</li>
        <img src="./Plots:Charts/Linear%20Models/Sex%20Ratio%20Non-White%20Ratio%20Correlation.png">
        <li>Sex Ratio ~ Blue-Collar Jobs Ratio</li>
        <img src="./Plots:Charts/Linear%20Models/Sex%20Ratio%20Blue-Collar%20Jobs%20Ratio.png">
        <li>Non-White Ratio ~ Blue-Collar Jobs Ratio</li>
        <img src="./Plots:Charts/Linear%20Models/Non-White%20Ratio%20Blue-Collar%20Jobs%20Ratio.png">
    </ol>
</ol>