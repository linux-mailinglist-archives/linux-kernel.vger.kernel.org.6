Return-Path: <linux-kernel+bounces-186389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFCD8CC38B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92AD41C20CA3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEF325753;
	Wed, 22 May 2024 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GqyHKQjF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF44C22EF4;
	Wed, 22 May 2024 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389441; cv=none; b=q1ubDAxqRMDpPNjQOgMZpMqi2lhdZZm7BR9bppZqFph+7dN72YJMfJfD8OAl1K6ekQDD2+kvmESmyNRTS7Wo89/crs2LPvhYTlTO4ErxAKcWMZxgG4qczBUE3qcK8UxGGfyL+iYCaEju1TB4csTEWMS12uZgWgw0rNmm9yKt0W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389441; c=relaxed/simple;
	bh=W5bA09DBlRWHH2Tf8kmFEwEAQY6JbDlVfEA5gtboA8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fBfsr+M/YKbPcxtgF72N8C2Z2rYPTw81sVKnI6hZu1ITsIvgP9FW+h0dNoiufdvnrz2uVUEbwNjLdLLSQDYI0rzySJVq5ayYduDVSTZPY5hNsphuZCABlXEFYGigYPPM4vj4DnhIAWMDUJA01FDQbuVU3tJhhsKvjfGHbNLb3SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GqyHKQjF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A53C2BBFC;
	Wed, 22 May 2024 14:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716389440;
	bh=W5bA09DBlRWHH2Tf8kmFEwEAQY6JbDlVfEA5gtboA8Q=;
	h=Date:From:To:Cc:Subject:From;
	b=GqyHKQjF9DinCLcg19hNpvdafzaOfQcf8py2mrJAyqym375Nhi3TJ6PTm6Z2NFQhg
	 4qRqSbZaDM+yJYHr2T+A3yFxq2iA3uSdHSaYqXKT1E+wYmiMySNdO+Y4Qjr8gJCj1P
	 O3RJ9TdxYkVeTVHUiduKoobF0bhvKaqSm9xNE4ho=
Date: Wed, 22 May 2024 16:50:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver changes for 6.10-rc1
Message-ID: <Zk4GPfBsYwVvk2H1@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.10-rc1

for you to fetch changes up to eb563dc752d33b0a5d4952964af15ca892f59524:

  staging: pi433: Remove unused driver (2024-05-04 18:42:43 +0200)

----------------------------------------------------------------
Staging driver changes for 6.10-rc1

Here is the big set of staging driver changes for 6.10-rc1.  Not a lot
of cleanups happening this kernel release, intern applications must be
out of sync at the moment.  But we did delete two drivers, wlan-ng and
pi433, as they are no longer in use and the developers involved wanted
them just gone entirely, allowing us to drop 19k lines from the tree.

Other than the normal coding style cleanups here, there has been a lot
of work on the vc04_services code, with the intent to finally get that
out of staging hopefully soon.  It's getting closer, which is nice to
see.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (1):
      fbtft: seps525: Don't use "proxy" headers

Ariel Silver (1):
      Staging: rtl8192e: Declare variable with static

Arnd Bergmann (4):
      greybus: arche-ctrl: move device table to its right location
      staging: rts5208: replace weird strncpy() with memcpy()
      staging: rtl8723bs: convert strncpy to strscpy
      staging: greybus: change strncpy() to strscpy_pad()

Ayush Tiwari (8):
      staging: greybus: Constify gb_audio_module_type
      staging: rtl8712: rename tmpVal to avg_val
      staging: rtl8712: Fix line length exceeding 100 columns
      staging: rtl8712: Remove additional space
      staging: rtl8712: Add space between operands and operator
      staging: rtl8712: rename backupPMKIDList to backup_PMKID_list
      staging: rtl8712: rename backupPMKIDIndex to backup_PMKID_index
      staging: rtl8712: rename backupTKIPCountermeasure to backup_TKIP_countermeasure

