select * from bank_info;

--Total de aplica��es
select distinct (count(id)) as Total_aplica��es from bank_info;

-- Total de aplica��es mensais
select distinct (count(id)) as Total_aplica��es_mensais from bank_info
where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021;

-- Total de aplica��es mensais
select distinct (count(id)) as Total_aplica��es_mensais from bank_info
where MONTH(issue_date) = 11 and YEAR(issue_date) = 2021;
--------------------------------------------------------------------------
--Total valor financiado
select sum(loan_amount) as valor_emprestimo from bank_info;

--Valor total de pagamento
select sum(total_payment) as total_pagamento from bank_info;

--Total de valor de aplica��es
select sum(loan_amount) as valor_total_emprestimo  from bank_info
where month(issue_date) = 11 and YEAR(issue_date) = 2021

--Total de emprestimo recebido
select sum(total_payment) as total_emprestimo_recebido from bank_info
where month(issue_date) = 11 and YEAR(issue_date) = 2021

select avg(int_rate)/100 from bank_info

--M�dia da taxa de juros no m�s
select round(avg(int_rate),0)/100 as media_taxa_juros from bank_info
where month(issue_date) = 11 and YEAR(issue_date) = 2021;

--rela��o d�vida/renda
select round(avg(dti),0)/100 as m�dia_rela��o_d�vida_renda from bank_info
where month(issue_date) = 12 and YEAR(issue_date) = 2021;

--Valor dos empr�stimos mensais
select
	year(issue_date) as ano,
	datename(month, issue_date) as nome_m�s,
	sum(loan_amount) as valor_total_emprestimo
from 
	bank_info
group by
	year(issue_date), 
	datename(month, issue_date)
order by
	ano, nome_m�s;

--Valor dos pagamentos mensais
select
	month(issue_date) as m�s,
	datename(month, issue_date) as nome_m�s,
	sum(total_payment) as valor_total_emprestimo
from 
	bank_info
group by
	month(issue_date), 
	datename(month, issue_date)
order by
	m�s, nome_m�s;

--M�dia da taxa de juros mensal
select
	month(issue_date) as m�s,
	datename(month, issue_date) as nome_m�s,
	round(avg(int_rate),0)/100 as media_taxa_juros
from 
	bank_info
group by
	month(issue_date), 
	datename(month, issue_date)
order by
	m�s, nome_m�s;

--rela��o d�vida/renda
select
	month(issue_date) as m�s,
	round(avg(dti),0)/100 as m�dia_rela��o_d�vida_renda
from 
	bank_info
group by
	month(issue_date)
order by
	m�s;


--------------------------------------------------------------------------
--Porcentagem de empr�stimos

--Bons empr�stimos
select count(id) as bom_empr�stimos  from bank_info
where loan_status = 'Fully Paind' or loan_status = 'Current'

--Valor do empr�stimos
select sum(loan_amount) as bom_empr�stimos  from bank_info
where loan_status = 'Fully Paind' or loan_status = 'Current'

--Total do empr�stimos recebidos
select sum(total_payment) as total_empr�stimos  from bank_info
where loan_status = 'Fully Paind' or loan_status = 'Current'

--Empr�stimos Ruins

select 
	(count(case when loan_status = 'Fully Paid' or loan_status ='Current' then id end)*100.0)
	/	
	count(id) as Porcentagem_emprestimo 
from bank_info;

--Porcentagem de empr�stimos
select 
	(count(case when loan_status = 'Charged off' then id end)*100.0)
	/	
	count(id) as Porcentagem_emprestimo_inadimplente 
from bank_info;

--Empr�stimos n�o pagos
select count(id) as imprestimos_n�o_pagos  from bank_info
where loan_status = 'Charged off' 

--Valor do empr�stimo
select sum(loan_amount) from bank_info
where loan_status = 'Charged off'

--Total de pagamentos
select sum(total_payment) as imprestimos_n�o_pagos  from bank_info
where loan_status = 'Charged off'
----------------------------------------------------------------------
--Estado dos empr�stimos
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

--Estado do empr�stimo no m�s
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

--Empr�stimo por m�s
select
	month(issue_date) as m�s,
	datename(month, issue_date) as nome_m�s,
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

--Empr�stimo por estado
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

--Empr�stimos por prazo de pagamento
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

--Estado do empr�stimo por ano de trabalho de funcion�rios
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

--Prop�sito do empr�stimo
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

--Empr�stimo por tipo de im�vel
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

--Prop�sito dos empr�stimos
select 
	purpose as Prop�sito,
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


