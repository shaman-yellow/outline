
Interaction propensity: a measure of the interaction ability between one protein (or region) and one RNA (or region). This measure is based on the observed tendency of the components of ribonucleoprotein complexes to exhibit specific properties of their physico-chemical profiles that can be used to make a prediction (Bellucci et al. [Nat Methods. 2011]). The reported value is that of the top RNA fragment (unfragmented protein; see Performances).

Z-score: In order to alleviate potential biases originating from the length of the RNAs and impacting the Interaction Propensity (IP) score, we developed a dynamic Z-score normalization procedure. To do so, we built multiple background distributions for different RNA length bins with width of 150nts. For the background distributions, we calculated the Interaction Propensities for a dataset of 12.5M interactions composed of ...(<http://service.tartaglialab.com/static_files/shared/documentation_omics2.html>)  We binned the Interaction Propensity scores in distinct distributions based on the RNA length of the corresponding interaction and we calculated mean and standard deviation for each of them. All Interaction Propensity scores calculated on the catRAPID omics v2.1 are Z-normalized against the respective background distribution depending on the length of the RNA fragment.

Interaction matrix: the protein-RNA interaction matrix, which contains the interaction propensity scores of each protein-RNA fragment pair, is reported for the top scoring couples (see at the end of the list). Such matrices are calculated through a second catRAPID run, in which both protein and RNA are fragmented (Cirillo et al. [RNA. 2013]).

RBP propensity: it is a measure of the propensity of the protein to bind RNA. It equals 1 if the protein is in the RBP precompiled library or it is similar to one of such RBPs. Otherwise, it is set to catRAPID signature overall score.

RNA-Binding Domains: number of RNA-binding domain occurrences found in the protein sequence.

RNA-Binding Motifs: number of RNA-binding motifs instances found on the RNA sequence. The presence of RNA-binding motifs on the target transcript is evaluated using the FIMO tool(Grant, Bailey and Noble. [Bioinformatics. 2011]).

Conserved interactions: RBP-RNA pairs orthologous to the top scoring pairs (see at the end of the list) undergo a parallel catRAPID analysis. If z-score is higher than the value in z-score column minus 0.5, the interaction is classified as conserved. The column reports the number of organisms in which the interaction is conserved out of those in which an orthologous pair is found.

Ranking: The star rating system helps the user to rank the results. The score is the sum of three individual values: 1) catRAPID normalized propensity, 2) RBP propensity and 3) presence of known RNA-binding motif.
