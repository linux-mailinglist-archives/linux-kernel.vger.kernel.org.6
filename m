Return-Path: <linux-kernel+bounces-413516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F239D1A41
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2BF51F22168
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 21:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BE0178395;
	Mon, 18 Nov 2024 21:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuvqCuid"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2451DFDE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 21:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964564; cv=none; b=XV+J7TIW7ecuaKnvbzOC0xVtCV1I++mVvlA2gfN0JOJKUXwdmYU9BOGxpV6cLjsvtmGXQly7B9YrBLIYLS62R1YofxiFfcM8Us29odFeQ9LBw5cB/RP6Fkdf7ef+CCIlMhc2vwKKJ3XnhOCUEfRQN9HTbF1I8LGabqlE24RAqDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964564; c=relaxed/simple;
	bh=X5rDK3q9GZv1j2+lh8rOdU+z3wHO9yp9ZVR4RDFXaAM=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=YY1r0h4rlRF/SwddnUXvsrkuhsrN8kg1X1rQWY8pN29LPL+bUZFrwQu2OoodfopOhhg8CEeLYGls49L4/yjizyv1oLGoNcNpeQCsueQMV8MZbw7YsepI9mEd5teLl35zXDUobi/vtCB0R4nUQAlOTbxmGM0n0zfApfcjP5P2SoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuvqCuid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5819C4CECC;
	Mon, 18 Nov 2024 21:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731964564;
	bh=X5rDK3q9GZv1j2+lh8rOdU+z3wHO9yp9ZVR4RDFXaAM=;
	h=Date:From:To:cc:Subject:From;
	b=tuvqCuidH320LAmKHciunziqlMPT+KW6kj9M28k8IeJnz0+zgrSYncmiNNZN6iPVB
	 +emQ+7a9yq2yBYohsTaS2a6J1bKxTtxN/2uPTEyUYvUsM5afgy+lx2y8/tT77udaxw
	 +8kvkDj6ZeT9M674P30WGhbIi5+XaEemytjBIp/sQOcB/xhJ3jRjE8hWgeTjThiWpj
	 /Hu10p5YlgwvA1wEIiNoV1ADcReITcgKlu/w9izAYHN1WbSmPolynLItlXQYDL37wZ
	 ckDwh3n3D6EQrfpWr2i//1e5DKB9RpgTd+dBJZcZoz5IArns13RooRT5XzOkeg7z8T
	 bWgxmCDQdKeeg==
Date: Mon, 18 Nov 2024 22:16:01 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID for 6.13
Message-ID: <nycvar.YFH.7.76.2411182207390.20286@cbobk.fhfr.pm>
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
nus-2024111801

to receive HID subsystem queue for 6.13 merge window.

Please note: there is one SHA that you might notice was not present in=20
linux-next, and that's e8a0581914bd ("HID: multitouch: make mt_set_mode()=
=20
less cryptic").

The reason for this is that there was a hiccup when merging this patch=20
originally, and the topic branch was based on some random state of the=20
for-next branch, so it contained a lot of unrelated churn. And I've=20
noticed that only now, when preparing the pull request. The end result is=
=20
identical on a code level, but I didn't want to send you the branch with=20
git merge history that makes no sense [1], so I've created [2] instead,=20
and that's the one present in this pull request.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/log/?h=3Dfo=
r-6.13/multitouch

Highlights:

=3D=3D=3D=3D=3D
- improvement of the way hid-bpf coexists with specific drivers=20
  (others than hid-generic) that are already bound to devices (Benjamin=20
  Tissoires)
- removal of three way-too-aggressive BUG_ON()s from HID drivers (He=20
  Lugang)
- assorted cleanups and small code fixes to HID core (Dmitry Torokhov, Yan=
=20
  Zhen, Nathan Chancellor, Andy Shevchenko)
- support for Corsair Void headset family (Stuart Hayhurst)
- Support for Goodix GT7986U SPI (Charles Wang)
- initial vendor-specific driver for Kysona, currently adding support for
  Kysona M600 (Lode Willems)
- other assorted code cleanups and small bugfixes all over the place
=3D=3D=3D=3D=3D

Thanks!

----------------------------------------------------------------
Andy Shevchenko (1):
      HID: debug: Remove duplicates from 'keys'

Bastien Nocera (3):
      HID: logitech-hidpp: Remove feature_type from hidpp_root_get_feature(=
)
      HID: steelseries: Fix battery requests stopping after some time
      HID: steelseries: Add capacity_level mapping

Benjamin Tissoires (12):
      HID: bpf: move HID-BPF report descriptor fixup earlier
      HID: core: save one kmemdup during .probe()
      HID: core: remove one more kmemdup on .probe()
      HID: bpf: allow write access to quirks field in struct hid_device
      selftests/hid: add dependency on hid_common.h
      selftests/hid: cleanup C tests by adding a common struct uhid_device
      selftests/hid: allow to parametrize bus/vid/pid/rdesc on the test dev=
ice
      HID: add per device quirk to force bind to hid-generic
      selftests/hid: add test for assigning a given device to hid-generic
      HID: bpf: Fix NKRO on Mistel MD770
      HID: bpf: Fix Rapoo M50 Plus Silent side buttons
      HID: bpf: drop use of Logical|Physical|UsageRange

Callahan Kovacs (1):
      HID: magicmouse: Apple Magic Trackpad 2 USB-C driver support

Charles Wang (4):
      HID: hid-goodix: Return 0 when receiving an empty HID feature package
      HID: hid-goodix: Fix HID get/set feature operation overwritten proble=
m
      dt-bindings: input: Goodix GT7986U SPI HID Touchscreen
      HID: hid-goodix-spi: Add OF supports

