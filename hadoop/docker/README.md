#1 Build image

```
bash build-image.sh
```

#2 Start container

```
bash start-container.sh
```

#3 Start hadoop
Sau khi start container, sẽ vào trong shell của container master, chạy lệnh start hadoop là đc
Note: nhớ tạo network trước khi chạy ```docker network create --driver=bridge hadoop```


```
bash start-hadoop.sh
```
