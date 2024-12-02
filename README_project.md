# Delivery Market Analysis

- Repository: `delivery-market-analysis-with-SQL`
- Type: `Learning and Consolidation`
- Duration: `1 week`
- Deadline: `06/12/2024` at 4:00 PM 
- Team: `Group`

## Mission Objectives

Enhance your data engineering and analytical skills by:
- Working with SQL operations like:
  - SELECT
  - JOIN
  - GROUP BY
  - Aggregations (e.g., average, sum)
  - Advanced queries
- Exploring geospatial data analysis
- Extracting and visualizing insights from food delivery datasets
- Building data storytelling and presentation skills

## Learning Objectives

- Collaborate effectively using ticketing systems like Trello
- To be able to read and understand a SQL database diagram
- Understand and query SQL database structures
- Optimize SQL queries for performance
- Visualize data insights using Python
- Deliver impactful presentations with data-driven narratives

## The Mission

> We are a small start-up interested in creating a web app that compares prices and different services provided by food delivery apps in Belgium. To that end, we have hired your team to analyze databases provided by a consultant to uncover actionable insights for restaurant partners and consumers.  Our tech stack uses SQL and Python which your solution must use as well. Finally, you must present your intial findings in a week as we will meet with investors in the following week.

The objective is to explore trends, customer preferences, and market dynamics in the food delivery space. Conduct exploratory analysis, summarize findings, and present actionable insights.

![fooddeliveryIMG](./assets/fooddelivery.jpg)

## Data

The database provided is structured as three SQLite files:

### Uber Eats Database
<img  src='./assets/ER_schema_ubereats.png' width=500px>

### Deliveroo Database
<img  src='./assets/ER_schema_deliveroo.png' width=500px>

### Takeaway Database
<img  src='./assets/ER_schema_takeaway.png' width=500px>

Use SQL queries to explore relationships between tables and derive insights. 

## Must-have Features (MVP)

Answer these key business questions:

1. What is the price distribution of menu items?
2. What is the distribution of restaurants per location?
3. Which are the top 10 pizza restaurants by rating?
4. Map locations offering kapsalons and their average price.
5. Compare restaurant distributions across UberEats, Deliveroo, and Takeaway. What are some of the market trends?

You can also answer these open ended questions:

1. How do delivery fees vary across platforms and locations?
2. Which restaurants have the best price-to-rating ratio?
3. Where are the delivery ‘dead zones’—areas with minimal restaurant coverage?
4. How does the availability of vegetarian and vegan dishes vary by area?
5. How do ratings of similar restaurants differ across Uber Eats, Deliveroo, and Takeaway?
6. Identify the **World Hummus Order (WHO)**; top 3 hummus serving restaurants.

**Come up with 2 original analyses!**

## Nice-to-have Features

- Optimize SQL queries for speed and readability
- Suggest database schema improvements
- Add custom exploratory insights:
  - Compare cuisines' average ratings across platforms
  - Map high-density restaurant zones
  - Identify cuisine trends in different regions
- Visualize overlap of restaurant categories on different platforms

## Constraints
- You are not allowed to use pandas or similar tools for the data analysis, you should use SQL and SQL only. For instance, use SQL JOINs to cross-reference tables, not pd.merge().
- You can use pandas and other libaries for visualization purposes.
- Write your queries in dedicated .sql files or a queries.py file with the queries as strings

## Deliverables

1. **GitHub Repository:** Include all source code.
2. **Trello Board:** Share with the team and coach.
3. **Show and Tell:** Summarize 5 main findings in an engaging format (PDF or other). One member of the team will present the teams findings on Friday.

## Steps

1. Study the brief: 
    - Who is your user (restaurants, clients, the app itself)? 
    - Why is your analysis relevant for your user? 
    - What will you deliver as a solution to your user (a notebook, presentation, scripts)?
2. Assign team roles:
    - Team Lead: Point of contact of coach,and lead in disussions
    - Repo Manager: Creates and manages the repo
    - Presenter:  Communicates findings 
3. Identify technical challenges: How?
    - Create a list of tasks and assign them to team members
    - Discuss a proposed workflow and how you will communicate as a team
    - Pick 5 key questions to tackle
4. Create the repository
    - Decide: branches or folders?
    - Decide: Github workflow
5. Explore and understand the dataset
6. Write and optimize SQL queries
7. Create visuals for each key question
8. Finalize and present results

---

## Evaluation

| Criterion      | Indicator                                              | Yes/No |
| -------------- | ------------------------------------------------------ | ------ |
| **Completion** | Each must-have question is answered                    |        |
|                | Queries and visualizations are included                |        |
| **Excellence** | SQL queries are efficient and documented               |        |
|                | Code follows best practices                            |        |
|                | Presentation is clear and compelling                   |        |

---

## Happy analyzing! Let the data drive your insights.
