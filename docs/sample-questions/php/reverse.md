# Sample reverse questions
## Question
Create a function reverse($str) which would return inputted string in reverse order.

## Answer
```php
<?php
function reverse($str) {
    return strrev($str);
}
```

## Test cases

| Case                       | Expected   |
|----------------------------|------------|
| `echo reverse(12345678)`   | `87654321` |
| `echo reverse("abcdefgh")` | `hgfedcba` |
