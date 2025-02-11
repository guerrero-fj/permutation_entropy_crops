# Calculating Permutation Entropy without Permutations

https://doi.org/10.1155/2020/7163254
____
### Abstract
A method for analyzing sequential data sets, similar to the permutation entropy one, is discussed. The characteristic features of this method are as follows: it preserves information about equal values, if any, in the embedding vectors; it is exempt from combinatorics; and it delivers the same entropy value as does the permutation method, provided the embedding vectors do not have equal components. In the latter case, this method can be used instead of the permutation one. If embedding vectors have equal components, this method could be more precise in discriminating between similar data sets.

---
This paper by Alexander K. Vidybida presents an **alternative method** for calculating entropy in time series, particularly addressing issues of **ties (equal values)** in embedding vectors, which are problematic in standard permutation entropy methods. Here’s a summary of its main points and contributions, highlighting why this approach is valuable:
___
### **Key Features of the Proposed Method**

1. **Preserves Information about Ties**:
    
    - Unlike standard permutation entropy, which requires ordering equal components artificially, this method keeps ties explicit.
    - This allows for a richer representation of embedding vectors, preserving nuances in data, which may be critical in systems with quantization or limited outputs.
    
2. **Replaces Permutations with Integer-Based Encoding**:
    
    - Instead of symbolizing embedding vectors with permutations (e.g., $123123123, 231231231$), it encodes them as integers in a **base-DDD** numeral system, where $DDD$ is the embedding dimension.
    - This eliminates the need for combinatorics, simplifying the algorithm.
    
3. **Handles Vectors with Equal Components More Naturally**:
    
    - Embedding vectors are converted into a numeric **arithmetic order pattern** that reflects the presence of ties.
    - For example, a vector $(7,15,7,25,15)$ produces the order pattern $(0,1,0,2,1)$, where the repeated elements $7$ are consistently assigned the same rank $(0)$.
    
4. **Equivalent to Standard Permutation Entropy When No Ties Exist**:
    
    - If all components in embedding vectors are distinct, the arithmetic encoding method yields the same entropy value as standard permutation entropy.
    - However, in cases with ties, this method may better discriminate between similar datasets.
    
5. **Introduces New Order Patterns**:
    
    - By preserving ties explicitly, this method increases the total number of possible order patterns beyond the D!D!D! patterns in standard permutation entropy.
    - The additional patterns arise from embedding vectors with equal components.

---

### **Mathematical Foundations**

### Mathematical Foundations

#### Encoding Ties:

For an embedding vector :

$$V = (x_0, x_1, \dots, x_{D-1})$$

construct a symbol $\alpha(V)$, where:

- Each unique value in $V$ is assigned a rank in ascending order.
- Equal values receive the same rank.

Example:  
$$V = (3,1,3) \rightarrow \alpha(V) = (1,0,1)$$
#### Integer Representation:

The symbol $α(V)$ is further converted into a single integer $A(V)$ in base $D$:  

$$A(V) = \sum_{i=0}^{D-1} \alpha_i \cdot D^i$$


This integer uniquely represents the order pattern of $V$, including ties.

#### Arithmetic Entropy:

The Shannon entropy of the integer-based patterns $A(V)$ is computed as:  

$$H = -\sum p(A_i) \cdot \log_2 (p(A_i))$$


where $p(A_i)$ is the probability of observing the pattern $A_i$.

---

### **Advantages Over Standard Permutation Entropy**

3. **Treats Ties Correctly**:
    
    - Standard permutation entropy forces an artificial ordering of ties, which may distort results or lose meaningful information.
    - This method explicitly accounts for ties, avoiding arbitrary decisions.
4. **Avoids Combinatorics**:
    
    - By replacing permutations with integer encodings, the method is computationally simpler, especially for large embedding dimensions.
5. **Higher Sensitivity**:
    
    - By introducing new order patterns due to ties, this method can distinguish datasets that standard permutation entropy would treat as identical.
6. **Broader Applicability**:
    
    - The method is particularly useful for:
        - Systems with quantized or discrete outputs,
        - High embedding dimensions where ties are more likely,
        - Datasets where ties carry critical information about the system.

---

### **Examples and Results**

7. **Testing on Random Sequences**:
    
    - The paper compares standard permutation entropy and arithmetic entropy for two datasets:
        - $S_1$​: Random numbers from the set $\{0,1,2,3,4\}$,
        - $S_2$​: Random numbers with added constraints (e.g., consecutive values are different).
    - **Findings**:
        - For embedding dimension $D=3$, arithmetic entropy $(AE)$ is significantly higher than permutation entropy $(PE)$: $AE_{S1}=3.684 bits,$ $PE_{S1}=2.497 bits,$ $AE_{S2}=2.919 bits$, $PE_{S2}=2.368 bits$.
        - Arithmetic entropy better discriminates between $S_1$ and $S_2$​.
          
8. **Dependence on Delay $\tau$**:
    
    - With different delays $\tau$, arithmetic entropy remains consistent, while permutation entropy may lose sensitivity due to forced tie-breaking.

---

### **Challenges and Considerations**

1. **Complexity with Large $D$**:
    
    - As the embedding dimension $D$ increases, the number of possible patterns grows exponentially, potentially requiring significant computational resources.
2. **Interpretability**:
    
    - While preserving ties adds information, interpreting the results requires understanding the meaning of new patterns introduced by ties.
3. **Domain-Specific Use**:
    
    - Whether to preserve ties depends on the system being studied. For some chaotic systems, ignoring ties may still be appropriate.

---

### **Conclusion**

The method described in this paper offers a **robust, flexible alternative to standard permutation entropy**, particularly when ties are present in the data. By explicitly encoding ties and avoiding combinatorics, it preserves critical information and improves sensitivity in distinguishing datasets. This approach is well-suited for systems with quantized data, long sequences, or large embedding dimensions.

