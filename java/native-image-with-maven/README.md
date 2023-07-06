## Requirements

---

1. Docker

## Using:

---

1. Build image:

``` bash
docker build --no-cache -t own.com/native-image
```

2. Run docker:

``` bash
docker run --rm -p 8080:8080 own.com/native-image
```

3. Show resource usage statistics:

``` bash
docker stats
```

4. Testing response

``` bash
curl localhost:8080
```
