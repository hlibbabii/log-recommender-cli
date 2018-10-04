# log-recommender-cli

# Supported commands
logrec **dataset**

### View datasets

```shell
logrec dataset ls
```

```shell
logrec dataset ls -l
```

```shell
logrec dataset ls -ll
```

### View detailed information about a dataset

```shell
logrec dataset ls <dataset name>
```

```shell
logrec dataset ls -l <dataset name>
```

```shell
logrec dataset ls -ll <dataset name>
```

### remove dataset

Warning:this command will remove all the files associated with the given dataset: original dataset, parsed dataset representation, all preprocessed dataset representations, all the computed metadata, such as number of number of projects, files, tokens in the oroginal dataset, the sizes of vocabularies of all prprocessed representations etc.

you may want to look at purge command, which does not remove the original dataset and associated with it metadata (You may want to do it if e.g. the algorithm of parsing changed and parsing with subsecuent preprocessing need to be rerun)

```shell
logrec dataset rm <dataset name>
```

### Purge dataset
Removes parsed and all preprocessed representations of the given dataset and associated with them metadata, e.g. vocabulary sizes. The original dataset is not removed as well as metadata associated with the original dataset (the number of projects,. files, tokens in the dataset etc.)

### Parse dataset
Builds a parsed representation of the dataset (which can be subsequently preprocessed with different preprocessing parameters).

Note 1! Multiple parse commands shouldnt be run on the same dataset. The results are not predictable.
Note 2! The parsing may take a while when processing a large dataset. If for some reason execution stops, the command can be rerun to continue parsing. If a parsing command is run on a dataset that has already been parsed, the dataset wont be parsed again. If the rerun of the parsing is desirable (e.g. after chabging of implementation of the parser, you may want ti run purge command.
