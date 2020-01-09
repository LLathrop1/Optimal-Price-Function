# Optimal-Price-Function
This is the code I used to find the Optimal Price for our Etsy shirt.  This function can be broken down and made to use however you need


## The theory of this code is based on using linear regression and Price Elasticity of Demand (PED).
The script provides a way to find out how you can get the most profit based on the prices you have sold your products.  In this example, we use data from our Etsy store to find out the average starting price to make the most profit.

***
## Steps
1. Extract data from Etsy.
2. Clean up the data
   - Removed some sales and outliers.  Outliers would be high shipping costs, larger orders, or larger discounts.
3. Run a regression model to get the coefficient of the data
   - Getting the coefficient will help predict the quantity based on the price point.
4. Build a new table with different price points.
   - We started at the price point with a profit of $2.00 above cost.  We will not accept anything that does not give us $2.00 in profit.
5. Get the *Predicted* quantity of demand based on these new price points.
   - We used the equation of the liner model to get the predicted quantity of the price.  
6. Get the total sales of the *Predicted* quantity.
   - Just take the sale price multiple the sale price and the *Predicted* quantity together.
7. Get the total cost of the *Predicted: quantity
   - Multiply the cost of goods and the *Predicted* quantity
8. Get the profit from the Total Cost and Total Sales
   - Subtract the Total Cost from the Total Sales
9. Review the profit with the highest number.  This is the optimal price to get the most profit.
   - This works best when you have a robust linear model that has a higher negative correlation.
***

### Review
The analysis is using basic economic principles.  This type of model building helps businesses find the best price to make the most profit.  Now there are other variables to take into consideration so it will not be 100% accurate.  But it can give you a good prediction.

### How you code use this
Understanding how to create this analysis is excellent, but how can you use it in your business?  Every easily, you can use this type of model to help get a closer pricing range on your products.  And you can use it to get a great idea on a starting price for a new product you may want to introduce.

Believe it or not, not many business owners, both small and medium, do not even think about these basic economic principles to conduct their business.  They usually got with the thought, "If I lower the price, I will sell more."
