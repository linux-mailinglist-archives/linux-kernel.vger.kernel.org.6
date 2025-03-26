Return-Path: <linux-kernel+bounces-576989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B8CA7170D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3C9B7A3CDA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BBE1DE4DD;
	Wed, 26 Mar 2025 13:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeDMhN3U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06D31A0BDB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742994247; cv=none; b=orJ5dFKZc4rWHD/GY+Y7Xa+p5suUsUsO/wATMhJYHC6/PC2kZuszAFQNoD3rRTvWueOLxh/10pEnAKvPSPJ5ASTIPn3d7IKQTPZs9Mf8WWt48BAL0j4vSKGUfSqGIu6s/b3bCYvJgAzyfIqCGUnrh72gqrEDWD0YxYrPMEYuRjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742994247; c=relaxed/simple;
	bh=agvXe4gT1XA0+WvgRdSiXw253f0WtfzQaZZ2fTA2U9I=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=pidxYJeLwRqFJBfYLZhcqM/EG6TvWwJsurB/q04Orne8fD1qAfhPFq1ZWRK6Lgyg6sRdTrzjTpjphXU/mZmCkGPULPjSrfa422EkU3j8A1szL3iW6oLR4t6QCojtMJ1f7fT/H1C2Jbk47eYODF1WD0aef9cpICmg8f8BfM3KbJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeDMhN3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02CEC4CEE2;
	Wed, 26 Mar 2025 13:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742994247;
	bh=agvXe4gT1XA0+WvgRdSiXw253f0WtfzQaZZ2fTA2U9I=;
	h=Date:From:To:cc:Subject:From;
	b=eeDMhN3Upf4Gn2snyE04474iSiCDidkdloqom3lYjhRK+l7zZ5rVDHC7khnan8hvD
	 SI1/RbVL6dxOIiil0iIQAiB3vz3IPXw3IEgQl3FnN3+y/r8NYfcrz/KDB4AtQzkUET
	 b3PLSk3c5a8gpG3wYA5PVuETSaIMegkizVrIkTwEBp5wFVB0vxGVYqarjfLY+TI6q9
	 g2PiOE/VtdkdhVGP3dx24U1TddjT3XXanRP0jEG0OfaTs8QjQp03pvsO7me09tntSb
	 5YdUMXvkn7MiNj4eheC7ngGhmO4WJLPtJMP7r6DxaiC+gB5JPzVIkxKVcF2NaXfMVC
	 b/o9+/QRV8tyw==
Date: Wed, 26 Mar 2025 14:04:04 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID for 6.15
Message-ID: <8r0s342o-prr6-0636-932n-10poq04p380p@xreary.bet>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-li=
nus-2025032601

to receive HID subsystem queue for 6.15 merge window.

Highlights:

=3D=3D=3D=3D=3D
- PlayStation 5 controllers support (Alex Henrie)
- big revamp and modernization of the aged hid-pidff force feedback driver=
=20
  (Tomasz Paku=B3a)
- conversion of hid-lg-g15 to standard multicolor LED API (Kate Hsuan)
- improvement of behavior of Human Presence Sensor (HPD) in amd_sfh=20
  driver (Mario Limonciello)
- other assorted fixes, code cleanups and device ID additions
=3D=3D=3D=3D=3D

----------------------------------------------------------------
Aditya Garg (7):
      HID: hid-appletb-kbd: add support for fn toggle between media and fun=
ction mode
      HID: hid-appletb-kbd: add support for automatic brightness control wh=
ile using the touchbar
      HID: hid-appletb-kbd: make struct attribute *appletb_kbd_attrs[] stat=
ic
      HID: hid-appletb-bl: use appletb_bl_brightness_map instead of magic n=
umbers to set default brightness
      HID: hid-appletb-kbd: simplify logic used to switch between media and=
 function keys on pressing fn key
      HID: hid-appletb-bl: fix incorrect error message for default brightne=
ss
      HID: appletb-kbd: Fix inconsistent indentation and pass -ENODEV to de=
v_err_probe

Alex Henrie (2):
      HID: Enable playstation driver independently of sony driver
      HID: Enable playstation driver for PlayStation 5 controllers

Benjamin Tissoires (7):
      HID: bpf: Add support for the default firmware mode of the Huion K20
      HID: bpf: Suppress bogus F13 trigger on Sirius keyboard full fan shor=
