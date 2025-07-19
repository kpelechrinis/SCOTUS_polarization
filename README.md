# Supreme Court Ideological Polarization Tracker

This project analyzes long-term trends in the ideological polarization of the U.S. Supreme Court using **Martin–Quinn scores**, a Bayesian ideal-point estimate for each justice in each term. By focusing on the **expected number of moderate justices per term or decade**, we provide a measure of how ideologically centered the Court has been over time.

## 🎯 Goal

The goal of this project is to:

- Quantify and visualize changes in the ideological composition of the Supreme Court over time.
- Track how often the Court features **moderate (ideologically neutral)** justices.
- Examine teporal trends.

This analysis helps inform discussions around judicial polarization, partisanship, and institutional shifts in the judiciary.

## 📐 Metric: Expected Number of Moderates

We define a justice as **moderate** if their Martin–Quinn score falls within a specified neutral range (e.g., −0.5 to +0.5). Rather than using hard thresholds on point estimates, we compute:

> **Expected probability that each justice is moderate**, given their posterior distribution.

Assuming a normal approximation:
- Let `μ = post_mn` (posterior mean),
- Let `σ = (post_975 - post_025) / (2 × 1.96)` (estimated posterior SD),
- Then, the **probability of moderation** is:

$P(\text{moderate}) = \Phi\left(\frac{0.5 - \mu}{\sigma}\right) - \Phi\left(\frac{-0.5 - \mu}{\sigma}\right)$

Summing across all justices in a term gives:

$\text{Expected Neutral Justices (per term)} = \sum_i P_i(\text{moderate})$

This results in a **soft, uncertainty-aware measure** of Court moderation over time.

## 📊 Visualization

We aggregate the expected number of neutral justices per decade but one can do the same on a per term or per administration.  

