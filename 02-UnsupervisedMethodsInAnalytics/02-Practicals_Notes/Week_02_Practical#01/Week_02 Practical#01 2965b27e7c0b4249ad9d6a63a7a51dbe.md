# Week_02:Practical#01

## 文件

[Wangjun_Prac#01.pdf](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Wangjun_Prac01.pdf)

[Prac#1-Get-Started-with-SAS-EM-2023.pdf](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Prac1-Get-Started-with-SAS-EM-2023.pdf)

## 注册与下载与开始

打开网站：[https://welcome.oda.sas.com/](https://welcome.oda.sas.com/)

点击“SAS Profile”来进行注册，使用UniSA的邮件地址来进行创建。

在Enrollment里里面注册一个课程，课程代码为：b911c7be-5272-4d87-80a6-5b5f3ad388a9，注册之后的course name为：UMA-UniSA-SP2-2023

完成之后在右边会有SAS EM的下载框出现：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled.png)

点击并且开始下载：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%201.png)

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%202.png)

安装的时候会需要一个URL进行激活，这个URL可以在页面中找到。

点击SAS EM，可以出现这样的一个页面：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%203.png)

## 创建一个 new project

在欢迎页面，点击New Project，File - New - Project：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%204.png)

在这个步骤中唯一能够存在的server是the host server。

在点击next之后，将project name显示为：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%205.png)

接着是地址：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%206.png)

最后创建成功这个项目：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%207.png)

如果已经存在着一个项目，则可以点击打开项目，然后出现这样的一个结果：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%208.png)

最终看到的页面如下所示：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%209.png)

## 创建一个diagram

接着创建一个 new diagram：File → New → Diagram from the main menu。

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2010.png)

创建之后如下图所示：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2011.png)

diagram workspace现在是empty的，如果想要 conduct analysis，则需要创建一个 process flow。

通常来讲，第一步是defining a data source一遍进行analysis。

## Define a data source

**Part 1：Specifying Data Source**

步骤如下所示： File —— New ——Data Source。

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2012.png)

默认的情况之下，选择的是SAS table，但是在这个practical中，需要选择的是Metadata Repository：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2013.png)

得到如下所示的结果：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2014.png)

在这里选哟选择SAS Table用来让SAS EM进行使用。

在这个Practical中：Shared Data —— Libraries —— AAEM，接着选择PVA97NK：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2015.png)

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2016.png)

点击下一步：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2017.png)

点击下一步：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2018.png)

在这一步，Data Source Wizard提供了关于selected table的basic information。

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2019.png)

**Part 2：Defining Column Metadata**

点击next：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2020.png)

两个选择的区别：

1. Basic Setting：根据变量名称、数据类型和分配的 SAS 格式等变量属性为元数据分配初始值。
2. Advanced Setting：以与 Basic 设置相同的方式为元数据分配初始值，但它还评估每个变量的分布以更好地确定适当的测量级别。

在这一步，选择basic setting来进行下一步：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2021.png)

选择标签（label）旁边的框：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2022.png)

数据源向导显示其对于元数据分配的最佳猜测，这个猜测是基于每个变量的名称和数据类型。Model Role的correct values和measurement level可以在PVA97NK metadata table的next page。

如下所示：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2023.png)

将当前分配的元数据与下一页 PVA97NK 元数据表中的元数据进行比较，可以看出一些差异。 虽然分配的建模角色大部分是正确的，但为几个变量分配的测量级别是错误的。

选择Back，然后选择Advanced选项，来尝试进行improve这个结果：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2024.png)

得到的结果为：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2025.png)

虽然有许多默认的元数据的设置是正确的，但是有几项需要被更改。

例如，DemCluster 变量被拒绝（因为有太多不同的值）并且不包括在分析中，并且几个数字输入将它们的测量级别设置为名义而不是间隔（因为有太少的不同值）。

为避免进行元数据调整的耗时任务，请返回到前面的数据源向导步骤并自定义 Metadata Advisor。

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2026.png)

可以发现，在default advanced的时候，metadata advisor可以执行以下的操作：

1. 拒绝有着过多缺失值的变量 默认值=50%
2. 检测数字变量的数类级别，并为类计数低于选定阀值的变量分配名义角色 默认值 20
3. 检测字符变量的类别级别数，并将拒绝角色分配给类别计数高于选定阀值的变量 默认值20

In the PVA97NK table, there are several numeric variables with fewer than 20 distinct values that should not be treated as nominal. Similarly, there is one class variable with more than 20 levels that should not be rejected.

将class levels count threshold的值修改为2，而reject levels count threshold的value修改为100，如下所示：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2027.png)

only character variables with more than 100 distinct values are rejected.

点击确定，然后再次查看结果：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2028.png)

可以发现：most of the metadata被正确的defined了。

SAS EM 通过名称正确推断了非输入变量的模型角色。使用 Advanced Metadata Advisor 正确定义了测量级别。

在上述的表格中，有着两个目标变量：

1. TargetB
2. TargetD

如果需要专注于TargetB，那么可以将TargetD拒绝掉：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2029.png)

总之，定义列元数据部分通常是数据源向导步骤中最耗时的部分。

**Part 3: Finalizing the Data Source Specification**

由于存在分类（二元、有序或名义）目标变量，数据源向导获得了额外的步骤。

定义预测建模数据集时，正确配置决策处理非常重要。 事实上，获得有意义的模型通常需要使用这些选项。PVA97NK 表的结构可以在不指定决策处理的情况下生成合理的模型。

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2030.png)

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2031.png)

在下一步中：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2032.png)

原始，raw，是可以被接受的。

选择Next，数据源向导中的最后一步提供有关您创建的数据表的摘要详细信息：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2033.png)

得到如下所示的结果：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2034.png)

## 创建一个 process flow diagram

点击PVA97NK，拖动到右边：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2035.png)

这样创建了一个Input Data node，在Diagram Workspace中。

右键这个node，选择 Edit Variable：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2036.png)

将Label，Mining和Statistic三个旁边的方框都选上：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2037.png)

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2038.png)

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2039.png)

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2040.png)

将所有的role为input的rows都选择上：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2041.png)

接着按一下A键，可以发现下面的：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2042.png)

从灰点亮了。

如果不亮，可以采用这样的两个办法来进行尝试：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2043.png)

接着点击Explore：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2044.png)

通过点击框可以放大查看：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2045.png)

## 链接和运行一个reporter node来创建一个report

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2046.png)

点击拖拽下来：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2047.png)

接着将其链接在一起：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2048.png)

右键Reporter，然后选择Run：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2049.png)

在这个样例中，可以直接选择OK。

接着点击一下Reporter Node：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2050.png)

往下拉，然后得到这样的一个结果：

![Untitled](Week_02%20Practical#01%202965b27e7c0b4249ad9d6a63a7a51dbe/Untitled%2051.png)

点击红色框出来的三个点就可以了。

将PDF保存和上交就结束了。