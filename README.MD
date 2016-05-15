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

### 5.8
```
如：综合医院：列出等级医院，如三甲医院，外资医院，社区医院等；
全城;为当前市的区县域选择；
智能排序：最近，最新，最高，最低，最好等。

1．今日新单，数据暂缺，放着
2．医院大全----点击展现全部分类三行列表：进入综合医院一栏
3．综合医院列表下有四个过滤条：综合医院，全城，智能排序，筛选
4．疾病查询列表下有四个过滤条;  疾病查询，疾病分类，智能排序，筛选
5．症状查询列表下有四个过滤条;   症状查询，关键字，智能排序，筛选
6．找医生列表下有四个过滤条;     找医生，科室，智能排序，筛选
7．肿瘤医院列表下有四个过滤条;   肿瘤医院，全城，智能排序，筛选
8．母婴会馆列表下有四个过滤条： 母婴会馆，全城，智能排序，筛选
9．月子团购列表下有四个过滤条： 月子团购，全城，智能排序，筛选
10.保险团购列表下有四个过滤条：  保险团购，保险精选，智能排序，筛选
11.保健品团购列表下有四个过滤条：保健品团购，精选，智能排序，筛选
12.精准攻略列表下有四个过滤条：  精准攻略，精选，智能排序，筛选
13.精准体检列表下有四个过滤条：  精准体检，精选，智能排序，筛选
14.特色科室列表下有四个过滤条：  特色科室，科室，智能排序，筛选
15.最新优惠列表下有四个过滤条：  最新优惠，精选，智能排序，筛选
16.海外医疗列表下有四个过滤条：  海外医疗，精选，智能排序，筛选
17.精准整形列表下有四个过滤条：  精准整形，精选，智能排序，筛选
18.精准牙科列表下有四个过滤条：  精准牙科，精选，智能排序，筛选
19.精准妇幼列表下有四个过滤条：  精准妇幼，精选，智能排序，筛选
20.精准男科列表下有四个过滤条：  精准男科，精选，智能排序，筛选
21.精准中医列表下有四个过滤条：  精准中医，精选，智能排序，筛选
22.精准购药列表下有四个过滤条：  精准购药，疾病，智能排序，筛选
```
```
/diseases filter 样式调整

```



```
    <!-- 去订阅 -->
    <div class="information-push-categories right-content">
      <% if @subscription_categories.empty? %>
        暂无订阅<a href="<%= frontend_person_customs_path %>">去订阅相关健康资讯</a>
      <% end %>
      <% @subscription_categories.each do |subscription_category| %>
        <ul class="list-unstyled push-list">
          <% subscription_category.information.each do |information| %>
            <li class="push-item">
              <a href="/information/<%= information.id.to_s %>" class="title">
                【<%= subscription_category.name %>】
                <%= information.title %>
              </a>
              <div class="publish-time">
                <%= information.created_at %>
              </div>
            </li>
          <% end %>
        </ul>
      <% end %>
      <div >
        <a href="#">加载更多...</a>
      </div>
    </div>

```