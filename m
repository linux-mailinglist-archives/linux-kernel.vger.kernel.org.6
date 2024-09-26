Return-Path: <linux-kernel+bounces-340312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A98F498716F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A8F1F25163
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3601ACE0B;
	Thu, 26 Sep 2024 10:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PvRg7W9F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764EC1ACDE0
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727346242; cv=none; b=O7/Hb+duI0lVMYJLeCJT6cv/EFIPGYQd8SqD8U6pEZiZsUQJNu/IuILWBt/eTjJs+8ls/uDu6zDLtyPxo4tDz/OsC6PPLk6KTlPf9mL9q3dNVVKjtdPhorJ5ppfXK8EfPCOoWLh7KS5tjk/xVP1pPmlW763EfTwov/E/v8xMT+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727346242; c=relaxed/simple;
	bh=ORlYYrcltJ04j+ou14zKrsfNmn2nDqkE9WkxlighPVc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fPuddat8oFIK+KKdVpCKdqZC8LcHZNAo79ynfTLqJOl9ZxOYWjlX/fArsZ1piYL3d774cPyAWxHJ4r4P9H8iVaQLlbOY6ItGAYn5A8g5+AaXyShyRE2vyIlTWC7hzj9hcPuEVYevQc0THF0tOk4LwV+Kf9INqlEK2L1Jhw1c1AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PvRg7W9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B230AC4CEC5;
	Thu, 26 Sep 2024 10:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727346242;
	bh=ORlYYrcltJ04j+ou14zKrsfNmn2nDqkE9WkxlighPVc=;
	h=Date:From:To:Cc:Subject:From;
	b=PvRg7W9FAzztLW9tkU3qNkKQN3wCURpkl6aSqgwU03tlGImxZoNv1ERacAzf/Ksfs
	 +9b+eFnEIDvjLXuln0gkhg858Gc22vVWXFnTmGfsCLg2MBsZukM84K3HQsllNL9/D0
	 7rKl+zn8asdJ8TpggIQ3Ym/EDZyCLGDXXtDmhBv0=
