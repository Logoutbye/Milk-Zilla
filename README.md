# milk_zilla

A Flutter project for FYP.

this is shop management system in which there are four kind of people who are supposed to use this app
1- Buyer/Customer
2- Seller/Shop Keeper/Vendor
3- Inspector/Milk Testor
4- Farmer/Milk Supplier


short flow of the app is :

        Buyer => Registration/Login =>  Select Shop => Select Items => confirm order => Track Order/cancel before Shop keeper Prepare.
       
        Seller => Registration => Get Approval by admin => order milk from Farm => milk test report approved by inspector => get the milk delivered by inspector => can sell the milk => get Order by customer (all details e.g delivery address,items etc) => Prepare => track the prepared order by the shop.

        Inspector=>  Registration => Get Approval by admin => test milk for shop => take it to shop 
                     Pick prepared order by any shop => get the customer details => deliver it.

        Farm =>  Registration => Get Approval by admin => Get the order Prepare it => Track it.



Farmer:- 
    1- Any farmer can register him self with milk zilla but he can offer milk to farm once his is approved by admin(firebase=> Farmers => id => status = Approved)
    2- if Farmer gets approval, he can recieve orders from shops/vendor.
    3- Farmer will get only those order which were made aginst him.
    Then inpector will do rest of the job.

Inspector:- is Supposed  to do two things one is milk testing and the other is delivering it to shop/customer. 
    1- First of all, He needs to get approval after Registration as inpector from the app by admin. 
    2- after that Inspector will be able to Test the milk according to milk zilla check and balance and if the milk is good to use, he will update the milk report status and  will deliver it to shop keeper otherwise he can dissapproved the milk.
    3- Inspector can also get all the of Prepared(by shop) orders made by Customer against any shop.
    4- when he chooses to pick the order status will be changed to "Shippped", 
    5- he can see delivery address on google maps on reaching there he will update the the status to "Delivered"

Buyer:- 
    1- Buyer will register him self.
    2- After which he will get the list of the shops(Approved With Mikl Zilla) of his city.
    3- once the shop is selected buyer now can make an order(all the items at the shop are tested by inspector before taking them to shop from farm).
    4- when the order is made successfully, buyer can track the order/see the status(Pending/Prepared/Shipped/Delivered{
                            Canceled :only when customer changes his mind before order is prepared by shop.
                            })
Seller:- seller will buy the milk from farm and then sell it to customer 
    1- once he recieve the tested milk from farm he will offer it to customer along with milk test report 
    2- when customer make an order against the shop ,shop keeper will prepare it and update the stauts to "Prepared"
    3- if he is out of milk he will make order from Farm.
    4- He can track the order afterwards.


Note: 
    1-Status for Approving in the Fire store database should have only "Approved" or "Pending".
    2- there should be Collection 'Price List' 
    3- with the doc id 'items' 
    4- with the fileds{
        cow_milk         (number)
        buffalo_milk     (number)
        mix_milk         (number)
        yogurt           (number)
        desi_ghee        (number)
        butter           (number)
        delivery_charges (number)
    }
    5- Collection 'Price List'
    6- doc id 'containers'
    7-with fileds{
        '1 liter'
        '500 ml'
        '250 ml'
        'delivery_charges'
    }



## Getting Started