Colin Ian King (1):
      staging: vt6655: remove redundant assignment to variable byData

Dan Carpenter (1):
      staging: vc04_services: Delete unnecessary NULL check

Dorine Tipo (3):
      staging: greybus: Add blank line after struct declaration
      staging: vt6655: Remove unused declaration of RFbAL7230SelectChannelPostProcess()
      staging: nvec: Fix documentation typo in nvec.c

Felix N. Kimbu (3):
      staging: wlan-ng: Rename 'foo' to 'rc' in p80211conv.c
      staging: wlan-ng: Rename 'wlan_unsetup' to 'wlan_teardown'
      staging: pi433: Correct comment typos in pi433_if.c

Greg Kroah-Hartman (1):
      Merge 6.9-rc2 into staging-next

Jackson Chui (1):
      staging: greybus: Replace gcam macros with direct dev log calls

Krzysztof Kozlowski (2):
      staging: pi433: drop driver owner assignment
      staging: ks7010: replace open-coded module_sdio_driver()

Marc Dietrich (4):
      staging: nvec: add ability to ignore EC responses in sync writes
      staging: nvec: make keyboard init synchronous
      staging: nvec: make touchpad init synchronous
      staging: nvec: update TODO

Meir Elisha (1):
      Staging: rtl8723bs: Delete dead code from update_current_network()

Michael Straube (2):
      staging: rtl8192e: replace variable with direct return
      staging: rtl8192e: remove unnecessary wrapper

Philipp Hortmann (3):
      staging: wlan-ng: Remove broken driver prism2_usb
      MAINTAINERS: vt665?: Replace Forest with Philipp as maintainer
      staging: pi433: Remove unused driver

Prasad Pandit (1):
      staging: bcm2835-audio: add terminating new line to Kconfig

Rui Miguel Silva (1):
      greybus: lights: check return of get_channel_from_mode

Shahar Avidar (7):
      staging: pi433: Rename struct pi433_device buffer field to tx_buffer.
      staging: pi433: Rename struct pi433_device instances to pi433.
      staging: pi433: Replace pi433_receive param void type to struct pi433_device.
      staging: pi433: Rename "pi433_dev" of type "dev_t" to "pi433_devt"
      staging: pi433: Remove duplicated code using the "goto" error recovery scheme.
      staging: pi433: Add debugfs_remove in case of driver register fails.
      staging: pi433: Reorder pi433_exit cleanup calls.

Stefan Wahren (7):
      staging: vchiq: Reformat Kconfig help texts
      staging: vc04_services: vchiq_arm: Fix NULL ptr dereferences
      staging: vchiq_arm: Drop unnecessary NULL check
      staging: vchiq_core: Use printk messages for devices
      staging: vchiq_core: Add parentheses to VCHIQ_MSG_SRCPORT
      staging: vchiq_core: Drop unnecessary blank lines
      staging: vchiq_core: Add missing blank lines

Sumadhura Kalyan (1):
      staging: vc04_services: Re-align function parameters

Tree Davies (28):
      Staging: rtl8192e: Rename variable ReturnPoint
      Staging: rtl8192e: Rename variable TimeStampLow
      Staging: rtl8192e: Rename variable TimeStampHigh
      Staging: rtl8192e: Rename variable Frame_Order
      Staging: rtl8192e: Rename variable aSifsTime
      Staging: rtl8192e: Rename variable posHTCap
      Staging: rtl8192e: Rename variable bRTSUseShortPreamble
      Staging: rtl8192e: Rename variable pBssHT
      Staging: rtl8192e: Rename variable bAllowAllDA
      Staging: rtl8192e: Rename variable WriteIntoReg
      Staging: rtl8192e: Rename variable CurSTAExtChnlOffset
      Staging: rtl8192e: Rename variable CurrentAMPDUFactor
      Staging: rtl8192e: Rename variable OptMode
      Staging: rtl8192e: Rename variable LSigTxopProtect
      Staging: rtl8192e: Rename variable ChlWidth
      Staging: rtl8192e: Rename variable AdvCoding
      Staging: rtl8192e: Rename variable MimoPwrSave
      Staging: rtl8192e: Rename variable ShortGI40Mhz
      Staging: rtl8192e: Rename variable ShortGI20Mhz
      Staging: rtl8192e: Rename variable GreenField
      Staging: rtl8192e: Rename variable TxSTBC
      Staging: rtl8192e: Rename variable RxSTBC
      Staging: rtl8192e: Rename variable DelayBA
      Staging: rtl8192e: Rename variable MaxAMSDUSize
      Staging: rtl8192e: Rename variable MaxRxAMPDUFactor
      Staging: rtl8192e: Rename variable MPDUDensity
      Staging: rtl8192e: Rename variable ExtHTCapInfo
      Staging: rtl8192e: Rename variable DssCCk

