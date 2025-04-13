# Heroes Data Platform

Welcome to the Heroes Data Platform! In a world full of heroes and villains, our mission is to create a dynamic data platform to track and analyze the evolving stories of comic characters. We update our heroes' information on a monthly basis to keep the data fresh and relevant.

## Project Overview

This project simulates a robust data engineering solution integrating multiple data sources. Our platform is structured into several layers:

### Raw Data Layer
We ingest raw data from multiple sources, including:
- DC Characters
- Marvel Characters
- Character abilities and additional info

### Staging Layer
In the staging layer, the raw data is cleaned and prepared. The process involves:
- Overwriting raw tables monthly with fresh data.
- Standardizing and validating data via basic tests (e.g., not_null constraints).

### Transformation Layer
Here, we merge and enrich the data:
- The DC and Marvel datasets are combined into a unified table.
- A new **Publisher** column is introduced to indicate the data origin (DC, Marvel, Other).
- A composite key is created by combining the page ID, publisher, and the number of appearances. This key changes if the appearance count updates, enabling incremental updates to the transform table.

### Presentation Layer
The presentation layer provides ready-to-use models answering key business questions about our heroes and villains. Specifically, it addresses the following queries:
- Top 10 villains by appearance per publisher (DC, Marvel, Other)
- Top 10 heroes by appearance per publisher (DC, Marvel, Other)
- Bottom 10 villains by appearance per publisher (DC, Marvel, Other)
- Bottom 10 heroes by appearance per publisher (DC, Marvel, Other)
- Top 10 most common superpowers by creator (DC, Marvel, Other)
- Re-ranking of the top 10 villains and heroes based on an overall score
- The 5 most common superpowers
- Identification of the hero and villain associated with each of these 5 superpowers

Each of these questions is addressed by a dedicated presentation table, ensuring our platform delivers clear and actionable insights.

## Workflow Summary
1. **Data Ingestion**: Load raw tables from various sources every month.
2. **Staging**: Clean and standardize data through an overwriting mechanism.
3. **Transformation**: Merge and enrich data with incremental updates using composite keys.
4. **Presentation**: Create specific models that provide quick answers to key analytical questions.

## Tests and Quality Assurance

We keep our schema as simple as possible by implementing basic tests such as `not_null` and `unique` on essential columns. This ensures the highest data quality and reliability.

---

We hope this improved structure and clear documentation convey our technical approach while maintaining a friendly tone. Happy data exploring!

* Top 10 villains by appearance per publisher 'DC', 'Marvel' and 'other'
* Top 10 heroes by appearance per publisher 'DC', 'Marvel' and 'other'
* Bottom 10 villains by appearance per publisher 'DC', 'Marvel' and 'other'
* Bottom 10 heroes by appearance per publisher 'DC', 'Marvel' and 'other'
* Top 10 most common superpowers by creator 'DC', 'Marvel' and 'other'
* Of the top 10 villains and heroes, re-rank them based on their overall score
* What are the 5 most common superpowers?
* Which hero and villain have the 5 most common superpowers?

This question are being answered on our present layer, exiting one table per question. 
