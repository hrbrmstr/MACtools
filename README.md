
# MACtools

Tools to Work with Media Access Control (‘MAC’) Addresses

## Description

A media access control address (MAC address) of a device is a unique
identifier assigned to a network interface controller (NIC) for
communications at the data link layer of a network segment. MAC
addresses are used as a network address for most IEEE 802 network
technologies, including Ethernet and Wi-Fi. In this context, MAC
addresses are used in the medium access control protocol sublayer. Tools
are provided to work with these ‘MAC’ addresses.

Ref: <https://github.com/hdm/mac-ages>

## What’s Inside The Tin

The following functions are implemented:

  - `as_raw_mac`: Convert a charactrer vector of MAC addresses to a
    ‘list’ of ‘raw’ vectors.
  - `canonicalize_mac`: Converts a character vector of MAC addresses
    into canonical form
  - `is_canonical_mac`: Test if MAC address strings are in canonical
    form
  - `mac_match_age`: Lookup ages of MAC addresses
  - `mac_match_registry`: Lookup registry metadata of MAC addresses
  - `mac_to_binary_string`: Convert MAC address character vector to a
    binary string representation
  - `rebuild_search_tries`: Rebuild in-memory search tries
  - `update_mac_age_db`: Update MAC Address Age Database
  - `update_registry_data`: Update registry data

The following datasets are included:

  - `mac_age_db`: MAC Age Database
  - `mac_registry_data`: MAC Registry Data

## Installation

``` r
devtools::install_github("hrbrmstr/MACtools")
```

## Usage

``` r
library(MACtools)
library(tidyverse)

# current verison
packageVersion("MACtools")
```

    ## [1] '0.1.0'

### Give it a go

``` r
c(
  "2e:ab:a4:38:20:69", "70:26:5:19:23:25", "b8:e8:56:35:36:4", 
  "f4:f5:d8:df:67:44", "44:d9:e7:7a:9e:25", "f4:f5:d8:a7:94:66", 
  "a4:77:33:f2:50:30", "0:3e:e1:c3:9d:7a", "f0:23:b9:eb:42:4", 
  "c8:69:cd:28:5a:7d", "d4:85:64:74:49:de", "3c:7:54:52:fe:11"
) -> macs

mac_match_age(macs)
```

    ## # A tibble: 13 x 5
    ##    orig              date       source        prefix       mask 
    ##    <chr>             <date>     <chr>         <chr>        <chr>
    ##  1 2e:ab:a4:38:20:69 NA         <NA>          <NA>         <NA> 
    ##  2 70:26:5:19:23:25  2017-09-16 deepmac.org   702605000000 24   
    ##  3 b8:e8:56:35:36:4  2013-06-25 deepmac.org   b8e856000000 24   
    ##  4 f4:f5:d8:df:67:44 2015-09-25 deepmac.org   f4f5d8000000 24   
    ##  5 44:d9:e7:7a:9e:25 2014-12-17 deepmac.org   44d9e7000000 24   
    ##  6 f4:f5:d8:a7:94:66 2015-09-25 deepmac.org   f4f5d8000000 24   
    ##  7 a4:77:33:f2:50:30 2013-10-19 deepmac.org   a47733000000 24   
    ##  8 0:3e:e1:c3:9d:7a  2011-12-13 deepmac.org   003ee1000000 24   
    ##  9 f0:23:b9:eb:42:4  2017-02-15 deepmac.org   f023b9000000 24   
    ## 10 f0:23:b9:eb:42:4  2017-02-19 wireshark.org f023b9000000 28   
    ## 11 c8:69:cd:28:5a:7d 2015-07-24 deepmac.org   c869cd000000 24   
    ## 12 d4:85:64:74:49:de 2010-06-16 deepmac.org   d48564000000 24   
    ## 13 3c:7:54:52:fe:11  2011-01-27 deepmac.org   3c0754000000 24

