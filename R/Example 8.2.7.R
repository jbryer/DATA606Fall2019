# OpenIntro 4th edition, Example 8.2.7, page 322-323 

library(openintro)
library(ggplot2)

data("elmhurst")
head(elmhurst)

ggplot(elmhurst, aes(x = family_income, y = gift_aid)) +
	geom_point() + geom_smooth(method = 'lm', se = FALSE)

lm.out <- lm(gift_aid ~ family_income, data = elmhurst)
summary(lm.out)

var(elmhurst$gift_aid) # s^2 for aid (i.e. variance of the dependent variable)
var(resid(lm.out)) # s^2 for the residuals (i.e. variance of the residuals)

# R-squared
(var(elmhurst$gift_aid) - var(resid(lm.out))) / var(elmhurst$gift_aid) 

# Let's  highlight one point
row <- which(min(elmhurst$family_income) == elmhurst$family_income)
elmhurst[row,]
predict(lm.out, newdata = elmhurst[row,]) # The predicted value for this data point

ggplot(elmhurst, aes(x = family_income, y = gift_aid)) +
	geom_hline(yintercept = mean(elmhurst$gift_aid), color = 'red') +
	geom_point() + 
	geom_smooth(method = 'lm', se = FALSE) +
	geom_segment(x = elmhurst[row,]$family_income,
				 y = elmhurst[row,]$gift_aid,
				 xend = elmhurst[row,]$family_income,
				 yend = predict(lm.out, newdata = elmhurst[row,]),
				 color = 'red') +
	geom_segment(x = elmhurst[row,]$family_income,
				 y = mean(elmhurst$gift_aid),
				 xend = elmhurst[row,]$family_income,
				 yend = predict(lm.out, newdata = elmhurst[row,]),
				 color = 'blue') +
	geom_point(data = elmhurst[row,], color = 'magenta', size = 3) +
	geom_text(x = elmhurst[row,]$family_income,
			  y = (elmhurst[row,]$gift_aid + predict(lm.out, newdata = elmhurst[row,])) / 2,
			  label = 'Unexplained (i.e. error) Variance', hjust = -0.1, color = 'red') +
	geom_text(x = elmhurst[row,]$family_income,
			  y = (mean(elmhurst$gift_aid) + predict(lm.out, newdata = elmhurst[row,])) / 2,
			  label = 'Explained Variance', hjust = -0.1, color = 'blue')

	

