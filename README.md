# xai.py: Explainable Multi-Objective Optimization

> *"In any field, find the strangest thing and explore it."*
> — John Archibald Wheeler

**xai.py** is a lightweight, zero-dependency framework for
multi-objective optimization. It challenges the software engineering
dogma that complex problems require complex tools.

## The Big Picture: The "Strangest Thing" About Software

Software theoretically shouldn't work. A modest system with 300
boolean variables has 2<sup>300</sup> states—more than the number of
stars in the observable universe (10<sup>24</sup>). If software
required us to manage every one of those states, we would never ship
a single line of code.

Yet, software *does* work. We build the Web, flight controllers,
and banking systems.

**Why?**
Because the **effective** structure of software is remarkably
simple. The "good" behaviors do not live on needle-point
singularities hidden in a chaotic landscape; they live on broad,
low-dimensional plateaus. A few key variables ("keys") usually
control the entire system.

**The Thesis of xai.py:**
Because the solution space is simpler than the theoretical space:
1. We do not need complex optimization frameworks (like genetic
   algorithms or neural nets).
2. We do not need "Big Data."
3. We need **Sampling Efficiency** (finding the plateau quickly)
   rather than **Computational Efficiency** (processing millions
   of rows).

---

## Case Study: Controlling Flight Software

Does simplicity actually work on real data?

Consider the `xomo_flight` dataset: 10,000 scenarios of flight
software development involving **24 independent variables**
(inputs) and **4 conflicting objectives** (Minimize Effort, Months,
Defects, and Risks).

Running `xai.py` produces the following decision tree:

```text
./xai.py -l 4 --tree ~/gits/moot/optimize/process/xomo_flight.csv

                                     score   N    EFFORT-, MONTHS-...
                                     -----   ---  -------------------
.                                  : 0.5   : 25 : 1119.0, 30.6, ...
FLEx >= 4.428                      : 0.27  :  4 : 786.7, 27.5, ...
FLEx < 4.428                       : 0.55  : 21 : 1182.3, 31.2, ...
| 2.67 <= RUSE < 3.19              : 0.29  :  4 : 819.6, 28.3, ...
| RUSE < 2.67 or RUSE >= 3.19      : 0.61  : 17 : 1267.7, 31.8, ...
| | PCAP >= 4.805                  : 0.36  :  5 : 893.1, 28.1, ...
| | PCAP < 4.805                   : 0.71  : 12 : 1423.7, 33.4, ...
| | | RELY >= 4.82                 : 0.5   :  4 : 1170.8, 31.2, ...
| | | RELY < 4.82                  : 0.79  :  8 : 1550.2, 34.5, ...
{:uses 4 :x 24 :y 4 :rows 10_000 :lo 0.15 :mid 0.48 :win 84}
```
Here is the complete, verbatim markdown for your `README.md`. I have
incorporated the `<sup>` tags for the exponents as requested, and
ensured the lines are wrapped to 70 characters.

```markdown
# xai.py: Explainable Multi-Objective Optimization

> *"In any field, find the strangest thing and explore it."*
> — John Archibald Wheeler

**xai.py** is a lightweight, zero-dependency framework for
multi-objective optimization. It challenges the software engineering
dogma that complex problems require complex tools.

## The Big Picture: The "Strangeness" of Software

Software theoretically shouldn't work. A modest system with 300
boolean variables has 2<sup>300</sup> states—more than the number of
stars in the observable universe (10<sup>24</sup>). If software
required us to manage every one of those states, we would never ship
a single line of code.

Yet, software *does* work. We build the Web, flight controllers,
and banking systems.

**Why?**
Because the **effective** structure of software is remarkably
simple. The "good" behaviors do not live on needle-point
singularities hidden in a chaotic landscape; they live on broad,
low-dimensional plateaus. A few key variables ("keys") usually
control the entire system.

**The Thesis of xai.py:**
Because the solution space is simpler than the theoretical space:
1. We do not need complex optimization frameworks (like genetic
   algorithms or neural nets).
2. We do not need "Big Data."
3. We need **Sampling Efficiency** (finding the plateau quickly)
   rather than **Computational Efficiency** (processing millions
   of rows).

---

## Case Study: Controlling Flight Software

Does simplicity actually work on real data?

Consider the `xomo_flight` dataset: 10,000 scenarios of flight
software development involving **24 independent variables**
(inputs) and **4 conflicting objectives** (Minimize Effort, Months,
Defects, and Risks).

Running `xai.py` produces the following decision tree:

```text
./xai.py -l 4 --tree ~/gits/moot/optimize/process/xomo_flight.csv

                                     score   N    EFFORT-, MONTHS-...
                                     -----   ---  -------------------
.                                  : 0.5   : 25 : 1119.0, 30.6, ...
FLEx >= 4.428                      : 0.27  :  4 : 786.7, 27.5, ...
FLEx < 4.428                       : 0.55  : 21 : 1182.3, 31.2, ...
| 2.67 <= RUSE < 3.19              : 0.29  :  4 : 819.6, 28.3, ...
| RUSE < 2.67 or RUSE >= 3.19      : 0.61  : 17 : 1267.7, 31.8, ...
| | PCAP >= 4.805                  : 0.36  :  5 : 893.1, 28.1, ...
| | PCAP < 4.805                   : 0.71  : 12 : 1423.7, 33.4, ...
| | | RELY >= 4.82                 : 0.5   :  4 : 1170.8, 31.2, ...
| | | RELY < 4.82                  : 0.79  :  8 : 1550.2, 34.5, ...
{:uses 4 :x 24 :y 4 :rows 10_000 :lo 0.15 :mid 0.48 :win 84}

