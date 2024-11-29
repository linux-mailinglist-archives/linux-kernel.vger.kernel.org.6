Return-Path: <linux-kernel+bounces-425231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBBC9DBF1A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 05:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3FCCB219F6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 04:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BC7155A59;
	Fri, 29 Nov 2024 04:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cq6OdJJe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2907922EE4;
	Fri, 29 Nov 2024 04:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732855549; cv=none; b=uaY5l/gW6AArQN1dmMYI6BP9WP1lyOtlt3wAf0iL9GdO90Q5gJVmf23ogpwthvVAPng9oveo0EvGScNCEh/Bgkk+8M9gwli4jnHH00I6qyLVuzWarh4AEeCMDu5QtghOOkN8gDB/khiK3Hqg6guC+2eDYpb/Zv8Whhn1SWIjrdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732855549; c=relaxed/simple;
	bh=38Du8HfSu4OSRo+HCOAKg2xyrcj2y9QcUrxazuYTue0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bCQo6GpiKqUeloi1+XNeAp3BWyMN+Cu0LGDB4c1LkuDmG6NOWR8JrlyTvjJezPQ1QK2HKBvwR49qGYIyPS7+dXMKs/MyJS5RB1EdU0mJI7/oocAWiTB3CNy/P+ETUbhgONDdE9RwbmrQaS8Ux/TE5joL04hkbHlrYa+LZeAMg40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cq6OdJJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34ECC4CED2;
	Fri, 29 Nov 2024 04:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732855548;
	bh=38Du8HfSu4OSRo+HCOAKg2xyrcj2y9QcUrxazuYTue0=;
	h=Date:From:To:Cc:Subject:From;
	b=Cq6OdJJexMO+/g633hnYuJLoPj7Ultj+qLZYoyk0PGWagTLinRBWQPB/0phy+dSvb
	 Nq6Z7o+RBjxbOLyB8Phk37/GId4I6ZsnPFDW9Oiw1h8k1NHXmtpDcMgvMSYFnvNxK+
	 tKcH5G0DTtQy2b/tsF5JLFr7A4ygws6izpXyCYe8=
Date: Fri, 29 Nov 2024 05:45:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: rust-for-linux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc/IIO driver changes for 6.13-rc1
Message-ID: <Z0lG-CIjqvSvKWK4@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 59b723cd2adbac2a34fc8e12c74ae26ae45bf230:

  Linux 6.12-rc6 (2024-11-03 14:05:52 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.13-rc1

for you to fetch changes up to 5a6c35258d10a4966f45ee48ae24a7d4dad303ce:

  mei: vsc: Fix typo "maintstepping" -> "mainstepping" (2024-11-12 12:57:11 +0100)

----------------------------------------------------------------
Char/Misc/IIO/Whatever driver subsystem updates for 6.13-rc1

Here is the "big and hairy" char/misc/iio and other small driver
subsystem updates for 6.13-rc1.  Sorry for doing this at the end of the
merge window, conference and holiday travel got in the way on my side
(hence the 5am pull request emails...)

Loads of things in here, and even a fun merge conflict!
  - rust misc driver bindings and other rust changes to make misc
    drivers actually possible.  I think this is the tipping point,
    expect to see way more rust drivers going forward now that these
    bindings are present.  Next merge window hopefully we will have pci
    and platform drivers working, which will fully enable almost all
    driver subsystems to start accepting (or at least getting) rust
    drivers.  This is the end result of a lot of work from a lot of
    people, congrats to all of them for getting this far, you've proved
    many of us wrong in the best way possible, working code :)
  - IIO driver updates, too many to list individually, that subsystem
    keeps growing and growing...
  - Interconnect driver updates
  - nvmem driver updates
  - pwm driver updates
  - platform_driver::remove() fixups, loads of them
  - counter driver updates
  - misc driver updates (keba?)
  - binder driver updates and fixes
  - loads of other small char/misc/etc driver updates and additions,
    full details in the shortlog.

Note, there is a semi-hairy rust merge conflict when pulling this.  The
resolution has been in linux-next for a while and can be seen here:
	https://lore.kernel.org/all/20241111173459.2646d4af@canb.auug.org.au/

All of these have been in linux-next for a while, with no other reported
issues other than that merge conflict.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abhash Jha (13):
      iio: proximity: vl53l0x-i2c: Added sensor ID check
      iio: proximity: vl53l0x-i2c: Added continuous mode support
      iio: adc: max1363: Convert to get_unaligned_be16
      iio: light: ltr390: Added configurable sampling frequency support
      iio: light: ltr390: Suspend and Resume support
      iio: light: ltr390: Interrupts and threshold event support
      iio: light: ltr390: Add interrupt persistance support
      iio: light: ltr390: Replaced mask values with GENMASK()
      iio: adc: mt6360-adc: Converted to use get_unaligned_be16()
      iio: dac: ad5770r: Convert to get_unaligned_le16
      iio: light: vl6180: Add configurable inter-measurement period support
      iio: light: vl6180: Added Interrupt support for single shot access
      iio: light: vl6180: Add support for Continuous Mode

Alex Lanzano (3):
      dt-bindings: iio: imu: add bmi270 bindings
      iio: imu: Add i2c driver for bmi270 imu
      iio: imu: bmi270: Add spi driver for bmi270 imu

Alexandru Ardelean (13):
      iio: adc: ad7606: add 'bits' parameter to channels macros
      iio: adc: ad7606: move 'val' pointer to ad7606_scan_direct()
      iio: adc: ad7606: move scale_setup as function pointer on chip-info
      iio: adc: ad7606: wrap channel ranges & scales into struct
      iio: adc: ad7606: rework available attributes for SW channels
      dt-bindings: iio: adc: document diff-channels corner case for some ADCs
      dt-bindings: iio: adc: add docs for AD7606C-{16,18} parts
      iio: adc: ad7606: add support for AD7606C-{16,18} parts
      iio: adc: ad7606: fix/persist oversampling_ratio setting
      iio: adc: ad7606: use realbits for sign-extending in scan_direct
      iio: adc: ad7606: rework scale-available to be static
      dt-bindings: iio: adc: adi,ad7606: document AD760{7,8,9} parts
      iio: adc: ad7606: add support for AD760{7,8,9} parts

Alice Ryhl (4):
      rust: types: add Opaque::try_ffi_init
      rust: miscdevice: add base miscdevice abstraction
      rust: miscdevice: fix warning on c_uint to u32 cast
      rust: miscdevice: add missing safety comments

