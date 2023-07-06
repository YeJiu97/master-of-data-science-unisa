# Week 7: Rule-based Classifier

**Task 1**

**Apply the RIPPER algorithm to find a set of all the classification rules for the dataset provided above. Please note that RIPPER algorithm learns rules starting from the minority class. In the practical folder (learnonline), you will find a RIPPER example on a different dataset (p7-ripper-sample.xlsx).**

In this Practical we will learn how to produce a set of classification rules using the <font color="red">***\*RIPPER\****</font> algorithm.

1. Understand the principles of the ***RIPPER*** algorithm. 

2. Learn **classification rules** on a sample dataset.

3. ***Apply*** the learned rules on test tuples.

We will be using a sample dataset that can be found in other examples that introduce rule-based classification. The point here is on learning the basics behind the RIPPER algorithm and not necessarily on covering various types of variables. That is why we have four categorical variables – Age (young, pre-presbyopic, and presbyopic), Spectacle prescription (myope and hypermetrope), Astigmatism (yes, no), and Tear production rate (reduced, normal). The outcome we are trying to predict is Recommended lenses that has three levels – none, soft, and hard.

| Age | Spectacle </br>prescription | Astigmatism | Tear production </br>rate | Recommended </br>lenses|
| :----- | :------ | :------- | :---- | :------ |
|young | myope | no  | reduced | none  |
|young | myope | no  | normal  | soft  |
|young | myope | yes | reduced | none  |
|young | myope | yes | normal |hard |
|young | hypermetrope | no   | reduced | none |
|young | hypermetrope | yes  | normal  | hard |
|pre-presbyopic | myope | no  | reduced | none |
|pre-presbyopic | myope | no  | normal  | soft |
|pre-presbyopic | myope | yes | reduced | none |
|pre-presbyopic | hypermetrope | no  | reduced | none|
|pre-presbyopic | hypermetrope | no  | normal  | soft|
|pre-presbyopic | hypermetrope | yes | reduced | none|
|pre-presbyopic | hypermetrope | yes | normal  | none|
|presbyopic | myope | no | reduced | none |
|presbyopic | myope | no | normal  | none |
|presbyopic | hypermetrope | no  | normal  | soft |
|presbyopic | hypermetrope | yes | reduced | none |
|presbyopic | hypermetrope | yes | normal  | none |

**Task 2: Applying the rules**

**Apply the rules the algorithm learned for the above dataset to make a prediction for the following tuples:**

**<A = “young”, SP = “hypermetrope”, AST = “no”, TP = “normal”, RL = ?>**
**<A = “presbyopic”, SP = “myope”, AST = “yes”, TP = “normal”, RL = ?>**
**<A = “presbyopic”, SP = “hypermetrope”, AST = “no”, TP = “reduced”, RL = ?>**

**Where: * A – Age, * SP – Spectacle prescription, * AST – Astigmatism, TP – Tear production, and RL – Recommended lenses (CLASS). What are the predicted classes for the three tuples above? Feel free to share your results in the discussion forum.**

What are the predicted classes for the three tuples above?

Based on the provided dataset and applying the learned rules, here are the predicted classes for the three tuples:

1. Tuple <A = "young", SP = "hypermetrope", AST = "no", TP = "normal", RL = ?> Predicted Class: Soft lenses
2. Tuple <A = "presbyopic", SP = "myope", AST = "yes", TP = "normal", RL = ?> Predicted Class: None (No recommended lenses)
3. Tuple <A = "presbyopic", SP = "hypermetrope", AST = "no", TP = "reduced", RL = ?> Predicted Class: None (No recommended lenses)