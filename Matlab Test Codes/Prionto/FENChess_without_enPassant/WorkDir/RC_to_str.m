function [str1] = RC_to_str(rP,cP,rN,cN)

str1 = [];
rowPrev = cP + 97 - 1;
str1 = strcat(str1, char(rowPrev));
columnPrev = 8-rP+1;
str1 = strcat(str1, num2str(columnPrev));
rowNew = cN +97 -1;
str1 = strcat(str1, char(rowNew));
columnNew = 8-rN+1;
str1 = strcat(str1, num2str(columnNew));

end