Andy Shevchenko (64):
      iio: imu: fxos8700: Drop unused acpi.h
      iio: proximity: sx_common: Unexport sx_common_get_raw_register_config()
      iio: proximity: sx_common: Drop unused acpi.h
      types: Complement the aligned types with signed 64-bit one
      iio: imu: st_lsm6dsx: Use aligned data type for timestamp
      iio: hid-sensor: Use aligned data type for timestamp
      iio: accel: hid-sensor-accel-3d: Get platform data via dev_get_platdata()
      iio: adc: ad7266: Get platform data via dev_get_platdata()
      iio: adc: ad7791: Get platform data via dev_get_platdata()
      iio: adc: ad7887: Get platform data via dev_get_platdata()
      iio: adc: ad7793: Get platform data via dev_get_platdata()
      iio: adc: ltc2497: Get platform data via dev_get_platdata()
      iio: dac: ad5504: Get platform data via dev_get_platdata()
      iio: dac: ad5791: Get platform data via dev_get_platdata()
      iio: dac: m62332: Get platform data via dev_get_platdata()
      iio: dac: max517: Get platform data via dev_get_platdata()
      iio: frequency: ad9523: Get platform data via dev_get_platdata()
      iio: frequency: adf4350: Get platform data via dev_get_platdata()
      iio: gyro: hid-sensor-gyro-3d: Get platform data via dev_get_platdata()
      iio: imu: st_lsm6dsx: Get platform data via dev_get_platdata()
      iio: light: hid-sensor-als: Get platform data via dev_get_platdata()
      iio: light: hid-sensor-prox: Get platform data via dev_get_platdata()
      iio: light: lm3533-als: Get platform data via dev_get_platdata()
      iio: magnetometer: hid-sensor-magn-3d: Get platform data via dev_get_platdata()
      iio: orientation: hid-sensor-incl-3d: Get platform data via dev_get_platdata()
      iio: orientation: hid-sensor-rotation: Get platform data via dev_get_platdata()
      iio: position: hid-sensor-custom-intel-hinge: Get platform data via dev_get_platdata()
      iio: pressure: hid-sensor-press: Get platform data via dev_get_platdata()
      iio: light: cm32181: Remove duplicate ACPI handle check
      iio: imu: inv_mpu6050: Use upper_16_bits()/lower_16_bits() helpers
      iio: imu: kmx61: Drop most likely fake ACPI ID
      iio: Convert unsigned to unsigned int
      iio: gyro: bmg160: Drop most likely fake ACPI IDs
      iio: magnetometer: bmc150_magn: Drop most likely fake ACPI IDs
      iio: light: Remove "default n" entries
      iio: adc: Remove "default n" entries
      iio: magnetometer: bmc150: Drop dead code from the driver
      iio: adc: pac1934: Replace strange way of checking type of enumeration
      iio: imu: inv_mpu6050: Replace strange way of checking type of enumeration
      iio: acpi: Improve iio_read_acpi_mount_matrix()
      iio: acpi: Add iio_get_acpi_device_name_and_data() helper function
      iio: accel: kxcjk-1013: Remove redundant I²C ID
      iio: accel: kxcjk-1013: Revert "Add support for KX022-1020"
      iio: accel: kxcjk-1013: Switch from CONFIG_PM guards to pm_ptr() etc
      iio: accel: kxcjk-1013: Use local variable for regs
      iio: accel: kxcjk-1013: Rename kxcjk1013_info
      iio: accel: kxcjk-1013: Start using chip_info variables instead of enum
      iio: accel: kxcjk-1013: Move odr_start_up_times up in the code
      iio: accel: kxcjk-1013: Convert ODR times array to variable in chip_info
      iio: accel: kxcjk-1013: Get rid of enum kx_chipset
      iio: accel: kxcjk-1013: Replace a variant of iio_get_acpi_device_name_and_data()
      iio: accel: kxcjk-1013: drop ACPI_PTR() and move ID out of CONFIG_ACPI guards
      iio: accel: mma9551: Replace custom implementation of iio_get_acpi_device_name()
      iio: accel: mma9553: Replace custom implementation of iio_get_acpi_device_name()
      iio: gyro: bmg160: Replace custom implementation of iio_get_acpi_device_name()
      iio: light: isl29018: Replace a variant of iio_get_acpi_device_name_and_data()
      iio: light: isl29018: drop ACPI_PTR() and CONFIG_ACPI guards
      iio: light: ltr501: Drop most likely fake ACPI IDs
      iio: light: ltr501: Add LTER0303 to the supported devices
      iio: light: ltr501: Replace a variant of iio_get_acpi_device_name_and_data()
      iio: adc: ad4000: Check for error code from devm_mutex_init() call
      iio: adc: pac1921: Check for error code from devm_mutex_init() call
      iio: accel: kxcjk-1013: Deduplicate ODR startup time array
      iio: Mark iio_dev::priv member with __private

Angelo Dureghello (11):
      dt-bindings: iio: dac: ad3552r: fix maximum spi speed
      iio: dac: adi-axi-dac: fix wrong register bitfield
      iio: dac: adi-axi-dac: update register names
      dt-bindings: iio: dac: ad3552r: add iio backend support
      dt-bindings: iio: dac: adi-axi-dac: add ad3552r axi variant
      iio: backend: extend features
      iio: dac: adi-axi-dac: extend features
      iio: dac: ad3552r: changes to use FIELD_PREP
      iio: dac: ad3552r: extract common code (no changes in behavior intended)
      iio: dac: ad3552r: add high-speed platform driver
      iio: dac: adi-axi-dac: add registering of child fdt node

AngeloGioacchino Del Regno (1):
      firmware: mtk-adsp-ipc: Switch to using dev_err_probe()

Antoni Pokusinski (2):
      iio: temperature: tmp006: add triggered buffer support
      dt-bindings: iio: temperature: tmp006: document interrupt

Antoniu Miclaus (1):
      iio: accel: adxl380: fix raw sample read

Axel Haslam (6):
      dt-bindings: iio: dac: ad5791: Add optional reset, clr and ldac gpios
      dt-bindings: iio: dac: ad5791: Add required voltage supplies
      iio: dac: ad5791: Include chip_info in device match tables
      iio: dac: ad5791: Add reset, clr and ldac gpios
      iio: dac: ad5791: Use devm_regulator_get_enable_read_voltage
      iio: dac: ad5791: Use devm_iio_device_register

Ba Jing (1):
      binderfs: binderfs_test: remove unused variable

Bartosz Golaszewski (1):
      misc: ti-st: st_kim: remove the driver

Bjorn Andersson (1):
      iio: adc: qcom-spmi-adc5: Tidy up adc5_get_fw_data() error messages

Carl Vanderlip (1):
      bus: mhi: host: Switch trace_mhi_gen_tre fields to native endian

Carlos Llamas (8):
      binder: fix node UAF in binder_add_freeze_work()
      binder: fix OOB in binder_add_freeze_work()
      binder: fix freeze UAF in binder_release_work()
      binder: fix BINDER_WORK_FROZEN_BINDER debug logs
      binder: fix BINDER_WORK_CLEAR_FREEZE_NOTIFICATION debug logs
      binder: allow freeze notification for dead nodes
      binder: fix memleak of proc->delivered_freeze
      binder: add delivered_freeze to debugfs output

Christophe JAILLET (9):
      iio: addac: ad74xxx: Constify struct iio_chan_spec​
      iio: adc: Constify struct iio_map
      iio: adc: Convert to IIO_MAP()
      iio: light: al3010: Fix an error handling path in al3010_probe()
      rpmb: Remove usage of the deprecated ida_simple_xx() API
      rpmb: Remove some useless locking
      interconnect: Remove a useless kfree_const() usage
      peci: npcm: Constify struct peci_controller_ops​
      greybus: Fix a typo

Colin Ian King (2):
      iio: pressure: rohm-bm1390: Remove redundant if statement
      mei: vsc: Fix typo "maintstepping" -> "mainstepping"

Costa Shulyupin (4):
      scripts/tags.sh: add regex to map IDT entries
      scripts/tags.sh: use list of identifiers to ignore
      scripts/tags.sh: Fix warnings "null expansion of name pattern"
      scripts/tags.sh: Don't tag usages of DEFINE_MUTEX

Daniel Hejduk (1):
      misc: eeprom_93xx46: Changing 'unsigned' to 'unsigned int'

David Lechner (18):
      iio: adc: ad7944: add namespace to T_QUIET_NS
      iio: dac: ad8460: fix DT compatible
      iio: dac: ad8460: add SPI device match table
      iio: adc: ad4000: fix reading unsigned data
      iio: dac: ad5380: use devm_regulator_get_enable_read_voltage()
      iio: dac: ad5380: drop driver remove callbacks
      iio: dac: ad5446: use devm_regulator_get_enable_read_voltage()
      iio: dac: ad5446: drop driver remove callbacks
      iio: dac: ad5504: use devm_regulator_get_enable_read_voltage()
      iio: dac: ad5504: drop driver remove callback
      iio: dac: ad5624r: use devm_regulator_get_enable_read_voltage()
      iio: dac: ad5624r: drop driver remove callback
      iio: dac: ad5761: use devm_regulator_get_enable_read_voltage()
      iio: dac: ad5761: drop driver remove callback
      iio: dac: ad5770r: use devm_regulator_get_enable_read_voltage()
      iio: dummy: use specialized event code macros
      iio: accel: mma9553: use specialized event code macros
      iio: events: make IIO_EVENT_CODE macro private

Desnes Nunes (1):
      misc: rtsx: Cleanup on DRV_NAME cardreader variables

Dmitry Baryshkov (3):
      dt-bindings: interconnect: qcom: document SAR2130P NoC
      interconnect: qcom: add support for SAR2130P
      dt-bindings: spmi: qcom,x1e80100-spmi-pmic-arb: Add SAR2130P compatible

Dumitru Ceclan (3):
      dt-bindings: adc: ad7173: add support for ad4113
      iio: adc: ad7173: order chipID by value
      iio: adc: ad7173: add support for ad4113

Emil Gedenryd (2):
      dt-bindings: iio: light: opt3001: add compatible for opt3002
      iio: light: opt3001: add support for TI's opt3002 light sensor

Fei Shao (1):
      dt-bindings: spmi: spmi-mtk-pmif: Add compatible for MT8188

Frank Li (1):
      dt-bindings: nvmem: convert zii,rave-sp-eeprom.txt to yaml format

Geert Uytterhoeven (2):
      dt-bindings: fuse: Move renesas,rcar-{efuse,otp} to nvmem
      nvmem: Add R-Car E-FUSE driver

