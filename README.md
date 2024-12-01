# db-migrate-startkit

## 事前準備

下載安裝Docker Desktop
* [Windows版](https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe?utm_source=docker&utm_medium=webreferral&utm_campaign=dd-smartbutton&utm_location=module&_gl=1*1x0tato*_gcl_au*NDk4NzQwNjM1LjE3MjczMzQ0NDY.*_ga*MTkxMzI2NzM5NC4xNjU5OTM4NTcy*_ga_XJWPQMJYHQ*MTcyNzMzMzcxNy4xNTYuMS4xNzI3MzM0NDY4LjM3LjAuMA..)
* Mac版
  * [Intel處理器](https://desktop.docker.com/mac/main/amd64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=dd-smartbutton&utm_location=module&_gl=1*sjadaf*_gcl_au*NDk4NzQwNjM1LjE3MjczMzQ0NDY.*_ga*MTkxMzI2NzM5NC4xNjU5OTM4NTcy*_ga_XJWPQMJYHQ*MTcyNzMzMzcxNy4xNTYuMS4xNzI3MzM0NDY4LjM3LjAuMA..)
  * [M系列處理器](https://desktop.docker.com/mac/main/arm64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=dd-smartbutton&utm_location=module&_gl=1*sjadaf*_gcl_au*NDk4NzQwNjM1LjE3MjczMzQ0NDY.*_ga*MTkxMzI2NzM5NC4xNjU5OTM4NTcy*_ga_XJWPQMJYHQ*MTcyNzMzMzcxNy4xNTYuMS4xNzI3MzM0NDY4LjM3LjAuMA..)

下載並安裝Node.js
* [下載連結](https://nodejs.org/zh-tw)

下載並安裝Dbeaver Community
* [Windows版](https://dbeaver.io/files/dbeaver-ce-latest-x86_64-setup.exe)
* Mac版
  * [Intel處理器](https://dbeaver.io/files/dbeaver-ce-latest-macos-x86_64.dmg)
  * [M系列處理器](https://dbeaver.io/files/dbeaver-ce-latest-macos-aarch64.dmg)

## 開始使用

### 安裝套件

>執行前請確保已經安裝了Node.js

打開終端機並輸入以下指令
```
$ npm i
```

### 首次在本機開啟資料庫並執行遷移

> 請確保Docker Desktop已經正常啟動，並能夠看到容器頁面(Containers)

打開終端機並輸入以下指令，程式將自動啟動資料庫，並運行遷移
```
$ npm run start
```

啟動後，請檢查Docker Desktop程式界面中裡是否新增db-migrate-startkit的容器堆疊，該堆疊裡了有兩個容器：
* db_migrate-1：執行遷移檔案的容器，執行後會自動關閉（狀態（STATUS）為Exited）。請務必進入檢查查看遷移的執行結果，確保遷移執行成功。
* postgres-1：資料庫容器，狀態應為Running

### 重新啟動資料庫
```
$ npm run restart
```
### 關閉資料庫
```
$ npm run stop
```

### 關閉資料庫並清除資料
```
$ npm run clean
```
