# Normalizing Arithmetic Entropy $(AE)$ 

## Maximum Possible Entropy

The maximum entropy ( $H_{\text{max}}$) occurs when all ordinal patterns are equally probable, i.e., the system exhibits maximum disorder. For AE:

$$
H_{\text{max}} = \log_2 (K)
$$

where:

- $K$ = number of possible ordinal patterns for a given embedding dimension \( D \),
- $K = D!$ for sequences without ties,
- $K > D!$ when ties are included, as ties introduce additional ordinal patterns.

## Normalized AE

The normalized AE is calculated as:

$$
H_{\text{norm}} = \frac{H}{H_{\text{max}}} = \frac{-\sum p(\alpha_i) \log_2 (p(\alpha_i))}{\log_2 (K)}
$$

where:

- $p(\alpha_i)$: Probability of each ordinal pattern.

### Example:

For $D = 3$ (embedding dimension) and no ties:

$$
K = 3! = 6
$$

$$
H_{\text{max}} = \log_2 (6) \approx 2.585 \text{ bits}
$$

If  $H = 1.5  bits$:

$$
H_{\text{norm}} = \frac{1.5}{2.585} \approx 0.58
$$

### When Ties Are Present:

- Calculate $K$ as the total number of unique ordinal patterns (including ties).
- For ties, $K$ is determined by the number of patterns that preserve ties (e.g., 112, 122).
- Use this $K$ to calculate $H_{max}$ and normalize $H$.

#  Generalizing $K$ for $AE$

In $AE$, the total number of possible ordinal patterns $K$ depends on whether ties are allowed:

### Without Ties:
The number of ordinal patterns is:

$$
K = D!
$$

where $D$ is the embedding dimension.

### With Ties:
Ties increase the number of possible patterns beyond $D!$, and $K$ must account for all possible arrangements of ranks when ties exist.

### Formula for $K$ $(AE)$:

$$
K = \sum_{d=1}^{D} \binom{D}{d} S(D,d)
$$

where:

- $D$ : The embedding dimension (number of elements in the window, e.g., $D=3$ means triplets),
- $d$: The number of unique ranks within an embedding vector (e.g., $AAB$ has 2 unique ranks, $ABC$ has 3 unique ranks),
- $\binom{D}{d}$: The **binomial coefficient**, which counts how many ways to select $d$ unique ranks from $D$,
- $S(D,d)$: The **Stirling number of the second kind**, which counts the number of ways to partition DDD elements into ddd non-empty groups (this accounts for ties).

# Understanding Each Term

## 1. Binomial Coefficient $\binom{D}{d}$

The binomial coefficient represents the number of ways to choose $d$ items from $D$, without considering order. It is calculated as:

$$
\binom{D}{d} = \frac{D!}{d! \cdot (D - d)!}
$$

where $n!$ (factorial) means the product of all positive integers up to $n$ e.g., 

$$
5! = 5 \cdot 4 \cdot 3 \cdot 2 \cdot 1 = 120
$$

### Example:
For $D = 3$ and $d = 2$:

$$
\binom{3}{2} = \frac{3!}{2!(3-2)!} = \frac{6}{2 \cdot 1} = 3
$$

This means there are 3 ways to select 2 ranks out of 3.

## 2. Stirling Numbers of the Second Kind $S(D,d)$

The Stirling number of the second kind, denoted  $S(D,d)$, is the number of ways to partition $D$ items into $d$ non-empty groups. This accounts for ties in the embedding vector.

### Interpretation:
- Each group corresponds to a unique rank in the ordinal pattern.
- $S(D,d)$ ensures that ties are represented properly in the count of patterns.

### Examples:
- $S(3,1) = 1$: There is 1 way to partition 3 items into 1 group (all elements are tied, e.g., $AAA$).
- $S(3,2) = 3$: There are 3 ways to partition 3 items into 2 groups (e.g., $AAB, ABA, BAA$).
- $S(3,3) = 1$: There is 1 way to partition 3 items into 3 groups (no ties, e.g., $ABC$).

For larger $D$, $S(D,d)$ can be calculated recursively:

$$
S(D,d) = d \cdot S(D-1,d) + S(D-1,d-1)
$$

with base cases:

$$
S(0,0) = 1
$$

$$
S(0,d) = 0, \quad \text{for } d > 0
$$

$$
S(D,0) = 0, \quad \text{for } D > 0
$$

## 3. How $\binom{D}{d} \cdot S(D,d)$ Works Together

For each value of $d$ (number of unique ranks):

- $\binom{D}{d}$: Chooses which $d$ ranks to use.
- $S(D,d)$: Counts how many patterns can be formed with $d$ unique ranks.

By summing over all possible values of $d$ (from 1 to $D$), we account for all possible ordinal patterns, including those with ties.

## 4.Example: Calculating $K$ for  $D = 3$

For $D = 3$, calculate $K$ using:

$$
K = \sum_{d=1}^{3} \binom{3}{d} S(3,d)
$$

### Step 1: Evaluate Terms for Each $d$

For  $d = 1$:

$$
\binom{3}{1} = 3
$$

$$
S(3,1) = 1
$$

**Contribution:**  
$$
3 \cdot 1 = 3
$$

For $d = 2$:

$$
\binom{3}{2} = 3
$$

$$
S(3,2) = 3
$$

**Contribution:**  
$$
3 \cdot 3 = 9
$$

For $d = 3$:

$$
\binom{3}{3} = 1
$$

$$
S(3,3) = 1
$$

**Contribution:**  
$$
1 \cdot 1 = 1
$$

### Step 2: Sum the Contributions

$$
K = 3 + 9 + 1 = 13
$$

Thus, for $D = 3$ with ties, there are **13 unique ordinal patterns**.

---

# Comparison: No Ties vs. With Ties

- **Without Ties:**  
  $$ K = D! = 6 $$  
  (Strictly ordered patterns only)

- **With Ties:**  
  $$ K = 13 $$  
  (Accounts for additional patterns introduced by ties)
