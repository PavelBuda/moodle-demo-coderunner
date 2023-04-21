# Sample reverse questions

## Question
Create a function reverse(s) which would return inputted string in reverse order.

## Answer
```python3
def reverse(s):
    return str(s)[::-1]
```

## Test cases

| Case                         | Expected   |
|------------------------------|------------|
| `print(reverse(12345678))`   | `87654321` |
| `print(reverse("abcdefgh"))` | `hgfedcba` |
