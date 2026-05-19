# AI-Facial-Unmasking
AI-Powered Facial Unmasking

The data files biometric-scores-arcface.txt and biometric-scores-adaface.txt provides the biometric scores between pairs of faces using two different embeddings (ArcFace and AdaFace). The first numeric column is the condition (see below), the second column is the filename used for comparison, and the third column is the biometric in the range of -1 (mismatch) to 1 (perfect match).

Condition:
1  same identity
2  different identity (same race/gender)
3  same identity (chatGPT unmasked)
4  same identity (chatGPT unmasked US Senators)
5  same identity (Grok unmasked)
6  same identity (Gemini unmasked)
7  same identity (Gemini unmasked US Senators)
8  different identity Doopelgangers

All analyses from the paper can be reproduced by running biometric-scores.m
