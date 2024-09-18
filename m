Return-Path: <linux-kernel+bounces-332659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 217F397BCBC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467F81C2191E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 13:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090CD189F43;
	Wed, 18 Sep 2024 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZutlTol"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D4C187FE6
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 13:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726664694; cv=none; b=Me2H/kMHRhrzVWb/GTA87vuR5ZnnytxNUe4YsRGuBiQr4OVJhh05e/G7woX3LxW/YnXmi4e7R8a+12t5QpLXBYi9sfYF/p2bLyJ8v0zqd4r7DJZFO5Q8XlTFRTRc6mu/rFTXDMR6jG4w897QjbNFi2CevVZ2Wmbf1mmmvYqeB1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726664694; c=relaxed/simple;
	bh=U9TRi1NngSMZJgZaHmW7qjo4mB7BN2H6t4P0rb+Y7Bc=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=SYCYKUo6JEsS5E5/C5E3muXGepIco1ll1+MV7OF2Nw5r8U2j2BUK3/QFkBYRQxHjLRyUtHGPpWugzIGYDWJxQchTuFLCTxC4vEmZs/a3XQoTo8e+cH9huH+ZoY2Jv3cVYLXGgEpjuAh0cCROpWn0iEVuMyYXx8EfA6D3gnIGm9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZutlTol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F5EC4CEC3;
	Wed, 18 Sep 2024 13:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726664693;
	bh=U9TRi1NngSMZJgZaHmW7qjo4mB7BN2H6t4P0rb+Y7Bc=;
	h=Date:From:To:cc:Subject:From;
	b=oZutlTolA8G1a8bfFqBogqThIyMmDzmwcphNtVL7JTik49YIKVXilLq70TZdi8BVh
	 eoYAVLRsW6RgmEDdqSvo9QTAsAy7zj2PgUs9Npc84fadk+12i7xze0Eey1JJZxKPP/
	 0GBAIgdXq8bL/ZGb6EotB6DWJ/KKLuCJf1JSx1xP7CCftqbGMWUo3ruSIjhGOVPKDo
	 n/u94yaqQoaEPZRp6GfoAC534waUSMkfnqf8kTGTIzbb91kh/xVdr8hXSCOmhSrP40
	 e0x4nfdMLrWiuTLb5wOqC6FGHIa06HRa/syPWpTr42YPTZaDY2H/KeRB+9QcHr3sb3
	 eViz5+udvEQ7Q==
Date: Wed, 18 Sep 2024 15:04:51 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
Subject: [GIT PULL] HID for 6.12
Message-ID: <nycvar.YFH.7.76.2409181132240.31206@cbobk.fhfr.pm>
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
nus-2024091602


to receive HID subsystem queue for 6.12 merge window, namely:

=3D=3D=3D=3D=3D

- New HID over SPI driver for Goodix devices that don't follow Microsoft's=
=20
  HID-over-SPI specification, so a separate driver is needed. Currently=20
  supported device is GT7986U touchscreen (Charles Wang)

- support for new hardware features in Wacom driver (high-res wheel=20
  scrolling, touchstrings with relative motions, support for two=20
  touchrings) (Jason Gerecke)

- support for customized vendor firmware loading in intel-ish driver=20
  (Zhang Lixu)

- fix for theoretical race condition in i2c-hid (Dmitry Torokhov)

- support for HIDIOCREVOKE -- evdev's EVIOCREVOKE equivalent in hidraw=20
  (Peter Hutterer)

- initial hidraw selftest implementation (Benjamin Tissoires)

- constification of device-specific report descriptors (Thomas Wei=DFschuh)

- other small assorted fixes and device ID / quirk additions

=3D=3D=3D=3D=3D

Thanks.

----------------------------------------------------------------
Benjamin Tissoires (4):
      HID: samples: fix the 2 struct_ops definitions
      selftests/hid: extract the utility part of hid_bpf.c into its own hea=
der
      selftests/hid: Add initial hidraw tests skeleton
      selftests/hid: Add HIDIOCREVOKE tests

Charles Wang (2):
      HID: hid-goodix: Add Goodix HID-over-SPI driver
      dt-bindings: input: Goodix SPI HID Touchscreen

Chen Ni (2):
      HID: amd_sfh: Convert comma to semicolon
      HID: hid-sensor-custom: Convert comma to semicolon

Dan Carpenter (1):
      HID: hid-goodix: Fix type promotion bug in goodix_hid_get_raw_report(=
)

Dmitry Torokhov (1):
      HID: i2c-hid: ensure various commands do not interfere with each othe=
r

Hans de Goede (1):
      HID: Ignore battery for all ELAN I2C-HID devices

