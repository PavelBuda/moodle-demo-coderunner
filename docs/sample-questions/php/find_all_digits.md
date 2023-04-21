# Sample find all digits in string
## Question
Create a function find($str) which would return all digits in string and return them as string

## Answer
```php
<?php

function find($str) {
    return preg_replace('/[^0-9]/', '', $str);
}
```

## Test cases

| Case                           | Expected |
|--------------------------------|----------|
| `echo find('asdfwqe234asdf3')` | `2343`   |
| `echo find('slkdmfg435as454')` | `435454` |
