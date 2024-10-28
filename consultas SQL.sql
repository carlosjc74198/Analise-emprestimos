select * from bank_info;

--Total de aplicações
select distinct (count(id)) as Total_aplicações from bank_info;

-- Total de aplicações mensais
select distinct (count(id)) as Total_aplicações_mensais from bank_info
where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021;

-- Total de aplicações mensais
select distinct (count(id)) as Total_aplicações_mensais from bank_info
where MONTH(issue_date) = 11 and YEAR(issue_date) = 2021;
--------------------------------------------------------------------------
--Total valor financiado
select sum(loan_amount) as valor_emprestimo from bank_info;

--Valor total de pagamento
select sum(total_payment) as total_pagamento from bank_info;

--Total de valor de aplicações
select sum(loan_amount) as valor_total_emprestimo  from bank_info
where month(issue_date) = 11 and YEAR(issue_date) = 2021

--Total de emprestimo recebido
select sum(total_payment) as total_emprestimo_recebido from bank_info
where month(issue_date) = 11 and YEAR(issue_date) = 2021

select avg(int_rate)/100 from bank_info

--Média da taxa de juros no mês
select round(avg(int_rate),0)/100 as media_taxa_juros from bank_info
where month(issue_date) = 11 and YEAR(issue_date) = 2021;

--relação dívida/renda
select round(avg(dti),0)/100 as média_relação_dívida_renda from bank_info
where month(issue_date) = 12 and YEAR(issue_date) = 2021;

--Valor dos empréstimos mensais
select
	year(issue_date) as ano,
	datename(month, issue_date) as nome_mês,
	sum(loan_amount) as valor_total_emprestimo
from 
	bank_info
group by
	year(issue_date), 
	datename(month, issue_date)
order by
	ano, nome_mês;

--Valor dos pagamentos mensais
select
	month(issue_date) as mês,
	datename(month, issue_date) as nome_mês,
	sum(total_payment) as valor_total_emprestimo
from 
	bank_info
group by
	month(issue_date), 
	datename(month, issue_date)
order by
	mês, nome_mês;

--Média da taxa de juros mensal
select
	month(issue_date) as mês,
	datename(month, issue_date) as nome_mês,
	round(avg(int_rate),0)/100 as media_taxa_juros
from 
	bank_info
group by
	month(issue_date), 
	datename(month, issue_date)
order by
	mês, nome_mês;

--relação dívida/renda
select
	month(issue_date) as mês,
	round(avg(dti),0)/100 as média_relação_dívida_renda
from 
	bank_info
group by
	month(issue_date)
order by
	mês;


--------------------------------------------------------------------------
--Porcentagem de empréstimos

--Bons empréstimos
select count(id) as bom_empréstimos  from bank_info
where loan_status = 'Fully Paind' or loan_status = 'Current'

--Valor do empréstimos
select sum(loan_amount) as bom_empréstimos  from bank_info
where loan_status = 'Fully Paind' or loan_status = 'Current'

--Total do empréstimos recebidos
select sum(total_payment) as total_empréstimos  from bank_info
where loan_status = 'Fully Paind' or loan_status = 'Current'

--Empréstimos Ruins

select 
	(count(case when loan_status = 'Fully Paid' or loan_status ='Current' then id end)*100.0)
	/	
	count(id) as Porcentagem_emprestimo 
from bank_info;

--Porcentagem de empréstimos
select 
	(count(case when loan_status = 'Charged off' then id end)*100.0)
	/	
	count(id) as Porcentagem_emprestimo_inadimplente 
from bank_info;

--Empréstimos não pagos
select count(id) as imprestimos_não_pagos  from bank_info
where loan_status = 'Charged off' 

--Valor do empréstimo
select sum(loan_amount) from bank_info
where loan_status = 'Charged off'

--Total de pagamentos
select sum(total_payment) as imprestimos_não_pagos  from bank_info
where loan_status = 'Charged off'
----------------------------------------------------------------------
--Estado dos empréstimos
select
	loan_status,
	count(id) as contagem_emprestimo,
	sum(total_payment) as total_valor_recebido,
	sum(loan_amount) as valor_financiado,
	avg(int_rate * 100) as taxa_juros,
	avg(dti * 100) divida_renda
from 
	bank_info
group by 
	loan_status

--Estado do empréstimo no mês
select
	loan_status,
	sum(total_payment) as total_valor_recebido,
	sum(loan_amount) as valor_financiado
from 
	bank_info
where
	month(issue_date) = 12
group by 
	loan_status

--Empréstimo por mês
select
	month(issue_date) as mês,
	datename(month, issue_date) as nome_mês,
	count(id) as contagem_emprestimo,
	sum(total_payment) as total_valor_recebido,
	sum(loan_amount) as valor_financiado
from 
	bank_info
group by
	month(issue_date),
	datename(MONTH, issue_date)
order by
	datename(MONTH, issue_date)

--Empréstimo por estado
select
	address_state as Estado,
	count(id) as contagem_emprestimo,
	sum(total_payment) as total_valor_recebido,
	sum(loan_amount) as valor_financiado
from 
	bank_info
group by
	address_state
order by
	sum(loan_amount) desc

--Empréstimos por prazo de pagamento
select
	term as Prazo,
	count(id) as contagem_emprestimo,
	sum(total_payment) as total_valor_recebido,
	sum(loan_amount) as valor_financiado
from 
	bank_info
group by
	term
order by
	term

--Estado do empréstimo por ano de trabalho de funcionários
select
	emp_length as ano_funcionarios,
	count(id) as contagem_emprestimo,
	sum(total_payment) as total_valor_recebido,
	sum(loan_amount) as valor_financiado
from 
	bank_info
group by
	emp_length
order by
	count(id) desc

--Propósito do empréstimo
select
	purpose as proprosito_emprestimo,
	count(id) as contagem_emprestimo,
	sum(total_payment) as total_valor_recebido,
	sum(loan_amount) as valor_financiado
from 
	bank_info
group by
	purpose
order by
	count(id) desc

--Empréstimo por tipo de imóvel
select
	home_ownership as tipo_imovel,
	count(id) as contagem_emprestimo,
	sum(total_payment) as total_valor_recebido,
	sum(loan_amount) as valor_financiado
from 
	bank_info
group by
	home_ownership
order by
	count(id) desc

--Propósito dos empréstimos
select 
	purpose as Propósito,
	count(id) as contagem_emprestimo,
	sum(loan_amount) as valor_financiado,
	sum(total_payment) as total_valor_recebido
from 
	bank_info
where 
	grade = 'A'
group by
	purpose
order by 
	purpose