Umang Jain (17):
      staging: vc04_services: Remove unused function declarations
      staging: vc04_services: vchiq_arm: Use appropriate dev_* log helpers
      staging: vc04_services: Do not log error on kzalloc()
      staging: vc04_services: Implement vchiq_bus .remove
      staging: vc04_services: vchiq_core: Stop kthreads on shutdown
      Revert "staging: vc04_services: vchiq_core: Stop kthreads on shutdown"
      staging: vc04_services: Drop g_once_init global variable
      staging: vc04_services: vchiq_arm: Split driver static and runtime data
      staging: vc04_services: vchiq_arm: Drop g_cache_line_size
      staging: vc04_services: Move variables for tracking connections
      staging: vc04_services: Drop vchiq_connected.[ch] files
      staging: vc04_services: Move global variables tracking allocated pages
      staging: vc04_services: Move global memory mapped pointer
      staging: vc04_services: Move spinlocks to vchiq_state
      staging: vc04_services: vchiq_mmal: Rename service_callback()
      staging: vc04_services: Move global g_state to vchiq_state
      staging: vc04_services: Drop completed TODO item

Uri Arev (1):
      staging: axis-fifo: Fix indentation

 MAINTAINERS                                        |    2 +-
 drivers/staging/Kconfig                            |    4 -
 drivers/staging/Makefile                           |    2 -
 drivers/staging/axis-fifo/axis-fifo.c              |   10 +-
 drivers/staging/fbtft/fb_seps525.c                 |    7 +-
 drivers/staging/greybus/arche-apb-ctrl.c           |    1 +
 drivers/staging/greybus/arche-platform.c           |    9 +-
 drivers/staging/greybus/audio_manager_module.c     |    2 +-
 drivers/staging/greybus/camera.c                   |   58 +-
 drivers/staging/greybus/fw-management.c            |   12 +-
 drivers/staging/greybus/light.c                    |    8 +-
 drivers/staging/greybus/loopback.c                 |    1 +
 drivers/staging/ks7010/ks7010_sdio.c               |    2 +-
 drivers/staging/nvec/TODO                          |    1 -
 drivers/staging/nvec/nvec.c                        |   11 +-
 drivers/staging/nvec/nvec_kbd.c                    |    9 +-
 drivers/staging/nvec/nvec_ps2.c                    |   31 +-
 .../Documentation/devicetree/pi433-overlay.dtso    |   48 -
 .../pi433/Documentation/devicetree/pi433.txt       |   62 -
 drivers/staging/pi433/Documentation/pi433.txt      |  274 --
 drivers/staging/pi433/Kconfig                      |   17 -
 drivers/staging/pi433/Makefile                     |    4 -
 drivers/staging/pi433/TODO                         |    8 -
 drivers/staging/pi433/pi433_if.c                   | 1438 --------
 drivers/staging/pi433/pi433_if.h                   |  148 -
 drivers/staging/pi433/rf69.c                       |  832 -----
 drivers/staging/pi433/rf69.h                       |   66 -
 drivers/staging/pi433/rf69_enum.h                  |  126 -
 drivers/staging/pi433/rf69_registers.h             |  478 ---
 drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c  |   11 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c     |   16 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h     |    4 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       |    2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c         |   10 +-
 drivers/staging/rtl8192e/rtl819x_HT.h              |   36 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c          |  104 +-
 drivers/staging/rtl8192e/rtllib.h                  |   20 +-
 drivers/staging/rtl8192e/rtllib_rx.c               |    2 +-
 drivers/staging/rtl8192e/rtllib_softmac_wx.c       |    2 +-
 drivers/staging/rtl8192e/rtllib_tx.c               |    2 +-
 drivers/staging/rtl8192e/rtllib_wx.c               |    8 +-
 drivers/staging/rtl8712/mlme_linux.c               |   18 +-
 drivers/staging/rtl8712/os_intfs.c                 |    3 +-
 drivers/staging/rtl8712/rtl8712_led.c              |    2 +-
 drivers/staging/rtl8712/rtl8712_recv.c             |    6 +-
 drivers/staging/rtl8712/rtl8712_recv.h             |    2 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c          |   92 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |    5 +-
 drivers/staging/rtl8723bs/os_dep/os_intfs.c        |    2 +-
 drivers/staging/rts5208/rtsx_scsi.c                |   10 +-
 drivers/staging/vc04_services/Kconfig              |   36 +-
 drivers/staging/vc04_services/Makefile             |    1 -
 .../staging/vc04_services/bcm2835-audio/Kconfig    |    2 +-
 .../vc04_services/bcm2835-audio/bcm2835-vchiq.c    |    5 +-
 .../vc04_services/bcm2835-camera/bcm2835-camera.c  |    4 +-
 .../include/linux/raspberrypi/vchiq.h              |    4 +-
 drivers/staging/vc04_services/interface/TODO       |   15 -
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |  265 +-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.h  |   41 +-
 .../vc04_services/interface/vchiq_arm/vchiq_bus.c  |   13 +
 .../vc04_services/interface/vchiq_arm/vchiq_bus.h  |    3 +
 .../interface/vchiq_arm/vchiq_connected.c          |   74 -
 .../interface/vchiq_arm/vchiq_connected.h          |   12 -
 .../vc04_services/interface/vchiq_arm/vchiq_core.c |   67 +-
 .../vc04_services/interface/vchiq_arm/vchiq_core.h |   17 +-
 .../interface/vchiq_arm/vchiq_debugfs.c            |    5 +-
 .../vc04_services/interface/vchiq_arm/vchiq_dev.c  |   39 +-
 .../staging/vc04_services/vchiq-mmal/mmal-vchiq.c  |   14 +-
 .../staging/vc04_services/vchiq-mmal/mmal-vchiq.h  |   32 +-
 drivers/staging/vt6655/rf.h                        |    4 -
 drivers/staging/vt6655/srom.c                      |    1 -
 drivers/staging/wlan-ng/Kconfig                    |   13 -
 drivers/staging/wlan-ng/Makefile                   |    8 -
 drivers/staging/wlan-ng/README                     |    8 -
 drivers/staging/wlan-ng/TODO                       |   16 -
 drivers/staging/wlan-ng/cfg80211.c                 |  718 ----
 drivers/staging/wlan-ng/hfa384x.h                  | 1236 -------
 drivers/staging/wlan-ng/hfa384x_usb.c              | 3880 --------------------
 drivers/staging/wlan-ng/p80211conv.c               |  643 ----
 drivers/staging/wlan-ng/p80211conv.h               |  141 -
 drivers/staging/wlan-ng/p80211hdr.h                |  189 -
 drivers/staging/wlan-ng/p80211ioctl.h              |   69 -
 drivers/staging/wlan-ng/p80211metadef.h            |  227 --
 drivers/staging/wlan-ng/p80211metastruct.h         |  236 --
 drivers/staging/wlan-ng/p80211mgmt.h               |  199 -
 drivers/staging/wlan-ng/p80211msg.h                |   39 -
 drivers/staging/wlan-ng/p80211netdev.c             |  988 -----
 drivers/staging/wlan-ng/p80211netdev.h             |  212 --
 drivers/staging/wlan-ng/p80211req.c                |  223 --
 drivers/staging/wlan-ng/p80211req.h                |   33 -
 drivers/staging/wlan-ng/p80211types.h              |  292 --
 drivers/staging/wlan-ng/p80211wep.c                |  207 --
 drivers/staging/wlan-ng/prism2fw.c                 | 1213 ------
 drivers/staging/wlan-ng/prism2mgmt.c               | 1315 -------
 drivers/staging/wlan-ng/prism2mgmt.h               |   89 -
 drivers/staging/wlan-ng/prism2mib.c                |  742 ----
 drivers/staging/wlan-ng/prism2sta.c                | 1945 ----------
 drivers/staging/wlan-ng/prism2usb.c                |  299 --
 98 files changed, 531 insertions(+), 19331 deletions(-)
 delete mode 100644 drivers/staging/pi433/Documentation/devicetree/pi433-overlay.dtso
 delete mode 100644 drivers/staging/pi433/Documentation/devicetree/pi433.txt
 delete mode 100644 drivers/staging/pi433/Documentation/pi433.txt
 delete mode 100644 drivers/staging/pi433/Kconfig
 delete mode 100644 drivers/staging/pi433/Makefile
 delete mode 100644 drivers/staging/pi433/TODO
 delete mode 100644 drivers/staging/pi433/pi433_if.c
 delete mode 100644 drivers/staging/pi433/pi433_if.h
 delete mode 100644 drivers/staging/pi433/rf69.c
 delete mode 100644 drivers/staging/pi433/rf69.h
 delete mode 100644 drivers/staging/pi433/rf69_enum.h
 delete mode 100644 drivers/staging/pi433/rf69_registers.h
 delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
 delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.h
 delete mode 100644 drivers/staging/wlan-ng/Kconfig
 delete mode 100644 drivers/staging/wlan-ng/Makefile
 delete mode 100644 drivers/staging/wlan-ng/README
 delete mode 100644 drivers/staging/wlan-ng/TODO
 delete mode 100644 drivers/staging/wlan-ng/cfg80211.c
 delete mode 100644 drivers/staging/wlan-ng/hfa384x.h
 delete mode 100644 drivers/staging/wlan-ng/hfa384x_usb.c
 delete mode 100644 drivers/staging/wlan-ng/p80211conv.c
 delete mode 100644 drivers/staging/wlan-ng/p80211conv.h
 delete mode 100644 drivers/staging/wlan-ng/p80211hdr.h
 delete mode 100644 drivers/staging/wlan-ng/p80211ioctl.h
 delete mode 100644 drivers/staging/wlan-ng/p80211metadef.h
 delete mode 100644 drivers/staging/wlan-ng/p80211metastruct.h
 delete mode 100644 drivers/staging/wlan-ng/p80211mgmt.h
 delete mode 100644 drivers/staging/wlan-ng/p80211msg.h
 delete mode 100644 drivers/staging/wlan-ng/p80211netdev.c
 delete mode 100644 drivers/staging/wlan-ng/p80211netdev.h
 delete mode 100644 drivers/staging/wlan-ng/p80211req.c
 delete mode 100644 drivers/staging/wlan-ng/p80211req.h
 delete mode 100644 drivers/staging/wlan-ng/p80211types.h
 delete mode 100644 drivers/staging/wlan-ng/p80211wep.c
 delete mode 100644 drivers/staging/wlan-ng/prism2fw.c
 delete mode 100644 drivers/staging/wlan-ng/prism2mgmt.c
 delete mode 100644 drivers/staging/wlan-ng/prism2mgmt.h
 delete mode 100644 drivers/staging/wlan-ng/prism2mib.c
 delete mode 100644 drivers/staging/wlan-ng/prism2sta.c
 delete mode 100644 drivers/staging/wlan-ng/prism2usb.c

