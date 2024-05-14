Return-Path: <linux-kernel+bounces-178652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 943AC8C55DE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B791A1C21C02
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21CA40862;
	Tue, 14 May 2024 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXzfyJKj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED315320F
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715688891; cv=none; b=D+btuu7PS1nTBTJDlgY0vzgIJQUOtT6WFbufFx5+WLu85JtbDoq2Ux6u6l0cs47mbULUUxG8AidC8vflFe7thyZllh6+vj0RZt3oHQ0mNIiC13RawUl6LgckAhjClHer2xpV0NQdJFXcvBxwXnvDtdmHxIQ0tcQRlf5PO28spKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715688891; c=relaxed/simple;
	bh=oFi+X8DWJauq3qBIES8fh+chhp9UGsg3AZYUFiG6KcE=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=U9urEPxHBZ31xQo6fPH7wUorN/ZCn6w8Af4AkuQMfZdHr/ongZj7shGkWrx2L62fIVbXowHZkicllUaJ3ouKHXyBfwPNOEBjrRkFeeWv798KNlJ0xhJ0HE+ojIikDODqpqHfaA+B1Y0gjwxTSlrLWwja5F4vvmTT2aL025cQb7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXzfyJKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9D8C2BD10;
	Tue, 14 May 2024 12:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715688890;
	bh=oFi+X8DWJauq3qBIES8fh+chhp9UGsg3AZYUFiG6KcE=;
	h=Date:From:To:cc:Subject:From;
	b=ZXzfyJKju5ZjosiQ/BIq4xrcSZFoq9z+Zb+r/X3aPGNSDgO2hRy9N7RoC55w/WTMB
	 Jq2lbKgqbbu9YV6wFmzMIwduN9t5RTO/jQUn9RZ8dV17Lpw0kaJkLxsh7T/7QEvpyr
	 son5rYho20C1Xa1RZGC/jBYc4oL6vOy3W7TFqHOjXIoA4MKPbgMkaOeNN9/6Nmmg7i
	 l83k+fVRbNropJjn6V0wVKKa2U436pKKRH4Piiuquydq0kZ4m1y3wbehiI2Sp80/qU
	 /43/EvDfFTIYTZch+LnSgClzdtySM3nvCEnTNPsvuW0bHk0+11szqDZV9iJspfWoNh
	 sXtG5u9UtaH9Q==
Date: Tue, 14 May 2024 14:14:48 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID for 6.10
Message-ID: <nycvar.YFH.7.76.2405141414420.16865@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-li=
nus-2024051401

to receive HID subsystem updates for 6.10 merge window. Highlights:

=3D=3D=3D=3D=3D
- Firmware loading from host support in intel-ish driver, needed
  to support Lunar Lake and later (Zhang Lixu)
- updates to HID-BPF infrastructure, with some of the specific
  fixes (e.g. rdesc fixups) abstracted into separate BPF programs
  for consumption from libevdev/udev-hid-bpf (Benjamin Tissoires)
- support for Deck IMU in hid-steam (Max Maisel)
- fixes for better support of 3rd party playstation DS4 controllers
  (Max Staudt)
- support for missing mappings and codes from HUT 1.5 in hid-debug
  (Thomas Kuehne)
- initial support for ROG Ally and ROG X13 devices (Luke D. Jones)
- full support for WinWing Orion2 (Ivan Gorinov)
=3D=3D=3D=3D=3D

Thanks!

----------------------------------------------------------------
Allan Sandfeld Jensen (1):
      HID: logitech: add a few Logitech HID++ device IDs

Basavaraj Natikar (3):
      HID: amd_sfh: Modify and log error only if case of functionality fail=
ures
      HID: amd_sfh: Handle "no sensors" in PM operations
      HID: amd_sfh: Use amd_get_c2p_val() to read C2P register

