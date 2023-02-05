-- Question 1: Total sales $
Select sum(il."UnitPrice" * il."Quantity") as Sales from "InvoiceLine" il;

--Question 2: Total sales $ by country – ranked (or at least sorted largest to smallest)
Select invo."BillingCountry" as Country, sum( involi."Quantity" * involi."UnitPrice" ) as SalesByCountry
from "InvoiceLine" involi 
join "Invoice" invo on invo."InvoiceId" = involi."InvoiceId" 
group by invo."BillingCountry" 
order by SalesByCountry desc;

--Question 3: Total sales $ by country, state & city
Select invo."BillingCountry" as Country,
case when invo."BillingState" is null then invo."BillingCity"
else invo."BillingState" end State
, invo."BillingCity" City,
sum( involi."Quantity" * involi."UnitPrice") SalesByCountryStateCity
from "InvoiceLine" involi join
"Invoice" invo on invo."InvoiceId" = involi."InvoiceId" 
group by invo."BillingCountry",
case
    when invo."BillingState" is null then invo."BillingCity" 
    else invo."BillingState" end
, invo."BillingCity"
order by State,SalesByCountryStateCity desc;

--Question 4: Total sales $ by customer (a person with last name & first name) – ranked (or at least sorted largest to smallest)

Select concat(cust."LastName" , cust."FirstName") as FullName, sum(involi."Quantity" * involi."UnitPrice") as SalesByCustomer
from "InvoiceLine" involi join "Invoice" invo
on involi."InvoiceId" = invo."InvoiceId" 
join "Customer" cust
on cust."CustomerId" = invo."CustomerId"
group by concat(cust."LastName" , cust."FirstName")
order by sum(involi."Quantity" * involi."UnitPrice") desc;


--Question 5. Total sales $ by artist – ranked (or at least sorted largest to smallest)

Select art."Name" as ArtistName, sum(involi."Quantity" * involi."UnitPrice") as SalesByArtist
from "Artist" art join "Album" ab on art."ArtistId" = ab."ArtistId" 
join "Track" tr on tr."AlbumId" = ab."AlbumId" 
join "InvoiceLine" involi on involi."TrackId" = tr."TrackId" 
group by art."Name" 
order by SalesByArtist desc;

--Question 6. Total sales $ by albums

Select ab."Title"  as Album_Name,sum(involi."Quantity" * involi."UnitPrice") SalesByAlbum
from "Album" ab join "Track" tr on ab."AlbumId" = tr."AlbumId"
join "InvoiceLine" involi on involi."TrackId" = tr."TrackId"
group by ab."Title"  
order by SalesByAlbum desc;

--Question 7. Total sales $ by salesperson (employee)

Select concat(emp."LastName", emp."FirstName") as SalesPerson, sum(involi."Quantity" * involi."UnitPrice") SalesBySalesperson
from "Employee" emp join "Customer" cust on emp."EmployeeId" = cust."SupportRepId" 
join "Invoice" invo on invo."CustomerId"  = cust."CustomerId" 
join "InvoiceLine" involi on involi."InvoiceId"  = invo."InvoiceId" 
group by concat(emp."LastName", emp."FirstName")
order by SalesBySalesperson desc;


-- Question 8: Total tracks bought and total revenue $ by media type
Select mt."Name"  as MediaType, sum(involi."Quantity" * involi."UnitPrice") as Sales, SUM(involi."Quantity")  
from "MediaType" mt join "Track" t on mt."MediaTypeId" = t."MediaTypeId" join "InvoiceLine" involi on t."TrackId" = involi."TrackId" 
group by mt."Name", involi."Quantity" ;

--Question 9: Total sales $ by genre
Select gen."Name" as GenreName, SUM(involi."Quantity" * involi."UnitPrice") as SalesByGenre
from "Genre" gen 
join "Track" t on gen."GenreId" = t."GenreId" 
join "InvoiceLine" involi on t."TrackId" = involi."TrackId"
group by gen."Name";

--Question 10: Total sales $ by company
Select cus."Company" as Company_Name, sum(involi."Quantity" * involi."UnitPrice") SalesByCompany 
from "Customer" cus 
join "Invoice" invo on cus."CustomerId" = invo."CustomerId"
join "InvoiceLine" involi on involi."InvoiceId"  = invo."InvoiceId"
where cus."Company" is not null
group by cus."Company"  
order by SalesByCompany desc;














