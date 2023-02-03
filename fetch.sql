/* Which brand saw the most dollars spent in the month of June? */
Select brand From 
(Select brand, total, rank()over(Order by total Desc) as rk From
(Select brands.BRAND_CODE as brand, sum(TOTAL_FINAL_PRICE)as total From brands Inner Join receipt_items On brands.BRAND_CODE = receipt_items.BRAND_CODE Where month(receipt_items.MODIFY_DATE) = 6 Group By brands.BRAND_CODE) a
)b Where rk = 1;
/* Which user spent the most money in the month of August? */
/*Hint: there is a case when several customers spent the most money */
Select USER_ID From
(Select USER_ID, total, rank()over(Order by total Desc) as rk From
(Select USER_ID, sum(TOTAL_SPENT) as total From receipts Where month(PURCHASE_DATE) = 8 Group By USER_ID Order By total) a
)b Where rk = 1;

/*What user bought the most expensive item?*/

Select USER_ID From
(Select USER_ID, rank()over(Order by single_price Desc) as rk From
(Select TOTAL_FINAL_PRICE/QUANTITY_PURCHASED as single_price, REWARDS_RECEIPT_ID From receipt_items) a Inner Join
receipts On a.REWARDS_RECEIPT_ID = receipts.ID) b
Where rk = 1;

/*What is the name of the most expensive item purchased?*/
Select ORIGINAL_RECEIPT_ITEM_TEXT From
(Select ORIGINAL_RECEIPT_ITEM_TEXT, rank()over(Order by single_price Desc) as rk From
(Select TOTAL_FINAL_PRICE/QUANTITY_PURCHASED as single_price, ORIGINAL_RECEIPT_ITEM_TEXT From receipt_items) a)b
 Where rk = 1;
 



