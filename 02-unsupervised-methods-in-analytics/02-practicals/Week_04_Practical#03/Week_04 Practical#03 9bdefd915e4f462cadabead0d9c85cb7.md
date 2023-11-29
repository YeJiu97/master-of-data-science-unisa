# Week_04:Practical#03

## Resources

[Prac#3-ClusterAnaysis-SAS-1.pdf](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Prac3-ClusterAnaysis-SAS-1.pdf)

## Practical

首先创建一个New Project，将其命名为 prac#3。

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled.png)

接着在Diagram创建一个new diagram，名为myPrac3：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%201.png)

接着开始创建data source：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%202.png)

接着使用数据集：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%203.png)

使用Basic即可：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%204.png)

接着选择：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%205.png)

得到如下所示的结果：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%206.png)

将所有类型为t的变量都选择出来，然后进行Explore：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%207.png)

首先查看一下MeanHHSz：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%208.png)

默认的情况之下bin的数量是10，可以增加这个bin的数量：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%209.png)

从10改成100：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2010.png)

得到如下所示的结果：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2011.png)

可以发现，直方图在接近0处有一个奇怪的尖峰，在人口普查数据的背景下，零家庭规模没有意义。

缩放回来：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2012.png)

零平均家庭规模（由对角线模式表示）似乎均匀分布在经度、纬度和密度百分位数变量上。 它似乎集中在低收入和人口上，并且也弥补了 Reion Density 分布中缺失的大部分观察结果。 探索样本的个别记录值得一看。

接着我们来查看一下这个windows：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2013.png)

找到这两个数据：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2014.png)

可以发现这两个数据的region population和median household income都是0和$0。

或者我们可以点击一下region population:

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2015.png)

点击一下Average Household Size：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2016.png)

不断的往下拉可以发现，直到这一行之上：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2017.png)

基本上Average Household Size为0数据的其他非Region数据要么为0要么missing。

所以接下来要做的事情就是想办法删除这些数据。

首先：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2018.png)

默认情况之下：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2019.png)

采用的方法是standard deviation from the mean，但是因为CENSUS2000只有interval，所以这里仅考虑区间变量部分中的标准。

这里选择：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2020.png)

接着：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2021.png)

可以发现SAS EM会提醒你“Train or raw data set does not exist”。

将MeanHHSz的Filter Lower Limit的值修改为0.1：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2022.png)

然后选择ok，这样，所有平均家庭人数小于0.1的个案将会从后续的分析步骤中被过滤掉。

开始run：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2023.png)

得到一个如下所示的result：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2024.png)

往下拉找到第1081行，可以发现：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2025.png)

一共有1081个数据被排除了。

可以关闭这个result了，CENSUS2000数据已经被准备好进行segmentation了。

通常来讲，聚类采用K-means cluster analyses：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2026.png)

要创建有意义的集群，您需要将集群节点设置为执行以下操作：
• 忽略不相关的输入
• 标准化输入以具有相似的范围

在cluster的property中选择：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2027.png)

对一些属性来进行修改：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2028.png)

Cluster 节点使用输入 MedHHInc、MeanHHSz 和 RegDens 创建分段。 请注意，变量 ID 未如前所述使用。 分段是根据所选输入空间中每个案例之间的（欧几里得）距离创建的。 如果您想使用所有输入来创建集群，这些输入应该具有相似的测量尺度。

使用标准化距离测量值（减去输入值的平均值并除以标准差）计算距离是确保这一点的一种方法。 您可以使用变换变量节点标准化输入测量值。 但是，使用 Cluster 节点中的内置属性更容易。

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2029.png)

得到的结果为：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2030.png)

选择用于集群的输入在三个完全不同的测量尺度上。 如果您想要有意义的聚类，则需要对它们进行标准化。

这里应该将其选择为Standardisation：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2031.png)

默认情况下，聚类工具会尝试自动确定数据中的聚类数。 使用三步过程。

1. 选择大量的簇种子（默认为 50 个）并放置在输入空间中。 数据集中的案例被分配给最近的种子，并完成了数据的初始聚类。 在该过程的第二步中，每个初步聚类中的输入变量均值被替换为原始数据案例。
2. 层次聚类算法（默认为 Ward 方法）用于顺序合并第一步中形成的聚类。 在合并的每个步骤中，都会计算一个名为立方聚类标准 (CCC) 的统计数据。 然后，选择满足以下两个条件的最小数量的簇：
    1. 聚类数必须大于或等于在选择标准属性中指定为最小值的数。
    2. 聚类数必须具有大于选择标准属性中指定的 CCC 阈值的立方聚类标准统计值。
3. 第二步确定的聚类数提供了原始数据个案的 kmeans 聚类中的 k 值。

运行cluster node，然后选择result：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2032.png)

The Results - Cluster window contains four embedded windows.
• The Segment Plot window attempts to show the distribution of each input variable by cluster.
• The Mean Statistics window lists various descriptive statistics by cluster.
• The Segment Size window shows a pie chart describing the size of each cluster formed.
• The Output window shows the output of various SAS procedures run by the Cluster node.

检查并尝试理解四个嵌入式窗口中每个窗口中的信息。 使用群集节点的帮助参考可以帮助您了解和理解这些窗口中显示的结果。 请注意，均值统计包含一些有助于比较不同聚类结果质量的信息，例如 均方根标准差（表示聚类的紧密度）和到最近聚类的距离（表示聚类是否分离良好）。

接着选择view —— Summary Statistics：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2033.png)

得到一个CCCplot结果：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2034.png)

理论上，数据集中的簇数由 CCC 与簇数图的峰值揭示。 然而，当不存在明显的集中数据时，CCC 统计量的效用就有些可疑了。 SAS Enterprise Miner 试图为其分析工具建立合理的默认值。 然而，这些默认值的适当性在很大程度上取决于分析目标和数据的性质。

自己指定簇号。您可能希望增加集群节点创建的集群数量。 您可以通过自己指定所需的簇数来执行此操作。

首先修改Cluster Node的Properties：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2035.png)

这里为10，接着重复之前的操作，得到的结果为：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2036.png)

可以从Mean Statistics window看出来变化。

配置clusters

首先：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2037.png)

然后修改variable的属性：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2038.png)

接着run一下segment profile：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2039.png)

然后得到的结果为：

![Untitled](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Untitled%2040.png)

然后运行report node：

[Wangjun#prac#03.pdf](Week_04%20Practical#03%209bdefd915e4f462cadabead0d9c85cb7/Wangjunprac03.pdf)