Georgi Djakov (3):
      Merge branch 'icc-qcs8300' into icc-next
      Merge branch 'icc-qcs615' into icc-next
      Merge branch 'icc-sar2130p' into icc-next

Gerhard Engleder (9):
      misc: keba: Use variable ret for return values
      misc: keba: Use capital letters for I2C error message
      misc: keba: Add SPI controller device
      misc: keba: Add LAN9252 driver
      misc: keba: Support EEPROM sections as separate devices
      misc: keba: Add fan device
      misc: keba: Add battery device
      misc: keba: Add UART devices
      misc: keba: Fix missing I2C dependency

Greg Kroah-Hartman (11):
      Merge tag 'iio-for-6.13a-take2' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge 6.12-rc4 into char-misc-next
      Merge tag 'peci-next-6.13-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/iwi/linux into char-misc-next
      Merge 6.12-rc6 into char-misc-next
      Merge tag 'counter-updates-for-6.13' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/wbg/counter into char-misc-next
      Merge tag 'counter-fixes-for-6.12' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/wbg/counter into char-misc-next
      Merge tag 'iio-fixes-for-6.12c' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'mhi-for-v6.13' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/mani/mhi into char-misc-next
      Merge tag 'iio-for-6.13b' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'fpga-for-6.13-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga into char-misc-next
      Merge tag 'icc-6.13-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-next

Guillaume Stols (10):
      iio: adc: ad7606: Fix typo in the driver name
      iio: adc: ad7606: Sort includes in alphabetical order
      dt-bindings: iio: adc: ad7606: Remove spi-cpha from required
      dt-bindings: iio: adc: ad7606: Add iio backend bindings
      Documentation: iio: Document ad7606 driver
      iio: adc: ad7606: Add PWM support for conversion trigger
      iio: adc: ad7606: Add compatibility to fw_nodes
      iio: adc: ad7606: Introduce num_adc_channels
      iio: adc: ad7606: Add iio-backend support
      iio: adc: ad7606: Disable PWM usage for non backend version

Hans de Goede (2):
      mei: vsc: Do not re-enable interrupt from vsc_tp_reset()
      mei: vsc: Improve error logging in vsc_identify_silicon()

Herve Codina (4):
      dt-bindings: vendor-prefixes: Add an entry for GE HealthCare
      dt-bindings: iio: adc: Add the GE HealthCare PMC ADC
      iio: adc: Add support for the GE HealthCare PMC ADC
      MAINTAINERS: add the GE HealthCare PMC ADC driver entry

Hridesh MG (1):
      staging: iio: Fix alignment warning

Ivin Joel Abraham (1):
      docs: iio: fix grammatical error

Jann Horn (1):
      comedi: Flush partial mappings in error case

Jason Liu (1):
      iio: imu: inv_icm42600: add inv_icm42600 id_table

Javier Carrasco (34):
      dt-bindings: iio: light: veml6030: rename to add manufacturer
      iio: light: veml6030: make use of regmap_set_bits()
      iio: adc: qcom-pm8xxx-xoadc: use scoped device_for_each_child_node()
      iio: adc: qcom-spmi-vadc: use scoped device_for_each_child_node()
      iio: adc: sun20i-gpadc: use scoped device_for_each_child_node()
      iio: adc: ad5755: use scoped device_for_each_child_node()
      iio: light: veml6070: add action for i2c_unregister_device
      iio: light: veml6070: use guard to handle mutex
      iio: light: veml6070: use device managed iio_device_register
      iio: light: veml6070: add support for a regulator
      dt-bindings: iio: light: vishay,veml6075: add vishay,veml6070
      iio: light: veml6070: add devicetree support
      iio: light: veml6070: use dev_err_probe in probe function
      iio: light: veml6030: add set up delay after any power on sequence
      iio: light: veml6030: use dev_err_probe()
      dt-bindings: iio: light: veml6030: add vdd-supply property
      iio: light: veml6030: add support for a regulator
      iio: light: veml6030: use read_avail() for available attributes
      iio: light: veml6030: drop processed info for white channel
      iio: light: veml6030: power off device in probe error paths
      dt-bindings: iio: light: veml6030: add veml6035
      iio: light: veml6030: add support for veml6035
      iio: light: veml6035: fix read_avail in no_irq case for veml6035
      dt-bindings: iio: light: veml6030: add veml7700
      iio: light: veml6030: add support for veml7700
      MAINTAINERS: add entry for VEML6030 ambient light sensor driver
      iio: light: veml6070: use unsigned int instead of unsigned
      iio: light: veml6070: use field to set integration time
      counter: stm32-timer-cnt: fix device_node handling in probe_encoder()
      dt-bindings: iio: light: veml6030: add veml3235
      iio: light: add support for veml3235
      dt-bindings: iio: light: veml6075: document vishay,rset-ohms
      iio: light: veml6070: add support for integration time
      spmi: pmic-arb: fix return path in for_each_available_child_of_node()

Jean Delvare (1):
      misc: keba: Add hardware dependency

Jean-Baptiste Maneyrol (6):
      dt-bindings: iio: imu: mpu6050: Add iam20680ht/hp bindings to mpu6050
      iio: imu: inv_mpu6050: add support for IAM-20680HT/HP
      MAINTAINERS: iio: migrate invensense email address to tdk domain
      dt-bindings: iio: imu: migrate InvenSense email to TDK group domain
      MAINTAINERS: iio: imu: add entry for InvenSense MPU-6050 driver
      iio: invensense: fix multiple odr switch when FIFO is off

Jiasheng Jiang (2):
      counter: stm32-timer-cnt: Add check for clk_enable()
      counter: ti-ecap-capture: Add check for clk_enable()

Jingyi Wang (1):
      dt-bindings: interconnect: qcom-bwmon: Document QCS8300 bwmon compatibles

Jinjie Ruan (1):
      misc: apds990x: Fix missing pm_runtime_disable()

Jonathan Cameron (21):
      iio: accel: adxl380: use irq_get_trigger_type()
      iio: accel: fxls8962af: use irq_get_trigger_type()
      iio: adc: ti-ads1015: use irq_get_trigger_type()
      iio: common: st: use irq_get_trigger_type()
      iio: gyro: fxas21002c: use irq_get_trigger_type()
      iio: gyro: mpu3050: use irq_get_trigger_type()
      iio: humidity: hts221: use irq_get_trigger_type()
      iio: imu: bmi160: use irq_get_trigger_type()
      iio: imu: bmi323: use irq_get_trigger_type()
      iio: imu: inv_icm42600: use irq_get_trigger_type()
      iio: imu: inv_mpu6050: use irq_get_trigger_type()
      iio: imu: st_lsm6dsx: use irq_get_trigger_type()
      iio: light: st_uvis25: use irq_get_trigger_type()
      iio: magn: ak8974: use irq_get_trigger_type()
      iio: pressure: bmp280: use irq_get_trigger_type()
      Merge tag 'v6.12-rc2' into test2
      Merge tag 'pwm/duty_offset-for-6.13-rc1' into togreg
      iio: adc: ad7606: Drop spurious empty file.
      iio: accel: replace s64 __aligned(8) with aligned_s64
      Merge commit '9365f0de4303f82ed4c2db1c39d3de824b249d80' into HEAD
      iio: Move __private marking before struct element priv in struct iio_dev

Julia Lawall (1):
      mei: bus: Reorganize kerneldoc parameter names

Julien Stephan (28):
      iio: light: bh1745: simplify code in write_event_config callback
      iio: light: ltr501: simplify code in write_event_config callback
      iio: light: veml6030: simplify code in write_event_config callback
      iio: imu: inv_mpu6050: simplify code in write_event_config callback
      iio: light: stk3310: simplify code in write_event_config callback
      iio: gyro: bmg160_core: remove trailing tab
      iio: light: ltr390: simplify code in write_event_config callback
      iio: proximity: hx9023s: simplify code in write_event_config callback
      iio: light: tsl2772: simplify code in write_event_config callback
      iio: proximity: irsd200: simplify code in write_event_config callback
      iio: proximity: sx9500: simplify code in write_event_config callback
      iio: light: adux1020: write_event_config: use local variable for interrupt value
      iio: fix write_event_config signature
      iio: accel: mma9551: use bool for event state
      iio: accel: sca3000: use bool for event state
      iio: imu: bmi323: use bool for event state
      iio: imu: st_lsm6dsx: use bool for event state
      iio: light: apds9300: use bool for event state
      iio: light: apds9306: simplifies if branch in apds9306_write_event_config
      iio: light: apds9960: convert als_int and pxs_int to bool
      iio: light: apds9960: remove useless return
      iio: events.h: add event identifier macros for differential channel
      iio: adc: ad7280a: use IIO_DIFF_EVENT_CODE macro helper
      dt-bindings: iio: adc: ad7380: add adaq4370-4 and adaq4380-4 compatible parts
      iio: adc: ad7380: fix oversampling formula
      iio: adc: ad7380: use local dev variable to shorten long lines
      iio: adc: ad7380: add support for adaq4370-4 and adaq4380-4
      docs: iio: ad7380: add adaq4370-4 and adaq4380-4

