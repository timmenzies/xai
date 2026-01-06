# xai.py: Explainable Multi-Objective Optimization

> *"In any field, find the strangest thing and explore it."*
> — John Archibald Wheeler

**xai.py** is a lightweight, zero-dependency framework for
multi-objective optimization. It challenges the software engineering
dogma that complex problems require complex tools.

## The Big Picture: The "Strangeness" of Software

Software theoretically shouldn't work. A modest system with 300
boolean variables has $2^{300}$ states—more than the number of
stars in the observable universe ($10^{24}$). If software required
us to manage every one of those states, we would never ship a
single line of code.

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
