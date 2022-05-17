use sm;

select count(*) 
from items
order by ﻿MASTER_PRODUCT_ID, PRODUCT_ID, UPC;

select distinct p.﻿PRODUCT_ID, p.GMM_ID, p.GOOGLE_PAGE_URL
from product p join items i
on p.﻿PRODUCT_ID = i.PRODUCT_ID
where i.PROMO_ID_LIST like '%19919457%';

select count(*) 
from items
where not TODAY_PRICE < 20 and not TODAY_PRICE > 28;

 select count(*) from Items where 20 <= TODAY_PRICE AND TODAY_PRICE <=28;

select count(*) from items where TODAY_PRICE between 20 and 28;