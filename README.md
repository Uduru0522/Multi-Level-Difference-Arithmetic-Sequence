## "Multi-Level Difference Arithmetic Sequence"
Stands for **a sequence that its difference between each term also forms a Multi-Level Difference Arithmetic Sequence** recursively, 
until the difference become constant (at the last level).

**Example**

The following sequence: 
1 -> 2 -> 4 -> 7 -> 11 -> ...
Has the difference sequence:
1 -> 2 -> 3 -> 4 -> ...
Has the constant difference $1$, which inhere we can say,
> The Sequence's first level difference is 1, and the second level difference is also 1.

The target of this program is to print out the sequence within a 32-bit integer range, 
with the given **initial-term, levels and difference list**
For the example sequence, the given input shall be `[1], [2], [1, 1]`.
