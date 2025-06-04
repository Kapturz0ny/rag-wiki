# rag-wiki

**Author:** Marcin Bagnowski

<a target="_blank" href="https://cookiecutter-data-science.drivendata.org/">
    <img src="https://img.shields.io/badge/CCDS-Project%20template-328F97?logo=cookiecutter" />
</a>


### Własny mini-RAG z fine-tuningiem retrievera

This project implements a custom mini Retrieval-Augmented Generation (RAG) model with retriever fine-tuning. The RAG model is based on 1000 selected articles from Wikipedia.

This project was created for the **Podstawy wielkich modeli językowych z zastosowaniami 2025L** course and is inspired by the paper [Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks](https://arxiv.org/pdf/2005.11401).



## Project Organization

```
├── Makefile           <- Makefile with convenience commands.
├── README.md          <- The top-level README for developers using this project.
├── data               <- To get this data dir structure type "make create-data-dirs"
│   ├── interim        <- Intermediate data that has been transformed.
│   ├── processed      <- The final, canonical data sets for modeling.
│   └── raw            <- The original, immutable data dump.
│
├── models             <- Trained and serialized models.
│
├── notebooks          <- Jupyter notebooks, named with run order.
│
├── pyproject.toml     <- Project configuration file with package metadata for 
│                         rag_wiki and configuration for tools like black.
│
├── figures            <- Generated figures used in reporting.
│
└── requirements.txt   <- The requirements file for reproducing the analysis environment.
```


## Setup and Usage

Follow these steps to set up the project environment and run the notebooks.

### Prerequisites

*   Python version 3.12.3
*   [Poetry](https://python-poetry.org/docs/#installation) (for dependency management)
*   [Make](https://www.gnu.org/software/make/) (optional, for using Makefile shortcuts)

### Installation and Setup

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/Kapturz0ny/rag-wiki
    cd rag-wiki
    ```

2.  **Create data directories:**
    This command creates the necessary `data/raw`, `data/interim`, and `data/processed` directories.
    ```bash
    make create-data-dirs
    ```
    Alternatively, without Make:
    ```bash
    mkdir -p data/processed data/raw data/interim
    ```

3.  **Install dependencies using Poetry:**
    This will create a virtual environment (if one doesn't exist) and install all project dependencies specified in `pyproject.toml` and locked in `poetry.lock`.
    ```bash
    make install
    ```
    Or directly with Poetry:
    ```bash
    poetry install --no-root
    ```


## Notebooks Overview

This section describes the Jupyter notebooks included in the `notebooks/` directory. It is recommended to run them in the specified numerical order.

**NOTE:** Remeber to select proper jupyter kenrel (.venv).

*   **`01_prepare_datasets.ipynb`**
    *   **Purpose:** This notebook is responsible for loading the initial raw data Natural Questions dataset, extracts key entities, calculates amount of documents per each entity, and downloads wikipedia corpus, then splits those documents into chunks.
    *   **Key Outputs:**  `data/interim/nq_questions_1000.jsonl` (raw NQ dataset), `data/raw/wikipedia_articles/` (raw wikipedia articles), `data/interim/wikipedia_corpus_xxxx.jsonl` (xxx is a number of downloaded articles), `data/processed/wikipedia_chunks.jsonl` (chunks)

*   **`02_create_retriever_training_data.ipynb`**
    *   **Purpose:** Focuses on generating specific training data formatted for fine-tuning the retriever model. Creates positive and negative pairs (question document).
    *   **Key Outputs:**  `data/processed/retriever_training_data.jsonl` (dataset for fine-tuning a retriever)

*   **`03_finetune_retriver.ipynb`**
    *   **Purpose:** This notebook contains the code for fine-tuning the retriever model using the training data generated in the previous step. Calcualtes metrics and saves the fine-tuned model. With optional push to hugging face repository.
    *   **Key Outputs:** `models/retriever_finetuned/best-model/` (fine-tuned retriever from the best epoch)

*   **`04_test_retriver.ipynb`**
    *   **Purpose:** Dedicated to load fine-tuned retriever and check it's performance. Also generates embeddings for all corpus chunks for future usage.
    *   **Key Outputs:** `data/processed/corpus_embeddings_finetuned.npy` (calculated embeddings for each chunk in corpus)

*   **`05_test_generator.ipynb`**
    *   **Purpose:** This notebook downloads and tests the generator component of the RAG system.
    *   **Key Outputs:** `models/generator_qwen/` (downloaded generator model)

*   **`06_rag_pipeline.ipynb`**
    *   **Purpose:** Combines fine-tuned retriever and generator into one RAG system.
   

--------

