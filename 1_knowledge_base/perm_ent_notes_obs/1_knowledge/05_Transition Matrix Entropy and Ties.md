# Transition Matrix Entropy and Ties

**Ties can also be problematic for transition matrix entropies**, although the challenges differ from those encountered with permutation entropy. Transition matrix entropy measures the complexity of transitions between discrete states (e.g., crops in a rotation), and ties can affect how these transitions are interpreted and counted.

Let’s break this down:

### 1. Transition Matrix Entropy

- Transition matrices capture the probability of transitioning from one state $(X_i​)$ to another $(X_{i+1}​)$.
- Transition entropy quantifies the uncertainty or randomness in the transitions using the Shannon entropy of the transition probabilities:

$$H = - \sum_{i} P(X_i) \sum_{j} P(X_j \mid X_i) \log_2 P(X_j \mid X_i)$$

 - Where $P(X_i)$ is the probability of being in state $X_i$
 - $P(X_j \mid X_i)$ is the probability of transitioning from $X_i$ to $X_j$

### 2. Why Ties Are Problematic

- Ties in sequential data (e.g., repeated crops like $Wheat \rightarrow Wheat \rightarrow Corn)$ can introduce ambiguities or biases in the transition matrix: 

#### a. Repeated States Inflate Self-Loops
- If a state repeats, (e.g., $Wheat \rightarrow Wheat \rightarrow Wheat)$, the transition matrix will heavily emphasize **self-loops** (e.g., $Wheat \rightarrow Wheat)$.
- This can artificially lower entropy by making the sequence appear more predictable than it truly is. 

### Example

Crop rotation: $[Wheat, Wheat, Corn, Wheat, Wheat]$

- Transitions:
	- $Wheat \rightarrow Wheat$: 3 times,
	- $Wheat \rightarrow Corn$: 1 time,
	- $Corn \rightarrow Corn$: 1 time.
- Transition Matrix:

			
$$
State =
\begin{array}{c|cc}
 & \text{Wheat} & \text{Corn} \\
\hline
\text{Wheat} & 0.75 & 0.25 \\
\text{Corn} & 1.00 & 0.00
\end{array}
$$

- Entropy will reflect the dominance of $Wheat \rightarrow Wheat$, lowering the overall uncertainty. 

### b. Loss of Meaning in Predictive Dynamics
- Repeated states do not provide information about transitions to new states. 
- If $Wheat \rightarrow Wheat \rightarrow Wheat$ dominates, the transition matrix will overlook the role of $Corn$ or other crops in the rotation. 

### c. Ties Across States Reduce Resolution
- In datasets with quantization (e.g., rounded values, discrete crop types), multiple states may appear tied or indistinguishable, reducing the granularity of the analysis.

### **3. Solutions to Address Ties in Transition Matrix Entropies**

To handle ties effectively, several strategies can be applied:

#### **a. Explicit Self-Loop Handling**

- Treat self-loops separately to ensure they do not dominate the transition probabilities:
    - Normalize self-loops to reflect their proportional significance.
    - Alternatively, exclude self-loops from entropy calculations if they are not meaningful for the analysis.
#### Example Adjustment

Instead of including all $Wheat→Wheat$ transitions, scale them down or assign a weight based on their ecological importance.

#### **b. Context-Specific Weighting**

- Assign weights to transitions based on their ecological or practical significance (e.g., $Wheat→Wheat$) may be penalized if it reflects monoculture practices).

#### Example:

Crop rotation: $[Wheat,Wheat,Corn,Soybean,Wheat]$

- Assign:
    - $Wheat→Wheat$: Weight = 0.5 (penalized),
    - $Wheat→Corn$, $Corn→Soybean$: Weight = 1.0 (unadjusted).

#### **c. Introduce Lagged Transitions**

- Use lagged transitions $(X_i \to X_{i+\tau})$ to capture longer-term dynamics, reducing the dominance of self-loops in short-term transitions.

#### Example:

For $[Wheat,Wheat,Corn,Wheat,Wheat]$ with $\tau = 2$:

- Consider transitions:
    - $Wheat→Corn$,
    - $Corn→Wheat$,
    - Ignoring the immediate $Wheat→Wheat$.

### **Conclusion**

Ties in sequential data, such as crop rotations, can skew transition matrix entropies by inflating self-loops and reducing diversity. To address this:

- Use strategies like **lagged transitions**, **penalizing self-loops**, or **contextual weighting**.
- If ties are meaningful (e.g., monoculture persistence), explicitly include them in the analysis.
