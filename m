Return-Path: <linux-kernel+bounces-186391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0958CC38D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B326FB216EE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243AA20DC3;
	Wed, 22 May 2024 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B6LDVhVd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B5F208A1
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389501; cv=none; b=ho8zOQ1xub49Q5Ymo7gYHJzEIeDonLyimeZnThnlQNaAgVoq/tygpLf3qi5UtWQR0LcSliLDhOh8lLSpodEzGdWS94eX8ieONKxf8nMQ9ieyuurtZFXy/TMDly4lnfoP5GW4IIsmeLJa8JQeVR2z7/PiBvvUmWHDzRQPg+nzLHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389501; c=relaxed/simple;
	bh=qvlNlVAOWFmEQlvwGfvUNn594+f1Or3J3sYMRLKzRNY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GDSRU7/BCCANUTqtAZClE5VizsToSJVbnrySBFAVIDmsa3jJn4OJKWC/fIOnbfpCxgRxd4sNcEJICKuTpi7lH07jmrO09W9ilOat1XWrxpDr2PUX8e92BWT46BQhlE645ftA1xRpYbjR7bRz+2lQp63rSSQogFu5CxFvuKpKnp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B6LDVhVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1486C2BBFC;
	Wed, 22 May 2024 14:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716389501;
	bh=qvlNlVAOWFmEQlvwGfvUNn594+f1Or3J3sYMRLKzRNY=;
	h=Date:From:To:Cc:Subject:From;
	b=B6LDVhVdgoFhaJdQc2LDzwBDI5pORteRrqaEa+s0ih3tGb+/tzBDebhipGTjHzcpk
	 O/NAl1VAJYFU5J/a0zef5GySXu1asCoByQI5b6CgFhSrqSsAmVFBlNpnAUgQt5CJSs
	 1GL5Mg19xcfeHGKLk9PaAL0Z6uqmxUPy+z1xpuiA=
