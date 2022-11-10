clear;clc
 load data1.mat 
[n,p] = size(x);  % n������������p��ָ�����
X=zscore(x);   % ������x��׼��ΪX
R = cov(X);    % ��������Э�������
disp('�������ϵ������Ϊ��')
disp(R)

[V,D] = eig(R);  % V ������������  D ����ֵ���ɵĶԽǾ���

lambda = diag(D);  % diag�������ڵõ�һ����������Խ���Ԫ��ֵ(���ص���������)
lambda = lambda(end:-1:1);  % lambda�����Ǵ�С������ģ��������ͷ
contribution_rate = lambda / sum(lambda);  % ���㹱����
cum_contribution_rate = cumsum(lambda)/ sum(lambda);   % �����ۼƹ�����  cumsum�����ۼ�ֵ�ĺ���
disp('����ֵΪ��')
disp(lambda') 
disp('������Ϊ��')
disp(contribution_rate')
disp('�ۼƹ�����Ϊ��')
disp(cum_contribution_rate')
disp('������ֵ��Ӧ��������������Ϊ��')
V=rot90(V)';
disp(V)

m =input('��������Ҫ��������ɷֵĸ���:  ');
F = zeros(n,m);  %��ʼ���������ɷֵľ���ÿһ����һ�����ɷ֣�
for i = 1:m
    ai = V(:,i)';   
    Ai = repmat(ai,n,1);   
    F(:, i) = sum(Ai .* X, 2);  
end