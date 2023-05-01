--- Desafio DIO, Personalizando acessos com views.


--- Criando View para o número de empregados por departamento e localidade
CREATE VIEW num_empregados_dep_loc AS
SELECT d.department_name, d.location_id, COUNT(*) AS num_empregados
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name, d.location_id;

--- Criando View para lista de departamentos e seus gerentes
CREATE VIEW lista_dept_gerentes AS
SELECT d.department_name, m.first_name, m.last_name
FROM departments d
JOIN employees m ON d.manager_id = m.employee_id;

--- Criando View para projetos com maior número de empregados
CREATE VIEW projetos_maior_num_empregados AS
SELECT p.project_id, p.project_name, COUNT(*) AS num_empregados
FROM employees e
JOIN employees_projects ep ON e.employee_id = ep.employee_id
JOIN projects p ON ep.project_id = p.project_id
GROUP BY p.project_id, p.project_name
ORDER BY num_empregados DESC;

--- Criando View para lista de projetos, departamentos e gerentes
CREATE VIEW lista_projetos_dept_gerentes AS
SELECT p.project_name, d.department_name, m.first_name, m.last_name
FROM projects p
JOIN departments d ON p.department_id = d.department_id
JOIN employees m ON d.manager_id = m.employee_id;

--- Criando View para empregados com dependentes e se são gerentes
CREATE VIEW empregados_dependentes_gerentes AS
SELECT e.employee_id, e.first_name, e.last_name,
(CASE WHEN e.job_title LIKE '%Manager%' THEN 'Sim' ELSE 'Não' END) AS gerente,
(CASE WHEN d.dependent_id IS NULL THEN 'Não' ELSE 'Sim' END) AS possui_dependentes
FROM employees e
LEFT JOIN dependents d ON e.employee_id = d.employee_id;

--- Criando usuário gerente e concedendo permissões para views de employee e department
CREATE USER 'gerente'@'localhost' IDENTIFIED BY 'senha';
GRANT SELECT ON employees TO 'gerente'@'localhost';
GRANT SELECT ON departments TO 'gerente'@'localhost';

--- Criando gatilho before delete para usuários
CREATE TRIGGER before_remove_usuario
BEFORE DELETE ON usuarios
FOR EACH ROW
BEGIN
INSERT INTO usuarios_deletados
VALUES (OLD.usuario_id, OLD.nome, OLD.email, NOW());
END;

--- Criando gatilho before update para inserção de novos colaboradores e atualização do salário base
CREATE TRIGGER before_update_colaborador
BEFORE INSERT OR UPDATE ON employees
FOR EACH ROW
BEGIN
IF NEW.salary < OLD.salary THEN
INSERT INTO log_salario (employee_id, old_salary, new_salary, date)
VALUES (NEW.employee_id, OLD.salary, NEW.salary, NOW());
END IF;
END;