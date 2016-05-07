# 团购

## Usage
```
配置config/database.yml
```

## 发布
```
mina deploy
```

## 域名
```
test.yiliaohj.com
test.yiliaohj.com/admin
```

rails generate devise:install


## Usage
```
跑索引
Hospital.__elasticsearch__.create_index! force: true
Hospital.import
```

## 图
```
rake diagram:all
```

发布需求
添加关注等（登录情况）

```
4-24
疾病详情页面没有
```

### 使用云 mongodb
```
mongorestore --host 10.4.44.137 --db yiliao_production ./mongodb_yiliao_20160507/yiliao_production -u root -p yiliaohj_syso --authenticationDatabase yiliao_production
```

mongo --host 10.4.44.137 -u "root" -p "yiliaohj_syso" --authenticationDatabase "yiliao_production"
mongo --host 10.4.44.137 -u "guyifeng" -p "password" --authenticationDatabase "yiliao_production"

mongorestore --host 10.4.44.137 --db yiliao_production ./mongodb_yiliao_20160506/yiliao_production -u guyifeng -p password


db.createUser(
  {
    user: "guyifeng",
    pwd: "password",
    roles: [ { role: "readWrite", db: "yiliao_production" } ]
  }
)