tcut
      HID: bpf: Added updated Kamvas Pro 19 descriptor
      HID: bpf: add support for the XP-Pen Artist Pro 19 (gen2)
      HID: bpf: import new kfunc from v6.10 & v6.11
      HID: bpf: new hid_bpf_async.h common header
      HID: bpf: add a v6.11+ compatible BPF fixup for the XPPen ACK05 remot=
e

Colin Ian King (1):
      HID: hid-universal-pidff: Fix spelling mistake "sucessfully" -> "succ=
essfully"

Dan Carpenter (1):
      HID: lenovo: silence unreachable code warning

Even Xu (2):
      Hid: Intel-thc-hid: Intel-thc: Fix "dubious: !x | !y" issue
      HID: Intel-thc-hid: Intel-quickspi: Correct device state names gramat=
ically

Jason Gerecke (1):
      HID: wacom: Remove static WACOM_PKGLEN_MAX limit

Jiri Kosina (1):
      HID: remove superfluous (and wrong) Makefile entry for CONFIG_INTEL_I=
SH_FIRMWARE_DOWNLOADER

Kate Hsuan (2):
      HID: hid-lg-g15: Use standard multicolor LED API
      HID: Kconfig: Add LEDS_CLASS_MULTICOLOR dependency to HID_LOGITECH

Kerem Karabay (2):
      HID: hid-appletb-bl: add driver for the backlight of Apple Touch Bars
      HID: hid-appletb-kbd: add driver for the keyboard mode of Apple Touch=
 Bars

Mario Limonciello (3):
      HID: amd_sfh: Allow configuring whether HPD is enabled or disabled
      HID: amd_sfh: Default to HPD disabled
      HID: amd_sfh: Don't show wrong status for amd_sfh_hpd_info()

Philipp Stanner (1):
      HID: intel-thc-hid: Remove deprecated PCI API calls

Tatsuya S (1):
      HID: core: Add reserved item tag for main items

Terry Junge (2):
      HID: hid-plantronics: Add mic mute mapping and generalize quirks
      ALSA: usb-audio: Add quirk for Plantronics headsets to fix control na=
mes

Tomasz Paku=B3a (33):
      HID: pidff: Convert infinite length from Linux API to PID standard
      HID: pidff: Do not send effect envelope if it's empty
      HID: pidff: Clamp PERIODIC effect period to device's logical range
      HID: pidff: Add MISSING_DELAY quirk and its detection
      HID: pidff: Add MISSING_PBO quirk and its detection
      HID: pidff: Add PERMISSIVE_CONTROL quirk
      HID: pidff: Add hid_pidff_init_with_quirks and export as GPL symbol
      HID: pidff: Add FIX_WHEEL_DIRECTION quirk
      HID: pidff: Stop all effects before enabling actuators
      HID: Add hid-universal-pidff driver and supported device ids
      MAINTAINERS: Add entry for hid-universal-pidff driver
      HID: pidff: Add PERIODIC_SINE_ONLY quirk
      HID: pidff: Completely rework and fix pidff_reset function
      HID: pidff: Simplify pidff_upload_effect function
      HID: pidff: Define values used in pidff_find_special_fields
      HID: pidff: Rescale time values to match field units
      HID: pidff: Factor out code for setting gain
      HID: pidff: Fix null pointer dereference in pidff_find_fields
      HID: pidff: Move all hid-pidff definitions to a dedicated header
      HID: pidff: Simplify pidff_rescale_signed
      HID: pidff: Use macros instead of hardcoded min/max values for shorts
      HID: pidff: Factor out pool report fetch and remove excess declaratio=
n
      MAINTAINERS: Update hid-universal-pidff entry
      HID: pidff: Make sure to fetch pool before checking SIMULTANEOUS_MAX
      HID: hid-universal-pidff: Add Asetek wheelbases support
      HID: pidff: Comment and code style update
      HID: pidff: Support device error response from PID_BLOCK_LOAD
      HID: pidff: Remove redundant call to pidff_find_special_keys
      HID: pidff: Rename two functions to align them with naming convention
      HID: pidff: Clamp effect playback LOOP_COUNT value
      HID: pidff: Compute INFINITE value instead of using hardcoded 0xffff
      HID: pidff: Fix 90 degrees direction name North -> East
      HID: pidff: Fix set_device_control()

