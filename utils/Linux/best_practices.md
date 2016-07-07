## 怎样查找一个文件所属的package

* 使用dpkg

  ```dpkg -S /usr/lib/tracker/tracker-store```

* apt-file

  ```sudo apt-file update``` or ``` apt-file update```

  ```apt-file search /usr/lib/tracker/tracker-store```

* dlocate - 速度秒杀前两者

  ```dlocate /path/to/file```

## 观察磁盘IO情况

  `$ dstat -D sda`

  或者

  `$ iostat -d 10 /dev/sda`

## example of a table

  | First Header  | Second Header | Third Header |
  |: ------------- | :-------------:|  -------------:|
  | Content Cell0000000000  | Content Cellaaaaaa  | fjlsfjlkjdsl |
  | Content Cell0000000000  | Content Cellbbbbbb  | fjlsfjlkjdsljfkdsjfldjslk |
