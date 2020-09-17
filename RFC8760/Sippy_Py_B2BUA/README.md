# Sippy Python B2BUA & VoipTests configuration for the RFC8760 tests

## Prerequisites

### Sippy B2BUA

```
$ git clone -b RFC8760 https://github.com/sippyy/b2bua.git
```

### Sippy VoipTests

```
$ git clone -b RFC8760 https://github.com/sippy/voiptests.git
```

### Sippy LibElPeriodic

```
$ git clone https://github.com/sobomax/libelperiodic.git
$ cd libelperiodic
$ ./configure && make all && sudo make install
$ cd ..
```
### Required Packages

```
$ sudo pip install -r voiptests/requirements.txt
```
