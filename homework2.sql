use tanya;

/* 1.Вибрати усіх клієнтів, чиє ім'я має менше ніж 6 символів. */

select * from client where length(FirstName)<6;

/* 2.Вибрати львівські відділення банку. */
select * from department where DepartmentCity='lviv';

/* 3.Вибрати клієнтів з вищою освітою та посортувати по прізвищу. */
select * from client where Education='high' order by LastName;

/* 4.Виконати сортування у зворотньому порядку над таблицею Заявка і вивести 5 останніх елементів. */
select * from application order by idApplication desc limit 5;

/* 5.Вивести усіх клієнтів, чиє прізвище закінчується на OV чи OVA. */
select * from client where client.FirstName like '%ov' or '%ova';

/* 6.Вивести клієнтів банку, які обслуговуються київськими відділеннями. */
select client.idClient,FirstName,LastName,DepartmentCity from client join tanya.department d on client.Department_idDepartment = d.idDepartment
where DepartmentCity='Kyiv';

/* 7.Знайти унікальні імена клієнтів. */
select distinct FirstName from client;

/* 8.Вивести дані про клієнтів, які мають кредит більше ніж на 5000 гривень. */

select * from client join tanya.application a on client.idClient = a.Client_idClient where CreditState='not returned' and Sum>5000 and Currency='gryvnia';

/* 9.Порахувати кількість клієнтів усіх відділень та лише львівських відділень. */
select count(idClient),DepartmentCity from client join tanya.department d on d.idDepartment = client.Department_idDepartment where DepartmentCity='lviv';
select count(*) from client join tanya.department d on d.idDepartment = client.Department_idDepartment;
/*OR*/
select (select count(*) from client join tanya.department d on d.idDepartment = client.Department_idDepartment) as allCount,
       (select count(*) from client join tanya.department d2 on d2.idDepartment = client.Department_idDepartment where DepartmentCity='lviv') as lviv_count;

/* 10.Знайти кредити, які мають найбільшу суму для кожного клієнта окремо. */
select max(Sum),client.* from client join tanya.application a on client.idClient = a.Client_idClient group by Client_idClient;

/* 11. Визначити кількість заявок на крдеит для кожного клієнта. */

select count(CreditState) as amount_of_creadits,client.* from client join tanya.application a on client.idClient = a.Client_idClient group by Client_idClient;

/* 12. Визначити найбільший та найменший кредити. */

select max(Sum) from application
union
select min(Sum) from application;
/*OR*/
select min(Sum) as min,max(Sum) as max from application;

/* 13. Порахувати кількість кредитів для клієнтів,які мають вищу освіту. */
select count(*),client.* from client join tanya.application a on client.idClient = a.Client_idClient where Education='high' group by idClient;

/* 14. Вивести дані про клієнта, в якого середня сума кредитів найвища. */
select avg(Sum) as avg_credit_sum,client.* from client join tanya.application a on client.idClient = a.Client_idClient group by Client_idClient order by avg_credit_sum desc limit 1;

/* 15. Вивести відділення, яке видало в кредити найбільше грошей */

select sum(Sum) as sum,DepartmentCity from department join tanya.client c on department.idDepartment = c.Department_idDepartment join tanya.application a on c.idClient = a.Client_idClient
group by Department_idDepartment order by sum desc limit 1;

/* 16. Вивести відділення, яке видало найбільший кредит. */

select max(Sum) as max_loan,DepartmentCity from department join tanya.client c on department.idDepartment = c.Department_idDepartment join tanya.application a on c.idClient = a.Client_idClient
group by Department_idDepartment order by max_loan desc limit 1;

/* 17. Усім клієнтам, які мають вищу освіту, встановити усі їхні кредити у розмірі 6000 грн. */

update client join tanya.application a on client.idClient = a.Client_idClient
    set Sum=6000, Currency='Gryvnia' where Education='high';

/* 18. Усіх клієнтів київських відділень пересилити до Києва. */

update client join tanya.department d on d.idDepartment = client.Department_idDepartment
    set City='Kyiv' where DepartmentCity='Kyiv';

/* 19. Видалити усі кредити, які є повернені. */

delete from application where CreditState='returned';

/* 20. Видалити кредити клієнтів, в яких друга літера прізвища є голосною. */
select * from client where FirstName regexp '^.a|^.e|^.i|^.o|^.u';

delete from application where Client_idClient in (select idClient from client where FirstName regexp '^.a|^.e|^.i|^.o|^.u');
/* OR */

delete application from application join tanya.client c on c.idClient = application.Client_idClient
where LastName regexp '^.[aeiou].*';

/* 21.Знайти львівські відділення, які видали кредитів на загальну суму більше ніж 5000 */
select sum(Sum) as sum,DepartmentCity from client join tanya.application a on client.idClient = a.Client_idClient join tanya.department d on d.idDepartment = client.Department_idDepartment
where DepartmentCity='lviv' group by idDepartment having sum(Sum)>5000;

/* 22.Знайти клієнтів, які повністю погасили кредити на суму більше ніж 5000 */

select *,Sum from client join tanya.application a on client.idClient = a.Client_idClient
where CreditState='returned' and Sum>5000;

/* 23.Знайти максимальний неповернений кредит. */
select max(Sum) as max_not_returned from application where CreditState='not returned';
/* OR */
select * from application where CreditState='not returned' order by Sum desc limit 1;

/* 24.Знайти клієнта, сума кредиту якого найменша */

select min(Sum) as sum,concat(FirstName,' ',LastName) from client join tanya.application a on client.idClient = a.Client_idClient
group by Client_idClient order by sum limit 1;
/* OR */
select * from application join tanya.client c on c.idClient = application.Client_idClient
order by Sum limit 1;

/* 25.Знайти кредити, сума яких більша за середнє значення усіх кредитів */

select Sum from application where (select avg(Sum) from application)<application.Sum;
/* OR */
select * from application where Sum > (select avg(Sum) from application);

/* 26. Знайти клієнтів, які є з того самого міста, що і клієнт, який взяв найбільшу кількість кредитів */
select City from client join tanya.application a2 on client.idClient = a2.Client_idClient group by City order by count(a2.Sum) desc limit 1;

select * from client join tanya.application a on client.idClient = a.Client_idClient
where City = (select City from client join tanya.application a2 on client.idClient = a2.Client_idClient group by idClient order by count(*) desc limit 1);

/* 27. Місто клієнта з найбільшою кількістю кредитів */

select count(Sum),City from client join tanya.application a on client.idClient = a.Client_idClient group by City order by count(Sum) desc limit 1;
/* OR */
select City from client join tanya.application a on client.idClient = a.Client_idClient
group by idClient order by count(*) desc limit 1;