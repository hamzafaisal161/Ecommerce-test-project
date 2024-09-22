# Ecommerce V2
- Rails Test Project
---
_**EcommerceV2**_ is a an online ecommerce platform for a shopping platform to facilitate online shopping.
### Users
A Guest can
* View all the Products
* Add Products to the Cart
* Remove or Change Quantity of the Products in the Cart
* Sign Up or Log in
* Search for Products by their name

A User can
* View all the Products
* He can create his own Products
* Add Products to the Cart
* He cannot add his own Product in the Cart
* Remove or Change Quantity of the Product in the Cart
* He can Comment on Products
* He cannot Comment on his Product
* He can Edit and Delete his Comments
* He can Add Products in his Wishlist
* He can Edit his Wishlist
* Checkout the Cart for the Order
* Search for Products by their name
* New Users can redeem 5% bonus on its first order
* A User can view his Orders Summary

A Product
* Will have a Name, Price, and Description with it
* It can have multiple images

A Comment
* Will have a decription
* It can have multiple images attached to it





## Technology Stack
---
![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white) ![Rails](https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white) ![HTML5](https://img.shields.io/badge/html5-%23E34F26.svg?style=for-the-badge&logo=html5&logoColor=white) ![Bootsrap](https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white)

## Gems used
---
| activemerchant | haml | jquery-rails
| money-rails | multi_json | nifty-generators
| paypal-sdk-rest | pundit | rails3-jquery-autocomplete
| ransack| rubocop-rails | cloudinary
| devise | image_processing | jdbc-mysql
| mysql2
## Environment Setup
---
| Tools/Technologies      | Description |
| :---        |:----   |
| Ruby   | Version 2.7.2        |
| Rails   | Version 5.2.8       |
| Postgres   | Version 14.2        |
## Local Machine Setup
---
Open Termnal and type
``` sh
git clone https://github.com/hamzafaisall/ecommerce_test_project
```
Then
```sh
cd ecommerce
```
Install Gems
``` sh
bundle
```
Run DB Build
```
rails db:create
```
Run Server
```
rails s
```
