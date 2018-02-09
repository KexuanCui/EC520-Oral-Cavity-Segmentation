# EC520 Course Project - Oral Cavity Segmentation
This is a course project of Boston University course EC520 - Digital Image Processing and Communication

We developed a supervised learning algorithm in building 2-class classifier for segmenting tissue area out from oral cavity photo, which was based on the idea of binary hypothesis test.

## Developers
Kexuan Cui
Yaan Ge

## Summary
Oral cavity image segmentation is the first phase of the oral cancer automatic diagnosis algorithm development. Oral cancer usually develops from lesions on oral tissue. Therefore, separating the oral cavity image into tissue and non-tissue classes and conducting further analysis only on tissue area could increase the efficiency and preciseness of diagnosis. This project developed a supervised learning algorithm to build a 2 class classifier for segmenting the tissue area out from the oral cavity photo, which was based on the idea of binary hypothesis test. A nonlinear color transformation, Hue, Saturation and Value, is studied. It was concluded that 2 class classifier performed well in oral cavity photo segmentation. Additionally, applying the classifier in the Hue, Saturation and Value color space provided preciser result than RGB color space provided, and combining the classification results of Hue (H) and Value (V) channels provide the best result.
