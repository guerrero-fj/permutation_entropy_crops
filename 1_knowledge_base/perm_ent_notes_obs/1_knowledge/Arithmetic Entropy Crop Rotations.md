**Arithmetic Entropy $(AE)$ is highly suitable for calculating permutation entropies for crop rotations**, especially when dealing with **low embedding dimensions** (e.g., $D=2,3,4$). Crop rotations often exhibit **ties and discrete states** (e.g., the same crop planted in consecutive years), which makes standard permutation entropy methods problematic. [Vidybida’s (2020)](https://doi.org/10.1155/2020/7163254) arithmetic entropy approach resolves these issues by explicitly preserving information about ties without artificially breaking them.

Here’s why and how this approach can work for crop rotations:

### **Why Arithmetic Entropy is Suitable for Crop Rotations**

1. **Ties Are Intrinsic to Crop Rotations**:
    
    - In crop rotations, the same crop might be planted over multiple consecutive cycles (e.g., $Wheat→Wheat→Corn$), leading to **ties** in the sequence.
    - Standard permutation entropy artificially breaks ties, treating them as strictly increasing $(123)$ or strictly decreasing $(321)$. This introduces **unrealistic patterns** into the analysis.
    
    **Example**:
    
    - Crop sequence: $\{Wheat, Wheat, Corn\}$
    - Standard permutation entropy forces: $112$ or $123$, depending on tie-breaking rules.
    - Arithmetic entropy preserves the tie: $[0,0,1]$, reflecting the actual pattern of repetition.
    
2. **Low Embedding Dimensions Are Common**:
    
    - Crop rotation studies typically use small embedding dimensions $(D=2,3)$, where ties are more likely because the crop set is limited (e.g., $Wheat,Corn,Soybean$).
    - In such cases, arithmetic entropy:
        - Avoids combinatorics (no need to calculate $D!$ permutations),
        - Ensures the calculation remains computationally efficient.
        
3. **Captures the Meaning of Repeated Crops**:
    
    - In crop rotations, consecutive planting of the same crop often holds ecological significance (e.g., soil nutrient depletion or pest buildup).
    - Preserving this information allows arithmetic entropy to better reflect the **temporal patterns and complexity** of the crop rotation system.
    
4. **Discrimination Between Similar Systems**:
    
    - Arithmetic entropy is better at distinguishing systems where ties (repeated crops) are frequent.
    - For example:
        - Rotation $A→A→B→C→A→A→C$,
        - Rotation $A→B→C→A→B→C→A.$
        - Standard permutation entropy may assign similar values due to forced ordering, while arithmetic entropy captures the repetitive structure in the first system.
---
### **How to Apply Arithmetic Entropy to Crop Rotations**

#### **1. Represent Crop Rotations as Sequences**

- Assign a unique numerical code to each crop:
    - $Wheat=1, Corn=2, Soybean=3$, etc.
- Crop rotation: $[Wheat,Wheat,Corn,Soybean,Wheat]$
- Numeric sequence:$[1,1,2,3,1]$
---
#### **2. Generate Embedding Vectors**

- Choose an embedding dimension $D$ (e.g., $D=3$).
- Extract overlapping windows (embedding vectors):
    - $[1,1,2]$, $[1,2,3]$, $[2,3,1]$
---
#### **3. Symbolize Vectors Using Arithmetic Patterns**

- Replace each embedding vector with an **arithmetic order pattern**:
    - For $[1,1,2]$: Assign ranks:
        - First and second $1's$ tie $(0,0)$,
        - $2$ gets the next rank $(1)$.
        - Arithmetic pattern: $[0,0,1]$.
    - For $[1,2,3]$: Strictly increasing, so:
        - Arithmetic pattern: $[0,1,2]$
    - For $[2,3,1]$: $1$ is smallest, $2$ is next, $3$ is largest:
        - Arithmetic pattern: $[1,2,0]$.
---
#### **4. Convert Arithmetic Patterns to Integers**

- Use base-$D$ encoding:
    - $[0,0,1]$: $A=0⋅3^2+0⋅3^1+1⋅3^0=1$,
    - $[0,1,2]$: $A=0⋅3^2+1⋅3^1+2⋅3^0=5$,
    - $[1,2,0]$: $A=1⋅3^2+2⋅3^1+0⋅3^0=15$.
---
#### **5. Calculate Arithmetic Entropy**

- Compute the Shannon entropy of the distribution of integers $A$: 
$$H = -\sum p(A_i) \cdot \log_2(p(A_i)),$$
- where $p(A_i)$ is the probability of each unique arithmetic pattern.
---
### **Expected Insights for Crop Rotations**

1. **Higher Entropy**:
    
    - Diverse and balanced rotations (e.g., $Wheat→Corn→Soybean→Wheat)$should yield **higher entropy**, reflecting greater complexity.
    
2. **Lower Entropy**:
    
    - Monocultures or repetitive patterns (e.g., $Wheat→Wheat→Wheat)$ will produce **lower entropy**, reflecting predictability.
    
3. **Impact of Embedding Dimension (DDD)**:
    
    - Small $D$: Captures local relationships (e.g., transitions between crops year-to-year).
    - Large $D$: Captures long-term patterns (e.g., multi-year rotational cycles).
---
### **Advantages of Using Arithmetic Entropy for Crop Rotations**

4. **Preserves Rotational Information**:
    - Ties in consecutive years are preserved, making the analysis ecologically meaningful.
5. **Efficient for Small DDD**:
    - The integer-based approach avoids computational overhead while capturing rotational complexity.
6. **Applicability Across Systems**:
    - Can be applied to various agricultural systems, even those with coarse-grained data or a limited number of crops.

---

### **Conclusion**

The arithmetic entropy method proposed in the Vidybida paper is a **natural fit for analyzing crop rotations**, where ties are common, and embedding dimensions are typically low. It allows for a more nuanced understanding of rotational complexity by preserving ties and avoiding arbitrary assumptions. Let me know if you’d like to implement this method or analyze specific crop rotation data!