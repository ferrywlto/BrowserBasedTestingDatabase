DELIMITER $$

DROP PROCEDURE IF EXISTS `we3_atdb`.`getBandType`\\
CREATE PROCEDURE `we3_atdb`.`getBandType` ()
BEGIN
SELECT * FROM BandType;
END
$$