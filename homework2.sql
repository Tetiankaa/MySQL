use tanya;

/* 1.Вибрати усіх клієнтів, чиє ім'я має менше ніж 6 символів. */

select * from client where length(FirstName)<6;

/* 2.Вибрати львівські відділення банку. */
select * from department where DepartmentCity='lviv';

/* 3.Вибрати клієнтів з вищою освітою та посортувати по прізвищу. */
select * from client where Education='high' order by FirstName;

/* 4.Виконати сортування у зворотньому порядку над таблицею Заявка і вивести 5 останніх елементів. */
select * from application order by idApplication desc limit 5;

/* 5.Вивести усіх клієнтів, чиє прізвище закінчується на OV чи OVA. */
select * from client where LastName like '%ov' or '%ova';

/* 6.Вивести клієнтів банку, які обслуговуються київськими відділеннями. */
select client.idClient,FirstName,LastName,DepartmentCity from client inner join tanya.department d on client.Department_idDepartment = d.idDepartment where DepartmentCity='Kyiv';

/* 7.Знайти унікальні імена клієнтів. */
select distinct FirstName from client;

/* 8.Вивести дані про клієнтів, які мають кредит більше ніж на 5000 гривень. */

select * from client join tanya.application a on client.idClient = a.Client_idClient where CreditState='not returned' and Sum>5000 and Currency='gryvnia';

/* ?????????? 9.Порахувати кількість клієнтів усіх відділень та лише львівських відділень. */

# select count(*),DepartmentCity from client join tanya.department d on d.idDepartment = client.Department_idDepartment where DepartmentCity='lviv' group by DepartmentCity
# union
# select * from client;

/* 10.Знайти кредити, які мають найбільшу суму для кожного клієнта окремо. */

select sum(Sum),client.*  from client right join tanya.application a on client.idClient = a.Client_idClient where CreditState='not returned' group by Client_idClient order by sum(Sum) desc ;

/* 11. Визначити кількість заявок на крдеит для кожного клієнта. */

select count(CreditState) as amount_of_creadits,client.* from client join tanya.application a on client.idClient = a.Client_idClient group by Client_idClient;

/* 12. Визначити найбільший та найменший кредити. */

select max(Sum) from application
union
select min(Sum) from application;

/* 13. Порахувати кількість кредитів для клієнтів,які мають вищу освіту. */

select count(Sum) from client join tanya.application a on client.idClient = a.Client_idClient where Education='high';

/* 14. Вивести дані про клієнта, в якого середня сума кредитів найвища. */