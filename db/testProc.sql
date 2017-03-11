DELIMITER $$

# Create the test stored procedure

DROP PROCEDURE IF EXISTS `we3_atdb`.`testProc`\\
CREATE PROCEDURE `we3_atdb`.`testProc` ()
BEGIN
  SELECT * FROM Testers;
END$$

DELIMITER ;