Benjamin Tissoires (27):
      HID: bpf/dispatch: regroup kfuncs definitions
      HID: bpf: export hid_hw_output_report as a BPF kfunc
      selftests/hid: add KASAN to the VM tests
      selftests/hid: Add test for hid_bpf_hw_output_report
      HID: bpf: allow to inject HID event from BPF
      selftests/hid: add tests for hid_bpf_input_report
      HID: bpf: allow to use bpf_timer_set_sleepable_cb() in tracing callba=
cks.
      HID: bpf: fix hid_bpf_input_report() when hid-core is not ready
      HID: do not assume HAT Switch logical max < 8
      HID: bpf: add first in-tree HID-BPF fix for the XPPen Artist 24
      HID: bpf: add in-tree HID-BPF fix for the XPPen Artist 16
      HID: bpf: add in-tree HID-BPF fix for the HP Elite Presenter Mouse
      HID: bpf: add in-tree HID-BPF fix for the IOGear Kaliber Gaming MMOme=
ntum mouse
      HID: bpf: add in-tree HID-BPF fix for the Wacom ArtPen
      HID: bpf: add in-tree HID-BPF fix for the XBox Elite 2 over Bluetooth
      HID: bpf: add in-tree HID-BPF fix for the Huion Kamvas Pro 19
      HID: bpf: add in-tree HID-BPF fix for the Raptor Mach 2
      selftests/hid: import base_device.py from hid-tools
      selftests/hid: add support for HID-BPF pre-loading before starting a =
test
      selftests/hid: tablets: reduce the number of pen state
      selftests/hid: tablets: add a couple of XP-PEN tablets
      selftests/hid: tablets: also check for XP-Pen offset correction
      selftests/hid: add Huion Kamvas Pro 19 tests
      selftests/hid: import base_gamepad.py from hid-tools
      selftests/hid: move the gamepads definitions in the test file
      selftests/hid: add tests for the Raptor Mach 2 joystick
      selftests/hid: skip tests with HID-BPF if udev-hid-bpf is not install=
ed

Chen Ni (1):
      HID: intel-ish-hid: ipc: Add check for pci_alloc_irq_vectors

Christophe JAILLET (1):
      HID: sony: Remove usage of the deprecated ida_simple_xx() API

Colin Ian King (1):
      HID: sony: remove redundant assignment

David Yang (1):
      HID: kye: Change Device Usage from Puck to Mouse

Ivan Gorinov (1):
      HID: Add WinWing Orion2 throttle support

Jiapeng Chong (2):
      HID: winwing: Remove unused variable 'minor'
      HID: nintendo: Remove unused function

Jos=E9 Exp=F3sito (1):
      HID: uclogic: Expose firmware name

Kenny Levinsen (3):
      HID: i2c-hid: Retry address probe after delay
      HID: i2c-hid: Use address probe to wake on resume
      HID: i2c-hid: Remove unused label in i2c_hid_set_power

Li Zhijian (4):
      HID: hid-picolcd*: Convert sprintf() family to sysfs_emit() family
      HID: hid-sensor-custom: Convert sprintf() family to sysfs_emit() fami=
ly
      HID: roccat: Convert sprintf() family to sysfs_emit() family
      HID: corsair,lenovo: Convert sprintf() family to sysfs_emit() family

Luke D. Jones (4):
      HID: asus: fix more n-key report descriptors if n-key quirked
      HID: asus: make asus_kbd_init() generic, remove rog_nkey_led_init()
      HID: asus: add ROG Ally N-Key ID and keycodes
      HID: asus: add ROG Z13 lightbar

Martino Fontana (1):
      HID: nintendo: use ida for LED player id

Max Maisel (1):
      HID: hid-steam: Add Deck IMU support

Max Staudt (7):
      HID: nintendo: Don't fail on setting baud rate
      HID: playstation: DS4: Fix LED blinking
      HID: playstation: DS4: Don't fail on FW/HW version request
      HID: playstation: DS4: Don't fail on calibration data request
      HID: playstation: DS4: Parse minimal report 0x01
      HID: playstation: Simplify device type ID
      HID: playstation: DS4: Fix calibration workaround for clone devices

