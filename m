Return-Path: <linux-kernel+bounces-253832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6314E932791
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870C31C22BF3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17A117C9FC;
	Tue, 16 Jul 2024 13:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoDRxLKi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768AC1991A4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136874; cv=none; b=Ji4WySAyalh3Kzh7fdjUvy4TiNpPw+ODNY2koG+iLUf1G4a/IG/R6aSh3isM/GyW7TjjPjifiuwVUuHVJOfgP1O4zdJJ9NUmWFDueenveZCNPtyJ0Z/vCkJeduyEobMEPFgyZpa2pE1T7Bt2OQ+bBRxgpCYgD4mYJpTfqZ/6ox8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136874; c=relaxed/simple;
	bh=waIkeAXi3WuqUlYCaMEcJ6GI9MZ0tEZg+XbAklqvxLA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J299Ox78sKcYcBd+mHPnHiifhqLmyWLV33cGE1B267r7jT3fKGRJmmmKv+HgRoOzo3MIltddxbSuW1wqph+D2ujje3tFPSPWzmheoy+/fXiOxy07nVB53GByuGDxu+pW1rShwVdT8SkBE/KWtKZIHnxReJoR3RD49dFk94XG7FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoDRxLKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59049C116B1;
	Tue, 16 Jul 2024 13:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721136874;
	bh=waIkeAXi3WuqUlYCaMEcJ6GI9MZ0tEZg+XbAklqvxLA=;
	h=Date:From:To:Cc:Subject:From;
	b=KoDRxLKiC4JKKPj3nx4pHTbwrBVxCDWsuKsiAHwVSsZgOcFdylSVCSOFFABs/FHuJ
	 7WvBcPFYHefkcMlVHLnoqBMLBv5Y/JJGXByjwqz70jOJm3S92nXzKG6p9wIXyFEQr3
	 Y70Pr4PKcF+4uSRxBAPXeS8fXiaewodJHvAOOVStdtcpZQBh00Iy6J2BmqRV79qF05
	 235mwWtEdTQqwn4PTruAHKbldnnjwLWd8PRP+wWtL6cYYoDTm7PHL54dkbdncwzgRA
	 84f6usDAeHEjz/SMhfotXjtGQcl6c1x26dBNpjFonhFI7xut0BepzK399iVs58DNOF
	 d6j7lOm1jiKIg==
Date: Tue, 16 Jul 2024 15:34:30 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID for 6.11
Message-ID: <uirri5bsktq5pk2tu4gs2u22qimjcn7hi66ek6gbj65qyczfex@yjy4brkoixfv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2024071601

to receive HID subsystem updates for 6.11 merge window. Highlights:

=====
- rewrite of the HID-BPF internal implementation to use bpf struct_ops
  instead of a tracing endpoint (Benjamin Tissoires)
- add 2 new HID-BPF hooks to be able to intercept userspace calls
  targetting a HID device and filtering them (Benjamin Tissoires)
- add support for various new devices through HID-BPF filters (Benjamin
  Tissoires)
- add support for the magic keyboard backlight (Orlando Chamberlain)
- add the missing MODULE_DESCRIPTION() macros in HID drivers (Jeff Johnson)
- use of kvzalloc in case memory gets too fragmented (Hailong Liu)
- retrieve the device firmware node in the child HID device (Danny Kaehn)
- some hid-uclogic improvements (José Expósito)
- some more typos, trivial fixes, kernel doctext and unused functions
  cleanups
=====

You are going to get a trivial conflict with the mm tree in include/linux/hid_bpf.h
which is documented here:

        https://lore.kernel.org/all/20240709112544.190ffda4@canb.auug.org.au/

You will also get a build failure after merging with the
bpf-next/net-next tree in drivers/hid/bpf/hid_bpf_struct_ops.c which is
documented here:

        https://lore.kernel.org/all/ZnB9X1Jj6c04ufC0@sirena.org.uk/

Please let me know in case you'd like me to fix those and prepare a merged
branch for you.


Thanks!

