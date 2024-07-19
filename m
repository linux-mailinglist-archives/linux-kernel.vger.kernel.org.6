Return-Path: <linux-kernel+bounces-257275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A84F19377BC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0105B1F21F28
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62C21353FE;
	Fri, 19 Jul 2024 12:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nGicJb0X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA3375808
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 12:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391992; cv=none; b=h7AZw6ot73OQBU72XugIOPOZci1oSAHt/wveo8qgYC6akJ8yaQ2tRX4l3I+wgSBF8kVbkg+7dMCQZ+ngzGELRdAyorVe+WHLYXbZjTCfw2BTuqJiDQ1Uzv/jHTjqLshaY9fu8hw36l70x0oce3K0+uw8Io8EzpYIXz5qCtvv90w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391992; c=relaxed/simple;
	bh=jV3lNdMrra3mfKK1lqT26jVlwi8KgUwNWSNE+h7tmqU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QnkhEk+2vufRuGQuscTNkb/L6uHdFjIVmWSwEI+FrYehdE/jzLzR5H0fD5rnsBGqhP/LQohK8HoxtU5l4TF+wauPw+jMbR12ZSwqZqMmSV7nqAPrZtd+gFqaxkwxcb/9l2PLyvmPKkVHWoGfD1stIusYflB/M62+cdAqni4K5pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nGicJb0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56719C32782;
	Fri, 19 Jul 2024 12:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721391990;
	bh=jV3lNdMrra3mfKK1lqT26jVlwi8KgUwNWSNE+h7tmqU=;
	h=Date:From:To:Cc:Subject:From;
	b=nGicJb0Xez0u6Fn2ufl05zOuQajrtJNpsqch8/Dl3tJ6D8iUPvfREsBpK2t4ninlk
	 8sYML89TtxFnCMC8I5K+AKnutMj5elr+DfUi9LgGBua3j0MOhb9axbCdkRBu3p0P9B
	 tVeAgKYH9yrYOqKFCm/rZCTx+CmhRKRh5MmpC4oc=