Date: Wed, 22 May 2024 16:51:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver changes for 6.10-rc1
Message-ID: <Zk4GetENJdycqIoG@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit dd5a440a31fae6e459c0d6271dddd62825505361:

  Linux 6.9-rc7 (2024-05-05 14:06:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.10-rc1

for you to fetch changes up to f5b335dc025cfee90957efa90dc72fada0d5abb4:

  misc: ntsync: mark driver as "broken" to prevent from building (2024-05-15 17:34:41 +0200)

----------------------------------------------------------------
Char/Misc and other driver subsystem changes for 6.10-rc1

Here is the big set of char/misc and other driver subsystem updates for
6.10-rc1.  Nothing major here, just lots of new drivers and updates for
apis and new hardware types.  Included in here are:
  - big IIO driver updates with more devices and drivers added
  - fpga driver updates
  - hyper-v driver updates
  - uio_pruss driver removal, no one uses it, other drivers control the
    same hardware now
  - binder minor updates
  - mhi driver updates
  - excon driver updates
  - counter driver updates
  - accessability driver updates
  - coresight driver updates
  - other hwtracing driver updates
  - nvmem driver updates
  - slimbus driver updates
  - spmi driver updates
  - other smaller misc and char driver updates

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abel Vesa (7):
      dt-bindings: spmi: Add X1E80100 SPMI PMIC ARB schema
      dt-bindings: spmi: Deprecate qcom,bus-id
      spmi: pmic-arb: Fix some compile warnings about members not being described
      spmi: pmic-arb: Make the APID init a version operation
      spmi: pmic-arb: Make core resources acquiring a version operation
      spmi: pmic-arb: Register controller for bus instead of arbiter
      spmi: pmic-arb: Add multi bus support

Alexander Shishkin (6):
      intel_th: pci: Add Granite Rapids support
      intel_th: pci: Add Granite Rapids SOC support
      intel_th: pci: Add Sapphire Rapids SOC support
      intel_th: pci: Add Meteor Lake-S support
      intel_th: pci: Add Meteor Lake-S CPU support
      intel_th: pci: Add Lunar Lake support

Andrew Davis (1):
      uio: pruss: Remove this driver

Andy Shevchenko (15):
      w1: gpio: Make use of device properties
      w1: gpio: Switch to use dev_err_probe()
      w1: gpio: Use sizeof(*pointer) instead of sizeof(type)
      w1: gpio: Remove duplicate NULL checks
      w1: gpio: Don't use "proxy" headers
      iio: adc: spear_adc: Make use of device properties
      iio: core: Leave private pointer NULL when no private data supplied
      iio: core: Calculate alloc_size only once in iio_device_alloc()
      iio: adc: twl4030-madc: Make use of device properties
      counter: Don't use "proxy" headers
      fpga: ice40-spi: Don't use "proxy" headers
      iio: light: stk3310: Drop most likely fake ACPI ID
      extcon: intel-mrfld: Switch to use dev_err_probe()
      extcon: intel-mrfld: Don't shadow error from devm_extcon_dev_allocate()
      extcon: realtek: Remove unused of_gpio.h

Anshuman Khandual (12):
      coresight: etm4x: Fix unbalanced pm_runtime_enable()
      coresight: stm: Extract device name from AMBA pid based table lookup
      coresight: tmc: Extract device properties from AMBA pid based table lookup
      coresight: Add helpers registering/removing both AMBA and platform drivers
      coresight: replicator: Move ACPI support from AMBA driver to platform driver
      coresight: funnel: Move ACPI support from AMBA driver to platform driver
      coresight: catu: Move ACPI support from AMBA driver to platform driver
      coresight: tpiu: Move ACPI support from AMBA driver to platform driver
      coresight: tmc: Move ACPI support from AMBA driver to platform driver
      coresight: stm: Move ACPI support from AMBA driver to platform driver
      coresight: debug: Move ACPI support from AMBA driver to platform driver
      coresight: tmc: Enable SG capability on ACPI based SoC-400 TMC ETR devices

Arnd Bergmann (1):
      parport: mfc3: avoid empty-body warning

Atin Bainada (1):
      misc: ti-st: st_kim: remove unnecessary (void*) conversions

Baochen Qiang (1):
      bus: mhi: host: Add mhi_power_down_keep_dev() API to support system suspend/hibernation

Bird, Tim (1):
      scripts/spdxcheck: Add count of missing files to stats output

Carlos Llamas (1):
      binder: fix max_thread type inconsistency

Charles Perry (4):
      fpga: xilinx-spi: extract a common driver core
      dt-bindings: fpga: xlnx,fpga-selectmap: add DT schema
      fpga: xilinx-selectmap: add new driver
      fpga: xilinx-core: add new gpio names for prog and init

Chris Morgan (1):
      dt-bindings: iio: adc: Add GPADC for Allwinner H616

Chris Packham (3):
      uio_pdrv_genirq: convert to use device_property APIs
      uio: use threaded interrupts
      uio: update kerneldoc comments for interrupt functions

Christophe JAILLET (3):
      iio: pressure: hsc030pa: Use spi_read()
      fpga: altera-cvp: Remove an unused field in struct altera_cvp_conf
      VMCI: Fix an error handling path in vmci_guest_probe_device()

Colin Ian King (3):
      iio: accel: adxl367: Remove second semicolon
      comedi: remove unused helper function dma_chain_flag_bits
      intel_th: Remove redundant initialization of pointer outp

Dan Carpenter (4):
      iio: light: apds9306: Fix off by one in apds9306_sampling_freq_get()
      iio: adc: ad7173: Fix ! vs ~ typo in ad7173_sel_clk()
      iio: dac: adi-axi: fix a mistake in axi_dac_ext_info_set()
      stm class: Fix a double free in stm_register_device()

David Collins (1):
      dt-bindings: nvmem: qcom,spmi-sdam: update maintainer

David Lechner (13):
      dt-bindings: iio: adc: add ad7944 ADCs
      iio: adc: ad7944: add driver for AD7944/AD7985/AD7986
      iio: adc: ad7944: Add support for "3-wire mode"
      MAINTAINERS: add Documentation/iio/ to IIO subsystem
      docs: iio: new docs for ad7944 driver
      iio: adc: ad7944: simplify adi,spi-mode property parsing
      iio: adc: ad7944: use spi_optimize_message()
      iio: adc: ad7944: Consolidate spi_sync() wrapper
      iio: adc: ad7266: don't set masklength
      iio: adc: mxs-lradc-adc: don't set masklength
      iio: buffer: initialize masklength accumulator to 0
      iio: adc: ad7944: add support for chain mode
      docs: iio: ad7944: add documentation for chain mode

Dimitri Fedrau (1):
      iio: temperature: mcp9600: Fix temperature reading for negative values

Dumitru Ceclan (6):
      dt-bindings: adc: add AD7173
      iio: adc: ad_sigma_delta: Add optional irq selection
      iio: adc: ad7173: add AD7173 driver
      dt-bindings: adc: ad7173: add support for additional models
      iio: adc: ad7173: improve chip id's defines
      iio: adc: ad7173: add support for additional models

Elizabeth Figura (3):
      ntsync: Introduce the ntsync driver and character device.
      ntsync: Introduce NTSYNC_IOC_CREATE_SEM.
      ntsync: Introduce NTSYNC_IOC_SEM_POST.

Fabrice Gasnier (11):
      counter: Introduce the COUNTER_COMP_FREQUENCY() macro
      counter: stm32-timer-cnt: rename quadrature signal
      counter: stm32-timer-cnt: rename counter
      counter: stm32-timer-cnt: adopt signal definitions
      counter: stm32-timer-cnt: introduce clock signal
      counter: stm32-timer-cnt: add counter prescaler extension
      counter: stm32-timer-cnt: add checks on quadrature encoder capability
      counter: stm32-timer-cnt: introduce channels
      counter: stm32-timer-cnt: probe number of channels from registers
      counter: stm32-timer-cnt: add support for overflow events
      counter: stm32-timer-cnt: add support for capture events

Gabriel Schwartz (1):
      iio: adc: rtq6056: Use automated cleanup for mode handling in write_raw

Greg Kroah-Hartman (15):
      Merge tag 'counter-updates-for-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter into char-misc-next
      Merge 6.9-rc5 into char-misc-next
      Merge tag 'iio-for-6.10a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'peci-next-6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/iwi/linux into char-misc-next
      Merge tag 'w1-drv-6.10' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1 into char-misc-next
      Merge tag 'counter-updates-for-6.10b' of git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter into char-misc-next
      Merge tag 'fpga-for-6.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga into char-misc-next
      Merge tag 'mhi-for-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi into char-misc-next
      Merge tag 'coresight-next-v6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux into char-misc-next
      nvmem: core: switch to use device_add_groups()
      Merge tag 'icc-6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-next
      Merge tag 'iio-for-6.10b-take2' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge 6.9-rc7 into char-misc-testing
      Merge tag 'extcon-next-for-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon into char-misc-next
      misc: ntsync: mark driver as "broken" to prevent from building

Gustavo A. R. Silva (1):
      mei: Avoid a bunch of -Wflex-array-member-not-at-end warnings

Gustavo Rodrigues (3):
      iio: adc: ad799x: change 'unsigned' to 'unsigned int' declaration
      iio: adc: ad799x: add blank line to avoid warning messages
      iio: adc: ad799x: Prefer to use octal permission

Hagar Gamal Halim Hemdan (1):
      vmci: prevent speculation leaks by sanitizing event in event_deliver()

Hans de Goede (4):
      iio: core: Add iio_read_acpi_mount_matrix() helper function
      iio: accel: kxcjk-1013: Use new iio_read_acpi_mount_matrix() helper
      iio: bmc150-accel-core: Use iio_read_acpi_mount_matrix() helper
      iio: accel: mxc4005: Read orientation matrix from ACPI ROTM method

Huai-Yuan Liu (1):
      ppdev: Add an error check in register_device

Javier Carrasco (8):
      io: light: st_uvis25: drop casting to void in dev_set_drvdata
      iio: humidity: hts211: drop casting to void in dev_set_drvdata
      iio: imu: st_lsm6dsx: drop casting to void in dev_set_drvdata
      iio: humidity: hdc3020: add power management
      dt-bindings: iio: humidity: hdc3020: add reset-gpios
      iio: humidity: hdc3020: add reset management
      dt-bindings: iio: health: maxim,max30102: add max30101
      iio: health: max30102: add support for max30101

Jean-Baptiste Maneyrol (10):
      iio: imu: inv_mpu6050: add WoM (Wake-on-Motion) sensor
      iio: imu: inv_mpu6050: add WoM event as accel event
      iio: imu: inv_mpu6050: add new interrupt handler for WoM events
      iio: imu: inv_mpu6050: add WoM suspend wakeup with low-power mode
      dt-bindings: iio: imu: add icm42688 inside inv_icm42600
      iio: imu: inv_icm42600: add support of ICM-42688-P
      dt-bindings: iio: imu: add icm42686 inside inv_icm42600
      iio: imu: inv_icm42600: add support of ICM-42686-P
      iio: invensense: fix interrupt timestamp alignment
      iio: invensense: fix timestamp glitches when switching frequency

Jiapeng Chong (2):
      coresight: stm: Remove duplicate linux/acpi.h header
      coresight: Remove duplicate linux/amba/bus.h header

Johan Hovold (2):
      dt-bindings: spmi: hisilicon,hisi-spmi-controller: fix binding references
      dt-bindings: spmi: hisilicon,hisi-spmi-controller: clean up example

Jonathan Cameron (32):
      device property: Move fwnode_handle_put() into property.h
      device property: Add cleanup.h based fwnode_handle_put() scope based cleanup.
      device property: Introduce device_for_each_child_node_scoped()
      iio: adc: max11410: Use device_for_each_child_node_scoped()
      iio: addac: ad74413r: Use device_for_each_child_node_scoped()
      iio: dac: ltc2688: Use device_for_each_child_node_scoped()
      iio: adc: fsl-imx25-gcq: Switch from of specific handing to fwnode based.
      iio: adc: fsl-imx25-gcq: Use devm_* and dev_err_probe() to simplify probe
      iio: adc: ad7124: Switch from of specific to fwnode based property handling
      iio: adc: ad7292: Switch from of specific to fwnode property handling
      iio: adc: ad7192: Convert from of specific to fwnode property handling
      iio: accel: mma8452: Switch from of specific to fwnode property handling.
      iio: accel: fxls8962af: Switch from of specific to fwnode based properties.
      iio: adc: hx711: Switch from of specific to fwnode property handling.
      iio: temp: ltc2983: Use __free(fwnode_handle) and device_for_each_node_scoped()
      iio: adc: rzg2l_adc: Use device_for_each_child_node_scoped()
      iio: adc: rcar-gyroadc: use for_each_available_child_node_scoped()
      iio: dac: ad3552r: Use device_for_each_child_node_scoped()
      iio: dac: ad5770r: Use device_for_each_child_node_scoped()
      iio: adc: ab8500-gpadc: Fix kernel-doc parameter names.
      iio: adc: ab8500-gpadc: Use device_for_each_child_node_scoped() to simplify erorr paths.
      iio: adc: ad4130: Use device_for_each_child_node_scoped() to simplify error paths.
      iio: adc: ad7173: Use device_for_each_child_node_scoped() to simplify error paths.
      iio: frequency: admfm2000: Use device_for_each_child_node_scoped() to simplify error paths.
      iio: dac: ad3552: Use __free(fwnode_handle) to simplify error handling.
      iio: adc: pac1934: Use device_for_each_available_child_node_scoped() to simplify error handling.
      iio: adc: stm32: Fixing err code to not indicate success
      iio: adc: stm32: Use device_for_each_child_node_scoped()
      iio: adc: qcom-spmi-adc5: Use device_for_each_child_node_scoped()
      iio: adc: mcp3564: Use device_for_each_child_node_scoped()
      Documentation: ABI + trace: hisi_ptt: update paths to bus/event_source
      hwtracing: hisi_ptt: Assign parent for event_source device

Konrad Dybcio (3):
      interconnect: qcom: sm6115: Unspaghettify SNoC QoS port numbering
      interconnect: qcom: qcm2290: Fix mas_snoc_bimc QoS port assignment
      dt-bindings: nvmem: Add compatible for SC8280XP

Krzysztof Kozlowski (12):
      fpga: altera: drop driver owner assignment
      iio: dac: ad5755: make use of of_device_id table
      dt-bindings: arm: qcom,coresight-tpda: drop redundant type from ports
      dt-bindings: arm: qcom,coresight-tpda: fix indentation in the example
      eeprom: at25: drop unneeded MODULE_ALIAS
      eeprom: 93xx46: drop unneeded MODULE_ALIAS
      nvmem: layouts: store owner from modules with nvmem_layout_driver_register()
      nvmem: layouts: onie-tlv: drop driver owner initialization
      nvmem: layouts: sl28vpd: drop driver owner initialization
      nvmem: sc27xx: fix module autoloading
      nvmem: sprd: fix module autoloading
      slimbus: qcom-ctrl: fix module autoloading

Kunwu Chan (2):
      mei: bus: constify the struct mei_cl_bus_type usage
      tifm: constify the struct tifm_bus_type usage

Laurent Pinchart (2):
      dt-bindings: iio: dac: ti,dac5571: Add DAC081C081 support
      iio: dac: ti-dac5571: Add DAC081C081 support

Li Zhijian (1):
      intel_th: Convert sprintf/snprintf to sysfs_emit

Lincoln Yuji (1):
      iio: adc: ti-ads1015: use device_for_each_child_node_scoped()

Lorenzo Bertin Salvador (1):
      iio: adc: ti-ads131e08: Use device_for_each_child_node_scoped() to simplify error paths.

Lothar Rubusch (8):
      iio: accel: adxl345: Make data_range obsolete
      iio: accel: adxl345: Group bus configuration
      iio: accel: adxl345: Move defines to header
      dt-bindings: iio: accel: adxl345: Add spi-3wire
      iio: accel: adxl345: Pass function pointer to core
      iio: accel: adxl345: Reorder probe initialization
      iio: accel: adxl345: Add comment to probe
      iio: accel: adxl345: Add spi-3wire option

Luca Weiss (2):
      Documentation: ABI: document in_temp_input file
      dt-bindings: iio: imu: mpu6050: Improve i2c-gate disallow list

Marco Pagani (4):
      fpga: manager: add owner module and take its refcount
      fpga: bridge: add owner module and take its refcount
      fpga: tests: use KUnit devices instead of platform devices
      fpga: region: add owner module and take its refcount

Marius Cristea (1):
      iio: adc: PAC1934: fix accessing out of bounds array index

Markus Elfring (1):
      spmi: pmic-arb: Replace three IS_ERR() calls by null pointer checks in spmi_pmic_arb_probe()

Mikhail Lappo (3):
      stm class: Add source type
      stm class: Propagate source type to protocols
      stm class: sys-t: Improve ftrace source handling

Mukesh Ojha (2):
      dt-bindings: nvmem: Add compatible for sm8450, sm8550 and sm8650
      nvmem: meson-mx-efuse: Remove nvmem_device from efuse struct

Niklas Schnelle (1):
      /dev/port: don't compile file operations without CONFIG_DEVPORT

Nuno Sa (21):
      iio: core: move to cleanup.h magic
      iio: trigger: move to the cleanup.h magic
      iio: buffer: iio: core: move to the cleanup.h magic
      iio: inkern: move to the cleanup.h magic
      dt-bindings: iio: temperature: ltc2983: document power supply
      iio: temperature: ltc2983: support vdd regulator
      iio: buffer-dma: add iio_dmaengine_buffer_setup()
      dt-bindings: iio: dac: add docs for AXI DAC IP
      dt-bindings: iio: dac: add docs for AD9739A
      iio: backend: add new functionality
      iio: dac: add support for AXI DAC IP core
      iio: dac: support the ad9739a RF DAC
      iio: adc: adi-axi-adc: only error out in major version mismatch
      dt-bindings: adc: axi-adc: add clocks property
      iio: adc: axi-adc: make sure AXI clock is enabled
      iio: backend: change docs padding
      iio: backend: add API for interface tuning
      iio: adc: adi-axi-adc: remove regmap max register
      iio: adc: adi-axi-adc: support digital interface calibration
      iio: adc: ad9467: support digital interface calibration
      iio: dac: ad9739a: write complete MU_CNT1 register during lock

Paul Cercueil (4):
      iio: buffer-dma: Rename iio_dma_buffer_data_available()
      iio: buffer-dma: Enable buffer write support
      iio: buffer-dmaengine: Support specifying buffer direction
      iio: buffer-dmaengine: Enable write support

Peter Colberg (2):
      fpga: dfl: remove unused function is_dfl_feature_present()
      fpga: dfl: remove unused member pdata from struct dfl_{afu,fme}

Prasad Pandit (2):
      misc: sgi_gru: indent SGI_GRU option help text
      misc: sgi_gru: remove default attribute of LATTICE_ECP3_CONFIG

Qiang Yu (3):
      bus: mhi: host: Add sysfs entry to force device to enter EDL
      bus: mhi: host: Add a new API for getting channel doorbell offset
      bus: mhi: host: pci_generic: Add generic edl_trigger to allow devices to enter EDL mode

Ramona Gradinariu (1):
      docs: iio: adis16475: fix device files tables

Randy Dunlap (3):
      counter: linux/counter.h: fix Excess kernel-doc description warning
      intel_th: msu: Fix kernel-doc warnings
      extcon: max8997: select IRQ_DOMAIN instead of depending on it

Remington Brasga (1):
      coresight:  Docs/ABI/testing/sysfs-bus-coresight-devices: Fix spelling errors

Ricardo B. Marliere (6):
      counter: make counter_bus_type const
      counter: constify the struct device_type usage
      peci: Make peci_bus_type const
      peci: constify the struct device_type usage
      intel_th: Constify the struct device_type usage
      spmi: make spmi_bus_type const

Ricky Wu (1):
      misc: rtsx: do clear express reg every SD_INT

Samuel Thibault (1):
      speakup: Turn i18n files utf-8

Saurabh Sengar (7):
      Drivers: hv: vmbus: Add utility function for querying ring size
      uio_hv_generic: Query the ringbuffer size for device
      uio_hv_generic: Enable interrupt for low speed VMBus devices
      tools: hv: Add vmbus_bufring
      tools: hv: Add new fcopy application based on uio driver
      Drivers: hv: Remove fcopy driver
      uio_hv_generic: Remove use of PAGE_SIZE

Sean Anderson (1):
      misc: ds1682: Add NVMEM support

Sicong Huang (1):
      greybus: Fix use-after-free bug in gb_interface_release due to race condition.

Subhajit Ghosh (7):
      dt-bindings: iio: light: Merge APDS9300 and APDS9960 schemas
      dt-bindings: iio: light: adps9300: Add missing vdd-supply
      dt-bindings: iio: light: adps9300: Update interrupt definitions
      dt-bindings: iio: light: Avago APDS9306
      iio: light: Add support for APDS9306 Light Sensor
      iio: light: apds9306: Improve apds9306_write_event_config()
      iio: light: apds9306: Fix input arguments to in_range()

Suzuki K Poulose (4):
      coresight: etm4x: Do not hardcode IOMEM access for register restore
      coresight: etm4x: Do not save/restore Data trace control registers
      coresight: etm4x: Safe access for TRCQCLTR
      coresight: etm4x: Fix access to resource selector registers

Thomas Haemmerle (4):
      iio: pressure: dps310: support negative temperature values
      iio: pressure: dps310: introduce consistent error handling
      iio: pressure: dps310: consistently check return value of `regmap_read`
      iio: pressure: dps310: simplify scale factor reading

Thomas Weißschuh (3):
      misc/pvpanic: use bit macros
      misc/pvpanic: add shutdown event definition
      misc/pvpanic: add support for normal shutdowns

Thorsten Blum (1):
      virt: acrn: Fix typos

Uwe Kleine-König (23):
      counter: ti-ecap-capture: Convert to platform remove callback returning void
      counter: ti-eqep: Convert to platform remove callback returning void
      uio: fsl_elbc_gpcm: Convert to platform remove callback returning void
      ndtest: Convert to platform remove callback returning void
      powerpc/powernv: Convert to platform remove callback returning void
      sonypi: Convert to platform remove callback returning void
      cdx: Convert to platform remove callback returning void
      coresight: catu: Convert to platform remove callback returning void
      coresight: debug: Convert to platform remove callback returning void
      coresight: stm: Convert to platform remove callback returning void
      coresight: tmc: Convert to platform remove callback returning void
      coresight: tpiu: Convert to platform remove callback returning void
      mcb: lpc: Convert to platform remove callback returning void
      nvmem: lpc18xx_eeprom: Convert to platform remove callback returning void
      slimbus: Convert to platform remove callback returning void
      intel_th: Convert to platform remove callback returning void
      extcon: adc-jack: Convert to platform remove callback returning void
      extcon: intel-cht-wc: Convert to platform remove callback returning void
      extcon: intel-mrfld: Convert to platform remove callback returning void
      extcon: max3355: Convert to platform remove callback returning void
      extcon: max77843: Convert to platform remove callback returning void
      extcon: usb-gpio: Convert to platform remove callback returning void
      extcon: usbc-cros-ec: Convert to platform remove callback returning void

Vamshi Gajjela (1):
      spmi: hisi-spmi-controller: Do not override device identifier

Vasileios Amoiridis (1):
      iio: pressure: BMP280 core driver headers sorting

Viken Dadhaniya (1):
      slimbus: qcom-ngd-ctrl: Reduce auto suspend delay

William Breathitt Gray (2):
      MAINTAINERS: Update email addresses for William Breathitt Gray
      counter: ti-ecap-capture: Utilize COUNTER_COMP_FREQUENCY macro

Wolfram Sang (8):
      iio: adc: ad_sigma_delta: use 'time_left' variable with wait_for_completion_timeout()
      iio: adc: exynos_adc: use 'time_left' variable with wait_for_completion_timeout()
      iio: adc: fsl-imx25-gcq: use 'time_left' variable with wait_for_completion_interruptible_timeout()
      iio: adc: intel_mrfld_adc: use 'time_left' variable with wait_for_completion_interruptible_timeout()
      iio: adc: stm32-adc: use 'time_left' variable with wait_for_completion_interruptible_timeout()
      iio: adc: stm32-dfsdm-adc: use 'time_left' variable with wait_for_completion_interruptible_timeout()
      iio: adc: twl6030-gpadc: use 'time_left' variable with wait_for_completion_interruptible_timeout()
      iio: pressure: zpa2326: use 'time_left' variable with wait_for_completion_interruptible_timeout()

Yang Li (1):
      extcon: adc-jack: Document missing struct members

 Documentation/ABI/stable/sysfs-bus-mhi             |   13 +
 .../ABI/testing/sysfs-bus-coresight-devices-etm3x  |    2 +-
 .../ABI/testing/sysfs-bus-coresight-devices-tmc    |    2 +-
 .../ABI/testing/sysfs-bus-coresight-devices-tpdm   |    2 +-
 ...ptt => sysfs-bus-event_source-devices-hisi_ptt} |   12 +-
 Documentation/ABI/testing/sysfs-bus-iio            |    3 +-
 Documentation/ABI/testing/sysfs-bus-iio-ad9739a    |   19 +
 .../bindings/arm/qcom,coresight-tpda.yaml          |   34 +-
 .../bindings/fpga/xlnx,fpga-selectmap.yaml         |   86 ++
 .../devicetree/bindings/iio/accel/adi,adxl345.yaml |    2 +
 .../devicetree/bindings/iio/adc/adi,ad7173.yaml    |  279 ++++
 .../devicetree/bindings/iio/adc/adi,ad7944.yaml    |  213 +++
 .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   |    5 +
 .../iio/adc/allwinner,sun20i-d1-gpadc.yaml         |    9 +-
 .../devicetree/bindings/iio/dac/adi,ad9739a.yaml   |   95 ++
 .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   |   62 +
 .../devicetree/bindings/iio/dac/ti,dac5571.yaml    |    1 +
 .../bindings/iio/health/maxim,max30102.yaml        |   12 +-
 .../bindings/iio/humidity/ti,hdc3020.yaml          |    5 +
 .../bindings/iio/imu/invensense,icm42600.yaml      |    2 +
 .../bindings/iio/imu/invensense,mpu6050.yaml       |   17 +-
 .../bindings/iio/light/avago,apds9300.yaml         |   20 +-
 .../bindings/iio/light/avago,apds9960.yaml         |   44 -
 .../bindings/iio/temperature/adi,ltc2983.yaml      |    4 +
 .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |    4 +
 .../devicetree/bindings/nvmem/qcom,spmi-sdam.yaml  |    2 +-
 .../spmi/hisilicon,hisi-spmi-controller.yaml       |   17 +-
 .../bindings/spmi/qcom,spmi-pmic-arb.yaml          |    1 +
 .../bindings/spmi/qcom,x1e80100-spmi-pmic-arb.yaml |  136 ++
 Documentation/driver-api/fpga/fpga-bridge.rst      |    7 +-
 Documentation/driver-api/fpga/fpga-mgr.rst         |   34 +-
 Documentation/driver-api/fpga/fpga-region.rst      |   13 +-
 Documentation/iio/ad7944.rst                       |  156 +++
 Documentation/iio/adis16475.rst                    |    8 +-
 Documentation/iio/index.rst                        |    1 +
 Documentation/trace/hisi-ptt.rst                   |    4 +-
 Documentation/userspace-api/ioctl/ioctl-number.rst |    2 +
 MAINTAINERS                                        |   60 +-
 drivers/accessibility/speakup/devsynth.c           |   57 +-
 drivers/accessibility/speakup/speakup.h            |    2 +
 drivers/accessibility/speakup/synth.c              |   92 +-
 drivers/acpi/arm64/amba.c                          |    8 -
 drivers/android/binder.c                           |    2 +-
 drivers/android/binder_internal.h                  |    2 +-
 drivers/base/property.c                            |   14 -
 drivers/bus/mhi/host/init.c                        |   41 +-
 drivers/bus/mhi/host/internal.h                    |    4 +-
 drivers/bus/mhi/host/main.c                        |   16 +
 drivers/bus/mhi/host/pci_generic.c                 |   45 +
 drivers/bus/mhi/host/pm.c                          |   42 +-
 drivers/cdx/controller/cdx_controller.c            |    6 +-
 drivers/char/mem.c                                 |    6 +-
 drivers/char/powernv-op-panel.c                    |    5 +-
 drivers/char/ppdev.c                               |   15 +-
 drivers/char/sonypi.c                              |    6 +-
 drivers/comedi/drivers/cb_pcidas64.c               |    5 -
 drivers/counter/counter-core.c                     |    4 +-
 drivers/counter/stm32-timer-cnt.c                  |  461 ++++++-
 drivers/counter/ti-ecap-capture.c                  |    8 +-
 drivers/counter/ti-eqep.c                          |    6 +-
 drivers/extcon/Kconfig                             |    3 +-
 drivers/extcon/extcon-adc-jack.c                   |    8 +-
 drivers/extcon/extcon-intel-cht-wc.c               |    6 +-
 drivers/extcon/extcon-intel-mrfld.c                |   26 +-
 drivers/extcon/extcon-max3355.c                    |    6 +-
 drivers/extcon/extcon-max77843.c                   |    6 +-
 drivers/extcon/extcon-rtk-type-c.c                 |    1 -
 drivers/extcon/extcon-usb-gpio.c                   |    6 +-
 drivers/extcon/extcon-usbc-cros-ec.c               |    6 +-
 drivers/fpga/Kconfig                               |   12 +
 drivers/fpga/Makefile                              |    2 +
 drivers/fpga/altera-cvp.c                          |    1 -
 drivers/fpga/altera-ps-spi.c                       |    1 -
 drivers/fpga/dfl-afu-main.c                        |    2 -
 drivers/fpga/dfl-afu.h                             |    3 -
 drivers/fpga/dfl-fme-main.c                        |    2 -
 drivers/fpga/dfl-fme.h                             |    2 -
 drivers/fpga/dfl.h                                 |    5 -
 drivers/fpga/fpga-bridge.c                         |   57 +-
 drivers/fpga/fpga-mgr.c                            |   82 +-
 drivers/fpga/fpga-region.c                         |   24 +-
 drivers/fpga/ice40-spi.c                           |    4 +-
 drivers/fpga/tests/fpga-bridge-test.c              |   33 +-
 drivers/fpga/tests/fpga-mgr-test.c                 |   16 +-
 drivers/fpga/tests/fpga-region-test.c              |   41 +-
 drivers/fpga/xilinx-core.c                         |  229 ++++
 drivers/fpga/xilinx-core.h                         |   27 +
 drivers/fpga/xilinx-selectmap.c                    |   95 ++
 drivers/fpga/xilinx-spi.c                          |  224 +---
 drivers/greybus/interface.c                        |    1 +
 drivers/hv/Makefile                                |    2 +-
 drivers/hv/channel_mgmt.c                          |   15 +-
 drivers/hv/hv_fcopy.c                              |  427 ------
 drivers/hv/hv_util.c                               |   12 -
 drivers/hv/hyperv_vmbus.h                          |    5 +
 drivers/hwtracing/coresight/coresight-catu.c       |  137 +-
 drivers/hwtracing/coresight/coresight-catu.h       |    1 +
 drivers/hwtracing/coresight/coresight-core.c       |   29 +
 drivers/hwtracing/coresight/coresight-cpu-debug.c  |  137 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c |   29 +-
 drivers/hwtracing/coresight/coresight-etm4x.h      |   31 +-
 drivers/hwtracing/coresight/coresight-funnel.c     |   87 +-
 drivers/hwtracing/coresight/coresight-priv.h       |   10 +
 drivers/hwtracing/coresight/coresight-replicator.c |   82 +-
 drivers/hwtracing/coresight/coresight-stm.c        |  114 +-
 drivers/hwtracing/coresight/coresight-tmc-core.c   |  181 ++-
 drivers/hwtracing/coresight/coresight-tmc.h        |    2 +
 drivers/hwtracing/coresight/coresight-tpiu.c       |  120 +-
 drivers/hwtracing/intel_th/acpi.c                  |    6 +-
 drivers/hwtracing/intel_th/core.c                  |    8 +-
 drivers/hwtracing/intel_th/gth.c                   |    8 +-
 drivers/hwtracing/intel_th/msu.c                   |   12 +-
 drivers/hwtracing/intel_th/pci.c                   |   30 +
 drivers/hwtracing/intel_th/sth.c                   |    2 +-
 drivers/hwtracing/ptt/hisi_ptt.c                   |    1 +
 drivers/hwtracing/stm/console.c                    |    1 +
 drivers/hwtracing/stm/core.c                       |   19 +-
 drivers/hwtracing/stm/ftrace.c                     |    1 +
 drivers/hwtracing/stm/heartbeat.c                  |    1 +
 drivers/hwtracing/stm/p_basic.c                    |    3 +-
 drivers/hwtracing/stm/p_sys-t.c                    |   93 +-
 drivers/hwtracing/stm/stm.h                        |    2 +-
 drivers/iio/Makefile                               |    1 +
 drivers/iio/accel/adxl345.h                        |   36 +-
 drivers/iio/accel/adxl345_core.c                   |   92 +-
 drivers/iio/accel/adxl345_i2c.c                    |    2 +-
 drivers/iio/accel/adxl345_spi.c                    |   10 +-
 drivers/iio/accel/adxl367.c                        |    2 +-
 drivers/iio/accel/bmc150-accel-core.c              |   44 +-
 drivers/iio/accel/fxls8962af-core.c                |   10 +-
 drivers/iio/accel/kxcjk-1013.c                     |   80 +-
 drivers/iio/accel/mma8452.c                        |    6 +-
 drivers/iio/accel/mxc4005.c                        |   22 +
 drivers/iio/adc/Kconfig                            |   27 +
 drivers/iio/adc/Makefile                           |    2 +
 drivers/iio/adc/ab8500-gpadc.c                     |    8 +-
 drivers/iio/adc/ad4130.c                           |    7 +-
 drivers/iio/adc/ad7124.c                           |   55 +-
 drivers/iio/adc/ad7173.c                           | 1180 +++++++++++++++++
 drivers/iio/adc/ad7192.c                           |   38 +-
 drivers/iio/adc/ad7266.c                           |    1 -
 drivers/iio/adc/ad7292.c                           |   13 +-
 drivers/iio/adc/ad7944.c                           |  690 ++++++++++
 drivers/iio/adc/ad799x.c                           |    7 +-
 drivers/iio/adc/ad9467.c                           |  374 +++++-
 drivers/iio/adc/ad_sigma_delta.c                   |   29 +-
 drivers/iio/adc/adi-axi-adc.c                      |  147 ++-
 drivers/iio/adc/exynos_adc.c                       |   16 +-
 drivers/iio/adc/fsl-imx25-gcq.c                    |  150 +--
 drivers/iio/adc/hx711.c                            |    5 +-
 drivers/iio/adc/intel_mrfld_adc.c                  |   12 +-
 drivers/iio/adc/max11410.c                         |   27 +-
 drivers/iio/adc/mcp3564.c                          |   16 +-
 drivers/iio/adc/mxs-lradc-adc.c                    |    1 -
 drivers/iio/adc/pac1934.c                          |   86 +-
 drivers/iio/adc/qcom-spmi-adc5.c                   |    7 +-
 drivers/iio/adc/rcar-gyroadc.c                     |   21 +-
 drivers/iio/adc/rtq6056.c                          |   34 +-
 drivers/iio/adc/rzg2l_adc.c                        |   11 +-
 drivers/iio/adc/spear_adc.c                        |   25 +-
 drivers/iio/adc/stm32-adc.c                        |   71 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |   12 +-
 drivers/iio/adc/ti-ads1015.c                       |    5 +-
 drivers/iio/adc/ti-ads131e08.c                     |   12 +-
 drivers/iio/adc/twl4030-madc.c                     |   19 +-
 drivers/iio/adc/twl6030-gpadc.c                    |    8 +-
 drivers/iio/addac/ad74413r.c                       |   10 +-
 drivers/iio/buffer/industrialio-buffer-dma.c       |  100 +-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |   86 +-
 .../iio/common/inv_sensors/inv_sensors_timestamp.c |   33 +-
 drivers/iio/dac/Kconfig                            |   37 +
 drivers/iio/dac/Makefile                           |    2 +
 drivers/iio/dac/ad3552r.c                          |  110 +-
 drivers/iio/dac/ad5755.c                           |   24 +-
 drivers/iio/dac/ad5770r.c                          |   19 +-
 drivers/iio/dac/ad9739a.c                          |  464 +++++++
 drivers/iio/dac/adi-axi-dac.c                      |  635 +++++++++
 drivers/iio/dac/ltc2688.c                          |   28 +-
 drivers/iio/dac/ti-dac5571.c                       |    3 +
 drivers/iio/frequency/admfm2000.c                  |   24 +-
 drivers/iio/health/max30102.c                      |    2 +
 drivers/iio/humidity/hdc3020.c                     |  111 +-
 drivers/iio/humidity/hts221_core.c                 |    2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |   37 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |   75 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |   31 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |   26 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |   84 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c    |    6 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c    |    6 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |  542 +++++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |   36 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |   19 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |   83 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |    2 +-
 drivers/iio/industrialio-acpi.c                    |   85 ++
 drivers/iio/industrialio-backend.c                 |  305 ++++-
 drivers/iio/industrialio-buffer.c                  |  124 +-
 drivers/iio/industrialio-core.c                    |   49 +-
 drivers/iio/industrialio-trigger.c                 |   71 +-
 drivers/iio/inkern.c                               |  263 ++--
 drivers/iio/light/Kconfig                          |   12 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/apds9306.c                       | 1361 ++++++++++++++++++++
 drivers/iio/light/st_uvis25_core.c                 |    2 +-
 drivers/iio/light/stk3310.c                        |    1 -
 drivers/iio/pressure/bmp280-core.c                 |   16 +-
 drivers/iio/pressure/dps310.c                      |  138 +-
 drivers/iio/pressure/hsc030pa_spi.c                |    7 +-
 drivers/iio/pressure/zpa2326.c                     |   10 +-
 drivers/iio/temperature/ltc2983.c                  |  142 +-
 drivers/iio/temperature/mcp9600.c                  |    3 +-
 drivers/interconnect/qcom/qcm2290.c                |    2 +-
 drivers/interconnect/qcom/sm6115.c                 |   33 +-
 drivers/mcb/mcb-lpc.c                              |    6 +-
 drivers/misc/Kconfig                               |   31 +-
 drivers/misc/Makefile                              |    1 +
 drivers/misc/cardreader/rtsx_pcr.c                 |   12 +-
 drivers/misc/ds1682.c                              |   37 +
 drivers/misc/eeprom/at25.c                         |    1 -
 drivers/misc/eeprom/eeprom_93xx46.c                |    2 -
 drivers/misc/mei/bus.c                             |    2 +-
 drivers/misc/mei/hw.h                              |    2 -
 drivers/misc/ntsync.c                              |  249 ++++
 drivers/misc/pvpanic/pvpanic.c                     |   43 +-
 drivers/misc/ti-st/st_kim.c                        |    4 +-
 drivers/misc/tifm_core.c                           |    2 +-
 drivers/misc/vmw_vmci/vmci_event.c                 |    6 +-
 drivers/misc/vmw_vmci/vmci_guest.c                 |   10 +-
 drivers/nvmem/core.c                               |    2 +-
 drivers/nvmem/layouts.c                            |    6 +-
 drivers/nvmem/layouts/onie-tlv.c                   |    1 -
 drivers/nvmem/layouts/sl28vpd.c                    |    1 -
 drivers/nvmem/lpc18xx_eeprom.c                     |    6 +-
 drivers/nvmem/meson-mx-efuse.c                     |    6 +-
 drivers/nvmem/sc27xx-efuse.c                       |    1 +
 drivers/nvmem/sprd-efuse.c                         |    1 +
 drivers/parport/parport_mfc3.c                     |    3 +-
 drivers/peci/core.c                                |    4 +-
 drivers/peci/device.c                              |    2 +-
 drivers/peci/internal.h                            |    6 +-
 drivers/slimbus/qcom-ctrl.c                        |    6 +-
 drivers/slimbus/qcom-ngd-ctrl.c                    |   14 +-
 drivers/spmi/hisi-spmi-controller.c                |    1 -
 drivers/spmi/spmi-pmic-arb.c                       |  980 ++++++++------
 drivers/spmi/spmi.c                                |    2 +-
 drivers/uio/Kconfig                                |   18 -
 drivers/uio/Makefile                               |    1 -
 drivers/uio/uio.c                                  |   24 +-
 drivers/uio/uio_fsl_elbc_gpcm.c                    |    6 +-
 drivers/uio/uio_hv_generic.c                       |   19 +-
 drivers/uio/uio_pdrv_genirq.c                      |   10 +-
 drivers/uio/uio_pruss.c                            |  255 ----
 drivers/w1/masters/w1-gpio.c                       |   62 +-
 include/linux/coresight.h                          |    6 +
 include/linux/counter.h                            |    7 +-
 include/linux/fpga/fpga-bridge.h                   |   10 +-
 include/linux/fpga/fpga-mgr.h                      |   26 +-
 include/linux/fpga/fpga-region.h                   |   13 +-
 include/linux/hyperv.h                             |    2 +
 include/linux/iio/adc/ad_sigma_delta.h             |    3 +
 include/linux/iio/backend.h                        |  107 +-
 include/linux/iio/buffer-dma.h                     |    4 +-
 include/linux/iio/buffer-dmaengine.h               |   24 +-
 include/linux/iio/common/inv_sensors_timestamp.h   |    3 +-
 include/linux/iio/iio.h                            |   13 +
 include/linux/mfd/stm32-timers.h                   |   13 +
 include/linux/mhi.h                                |   29 +-
 include/linux/nvmem-provider.h                     |    5 +-
 include/linux/platform_data/uio_pruss.h            |   18 -
 include/linux/property.h                           |   22 +-
 include/linux/stm.h                                |   12 +
 include/uapi/linux/ntsync.h                        |   23 +
 include/uapi/misc/pvpanic.h                        |    7 +-
 samples/acrn/vm-sample.c                           |    4 +-
 scripts/spdxcheck.py                               |    3 +
 tools/hv/Build                                     |    3 +-
 tools/hv/Makefile                                  |   14 +-
 tools/hv/hv_fcopy_daemon.c                         |  266 ----
 tools/hv/hv_fcopy_uio_daemon.c                     |  490 +++++++
 tools/hv/vmbus_bufring.c                           |  318 +++++
 tools/hv/vmbus_bufring.h                           |  158 +++
 tools/testing/nvdimm/test/ndtest.c                 |    5 +-
 283 files changed, 12915 insertions(+), 3995 deletions(-)
 rename Documentation/ABI/testing/{sysfs-devices-hisi_ptt => sysfs-bus-event_source-devices-hisi_ptt} (90%)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-ad9739a
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad9739a.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml
 create mode 100644 Documentation/devicetree/bindings/spmi/qcom,x1e80100-spmi-pmic-arb.yaml
 create mode 100644 Documentation/iio/ad7944.rst
 create mode 100644 drivers/fpga/xilinx-core.c
 create mode 100644 drivers/fpga/xilinx-core.h
 create mode 100644 drivers/fpga/xilinx-selectmap.c
 delete mode 100644 drivers/hv/hv_fcopy.c
 create mode 100644 drivers/iio/adc/ad7173.c
 create mode 100644 drivers/iio/adc/ad7944.c
 create mode 100644 drivers/iio/dac/ad9739a.c
 create mode 100644 drivers/iio/dac/adi-axi-dac.c
 create mode 100644 drivers/iio/industrialio-acpi.c
 create mode 100644 drivers/iio/light/apds9306.c
 create mode 100644 drivers/misc/ntsync.c
 delete mode 100644 drivers/uio/uio_pruss.c
 delete mode 100644 include/linux/platform_data/uio_pruss.h
 create mode 100644 include/uapi/linux/ntsync.h
 delete mode 100644 tools/hv/hv_fcopy_daemon.c
 create mode 100644 tools/hv/hv_fcopy_uio_daemon.c
 create mode 100644 tools/hv/vmbus_bufring.c
 create mode 100644 tools/hv/vmbus_bufring.h

