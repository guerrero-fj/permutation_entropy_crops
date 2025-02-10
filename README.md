# permutation_entropy_crops
# 🚜 Permutation Entropy Crops 🌾  
**R-based Entropy Analysis for Crop Rotations**  

## **🌱 Introduction**  
Crop rotation is a key agricultural practice that influences **soil health, pest resilience, climate adaptation, and overall sustainability**. However, traditional assessments often focus on **static measures** (e.g., crop frequency, diversity indices) without capturing **the complexity of rotation patterns** over time.  

🔹 This project applies **Permutation Entropy methods** to quantify the **structural complexity** of crop sequences.  
🔹 It introduces a novel **Combined Entropy Metric** that integrates **local variability** and **global transition complexity** in a unified framework.  

📊 **Key Entropy Measures Used:**  
✅ **Arithmetic Entropy (AE)** – Captures **short-term patterns** in crop rotations.  
✅ **Transition Arithmetic Entropy (TAE)** – Evaluates **global complexity** of crop transitions.  
✅ **Combined Entropy Metric** – A single score representing total sequence complexity.  

---

## **🔬 Why Use Entropy for Crop Rotation Analysis?**  
Traditional crop rotation assessments rely on **crop frequency analysis, Shannon diversity indices, or transition matrices**. These methods can identify **how often** different crops are planted but often fail to capture **the structural complexity** of crop sequences.  

### **🔄 Comparison to Other Methods**
| **Method** | **Captures Local Patterns?** | **Captures Global Transitions?** | **Handles Ties?** | **Computational Complexity** |
|------------|-----------------------------|---------------------------------|-------------------|-----------------------------|
| **Crop Frequency** | ❌ No | ✅ Yes (Static) | ✅ Yes | 🟢 Low |
| **Shannon Diversity** | ❌ No | ✅ Yes (Static) | ✅ Yes | 🟢 Low |
| **Markov Models** | ❌ No | ✅ Yes (Probabilistic) | ❌ No | 🔴 High |
| **Transition Matrix Entropy (TME)** | ❌ No | ✅ Yes (Based on Transition Probabilities) | ❌ No | 🟡 Medium |
| **Permutation Entropy (AE & TAE)** | ✅ Yes | ✅ Yes (Captures Complexity) | ✅ Yes | 🟢 Medium |

📌 **AE and TAE provide a more nuanced understanding** of crop sequence complexity, particularly when sequences involve repeated crops (ties), rotational cycles, and non-trivial patterns.

---

## **📊 Key Entropy Metrics Used in This Project**
### **1️⃣ Arithmetic Entropy (AE)**
- Measures **local complexity** by analyzing **short-term ordinal patterns** in the sequence.
- Uses an **embedding dimension** (window size) to detect structure.
- **Accounts for ties**, which occur when the same crop appears consecutively.
- **Formula:**
  \[
  H_{\text{AE, norm}} = \frac{H_{\text{AE}}}{\log_2(K)}
  \]
  where \(K\) is the number of unique ordinal patterns.

### **2️⃣ Transition Arithmetic Entropy (TAE)**
- Captures **global complexity** by encoding transitions between crops as distinct categories.
- **Ties are treated as unique transition types** to avoid bias.
- **Formula:**
  \[
  H_{\text{TAE, norm}} = \frac{H_{\text{TAE}}}{\log_2(M)}
  \]
  where \(M\) is the number of unique crop transitions.

### **3️⃣ Combined Entropy Metric**
- Integrates **AE and TAE** to quantify **overall crop sequence complexity**.
- Uses the **Euclidean norm** to balance both local and global complexity:
  \[
  H_{\text{combined, norm}} = \frac{\sqrt{H_{\text{AE, norm}}^2 + H_{\text{TAE, norm}}^2}}{\sqrt{2}}
  \]
- **Why Use This?** It provides a **single, interpretable score** that reflects how structured or unpredictable a rotation is.

---

## **📂 Project Structure**