----------------------------------------------------------------
Benjamin Tissoires (41):
      HID: rename struct hid_bpf_ops into hid_ops
      HID: bpf: add hid_get/put_device() helpers
      HID: bpf: implement HID-BPF through bpf_struct_ops
      selftests/hid: convert the hid_bpf selftests with struct_ops
      HID: samples: convert the 2 HID-BPF samples into struct_ops
      HID: bpf: add defines for HID-BPF SEC in in-tree bpf fixes
      HID: bpf: convert in-tree fixes into struct_ops
      HID: bpf: remove tracing HID-BPF capability
      selftests/hid: add subprog call test
      Documentation: HID: amend HID-BPF for struct_ops
      Documentation: HID: add a small blurb on udev-hid-bpf
      HID: bpf: Artist24: remove unused variable
      HID: bpf: error on warnings when compiling bpf objects
      bpf: allow bpf helpers to be used into HID-BPF struct_ops
      HID: bpf: rework hid_bpf_ops_btf_struct_access
      HID: bpf: make part of struct hid_device writable
      HID: bpf: fix dispatch_hid_bpf_device_event uninitialized ret value
      HID: add source argument to HID low level functions
      HID: bpf: protect HID-BPF prog_list access by a SRCU
      HID: bpf: add HID-BPF hooks for hid_hw_raw_requests
      HID: bpf: prevent infinite recursions with hid_hw_raw_requests hooks
      selftests/hid: add tests for hid_hw_raw_request HID-BPF hooks
      HID: bpf: add HID-BPF hooks for hid_hw_output_report
      selftests/hid: add tests for hid_hw_output_report HID-BPF hooks
      HID: bpf: make hid_bpf_input_report() sleep until the device is ready
      selftests/hid: add wq test for hid_bpf_input_report()
      HID: bpf: allow hid_device_event hooks to inject input reports on self
      selftests/hid: add another test for injecting an event from an event hook
      selftests/hid: add an infinite loop test for hid_bpf_try_input_report
      selftests/hid: ensure CKI can compile our new tests on old kernels
      HID: bpf: fix gcc warning and unify __u64 into u64
      HID: bpf: doc fixes for hid_hw_request() hooks
      HID: bpf: doc fixes for hid_hw_request() hooks
      HID: bpf: Add a HID report composition helper macros
      HID: bpf: add a driver for the Huion Inspiroy 2S (H641P)
      HID: bpf: move the BIT() macro to hid_bpf_helpers.h
      HID: bpf: Add support for the XP-PEN Deco Mini 4
      HID: bpf: Add Huion Dial 2 bpf fixup
      HID: bpf: Thrustmaster TCA Yoke Boeing joystick fix
      HID: fix for amples in for-6.11/bpf
      HID: samples: fix the 2 struct_ops definitions

Chen Ni (1):
      HID: mcp2221: Remove unnecessary semicolon

Colin Ian King (1):
      HID: Fix spelling mistakes "Kensigton" -> "Kensington"

Danny Kaehn (1):
      HID: usbhid: Share USB device firmware node with child HID device

Hailong.Liu (1):
      HID: Use kvzalloc instead of kzalloc in hid_register_field()

Jeff Johnson (7):
      HID: intel-ish-hid: fix ishtp_wait_resume() kernel-doc
      HID: intel-ish-hid: add MODULE_DESCRIPTION()
      HID: letsketch: add missing MODULE_DESCRIPTION() macro
      HID: lg-g15: add missing MODULE_DESCRIPTION() macro
      HID: logitech-dj: add missing MODULE_DESCRIPTION() macro
      HID: add missing MODULE_DESCRIPTION() macros
      HID: add more missing MODULE_DESCRIPTION() macros

Jiapeng Chong (1):
      HID: nintendo: Remove some unused functions

José Expósito (4):
      HID: uclogic: Support HUION devices with up to 20 buttons
      HID: uclogic: Use Rx and Ry for touch strips
      HID: uclogic: Avoid linking common code into multiple modules
      HID: uclogic: Add module description

Luis Felipe Hernandez (1):
      hid: bpf: Fix grammar

Orlando Chamberlain (1):
      HID: apple: Add support for magic keyboard backlight on T2 Macs