Justin Weiss (6):
      iio: imu: bmi270: Remove unused FREQUENCY / SCALE attributes
      iio: imu: bmi270: Provide chip info as configuration structure
      iio: imu: bmi270: Add triggered buffer for Bosch BMI270 IMU
      iio: imu: bmi270: Add scale and sampling frequency to BMI270 IMU
      dt-bindings: iio: imu: bmi270: Add Bosch BMI260
      iio: imu: bmi270: Add support for BMI260

Krzysztof Kozlowski (1):
      interconnect: qcom: msm8937: constify pointer to qcom_icc_node

Kunwu Chan (1):
      firmware: memmap: Constify memmap_ktype

Liao Chen (1):
      counter: ftm-quaddec: Enable module autoloading

Luo Yifan (1):
      eeprom: Fix the cacography in Kconfig

Manivannan Sadhasivam (1):
      bus: mhi: host: pci_generic: Use pcim_iomap_region() to request and map MHI BAR

Marek Vasut (1):
      nvmem: core: Check read_only flag for force_ro in bin_attr_nvmem_write()

Mariel Tinaco (2):
      dt-bindings: iio: dac: add docs for ad8460
      iio: dac: support the ad8460 Waveform DAC

Matteo Martelli (1):
      iio: pac1921: remove unnecessary explicit casts

Matti Vaittinen (1):
      iio: accel: kx022a: Fix raw read format

Neil Armstrong (4):
      dt-bindings: iio: adc: amlogic,meson-saradc: also allow meson8-saradc to have amlogic,hhi-sysctrl property
      dt-bindings: vendor-prefixes: Add Allegro MicroSystems, Inc
      dt-bindings: iio: magnetometer: document the Allegro MicroSystems ALS31300 3-D Linear Hall Effect Sensor
      iio: magnetometer: add Allegro MicroSystems ALS31300 3-D Linear Hall Effect driver

Nuno Sa (9):
      iio: frequency: adf4371: make use of spi_get_device_match_data()
      iio: frequency: adf4371: drop spi_set_drvdata()
      iio: frequency: adf4371: drop clkin from struct adf4371_state
      iio: frequency: adf4371: make use of dev_err_probe()
      iio: adc: ad7192: properly check spi_get_device_match_data()
      iio: addac: ad74413r: drop reset_gpio from struct ad74413r_state
      iio: addac: ad74413r: use devm_regulator_get_enable_read_voltage()
      iio: addac: ad74413r: simplify with cleanup.h
      iio: adc: ad7923: Fix buffer overflow for tx_buf and ring_xfer

Philipp Stanner (1):
      counter: intel-qep: Replace deprecated PCI functions

Ramona Alexandra Nechita (3):
      dt-bindings: iio: adc: add ad7779 doc
      Documentation: ABI: added filter mode doc in sysfs-bus-iio
      drivers: iio: adc: add support for ad777x family

Raviteja Laggyshetty (6):
      interconnect: qcom: icc-rpmh: probe defer incase of missing QoS clock dependency
      interconnect: qcom: icc-rpmh: rename qos_clks_required flag
      dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in QCS8300 SoC
      dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in QCS615 SoC
      interconnect: qcom: add QCS615 interconnect provider driver
      interconnect: qcom: add QCS8300 interconnect provider driver

Ricardo Ribalda (5):
      iio: hid-sensors: Add proximity and attention IDs
      iio: hid-sensors-prox: Factor-in hid_sensor_push_data
      iio: Add channel type for attention
      iio: hid-sensors-prox: Make proximity channel indexed
      iio: hid-sensor-prox: Add support for more channels

Rob Herring (Arm) (2):
      interconnect: Use of_property_present() for non-boolean properties
      misc: atmel-ssc: Use of_property_present() for non-boolean properties

Shen Jianping (2):
      dt-bindings: iio: imu: smi240: add Bosch smi240
      iio: imu: smi240: add driver

Shen Lichuan (2):
      nvmem: Correct some typos in comments
      nvmem: imx-iim: Convert comma to semicolon

Shreeya Patel (1):
      iio: light: ltrf216a: Document device name for compatible

Stanislav Jakubek (2):
      dt-bindings: nvmem: sprd,ums312-efuse: convert to YAML
      dt-bindings: nvmem: sprd,sc2731-efuse: convert to YAML

Tarang Raval (1):
      iio: imu: bmi323: remove redundant register definition

Tomas Winkler (1):
      MAINTAINERS: change mei driver maintainer

Trevor Gamblin (3):
      dt-bindings: iio: adc: add AD762x/AD796x ADCs
      iio: adc: ad7625: add driver
      docs: iio: new docs for ad7625 driver

Uwe Kleine-König (15):
      pwm: Add more locking
      pwm: New abstraction for PWM waveforms
      pwm: Provide new consumer API functions for waveforms
      pwm: Add tracing for waveform callbacks
      pwm: axi-pwmgen: Implementation of the waveform callbacks
      pwm: stm32: Implementation of the waveform callbacks
      pwm: Reorder symbols in core.c
      pwm: Add kernel doc for members added to pwm_ops recently
      pwm: stm32: Fix error checking for a regmap_read() call
      iio: adc: ti-ads1119: Drop explicit initialization of struct i2c_device_id::driver_data to 0
      iio: Switch back to struct platform_driver::remove()
      interconnect: Switch back to struct platform_driver::remove()
      char: Switch back to struct platform_driver::remove()
      fpga: Switch back to struct platform_driver::remove()
      firmware: Switch back to struct platform_driver::remove()

Vasileios Amoiridis (23):
      iio: pressure: bmp280: Use bulk read for humidity calibration data
      iio: pressure: bmp280: Add support for bmp280 soft reset
      iio: pressure: bmp280: Remove config error check for IIR filter updates
      iio: pressure: bmp280: Use unsigned type for raw values
      iio: pressure: bmp280: Use char instead of s32 for data buffer
      uio: uio_dmem_genirq: Make use of irq_get_trigger_type()
      uio: uio_pdrv_genirq: Make use of irq_get_trigger_type()
      iio: light: rpr0521: Use generic iio_pollfunc_store_time()
      iio: pressure: bmp280: Use sleep and forced mode for oneshot captures
      dt-bindings: iio: pressure: bmp085: Add interrupts for BMP3xx and BMP5xx devices
      iio: pressure: bmp280: Add data ready trigger support
      iio: pressure: bmp280: Move bmp085 interrupt to new configuration
      iio: chemical: bme680: Add missing regmap.h include
      iio: chemical: bme680: optimize startup time
      iio: chemical: bme680: avoid using camel case
      iio: chemical: bme680: move to fsleep()
      iio: chemical: bme680: Fix indentation and unnecessary spaces
      iio: chemical: bme680: generalize read_*() functions
      iio: chemical: bme680: use s16 variable for temp value to avoid casting
      iio: chemical: bme680: refactorize set_mode() mode
      iio: chemical: bme680: Add SCALE and RAW channels
      iio: chemical: bme680: Add triggered buffer support
      iio: chemical: bme680: Add support for preheat current

WangYuli (1):
      iio: accel: adxl355: Fix typo "accelaration"

Wedson Almeida Filho (2):
      rust: introduce `InPlaceModule`
      rust: add `dev_*` print macros.

Yan Zhen (1):
      bus: mhi: host: Fix typos in the comments

Yang Li (1):
      iio: imu: bmi270: Remove duplicated include in bmi270_i2c.c

Yang Yingliang (1):
      iio: backend: fix wrong pointer passed to IS_ERR()

Yo-Jung (Leo) Lin (2):
      iio: pressure: bmp280: Fix uninitialized variable
      iio: gyro: list adis16137 in Kconfig description

Yu Jiaoliang (1):
      iio: adc: Fix typos in comments across various files

Zeng Heng (1):
      goldfish: Fix unused const variable 'goldfish_pipe_acpi_match'

