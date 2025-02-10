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
- Measures **local complexity** using short-term ordinal patterns.
- Uses an **embedding dimension (D)** to detect structure.
- Handles **ties**, which occur when the same crop appears consecutively.
- Here, AE is **normalized** so its value ranges from 0 to 1

**Formula:**
Hₐₑ = Hₐₑ / log₂(K)

where **K** is the number of unique ordinal patterns.

### **2️⃣ Transition Arithmetic Entropy (TAE)**
- Captures **global complexity** by encoding transitions between crops as distinct categories.
- **Ties are treated as unique transition types** to avoid bias.
- Here TAE is **normalized** so its value ranges from 0 to 1

**Formula:**
Hₜₐₑ = Hₜₐₑ / log₂(M)

where **M** is the number of unique crop transitions.


### **3️⃣ Combined Entropy Metric**
- Integrates **AE and TAE** to quantify **overall crop sequence complexity**.
- Uses the **Euclidean norm** to balance both local and global complexity:

Hₜₒₜ = sqrt(Hₐₑ² + Hₜₐₑ²) / sqrt(2)
  
- **Why Use This?** It provides a **single, interpretable score** that reflects how structured or unpredictable a rotation is.

---

## **📈 Example Results**
Input Crop Rotation Sequence
["Wheat", "Wheat", "Corn", "Soybean", "Wheat", "Corn", "Wheat"]

### **Computed Entropy Metrics**

| **Metric** | Value |
|-------------|------------|
| Arithmetic Entropy (AE) |	0.65 |
| Transition Arithmetic Entropy (TAE) |	0.80 |
| Combined Entropy Metric |	0.73 |

### **📊 Interpretation**:

- AE = 0.65 → Moderate diversity in short-term patterns.
- TAE = 0.80 → High diversity in global crop transitions.
- Combined Metric = 0.73 → A well-structured, moderately complex rotation.

## **🌍 Applications**
- 🔬 Sustainable Agriculture – Identify rotation strategies that enhance soil health and biodiversity.
- 📉 Climate Resilience – Evaluate the adaptability of crop rotations under changing climate conditions.
- 📊 Comparative Studies – Rank different farming practices based on their entropy scores.
- 📌 Policy & Decision-Making – Support data-driven agricultural planning and sustainability initiatives.

## **🤝 Contributing**
We welcome contributions! Feel free to:

Fork the repository
Create a feature branch (feature-name)
Submit a pull request with detailed explanations

## **📜 License**
This project is licensed under the MIT License – allowing for free use, modification, and distribution.

## **🚀 Future Directions**
📌 Incorporate external crop scoring systems (e.g., climate resilience, pest control).
📌 Expand to multi-year crop sequences for long-term analysis.
📌 Automate report generation with R Markdown.

## **💡 Final Thoughts**
Permutation Entropy Crops brings a new perspective to agricultural data analysis, bridging the gap between mathematical complexity measures and real-world sustainability challenges. By leveraging entropy methods, we can better understand how crop rotation choices impact long-term resilience.

🔹 Ready to explore entropy-based crop analysis? 🚜 Clone the repo and run analysis.R today! 🌾📊