Thorsten Blum (1):
      HID: hid-steam: Fix typo in goto label

 Documentation/hid/hid-bpf.rst                                                          |  173 ++---
 drivers/hid/Makefile                                                                   |    6 +-
 drivers/hid/bpf/Makefile                                                               |    2 +-
 drivers/hid/bpf/entrypoints/Makefile                                                   |   93 ---
 drivers/hid/bpf/entrypoints/README                                                     |    4 -
 drivers/hid/bpf/entrypoints/entrypoints.bpf.c                                          |   25 -
 drivers/hid/bpf/entrypoints/entrypoints.lskel.h                                        |  248 -------
 drivers/hid/bpf/hid_bpf_dispatch.c                                                     |  419 ++++++------
 drivers/hid/bpf/hid_bpf_dispatch.h                                                     |   13 +-
 drivers/hid/bpf/hid_bpf_jmp_table.c                                                    |  565 ----------------
 drivers/hid/bpf/hid_bpf_struct_ops.c                                                   |  307 +++++++++
 drivers/hid/bpf/progs/FR-TEC__Raptor-Mach-2.bpf.c                                      |    9 +-
 drivers/hid/bpf/progs/HP__Elite-Presenter.bpf.c                                        |    6 +-
 drivers/hid/bpf/progs/Huion__Dial-2.bpf.c                                              |  614 +++++++++++++++++
 drivers/hid/bpf/progs/Huion__Inspiroy-2-S.bpf.c                                        |  534 +++++++++++++++
 drivers/hid/bpf/progs/Huion__Kamvas-Pro-19.bpf.c                                       |    9 +-
 drivers/hid/bpf/progs/IOGEAR__Kaliber-MMOmentum.bpf.c                                  |    6 +-
 drivers/hid/bpf/progs/Makefile                                                         |    2 +-
 drivers/hid/bpf/progs/{Microsoft__XBox-Elite-2.bpf.c => Microsoft__Xbox-Elite-2.bpf.c} |   21 +-
 drivers/hid/bpf/progs/Thrustmaster__TCA-Yoke-Boeing.bpf.c                              |  144 ++++
 drivers/hid/bpf/progs/Wacom__ArtPen.bpf.c                                              |    6 +-
 drivers/hid/bpf/progs/XPPen__Artist24.bpf.c                                            |   12 +-
 drivers/hid/bpf/progs/XPPen__ArtistPro16Gen2.bpf.c                                     |   24 +-
 drivers/hid/bpf/progs/XPPen__DecoMini4.bpf.c                                           |  231 +++++++
 drivers/hid/bpf/progs/hid_bpf.h                                                        |    6 +
 drivers/hid/bpf/progs/hid_bpf_helpers.h                                                |    1 +
 drivers/hid/bpf/progs/hid_report_helpers.h                                             | 2960 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-a4tech.c                                                               |    1 +
 drivers/hid/hid-apple.c                                                                |   88 +++
 drivers/hid/hid-aureal.c                                                               |    1 +
 drivers/hid/hid-belkin.c                                                               |    1 +
 drivers/hid/hid-betopff.c                                                              |    1 +
 drivers/hid/hid-bigbenff.c                                                             |    1 +
 drivers/hid/hid-cherry.c                                                               |    1 +
 drivers/hid/hid-chicony.c                                                              |    1 +
 drivers/hid/hid-core.c                                                                 |  133 ++--
 drivers/hid/hid-cypress.c                                                              |    1 +
 drivers/hid/hid-dr.c                                                                   |    1 +
 drivers/hid/hid-elecom.c                                                               |    1 +
 drivers/hid/hid-elo.c                                                                  |    1 +
 drivers/hid/hid-emsff.c                                                                |    1 +
 drivers/hid/hid-evision.c                                                              |    1 +
 drivers/hid/hid-ezkey.c                                                                |    1 +
 drivers/hid/hid-gaff.c                                                                 |    1 +
 drivers/hid/hid-google-hammer.c                                                        |    1 +
 drivers/hid/hid-google-stadiaff.c                                                      |    1 +
 drivers/hid/hid-gyration.c                                                             |    1 +
 drivers/hid/hid-holtek-kbd.c                                                           |    1 +
 drivers/hid/hid-holtek-mouse.c                                                         |    1 +
 drivers/hid/hid-ite.c                                                                  |    1 +
 drivers/hid/hid-kensington.c                                                           |    3 +-
 drivers/hid/hid-keytouch.c                                                             |    1 +
 drivers/hid/hid-kye.c                                                                  |    1 +
 drivers/hid/hid-lcpower.c                                                              |    1 +
 drivers/hid/hid-lenovo.c                                                               |    1 +
 drivers/hid/hid-letsketch.c                                                            |    1 +
 drivers/hid/hid-lg-g15.c                                                               |    1 +
 drivers/hid/hid-lg.c                                                                   |    1 +
 drivers/hid/hid-logitech-dj.c                                                          |    1 +
 drivers/hid/hid-magicmouse.c                                                           |    1 +
 drivers/hid/hid-maltron.c                                                              |    1 +
 drivers/hid/hid-mcp2221.c                                                              |    2 +-
 drivers/hid/hid-megaworld.c                                                            |    1 +
 drivers/hid/hid-mf.c                                                                   |    1 +
 drivers/hid/hid-microsoft.c                                                            |    1 +
 drivers/hid/hid-monterey.c                                                             |    1 +
 drivers/hid/hid-nintendo.c                                                             |   21 -
 drivers/hid/hid-ntrig.c                                                                |    1 +
 drivers/hid/hid-ortek.c                                                                |    1 +
 drivers/hid/hid-petalynx.c                                                             |    1 +
 drivers/hid/hid-pl.c                                                                   |    1 +
 drivers/hid/hid-primax.c                                                               |    1 +
 drivers/hid/hid-prodikeys.c                                                            |    1 +
 drivers/hid/hid-razer.c                                                                |    1 +
 drivers/hid/hid-redragon.c                                                             |    1 +
 drivers/hid/hid-retrode.c                                                              |    1 +
 drivers/hid/hid-saitek.c                                                               |    1 +
 drivers/hid/hid-samsung.c                                                              |    1 +
 drivers/hid/hid-semitek.c                                                              |    1 +
 drivers/hid/hid-sjoy.c                                                                 |    1 +
 drivers/hid/hid-sony.c                                                                 |    1 +
 drivers/hid/hid-speedlink.c                                                            |    1 +
 drivers/hid/hid-steam.c                                                                |    5 +-
 drivers/hid/hid-steelseries.c                                                          |    1 +
 drivers/hid/hid-sunplus.c                                                              |    1 +
 drivers/hid/hid-tivo.c                                                                 |    1 +
 drivers/hid/hid-tmff.c                                                                 |    1 +
 drivers/hid/hid-topseed.c                                                              |    1 +
 drivers/hid/hid-twinhan.c                                                              |    1 +
 drivers/hid/hid-uclogic-core.c                                                         |    2 +
 drivers/hid/hid-uclogic-rdesc-test.c                                                   |    2 +
 drivers/hid/hid-uclogic-rdesc.c                                                        |   11 +-
 drivers/hid/hid-viewsonic.c                                                            |    1 +
 drivers/hid/hid-vivaldi-common.c                                                       |    1 +
 drivers/hid/hid-waltop.c                                                               |    1 +
 drivers/hid/hid-winwing.c                                                              |    1 +
 drivers/hid/hid-xinmo.c                                                                |    1 +
 drivers/hid/hid-zpff.c                                                                 |    1 +
 drivers/hid/hid-zydacron.c                                                             |    1 +
 drivers/hid/hidraw.c                                                                   |   10 +-
 drivers/hid/intel-ish-hid/ishtp/bus.c                                                  |    2 +
 drivers/hid/usbhid/hid-core.c                                                          |    2 +
 include/linux/hid.h                                                                    |    7 +
 include/linux/hid_bpf.h                                                                |  202 ++++--
 samples/hid/Makefile                                                                   |    5 +-
 samples/hid/hid_bpf_attach.bpf.c                                                       |   18 -
 samples/hid/hid_bpf_attach.h                                                           |   14 -
 samples/hid/hid_mouse.bpf.c                                                            |   26 +-
 samples/hid/hid_mouse.c                                                                |   39 +-
 samples/hid/hid_surface_dial.bpf.c                                                     |   10 +-
 samples/hid/hid_surface_dial.c                                                         |   53 +-
 tools/testing/selftests/hid/hid_bpf.c                                                  |  426 +++++++++++-
 tools/testing/selftests/hid/progs/hid.c                                                |  392 ++++++++++-
 tools/testing/selftests/hid/progs/hid_bpf_helpers.h                                    |   46 +-
 114 files changed, 6443 insertions(+), 1579 deletions(-)
 delete mode 100644 drivers/hid/bpf/entrypoints/Makefile
 delete mode 100644 drivers/hid/bpf/entrypoints/README
 delete mode 100644 drivers/hid/bpf/entrypoints/entrypoints.bpf.c
 delete mode 100644 drivers/hid/bpf/entrypoints/entrypoints.lskel.h
 delete mode 100644 drivers/hid/bpf/hid_bpf_jmp_table.c
 create mode 100644 drivers/hid/bpf/hid_bpf_struct_ops.c
 create mode 100644 drivers/hid/bpf/progs/Huion__Dial-2.bpf.c
 create mode 100644 drivers/hid/bpf/progs/Huion__Inspiroy-2-S.bpf.c
 rename drivers/hid/bpf/progs/{Microsoft__XBox-Elite-2.bpf.c => Microsoft__Xbox-Elite-2.bpf.c} (89%)
 create mode 100644 drivers/hid/bpf/progs/Thrustmaster__TCA-Yoke-Boeing.bpf.c
 create mode 100644 drivers/hid/bpf/progs/XPPen__DecoMini4.bpf.c
 create mode 100644 drivers/hid/bpf/progs/hid_report_helpers.h
 delete mode 100644 samples/hid/hid_bpf_attach.bpf.c
 delete mode 100644 samples/hid/hid_bpf_attach.h


