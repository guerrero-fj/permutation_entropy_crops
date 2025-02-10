### **🔹 How Does Permutation Entropy (PE) Handle Ties?**

Permutation Entropy (PE) was originally designed for **continuous time series**, where the probability of two values being exactly the same is very low. However, in **discrete datasets**—such as **crop rotation sequences, financial data, or quantized measurements**—**ties (repeated values)** occur frequently.

Since **PE relies on ordinal rankings**, ties introduce **ambiguity** in how patterns are assigned. Different approaches have been proposed to handle them, each with **trade-offs**.

---

## **1️⃣ The Problem: Why Are Ties Difficult for PE?**

PE determines **ordinal patterns** by ranking values within a **D-length window**.

### **Example Without Ties (D = 3)**

Given **X = [10, 15, 5]**, we sort them:

Ordinal pattern → **(2,3,1)**.

✅ **No problem!** The ranking is clear.

---

### **Example With Ties**

What happens if we have **X = [10, 10, 5]**?

`10 → 10 = ?`

**Ambiguity:** Should the two 10s be ranked as (2,3) or (3,2), or (2,2)?

This **arbitrary choice affects entropy calculations**, leading to **inconsistent or biased results**.

---

## **2️⃣ How Does Classic PE Handle Ties?**

The **original Bandt & Pompe (2002) method** forces an arbitrary **ranking rule**:

1. **Break ties by assigning increasing ranks (first-come-first-served)**
    
    - Example: `[10, 10, 5]` becomes **(3,1,2)**
    - The **first 10 is ranked lower** than the **second 10**.
2. **Break ties randomly** (less common)
    
    - Assign ranks at random (e.g., `[10, 10, 5]` could be **(3,1,2)** OR **(3,2,1)** randomly).
    - This **reduces bias**, but **introduces noise** into entropy calculations.

🔴 **Problem:**

- **This method does not preserve the fact that two values are equal.**
- The same pattern might be assigned different ranks in different occurrences, **altering entropy values**.
- If a time series has **many ties**, this method **overestimates entropy** by treating structurally similar sequences as if they were different.

---

## **3️⃣ Alternative Solutions for Handling Ties**

Several approaches **modify PE** to address the **bias introduced by ties**:

### **🔹 Method 1: Weighted Permutation Entropy (WPE)**

- Instead of using **strict ordinal ranks**, **weights are assigned based on value differences**.
- If **two values are equal**, they receive **the same ranking**, reducing artificial disorder.
- **More sensitive to gradual changes**, useful in **slowly varying datasets** (e.g., climate data).

🔵 **Pro:** Retains **more information** about the original sequence.  
🔴 **Con:** Increases **computational cost**.

---

### **🔹 Method 2: Arithmetic Entropy (AE)**

- Instead of **ranking ties arbitrarily**, AE **explicitly encodes equal values as distinct patterns**.
- Uses a **base-D encoding** to **preserve tie structure**, allowing more accurate entropy estimation.
- **Example:**
    - `[10, 10, 5]` → Instead of **(3,2,1)**, AE encodes it as **(2,2,1)**, preserving the tie.

🔵 **Pro:** Correctly represents **ties as they are**, making it ideal for **categorical data** like **crop rotations**.  
🔴 **Con:** Needs a **custom entropy calculation** since the number of possible patterns **increases beyond D!**.

---

### **🔹 Method 3: Fuzzy Permutation Entropy (FPE)**

- Assigns **probabilities** to different ranking orders **instead of forcing a single ordinal pattern**.
- Example: `[10, 10, 5]` could contribute **50% weight to (3,1,2) and 50% to (3,2,1)**.
- This **reduces bias** in entropy computation.

🔵 **Pro:** Reduces **overestimation of entropy**.  
🔴 **Con:** **Computationally expensive** for large datasets.

---

### **4️⃣ Which Method Should We Use for Crop Rotation Data?**

For **discrete datasets like crop rotations**, we need an approach that: 
✅ **Preserves ties explicitly** (since the same crop can be planted multiple years).  
✅ **Provides accurate entropy estimates** without inflating disorder.  
✅ **Is computationally efficient** for large datasets.

**Best Choice → Arithmetic Entropy (AE)**

- AE handles ties **by preserving ordinal relationships instead of arbitrarily breaking them**.
- AE **maintains the correct number of unique ordinal patterns**.
- AE ensures that **two sequences with the same crops in the same order are treated consistently**.

---

## **📌 Summary**

|**Approach**|**How It Handles Ties**|**Pros**|**Cons**|
|---|---|---|---|
|**Classic PE (Bandt & Pompe, 2002)**|Arbitrarily ranks ties (e.g., first-come-first-served)|✅ Computationally fast|❌ Introduces bias, overestimates entropy|
|**Weighted PE (WPE)**|Uses **weighted differences** instead of strict ranks|✅ More accurate for continuous data|❌ Computationally expensive|
|**Arithmetic Entropy (AE)**|**Preserves equal values explicitly**|✅ Best for categorical data (e.g., crop rotations)|❌ Requires modified entropy computation|
|**Fuzzy PE (FPE)**|Assigns probabilities to **different tie-breaking orders**|✅ Reduces bias|❌ Harder to compute|

🚀 **For crop rotation analysis, AE is the best choice because it correctly encodes ties without inflating entropy.**