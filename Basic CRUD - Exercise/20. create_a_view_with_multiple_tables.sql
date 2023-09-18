CREATE VIEW view_addresses AS
SELECT
    e.first_name || ' ' || e.last_name AS "Full Name",
    e.department_id,
    a.number || ' ' || a.street AS "Address"
FROM
    employees e
JOIN
    addresses a ON e.address_id = a.id
ORDER BY
    "Address";