He Lugang (1):
      HID: multitouch: Add support for lenovo Y9000P Touchpad

Jason Gerecke (6):
      HID: wacom: Improve warning for tablets falling back to default resol=
ution
      HID: wacom: Support touchrings with relative motion
      HID: wacom: Add preliminary support for high-resolution wheel scrolli=
ng
      HID: wacom: Support devices with two touchrings
      HID: wacom: Support sequence numbers smaller than 16-bit
      HID: wacom: Do not warn about dropped packets for first packet

Jinjie Ruan (1):
      hid: cp2112: Use irq_get_trigger_type() helper

Kerem Karabay (1):
      HID: core: add helper for finding a field with a certain usage

Max Staudt (1):
      HID: hid-playstation: DS4: Update rumble and lightbar together

Peter Hutterer (1):
      HID: hidraw: add HIDIOCREVOKE ioctl

Thomas Wei=DFschuh (22):
      HID: bpf: constify parameter rdesc of call_hid_bpf_rdesc_fixup()
      HID: constify parameter rdesc of hid_parse_report()
      HID: constify hid_device::rdesc
      HID: constify params and return value of fetch_item()
      HID: constify hid_device::dev_rdesc
      HID: change return type of report_fixup() to const
      HID: cmedia: constify fixed up report descriptor
      HID: winwing: constify read-only structs
      HID: bigbenff: constify fixed up report descriptor
      HID: dr: constify fixed up report descriptor
      HID: holtek-kbd: constify fixed up report descriptor
      HID: keytouch: constify fixed up report descriptor
      HID: maltron: constify fixed up report descriptor
      HID: xiaomi: constify fixed up report descriptor
      HID: vrc2: constify fixed up report descriptor
      HID: viewsonic: constify fixed up report descriptor
      HID: steelseries: constify fixed up report descriptor
      HID: pxrc: constify fixed up report descriptor
      HID: sony: constify fixed up report descriptor
      HID: waltop: constify fixed up report descriptor
      HID: uclogic: constify fixed up report descriptor
      HID: lg: constify fixed up report descriptor

Thomas Zimmermann (1):
      HID: picoLCD: Use backlight power constants

Vishnu Sankar (1):
      HID: multitouch: Add support for Thinkpad X12 Gen 2 Kbd Portfolio

Yue Haibing (2):
      HID: intel-ish-hid: Remove unused declarations
      HID: amd_sfh: Remove unused declarations

Zhang Lixu (3):
      Documentation: hid: intel-ish-hid: Add vendor custom firmware loading
      HID: intel-ish-hid: Use CPU generation string in driver_data
      hid: intel-ish-hid: Add support for vendor customized firmware loadin=
g

Zhaoxiong Lv (2):
      dt-bindings: HID: i2c-hid: elan: Introduce Elan ekth6a12nay
      HID: i2c-hid: elan: Add elan-ekth6a12nay timing

tammy tseng (1):
      HID: add patch for sis multitouch format

 .../devicetree/bindings/input/elan,ekth6915.yaml   |   4 +-
 .../devicetree/bindings/input/goodix,gt7986u.yaml  |  71 ++
 Documentation/hid/intel-ish-hid.rst                |  29 +
 drivers/hid/Kconfig                                |   6 +
 drivers/hid/Makefile                               |   1 +
 drivers/hid/amd-sfh-hid/amd_sfh_hid.h              |   2 -
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c      |   4 +-
 drivers/hid/bpf/hid_bpf_dispatch.c                 |   6 +-
 drivers/hid/hid-apple.c                            |   2 +-
 drivers/hid/hid-asus.c                             |   2 +-
 drivers/hid/hid-aureal.c                           |   2 +-
 drivers/hid/hid-bigbenff.c                         |   6 +-
 drivers/hid/hid-cherry.c                           |   2 +-
 drivers/hid/hid-chicony.c                          |   4 +-
 drivers/hid/hid-cmedia.c                           |   6 +-
 drivers/hid/hid-core.c                             |  39 +-
 drivers/hid/hid-corsair.c                          |   4 +-
 drivers/hid/hid-cougar.c                           |   4 +-
 drivers/hid/hid-cp2112.c                           |   7 +-
 drivers/hid/hid-cypress.c                          |   2 +-
 drivers/hid/hid-dr.c                               |   8 +-
 drivers/hid/hid-elecom.c                           |   2 +-
 drivers/hid/hid-gembird.c                          |   2 +-
 drivers/hid/hid-glorious.c                         |   2 +-
 drivers/hid/hid-goodix-spi.c                       | 818 +++++++++++++++++=
