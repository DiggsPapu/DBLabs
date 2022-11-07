create table student(
    carne int primary key,
    names varchar(100),
    surnames varchar(100)
)
create table curse(
    code int primary key,
    name varchar(20),
    actual_quota int,
    max_quota int
)
create table asignation(
    carne int references student(carne),
    code int references curse(code)
)
-- Admin level 1
create role admin_level1;
grant insert, update, select on asignation, curse, student to admin_level1;
revoke insert, update, select on asignation, curse, student from admin_level1;
create user sol with password 'Manager123';--los nombres de usuario quedan en minusculas, las contrasenias no
grant admin_level1 to DieggsPapu;
drop role admin_level1
drop user dieggspapu
-- Admin level 2
create role admin_level2;
grant insert on curse, student to admin_level2;
revoke insert on curse, student from admin_level2;
create user RaulAlbiol with password 'RaulSeleccion';
grant admin_level2 to RaulAlbiol;
-- Admin level 3
create role admin_level3;
grant select on asignation, curse, student to admin_level3;
grant insert on asignation to admin_level3;
revoke select on asignation, curse, student to admin_level3;
revoke insert on asignation to admin_level3;
create user Ulises2 with password 'Ulises2';
grant admin_level3 to Ulises2;
grant insert on student to admin_level3;
--  Trigger
CREATE FUNCTION VALIDACION_ASIGNACION()
RETURNS TRIGGER AS $$
DECLARE
	total_asignaciones INT;
    max_asignaciones int;
BEGIN
	SELECT actual_quota  FROM curse WHERE code = NEW.code INTO total_asignaciones;
    SELECT max_quota from curse where code = new.code into max_asignaciones;
	IF (total_asignaciones >=max_asignaciones) THEN
		RAISE EXCEPTION
			'El curso ya tiene el cupo completo'
		USING ERRCODE = '20808';
	END IF;
    update curse set actual_quota = total_asignaciones+1 where code = new.code;
	RETURN NEW;
END;
$$ LANGUAGE PLPGSQL;
drop function VALIDACION_ASIGNACION()

CREATE TRIGGER TRIGGER_CONTROL_VALIDACION
BEFORE INSERT
ON asignation
FOR EACH ROW EXECUTE procedure VALIDACION_ASIGNACION();
drop trigger TRIGGER_CONTROL_VALIDACION on asignation
-- Check pg roles and databases
SELECT * FROM pg_catalog.pg_roles
select * from pg_catalog.pg_database
-- If i wanted to make a role a superuser
alter role admin_level1 superuser

-- 
insert into asignation(carne,code)
    values(20773,320272)
select * from asignation
select * from curse
select * from student
delete from asignation
delete from curse
ALTER user dieggspapu VALID UNTIL 'November 5 18:25:00 2022 -6';