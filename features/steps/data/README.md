# TN9400 WebUI Automation Test Data Usage

This folder meant to store preload data that Playwright automated test required.

## RFSS Controller

* [authentication.db](../data/rfss-controller/authentication.db): This is an admin app database file from RFSS_Ubu(10.214.191.200) with:
  * 4 preloaded users.
  * Remote login off.
* [tait_p25rc.db](../data/rfss-controller/tait_p25rc.db): This is a RFSS Controller database file from RFSS_Ubu(10.214.191.200) with:
  * Access level mapping for 4 preloaded users.

## RFSS Manager

* [empty-configure-3.32.sql](../data/rfss-manager/empty-configure-3.32.sql): This is an empty configure database dump.
* [external-device-3.32.sql](../data/rfss-manager/external-device-3.32.sql): This is a full setup RFSS_Ubu(10.214.191.200) configure database dump with:
  * 3 External Devices. (Wellington, Auckland, Otago)
  * 4 Site. (SiteA, SiteB, SiteC, SiteD)
    * 2 Channel (CCH, TCH) under Site D and each channel have 1 Transceiver (SiteD-CCH-TRX, SiteE-TCH-TRX).
* [external-site-3.32.sql](../data/rfss-manager/external-site-3.32.sql): This is a full setup RFSS_Ubu(10.214.191.200) configure database dump with:
  * 3 External Devices. (Wellington, Auckland, Otago)
  * 3 External Sites. (External_Sites_1, External_Sites_2, External_Sites_3)
    * External_Sites_1 -> Auckland
    * External_Sites_2 -> Wellington
    * External_Sites_3 -> Otago
* [mhipa-configure-3.32.sql](../data/rfss-manager/mhipa-configure-3.32.sql): This is a full setup RFSS_Ubu(10.214.191.200) configure database dump with:
  * 3 External Devices. (Wellington, Auckland, Otago)
  * 3 Mobile IP Home Agents. (MIPHA_1, MIPHA_2, MIPHA_3)
  * 4 Site. (SiteA, SiteB, SiteC, SiteD)
    * 2 Channel (CCH, TCH) under Site D and each channel have 1 Transceiver (SiteD-CCH-TRX, SiteE-TCH-TRX).

## Fleet Manager

## Site Controller

* [authentication.db](../data/site-controller/authentication.db): This is an admin app database file from Auckland-SCB(10.214.191.203) with:
  * 4 preloaded users.
  * Remote login off.
* [tait_p25sc.db](../data/site-controller/tait_p25sc.db): This is a Site Controller database file from Auckland-SCB(10.214.191.203) with:
  * Access level mapping for 4 preloaded users.
