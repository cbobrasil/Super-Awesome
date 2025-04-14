# Heroes Data Platform

Welcome to the Heroes Data Platform! In a world full of heroes and villains, our mission is to create a dynamic data platform to track and analyze the evolving stories of comic book characters. We update our heroes' information on a monthly basis to keep the data fresh and relevant.

## Project Overview

This project simulates a robust data engineering solution by integrating multiple data sources.

## How to Run It

### Requirements

- Python 3.8 or higher
- `pip` (Python package installer)

### Installation

It’s recommended to create a virtual environment to isolate dependencies.

Create a virtual environment:

```python3 -m venv venv```

Activate it:

**On macOS/Linux:**
```source venv/bin/activate```

**On Windows:**
```venv\Scripts\activate```

Install the dependencies:

```pip install -r requirements.txt```

### Run the Seeds and Models

```dbt seed```
```dbt debug```
```dbt run```


## How the Data Pipeline Works

Our platform is structured into several layers:

### Raw Data Layer

We ingest raw data from multiple sources and place it in the `seed` folder. It includes:

- DC characters
- Marvel characters
- Character abilities and additional info

### Staging Layer

In the staging layer, the raw data is cleaned and prepared. The process involves:

- Overwriting raw tables monthly with fresh data
- Standardizing and validating data using basic tests (e.g., `not_null` constraints)

### Transformation Layer

Here, we merge and enrich the data:

- DC and Marvel datasets are combined into a unified table
- A **publisher** column is added to indicate data origin (DC, Marvel, Other)
- A composite key is created using page ID, publisher, and number of appearances. This key updates when the appearance count changes, enabling incremental updates

### Presentation Layer

This layer provides ready-to-use models answering key business questions about our heroes and villains, such as:

- Top 10 villains by appearance per publisher (DC, Marvel, Other)
- Top 10 heroes by appearance per publisher (DC, Marvel, Other)
- Bottom 10 villains by appearance per publisher (DC, Marvel, Other)
- Bottom 10 heroes by appearance per publisher (DC, Marvel, Other)
- Top 10 most common superpowers by creator (DC, Marvel, Other)
- Re-ranking of the top 10 villains and heroes based on overall score
- The 5 most common superpowers
- Identification of the hero and villain associated with each of these 5 superpowers

Each of these questions is answered by a dedicated presentation table, ensuring the platform delivers clear and actionable insights.

## Workflow Summary

1. **Data Ingestion** – Load raw tables from various sources monthly  
2. **Staging** – Clean and standardize data using an overwriting mechanism  
3. **Transformation** – Merge and enrich data with incremental logic using composite keys  
4. **Presentation** – Create specific models that provide quick answers to key analytical questions

## Tests and Quality Assurance

We keep our schema simple and effective by implementing basic tests such as `not_null` and `unique` on essential columns. This ensures high data quality and reliability.

## Key Questions Answered About the Characters

- Top 10 villains by appearance per publisher ('DC', 'Marvel', 'Other')
- Top 10 heroes by appearance per publisher ('DC', 'Marvel', 'Other')
- Bottom 10 villains by appearance per publisher ('DC', 'Marvel', 'Other')
- Bottom 10 heroes by appearance per publisher ('DC', 'Marvel', 'Other')
- Top 10 most common superpowers by creator ('DC', 'Marvel', 'Other')
- Re-rank the top 10 villains and heroes based on overall score
- What are the 5 most common superpowers?
- Which hero and villain have the 5 most common superpowers?

These questions are answered in the **presentation layer**, with one table per question.

## Conclusion

With the Heroes Data Platform up and running, the citizens of our comic universe can finally stay informed about the heroes and villains shaping their world. Whether you're cheering for justice or secretly rooting for the villains, one thing is certain — data is now our greatest superpower!

Thanks
Clara Oliveira