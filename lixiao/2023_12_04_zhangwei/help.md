genelist: one or more columns of probe annotation,
          if genelist was included as input

   logFC: estimate of the log2-fold-change
          corresponding to the effect or contrast
          (for ‘topTableF’ there may be several
          columns of log-fold-changes)

    CI.L: left limit of confidence interval for
          ‘logFC’ (if ‘confint=TRUE’ or ‘confint’
          is numeric)

    CI.R: right limit of confidence interval for
          ‘logFC’ (if ‘confint=TRUE’ or ‘confint’
          is numeric)

 AveExpr: average log2-expression for the probe
          over all arrays and channels, same as
          ‘Amean’ in the ‘MarrayLM’ object

       t: moderated t-statistic (omitted for
          ‘topTableF’)

       F: moderated F-statistic (omitted for
          ‘topTable’ unless more than one coef is
          specified)

 P.Value: raw p-value

adj.P.Value: adjusted p-value or q-value

       B: log-odds that the gene is differentially
          expressed (omitted for ‘topTreat’)