Qianru Huang (2):
      Documentation: hid: intel-ish-hid: remove section numbering
      Documentation: hid: intel-ish-hid: add section for firmware loading

Sean O'Brien (1):
      HID: Add quirk for Logitech Casa touchpad

Thomas Kuehne (4):
      HID: hid-debug: add missing evdev and HID codes
      HID: hid-debug: fix Moir -> Moire typo
      HID: hid-debug: more informative output for EV_KEY
      HID: hid-debug: add EV_FF and FF_STATUS mappings

Uwe Kleine-K=F6nig (3):
      HID: google: hammer: Convert to platform remove callback returning vo=
id
      HID: hid-sensor-custom: Convert to platform remove callback returning=
 void
      HID: surface-hid: kbd: Convert to platform remove callback returning =
void

Zhang Lixu (4):
      HID: intel-ish-hid: ipc: Add Lunar Lake-M PCI device ID
      HID: intel-ish-hid: Add driver_data for specifying the firmware filen=
ame
      HID: intel-ish-hid: Implement loading firmware from host feature
      HID: intel-ish-hid: handler multiple MNG_RESET_NOTIFY messages

Zhang, Lixu (1):
      HID: intel-ish-hid: Use PCI_VDEVICE() and rename device ID macros

 Documentation/hid/hid-bpf.rst                      |    2 +-
 Documentation/hid/intel-ish-hid.rst                |  137 +-
 drivers/hid/Kconfig                                |   16 +
 drivers/hid/Makefile                               |    1 +
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c             |    5 +-
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c      |   17 +-
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c |    2 +-
 drivers/hid/bpf/hid_bpf_dispatch.c                 |  226 +-
 drivers/hid/bpf/progs/FR-TEC__Raptor-Mach-2.bpf.c  |  185 ++
 drivers/hid/bpf/progs/HP__Elite-Presenter.bpf.c    |   58 +
 drivers/hid/bpf/progs/Huion__Kamvas-Pro-19.bpf.c   |  290 ++
 .../hid/bpf/progs/IOGEAR__Kaliber-MMOmentum.bpf.c  |   59 +
 drivers/hid/bpf/progs/Makefile                     |   91 +
 .../hid/bpf/progs/Microsoft__XBox-Elite-2.bpf.c    |  133 +
 drivers/hid/bpf/progs/README                       |  102 +
 drivers/hid/bpf/progs/Wacom__ArtPen.bpf.c          |  173 +
 drivers/hid/bpf/progs/XPPen__Artist24.bpf.c        |  229 ++
 drivers/hid/bpf/progs/XPPen__ArtistPro16Gen2.bpf.c |  274 ++
 drivers/hid/bpf/progs/hid_bpf.h                    |   15 +
 drivers/hid/bpf/progs/hid_bpf_helpers.h            |  168 +
 drivers/hid/hid-asus.c                             |  132 +-
 drivers/hid/hid-core.c                             |    2 +
 drivers/hid/hid-corsair.c                          |    4 +-
 drivers/hid/hid-debug.c                            | 3437 ++++++++++++++++=