Date: Fri, 19 Jul 2024 14:26:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver changes for 6.11-rc1
Message-ID: <Zppbc65te9pxYeEx@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 22a40d14b572deb80c0648557f4bd502d7e83826:

  Linux 6.10-rc6 (2024-06-30 14:40:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.11-rc1

for you to fetch changes up to 5418e6dfc905b3ccc1e01bdad97d948697b20100:

  misc: Kconfig: exclude mrvl-cn10k-dpi compilation for 32-bit systems (2024-07-18 09:02:37 +0200)

----------------------------------------------------------------
Char/Misc and other driver changes for 6.11-rc1

Here is the "big" set of char/misc and other driver subsystem changes
for 6.11-rc1.  Nothing major in here, just loads of new drivers and
updates.  Included in here are:
  - IIO api updates and new drivers added
  - wait_interruptable_timeout() api cleanups for some drivers
  - MODULE_DESCRIPTION() additions for loads of drivers
  - parport out-of-bounds fix
  - interconnect driver updates and additions
  - mhi driver updates and additions
  - w1 driver fixes
  - binder speedups and fixes
  - eeprom driver updates
  - coresight driver updates
  - counter driver update
  - new misc driver additions
  - other minor api updates

All of these, EXCEPT for the final Kconfig build fix for 32bit systems,
have been in linux-next for a while with no reported issues.  The
Kconfig fixup went in 29 hours ago, so might have missed the latest
linux-next, but was acked by everyone involved.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aidan MacDonald (1):
      iio: adc: axp20x_adc: Add support for AXP192

Alexander Usyskin (1):
      mei: bus-fixup: set timeout for MKHI send operations

Alisa-Dariana Roman (8):
      iio: adc: ad7192: Use standard attribute
      dt-bindings: iio: adc: ad7192: Add aincom supply
      iio: adc: ad7192: Add aincom supply
      dt-bindings: iio: adc: Add single-channel property
      dt-bindings: iio: adc: ad7192: Add AD7194 support
      iio: adc: ad7192: Add AD7194 support
      iio: adc: ad7192: Clean up dev
      MAINTAINERS: Update AD7192 driver maintainer

Amit Vadhavana (1):
      slimbus: Fix struct and documentation alignment in stream.c

Andy Shevchenko (10):
      misc: eeprom_93xx46: Make use of device properties
      eeprom: digsy_mtc: Fix 93xx46 driver probe failure
      eeprom: digsy_mtc: Convert to use GPIO descriptors
      misc: eeprom_93xx46: Hide legacy platform data in the driver
      misc: eeprom_93xx46: Remove ->prepare() and ->finish() customisation
      misc: eeprom_93xx46: Use spi_message_init_with_transfers()
      misc: eeprom_93xx46: Convert to use kstrtox()
      misc: eeprom_93xx46: Replace explicit castings with proper specifiers
      misc: eeprom_93xx46: Use string_choices API instead of ternary operator
      misc: eeprom_93xx46: Convert to DEVICE_ATTR_WO()

Angelo Dureghello (6):
      dt-bindings: iio: dac: fix ad3552r gain parameter names
      dt-bindings: iio: dac: add ad35xxr single output variants
      iio: dac: ad3552r: add model data structure
      iio: dac: ad3552r: add support for ad3541r and ad3551r
      iio: dac: ad3552r: change AD3552R_NUM_CH define name
      iio: dac: ad3552r: uniform structure names

AngeloGioacchino Del Regno (5):
      dt-bindings: interconnect: Add MediaTek EMI Interconnect bindings
      interconnect: mediatek: Add MediaTek MT8183/8195 EMI Interconnect driver
      dt-bindings: iio: adc: Add MediaTek MT6359 PMIC AUXADC
      math.h: Add unsigned 8 bits fractional numbers type
      iio: adc: Add support for MediaTek MT6357/8/9 Auxiliary ADC

Antoni Pokusinski (1):
      iio: humidity: si7020: add heater support

Antoniu Miclaus (3):
      iio: frequency: adrf6780: rm clk provider include
      dt-bindings: iio: adf4350: add clk provider prop
      iio: frequency: adf4350: add clk provider

Armin Wolf (2):
      eeprom: ee1004: Use devres for bus data cleanup
      eeprom: ee1004: Add nvmem support

Arthur Becker (2):
      iio: light: driver for Vishay VEML6040
      dt-bindings: iio: light: add VEML6040 RGBW-LS

Barnabás Czémán (3):
      iio: light: stk3310: relax failure to match id
      iio: light: stk3310: make chip id check expandable
      iio: light: stk3310: support more stk3311 variants

Bruna Bispo (1):
      iio: chemical: ams-iaq-core: clean up codestyle warning

Carlos Llamas (2):
      binder: use bitmap for faster descriptor lookup
      binder: fix hang of unregistered readers

Chenyuan Yang (1):
      iio: Fix the sorting functionality in iio_gts_build_avail_time_table

Christophe JAILLET (4):
      iio: temperature: max30208: Remove an unused field in struct max30208_data
      iio: multiplexer: Remove an unused field in struct mux
      iio: tmag5273: Remove some unused field in struct tmag5273_data
      iio: light: gp2ap020a00f: Remove some unused field in struct gp2ap020a00f_data

Danila Tikhonov (2):
      iio: imu: bmi160: add support for bmi120
      dt-bindings: iio: imu: bmi160: add bmi120

David Lechner (32):
      iio: adc: sort Makefile
      iio: adc: ad7944: remove unused parameter
      dt-bindings: iio: adc: Add binding for AD7380 ADCs
      iio: adc: ad7380: new driver for AD7380 ADCs
      dt-bindings: iio: adc: ad7380: add pseudo-differential parts
      iio: adc: ad7380: add support for pseudo-differential parts
      iio: introduce struct iio_scan_type
      iio: buffer: use struct iio_scan_type to simplify code
      iio: add support for multiple scan types per channel
      iio: adc: ad7380: use spi_optimize_message()
      iio: adc: ad7266: use devm_regulator_get_enable_read_voltage
      iio: adc: ad7292: use devm_regulator_get_enable_read_voltage
      iio: adc: ad7793: use devm_regulator_get_enable_read_voltage
      iio: adc: ad7944: use devm_regulator_get_enable_read_voltage
      Documentation: devres: add missing SPI helpers
      spi: add devm_spi_optimize_message() helper
      spi: add EXPORT_SYMBOL_GPL(devm_spi_optimize_message)
      iio: adc: aspeed_adc: use devm_regulator_get_enable_read_voltage()
      iio: adc: hx711: use devm_regulator_get_enable_read_voltage()
      iio: adc: hx711: remove hx711_remove()
      iio: adc: hx711: use dev_err_probe()
      iio: adc: ltc2309: use devm_regulator_get_enable_read_voltage()
      iio: adc: max1363: use devm_regulator_get_enable_read_voltage()
      iio: adc: ti-adc108s102: use devm_regulator_get_enable_read_voltage()
      iio: adc: ti-ads8688: use devm_regulator_get_enable_read_voltage()
      iio: adc: ti-ads8688: drop ads8688_remove()
      iio: dac: ad3552r: use devm_regulator_get_enable_read_voltage()
      iio: adc: ad7192: use devm_regulator_get_enable_read_voltage
      iio: adc: ad7944: use devm_spi_optimize_message()
      counter: ti-eqep: implement over/underflow events
      counter: ti-eqep: remove unused struct member
      counter: ti-eqep: remove counter_priv() wrapper

Denis Benato (1):
      iio: imu: bmi323: Use iio read_acpi_mount_matrix() helper

Dimitri Fedrau (1):
      iio: temperature: mcp9600: add threshold events support

Dmitry Baryshkov (1):
      MAINTAINERS: CC dri-devel list on Qualcomm FastRPC patches

Dr. David Alan Gilbert (9):
      iio: accel: bmi088: remove unused struct 'bmi088_scale_info'
      iio: adc: pac1934: remove unused struct 'samp_rate_mapping'
      iio: light: rohm-bu27034: remove unused struct 'bu27034_result'
      staging: iio: adt7316: remove unused struct 'adt7316_limit_regs'
      fpga: altera-fpga2sdram: remove unused struct 'prop_map'
      mcb: remove unused struct 'mcb_parse_priv'
      parport: Remove 'drivers' list
      parport: Remove attach function pointer
      parport: Remove parport_driver.devmodel

Dumitru Ceclan (9):
      dt-bindings: iio: adc: Add common-mode-channel property
      dt-bindings: adc: ad7173: add support for ad411x
      iio: adc: ad_sigma_delta: add disable_one callback
      iio: adc: ad7173: refactor channel configuration parsing
      iio: adc: ad7173: refactor ain and vref selection
      iio: adc: ad7173: add support for special inputs
      iio: adc: ad7173: refactor device info structs
      iio: adc: ad7173: document sampling frequency behaviour
      iio: adc: ad7173: Add support for AD411x devices

Dylan Van Assche (2):
      misc: fastrpc: support complete DMA pool access to the DSP
      misc: fastrpc: use coherent pool for untranslated Compute Banks

Ekansh Gupta (1):
      misc: fastrpc: Add missing dev_err newlines

Erick Archer (1):
      iio: event: use sizeof(*pointer) instead of sizeof(type)

Georgi Djakov (4):
      Merge branch 'icc-mtk' into icc-next
      Merge branch 'icc-fixes' into icc-next
      Merge branch 'icc-msm8953' into icc-next
      Merge branch 'icc-rpmh-qos' into icc-next

Gerhard Engleder (2):
      misc: keba: Add basic KEBA CP500 system FPGA support
      misc: keba: Fix missing AUXILIARY_BUS dependency

Greg Kroah-Hartman (12):
      Merge tag 'iio-for-6.11a' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-testing
      Merge tag 'v6.10-rc4' into char-misc-next
      Merge tag 'peci-next-6.11-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/iwi/linux into char-misc-next
      Merge 6.10-rc6 into char-misc-next
      Merge tag 'fpga-for-6.11-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga into char-misc-next
      Merge tag 'w1-drv-6.11' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1 into char-misc-next
      Merge tag 'counter-updates-for-6.11' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/wbg/counter into char-misc-next
      Merge tag 'coresight-next-v6.11' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/coresight/linux into char-misc-next
      Merge tag 'iio-for-6.11b' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'mhi-for-v6.11' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/mani/mhi into char-misc-next
      Merge tag 'icc-6.11-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-next
      misc: delete Makefile.rej

Guenter Roeck (2):
      eeprom: ee1004: Call i2c_new_scanned_device to instantiate thermal sensor
      eeprom: ee1004: Instantiate jc42 devices for DIMMS implementing Rev.1 SPD

Guillaume Stols (2):
      dt-bindings: iio: adc: adi,ad7606: add missing datasheet link
      dt-bindings: iio: adc: adi,ad7606: comment and sort the compatible names

Gustavo Silva (6):
      dt-bindings: vendor-prefixes: add ScioSense
      dt-bindings: iio: chemical: add ENS160 sensor
      iio: chemical: add driver for ENS160 sensor
      iio: chemical: ens160: add triggered buffer support
      iio: chemical: ens160: add power management support
      MAINTAINERS: Add ScioSense ENS160

Gustavo Ueti Fukunaga (1):
      iio: adc: ti-adc161s626: make use of iio_device_claim_direct_scoped()

Heiko Stuebner (3):
      nvmem: rockchip-otp: set add_legacy_fixed_of_cells config option
      nvmem: rockchip-otp: Set type to OTP
      nvmem: rockchip-efuse: set type to OTP

Iwona Winiarska (1):
      peci: aspeed: Clear clock_divider value before setting it

James Clark (1):
      coresight: Fix ref leak when of_coresight_parse_endpoint() fails

Jean-Baptiste Maneyrol (3):
      iio: imu: inv_icm42600: add register caching in the regmap
      iio: document inv_icm42600 driver private sysfs attributes
      iio: imu: inv_icm42600: add support of accel low-power mode

Jeff Johnson (26):
      uio: add missing MODULE_DESCRIPTION() macros
      parport: add missing MODULE_DESCRIPTION()
      dyndbg: add missing MODULE_DESCRIPTION() macro
      lib/math: add missing MODULE_DESCRIPTION() macros
      ppdev: add missing MODULE_DESCRIPTION() macro
      tlclk: add missing MODULE_DESCRIPTION() macro
      char: add missing MODULE_DESCRIPTION() macros
      misc: open-dice: add missing MODULE_DESCRIPTION() macro
      siox: bus-gpio: add missing MODULE_DESCRIPTION()
      interconnect: imx: add missing MODULE_DESCRIPTION() macros
      interconnect: qcom: add missing MODULE_DESCRIPTION() macros
      iio: add missing MODULE_DESCRIPTION() macros
      counter: ftm-quaddec: add missing MODULE_DESCRIPTION() macro
      dtlk: add missing MODULE_DESCRIPTION() macro
      dsp56k: add missing MODULE_DESCRIPTION() macro
      intel_th: msu-sink: add missing MODULE_DESCRIPTION()
      greybus: add missing MODULE_DESCRIPTION() macros
      dca: add missing MODULE_DESCRIPTION() macro
      platform/goldfish: goldfish_pipe: add missing MODULE_DESCRIPTION() macro
      bsr: add missing MODULE_DESCRIPTION() macro
      nvmem: add missing MODULE_DESCRIPTION() macros
      misc: fastrpc: add missing MODULE_DESCRIPTION() macro
      samples: configfs: add missing MODULE_DESCRIPTION() macro
      spmi: add missing MODULE_DESCRIPTION() macros
      agp: uninorth: add missing MODULE_DESCRIPTION() macro
      virtio: add missing MODULE_DESCRIPTION() macro

Jiapeng Chong (1):
      interconnect: mediatek: remove unneeded semicolon

Jonathan Cameron (4):
      iio: adc: ltc2309: Fix endian type passed to be16_to_cpu()
      Merge tag 'dmaengine_topic_dma_vec' into togreg
      Merge tag 'spi-devm-optimize' into togreg
      iio: adc: ad7173: Fix uninitialized symbol is_current_chan

Jorge Harrisonn (1):
      iio: adc: ad7606: using claim_direct_scoped for code simplification

Josua Mayer (1):
      dt-bindings: iio: adc: ti,ads1015: add compatible for tla2021

João Paulo Gonçalves (2):
      dt-bindings: iio: adc: add ti,ads1119
      iio: adc: ti-ads1119: Add driver

Judith Mendez (3):
      dt-bindings: counter: Add new ti,am62-eqep compatible
      counter/ti-eqep: Add new ti-am62-eqep compatible
      counter: ti-eqep: Allow eQEP driver to be built for K3 devices

Julien Stephan (5):
      iio: adc: ad7380: prepare for parts with more channels
      dt-bindings: iio: adc: ad7380: add support for ad738x-4 4 channels variants
      iio: adc: ad7380: add support for ad738x-4 4 channels variants
      iio: adc: ad7380: add oversampling support
      driver: iio: add missing checks on iio_info's callback access

Kaustabh Chakraborty (3):
      iio: accel: st_accel: add support for LIS2DS12
      dt-bindings: iio: st-sensors: add LIS2DS12 accelerometer
      iio: st_sensors: relax WhoAmI check in st_sensors_verify_id()

Konrad Dybcio (1):
      interconnect: qcom: qcm2290: Fix mas_snoc_bimc RPM master ID

Krzysztof Kozlowski (8):
      iio: accel: adxl313: simplify with spi_get_device_match_data()
      iio: accel: adxl355: simplify with spi_get_device_match_data()
      iio: adc: max11205: simplify with spi_get_device_match_data()
      iio: adc: ti-ads131e08: simplify with spi_get_device_match_data()
      iio: adc: ti-tsc2046: simplify with spi_get_device_match_data()
      iio: addac: ad74413r: simplify with spi_get_device_match_data()
      iio: dac: max5522: simplify with spi_get_device_match_data()
      iio: adc: mcp3564: drop redundant open-coded spi_get_device_match_data()

Kuninori Morimoto (1):
      hwtracing: use for_each_endpoint_of_node()

Lei Liu (1):
      binder_alloc: Replace kcalloc with kvcalloc to mitigate OOM issues

Manivannan Sadhasivam (2):
      bus: mhi: ep: Do not allocate memory for MHI objects from DMA zone
      bus: mhi: host: pci_generic: Use unique 'mhi_pci_dev_info' for product families

Marco Pagani (1):
      Revert "fpga: disable KUnit test suites when module support is enabled"

Marek Vasut (4):
      nvmem: Replace spaces with tab in documentation
      nvmem: Document type attribute
      nvmem: Use sysfs_emit() for type attribute
      nvmem: core: Implement force_ro sysfs attribute

MarileneGarcia (1):
      nvmem: meson-efuse: Replacing the use of of_node_put to __free

Matti Vaittinen (1):
      iio: test: gts: test available times and gains sorting

Neil Armstrong (2):
      dt-bindings: iio: adc: amlogic,meson-saradc: add optional power-domains
      dt-bindings: nvmem: amlogic,meson-gx-efuse: add optional power-domains

Nuno Sa (19):
      iio: adc: ad9467: use DMA safe buffer for spi
      iio: adc: ad9467: change struct members padding
      iio: adc: adi-axi-adc: don't allow concurrent enable/disable calls
      iio: adc: adi-axi-adc: make sure DRP is locked on enable
      iio: adc: adi-axi-adc: add platform dependencies
      iio: dac: adi-axi-dac: add platform dependencies
      iio: imu: adis_buffer: split trigger handling
      iio: imu: adis: move to the cleanup magic
      iio: imu: adis: add cleanup based lock helpers
      iio: gyro: adis16260: make use of the new lock helpers
      iio: gyro: adis16260: make use of the new lock helpers
      iio: imu: adis16400: make use of the new lock helpers
      iio: imu: adis16480: make use of the new lock helpers
      iio: imu: adis16475: make use of the new lock helpers
      iio: imu: adis: remove legacy lock helpers
      dev_printk: add new dev_err_probe() helpers
      iio: temperature: ltc2983: convert to dev_err_probe()
      iio: backend: make use of dev_err_cast_probe()
      iio: common: scmi_iio: convert to dev_err_probe()

Odelu Kukatla (4):
      dt-bindings: interconnect: add clock property to enable QOS on SC7280
      interconnect: qcom: icc-rpmh: Add QoS configuration support
      interconnect: qcom: sc7280: enable QoS configuration
      interconnect: qcom: Fix DT backwards compatibility for QoS

Olivier Moysan (1):
      dt-bindings: iio: stm32: dfsdm: fix dtbs warnings on dfsdm audio port

Paul Cercueil (7):
      dmaengine: Add API function dmaengine_prep_peripheral_dma_vec()
      dmaengine: dma-axi-dmac: Implement device_prep_peripheral_dma_vec
      Documentation: dmaengine: Document new dma_vec API
      iio: core: Add new DMABUF interface infrastructure
      iio: buffer-dma: Enable support for DMABUFs
      iio: buffer-dmaengine: Support new DMABUF based userspace API
      Documentation: iio: Document high-speed DMABUF based API

Rafał Miłecki (2):
      dt-bindings: nvmem: mediatek: efuse: add support for MT7981
      dt-bindings: nvmem: mediatek: efuse: add support for MT7988

Ramona Gradinariu (15):
      dt-bindings: iio: imu: Add ADIS16501 compatibles
      drivers: iio: imu: Add support for ADIS16501
      iio: imu: adis_buffer: Add buffer setup API with buffer attributes
      iio: imu: adis16475: Create push single sample API
      drivers: iio: imu: adis16475: generic computation for sample rate
      iio: imu: adis_trigger: Allow level interrupts for FIFO readings
      iio: imu: adis16475: Re-define ADIS16475_DATA
      dt-bindings: iio: imu: Add ADIS1657X family devices compatibles
      drivers: iio: imu: Add support for adis1657x family
      iio: adis16480: make the burst_max_speed configurable
      iio: imu: adis16480.c: Add delta angle and delta velocity channels
      dt-bindings: iio: imu: Add ADIS16545/47 compatibles
      iio: adis16480: add support for adis16545/7 families
      docs: iio: add documentation for interfacing tools
      docs: iio: add documentation for adis16480 driver

Ricardo B. Marliere (1):
      coresight: constify the struct device_type usage

Sanjuán García, Jorge (1):
      mcb: mcb-pci: detect IO mapped devices before requesting resources

Sean Anderson (3):
      iio: Add iio_read_channel_label to inkern API
      hwmon: iio: Add labels from IIO channels
      iio: xilinx-ams: Add labels

Sebastian Ene (2):
      dt-bindings: vcpu_stall_detector: Add a PPI interrupt to the virtual device
      misc: Register a PPI for the vcpu stall detection virtual device

Slark Xiao (3):
      bus: mhi: host: Add support for Foxconn SDX72 modems
      bus: mhi: host: Allow controller drivers to specify name for the MHI controller
      net: wwan: mhi: make default data link id configurable

Subhajit Ghosh (1):
      MAINTAINERS: Add AVAGO APDS9306

Thomas Weißschuh (3):
      nvmem: core: add single sysfs group
      nvmem: core: remove global nvmem_cells_group
      nvmem: core: drop unnecessary range checks in sysfs callbacks

Thorsten Blum (3):
      w1: Add missing newline and fix typos in w1_bus_master comment
      w1: Drop allocation error message
      misc: fastrpc: Use memdup_user()

Tony Luck (1):
      peci, hwmon: Switch to new Intel CPU model defines

Trevor Gamblin (43):
      iio: adc: adi-axi-adc: improve probe() error messaging
      iio: accel: fxls8962af-core: Make use of regmap_set_bits(), regmap_clear_bits()
      iio: accel: kxsd9: Make use of regmap_clear_bits()
      iio: accel: msa311: make use of regmap_clear_bits()
      iio: adc: ad4130: make use of regmap_clear_bits()
      iio: adc: axp20x_adc: make use of regmap_set_bits()
      iio: adc: axp288_adc: make use of regmap_set_bits()
      iio: adc: bcm_iproc_adc: make use of regmap_clear_bits()
      iio: adc: cpcap-adc: make use of regmap_clear_bits(), regmap_set_bits()
      iio: adc: fsl-imx25-gcq: make use of regmap_clear_bits(), regmap_set_bits()
      iio: adc: ina2xx-adc: make use of regmap_clear_bits()
      iio: adc: intel_mrfld_adc: make use of regmap_clear_bits()
      iio: adc: meson_saradc: make use of regmap_clear_bits(), regmap_set_bits()
      iio: adc: mp2629_adc: make use of regmap_clear_bits(), regmap_set_bits()
      iio: adc: berlin2-adc: make use of regmap_clear_bits(), regmap_set_bits()
      iio: adc: qcom-spmi-rradc: make use of regmap_clear_bits(), regmap_set_bits()
      iio: adc: rn5t618-adc: make use of regmap_set_bits()
      iio: adc: sc27xx_adc: make use of regmap_clear_bits(), regmap_set_bits()
      iio: adc: stm32-dfsdm-adc: make use of regmap_clear_bits(), regmap_set_bits()
      iio: dac: ltc2688: make use of regmap_set_bits()
      iio: dac: stm32-dac-core: make use of regmap_set_bits()
      iio: gyro: bmg160_core: make use of regmap_clear_bits()
      iio: gyro: mpu3050-core: make use of regmap_clear_bits(), regmap_set_bits()
      iio: health: afe4403: make use of regmap_clear_bits(), regmap_set_bits()
      iio: health: afe4404: make use of regmap_clear_bits(), regmap_set_bits()
      iio: health: max30100: make use of regmap_set_bits()
      iio: health: max30102: make use of regmap_set_bits()
      iio: imu: inv_icm42600: make use of regmap_clear_bits(), regmap_set_bits()
      iio: light: adux1020: make use of regmap_clear_bits(), regmap_set_bits()
      iio: light: iqs621-als: make use of regmap_clear_bits()
      iio: light: isl29018: make use of regmap_clear_bits()
      iio: light: st_uvis25_core: make use of regmap_clear_bits()
      iio: light: veml6030: make use of regmap_clear_bits()
      iio: magnetometer: ak8974: make use of regmap_set_bits()
      iio: magnetometer: mmc35240: make use of regmap_set_bits()
      iio: pressure: bmp280-core: make use of regmap_clear_bits()
      iio: proximity: sx9324: make use of regmap_set_bits()
      iio: proximity: sx9360: make use of regmap_set_bits()
      iio: proximity: sx9500: make use of regmap_clear_bits(), regmap_set_bits()
      iio: proximity: sx_common: make use of regmap_clear_bits(), regmap_set_bits()
      iio: temperature: mlx90632: make use of regmap_clear_bits()
      iio: trigger: stm32-timer-trigger: make use of regmap_clear_bits(), regmap_set_bits()
      iio: dac: adi-axi-dac: improve probe() error messaging

Uwe Kleine-König (4):
      iio: Drop explicit initialization of struct i2c_device_id::driver_data to 0
      eeprom: Drop explicit initialization of struct i2c_device_id::driver_data to 0
      staging: iio: Drop explicit initialization of struct i2c_device_id::driver_data to 0
      misc: Drop explicit initialization of struct i2c_device_id::driver_data to 0

Val Packett (1):
      iio: accel: mma7660: add mount-matrix support

Vamsi Attunuru (3):
      misc: mrvl-cn10k-dpi: add Octeon CN10K DPI administrative driver
      misc: Kconfig: add a new dependency for MARVELL_CN10K_DPI
      misc: Kconfig: exclude mrvl-cn10k-dpi compilation for 32-bit systems

Vasileios Amoiridis (10):
      iio: pressure: bmp280: Improve indentation and line wrapping
      iio: pressure: bmp280: Use BME prefix for BME280 specifics
      iio: pressure: bmp280: Add identifier names in function definitions
      iio: pressure: bmp280: Add more intuitive name for bmp180_measure()
      iio: pressure: bmp280: Remove dead error checks
      iio: pressure: bmp280: Remove, add and update error messages
      iio: pressure: bmp280: Make error checks consistent
      iio: pressure: bmp280: Use unsigned data types for raw sensor data
      iio: pressure: bmp280: Refactorize reading functions
      iio: pressure: bmp280: Introduce new cleanup routines

Vladimir Lypak (2):
      dt-bindings: interconnect: qcom: Add Qualcomm MSM8953 NoC
      interconnect: qcom: Add MSM8953 driver

Wolfram Sang (4):
      misc: apds990x: use 'time_left' variable with wait_event_interruptible_timeout()
      misc: bh1770glc: use 'time_left' variable with wait_event_interruptible_timeout()
      misc: tifm: use 'time_left' variable with wait_for_completion_timeout()
      misc: ti-st: st_kim: use 'time_left' variable with wait_for_completion_interruptible_timeout()

Yang Li (1):
      coresight: tmc: Remove duplicated include in coresight-tmc-core.c

tuhaowen (1):
      dev/parport: fix the array out-of-bounds risk

 Documentation/ABI/stable/sysfs-bus-nvmem           |   30 +-
 Documentation/ABI/stable/sysfs-driver-misc-cp500   |   25 +
 .../ABI/testing/sysfs-bus-iio-inv_icm42600         |   18 +
 .../devicetree/bindings/counter/ti-eqep.yaml       |   27 +-
 Documentation/devicetree/bindings/iio/adc/adc.yaml |   30 +
 .../devicetree/bindings/iio/adc/adi,ad7173.yaml    |  194 ++-
 .../devicetree/bindings/iio/adc/adi,ad7192.yaml    |   95 ++
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    |  148 +++
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |    5 +-
 .../bindings/iio/adc/amlogic,meson-saradc.yaml     |    3 +
 .../bindings/iio/adc/mediatek,mt6359-auxadc.yaml   |   33 +
 .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml       |    4 +
 .../devicetree/bindings/iio/adc/ti,ads1015.yaml    |    1 +
 .../devicetree/bindings/iio/adc/ti,ads1119.yaml    |  155 +++
 .../bindings/iio/chemical/sciosense,ens160.yaml    |   70 ++
 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   |   43 +-
 .../bindings/iio/frequency/adi,adf4350.yaml        |    6 +
 .../devicetree/bindings/iio/imu/adi,adis16475.yaml |   31 +
 .../devicetree/bindings/iio/imu/adi,adis16480.yaml |    6 +
 .../devicetree/bindings/iio/imu/bosch,bmi160.yaml  |    6 +-
 .../bindings/iio/light/vishay,veml6075.yaml        |    9 +-
 .../devicetree/bindings/iio/st,st-sensors.yaml     |    1 +
 .../bindings/interconnect/mediatek,mt8183-emi.yaml |   51 +
 .../bindings/interconnect/qcom,msm8953.yaml        |  101 ++
 .../bindings/interconnect/qcom,sc7280-rpmh.yaml    |   53 +
 .../bindings/misc/qemu,vcpu-stall-detector.yaml    |    6 +
 .../bindings/nvmem/amlogic,meson-gxbb-efuse.yaml   |    3 +
 .../devicetree/bindings/nvmem/mediatek,efuse.yaml  |    2 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 Documentation/driver-api/dmaengine/client.rst      |    9 +
 Documentation/driver-api/dmaengine/provider.rst    |   10 +
 Documentation/driver-api/driver-model/devres.rst   |    3 +
 Documentation/iio/adis16475.rst                    |   23 +-
 Documentation/iio/adis16480.rst                    |  443 +++++++
 Documentation/iio/iio_dmabuf_api.rst               |   54 +
 Documentation/iio/iio_tools.rst                    |   27 +
 Documentation/iio/index.rst                        |    3 +
 Documentation/misc-devices/index.rst               |    1 +
 Documentation/misc-devices/mrvl_cn10k_dpi.rst      |   52 +
 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 +
 MAINTAINERS                                        |   42 +-
 drivers/android/binder.c                           |  116 +-
 drivers/android/binder_alloc.c                     |   10 +-
 drivers/android/binder_internal.h                  |    5 +-
 drivers/android/dbitmap.h                          |  176 +++
 drivers/ata/pata_parport/pata_parport.c            |    1 -
 drivers/auxdisplay/ks0108.c                        |    1 -
 drivers/auxdisplay/panel.c                         |    1 -
 drivers/bus/mhi/ep/main.c                          |   14 +-
 drivers/bus/mhi/host/pci_generic.c                 |  128 +-
 drivers/char/agp/uninorth-agp.c                    |    1 +
 drivers/char/bsr.c                                 |    1 +
 drivers/char/dsp56k.c                              |    1 +
 drivers/char/dtlk.c                                |    1 +
 drivers/char/lp.c                                  |    2 +-
 drivers/char/nvram.c                               |    1 +
 drivers/char/ppdev.c                               |    2 +-
 drivers/char/tlclk.c                               |    1 +
 drivers/char/ttyprintk.c                           |    1 +
 drivers/counter/Kconfig                            |    2 +-
 drivers/counter/ftm-quaddec.c                      |    1 +
 drivers/counter/ti-eqep.c                          |  131 +-
 drivers/dca/dca-core.c                             |    1 +
 drivers/dma/dma-axi-dmac.c                         |   40 +
 drivers/fpga/altera-fpga2sdram.c                   |    6 -
 drivers/fpga/tests/Kconfig                         |    4 +-
 drivers/greybus/core.c                             |    1 +
 drivers/greybus/es2.c                              |    1 +
 drivers/hwmon/iio_hwmon.c                          |   45 +-
 drivers/hwmon/peci/cputemp.c                       |    8 +-
 drivers/hwtracing/coresight/coresight-platform.c   |    8 +-
 drivers/hwtracing/coresight/coresight-priv.h       |    2 +-
 drivers/hwtracing/coresight/coresight-sysfs.c      |    2 +-
 drivers/hwtracing/coresight/coresight-tmc-core.c   |    1 -
 drivers/hwtracing/intel_th/msu-sink.c              |    1 +
 drivers/i2c/busses/i2c-parport.c                   |    1 -
 drivers/iio/Kconfig                                |    1 +
 drivers/iio/accel/adxl313_spi.c                    |    8 +-
 drivers/iio/accel/adxl355_spi.c                    |   10 +-
 drivers/iio/accel/adxl367_i2c.c                    |    4 +-
 drivers/iio/accel/adxl372_i2c.c                    |    2 +-
 drivers/iio/accel/bma400_i2c.c                     |    2 +-
 drivers/iio/accel/bmi088-accel-core.c              |    5 -
 drivers/iio/accel/da311.c                          |    2 +-
 drivers/iio/accel/dmard06.c                        |    6 +-
 drivers/iio/accel/dmard09.c                        |    4 +-
 drivers/iio/accel/dmard10.c                        |    2 +-
 drivers/iio/accel/fxls8962af-core.c                |   18 +-
 drivers/iio/accel/kxsd9-i2c.c                      |    4 +-
 drivers/iio/accel/kxsd9.c                          |    5 +-
 drivers/iio/accel/mc3230.c                         |    2 +-
 drivers/iio/accel/mma7455_i2c.c                    |    4 +-
 drivers/iio/accel/mma7660.c                        |   52 +-
 drivers/iio/accel/mma9551.c                        |    2 +-
 drivers/iio/accel/mma9553.c                        |    4 +-
 drivers/iio/accel/msa311.c                         |    8 +-
 drivers/iio/accel/mxc4005.c                        |    6 +-
 drivers/iio/accel/mxc6255.c                        |    4 +-
 drivers/iio/accel/st_accel.h                       |    1 +
 drivers/iio/accel/st_accel_core.c                  |   81 ++
 drivers/iio/accel/st_accel_i2c.c                   |    5 +
 drivers/iio/accel/st_accel_spi.c                   |    5 +
 drivers/iio/accel/stk8312.c                        |    4 +-
 drivers/iio/accel/stk8ba50.c                       |    2 +-
 drivers/iio/adc/Kconfig                            |   52 +-
 drivers/iio/adc/Makefile                           |   27 +-
 drivers/iio/adc/ad4130.c                           |    4 +-
 drivers/iio/adc/ad7124.c                           |   14 +-
 drivers/iio/adc/ad7173.c                           |  676 +++++++---
 drivers/iio/adc/ad7192.c                           |  361 ++++--
 drivers/iio/adc/ad7266.c                           |   33 +-
 drivers/iio/adc/ad7291.c                           |    2 +-
 drivers/iio/adc/ad7292.c                           |   36 +-
 drivers/iio/adc/ad7380.c                           |  833 ++++++++++++
 drivers/iio/adc/ad7606.c                           |   19 +-
 drivers/iio/adc/ad7793.c                           |   24 +-
 drivers/iio/adc/ad7944.c                           |   88 +-
 drivers/iio/adc/ad9467.c                           |  103 +-
 drivers/iio/adc/ad_sigma_delta.c                   |    1 +
 drivers/iio/adc/adi-axi-adc.c                      |   27 +-
 drivers/iio/adc/aspeed_adc.c                       |   30 +-
 drivers/iio/adc/axp20x_adc.c                       |  284 ++++-
 drivers/iio/adc/axp288_adc.c                       |    4 +-
 drivers/iio/adc/bcm_iproc_adc.c                    |    8 +-
 drivers/iio/adc/berlin2-adc.c                      |   24 +-
 drivers/iio/adc/cpcap-adc.c                        |   46 +-
 drivers/iio/adc/fsl-imx25-gcq.c                    |   16 +-
 drivers/iio/adc/hx711.c                            |   78 +-
 drivers/iio/adc/ina2xx-adc.c                       |    3 +-
 drivers/iio/adc/ingenic-adc.c                      |    1 +
 drivers/iio/adc/intel_mrfld_adc.c                  |    4 +-
 drivers/iio/adc/ltc2309.c                          |   45 +-
 drivers/iio/adc/ltc2485.c                          |    2 +-
 drivers/iio/adc/max11205.c                         |    5 +-
 drivers/iio/adc/max1363.c                          |   28 +-
 drivers/iio/adc/mcp3564.c                          |    6 -
 drivers/iio/adc/meson_saradc.c                     |  101 +-
 drivers/iio/adc/mp2629_adc.c                       |   19 +-
 drivers/iio/adc/mt6359-auxadc.c                    |  606 +++++++++
 drivers/iio/adc/nau7802.c                          |    2 +-
 drivers/iio/adc/pac1934.c                          |    5 -
 drivers/iio/adc/qcom-spmi-rradc.c                  |   50 +-
 drivers/iio/adc/rn5t618-adc.c                      |    5 +-
 drivers/iio/adc/sc27xx_adc.c                       |   41 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |   29 +-
 drivers/iio/adc/ti-adc108s102.c                    |   28 +-
 drivers/iio/adc/ti-adc161s626.c                    |   18 +-
 drivers/iio/adc/ti-ads1119.c                       |  825 ++++++++++++
 drivers/iio/adc/ti-ads131e08.c                     |    4 +-
 drivers/iio/adc/ti-ads7924.c                       |    2 +-
 drivers/iio/adc/ti-ads8688.c                       |   59 +-
 drivers/iio/adc/ti-tsc2046.c                       |    7 +-
 drivers/iio/adc/xilinx-ams.c                       |  108 +-
 drivers/iio/addac/ad74413r.c                       |   13 +-
 drivers/iio/buffer/industrialio-buffer-dma.c       |  178 ++-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |   64 +-
 drivers/iio/buffer/kfifo_buf.c                     |    1 +
 drivers/iio/chemical/Kconfig                       |   20 +
 drivers/iio/chemical/Makefile                      |    3 +
 drivers/iio/chemical/ams-iaq-core.c                |    4 +-
 drivers/iio/chemical/bme680_i2c.c                  |    4 +-
 drivers/iio/chemical/ccs811.c                      |    2 +-
 drivers/iio/chemical/ens160.h                      |   10 +
 drivers/iio/chemical/ens160_core.c                 |  367 ++++++
 drivers/iio/chemical/ens160_i2c.c                  |   62 +
 drivers/iio/chemical/ens160_spi.c                  |   61 +
 drivers/iio/common/scmi_sensors/scmi_iio.c         |   45 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |    3 +-
 drivers/iio/dac/Kconfig                            |    1 +
 drivers/iio/dac/ad3552r.c                          |  168 ++-
 drivers/iio/dac/adi-axi-dac.c                      |    9 +-
 drivers/iio/dac/ltc2688.c                          |    5 +-
 drivers/iio/dac/max5522.c                          |   11 +-
 drivers/iio/dac/mcp4728.c                          |    2 +-
 drivers/iio/dac/stm32-dac-core.c                   |    5 +-
 drivers/iio/frequency/adf4350.c                    |  124 +-
 drivers/iio/frequency/adrf6780.c                   |    1 -
 drivers/iio/gyro/adis16136.c                       |   26 +-
 drivers/iio/gyro/adis16260.c                       |   19 +-
 drivers/iio/gyro/bmg160_core.c                     |    4 +-
 drivers/iio/gyro/bmg160_i2c.c                      |    6 +-
 drivers/iio/gyro/fxas21002c_i2c.c                  |    2 +-
 drivers/iio/gyro/itg3200_core.c                    |    2 +-
 drivers/iio/gyro/mpu3050-core.c                    |   35 +-
 drivers/iio/health/afe4403.c                       |    9 +-
 drivers/iio/health/afe4404.c                       |   11 +-
 drivers/iio/health/max30100.c                      |    7 +-
 drivers/iio/health/max30102.c                      |    5 +-
 drivers/iio/humidity/am2315.c                      |    2 +-
 drivers/iio/humidity/hdc100x.c                     |   12 +-
 drivers/iio/humidity/si7005.c                      |    4 +-
 drivers/iio/humidity/si7020.c                      |  141 ++-
 drivers/iio/iio_core.h                             |    4 +
 drivers/iio/imu/Kconfig                            |    4 +-
 drivers/iio/imu/adis.c                             |   11 +-
 drivers/iio/imu/adis16400.c                        |   72 +-
 drivers/iio/imu/adis16475.c                        |  823 ++++++++++--
 drivers/iio/imu/adis16480.c                        |  458 +++++--
 drivers/iio/imu/adis_buffer.c                      |   73 +-
 drivers/iio/imu/adis_trigger.c                     |   37 +-
 drivers/iio/imu/bmi160/bmi160_core.c               |   26 +-
 drivers/iio/imu/bmi160/bmi160_i2c.c                |    5 +-
 drivers/iio/imu/bmi160/bmi160_spi.c                |    3 +
 drivers/iio/imu/bmi323/bmi323_core.c               |    8 +-
 drivers/iio/imu/bno055/bno055_i2c.c                |    2 +-
 drivers/iio/imu/fxos8700_i2c.c                     |    2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |    4 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |  124 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |   14 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |   80 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c    |    4 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c    |    4 +-
 drivers/iio/imu/kmx61.c                            |    2 +-
 drivers/iio/industrialio-backend.c                 |    8 +-
 drivers/iio/industrialio-buffer.c                  |  588 ++++++++-
 drivers/iio/industrialio-core.c                    |   32 +-
 drivers/iio/industrialio-event.c                   |   13 +-
 drivers/iio/industrialio-gts-helper.c              |    7 +-
 drivers/iio/inkern.c                               |   38 +-
 drivers/iio/light/Kconfig                          |   11 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/adjd_s311.c                      |    2 +-
 drivers/iio/light/adux1020.c                       |   15 +-
 drivers/iio/light/al3320a.c                        |    2 +-
 drivers/iio/light/apds9300.c                       |    2 +-
 drivers/iio/light/apds9960.c                       |    2 +-
 drivers/iio/light/bh1780.c                         |    4 +-
 drivers/iio/light/cm3232.c                         |    2 +-
 drivers/iio/light/cm3323.c                         |    2 +-
 drivers/iio/light/cm36651.c                        |    2 +-
 drivers/iio/light/gp2ap002.c                       |    4 +-
 drivers/iio/light/gp2ap020a00f.c                   |    3 +-
 drivers/iio/light/iqs621-als.c                     |    4 +-
 drivers/iio/light/isl29018.c                       |    6 +-
 drivers/iio/light/isl29028.c                       |    4 +-
 drivers/iio/light/isl29125.c                       |    2 +-
 drivers/iio/light/jsa1212.c                        |    2 +-
 drivers/iio/light/lv0104cs.c                       |    2 +-
 drivers/iio/light/max44000.c                       |    2 +-
 drivers/iio/light/max44009.c                       |    2 +-
 drivers/iio/light/noa1305.c                        |    2 +-
 drivers/iio/light/opt3001.c                        |    2 +-
 drivers/iio/light/pa12203001.c                     |    2 +-
 drivers/iio/light/rohm-bu27034.c                   |    6 -
 drivers/iio/light/rpr0521.c                        |    2 +-
 drivers/iio/light/si1133.c                         |    2 +-
 drivers/iio/light/st_uvis25_core.c                 |    4 +-
 drivers/iio/light/stk3310.c                        |   37 +-
 drivers/iio/light/tcs3414.c                        |    2 +-
 drivers/iio/light/tcs3472.c                        |    2 +-
 drivers/iio/light/tsl4531.c                        |    2 +-
 drivers/iio/light/us5182d.c                        |    2 +-
 drivers/iio/light/vcnl4035.c                       |    2 +-
 drivers/iio/light/veml6030.c                       |    6 +-
 drivers/iio/light/veml6040.c                       |  281 +++++
 drivers/iio/light/veml6070.c                       |    2 +-
 drivers/iio/light/vl6180.c                         |    2 +-
 drivers/iio/light/zopt2201.c                       |    2 +-
 drivers/iio/magnetometer/af8133j.c                 |    2 +-
 drivers/iio/magnetometer/ak8974.c                  |   18 +-
 drivers/iio/magnetometer/bmc150_magn_i2c.c         |    6 +-
 drivers/iio/magnetometer/mag3110.c                 |    2 +-
 drivers/iio/magnetometer/mmc35240.c                |   10 +-
 drivers/iio/magnetometer/tmag5273.c                |    2 -
 drivers/iio/multiplexer/iio-mux.c                  |    1 -
 drivers/iio/potentiostat/lmp91000.c                |    4 +-
 drivers/iio/pressure/bmp280-core.c                 |  839 +++++++------
 drivers/iio/pressure/bmp280-regmap.c               |    8 +-
 drivers/iio/pressure/bmp280-spi.c                  |    4 +-
 drivers/iio/pressure/bmp280.h                      |   65 +-
 drivers/iio/pressure/dps310.c                      |    2 +-
 drivers/iio/pressure/hp03.c                        |    4 +-
 drivers/iio/pressure/icp10100.c                    |    2 +-
 drivers/iio/pressure/mpl115_i2c.c                  |    2 +-
 drivers/iio/pressure/mpl3115.c                     |    2 +-
 drivers/iio/pressure/t5403.c                       |    2 +-
 drivers/iio/pressure/zpa2326_i2c.c                 |    4 +-
 drivers/iio/proximity/isl29501.c                   |    2 +-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |    6 +-
 drivers/iio/proximity/rfd77402.c                   |    2 +-
 drivers/iio/proximity/sx9324.c                     |    5 +-
 drivers/iio/proximity/sx9360.c                     |    5 +-
 drivers/iio/proximity/sx9500.c                     |   16 +-
 drivers/iio/proximity/sx_common.c                  |    9 +-
 drivers/iio/proximity/vl53l0x-i2c.c                |    2 +-
 drivers/iio/temperature/ltc2983.c                  |  260 ++--
 drivers/iio/temperature/max30208.c                 |    1 -
 drivers/iio/temperature/mcp9600.c                  |  363 +++++-
 drivers/iio/temperature/mlx90632.c                 |    6 +-
 drivers/iio/temperature/tmp006.c                   |    2 +-
 drivers/iio/temperature/tmp007.c                   |    2 +-
 drivers/iio/temperature/tsys01.c                   |    2 +-
 drivers/iio/temperature/tsys02d.c                  |    2 +-
 drivers/iio/test/iio-test-gts.c                    |    8 +-
 drivers/iio/trigger/stm32-timer-trigger.c          |   34 +-
 drivers/input/joystick/db9.c                       |    1 -
 drivers/input/joystick/gamecon.c                   |    1 -
 drivers/input/joystick/turbografx.c                |    1 -
 drivers/input/joystick/walkera0701.c               |    1 -
 drivers/input/serio/parkbd.c                       |    1 -
 drivers/interconnect/Kconfig                       |    1 +
 drivers/interconnect/Makefile                      |    1 +
 drivers/interconnect/imx/imx.c                     |    1 +
 drivers/interconnect/imx/imx8mm.c                  |    1 +
 drivers/interconnect/imx/imx8mn.c                  |    1 +
 drivers/interconnect/imx/imx8mp.c                  |    1 +
 drivers/interconnect/imx/imx8mq.c                  |    1 +
 drivers/interconnect/mediatek/Kconfig              |   29 +
 drivers/interconnect/mediatek/Makefile             |    5 +
 drivers/interconnect/mediatek/icc-emi.c            |  153 +++
 drivers/interconnect/mediatek/icc-emi.h            |   40 +
 drivers/interconnect/mediatek/mt8183.c             |  143 +++
 drivers/interconnect/mediatek/mt8195.c             |  339 +++++
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/icc-common.c             |    1 +
 drivers/interconnect/qcom/icc-rpmh.c               |   94 ++
 drivers/interconnect/qcom/icc-rpmh.h               |   36 +
 drivers/interconnect/qcom/msm8953.c                | 1321 ++++++++++++++++++++
 drivers/interconnect/qcom/qcm2290.c                |    2 +-
 drivers/interconnect/qcom/sc7280.c                 |  276 ++++
 drivers/mcb/mcb-parse.c                            |    5 -
 drivers/mcb/mcb-pci.c                              |   16 +-
 drivers/misc/Kconfig                               |   16 +
 drivers/misc/Makefile                              |    2 +
 drivers/misc/apds9802als.c                         |    2 +-
 drivers/misc/apds990x.c                            |   12 +-
 drivers/misc/bh1770glc.c                           |   14 +-
 drivers/misc/ds1682.c                              |    2 +-
 drivers/misc/eeprom/Kconfig                        |    2 +
 drivers/misc/eeprom/digsy_mtc_eeprom.c             |   46 +-
 drivers/misc/eeprom/ee1004.c                       |  131 +-
 drivers/misc/eeprom/eeprom_93xx46.c                |  178 ++-
 drivers/misc/eeprom/idt_89hpesx.c                  |   96 +-
 drivers/misc/eeprom/max6875.c                      |    2 +-
 drivers/misc/fastrpc.c                             |   46 +-
 drivers/misc/hmc6352.c                             |    2 +-
 drivers/misc/ics932s401.c                          |    2 +-
 drivers/misc/isl29003.c                            |    2 +-
 drivers/misc/isl29020.c                            |    2 +-
 drivers/misc/keba/Kconfig                          |   13 +
 drivers/misc/keba/Makefile                         |    3 +
 drivers/misc/keba/cp500.c                          |  458 +++++++
 drivers/misc/mei/bus-fixup.c                       |    8 +-
 drivers/misc/mrvl_cn10k_dpi.c                      |  676 ++++++++++
 drivers/misc/open-dice.c                           |    1 +
 drivers/misc/ti-st/st_kim.c                        |    8 +-
 drivers/misc/tifm_7xx1.c                           |    6 +-
 drivers/misc/tsl2550.c                             |    2 +-
 drivers/misc/vcpu_stall_detector.c                 |   31 +-
 drivers/net/hamradio/baycom_epp.c                  |    1 -
 drivers/net/hamradio/baycom_par.c                  |    1 -
 drivers/net/plip/plip.c                            |    1 -
 drivers/net/wwan/mhi_wwan_mbim.c                   |   18 +-
 drivers/nvmem/apple-efuses.c                       |    1 +
 drivers/nvmem/brcm_nvram.c                         |    1 +
 drivers/nvmem/core.c                               |   90 +-
 drivers/nvmem/meson-efuse.c                        |    5 +-
 drivers/nvmem/rockchip-efuse.c                     |    1 +
 drivers/nvmem/rockchip-otp.c                       |    2 +
 drivers/nvmem/u-boot-env.c                         |    1 +
 drivers/parport/daisy.c                            |    1 -
 drivers/parport/procfs.c                           |   24 +-
 drivers/parport/share.c                            |   10 +-
 drivers/peci/controller/peci-aspeed.c              |    1 +
 drivers/peci/core.c                                |    5 +-
 drivers/peci/cpu.c                                 |   21 +-
 drivers/peci/device.c                              |    3 +-
 drivers/peci/internal.h                            |    6 +-
 drivers/platform/goldfish/goldfish_pipe.c          |    1 +
 drivers/pps/clients/pps_parport.c                  |    1 -
 drivers/pps/generators/pps_gen_parport.c           |    1 -
 drivers/scsi/imm.c                                 |    1 -
 drivers/scsi/ppa.c                                 |    1 -
 drivers/siox/siox-bus-gpio.c                       |    1 +
 drivers/slimbus/stream.c                           |    8 +-
 drivers/spi/spi-butterfly.c                        |    1 -
 drivers/spi/spi-lm70llp.c                          |    1 -
 drivers/spi/spi.c                                  |   28 +
 drivers/spmi/hisi-spmi-controller.c                |    1 +
 drivers/spmi/spmi-pmic-arb.c                       |    1 +
 drivers/staging/iio/addac/adt7316-i2c.c            |   12 +-
 drivers/staging/iio/addac/adt7316.c                |    9 -
 drivers/staging/iio/impedance-analyzer/ad5933.c    |    4 +-
 drivers/uio/uio.c                                  |    1 +
 drivers/uio/uio_aec.c                              |    1 +
 drivers/uio/uio_cif.c                              |    1 +
 drivers/uio/uio_mf624.c                            |    3 +-
 drivers/uio/uio_netx.c                             |    1 +
 drivers/virtio/virtio_dma_buf.c                    |    1 +
 drivers/w1/w1.c                                    |    2 +-
 drivers/w1/w1_int.c                                |    6 +-
 .../dt-bindings/iio/adc/mediatek,mt6357-auxadc.h   |   21 +
 .../dt-bindings/iio/adc/mediatek,mt6358-auxadc.h   |   22 +
 .../dt-bindings/iio/adc/mediatek,mt6359-auxadc.h   |   22 +
 include/dt-bindings/interconnect/mediatek,mt8183.h |   23 +
 include/dt-bindings/interconnect/mediatek,mt8195.h |   44 +
 include/dt-bindings/interconnect/qcom,msm8953.h    |   93 ++
 include/linux/dev_printk.h                         |    8 +
 include/linux/dmaengine.h                          |   33 +
 include/linux/eeprom_93xx46.h                      |   32 -
 include/linux/iio/adc/ad_sigma_delta.h             |   14 +
 include/linux/iio/buffer-dma.h                     |   31 +
 include/linux/iio/buffer_impl.h                    |   33 +
 include/linux/iio/consumer.h                       |   10 +
 include/linux/iio/iio.h                            |   94 +-
 include/linux/iio/imu/adis.h                       |   87 +-
 include/linux/math.h                               |    2 +
 include/linux/mhi.h                                |    2 +
 include/linux/misc/keba.h                          |   25 +
 include/linux/parport.h                            |    6 -
 include/linux/peci-cpu.h                           |   24 +
 include/linux/peci.h                               |    6 +-
 include/linux/spi/spi.h                            |    2 +
 include/linux/w1.h                                 |    7 +-
 include/uapi/linux/iio/buffer.h                    |   22 +
 include/uapi/misc/mrvl_cn10k_dpi.h                 |   39 +
 lib/math/prime_numbers.c                           |    1 +
 lib/math/rational-test.c                           |    1 +
 lib/test_dynamic_debug.c                           |    1 +
 samples/configfs/configfs_sample.c                 |    1 +
 sound/drivers/mts64.c                              |    1 -
 sound/drivers/portman2x4.c                         |    1 -
 423 files changed, 15716 insertions(+), 3144 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-misc-cp500
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-inv_icm42600
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sciosense,ens160.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/mediatek,mt8183-emi.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8953.yaml
 create mode 100644 Documentation/iio/adis16480.rst
 create mode 100644 Documentation/iio/iio_dmabuf_api.rst
 create mode 100644 Documentation/iio/iio_tools.rst
 create mode 100644 Documentation/misc-devices/mrvl_cn10k_dpi.rst
 create mode 100644 drivers/android/dbitmap.h
 create mode 100644 drivers/iio/adc/ad7380.c
 create mode 100644 drivers/iio/adc/mt6359-auxadc.c
 create mode 100644 drivers/iio/adc/ti-ads1119.c
 create mode 100644 drivers/iio/chemical/ens160.h
 create mode 100644 drivers/iio/chemical/ens160_core.c
 create mode 100644 drivers/iio/chemical/ens160_i2c.c
 create mode 100644 drivers/iio/chemical/ens160_spi.c
 create mode 100644 drivers/iio/light/veml6040.c
 create mode 100644 drivers/interconnect/mediatek/Kconfig
 create mode 100644 drivers/interconnect/mediatek/Makefile
 create mode 100644 drivers/interconnect/mediatek/icc-emi.c
 create mode 100644 drivers/interconnect/mediatek/icc-emi.h
 create mode 100644 drivers/interconnect/mediatek/mt8183.c
 create mode 100644 drivers/interconnect/mediatek/mt8195.c
 create mode 100644 drivers/interconnect/qcom/msm8953.c
 create mode 100644 drivers/misc/keba/Kconfig
 create mode 100644 drivers/misc/keba/Makefile
 create mode 100644 drivers/misc/keba/cp500.c
 create mode 100644 drivers/misc/mrvl_cn10k_dpi.c
 create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6357-auxadc.h
 create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6358-auxadc.h
 create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6359-auxadc.h
 create mode 100644 include/dt-bindings/interconnect/mediatek,mt8183.h
 create mode 100644 include/dt-bindings/interconnect/mediatek,mt8195.h
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8953.h
 delete mode 100644 include/linux/eeprom_93xx46.h
 create mode 100644 include/linux/misc/keba.h
 create mode 100644 include/uapi/misc/mrvl_cn10k_dpi.h