Date: Thu, 26 Sep 2024 12:23:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver updates for 6.12-rc1
Message-ID: <ZvU2LBnU8jwgOY00@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit da3ea35007d0af457a0afc87e84fddaebc4e0b63:

  Linux 6.11-rc7 (2024-09-08 14:50:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.12-rc1

for you to fetch changes up to 0cf7befa3ea2e7284d8ba5b8f45a546865b09edb:

  greybus: gb-beagleplay: Add firmware upload API (2024-09-12 09:04:09 +0200)

----------------------------------------------------------------
Char/Misc and other driver changes for 6.12-rc1

Here is the "big" set of char/misc and other driver subsystem changes
for 6.12-rc1.  Sorry for the delay, conference travel for the past two
weeks has this and my other pull requests showing up real late
in the cycle.

Lots of changes in here, primarily dominated by the usual IIO driver
updates and additions, but there are also small driver subsystem updates
all over the place.  Included in here are:
  - lots and lots of new IIO drivers and updates to existing ones
  - interconnect subsystem updates and new drivers
  - nvmem subsystem updates and new drivers
  - mhi driver updates
  - power supply subsystem updates
  - kobj_type const work for many different small subsystems
  - comedi driver fix
  - coresight subsystem and driver updates
  - fpga subsystem improvements
  - slimbus fixups
  - binder new feature addition for "frozen" notifications
  - lots and lots of other small driver updates and cleanups

All of these have been in linux-next for a long time with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abhash Jha (4):
      iio: light: ltr390: Add configurable gain and resolution
      iio: light: apds9960: Add proximity and gesture offset calibration
      iio: light: ltr390: Add ALS channel and support for gain and resolution
      iio: light: ltr390: Calculate 'counts_per_uvi' dynamically

Adam Skladowski (9):
      dt-bindings: interconnect: qcom: Add Qualcomm MSM8976 NoC
      interconnect: qcom: Add MSM8976 interconnect provider driver
      dt-bindings: interconnect: qcom: Add Qualcomm MSM8937 NoC
      interconnect: qcom: Add MSM8937 interconnect provider driver
      interconnect: qcom: qcs404: Mark AP-owned nodes as such
      interconnect: qcom: qcs404: Add regmaps and more bus descriptions
      dt-bindings: interconnect: qcom: msm8939: Fix example
      interconnect: qcom: msm8953: Add ab_coeff
      dt-bindings: interconnect: qcom: msm8953: Fix 'See also' in description

Alisa-Dariana Roman (4):
      dt-bindings: iio: adc: ad7192: Update clock config
      iio: adc: ad7192: Update clock config
      dt-bindings: iio: adc: ad7192: Add clock provider
      iio: adc: ad7192: Add clock provider

Andreas Klinger (1):
      iio: sgp40: retain documentation in driver

Andy Shevchenko (5):
      iio: proximity: cros_ec_mkbp_proximity: Switch to including mod_devicetable.h for struct of_device_id definition
      iio: accel: bmc150: use fwnode_irq_get_byname()
      iio: accel: bmc150: Improve bmc150_apply_bosc0200_acpi_orientation()
      iio: imu: st_lsm6dsx: Use iio_read_acpi_mount_matrix() helper
      iio: imu: st_lsm6dsx: Remove useless dev_fwnode() calls

Antoniu Miclaus (6):
      ABI: testing: fix admv8818 attr description
      dt-bindings: iio: accel: add ADXL380
      iio: accel: add ADXL380 driver
      docs: iio: add documentation for adxl380 driver
      dt-bindings: iio: adf4377: add adf4378 support
      iio: frequency: adf4377: add adf4378 support

Ayush Singh (3):
      dt-bindings: net: ti,cc1352p7: Add bootloader-backdoor-gpios
      arm64: dts: ti: k3-am625-beagleplay: Add bootloader-backdoor-gpios to cc1352p7
      greybus: gb-beagleplay: Add firmware upload API

Ba Jing (1):
      binder: modify the comment for binder_proc_unlock

Barnabás Czémán (2):
      iio: magnetometer: ak8975: Relax failure on unknown id
      iio: magnetometer: ak8975: Fix reading for ak099xx sensors

Bartosz Golaszewski (3):
      dt-bindings: misc: qcom,fastrpc: increase the max number of iommus
      dt-bindings: misc: qcom,fastrpc: document new domain ID
      iio: dac: ad5449: drop support for platform data

Chanwoo Choi (1):
      Merge tag 'ib-psy-usb-types-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply into extcon-next

Chen Ni (1):
      iio: dac: ti-dac7311: Add check for spi_setup

Chris Morgan (4):
      mfd: axp20x: Add ADC, BAT, and USB cells for AXP717
      iio: adc: axp20x_adc: Add adc_en1 and adc_en2 to axp_data
      dt-bindings: iio: adc: Add AXP717 compatible
      iio: adc: axp20x_adc: add support for AXP717 ADC

Colin Ian King (2):
      iio: pressure: bmp280-core: Make read-only const array conversion_time_max static
      iio: Fix spelling mistake "avaialable" -> "available"

Dan Carpenter (3):
      iio: dac: ltc2664: Fix off by one in ltc2664_channel_config()
      iio: adc: pac1921: add missing error return in probe()
      iio: proximity: hx9023s: Fix error code in hx9023s_property_get()

Danila Tikhonov (2):
      dt-bindings: iio: magnetometer: Add ak09118
      iio: magnetometer: ak8975: Add AK09118 support

David Lechner (23):
      dt-bindings: iio: adc: add AD4695 and similar ADCs
      iio: adc: ad4695: Add driver for AD4695 and similar ADCs
      Documentation: iio: Document ad4695 driver
      iio: dac: mcp4728: rename err to ret in probe function
      iio: dac: mcp4728: use devm_regulator_get_enable_read_voltage()
      iio: dac: mcp4922: use devm_regulator_get_enable_read_voltage()
      iio: dac: mcp4922: drop remove() callback
      iio: adc: mcp3911: use devm_regulator_get_enable_read_voltage()
      iio: backend: spelling: continuous -> continuous
      iio: adc: mcp3564: use devm_regulator_get_enable_read_voltage()
      iio: adc: ti-tsc2046: use devm_regulator_get_enable_read_voltage()
      dt-bindings: iio: ad4695: fix common-mode-channel
      iio: adc: ad4695: implement triggered buffer
      doc: iio: ad4695: document buffered read
      iio: ABI: document calibscale_available attributes
      iio: ABI: sort calibscale attributes
      iio: ABI: add missing calibscale attributes
      iio: ABI: add missing calibbias attributes
      iio: ABI: remove duplicate in_resistance_calibbias
      iio: adc: ad4695: add 2nd regmap for 16-bit registers
      iio: adc: ad4695: implement calibration support
      doc: iio: ad4695: update for calibration support
      iio: ABI: document ad4695 new attributes

Denis Benato (3):
      iio: trigger: allow devices to suspend/resume theirs associated trigger
      iio: bmi323: suspend and resume triggering on relevant pm operations
      iio: bmi323: peripheral in lowest power state on suspend

Detlev Casanova (1):
      dt-bindings: iio: adc: Add rockchip,rk3576-saradc string

Dmitry Baryshkov (3):
      interconnect: qcom: sm8350: drop DISP nodes
      dt-bindings: interconnect: qcom,sm8350: drop DISP nodes
      interconnect: qcom: sm8250: Enable sync_state

Dr. David Alan Gilbert (1):
      cdx: remove unused struct 'cdx_mcdi_copy_buffer'

Dumitru Ceclan (2):
      iio: adc: ad7124: reduce the number of SPI transfers
      iio: adc: ad7124: set initial ADC mode to idle

Fabio Porcedda (1):
      bus: mhi: host: pci_generic: Fix the name for the Telit FE990A

Florian Rommel (1):
      kgdbts: fix hw_access_break_test

Frank Li (3):
      dt-bindings: nvmem: sfp: add ref to nvmem-deprecated-cells.yaml
      dt-bindings: extcon: ptn5150: add child node port
      dt-bindings: extcon: convert extcon-usb-gpio.txt to yaml format

Georgi Djakov (3):
      dt-bindings: interconnect: qcom: Do not require reg for sc8180x virt NoCs
      Merge branch 'icc-misc' into icc-next
      Merge branch 'icc-sm8350' into icc-next

Greg Kroah-Hartman (10):
      Merge 6.11-rc3 into char-misc-next
      Merge 6.11-rc4 into char-misc-next
      Merge tag 'iio-for-6.12a' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-testing
      Merge tag 'coresight-next-v6.12' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/coresight/linux into char-misc-next
      Merge tag 'fpga-for-6.12-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga into char-misc-next
      Merge tag 'mhi-for-v6.12' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/mani/mhi into char-misc-next
      Merge tag 'icc-6.12-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-next
      Merge tag 'iio-for-6.12b' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'extcon-next-for-6.12' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon into char-misc-next
      Merge 6.11-rc7 into char-misc-next

Guillaume Stols (8):
      dt-bindings: iio: adc: adi,ad7606: normalize textwidth
      dt-bindings: iio: adc: adi,ad7606: improve descriptions
      dt-bindings: iio: adc: adi,ad7606: add supply properties
      dt-bindings: iio: adc: adi,ad7606: fix example
      dt-bindings: iio: adc: adi,ad7606: add conditions
      iio: adc: ad7606: fix oversampling gpio array
      iio: adc: ad7606: fix standby gpio state to match the documentation
      iio: adc: ad7606: switch mutexes to guard

Hans de Goede (7):
      power: supply: "usb_type" property may be written to
      power: supply: ucs1002: Adjust ucs1002_set_usb_type() to accept string values
      power: supply: rt9467-charger: Remove "usb_type" property write support
      power: supply: sysfs: Add power_supply_show_enum_with_available() helper
      power: supply: sysfs: Move power_supply_show_enum_with_available() up
      power: supply: Change usb_types from an array into a bitmask
      extcon: Add LC824206XA microUSB switch driver

Hongbo Li (3):
      misc: tsl2550: replace simple_strtoul to kstrtoul
      cxl: Constify struct kobj_type
      uio: Constify struct kobj_type

Ian Abbott (1):
      comedi: ni_*: do not declare unused variable range_ni_E_ao_ext

James Clark (9):
      coresight: Remove unused ETM Perf stubs
      coresight: Clarify comments around the PID of the sink owner
      coresight: Move struct coresight_trace_id_map to common header
      coresight: Expose map arguments in trace ID API
      coresight: Make CPU id map a property of a trace ID map
      coresight: Use per-sink trace ID maps for Perf sessions
      coresight: Remove pending trace ID release mechanism
      coresight: Emit sink ID in the HW_ID packets
      coresight: Make trace ID map spinlock local to the map

Javier Carrasco (13):
      iio: accel: adxl367: Constify struct regmap_bus
      iio: accel: bma400: Constify struct regmap_bus
      iio: accel: bmi088: Constify struct regmap_bus
      iio: adc: ad7091r8: Constify struct regmap_bus
      iio: chemical: bme680: Constify struct regmap_bus
      iio: dac: ltc2688: Constify struct regmap_bus
      iio: imu: bmi323: Constify struct regmap_bus
      iio: imu: bno055: Constify struct regmap_bus
      iio: light: gp2ap002: Constify struct regmap_bus
      iio: pressure: bmp280: Constify struct regmap_bus
      iio: adc: ad7768-1: use device_* to iterate over device child nodes
      coresight: cti: use device_* to iterate over device child nodes
      iio: adc: xilinx-ams: use device_* to iterate over device child nodes

Jie Gan (2):
      Coresight: Set correct cs_mode for TPDM to fix disable issue
      Coresight: Set correct cs_mode for dummy source to fix disable issue

Jonathan Cameron (3):
      Merge tag 'spi-mosi-config' into togreg
      iio: adc: standardize on formatting for id match tables
      Merge remote-tracking branch 'mfd/ib-mfd-for-iio-power-6.12' into togreg

Joshua Felmeden (2):
      dt-bindings: iio: humidity: add ENS210 sensor family
      iio: humidity: Add support for ENS210

Julien Stephan (8):
      docs: iio: new docs for ad7380 driver
      dt-bindings: iio: adc: ad7380: add single-ended compatible parts
      iio: core: add function to retrieve active_scan_mask index
      iio: adc: ad7380: add missing trailing commas
      iio: adc: ad7380: prepare driver for single-ended parts support
      iio: adc: ad7380: add support for single-ended parts
      iio: adc: ad7380: enable sequencer for single-ended parts
      docs: iio: ad7380: add support for single-ended parts

Kaustabh Chakraborty (3):
      iio: light: stk3310: relax chipid check warning
      iio: light: stk3310: add support for stk3013
      dt-bindings: iio: light: stk33xx: add compatible for stk3013

Kees Cook (1):
      interconnect: icc-clk: Add missed num_nodes initialization

Kim Seer Paller (6):
      iio: ABI: Generalize ABI documentation for DAC
      iio: ABI: add DAC 42kohm_to_gnd powerdown mode
      dt-bindings: iio: dac: Generalize DAC common properties
      dt-bindings: iio: dac: Add adi,ltc2664.yaml
      dt-bindings: iio: dac: Add adi,ltc2672.yaml
      iio: dac: ltc2664: Add driver for LTC2664 and LTC2672

Krzysztof Kozlowski (9):
      iio: accel: bma400: simplify with cleanup.h
      iio: adc: ad7280a: simplify with cleanup.h
      iio: adc: at91: simplify with cleanup.h
      iio: adc: max1363: simplify with cleanup.h
      iio: adc: ti-tsc2046: simplify with cleanup.h
      iio: magnetometer: ak8975: drop incorrect AK09116 compatible
      dt-bindings: iio: asahi-kasei,ak8975: drop incorrect AK09116 compatible
      dt-bindings: iio: st,stm32-adc: add top-level constraints
      dt-bindings: nvmem: st,stm32-romem: add missing "unevaluatedProperties" on child nodes

Kunwu Chan (1):
      bus: mhi: host: make mhi_bus_type const

Ling Xu (1):
      misc: fastrpc: Add support for cdsp1 remoteproc

Ma Ke (1):
      pps: add an error check in parport_attach

Mank Wang (1):
      bus: mhi: host: pci_generic: Add support for Netprisma LCUR57 and FCUN69

Marcelo Schmitt (7):
      spi: Enable controllers to extend the SPI protocol with MOSI idle configuration
      spi: bitbang: Implement support for MOSI idle state configuration
      spi: spi-gpio: Add support for MOSI idle state configuration
      spi: spi-axi-spi-engine: Add support for MOSI idle configuration
      dt-bindings: iio: adc: Add AD4000
      iio: adc: Add support for AD4000
      Documentation: Add AD4000 documentation

Marco Pagani (3):
      fpga: Simplify and improve fpga mgr test using deferred actions
      fpga: Simplify and improve fpga bridge test using deferred actions
      fpga: Simplify and improve fpga region test using deferred actions

Marek Vasut (8):
      dt-bindings: iio: light: ltrf216a: Document LTR-308 support
      iio: light: ltrf216a: Add LTR-308 support
      iio: light: noa1305: Simplify noa1305_read_raw()
      iio: light: noa1305: Assign val in noa1305_measure()
      iio: light: noa1305: Use static table lookup of scale values
      iio: light: noa1305: Report available scale values
      iio: light: noa1305: Make integration time configurable
      iio: light: noa1305: Fix up integration time look up

Masahiro Yamada (1):
      slimbus: generate MODULE_ALIAS() from MODULE_DEVICE_TABLE()

Matteo Martelli (4):
      iio: ABI: generalize shunt_resistor attribute
      dt-bindings: iio: adc: add binding for pac1921
      iio: adc: add support for pac1921
      iio: remove unneeded assignment in __iio_format_value

Matthew Wilcox (1):
      nvmem: Fix misspelling

Matti Vaittinen (6):
      dt-bindings: iio: BU27034 => BU27034ANUC
      bu27034: ROHM BU27034NUC to BU27034ANUC
      bu27034: ROHM BU27034NUC to BU27034ANUC drop data2
      bu27034: ROHM BU27034ANUC correct gains and times
      bu27034: ROHM BU27034ANUC correct lux calculation
      iio: bu27034: Add a read only HARDWAREGAIN

Mudit Sharma (2):
      dt-bindings: iio: light: ROHM BH1745
      iio: light: ROHM BH1745 colour sensor

Nuno Sa (89):
      iio: core: add accessors 'masklength'
      iio: core: make use of iio_get_masklength()
      iio: buffer: make use of iio_get_masklength()
      iio: accel: adxl367: make use of iio_get_masklength()
      iio: accel: adxl372: make use of iio_get_masklength()
      iio: accel: bma180: make use of iio_for_each_active_channel()
      iio: accel: bmc150-accel-core: make use of iio_for_each_active_channel()
      iio: accel: cros_ec_accel_legacy: make use of iio_get_masklength()
      iio: accel: fxls8962af-core: make use of iio_for_each_active_channel()
      iio: accel: msa311: make use of iio_for_each_active_channel()
      iio: accel: sca3300: make use of iio_for_each_active_channel()
      iio: accel: stk8312: make use of iio_for_each_active_channel()
      iio: accel: stk8ba50: make use of iio_for_each_active_channel()
      iio: adc: ad7266: make use of iio_get_masklength()
      iio: adc: ad7298: make use of iio_get_masklength()
      iio: adc: ad799x: make use of iio_get_masklength()
      iio: adc: ad_sigma_delta: use new '.masklength' accessors
      iio: adc: at91_adc: make use of iio_for_each_active_channel()
      iio: imu: adis16475: make use of iio_for_each_active_channel()
      iio: imu: adis16480: make use of iio_for_each_active_channel()
      iio: adc: ad9467: support multiple channels calibration
      iio: adc: ad9467: add new chip_info variables
      iio: adc: ad9467: don't allow reading vref if not available
      dt-bindings: adc: ad9467: support new parts
      iio: adc: ad9467: support new parts
      iio: backend: remove unused parameter
      iio: backend: print message in case op is not implemented
      iio: adc: cc10001_adc: make use of iio_for_each_active_channel()
      iio: adc: dln2-adc: use new '.masklength' accessors
      iio: adc: hx711: make use of iio_for_each_active_channel()
      iio: dummy: iio_simple_dummy_buffer: use iio_for_each_active_channel()
      iio: health: afe4403: make use of iio_for_each_active_channel()
      iio: health: max30102: make use of iio_get_masklength()
      iio: health: afe4404: make use of iio_for_each_active_channel()
      iio: humidity: am2315: make use of iio_for_each_active_channel()
      iio: imu: bmi160_core: make use of iio_for_each_active_channel()
      iio: imu: bno055: make use of iio_get_masklength()
      iio: imu: kmx61: make use of iio_for_each_active_channel()
      iio: light: adjd_s311: make use of iio_for_each_active_channel()
      iio: light: gp2ap020a00f: make use of iio_for_each_active_channel()
      iio: light: isl29125: make use of iio_for_each_active_channel()
      iio: light: si1145: use new '.masklength' accessors
      iio: light: tcs3414: make use of iio_for_each_active_channel()
      iio: light: tcs3472: make use of iio_for_each_active_channel()
      iio: magnetometer: rm3100-core: make use of iio_get_masklength()
      iio: pressure: dlhl60d: make use of iio_for_each_active_channel()
      iio: proximity: hx9023s: make use of iio_for_each_active_channel()
      iio: proximity: sx9500: make use of iio_for_each_active_channel()
      iio: proximity: sx_common: make use of iio_for_each_active_channel()
      iio: accel: adxl380: make use of iio_get_masklength()
      iio: adc: max1118: make use of iio_for_each_active_channel()
      iio: adc: max1118: make use of iio_for_each_active_channel()
      iio: adc: mcp3911: make use of iio_for_each_active_channel()
      iio: adc: mt6360-adc: make use of iio_for_each_active_channel()
      iio: adc: rockchip_saradc: make use of iio_for_each_active_channel()
      iio: adc: rtq6056: make use of iio_for_each_active_channel()
      iio: adc: stm32-adc: make use of iio_get_masklength()
      iio: adc: stm32-dfsdm-adc: make use of iio_get_masklength()
      iio: adc: ti-adc0832: make use of iio_for_each_active_channel()
      iio: adc: ti-adc084s021: make use of iio_for_each_active_channel()
      iio: adc: ti-ads1015: make use of iio_get_masklength()
      iio: adc: ti-ads1119: make use of iio_get_masklength()
      iio: adc: ti-ads1298: make use of iio_for_each_active_channel()
      iio: adc: ti-adc12138: make use of iio_for_each_active_channel()
      iio: adc: ti-ads124s08: make use of iio_for_each_active_channel()
      iio: adc: ti-ads131e08: make use of iio_for_each_active_channel()
      iio: adc: ti-ads8688: make use of iio_for_each_active_channel()
      iio: adc: vf610_adc: make use of iio_get_masklength()
      iio: adc: xilinx-xadc-core: use new '.masklength' accessors
      iio: common: cros_ec_sensors_core: use new '.masklength' accessors
      staging: iio: impedance-analyzer: ad5933: make use of iio_get_masklength()
      iio: core: annotate masklength as __private
      iio: buffer-dma: Move exports into IIO_DMA_BUFFER namespace
      iio: backend: introduce struct iio_backend_info
      iio: backend: add debugFs interface
      iio: backend: add a modified prbs23 support
      iio: adc: adi-axi-adc: support modified prbs23
      iio: adc: adi-axi-adc: split axi_adc_chan_status()
      iio: adc: adi-axi-adc: implement backend debugfs interface
      iio: adc: ad9467: add backend test mode helpers
      iio: adc: ad9467: add digital interface test to debugfs
      iio: dac: adi-axi-dac: support debugfs direct_reg_access
      iio: dac: ad9739a: add backend debugfs interface
      MAINTAINERS: add entry for ad9467
      ABI: debugfs-iio-ad9467: document the debugfs interface
      iio: imu: adis16475: drop ifdef around CONFIG_DEBUG_FS
      iio: imu: adis16480: drop ifdef around CONFIG_DEBUG_FS
      iio: imu: adis16400: drop ifdef around CONFIG_DEBUG_FS
      iio: imu: adis16460: drop ifdef around CONFIG_DEBUG_FS

Olivier Moysan (9):
      iio: add read scale and offset services to iio backend framework
      iio: add enable and disable services to iio backend framework
      iio: add child nodes support in iio backend framework
      dt-bindings: iio: dfsdm: move to backend framework
      dt-bindings: iio: add backend support to sd modulator
      dt-bindings: iio: add vref support to sd modulator
      iio: adc: stm32-dfsdm: adopt generic channels bindings
      iio: add iio backend support to sd modulator
      iio: adc: stm32-dfsdm: add scaling support to dfsdm

Peng Fan (2):
      dt-bindings: nvmem: imx-ocotp: support i.MX95
      nvmem: imx-ocotp-ele: support i.MX95

Petar Stoykov (3):
      dt-bindings: iio: pressure: Add Sensirion SDP500
      iio: pressure: Add driver for Sensirion SDP500
      MAINTAINERS: Add Sensirion SDP500

Rafał Miłecki (3):
      dt-bindings: nvmem: convert U-Boot env to a layout
      nvmem: layouts: add U-Boot env layout
      MAINTAINERS: Update path for U-Boot environment variables YAML

Rayyan Ansari (4):
      dt-bindings: iio: kionix,kxcjk1013: Document KX022-1020
      iio: accel: kxcjk-1013: Add support for KX022-1020
      dt-bindings: iio: magnetometer: bmc150: Document mount-matrix
      dt-bindings: interconnect: qcom,rpmh: correct sm8150 camnoc

Rob Herring (Arm) (5):
      cxl: Drop printing of DT properties
      cxl: Use of_property_ accessor functions
      iio: adc: aspeed: Use of_property_present()
      misc: lis3lv02d: Fix incorrect of_get_property() usage
      iio: adc: mcp320x: Drop vendorless compatible strings

Ruffalo Lavoisier (2):
      binder: fix typo in comment
      comedi: ni_routing: tools: Check when the file could not be opened

Slark Xiao (2):
      bus: mhi: host: pci_generic: Update EDL firmware path for Foxconn modems
      bus: mhi: host: pci_generic: Enable EDL trigger for Foxconn modems

Stephen Rothwell (1):
      extcon: lc824206xa: Fix build error of POWER_SUPPLY_PROP_USB_TYPE

Suzuki K Poulose (1):
      coresight: tmc: sg: Do not leak sg_table

Tengfei Fan (1):
      dt-bindings: interconnect: qcom-bwmon: Document SA8775p bwmon compatibles

Thomas Bonnefille (2):
      dt-bindings: iio: adc: sophgo,cv1800b-saradc: Add Sophgo CV1800B SARADC
      iio: adc: sophgo-saradc: Add driver for Sophgo CV1800B SARADC

Thorsten Blum (2):
      hpet: Optimize local variable data type in hpet_alloc()
      iio: common: scmi_iio: Remove unnecessary u64 type cast

Uwe Kleine-König (1):
      w1: ds2482: Drop explicit initialization of struct i2c_device_id::driver_data to 0

Vasileios Amoiridis (22):
      iio: chemical: bme680: Fix read/write ops to device by adding mutexes
      iio: chemical: bme680: Fix typo in define
      iio: chemical: bme680: Drop unnecessary casts and correct adc data types
      iio: chemical: bme680: Remove remaining ACPI-only stuff
      iio: chemical: bme680: Sort headers alphabetically
      iio: chemical: bme680: Remove duplicate register read
      iio: chemical: bme680: Use bulk reads for calibration data
      iio: chemical: bme680: Allocate IIO device before chip initialization
      iio: chemical: bme680: Add read buffers in read/write buffer union
      iio: chemical: bme680: Make error checks consistent
      iio: chemical: bme680: Modify startup procedure
      iio: chemical: bme680: Move probe errors to dev_err_probe()
      iio: chemical: bme680: Remove redundant gas configuration
      iio: chemical: bme680: Move forced mode setup in ->read_raw()
      iio: chemical: bme680: Refactorize reading functions
      iio: pressure: bmp280: Generalize read_*() functions
      iio: pressure: bmp280: Add SCALE, RAW values in channels and refactorize them
      iio: pressure: bmp280: Add triggered buffer support
      iio: pressure: bmp280: Fix regmap for BMP280 device
      iio: pressure: bmp280: Fix waiting time for BMP3xx configuration
      iio: pressure: bmp280: Sort headers alphabetically
      chemical: bme680: Convert to static the const lookup table

Vincenzo Mezzela (1):
      drivers: cacheinfo: use __free attribute instead of of_node_put()

Wolfram Sang (5):
      fpga: socfpga: Rename 'timeout' variable as 'time_left'
      fpga: zynq-fpga: Rename 'timeout' variable as 'time_left'
      slimbus: messaging: use 'time_left' variable with wait_for_completion_timeout()
      slimbus: qcom-ctrl: use 'time_left' variable with wait_for_completion_timeout()
      slimbus: qcom-ngd-ctrl: use 'time_left' variable with wait_for_completion_timeout()

Yang Ruibin (1):
      drivers:iio:Fix the NULL vs IS_ERR() bug for debugfs_create_dir()

Yasin Lee (3):
      dt-bindings: vendor-prefixes: add tyhx
      dt-bindings: iio: proximity: Add TYHX HX9023S
      iio: proximity: Add driver support for TYHX's HX9023S capacitive proximity sensor

Yu-Ting Tseng (2):
      binder: frozen notification
      binder: frozen notification binder_features flag

Zhang Zekun (2):
      nvmem: sunplus-ocotp: Use devm_platform_ioremap_resource_byname() helper function
      ocxl: Remove the unused declarations in headr file

Zhu Jun (1):
      tools/iio: Add memory allocation failure check for trigger_name

shuaijie wang (2):
      dt-bindings: iio: aw96103: Add bindings for aw96103/aw96105 sensor
      iio: proximity: aw96103: Add support for aw96103/aw96105 proximity sensor

zhang jiao (1):
      hpet: Fix the wrong format specifier

zhangjiao (1):
      tools: iio: rm .*.cmd when make clean

 Documentation/ABI/stable/sysfs-bus-nvmem           |    2 +-
 Documentation/ABI/testing/debugfs-iio-ad9467       |   39 +
 Documentation/ABI/testing/debugfs-iio-backend      |   20 +
 Documentation/ABI/testing/sysfs-bus-iio            |   78 +-
 .../ABI/testing/sysfs-bus-iio-adc-max9611          |   17 -
 .../ABI/testing/sysfs-bus-iio-chemical-sgp40       |   14 -
 Documentation/ABI/testing/sysfs-bus-iio-dac        |   61 +
 .../ABI/testing/sysfs-bus-iio-dac-ltc2688          |   31 -
 .../ABI/testing/sysfs-bus-iio-filter-admv8818      |    2 +-
 Documentation/ABI/testing/sysfs-bus-iio-ina2xx-adc |    9 -
 Documentation/ABI/testing/sysfs-class-power        |    7 +-
 .../devicetree/bindings/extcon/extcon-ptn5150.yaml |   11 +
 .../devicetree/bindings/extcon/extcon-usb-gpio.txt |   21 -
 .../bindings/extcon/linux,extcon-usb-gpio.yaml     |   37 +
 .../devicetree/bindings/iio/accel/adi,adxl380.yaml |   92 +
 .../bindings/iio/accel/kionix,kxcjk1013.yaml       |    1 +
 .../devicetree/bindings/iio/adc/adi,ad4000.yaml    |  197 ++
 .../devicetree/bindings/iio/adc/adi,ad4695.yaml    |  254 +++
 .../devicetree/bindings/iio/adc/adi,ad7192.yaml    |   33 +-
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    |   13 +
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |  123 +-
 .../devicetree/bindings/iio/adc/adi,ad9467.yaml    |    3 +
 .../bindings/iio/adc/microchip,pac1921.yaml        |   71 +
 .../bindings/iio/adc/rockchip-saradc.yaml          |    3 +
 .../bindings/iio/adc/sigma-delta-modulator.yaml    |   25 +-
 .../bindings/iio/adc/sophgo,cv1800b-saradc.yaml    |   83 +
 .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  |    4 +-
 .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml       |  122 +-
 .../bindings/iio/adc/x-powers,axp209-adc.yaml      |   12 +
 .../devicetree/bindings/iio/dac/adi,ltc2664.yaml   |  181 ++
 .../devicetree/bindings/iio/dac/adi,ltc2672.yaml   |  160 ++
 Documentation/devicetree/bindings/iio/dac/dac.yaml |   50 +
 .../bindings/iio/frequency/adi,adf4377.yaml        |   10 +
 .../bindings/iio/humidity/sciosense,ens210.yaml    |   55 +
 .../bindings/iio/light/liteon,ltrf216a.yaml        |    4 +-
 .../devicetree/bindings/iio/light/rohm,bh1745.yaml |   53 +
 .../{rohm,bu27034.yaml => rohm,bu27034anuc.yaml}   |   11 +-
 .../devicetree/bindings/iio/light/stk33xx.yaml     |   13 +-
 .../iio/magnetometer/asahi-kasei,ak8975.yaml       |    5 +-
 .../iio/magnetometer/bosch,bmc150_magn.yaml        |    3 +
 .../bindings/iio/pressure/sensirion,sdp500.yaml    |   46 +
 .../bindings/iio/proximity/awinic,aw96103.yaml     |   61 +
 .../bindings/iio/proximity/tyhx,hx9023s.yaml       |   93 +
 .../bindings/interconnect/qcom,msm8939.yaml        |   25 +-
 .../bindings/interconnect/qcom,msm8953.yaml        |    3 +-
 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |    2 +
 .../bindings/interconnect/qcom,rpmh.yaml           |    5 +-
 .../devicetree/bindings/misc/qcom,fastrpc.yaml     |    3 +-
 .../devicetree/bindings/net/ti,cc1352p7.yaml       |    7 +
 .../bindings/nvmem/fsl,layerscape-sfp.yaml         |    1 +
 .../devicetree/bindings/nvmem/imx-ocotp.yaml       |    3 +-
 .../bindings/nvmem/layouts/nvmem-layout.yaml       |    1 +
 .../bindings/nvmem/{ => layouts}/u-boot,env.yaml   |   39 +-
 .../devicetree/bindings/nvmem/st,stm32-romem.yaml  |    3 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 Documentation/iio/ad4000.rst                       |  131 ++
 Documentation/iio/ad4695.rst                       |  167 ++
 Documentation/iio/ad7380.rst                       |  130 ++
 Documentation/iio/adxl380.rst                      |  233 +++
 Documentation/iio/index.rst                        |    4 +
 Documentation/spi/spi-summary.rst                  |   83 +
 MAINTAINERS                                        |   76 +-
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts     |    3 +-
 drivers/android/binder.c                           |  288 ++-
 drivers/android/binder_internal.h                  |   21 +-
 drivers/android/binderfs.c                         |    8 +
 drivers/base/cacheinfo.c                           |   41 +-
 drivers/bus/mhi/host/init.c                        |    2 +-
 drivers/bus/mhi/host/internal.h                    |    2 +-
 drivers/bus/mhi/host/pci_generic.c                 |   64 +-
 drivers/cdx/controller/mcdi.c                      |    4 -
 drivers/char/hpet.c                                |    6 +-
 drivers/comedi/drivers/ni_atmio.c                  |    9 +
 drivers/comedi/drivers/ni_mio_common.c             |    9 -
 drivers/comedi/drivers/ni_pcimio.c                 |    9 +
 .../drivers/ni_routing/tools/convert_c_to_py.c     |    5 +
 drivers/comedi/drivers/ni_stc.h                    |    2 -
 drivers/extcon/Kconfig                             |   11 +
 drivers/extcon/Makefile                            |    1 +
 drivers/extcon/extcon-intel-cht-wc.c               |   15 +-
 drivers/extcon/extcon-lc824206xa.c                 |  495 +++++
 drivers/fpga/socfpga.c                             |    7 +-
 drivers/fpga/tests/fpga-bridge-test.c              |   25 +-
 drivers/fpga/tests/fpga-mgr-test.c                 |   28 +-
 drivers/fpga/tests/fpga-region-test.c              |   41 +-
 drivers/fpga/zynq-fpga.c                           |    8 +-
 drivers/greybus/Kconfig                            |    2 +
 drivers/greybus/gb-beagleplay.c                    |  658 ++++++-
 drivers/hwtracing/coresight/coresight-core.c       |   37 +-
 .../hwtracing/coresight/coresight-cti-platform.c   |   10 +-
 drivers/hwtracing/coresight/coresight-dummy.c      |    7 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |   47 +-
 drivers/hwtracing/coresight/coresight-etm-perf.h   |   18 -
 drivers/hwtracing/coresight/coresight-etm3x-core.c |    9 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c |    9 +-
 drivers/hwtracing/coresight/coresight-priv.h       |    1 +
 drivers/hwtracing/coresight/coresight-stm.c        |    3 +-
 drivers/hwtracing/coresight/coresight-sysfs.c      |    3 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |    7 +-
 drivers/hwtracing/coresight/coresight-tmc.h        |    5 +-
 drivers/hwtracing/coresight/coresight-tpdm.c       |    9 +-
 drivers/hwtracing/coresight/coresight-trace-id.c   |  138 +-
 drivers/hwtracing/coresight/coresight-trace-id.h   |   70 +-
 drivers/iio/accel/Kconfig                          |   27 +
 drivers/iio/accel/Makefile                         |    3 +
 drivers/iio/accel/adxl367.c                        |    2 +-
 drivers/iio/accel/adxl367_spi.c                    |    2 +-
 drivers/iio/accel/adxl372.c                        |    2 +-
 drivers/iio/accel/adxl380.c                        | 1905 ++++++++++++++++++++
 drivers/iio/accel/adxl380.h                        |   26 +
 drivers/iio/accel/adxl380_i2c.c                    |   64 +
 drivers/iio/accel/adxl380_spi.c                    |   66 +
 drivers/iio/accel/bma180.c                         |    3 +-
 drivers/iio/accel/bma400_core.c                    |   11 +-
 drivers/iio/accel/bma400_spi.c                     |    2 +-
 drivers/iio/accel/bmc150-accel-core.c              |   13 +-
 drivers/iio/accel/bmi088-accel-spi.c               |    2 +-
 drivers/iio/accel/cros_ec_accel_legacy.c           |    2 +-
 drivers/iio/accel/fxls8962af-core.c                |    3 +-
 drivers/iio/accel/kxcjk-1013.c                     |    8 +-
 drivers/iio/accel/msa311.c                         |    3 +-
 drivers/iio/accel/sca3300.c                        |    3 +-
 drivers/iio/accel/stk8312.c                        |    3 +-
 drivers/iio/accel/stk8ba50.c                       |    3 +-
 drivers/iio/adc/Kconfig                            |   48 +
 drivers/iio/adc/Makefile                           |    4 +
 drivers/iio/adc/ad4000.c                           |  722 ++++++++
 drivers/iio/adc/ad4695.c                           | 1185 ++++++++++++
 drivers/iio/adc/ad7091r5.c                         |    6 +-
 drivers/iio/adc/ad7091r8.c                         |    2 +-
 drivers/iio/adc/ad7124.c                           |   38 +-
 drivers/iio/adc/ad7192.c                           |  189 +-
 drivers/iio/adc/ad7266.c                           |    7 +-
 drivers/iio/adc/ad7280a.c                          |   14 +-
 drivers/iio/adc/ad7291.c                           |    4 +-
 drivers/iio/adc/ad7292.c                           |    4 +-
 drivers/iio/adc/ad7298.c                           |    7 +-
 drivers/iio/adc/ad7380.c                           |  523 +++++-
 drivers/iio/adc/ad7476.c                           |   58 +-
 drivers/iio/adc/ad7606.c                           |   47 +-
 drivers/iio/adc/ad7606_par.c                       |    2 +-
 drivers/iio/adc/ad7606_spi.c                       |    9 +-
 drivers/iio/adc/ad7766.c                           |   14 +-
 drivers/iio/adc/ad7768-1.c                         |    7 +-
 drivers/iio/adc/ad7780.c                           |   10 +-
 drivers/iio/adc/ad7793.c                           |   20 +-
 drivers/iio/adc/ad7887.c                           |    4 +-
 drivers/iio/adc/ad7923.c                           |   18 +-
 drivers/iio/adc/ad799x.c                           |    3 +-
 drivers/iio/adc/ad9467.c                           |  491 ++++-
 drivers/iio/adc/ad_sigma_delta.c                   |    6 +-
 drivers/iio/adc/adi-axi-adc.c                      |   71 +-
 drivers/iio/adc/aspeed_adc.c                       |    5 +-
 drivers/iio/adc/at91_adc.c                         |   19 +-
 drivers/iio/adc/axp20x_adc.c                       |  182 +-
 drivers/iio/adc/axp288_adc.c                       |    2 +-
 drivers/iio/adc/bcm_iproc_adc.c                    |    2 +-
 drivers/iio/adc/berlin2-adc.c                      |    2 +-
 drivers/iio/adc/cc10001_adc.c                      |    4 +-
 drivers/iio/adc/dln2-adc.c                         |    8 +-
 drivers/iio/adc/ep93xx_adc.c                       |    2 +-
 drivers/iio/adc/exynos_adc.c                       |    2 +-
 drivers/iio/adc/hi8435.c                           |    2 +-
 drivers/iio/adc/hx711.c                            |    7 +-
 drivers/iio/adc/ina2xx-adc.c                       |   17 +-
 drivers/iio/adc/ingenic-adc.c                      |    2 +-
 drivers/iio/adc/lpc32xx_adc.c                      |    2 +-
 drivers/iio/adc/ltc2496.c                          |    2 +-
 drivers/iio/adc/ltc2497.c                          |    2 +-
 drivers/iio/adc/max1027.c                          |   16 +-
 drivers/iio/adc/max11100.c                         |    4 +-
 drivers/iio/adc/max1118.c                          |    7 +-
 drivers/iio/adc/max1241.c                          |    4 +-
 drivers/iio/adc/max1363.c                          |   34 +-
 drivers/iio/adc/max34408.c                         |    4 +-
 drivers/iio/adc/max9611.c                          |    6 +-
 drivers/iio/adc/mcp320x.c                          |   10 -
 drivers/iio/adc/mcp3564.c                          |   54 +-
 drivers/iio/adc/mcp3911.c                          |   61 +-
 drivers/iio/adc/mp2629_adc.c                       |    4 +-
 drivers/iio/adc/mt6360-adc.c                       |    4 +-
 drivers/iio/adc/nau7802.c                          |    2 +-
 drivers/iio/adc/pac1921.c                          | 1261 +++++++++++++
 drivers/iio/adc/pac1934.c                          |    6 +-
 drivers/iio/adc/qcom-pm8xxx-xoadc.c                |    2 +-
 drivers/iio/adc/qcom-spmi-rradc.c                  |    2 +-
 drivers/iio/adc/rockchip_saradc.c                  |    4 +-
 drivers/iio/adc/rtq6056.c                          |    4 +-
 drivers/iio/adc/sd_adc_modulator.c                 |   97 +-
 drivers/iio/adc/sophgo-cv1800b-adc.c               |  227 +++
 drivers/iio/adc/stm32-adc.c                        |    6 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |  299 ++-
 drivers/iio/adc/stm32-dfsdm-core.c                 |    2 +-
 drivers/iio/adc/stmpe-adc.c                        |    2 +-
 drivers/iio/adc/ti-adc0832.c                       |    7 +-
 drivers/iio/adc/ti-adc084s021.c                    |    7 +-
 drivers/iio/adc/ti-adc12138.c                      |    7 +-
 drivers/iio/adc/ti-adc161s626.c                    |    8 +-
 drivers/iio/adc/ti-ads1015.c                       |    6 +-
 drivers/iio/adc/ti-ads1119.c                       |    4 +-
 drivers/iio/adc/ti-ads124s08.c                     |    5 +-
 drivers/iio/adc/ti-ads1298.c                       |    3 +-
 drivers/iio/adc/ti-ads131e08.c                     |    6 +-
 drivers/iio/adc/ti-ads7924.c                       |    4 +-
 drivers/iio/adc/ti-ads7950.c                       |    2 +-
 drivers/iio/adc/ti-ads8344.c                       |    2 +-
 drivers/iio/adc/ti-ads8688.c                       |   10 +-
 drivers/iio/adc/ti-lmp92064.c                      |    2 +-
 drivers/iio/adc/ti-tlc4541.c                       |    8 +-
 drivers/iio/adc/ti-tsc2046.c                       |   83 +-
 drivers/iio/adc/vf610_adc.c                        |    2 +-
 drivers/iio/adc/xilinx-ams.c                       |   15 +-
 drivers/iio/adc/xilinx-xadc-core.c                 |    5 +-
 drivers/iio/buffer/industrialio-buffer-cb.c        |    2 +-
 drivers/iio/buffer/industrialio-buffer-dma.c       |   36 +-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |    1 +
 drivers/iio/buffer/industrialio-hw-consumer.c      |    4 +-
 drivers/iio/chemical/bme680.h                      |   41 +-
 drivers/iio/chemical/bme680_core.c                 |  633 +++----
 drivers/iio/chemical/bme680_spi.c                  |    2 +-
 drivers/iio/chemical/sgp40.c                       |   11 +-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |    8 +-
 drivers/iio/common/scmi_sensors/scmi_iio.c         |    2 +-
 drivers/iio/dac/Kconfig                            |   11 +
 drivers/iio/dac/Makefile                           |    1 +
 drivers/iio/dac/ad5449.c                           |   15 +-
 drivers/iio/dac/ad9739a.c                          |   13 +-
 drivers/iio/dac/adi-axi-dac.c                      |   21 +-
 drivers/iio/dac/ltc2664.c                          |  735 ++++++++
 drivers/iio/dac/ltc2688.c                          |    2 +-
 drivers/iio/dac/mcp4728.c                          |   45 +-
 drivers/iio/dac/mcp4922.c                          |   45 +-
 drivers/iio/dac/ti-dac7311.c                       |    4 +-
 drivers/iio/dummy/iio_simple_dummy_buffer.c        |    2 +-
 drivers/iio/frequency/adf4377.c                    |   35 +-
 drivers/iio/health/afe4403.c                       |    3 +-
 drivers/iio/health/afe4404.c                       |    3 +-
 drivers/iio/health/max30102.c                      |    2 +-
 drivers/iio/humidity/Kconfig                       |   11 +
 drivers/iio/humidity/Makefile                      |    1 +
 drivers/iio/humidity/am2315.c                      |    3 +-
 drivers/iio/humidity/ens210.c                      |  339 ++++
 drivers/iio/imu/adis16400.c                        |   18 +-
 drivers/iio/imu/adis16460.c                        |   18 +-
 drivers/iio/imu/adis16475.c                        |   12 +-
 drivers/iio/imu/adis16480.c                        |   20 +-
 drivers/iio/imu/bmi160/bmi160_core.c               |    3 +-
 drivers/iio/imu/bmi323/bmi323.h                    |    1 +
 drivers/iio/imu/bmi323/bmi323_core.c               |  182 +-
 drivers/iio/imu/bmi323/bmi323_i2c.c                |    3 +-
 drivers/iio/imu/bmi323/bmi323_spi.c                |    3 +-
 drivers/iio/imu/bno055/bno055.c                    |    2 +-
 drivers/iio/imu/bno055/bno055_ser_core.c           |    2 +-
 drivers/iio/imu/kmx61.c                            |    3 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |   93 +-
 drivers/iio/industrialio-backend.c                 |  264 ++-
 drivers/iio/industrialio-buffer.c                  |   52 +-
 drivers/iio/industrialio-core.c                    |   46 +-
 drivers/iio/industrialio-trigger.c                 |   27 +
 drivers/iio/light/Kconfig                          |   13 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/adjd_s311.c                      |    3 +-
 drivers/iio/light/apds9960.c                       |   55 +-
 drivers/iio/light/bh1745.c                         |  906 ++++++++++
 drivers/iio/light/gp2ap002.c                       |    2 +-
 drivers/iio/light/gp2ap020a00f.c                   |    9 +-
 drivers/iio/light/isl29125.c                       |    3 +-
 drivers/iio/light/ltr390.c                         |  241 ++-
 drivers/iio/light/ltrf216a.c                       |   53 +-
 drivers/iio/light/noa1305.c                        |  171 +-
 drivers/iio/light/rohm-bu27034.c                   |  337 +---
 drivers/iio/light/si1145.c                         |    7 +-
 drivers/iio/light/stk3310.c                        |    7 +-
 drivers/iio/light/tcs3414.c                        |    3 +-
 drivers/iio/light/tcs3472.c                        |    3 +-
 drivers/iio/magnetometer/Kconfig                   |    2 +-
 drivers/iio/magnetometer/ak8975.c                  |   80 +-
 drivers/iio/magnetometer/rm3100-core.c             |    2 +-
 drivers/iio/pressure/Kconfig                       |   11 +
 drivers/iio/pressure/Makefile                      |    1 +
 drivers/iio/pressure/bmp280-core.c                 |  654 ++++++-
 drivers/iio/pressure/bmp280-i2c.c                  |    2 +-
 drivers/iio/pressure/bmp280-regmap.c               |   45 +-
 drivers/iio/pressure/bmp280-spi.c                  |   18 +-
 drivers/iio/pressure/bmp280.h                      |   37 +-
 drivers/iio/pressure/dlhl60d.c                     |    3 +-
 drivers/iio/pressure/sdp500.c                      |  156 ++
 drivers/iio/proximity/Kconfig                      |   25 +
 drivers/iio/proximity/Makefile                     |    2 +
 drivers/iio/proximity/aw96103.c                    |  846 +++++++++
 drivers/iio/proximity/cros_ec_mkbp_proximity.c     |    2 +-
 drivers/iio/proximity/hx9023s.c                    | 1144 ++++++++++++
 drivers/iio/proximity/sx9500.c                     |    3 +-
 drivers/iio/proximity/sx_common.c                  |    6 +-
 drivers/interconnect/icc-clk.c                     |    3 +-
 drivers/interconnect/qcom/Kconfig                  |   18 +
 drivers/interconnect/qcom/Makefile                 |    4 +
 drivers/interconnect/qcom/msm8937.c                | 1350 ++++++++++++++
 drivers/interconnect/qcom/msm8953.c                |    2 +
 drivers/interconnect/qcom/msm8976.c                | 1440 +++++++++++++++
 drivers/interconnect/qcom/qcs404.c                 |  127 +-
 drivers/interconnect/qcom/sm8350.c                 |  155 +-
 drivers/interconnect/qcom/sm8350.h                 |   10 -
 drivers/mfd/axp20x.c                               |   25 +-
 drivers/misc/cxl/of.c                              |  207 +--
 drivers/misc/cxl/pci.c                             |   32 +-
 drivers/misc/cxl/sysfs.c                           |    2 +-
 drivers/misc/fastrpc.c                             |   10 +-
 drivers/misc/kgdbts.c                              |    4 +-
 drivers/misc/lis3lv02d/lis3lv02d.c                 |    4 +-
 drivers/misc/ocxl/ocxl_internal.h                  |    2 -
 drivers/misc/tsl2550.c                             |    8 +-
 drivers/nvmem/Kconfig                              |    3 +-
 drivers/nvmem/imx-ocotp-ele.c                      |   32 +-
 drivers/nvmem/layouts/Kconfig                      |   11 +
 drivers/nvmem/layouts/Makefile                     |    1 +
 drivers/nvmem/layouts/u-boot-env.c                 |  211 +++
 drivers/nvmem/layouts/u-boot-env.h                 |   15 +
 drivers/nvmem/sunplus-ocotp.c                      |    7 +-
 drivers/nvmem/u-boot-env.c                         |  165 +-
 drivers/phy/ti/phy-tusb1210.c                      |   11 +-
 drivers/power/supply/axp20x_usb_power.c            |   13 +-
 drivers/power/supply/bq256xx_charger.c             |   15 +-
 drivers/power/supply/cros_usbpd-charger.c          |   22 +-
 drivers/power/supply/lenovo_yoga_c630_battery.c    |    7 +-
 drivers/power/supply/mp2629_charger.c              |   15 +-
 drivers/power/supply/mt6360_charger.c              |   13 +-
 drivers/power/supply/mt6370-charger.c              |   13 +-
 drivers/power/supply/power_supply_core.c           |    4 -
 drivers/power/supply/power_supply_sysfs.c          |   66 +-
 drivers/power/supply/qcom_battmgr.c                |   37 +-
 drivers/power/supply/qcom_pmi8998_charger.c        |   13 +-
 drivers/power/supply/rk817_charger.c               |    9 +-
 drivers/power/supply/rn5t618_power.c               |   13 +-
 drivers/power/supply/rt9467-charger.c              |   16 +-
 drivers/power/supply/rt9471.c                      |   15 +-
 drivers/power/supply/ucs1002_power.c               |   26 +-
 drivers/pps/clients/pps_parport.c                  |    8 +-
 drivers/slimbus/messaging.c                        |    9 +-
 drivers/slimbus/qcom-ctrl.c                        |    7 +-
 drivers/slimbus/qcom-ngd-ctrl.c                    |   29 +-
 drivers/spi/spi-axi-spi-engine.c                   |   15 +-
 drivers/spi/spi-bitbang.c                          |   24 +
 drivers/spi/spi-gpio.c                             |   12 +-
 drivers/spi/spi.c                                  |    6 +
 drivers/staging/iio/impedance-analyzer/ad5933.c    |    5 +-
 drivers/uio/uio.c                                  |    4 +-
 drivers/usb/typec/anx7411.c                        |   11 +-
 drivers/usb/typec/rt1719.c                         |   11 +-
 drivers/usb/typec/tcpm/tcpm.c                      |   11 +-
 drivers/usb/typec/tipd/core.c                      |    9 +-
 drivers/usb/typec/ucsi/psy.c                       |   11 +-
 drivers/w1/masters/ds2482.c                        |    4 +-
 include/dt-bindings/iio/adi,ad4695.h               |    9 +
 include/dt-bindings/interconnect/qcom,msm8937.h    |   93 +
 include/dt-bindings/interconnect/qcom,msm8976.h    |   97 +
 include/dt-bindings/interconnect/qcom,sm8350.h     |   10 -
 include/linux/coresight-pmu.h                      |   17 +-
 include/linux/coresight.h                          |   21 +-
 include/linux/iio/backend.h                        |   62 +-
 include/linux/iio/iio.h                            |   39 +-
 include/linux/mfd/axp20x.h                         |   26 +
 include/linux/platform_data/ad5449.h               |   39 -
 include/linux/power_supply.h                       |    3 +-
 include/linux/spi/spi_bitbang.h                    |    1 +
 include/uapi/linux/android/binder.h                |   36 +
 include/uapi/linux/spi/spi.h                       |    5 +-
 scripts/mod/devicetable-offsets.c                  |    4 +
 scripts/mod/file2alias.c                           |   11 +
 tools/iio/Makefile                                 |    2 +-
 tools/iio/iio_generic_buffer.c                     |    4 +
 .../selftests/filesystems/binderfs/binderfs_test.c |    1 +
 372 files changed, 22488 insertions(+), 3378 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-iio-ad9467
 create mode 100644 Documentation/ABI/testing/debugfs-iio-backend
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-max9611
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac
 delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/linux,extcon-usb-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac1921.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/sophgo,cv1800b-saradc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/dac.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/humidity/sciosense,ens210.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml
 rename Documentation/devicetree/bindings/iio/light/{rohm,bu27034.yaml => rohm,bu27034anuc.yaml} (66%)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/awinic,aw96103.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
 rename Documentation/devicetree/bindings/nvmem/{ => layouts}/u-boot,env.yaml (75%)
 create mode 100644 Documentation/iio/ad4000.rst
 create mode 100644 Documentation/iio/ad4695.rst
 create mode 100644 Documentation/iio/ad7380.rst
 create mode 100644 Documentation/iio/adxl380.rst
 create mode 100644 drivers/extcon/extcon-lc824206xa.c
 create mode 100644 drivers/iio/accel/adxl380.c
 create mode 100644 drivers/iio/accel/adxl380.h
 create mode 100644 drivers/iio/accel/adxl380_i2c.c
 create mode 100644 drivers/iio/accel/adxl380_spi.c
 create mode 100644 drivers/iio/adc/ad4000.c
 create mode 100644 drivers/iio/adc/ad4695.c
 create mode 100644 drivers/iio/adc/pac1921.c
 create mode 100644 drivers/iio/adc/sophgo-cv1800b-adc.c
 create mode 100644 drivers/iio/dac/ltc2664.c
 create mode 100644 drivers/iio/humidity/ens210.c
 create mode 100644 drivers/iio/light/bh1745.c
 create mode 100644 drivers/iio/pressure/sdp500.c
 create mode 100644 drivers/iio/proximity/aw96103.c
 create mode 100644 drivers/iio/proximity/hx9023s.c
 create mode 100644 drivers/interconnect/qcom/msm8937.c
 create mode 100644 drivers/interconnect/qcom/msm8976.c
 create mode 100644 drivers/nvmem/layouts/u-boot-env.c
 create mode 100644 drivers/nvmem/layouts/u-boot-env.h
 create mode 100644 include/dt-bindings/iio/adi,ad4695.h
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8937.h
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8976.h
 delete mode 100644 include/linux/platform_data/ad5449.h

