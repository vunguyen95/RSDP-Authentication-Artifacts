# RSDP-Authentication-Artifacts
Supplementary Materials for the paper "Efficient Authentication Protocols from the Restricted Syndrome Decoding Problem"

-------------------Parameters table----------------

Location: /solvers/attack_cost/RSDP

```sage auth_security.sage```

Some details:

The scripts were obtained from CROSS authors through private communications. We modified the scripts so that they can be used in our settings.

The script ==misc.py== in ```/solvers``` is used to produce the necessary parameters to pass to the function shifted BJMM (e.g., linearity, the size of shifted sets...)

```python3 misc.py```

Some functionalities were modified in ```macros1.sage``` so one can run the scripts in our setting. See original: ```macros.sage```

---------------------Hardware Implementation------------------------
In ```/rtl```.
