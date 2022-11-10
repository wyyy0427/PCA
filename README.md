# PCA
主成分分析法
主成分分析是一种降维算法，它能将多个指标转换为少数几个主成分，这些主成分是原始变量的线性组合，且彼此之间互不相关，其能反映出原始数据的大部分信息。一般来说，
当研究的问题涉及到多变量且变量之间存在很强的相关性时，我们可考虑使用主成分分析的方法来对数据进行简化。

计算步骤：
1.对矩阵进行标准化处理
2、计算标准化矩阵的协方差R，及其特征值，特征向量
3、求贡献率和累计贡献率（通常前i个主成分累计贡献率超过85%，就取前i个主成分）
4、计算n个样本的主成分得分

代码讲解：
clear;clc
 load data1.mat 
[n,p] = size(x);  % n是样本个数，p是指标个数
X=zscore(x);   % 对数据x标准化为X
R = cov(X);    % 计算样本协方差矩阵
disp('样本相关系数矩阵为：')
disp(R)

[V,D] = eig(R);  % V 特征向量矩阵  D 特征值构成的对角矩阵

lambda = diag(D);  % diag函数用于得到一个矩阵的主对角线元素值(返回的是列向量)
lambda = lambda(end:-1:1);  % lambda向量是从小大到排序的，将其调个头
contribution_rate = lambda / sum(lambda);  % 计算贡献率
cum_contribution_rate = cumsum(lambda)/ sum(lambda);   % 计算累计贡献率  cumsum是求累加值的函数
disp('特征值为：')
disp(lambda') 
disp('贡献率为：')
disp(contribution_rate')
disp('累计贡献率为：')
disp(cum_contribution_rate')
disp('与特征值对应的特征向量矩阵为：')
V=rot90(V)';
disp(V)  

m =input('请输入需要保存的主成分的个数:  ');
F = zeros(n,m);  %初始化保存主成分的矩阵（每一列是一个主成分）
for i = 1:m
    ai = V(:,i)';   
    Ai = repmat(ai,n,1);   
    F(:, i) = sum(Ai .* X, 2);  % 对标准化的数据求了权重后要计算每一行的和
end
