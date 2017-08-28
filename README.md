# InvoicePlane OpenCart Extension
> Author: Adskiremote
> Lead developer at Cortek Solutions

### Summary
This extension provides integration with InvoicePlane.
It requires you to include my API module for InvoicePlane.
Available here: https://github.com/adskiremote/InvoicePlane

### Requirements
- InvoicePlane API
- OpenCart VQmod

### Currently WIP - Stable version coming soon
- Send all OpenCart customers to InvoicePlane
- Sync OpenCart Products to InvoicePlane
- Sync of OpenCart Orders to InvoicePlane Payments and Invoices
- Auto and Manual add Customers, Orders, Payments and Products

### Setup
- Place files in upload directory into OpenCart.
- Check vqmod InvoicePlane extension is enabled
- Enable at OpenCart -> Extensions -> Modules -> InvoicePlane
- Enter your API Key and InvoicePlane server url

### Testing InvoicePlane REST API
You can test your InvoicePlane API using Postman.
> Download Postman test routes here: `https://drive.google.com/open?id=0B86bid2EVKrVQXN0Qm51dlE0Z3M`

API routes can be used to return all data from InvoicePlane or by ID.

````
Route: http://localhost/api/clients/clients/
Return: All clients

Route: http://localhost/api/clients/clients/id/1
Return: Client ID 1
````

