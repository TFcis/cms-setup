# cms-setup
自動配置cms.conf

## 安裝
1. git clone 此 repo 至網頁伺服器上。
2. 執行 ```make setup``` 。
3. 將[這裡的內容](https://github.com/cms-dev/cms/blob/master/config/cms.conf.sample)複製到 ```cms.conf.sample``` 內並設定好，不要修改 ```core_services``` 和 ```other_services```。

## 配置
1. ```wget example.com/path_to_your_folder/makefile```
2. ```make main```
3. ```make service```
4. ```make getconf```
5. ```make start```

配置 ```Worker 4``` 步驟 2~5 可改成 ```make all```

## 指令
使用方法: ```make [OPTION]```

OPTION     |效果
---|---
download   |下載所有 ```.sh``` 檔 & 執行 ```chmod```
chmod      |設定所有 ```.sh``` 檔權限 ```777```
rmfile     |刪除所有 ```.sh``` 檔
redownload |刪除 & 重新下載所有 ```.sh``` 檔
service    |設定Service <br> 使用方法: ```make service s=[SERVICE] c=[COUNT]``` <br> 預設值: ```make service s=Worker c=4``` <br> 預設值: ```make service s=[SERVICE] c=1```
show       |顯示所有 Service 設定
showthis   |顯示本機 Service 設定
sys        |kill 所有 cms 程序 & 關閉防火牆
install    |安裝所有需要程式 & CMS
makeconf   |產生 ```cms.conf```
getconf    |產生 ```cms.conf``` & 下載
start      |啟動本機所有 Service <br> 使用方法: ```make start c=[CONTEST]```
main       |執行 ```download``` & ```sys``` & ```install```
all        |執行 ```main``` & ```service Worker 4``` & ```getconf``` & ```start```
help       |顯示此說明
