---
downloads:
  - file: ../../src/phylo.mk
    title: Makefile
  - file: ../../envs/phylo.yml
    title: env.yml
---

(bwf-phylo)=
# phylo.mk

## Overview

The `phylo.mk` workflow contains rules for performing phylogenetic tree inference using `raxml-ng` and `iqtree`.

Inference is conducted using either [maximum likelihood](wiki:Maximum_likelihood_estimation) or [bootstrapping](wiki:Bootstrapping_(statistics)) methods. To generate the alignment, refer to the [alignment workflow](./alignment.md).

:::{hint} Environment Setup
:class: dropdown

Prior to using the workflow, download the dependencies within a virtual environment using your manager of choice:

```bash
make -f src/phylo.mk init ENV_MANAGER=micromamba
```

Activate environment to expose dependencies:
```bash
micromamba activate bwf-phylo
```
:::

## Rules

### boostrap

Generate multiple phylogenies using bootstrapping and extract the best tree.

**{sc}`Parameters`**

- MODEL: substitution matrix or evolutionary model to use in analysis (default: GTR+G)
- N: number of bootstrap iterations (default: 10)
- PREFIX: add prefix to output files (default: result)
- SEED: indicate seed used for bootstrapping
- TOOL: specify tool to perform bootstrapping (default: raxml)
- THREADS: number of cores (default: 8)

**{sc}`Example Usage`**

Perform bootstrapping wit 20 iterations using `raxml`.
```bash
make -f src/phylo.mk bootstrap \
    TOOL=raxml N=20
```

Prepend _bootstrap_ to output files of `iqtree`.
```bash
make -f src/phylo.mk bootstrap \
    TOOL=iqtree PREFIX=bootstrap
```

### ML

Compute for maximum-likelihood tree.

**{sc}`Parameters`**

- MODEL: substitution matrix or evolutionary model to use in analysis (default: GTR+G)
- N: number of searches to perform (default: 10)
- PREFIX: add prefix to output files (default: result)
- SEED: indicate seed used for bootstrapping
- TOOL: specify tool to perform bootstrapping (default: raxml)
- THREADS: number of cores (default: 8)

**{sc}`Example Usage`**

Generate ML tree with 20 searches using `raxml`.
```bash
make -f src/phylo.mk ML \
    TOOL=raxml N=20
```

### models

List supported substitution models.

**{sc}`Parameters`**

This command does not accept parameters.

**{sc}`Example Usage`**

Print available evolutionary models.
```bash
make -f src/alignment.mk models
```