+---
 drivers/hid/hid-google-hammer.c                    |    5 +-
 drivers/hid/hid-ids.h                              |    3 +
 drivers/hid/hid-kye.c                              |   75 +-
 drivers/hid/hid-lenovo.c                           |   23 +-
 drivers/hid/hid-logitech-hidpp.c                   |   14 +-
 drivers/hid/hid-multitouch.c                       |    6 +
 drivers/hid/hid-nintendo.c                         |   57 +-
 drivers/hid/hid-picolcd_core.c                     |    6 +-
 drivers/hid/hid-picolcd_fb.c                       |    8 +-
 drivers/hid/hid-playstation.c                      |  138 +-
 drivers/hid/hid-roccat-isku.c                      |    2 +-
 drivers/hid/hid-roccat-kone.c                      |   12 +-
 drivers/hid/hid-roccat-koneplus.c                  |    4 +-
 drivers/hid/hid-roccat-kovaplus.c                  |   10 +-
 drivers/hid/hid-roccat-pyra.c                      |    6 +-
 drivers/hid/hid-sensor-custom.c                    |   17 +-
 drivers/hid/hid-sony.c                             |    7 +-
 drivers/hid/hid-steam.c                            |  155 +-
 drivers/hid/hid-uclogic-params.c                   |    3 +
 drivers/hid/hid-winwing.c                          |  226 ++
 drivers/hid/i2c-hid/i2c-hid-core.c                 |   44 +-
 drivers/hid/intel-ish-hid/Makefile                 |    1 +
 drivers/hid/intel-ish-hid/ipc/hw-ish.h             |   45 +-
 drivers/hid/intel-ish-hid/ipc/ipc.c                |   21 +-
 drivers/hid/intel-ish-hid/ipc/pci-ish.c            |   80 +-
 drivers/hid/intel-ish-hid/ishtp/hbm.c              |   21 +
 drivers/hid/intel-ish-hid/ishtp/init.c             |    8 +
 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h        |   28 +
 drivers/hid/intel-ish-hid/ishtp/loader.c           |  275 ++
 drivers/hid/intel-ish-hid/ishtp/loader.h           |  226 ++
 drivers/hid/surface-hid/surface_kbd.c              |    5 +-
 include/linux/hid.h                                |    6 +-
 include/linux/hid_bpf.h                            |    3 +
 tools/testing/selftests/hid/config.common          |    1 +
 tools/testing/selftests/hid/hid_bpf.c              |  112 +-
 tools/testing/selftests/hid/progs/hid.c            |   46 +
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  |    6 +
 tools/testing/selftests/hid/tests/base.py          |   92 +-
 tools/testing/selftests/hid/tests/base_device.py   |  421 +++
 tools/testing/selftests/hid/tests/base_gamepad.py  |  238 ++
 tools/testing/selftests/hid/tests/test_gamepad.py  |  457 ++-
 tools/testing/selftests/hid/tests/test_tablet.py   |  723 ++--
 66 files changed, 8301 insertions(+), 1093 deletions(-)
 create mode 100644 drivers/hid/bpf/progs/FR-TEC__Raptor-Mach-2.bpf.c
 create mode 100644 drivers/hid/bpf/progs/HP__Elite-Presenter.bpf.c
 create mode 100644 drivers/hid/bpf/progs/Huion__Kamvas-Pro-19.bpf.c
 create mode 100644 drivers/hid/bpf/progs/IOGEAR__Kaliber-MMOmentum.bpf.c
 create mode 100644 drivers/hid/bpf/progs/Makefile
 create mode 100644 drivers/hid/bpf/progs/Microsoft__XBox-Elite-2.bpf.c
 create mode 100644 drivers/hid/bpf/progs/README
 create mode 100644 drivers/hid/bpf/progs/Wacom__ArtPen.bpf.c
 create mode 100644 drivers/hid/bpf/progs/XPPen__Artist24.bpf.c
 create mode 100644 drivers/hid/bpf/progs/XPPen__ArtistPro16Gen2.bpf.c
 create mode 100644 drivers/hid/bpf/progs/hid_bpf.h
 create mode 100644 drivers/hid/bpf/progs/hid_bpf_helpers.h
 create mode 100644 drivers/hid/hid-winwing.c
 create mode 100644 drivers/hid/intel-ish-hid/ishtp/loader.c
 create mode 100644 drivers/hid/intel-ish-hid/ishtp/loader.h
 create mode 100644 tools/testing/selftests/hid/tests/base_device.py
 create mode 100644 tools/testing/selftests/hid/tests/base_gamepad.py

--=20
Jiri Kosina
SUSE Labs