Vicki Pfau (1):
      HID: hid-steam: Mutex cleanup in steam_set_lizard_mode()

Vishnu Sankar (1):
      HID: lenovo: Fix to ensure the data as __le32 instead of u32

Wolfram Sang (1):
      HID: google: don't include '<linux/pm_wakeup.h>' directly

junan (1):
      HID: usbkbd: Fix the bit shift number for LED_KANA

 Documentation/ABI/testing/sysfs-driver-amd-sfh     |  13 +
 .../ABI/testing/sysfs-driver-hid-appletb-kbd       |  13 +
 MAINTAINERS                                        |   8 +
 drivers/hid/Kconfig                                |  40 ++
 drivers/hid/Makefile                               |   4 +-
 drivers/hid/amd-sfh-hid/amd_sfh_common.h           |   1 +
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c             |  58 +++
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c      |  50 +-
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.h      |   3 +
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c |   2 +-
 drivers/hid/bpf/progs/Huion__Kamvas-Pro-19.bpf.c   |  75 ++-
 drivers/hid/bpf/progs/Huion__KeydialK20.bpf.c      | 531 +++++++++++++++++=
++
 .../progs/TUXEDO__Sirius-16-Gen1-and-Gen2.bpf.c    |  47 ++
 drivers/hid/bpf/progs/XPPen__ACK05.bpf.c           | 330 ++++++++++++
 drivers/hid/bpf/progs/XPPen__ArtistPro16Gen2.bpf.c |  44 +-
 drivers/hid/bpf/progs/hid_bpf_async.h              | 219 ++++++++
 drivers/hid/bpf/progs/hid_bpf_helpers.h            |  19 +
 drivers/hid/hid-appletb-bl.c                       | 204 ++++++++
 drivers/hid/hid-appletb-kbd.c                      | 507 +++++++++++++++++=
+
 drivers/hid/hid-core.c                             |   6 +-
 drivers/hid/hid-google-hammer.c                    |   1 -
 drivers/hid/hid-ids.h                              |  37 ++
 drivers/hid/hid-lenovo.c                           |   8 +-
 drivers/hid/hid-lg-g15.c                           | 146 +++---
 drivers/hid/hid-plantronics.c                      | 144 +++---
 drivers/hid/hid-quirks.c                           |  24 +-
 drivers/hid/hid-steam.c                            |   7 +-
 drivers/hid/hid-universal-pidff.c                  | 202 ++++++++
 .../intel-thc-hid/intel-quicki2c/pci-quicki2c.c    |  14 +-
 .../intel-thc-hid/intel-quickspi/pci-quickspi.c    |  16 +-
 .../intel-thc-hid/intel-quickspi/quickspi-dev.h    |   4 +-
 .../intel-quickspi/quickspi-protocol.c             |   2 +-
 .../hid/intel-thc-hid/intel-thc/intel-thc-dma.c    |   2 +-
 drivers/hid/usbhid/hid-core.c                      |   1 +
 drivers/hid/usbhid/hid-pidff.c                     | 569 ++++++++++++++---=
----
 drivers/hid/usbhid/hid-pidff.h                     |  33 ++
 drivers/hid/usbhid/usbkbd.c                        |   2 +-
 drivers/hid/wacom_sys.c                            |  35 +-
 drivers/hid/wacom_wac.c                            |   8 +-
 drivers/hid/wacom_wac.h                            |   7 +-
 include/linux/hid.h                                |   8 +-
 sound/usb/mixer_quirks.c                           |  51 ++
 42 files changed, 3056 insertions(+), 439 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-amd-sfh
 create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-appletb-kbd
 create mode 100644 drivers/hid/bpf/progs/Huion__KeydialK20.bpf.c
 create mode 100644 drivers/hid/bpf/progs/TUXEDO__Sirius-16-Gen1-and-Gen2.b=
pf.c
 create mode 100644 drivers/hid/bpf/progs/XPPen__ACK05.bpf.c
 create mode 100644 drivers/hid/bpf/progs/hid_bpf_async.h
 create mode 100644 drivers/hid/hid-appletb-bl.c
 create mode 100644 drivers/hid/hid-appletb-kbd.c
 create mode 100644 drivers/hid/hid-universal-pidff.c
 create mode 100644 drivers/hid/usbhid/hid-pidff.h

--=20
Jiri Kosina
SUSE Labs


