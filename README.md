# Gene expression in public RNA-Seq data for adult Zebrafish tissues.

In which tissue my favorite gene is expressed?

I used [STAR](https://github.com/alexdobin/STAR) to map the publicly available RNA-Seq data and [Kallisto](https://github.com/pachterlab/kallisto) to quantify expression.

### Usage:

## Using Docker container locally:

```
# Build an image:
make build
# Run the server:
make run
```
The app should be accessible in your browser at `localhost:3838`

## If you have Rstudio installed locally:

Open Rstudio and type:
```{r}
library("shiny")
runGitHub("public_rnaseq_tpm","slebedeva")
```

Enter your gene as official gene symbol (case-sensitive!) (piwil1) or Ensembl gene name (ENSDARG...).
Mouse over the bar to see the sample and the TPM. The plot is showing total expression per gene.
You can also download the counts as a table.

![](Screenshot.png)


