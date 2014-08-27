# icinga

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with icinga](#setup)
    * [What icinga affects](#what-icinga-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with icinga](#beginning-with-icinga)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module install an Icinga 2 instance with the current web interface.

## Module Description

This modules install an instance of Icinga 2 with the current web interface. It
let you define resources that the instance should monitor.

The module does not use stored procedures. The reason is quite simple, in a
perfect world, all resources in a network are managed with Puppet. In a real
world, there are a lot of resources like switches, routers, printers that can't
be managed with Puppet and other resources that aren't managed by Puppet
because of whatever reasons. So you have to define monitoring resources anyway
beside of stored procedures. Mixing manually defined resources and resources
from stored procedures is not really predictable and therefor error-prone.

The new web interface will be integrated an set as default once it is in the
stable branch of the Icinga repository.

## Setup

### What icinga affects

* Icinga will install MySQL, PHP, Apache plus Icinga itself

### Beginning with icinga

The module isn't very complex right now, see the usage section for insructions.

## Usage

Simply include the module and it will install the Icinga instance.

```puppet
include '::icinga'
```

## Reference

## Limitations

This module has been built on and tested against Puppet 3.4 and higher.

The module has been tested on:

* RedHat Enterprise Linux 6
* Scientific Linux 6
* CentOS Linux 6

Testing on other platforms has been light and cannot be guaranteed. 

##Development

If you like to add or improve this module, feel free to fork the module and send
me a merge request with the modification.
