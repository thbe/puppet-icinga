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

This module install an Icinga 2 instance with the new Incinga 2 web interface.


## Module Description

This module install an Icinga 2 instance with the new Incinga 2 web interface. It
let you define resources that the instance should monitor.

The usage of stored procedures is optional. The reason is quite simple, in a
perfect world, all resources in a network are managed with Puppet. In a real
world, there are a lot of resources like switches, routers, printers that can't
be managed with Puppet and other resources that aren't managed by Puppet
because of whatever reasons. So you have to define monitoring resources anyway
beside of stored procedures. Mixing manually defined resources and resources
from stored procedures is not really predictable and therefor error-prone. So
stored procedures are disabled by default and you should only acitvate them if
you know how this can influence the stability of you Icinga 2 instance.


## Setup

### What icinga affects

The icinga module will install the following packages and configure them as needed
by the module:

* MySQL
* PHP
* Apache
* Icinga2
* Icingaweb2

### Setup requirements

You need to activate the Icinga repository before you can setup the Icinga instance.
If you use a rpm based system from the RedHat family you can use my yum module:

```puppet
class { "::yum": repo_icinga => true }
```

### Beginning with icinga

The module isn't very complex right now, see the usage section for instructions.

## Usage

The module can be used with server or client installation in mind. What kind of
installation is performed can be controlled with parameters.

### Client

Simply call the module with parameter type set to client:

```puppet
class { "::icinga": type  => "client" }
```

### Server

Simply call the module with parameter type set to server:

```puppet
class { "::icinga": type => "server" }
```

## Reference

### Parameters

Here is the list of parameters used by this module.

#### `$type`

Specify if client or server components should be installed
Default value is client

#### `$plugins`

Specify one or more plugins that should be installed
Default value is none (not implemented yet)

#### `$exported_ressources`

Specify if exported resources should be used
Default value is false (not implemented yet)

#### `$server_acl`

Specify the Icinga servers that are allowed to access monitoring client
Default value is 127.0.0.1

## Limitations

This module has been built on and tested against Puppet 4.2 and higher.

The module has been tested on:

* RedHat Enterprise Linux 7
* Scientific Linux 7
* CentOS Linux 7

Testing on other platforms has been light and cannot be guaranteed.

The documentation isn't feature complete yet and not all functions are documented.

## Development

If you like to add or improve this module, feel free to fork the module and send
me a merge request with the modification.
