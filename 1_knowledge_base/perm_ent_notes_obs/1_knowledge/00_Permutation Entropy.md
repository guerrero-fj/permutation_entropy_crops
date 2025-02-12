### **What Is Permutation Entropy?**

**Permutation Entropy (PE)** is a **complexity measure** for time series data based on the **ordering of values rather than their magnitudes**. It was introduced by **Bandt & Pompe (2002)** as a robust method to analyze **temporal patterns** in signals.

At its core, PE **quantifies how unpredictable the arrangement of values is** in a time series by computing the **frequency of ordinal patterns** within a given embedding dimension (**D**).

### **2️⃣ Why Use Permutation Entropy?**

✅ **Invariant to nonlinear transformations** (e.g., shifting or scaling values).  
✅ **Captures underlying dynamics** without requiring explicit model assumptions.  
✅ **Computationally efficient**, making it suitable for large datasets.

### **3️⃣ How Is Permutation Entropy Computed?**

#### **Step 1: Choose an Embedding Dimension (D)**

- This determines the **window size** for analyzing local order patterns.
- Example: If **D = 3**, we look at **triplets** of consecutive values.

#### **Step 2: Extract All Possible Sub-Sequences of Length D**

- Given a time series **X = [x₁, x₂, x₃, x₄, x₅]**, for **D = 3**, we extract:
    
        `[x₁, x₂, x₃], [x₂, x₃, x₄], [x₃, x₄, x₅]`
    
- Each of these groups is an **embedding vector**.

#### **Step 3: Rank the Elements in Each Sub-Sequence**

- **Convert values into ordinal patterns** by ranking them from smallest to largest.
- Example: If **[x₁, x₂, x₃] = [10, 15, 5]**, the ranks are:
   
    `[2nd, 3rd, 1st] → (2,3,1)`

- If **values are equal (ties), they are handled separately**.

#### **Step 4: Compute the Frequency of Each Unique Pattern**

- Count how often each **ordering pattern** occurs.
- Example: In **10-year crop rotation data**, we might find that:

    `(1,2,3) appears 40% of the time (2,3,1) appears 30% of the time (3,1,2) appears 20% of the time (2,1,3) appears 10% of the time`

- This distribution tells us how **predictable** the system is.

#### **Step 5: Compute Permutation Entropy (PE)**

Using **Shannon entropy**:

$$HPE=−∑p(πi)log⁡2p(πi)$$

where $$p(πi)$$ is the probability of observing the **i-th ordinal pattern**.

- **If all patterns appear equally**, entropy is **maximized** → **high complexity**.
- **If only one pattern dominates**, entropy is **low** → **high predictability**.

#### **Step 6: Normalize the Entropy**

To compare across datasets, we **normalize** PE by dividing by the maximum possible entropy:

$$HPE_{norm} = \frac{H_{PE}}{\log_2(D!)}$$​​

where **D!** is the number of possible unique ordinal patterns for a given **D**.

- **Normalized PE ≈ 1** → Highly complex, nearly random sequence.
- **Normalized PE ≈ 0** → Fully predictable, structured sequence.

---

### **4️⃣ Example Calculation**

#### **Example 1: Simple Crop Rotation**

Imagine we have the **5-year crop sequence**:


`["Corn", "Soybean", "Wheat", "Corn", "Soybean"]`

##### **Step 1: Select D = 3**

We extract **3-year sequences**:

|**Window**|**Ranked Pattern**|**Ordinal Representation**|
|---|---|---|
|Corn → Soybean → Wheat|Increasing order|**1-2-3**|
|Soybean → Wheat → Corn|2nd > 3rd > 1st|**2-3-1**|
|Wheat → Corn → Soybean|Increasing order|**1-2-3**|

##### **Step 2: Count Frequencies**

- Pattern **1-2-3** appears **twice**.
- Pattern **2-3-1** appears **once**.

##### **Step 3: Compute PE**

$$HPE= -\left( \frac{2}{3} \log_2 \frac{2}{3} + \frac{1}{3} \log_2 \frac{1}{3} \right)≈0.92$$

##### **Step 4: Normalize PE**

$$HPE_{norm} = \frac{H_{PE}}{\log_2(3!)} = \frac{0.92}{\log_2(6)}≈0.75$$

**Interpretation:**
$$HPE_{norm} = 0.75$$suggests that this sequence has **moderate complexity**.
- If a field **strictly alternated** between two crops (e.g., Corn → Soybean → Corn → Soybean), **PE would be lower (~0.3-0.5)**.
- If crops were **randomly assigned each year**, **PE would be closer to 1**.