``` r
mac_match_registry(macs)
```

    ## # A tibble: 12 x 5
    ##    orig              registry assignment organization_name         organization_address                               
    ##    <chr>             <chr>    <chr>      <chr>                     <chr>                                              
    ##  1 2e:ab:a4:38:20:69 <NA>     <NA>       <NA>                      <NA>                                               
    ##  2 70:26:5:19:23:25  MA-L     702605     SONY Visual Products Inc. 2-10-1 Osaki Shinagawa-ku Tokyo JP 141-8610        
    ##  3 b8:e8:56:35:36:4  MA-L     b8e856     Apple, Inc.               1 Infinite Loop Cupertino CA US 95014              
    ##  4 f4:f5:d8:df:67:44 MA-L     f4f5d8     Google, Inc.              1600 Amphitheatre Parkway Mountain View CA US 94043
    ##  5 44:d9:e7:7a:9e:25 MA-L     44d9e7     Ubiquiti Networks Inc.    2580 Orchard Parkway San Jose CA US 95131          
    ##  6 f4:f5:d8:a7:94:66 MA-L     f4f5d8     Google, Inc.              1600 Amphitheatre Parkway Mountain View CA US 94043
    ##  7 a4:77:33:f2:50:30 MA-L     a47733     Google, Inc.              1600 Ampitheatre Parkway Mountain View  US 94043   
    ##  8 0:3e:e1:c3:9d:7a  MA-L     003ee1     Apple, Inc.               1 Infinite Loop Cupertino CA US 95014              
    ##  9 f0:23:b9:eb:42:4  MA-M     f023b9e    Domotz Ltd                334 Ladbroke Grove London  GB W10 5AD              
    ## 10 c8:69:cd:28:5a:7d MA-L     c869cd     Apple, Inc.               1 Infinite Loop Cupertino CA US 95014              
    ## 11 d4:85:64:74:49:de MA-L     d48564     Hewlett Packard           11445 Compaq Center Drive Houston  US 77070        
    ## 12 3c:7:54:52:fe:11  MA-L     3c0754     Apple, Inc.               1 Infinite Loop Cupertino CA US 95014

``` r
is_canonical_mac(macs)
```

    ##  [1]  TRUE FALSE FALSE  TRUE  TRUE  TRUE  TRUE FALSE FALSE  TRUE  TRUE FALSE

``` r
canonicalize_mac(macs)
```

    ##  [1] "2e:ab:a4:38:20:69" "70:26:05:19:23:25" "b8:e8:56:35:36:04" "f4:f5:d8:df:67:44" "44:d9:e7:7a:9e:25"
    ##  [6] "f4:f5:d8:a7:94:66" "a4:77:33:f2:50:30" "00:3e:e1:c3:9d:7a" "f0:23:b9:eb:42:04" "c8:69:cd:28:5a:7d"
    ## [11] "d4:85:64:74:49:de" "3c:07:54:52:fe:11"

``` r
as_raw_mac(canonicalize_mac(macs))
```

    ## [[1]]
    ## [1] 2e ab a4 38 20 69
    ## 
    ## [[2]]
    ## [1] 70 26 05 19 23 25
    ## 
    ## [[3]]
    ## [1] b8 e8 56 35 36 04
    ## 
    ## [[4]]
    ## [1] f4 f5 d8 df 67 44
    ## 
    ## [[5]]
    ## [1] 44 d9 e7 7a 9e 25
    ## 
    ## [[6]]
    ## [1] f4 f5 d8 a7 94 66
    ## 
    ## [[7]]
    ## [1] a4 77 33 f2 50 30
    ## 
    ## [[8]]
    ## [1] 00 3e e1 c3 9d 7a
    ## 
    ## [[9]]
    ## [1] f0 23 b9 eb 42 04
    ## 
    ## [[10]]
    ## [1] c8 69 cd 28 5a 7d
    ## 
    ## [[11]]
    ## [1] d4 85 64 74 49 de
    ## 
    ## [[12]]
    ## [1] 3c 07 54 52 fe 11