Dmitry Torokhov (4):
      HID: simplify code in fetch_item()
      HID: simplify snto32()
      HID: stop exporting hid_snto32()
      HID: multitouch: make mt_set_mode() less cryptic

Erick Archer (1):
      HID: ishtp-hid-client: replace fake-flex arrays with flex-array membe=
rs

He Lugang (1):
      HID: replace BUG_ON() with WARN_ON()

Jason Gerecke (2):
      HID: wacom: Set eraser status when either 'Eraser' or 'Invert' usage =
is set
      HID: wacom: Interpret tilt data from Intuos Pro BT as signed values

Lode Willems (4):
      HID: Add IDs for Kysona
      HID: Kysona: Add basic battery reporting for Kysona M600
      HID: Kysona: check battery status every 5s using a workqueue
      HID: Kysona: add basic online status

Nathan Chancellor (1):
      HID: Remove default case statement in fetch_item()

Stuart Hayhurst (1):
      HID: corsair-void: Add Corsair Void headset family driver

Uwe Kleine-K=F6nig (1):
      HID: i2c-hid-of: Drop explicit initialization of struct i2c_device_id=
::driver_data to 0

Vincent Huang (1):
      HID: rmi: Add select RMI4_F3A in Kconfig

Vitaly Kuznetsov (1):
      HID: hyperv: streamline driver probe to avoid devres issues

Yan Zhen (1):
      HID: Fix typo in the comment

Zhang Lixu (1):
      HID: intel-ish-hid: Add firmware version sysfs attributes

 .../ABI/testing/sysfs-driver-hid-corsair-void      |  38 +
 .../bindings/input/goodix,gt7986u-spifw.yaml       |  69 ++
 drivers/hid/Kconfig                                |  13 +
 drivers/hid/Makefile                               |   3 +-
 drivers/hid/bpf/hid_bpf_dispatch.c                 |   9 +-
 drivers/hid/bpf/hid_bpf_struct_ops.c               |   1 +
 drivers/hid/bpf/progs/Huion__Dial-2.bpf.c          |  66 +-
 drivers/hid/bpf/progs/Huion__Inspiroy-2-S.bpf.c    |  60 +-
 drivers/hid/bpf/progs/Mistel__MD770.bpf.c          | 154 ++++
 drivers/hid/bpf/progs/Rapoo__M50-Plus-Silent.bpf.c | 148 ++++
 drivers/hid/bpf/progs/hid_report_helpers.h         |  36 +-
 drivers/hid/hid-asus.c                             |   2 +-
 drivers/hid/hid-core.c                             | 182 +++--
 drivers/hid/hid-corsair-void.c                     | 829 +++++++++++++++++=
++++
 drivers/hid/hid-cp2112.c                           |   3 +-
 drivers/hid/hid-debug.c                            |   9 +-
 drivers/hid/hid-generic.c                          |   3 +
 drivers/hid/hid-goodix-spi.c                       |  35 +-
 drivers/hid/hid-hyperv.c                           |  58 +-
 drivers/hid/hid-ids.h                              |   5 +
 drivers/hid/hid-kysona.c                           | 248 ++++++
 drivers/hid/hid-lg4ff.c                            |   3 +-
 drivers/hid/hid-logitech-hidpp.c                   |  74 +-
 drivers/hid/hid-magicmouse.c                       |  56 +-
 drivers/hid/hid-multitouch.c                       |  30 +-
 drivers/hid/hid-picolcd_fb.c                       |   2 +-
 drivers/hid/hid-sensor-custom.c                    |   2 +-
 drivers/hid/hid-sony.c                             |   3 +-
 drivers/hid/hid-steam.c                            |   2 +-
 drivers/hid/hid-steelseries.c                      |  19 +-
 drivers/hid/i2c-hid/i2c-hid-of.c                   |   6 +-
 drivers/hid/intel-ish-hid/ipc/pci-ish.c            |  45 ++
 drivers/hid/intel-ish-hid/ishtp-fw-loader.c        |   2 +-
 drivers/hid/intel-ish-hid/ishtp-hid-client.c       |  25 +-
 drivers/hid/intel-ish-hid/ishtp-hid.h              |  11 +-
 drivers/hid/intel-ish-hid/ishtp/client.c           |   2 +-
 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h        |  12 +
 drivers/hid/intel-ish-hid/ishtp/loader.c           |  35 +-
 drivers/hid/intel-ish-hid/ishtp/loader.h           |  34 +
 drivers/hid/usbhid/hid-core.c                      |   2 +-
 drivers/hid/wacom_wac.c                            |  11 +-
 drivers/hid/wacom_wac.h                            |   2 +-
 include/linux/hid.h                                |  21 +-
 include/linux/hid_bpf.h                            |  11 +-
 tools/testing/selftests/hid/Makefile               |   2 +-
 tools/testing/selftests/hid/hid_bpf.c              | 151 ++--
 tools/testing/selftests/hid/hid_common.h           | 112 ++-
 tools/testing/selftests/hid/hidraw.c               |  36 +-
 tools/testing/selftests/hid/progs/hid.c            |  12 +
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  |   6 +-
 50 files changed, 2288 insertions(+), 412 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-corsair-void
 create mode 100644 Documentation/devicetree/bindings/input/goodix,gt7986u-=
spifw.yaml
 create mode 100644 drivers/hid/bpf/progs/Mistel__MD770.bpf.c
 create mode 100644 drivers/hid/bpf/progs/Rapoo__M50-Plus-Silent.bpf.c
 create mode 100644 drivers/hid/hid-corsair-void.c
 create mode 100644 drivers/hid/hid-kysona.c

--=20
Jiri Kosina
SUSE Labs


