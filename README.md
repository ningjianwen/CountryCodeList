# CountryCodeList
**CountryCodeList**是swift学习的一个项目。主要使用了练习了`UITableView`的swift使用。**全球国家列表的数据来源**是之前从一张全球国家列表的**sql**表中使用**Python**洗出来来的数据，经过处理之后形式了一个**Json**文件。

每一个国家对象主要包括了：**国家的英文名**、**国家的缩写**、**国际区号**。

主要使用了**HandyJson**把从本地读取的json文件转化为数据模型数组。通过`UITableView`展示出来。

效果展示如下：
