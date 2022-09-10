## Requirements

---

1. Docker
2. Java 17
3. Maven

## Using:

---

1. Build image:

``` bash
mvn spring-boot:build-image
```

2. Run docker:

``` bash
docker run --rm -p 8080:8080 docker.io/library/spring-native-simple-project:1.0-SNAPSHOT
```

3. Show resource usage statistics:

``` bash
docker stats
```

4. Testing response

``` bash
curl localhost:8080
```