++++
 drivers/hid/hid-google-hammer.c                    |  27 +-
 drivers/hid/hid-holtek-kbd.c                       |   6 +-
 drivers/hid/hid-holtek-mouse.c                     |   4 +-
 drivers/hid/hid-ids.h                              |  18 +-
 drivers/hid/hid-input.c                            |  37 +-
 drivers/hid/hid-ite.c                              |   2 +-
 drivers/hid/hid-keytouch.c                         |   8 +-
 drivers/hid/hid-kye.c                              |   2 +-
 drivers/hid/hid-lenovo.c                           |   2 +-
 drivers/hid/hid-lg.c                               |  30 +-
 drivers/hid/hid-logitech-hidpp.c                   |   4 +-
 drivers/hid/hid-macally.c                          |   4 +-
 drivers/hid/hid-magicmouse.c                       |   4 +-
 drivers/hid/hid-maltron.c                          |   8 +-
 drivers/hid/hid-microsoft.c                        |   2 +-
 drivers/hid/hid-monterey.c                         |   2 +-
 drivers/hid/hid-multitouch.c                       |  30 +-
 drivers/hid/hid-nti.c                              |   2 +-
 drivers/hid/hid-ortek.c                            |   2 +-
 drivers/hid/hid-petalynx.c                         |   2 +-
 drivers/hid/hid-picolcd_backlight.c                |   5 +-
 drivers/hid/hid-playstation.c                      |  20 +
 drivers/hid/hid-prodikeys.c                        |   2 +-
 drivers/hid/hid-pxrc.c                             |   6 +-
 drivers/hid/hid-redragon.c                         |   2 +-
 drivers/hid/hid-saitek.c                           |   2 +-
 drivers/hid/hid-samsung.c                          |   2 +-
 drivers/hid/hid-semitek.c                          |   4 +-
 drivers/hid/hid-sensor-custom.c                    |   2 +-
 drivers/hid/hid-sensor-hub.c                       |   2 +-
 drivers/hid/hid-sigmamicro.c                       |   4 +-
 drivers/hid/hid-sony.c                             |  14 +-
 drivers/hid/hid-steelseries.c                      |   8 +-
 drivers/hid/hid-sunplus.c                          |   2 +-
 drivers/hid/hid-topre.c                            |   4 +-
 drivers/hid/hid-uclogic-core.c                     |   4 +-
 drivers/hid/hid-uclogic-params.c                   |   4 +-
 drivers/hid/hid-uclogic-params.h                   |  10 +-
 drivers/hid/hid-uclogic-rdesc.c                    |  20 +-
 drivers/hid/hid-uclogic-rdesc.h                    |  20 +-
 drivers/hid/hid-viewsonic.c                        |   8 +-
 drivers/hid/hid-vrc2.c                             |   6 +-
 drivers/hid/hid-waltop.c                           |  30 +-
 drivers/hid/hid-winwing.c                          |   8 +-
 drivers/hid/hid-xiaomi.c                           |   8 +-
 drivers/hid/hid-zydacron.c                         |   2 +-
 drivers/hid/hidraw.c                               |  39 +-
 drivers/hid/i2c-hid/i2c-hid-core.c                 |  42 +-
 drivers/hid/i2c-hid/i2c-hid-of-elan.c              |   8 +
 drivers/hid/intel-ish-hid/ipc/pci-ish.c            |  10 +-
 drivers/hid/intel-ish-hid/ishtp/bus.h              |   1 -
 drivers/hid/intel-ish-hid/ishtp/client.h           |   1 -
 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h        |   8 +-
 drivers/hid/intel-ish-hid/ishtp/loader.c           | 121 ++-
 drivers/hid/wacom_wac.c                            |  87 ++-
 drivers/hid/wacom_wac.h                            |   6 +-
 include/linux/hid.h                                |  12 +-
 include/linux/hid_bpf.h                            |   2 +-
 include/linux/hidraw.h                             |   1 +
 include/uapi/linux/hidraw.h                        |   1 +
 tools/testing/selftests/hid/.gitignore             |   1 +
 tools/testing/selftests/hid/Makefile               |   2 +-
 tools/testing/selftests/hid/hid_bpf.c              | 437 +----------
 tools/testing/selftests/hid/hid_common.h           | 436 +++++++++++
 tools/testing/selftests/hid/hidraw.c               | 237 ++++++
 90 files changed, 2150 insertions(+), 732 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/goodix,gt7986u.=
yaml
 create mode 100644 drivers/hid/hid-goodix-spi.c
 create mode 100644 tools/testing/selftests/hid/hid_common.h
 create mode 100644 tools/testing/selftests/hid/hidraw.c

--=20
Jiri Kosina
SUSE Labs


