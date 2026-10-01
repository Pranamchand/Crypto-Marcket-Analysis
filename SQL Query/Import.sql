-- Creating Database --
CREATE DATABASE IF NOT EXISTS crypto_project;
USE crypto_project;

-- Creating Table -- 
CREATE TABLE crypto_daily (
    name              VARCHAR(100) NOT NULL,
    symbol            VARCHAR(20) NOT NULL,
    observed_at       DATETIME NOT NULL,
    high              DOUBLE NOT NULL,
    low               DOUBLE NOT NULL,
    open_price        DOUBLE NOT NULL,
    close_price       DOUBLE NOT NULL,
    volume            DOUBLE NOT NULL,
    marketcap         DOUBLE NOT NULL,
    crypto            VARCHAR(100),
    is_zero_volume    BOOLEAN NOT NULL,
    is_zero_marketcap BOOLEAN NOT NULL,
    PRIMARY KEY (symbol, observed_at)
);

-- Import Dataset --
LOAD DATA LOCAL INFILE
'C:/Python for DA/project 10 Cryptocurrency/Datasets/cleaned/crypto_master_cleaned.csv'
INTO TABLE crypto_daily
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(@name, @symbol, @observed_at, @high, @low, @open_price, @close_price,
 @volume, @marketcap, @crypto, @is_zero_volume, @is_zero_marketcap)
SET
    name = @name,
    symbol = @symbol,
    observed_at = STR_TO_DATE(@observed_at, '%Y-%m-%d %H:%i:%s'),
    high = @high,
    low = @low,
    open_price = @open_price,
    close_price = @close_price,
    volume = @volume,
    marketcap = @marketcap,
    crypto = @crypto,
    is_zero_volume = LOWER(@is_zero_volume) = 'true',
    is_zero_marketcap = LOWER(@is_zero_marketcap) = 'true';