```

Note what has happened here:

* **Drastic Simplification:** Despite having **24** variables to
choose from, the algorithm found that only **4** mattered
(`FLEx`, `RUSE`, `PCAP`, `RELY`).
* **High Performance:** By controlling just these 4 variables, we
achieve **84%** of the optimal score (`:win 84`).

We do not need to manage 24 complex factors. We only need to manage
the 4 "keys."

---

## FAQ: Philosophy & Design

### 1. The "Backpacking" Philosophy (Why no Pandas/Numpy?)

**Q: Why implement custom `Num`/`Sym` classes and CSV parsers
instead of using industry standards like Pandas?**

**A:** We practice **"Backpacking"** software design—carrying only
what is strictly necessary. By removing heavy external dependencies,
this code achieves:

* **Auditability:** Every line of logic is visible and understandable
by a human.
* **Portability:** It runs in restricted environments, CI/CD
pipelines, or secure air-gapped systems where `pip install` is
blocked.
* **Supply Chain Security:** It is immune to attacks on upstream
libraries.
* **Longevity:** It will run 10 years from now without "dependency
hell."

### 2. Novelty & "Complexity Theater"

**Q: Isn't "Keep It Simple" (KISS) obvious? What is novel here?**

**A:** KISS is a slogan, not a practice. The industry currently
suffers from **Complexity Theater**.
In a recent survey of 229 papers applying LLMs to Software
Engineering, **only 5%** compared their complex results against a
simple baseline. This work provides rigorous proof that simple
methods are not just "okay"—they are often optimal because they
exploit the underlying simplicity of the software domain.

### 3. Random Probing vs. "Smart" Search

**Q: Why does the code rely on random probing? Isn't that just
"dumb luck"?**

**A:** It is not luck; it is geometry.
If the "success zone" of a software configuration were a tiny point,
random probing would fail. But because the success zone is usually
a large manifold (a plateau), random probing hits it with
surprising frequency. We aren't "monkeys typing Shakespeare"; we
are monkeys throwing darts at a barn door. It is hard to miss.

### 4. Simplicity & Discretization (Why `bins=7`?)

**Q: Why is `bins=7` hard-coded? Why not use dynamic binning?**

**A:** Because complexity is a cost we refuse to pay without proof.
Cognitive science (Adams, Fillon) proves humans have a 4:1 bias
toward **adding complexity** rather than removing it. We
instinctively think "more bins = better." However:

* **Cognitive Load:** `7` aligns with **Miller’s Law** (humans
hold 7 +/- 2 items in working memory). If an explanation
requires 20 bins, it is not "explainable."
* **Statistical Robustness:** With small samples (e.g., N=30),
sqrt(N) approx 5.5. Using 7 bins matches the granularity
justifiable by the data.

### 5. Performance & Scale

**Q: This code iterates using standard Python loops. Won't this
grind to a halt on large datasets?**

**A:** You are confusing **Computational Efficiency** with
**Sampling Efficiency**.
Standard optimizers assume the haystack is hard to search, so they
build massive machinery to sift through it. We assume the "needle"
is actually quite large.
Empirical evidence on 120+ SE datasets shows that evaluating just
**30 to 100 samples** is often sufficient to rank the top
solutions. When N=30, Python loops are instantaneous. We don't
need to process the whole dataset to understand it.

---

## Quick Start

### Installation

This is a single-file script. No `pip install` required.

```bash
# Download source
curl -O \
[https://raw.githubusercontent.com/timm/six/refs/heads/main/src/xai.py](https://raw.githubusercontent.com/timm/six/refs/heads/main/src/xai.py)

mv xai.py xaipy
chmod +x xaipy

# Download sample data
mkdir -p $HOME/gits
git clone [http://github.com/timm/moot](http://github.com/timm/moot) $HOME/gits/moot

```

### Usage

Run the script on a CSV file. The columns in the CSV header
determine the objective:

* `Name+`: Maximize this column.
* `Name-`: Minimize this column.
* `Name`: Independent variable.

```bash
# Run with default settings
./xaipy --tree $HOME/gits/moot/optimize/misc/auto93.csv

# Custom settings: 
#   -B 50 (Budget of 50 evaluations)
#   -b 5  (Discretize into 5 bins)
./xaipy -B 50 -b 5 -d $HOME/gits/moot/optimize/misc/auto93.csv

```

### Command Line Options

```text
  -h                help
  -b bins=7         set number of bins for discretization
  -B Budget=30      set number of rows to evaluate
  -C Check=5        set number of guesses to check
  -d data=data.csv  set data to load
  -l leaf=2         set examples per leaves in a tree
  -s seed=1         set random number seed

```

---

*(c) 2025 Tim Menzies, MIT License*