Zhu Jun (1):
      misc: isl29020: Fix the wrong format specifier

Zicheng Qu (4):
      ad7780: fix division by zero in ad7780_write_raw()
      iio: gts: Fix uninitialized symbol 'ret'
      iio: gts: fix infinite loop for gain_to_scaletables()
      iio: Fix fwnode_handle in __fwnode_iio_channel_get_by_name()

zhang jiao (1):
      iio: event_monitor: Fix missing free in main

 Documentation/ABI/testing/sysfs-bus-iio            |   32 +
 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130 |   46 -
 Documentation/devicetree/bindings/iio/adc/adc.yaml |    4 +
 .../devicetree/bindings/iio/adc/adi,ad7173.yaml    |    3 +
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    |  120 ++
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |  199 +-
 .../devicetree/bindings/iio/adc/adi,ad7625.yaml    |  176 ++
 .../devicetree/bindings/iio/adc/adi,ad7779.yaml    |  110 ++
 .../bindings/iio/adc/amlogic,meson-saradc.yaml     |    1 +
 .../devicetree/bindings/iio/adc/gehc,pmc-adc.yaml  |   86 +
 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   |    9 +-
 .../devicetree/bindings/iio/dac/adi,ad5791.yaml    |   39 +
 .../devicetree/bindings/iio/dac/adi,ad8460.yaml    |  164 ++
 .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   |   69 +-
 .../devicetree/bindings/iio/imu/bosch,bmi270.yaml  |   79 +
 .../devicetree/bindings/iio/imu/bosch,smi240.yaml  |   51 +
 .../bindings/iio/imu/invensense,icm42600.yaml      |    2 +-
 .../bindings/iio/imu/invensense,mpu6050.yaml       |    7 +-
 .../devicetree/bindings/iio/light/ti,opt3001.yaml  |    4 +-
 .../devicetree/bindings/iio/light/veml6030.yaml    |   64 -
 .../bindings/iio/light/vishay,veml6030.yaml        |  107 +
 .../bindings/iio/light/vishay,veml6075.yaml        |   21 +-
 .../iio/magnetometer/allegromicro,als31300.yaml    |   46 +
 .../devicetree/bindings/iio/pressure/bmp085.yaml   |   22 +-
 .../bindings/iio/temperature/ti,tmp006.yaml        |    6 +
 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |    2 +
 .../bindings/interconnect/qcom,qcs615-rpmh.yaml    |   73 +
 .../bindings/interconnect/qcom,qcs8300-rpmh.yaml   |   72 +
 .../bindings/interconnect/qcom,sar2130p-rpmh.yaml  |  117 ++
 .../{fuse => nvmem}/renesas,rcar-efuse.yaml        |   33 +-
 .../bindings/{fuse => nvmem}/renesas,rcar-otp.yaml |   17 +-
 .../devicetree/bindings/nvmem/sc27xx-efuse.txt     |   52 -
 .../bindings/nvmem/sprd,sc2731-efuse.yaml          |   68 +
 .../bindings/nvmem/sprd,ums312-efuse.yaml          |   61 +
 .../devicetree/bindings/nvmem/sprd-efuse.txt       |   39 -
 .../bindings/nvmem/zii,rave-sp-eeprom.txt          |   40 -
 .../bindings/nvmem/zii,rave-sp-eeprom.yaml         |   54 +
 .../bindings/spmi/mtk,spmi-mtk-pmif.yaml           |    1 +
 .../bindings/spmi/qcom,x1e80100-spmi-pmic-arb.yaml |    6 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |    4 +
 Documentation/iio/ad7380.rst                       |   16 +
 Documentation/iio/ad7606.rst                       |  144 ++
 Documentation/iio/ad7625.rst                       |   91 +
 Documentation/iio/bno055.rst                       |    2 +-
 Documentation/iio/index.rst                        |    2 +
 MAINTAINERS                                        |   62 +-
 drivers/android/binder.c                           |   64 +-
 drivers/bus/mhi/host/boot.c                        |    4 +-
 drivers/bus/mhi/host/internal.h                    |    2 +-
 drivers/bus/mhi/host/pci_generic.c                 |    6 +-
 drivers/bus/mhi/host/trace.h                       |   25 +-
 drivers/char/powernv-op-panel.c                    |    2 +-
 drivers/char/sonypi.c                              |    2 +-
 drivers/char/xilinx_hwicap/xilinx_hwicap.c         |    2 +-
 drivers/char/xillybus/xillybus_of.c                |    2 +-
 drivers/comedi/comedi_fops.c                       |   12 +
 drivers/counter/ftm-quaddec.c                      |    1 +
 drivers/counter/intel-qep.c                        |   10 +-
 drivers/counter/stm32-timer-cnt.c                  |   17 +-
 drivers/counter/ti-ecap-capture.c                  |    7 +-
 drivers/firmware/arm_scmi/driver.c                 |    2 +-
 drivers/firmware/arm_scpi.c                        |    2 +-
 drivers/firmware/google/coreboot_table.c           |    2 +-
 drivers/firmware/imx/imx-dsp.c                     |    2 +-
 drivers/firmware/memmap.c                          |    2 +-
 drivers/firmware/microchip/mpfs-auto-update.c      |    2 +-
 drivers/firmware/mtk-adsp-ipc.c                    |    9 +-
 drivers/firmware/qemu_fw_cfg.c                     |    2 +-
 drivers/firmware/raspberrypi.c                     |    2 +-
 drivers/firmware/stratix10-rsu.c                   |    2 +-
 drivers/firmware/stratix10-svc.c                   |    2 +-
 drivers/firmware/xilinx/zynqmp.c                   |    2 +-
 drivers/fpga/altera-fpga2sdram.c                   |    2 +-
 drivers/fpga/altera-freeze-bridge.c                |    2 +-
 drivers/fpga/altera-hps2fpga.c                     |    2 +-
 drivers/fpga/dfl-afu-main.c                        |    8 +-
 drivers/fpga/dfl-fme-br.c                          |    8 +-
 drivers/fpga/dfl-fme-main.c                        |    8 +-
 drivers/fpga/dfl-fme-region.c                      |    8 +-
 drivers/fpga/intel-m10-bmc-sec-update.c            |    2 +-
 drivers/fpga/of-fpga-region.c                      |    2 +-
 drivers/fpga/socfpga-a10.c                         |    2 +-
 drivers/fpga/stratix10-soc.c                       |    2 +-
 drivers/fpga/xilinx-pr-decoupler.c                 |    2 +-
 drivers/fpga/zynq-fpga.c                           |    2 +-
 drivers/greybus/interface.c                        |    2 +-
 drivers/iio/accel/adxl355_core.c                   |    2 +-
 drivers/iio/accel/adxl367.c                        |    2 +-
 drivers/iio/accel/adxl372.c                        |    2 +-
 drivers/iio/accel/adxl380.c                        |   11 +-
 drivers/iio/accel/bma180.c                         |    3 +-
 drivers/iio/accel/bma220_spi.c                     |    1 +
 drivers/iio/accel/bma400_core.c                    |    4 +-
 drivers/iio/accel/bmc150-accel-core.c              |    2 +-
 drivers/iio/accel/bmc150-accel.h                   |    3 +-
 drivers/iio/accel/fxls8962af-core.c                |    8 +-
 drivers/iio/accel/hid-sensor-accel-3d.c            |    9 +-
 drivers/iio/accel/kionix-kx022a.c                  |    5 +-
 drivers/iio/accel/kxcjk-1013.c                     |  442 ++---
 drivers/iio/accel/kxsd9.c                          |    3 +-
 drivers/iio/accel/mma7455_core.c                   |    3 +-
 drivers/iio/accel/mma8452.c                        |    5 +-
 drivers/iio/accel/mma9551.c                        |   27 +-
 drivers/iio/accel/mma9553.c                        |   46 +-
 drivers/iio/accel/msa311.c                         |    3 +-
 drivers/iio/accel/mxc4005.c                        |    3 +-
 drivers/iio/accel/sca3000.c                        |    6 +-
 drivers/iio/accel/stk8312.c                        |    3 +-
 drivers/iio/accel/stk8ba50.c                       |    3 +-
 drivers/iio/adc/Kconfig                            |   43 +-
 drivers/iio/adc/Makefile                           |    3 +
 drivers/iio/adc/ab8500-gpadc.c                     |    2 +-
 drivers/iio/adc/ad4000.c                           |    6 +-
 drivers/iio/adc/ad7091r-base.c                     |    3 +-
 drivers/iio/adc/ad7091r-base.h                     |    2 +-
 drivers/iio/adc/ad7173.c                           |   38 +-
 drivers/iio/adc/ad7192.c                           |    3 +
 drivers/iio/adc/ad7266.c                           |    2 +-
 drivers/iio/adc/ad7280a.c                          |   14 +-
 drivers/iio/adc/ad7291.c                           |    2 +-
 drivers/iio/adc/ad7380.c                           |  178 +-
 drivers/iio/adc/ad7606.c                           | 1056 ++++++++--
 drivers/iio/adc/ad7606.h                           |  134 +-
 drivers/iio/adc/ad7606_par.c                       |  133 +-
 drivers/iio/adc/ad7606_spi.c                       |  195 +-
 drivers/iio/adc/ad7625.c                           |  684 +++++++
 drivers/iio/adc/ad7779.c                           |  914 +++++++++
 drivers/iio/adc/ad7780.c                           |    2 +-
 drivers/iio/adc/ad7791.c                           |    4 +-
 drivers/iio/adc/ad7793.c                           |    2 +-
 drivers/iio/adc/ad7887.c                           |    4 +-
 drivers/iio/adc/ad7923.c                           |    4 +-
 drivers/iio/adc/ad7944.c                           |    4 +-
 drivers/iio/adc/ad799x.c                           |    2 +-
 drivers/iio/adc/ad_sigma_delta.c                   |    4 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 |    2 +-
 drivers/iio/adc/at91_adc.c                         |    2 +-
 drivers/iio/adc/axp20x_adc.c                       |   62 +-
 drivers/iio/adc/axp288_adc.c                       |    2 +-
 drivers/iio/adc/bcm_iproc_adc.c                    |    8 +-
 drivers/iio/adc/da9150-gpadc.c                     |   26 +-
 drivers/iio/adc/dln2-adc.c                         |    2 +-
 drivers/iio/adc/ep93xx_adc.c                       |    2 +-
 drivers/iio/adc/exynos_adc.c                       |    2 +-
 drivers/iio/adc/gehc-pmc-adc.c                     |  228 +++
 drivers/iio/adc/hi8435.c                           |    2 +-
 drivers/iio/adc/imx8qxp-adc.c                      |    2 +-
 drivers/iio/adc/imx93_adc.c                        |    2 +-
 drivers/iio/adc/intel_mrfld_adc.c                  |    2 +-
 drivers/iio/adc/lp8788_adc.c                       |   18 +-
 drivers/iio/adc/ltc2497-core.c                     |   15 +-
 drivers/iio/adc/max1363.c                          |    5 +-
 drivers/iio/adc/max34408.c                         |    2 +-
 drivers/iio/adc/meson_saradc.c                     |    2 +-
 drivers/iio/adc/mp2629_adc.c                       |    4 +-
 drivers/iio/adc/mt6360-adc.c                       |    2 +-
 drivers/iio/adc/mxs-lradc-adc.c                    |    6 +-
 drivers/iio/adc/npcm_adc.c                         |    2 +-
 drivers/iio/adc/pac1921.c                          |   48 +-
 drivers/iio/adc/pac1934.c                          |    2 +-
 drivers/iio/adc/palmas_gpadc.c                     |    4 +-
 drivers/iio/adc/qcom-pm8xxx-xoadc.c                |   10 +-
 drivers/iio/adc/qcom-spmi-adc5.c                   |    4 +-
 drivers/iio/adc/qcom-spmi-vadc.c                   |    7 +-
 drivers/iio/adc/rcar-gyroadc.c                     |    2 +-
 drivers/iio/adc/rn5t618-adc.c                      |    2 +-
 drivers/iio/adc/stm32-adc-core.c                   |    2 +-
 drivers/iio/adc/stm32-adc.c                        |    2 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |    2 +-
 drivers/iio/adc/stm32-dfsdm-core.c                 |    2 +-
 drivers/iio/adc/sun20i-gpadc-iio.c                 |    7 +-
 drivers/iio/adc/sun4i-gpadc-iio.c                  |    9 +-
 drivers/iio/adc/ti-ads1015.c                       |    5 +-
 drivers/iio/adc/ti-ads1119.c                       |    2 +-
 drivers/iio/adc/ti-ads1298.c                       |    2 +-
 drivers/iio/adc/ti_am335x_adc.c                    |   10 +-
 drivers/iio/adc/twl4030-madc.c                     |    4 +-
 drivers/iio/adc/twl6030-gpadc.c                    |    2 +-
 drivers/iio/adc/vf610_adc.c                        |    2 +-
 drivers/iio/adc/xilinx-ams.c                       |    2 +-
 drivers/iio/adc/xilinx-xadc-events.c               |    4 +-
 drivers/iio/adc/xilinx-xadc.h                      |    2 +-
 drivers/iio/addac/ad74115.c                        |   18 +-
 drivers/iio/addac/ad74413r.c                       |  102 +-
 drivers/iio/cdc/ad7150.c                           |    2 +-
 drivers/iio/chemical/Kconfig                       |    2 +
 drivers/iio/chemical/bme680.h                      |   11 +-
 drivers/iio/chemical/bme680_core.c                 |  364 +++-
 .../iio/common/inv_sensors/inv_sensors_timestamp.c |    4 +
 drivers/iio/common/st_sensors/st_sensors_trigger.c |    2 +-
 drivers/iio/dac/Kconfig                            |   32 +
 drivers/iio/dac/Makefile                           |    3 +
 drivers/iio/dac/ad3552r-common.c                   |  249 +++
 drivers/iio/dac/ad3552r-hs.c                       |  529 +++++
 drivers/iio/dac/ad3552r-hs.h                       |   19 +
 drivers/iio/dac/ad3552r.c                          |  553 +-----
 drivers/iio/dac/ad3552r.h                          |  228 +++
 drivers/iio/dac/ad5380.c                           |   85 +-
 drivers/iio/dac/ad5421.c                           |    2 +-
 drivers/iio/dac/ad5446.c                           |   77 +-
 drivers/iio/dac/ad5504.c                           |   61 +-
 drivers/iio/dac/ad5624r.h                          |    1 -
 drivers/iio/dac/ad5624r_spi.c                      |   69 +-
 drivers/iio/dac/ad5755.c                           |   11 +-
 drivers/iio/dac/ad5761.c                           |  109 +-
 drivers/iio/dac/ad5770r.c                          |   44 +-
 drivers/iio/dac/ad5791.c                           |  205 +-
 drivers/iio/dac/ad8460.c                           |  951 +++++++++
 drivers/iio/dac/adi-axi-dac.c                      |  449 ++++-
 drivers/iio/dac/dpot-dac.c                         |    2 +-
 drivers/iio/dac/lpc18xx_dac.c                      |    6 +-
 drivers/iio/dac/m62332.c                           |    2 +-
 drivers/iio/dac/max517.c                           |    2 +-
 drivers/iio/dac/stm32-dac-core.c                   |    2 +-
 drivers/iio/dac/stm32-dac.c                        |    2 +-
 drivers/iio/dac/vf610_dac.c                        |    2 +-
 drivers/iio/dummy/iio_simple_dummy.h               |    2 +-
 drivers/iio/dummy/iio_simple_dummy_events.c        |   32 +-
 drivers/iio/frequency/ad9523.c                     |    2 +-
 drivers/iio/frequency/adf4350.c                    |    2 +-
 drivers/iio/frequency/adf4371.c                    |   63 +-
 drivers/iio/gyro/Kconfig                           |    2 +-
 drivers/iio/gyro/bmg160_core.c                     |   19 +-
 drivers/iio/gyro/bmg160_i2c.c                      |    6 +-
 drivers/iio/gyro/fxas21002c_core.c                 |    3 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |    8 +-
 drivers/iio/gyro/mpu3050-core.c                    |    2 +-
 drivers/iio/humidity/hid-sensor-humidity.c         |    4 +-
 drivers/iio/humidity/hts221_buffer.c               |    3 +-
 drivers/iio/imu/Kconfig                            |   15 +
 drivers/iio/imu/Makefile                           |    3 +
 drivers/iio/imu/bmi160/bmi160_core.c               |   11 +-
 drivers/iio/imu/bmi270/Kconfig                     |   33 +
 drivers/iio/imu/bmi270/Makefile                    |    7 +
 drivers/iio/imu/bmi270/bmi270.h                    |   38 +
 drivers/iio/imu/bmi270/bmi270_core.c               |  734 +++++++
 drivers/iio/imu/bmi270/bmi270_i2c.c                |   66 +
 drivers/iio/imu/bmi270/bmi270_spi.c                |   92 +
 drivers/iio/imu/bmi323/bmi323.h                    |    1 -
 drivers/iio/imu/bmi323/bmi323_core.c               |   18 +-
 drivers/iio/imu/fxos8700_core.c                    |    1 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |    2 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |   10 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |    3 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c    |   17 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c    |   17 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c         |   11 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   38 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |   10 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |    4 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |   10 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |    1 -
 drivers/iio/imu/kmx61.c                            |   27 +-
 drivers/iio/imu/smi240.c                           |  621 ++++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |    2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |   22 +-
 drivers/iio/industrialio-acpi.c                    |   48 +-
 drivers/iio/industrialio-backend.c                 |   82 +-
 drivers/iio/industrialio-core.c                    |    3 +-
 drivers/iio/industrialio-gts-helper.c              |    4 +-
 drivers/iio/inkern.c                               |    9 +-
 drivers/iio/light/Kconfig                          |   18 +-
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/adux1020.c                       |   12 +-
 drivers/iio/light/al3010.c                         |   11 +-
 drivers/iio/light/apds9300.c                       |   20 +-
 drivers/iio/light/apds9306.c                       |    7 +-
 drivers/iio/light/apds9960.c                       |   10 +-
 drivers/iio/light/bh1745.c                         |   50 +-
 drivers/iio/light/cm32181.c                        |    3 +-
 drivers/iio/light/cm3605.c                         |    2 +-
 drivers/iio/light/cm36651.c                        |    2 +-
 drivers/iio/light/gp2ap002.c                       |    2 +-
 drivers/iio/light/gp2ap020a00f.c                   |    2 +-
 drivers/iio/light/hid-sensor-als.c                 |    8 +-
 drivers/iio/light/hid-sensor-prox.c                |  199 +-
 drivers/iio/light/iqs621-als.c                     |    2 +-
 drivers/iio/light/isl29018.c                       |   38 +-
 drivers/iio/light/lm3533-als.c                     |    8 +-
 drivers/iio/light/ltr390.c                         |  362 +++-
 drivers/iio/light/ltr501.c                         |   35 +-
 drivers/iio/light/ltrf216a.c                       |    1 +
 drivers/iio/light/max44009.c                       |    2 +-
 drivers/iio/light/opt3001.c                        |  191 +-
 drivers/iio/light/rpr0521.c                        |   14 +-
 drivers/iio/light/st_uvis25_core.c                 |    3 +-
 drivers/iio/light/stk3310.c                        |    5 +-
 drivers/iio/light/tcs3472.c                        |    2 +-
 drivers/iio/light/tsl2563.c                        |    2 +-
 drivers/iio/light/tsl2591.c                        |    2 +-
 drivers/iio/light/tsl2772.c                        |    6 +-
 drivers/iio/light/us5182d.c                        |    2 +-
 drivers/iio/light/vcnl4000.c                       |    5 +-
 drivers/iio/light/veml3235.c                       |  495 +++++
 drivers/iio/light/veml6030.c                       |  537 +++--
 drivers/iio/light/veml6070.c                       |  203 +-
 drivers/iio/light/vl6180.c                         |  253 ++-
 drivers/iio/magnetometer/Kconfig                   |   13 +
 drivers/iio/magnetometer/Makefile                  |    1 +
 drivers/iio/magnetometer/ak8974.c                  |    2 +-
 drivers/iio/magnetometer/als31300.c                |  494 +++++
 drivers/iio/magnetometer/bmc150_magn.c             |   15 -
 drivers/iio/magnetometer/bmc150_magn_i2c.c         |    9 -
 drivers/iio/magnetometer/bmc150_magn_spi.c         |    9 -
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      |    6 +-
 drivers/iio/orientation/hid-sensor-incl-3d.c       |    8 +-
 drivers/iio/orientation/hid-sensor-rotation.c      |    8 +-
 .../iio/position/hid-sensor-custom-intel-hinge.c   |    8 +-
 drivers/iio/position/iqs624-pos.c                  |    2 +-
 drivers/iio/pressure/bmp280-core.c                 |  713 +++++--
 drivers/iio/pressure/bmp280-i2c.c                  |    4 +-
 drivers/iio/pressure/bmp280-spi.c                  |    4 +-
 drivers/iio/pressure/bmp280.h                      |   56 +-
 drivers/iio/pressure/hid-sensor-press.c            |    8 +-
 drivers/iio/pressure/rohm-bm1390.c                 |    3 -
 drivers/iio/proximity/aw96103.c                    |    2 +-
 drivers/iio/proximity/cros_ec_mkbp_proximity.c     |    4 +-
 drivers/iio/proximity/hx9023s.c                    |    4 +-
 drivers/iio/proximity/irsd200.c                    |    5 +-
 drivers/iio/proximity/srf04.c                      |    2 +-
 drivers/iio/proximity/sx9324.c                     |   20 +
 drivers/iio/proximity/sx9360.c                     |    1 -
 drivers/iio/proximity/sx9500.c                     |    6 +-
 drivers/iio/proximity/sx_common.c                  |   23 +-
 drivers/iio/proximity/sx_common.h                  |    6 +-
 drivers/iio/proximity/vcnl3020.c                   |    2 +-
 drivers/iio/proximity/vl53l0x-i2c.c                |  174 +-
 drivers/iio/temperature/Kconfig                    |    2 +
 drivers/iio/temperature/hid-sensor-temperature.c   |    4 +-
 drivers/iio/temperature/mcp9600.c                  |    2 +-
 drivers/iio/temperature/tmp006.c                   |  134 +-
 drivers/iio/temperature/tmp007.c                   |    2 +-
 drivers/iio/trigger/iio-trig-interrupt.c           |    2 +-
 drivers/iio/trigger/stm32-timer-trigger.c          |    2 +-
 drivers/interconnect/core.c                        |    4 +-
 drivers/interconnect/imx/imx8mm.c                  |    2 +-
 drivers/interconnect/imx/imx8mn.c                  |    2 +-
 drivers/interconnect/imx/imx8mp.c                  |    2 +-
 drivers/interconnect/imx/imx8mq.c                  |    2 +-
 drivers/interconnect/mediatek/mt8183.c             |    2 +-
 drivers/interconnect/mediatek/mt8195.c             |    2 +-
 drivers/interconnect/qcom/Kconfig                  |   29 +
 drivers/interconnect/qcom/Makefile                 |    6 +
 drivers/interconnect/qcom/icc-rpmh.c               |    5 +-
 drivers/interconnect/qcom/icc-rpmh.h               |    2 +-
 drivers/interconnect/qcom/msm8909.c                |    2 +-
 drivers/interconnect/qcom/msm8916.c                |    2 +-
 drivers/interconnect/qcom/msm8937.c                |   10 +-
 drivers/interconnect/qcom/msm8939.c                |    2 +-
 drivers/interconnect/qcom/msm8953.c                |    2 +-
 drivers/interconnect/qcom/msm8974.c                |    2 +-
 drivers/interconnect/qcom/msm8976.c                |    2 +-
 drivers/interconnect/qcom/msm8996.c                |    2 +-
 drivers/interconnect/qcom/osm-l3.c                 |    2 +-
 drivers/interconnect/qcom/qcm2290.c                |    2 +-
 drivers/interconnect/qcom/qcs404.c                 |    2 +-
 drivers/interconnect/qcom/qcs615.c                 | 1563 +++++++++++++++
 drivers/interconnect/qcom/qcs615.h                 |  128 ++
 drivers/interconnect/qcom/qcs8300.c                | 2088 ++++++++++++++++++++
 drivers/interconnect/qcom/qcs8300.h                |  177 ++
 drivers/interconnect/qcom/qdu1000.c                |    2 +-
 drivers/interconnect/qcom/sa8775p.c                |    2 +-
 drivers/interconnect/qcom/sar2130p.c               | 1930 ++++++++++++++++++
 drivers/interconnect/qcom/sc7180.c                 |    2 +-
 drivers/interconnect/qcom/sc7280.c                 |    6 +-
 drivers/interconnect/qcom/sc8180x.c                |    2 +-
 drivers/interconnect/qcom/sc8280xp.c               |    2 +-
 drivers/interconnect/qcom/sdm660.c                 |    2 +-
 drivers/interconnect/qcom/sdm670.c                 |    2 +-
 drivers/interconnect/qcom/sdm845.c                 |    2 +-
 drivers/interconnect/qcom/sdx55.c                  |    2 +-
 drivers/interconnect/qcom/sdx65.c                  |    2 +-
 drivers/interconnect/qcom/sdx75.c                  |    2 +-
 drivers/interconnect/qcom/sm6115.c                 |    2 +-
 drivers/interconnect/qcom/sm6350.c                 |    2 +-
 drivers/interconnect/qcom/sm7150.c                 |    2 +-
 drivers/interconnect/qcom/sm8150.c                 |    2 +-
 drivers/interconnect/qcom/sm8250.c                 |    2 +-
 drivers/interconnect/qcom/sm8350.c                 |    2 +-
 drivers/interconnect/qcom/sm8450.c                 |    2 +-
 drivers/interconnect/qcom/sm8550.c                 |    2 +-
 drivers/interconnect/qcom/sm8650.c                 |    2 +-
 drivers/interconnect/qcom/smd-rpm.c                |    2 +-
 drivers/interconnect/qcom/x1e80100.c               |    2 +-
 drivers/interconnect/samsung/exynos.c              |    2 +-
 drivers/misc/Kconfig                               |    1 -
 drivers/misc/Makefile                              |    1 -
 drivers/misc/apds990x.c                            |   12 +-
 drivers/misc/atmel-ssc.c                           |    4 +-
 drivers/misc/cardreader/alcor_pci.c                |    2 -
 drivers/misc/cardreader/rtsx_usb.c                 |    6 +-
 drivers/misc/eeprom/Kconfig                        |    4 +-
 drivers/misc/eeprom/eeprom_93xx46.c                |    2 +-
 drivers/misc/isl29020.c                            |    2 +-
 drivers/misc/keba/Kconfig                          |   13 +
 drivers/misc/keba/Makefile                         |    1 +
 drivers/misc/keba/cp500.c                          |  558 +++++-
 drivers/misc/keba/lan9252.c                        |  359 ++++
 drivers/misc/mei/bus.c                             |    2 +-
 drivers/misc/mei/platform-vsc.c                    |    2 -
 drivers/misc/mei/vsc-fw-loader.c                   |   26 +-
 drivers/misc/mei/vsc-tp.c                          |    2 -
 drivers/misc/rpmb-core.c                           |    9 +-
 drivers/misc/ti-st/Kconfig                         |   19 -
 drivers/misc/ti-st/Makefile                        |    7 -
 drivers/misc/ti-st/st_core.c                       |  918 ---------
 drivers/misc/ti-st/st_kim.c                        |  839 --------
 drivers/misc/ti-st/st_ll.c                         |  156 --
 drivers/nvmem/Kconfig                              |   11 +
 drivers/nvmem/Makefile                             |    2 +
 drivers/nvmem/brcm_nvram.c                         |    2 +-
 drivers/nvmem/core.c                               |    6 +-
 drivers/nvmem/imx-iim.c                            |   10 +-
 drivers/nvmem/lpc18xx_otp.c                        |    2 +-
 drivers/nvmem/microchip-otpc.c                     |    2 +-
 drivers/nvmem/rcar-efuse.c                         |  142 ++
 drivers/peci/controller/peci-npcm.c                |    2 +-
 drivers/platform/goldfish/goldfish_pipe.c          |    3 +-
 drivers/pwm/core.c                                 |  857 ++++++--
 drivers/pwm/pwm-axi-pwmgen.c                       |  154 +-
 drivers/pwm/pwm-stm32.c                            |  612 +++---
 drivers/spmi/spmi-pmic-arb.c                       |    3 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |    6 +-
 drivers/uio/uio_dmem_genirq.c                      |    5 +-
 drivers/uio/uio_pdrv_genirq.c                      |    5 +-
 include/dt-bindings/iio/adc/gehc,pmc-adc.h         |   10 +
 .../dt-bindings/interconnect/qcom,qcs615-rpmh.h    |  136 ++
 .../dt-bindings/interconnect/qcom,qcs8300-rpmh.h   |  189 ++
 .../dt-bindings/interconnect/qcom,sar2130p-rpmh.h  |  137 ++
 include/linux/alcor_pci.h                          |    1 +
 include/linux/hid-sensor-ids.h                     |    2 +
 include/linux/iio/backend.h                        |   17 +
 include/linux/iio/driver.h                         |    5 +-
 include/linux/iio/events.h                         |   31 +-
 include/linux/iio/iio-opaque.h                     |    2 +-
 include/linux/iio/iio.h                            |   36 +-
 include/linux/misc/keba.h                          |   47 +
 include/linux/pwm.h                                |   60 +-
 include/linux/rtsx_common.h                        |    1 -
 include/linux/rtsx_usb.h                           |    4 +
 include/linux/types.h                              |    3 +-
 include/trace/events/pwm.h                         |  134 +-
 include/uapi/linux/iio/types.h                     |    1 +
 include/uapi/linux/types.h                         |    1 +
 rust/bindings/bindings_helper.h                    |    1 +
 rust/kernel/device.rs                              |  319 ++-
 rust/kernel/lib.rs                                 |   24 +
 rust/kernel/miscdevice.rs                          |  256 +++
 rust/kernel/prelude.rs                             |    2 +
 rust/kernel/types.rs                               |   16 +
 rust/macros/module.rs                              |   28 +-
 scripts/tags.sh                                    |   40 +-
 tools/iio/iio_event_monitor.c                      |    3 +
 .../selftests/filesystems/binderfs/binderfs_test.c |    1 -
 454 files changed, 24259 insertions(+), 5860 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/gehc,pmc-adc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/light/veml6030.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/allegromicro,als31300.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs8300-rpmh.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sar2130p-rpmh.yaml
 rename Documentation/devicetree/bindings/{fuse => nvmem}/renesas,rcar-efuse.yaml (54%)
 rename Documentation/devicetree/bindings/{fuse => nvmem}/renesas,rcar-otp.yaml (60%)
 delete mode 100644 Documentation/devicetree/bindings/nvmem/sc27xx-efuse.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/sprd,sc2731-efuse.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/sprd,ums312-efuse.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/sprd-efuse.txt
 delete mode 100644 Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.yaml
 create mode 100644 Documentation/iio/ad7606.rst
 create mode 100644 Documentation/iio/ad7625.rst
 create mode 100644 drivers/iio/adc/ad7625.c
 create mode 100644 drivers/iio/adc/ad7779.c
 create mode 100644 drivers/iio/adc/gehc-pmc-adc.c
 create mode 100644 drivers/iio/dac/ad3552r-common.c
 create mode 100644 drivers/iio/dac/ad3552r-hs.c
 create mode 100644 drivers/iio/dac/ad3552r-hs.h
 create mode 100644 drivers/iio/dac/ad3552r.h
 create mode 100644 drivers/iio/dac/ad8460.c
 create mode 100644 drivers/iio/imu/bmi270/Kconfig
 create mode 100644 drivers/iio/imu/bmi270/Makefile
 create mode 100644 drivers/iio/imu/bmi270/bmi270.h
 create mode 100644 drivers/iio/imu/bmi270/bmi270_core.c
 create mode 100644 drivers/iio/imu/bmi270/bmi270_i2c.c
 create mode 100644 drivers/iio/imu/bmi270/bmi270_spi.c
 create mode 100644 drivers/iio/imu/smi240.c
 create mode 100644 drivers/iio/light/veml3235.c
 create mode 100644 drivers/iio/magnetometer/als31300.c
 create mode 100644 drivers/interconnect/qcom/qcs615.c
 create mode 100644 drivers/interconnect/qcom/qcs615.h
 create mode 100644 drivers/interconnect/qcom/qcs8300.c
 create mode 100644 drivers/interconnect/qcom/qcs8300.h
 create mode 100644 drivers/interconnect/qcom/sar2130p.c
 create mode 100644 drivers/misc/keba/lan9252.c
 delete mode 100644 drivers/misc/ti-st/Kconfig
 delete mode 100644 drivers/misc/ti-st/Makefile
 delete mode 100644 drivers/misc/ti-st/st_core.c
 delete mode 100644 drivers/misc/ti-st/st_kim.c
 delete mode 100644 drivers/misc/ti-st/st_ll.c
 create mode 100644 drivers/nvmem/rcar-efuse.c
 create mode 100644 include/dt-bindings/iio/adc/gehc,pmc-adc.h
 create mode 100644 include/dt-bindings/interconnect/qcom,qcs615-rpmh.h
 create mode 100644 include/dt-bindings/interconnect/qcom,qcs8300-rpmh.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sar2130p-rpmh.h
 create mode 100644 rust/kernel/miscdevice.rs

