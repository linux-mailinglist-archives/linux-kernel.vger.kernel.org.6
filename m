Return-Path: <linux-kernel+bounces-257274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8939377BB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6D95B21218
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91E81339B1;
	Fri, 19 Jul 2024 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N1HNfe/K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB85675808;
	Fri, 19 Jul 2024 12:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391970; cv=none; b=nfiPAqscSCfvOOZ8Nhg6qU9PfH1XLvafc+OH3sLioaJTSgFC/pkr6oikfxxItIx2j8kbcdvIGyD2feCvC2CYrNvYkrJ/0bz3D2H3Vve0WwfDHvSYzNduF+cF6B4+TL4EMXgFi1P7WZt9U7qP8r9GyWBth5OEex5DHUAlAaSILcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391970; c=relaxed/simple;
	bh=JENgZSs9W76IQ6K48j3mT//+gfM5xsKP2pnOlgAE/4U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G3G41O6JtmGQ5JOAvAB+a916w7F7qoz2XCVGGAsZJ3dkFI278E5t5kAYC0hQ7cvm5Jq/6q8++GQ7e/r1E74Gz6hh0etHKGcDPsqpIUjIo41nYQkdT7bAfR44KOxL8FX78Wrq+PSWQFoQV38EezdIhxvPdjTZFUvFmCXsJD2EJlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N1HNfe/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFF3C32782;
	Fri, 19 Jul 2024 12:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721391970;
	bh=JENgZSs9W76IQ6K48j3mT//+gfM5xsKP2pnOlgAE/4U=;
	h=Date:From:To:Cc:Subject:From;
	b=N1HNfe/K5mE6vWhp19G/SMAUYFPCQ4NZTISD6XPlp4jHL+HsHYGoaKn8bLT7iOHdB
	 5uIpsg5ya+IuYnYu06IEjBoCDvoydHj+Y8m7QrkuAhSE6ztbVrb1sg6tkw8vB+Kkel
	 Mp3s6sIBc3Y6TpI3ATfMUAc4acVl++mU5gKJriKo=
Date: Fri, 19 Jul 2024 14:26:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver changes for 6.11-rc1
Message-ID: <ZppbX-7yYMwv7UJA@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 22a40d14b572deb80c0648557f4bd502d7e83826:

  Linux 6.10-rc6 (2024-06-30 14:40:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.11-rc1

for you to fetch changes up to 104e004739ef03890a1e175b3c2672d50c6d1a6a:

  staging: rtl8723bs: Remove constant result function CheckNegative() (2024-07-10 14:52:34 +0200)

----------------------------------------------------------------
Staging driver updates for 6.11-rc1

This is the "big" staging driver update for 6.11-rc1.  Not really all
that much happened this release cycle, just lots of tiny cleanups,
overall about 3000 lines removed, so the cleanups were worth it.

Included in here are:
  - loads of rtl8723bs driver cleanups
  - lots of rtl8192e driver cleanups
  - vc04_services reworks and cleanups as that codebase gets slowly
    evolved into something that will make it into the "real" part of the
    kernel hopefully soon.
  - other tiny staging driver cleanups

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ashok Kumar (1):
      staging: vme_user: Add blank line after struct decl

Chen shuo (1):
      staging: rtl8192e: remove the r8192E_dev.c's unnecessary brace

Dr. David Alan Gilbert (2):
      staging: r8712u: remove unused struct 'zero_bulkout_context'
      staging: greybus: audio: remove unused struct gb_mixer_control

Greg Kroah-Hartman (2):
      Merge tag 'v6.10-rc4' into staging-next
      Merge 6.10-rc6 into staging-next

Jeff Johnson (3):
      staging: greybus: add missing MODULE_DESCRIPTION() macros
      staging: fbtft: add missing MODULE_DESCRIPTION() macro
      staging: rtl8192e: add missing MODULE_DESCRIPTION() macros

Marc Dietrich (1):
      staging: nvec: make i2c controller register writes robust

Michael Straube (2):
      staging: rtl8192e: reduce indentation level
      staging: rtl8192e: remove unnecessary line breaks

Nam Cao (1):
      staging: rtl8712: remove unnecessary alignment of pxmitpriv->pxmitbuf

Philipp Hortmann (29):
      staging: rtl8723bs: Remove unused structs starting with profile_info
      staging: rtl8723bs: Remove switch(type) as type is constant
      staging: rtl8723bs: Remove unused declarations start with sd_hal_bus_init
      staging: rtl8723bs: Remove empty file sdio_osintf.h
      staging: rtl8723bs: Remove unused macros in wifi.h
      staging: rtl8723bs: Remove unused macros in sta_info.h
      staging: rtl8723bs: Remove unused macros in rtw_xmit.h
      staging: rtl8723bs: Remove unused macros in rtw_security.h
      staging: rtl8723bs: Remove unused macros in rtw_recv.h
      staging: rtl8723bs: Remove unused macros in rtw_pwrctrl.h
      staging: rtl8723bs: Remove unused macros in rtw_mp.h
      staging: rtl8723bs: Remove unused macros in rtw_mlme.h
      staging: rtl8723bs: Remove unused macros in rtw_io.h
      staging: rtl8723bs: Remove unused macro in ioctl_cfg80211.c
      staging: rtl8723bs: Remove unused variable pwdev_priv
      staging: rtl8723bs: Remove unused macros in hal_com_h2c.h
      staging: rtl8723bs: Remove unused macros in rtw_ht.h
      staging: rtl8723bs: Remove unused macros in hal_com_reg.h
      staging: rtl8723bs: Remove unused macros in hal_phy_reg_8723b.h
      staging: rtl8723bs: Move last macro from hal_phy_reg_8723b.h
      staging: rtl8723bs: Delete file hal_phy_reg_8723b.h
      staging: rtl8723bs: Remove unused macros in Hal8192CPhyReg.h
      staging: rtl8723bs: Remove unused macros in Hal8723BReg.h
      staging: rtl8723bs: Remove unused macros in HalPwrSeqCmd.h
      staging: rtl8723bs: Remove unused macros in rtw_mlme.h
      staging: rtl8723bs: Remove unused macros in rtw_efuse.h
      staging: rtl8723bs: Remove unused macros in hal_pwr_seq.h
      staging: rtl8723bs: Remove unused macros in rtw_mlme_ext.h
      staging: rtl8723bs: Remove constant result function CheckNegative()

Roshan Khatri (7):
      staging: rtl8712: Fix spelling mistake in rtl871x_event.h
      staging: rtl8712: Fix spelling mistake in rtl8712_xmit.c
      staging: rtl8192e: Fix spelling mistakes in rtllib_softmac.c
      staging: rtl8712: Fix spelling mistake in rtl871x_mlme.c
      staging: rtl8712: Fix spelling mistake in rtl871x_io.h
      staging: rtl8723bs: hal: Fix spelling mistakes in rtl8723b_cmd.c
      staging: rtl8723bs: hal: Fix spelling mistakes in odm.h

Stefan Wahren (10):
      staging: vchiq_arm: Unify return code variable
      staging: vchiq_arm: Drop obsolete comment
      staging: vchiq_core: Drop non-functional struct members
      staging: vchiq_arm: Drop unnecessary declarations
      staging: vchiq_arm: Get the rid off struct vchiq_2835_state
      staging: vchiq_arm: Drop vchiq_arm_init_state
      staging: vchiq_arm: Reduce indentation of service_callback
      staging: vchiq_core: Add hex prefix to debugfs output
      staging: vchiq_arm: Don't cast scatter-gather elements
      staging: vc04_services: Update testing instructions

Teddy Engel (7):
      staging: vt6656: Remove line from TODO
      staging: rtl8192e: Remove unused constants
      staging: rtl8192e: Remove unused struct phy_ofdm_rx_status_rxsc
      staging: rtl8192e: Capitalize constant RegC38_TH
      staging: rtl8192e: Remove unused macro dm_tx_bb_gain_idx_to_amplify
      staging: rtl8192e: Remove unnecessary pre-declaration of struct net_device
      staging: rtl8192e: Fix conflicting types error with net_device.

Tom Mounet (1):
      staging: nvec: Use x instead of x != NULL to improve readability.

Tree Davies (55):
      Staging: rtl8192e: Rename variable IsPassiveChannel
      Staging: rtl8192e: Rename variable CountryIeBuf
      Staging: rtl8192e: Rename variable CountryIeLen
      Staging: rtl8192e: Rename variable bWithAironetIE
      Staging: rtl8192e: Rename variable bContainHTC
      Staging: rtl8192e: Rename variable MBssid
      Staging: rtl8192e: Rename variable MBssidMask
      Staging: rtl8192e: Rename variable elementID
      Staging: rtl8192e: Rename variable rtllib_rx_Monitor
      Staging: rtl8192e: Rename variable rtllib_rx_InfraAdhoc
      Staging: rtl8192e: Rename variable IsLegacyDataFrame
      Staging: rtl8192e: Rename variable RxReorderIndicatePacket
      Staging: rtl8192e: Rename variable RfdArray
      Staging: rtl8192e: Rename variable Decrypted
      Staging: rtl8192e: Rename variable AddReorderEntry
      Staging: rtl8192e: Rename variable pList
      Staging: rtl8192e: Rename variable nPadding_Length
      Staging: rtl8192e: Rename variable LLCOffset
      Staging: rtl8192e: Remove variable ChkLength
      Staging: rtl8192e: Rename variable WinEnd
      Staging: rtl8192e: Rename variable WinSize
      Staging: rtl8192e: Rename variable IsDataFrame
      Staging: rtl8192e: Rename variable bMatchWinStart
      Staging: rtl8192e: Rename variable bMBssidValid
      Staging: rtl8192e: Rename variable bWithCcxVerNum
      Staging: rtl8192e: Rename variable Frame_QoSTID
      Staging: rtl8192e: Rename variable CcxRmState
      Staging: rtl8192e: Rename variable IsQoSDataFrame
      Staging: rtl8192e: Rename variable RfdCnt
      Staging: rtl8192e: Rename variable prxbIndicateArray
      Staging: rtl8192e: Rename variable bPktInBuf
      Staging: rtl8192e: Rename variable bHwSec
      Staging: rtl8192e: Rename variable bIsMulticast
      Staging: rtl8192e: Rename variable HTCurrentOperaRate
      Staging: rtl8192e: Rename variable HTOpMode
      Staging: rtl8192e: Rename variable bRTSEnable
      Staging: rtl8192e: Rename variable bRTSBW
      Staging: rtl8192e: Rename variable bCTSEnable
      Staging: rtl8192e: Rename variable bRTSUseShortGI
      Staging: rtl8192e: Rename variable bforced_tx20Mhz
      Staging: rtl8192e: Rename variable bPacketBW
      Staging: rtl8192e: Rename variable bBroadcast
      Staging: rtl8192e: Rename variable CntAfterLink
      Staging: rtl8192e: Rename variable bUseShortGI
      Staging: rtl8192e: Rename function TsStartAddBaProcess()
      Staging: rtl8192e: Fix alignment to match open parenthesis
      Staging: rtl8192e: Rename function rtllib_query_BandwidthMode
      Staging: rtl8192e: Rename function rtllib_query_ShortPreambleMode
      Staging: rtl8192e: Rename function rtllib_query_HTCapShortGI
      Staging: rtl8192e: Rename variable bUseShortPreamble
      Staging: rtl8192e: Rename variable bRTSSTBC
      Staging: rtl8192e: Remove parameter bIsAmsdu from rtllib_classify()
      Staging: rtl8192e: Remove variable IsAmsdu from rtllib_xmit_inter()
      Staging: rtl8192e: Fix alignment to match open parenthesis in rtllib_tx.c
      Staging: rtl8192e: Fix alignment to match open parenthesis in rtllib_rx.c

Umang Jain (2):
      staging: vchiq_core: Bubble up wait_event_interruptible() return value
      staging: vc04_services: vchiq_core: Stop kthreads on vchiq module unload

Wolfram Sang (1):
      staging: vc04_services: use 'time_left' variable with wait_for_completion_timeout()

Yang Li (1):
      staging: vc04_services: Fix kernel-doc param for vchiq_register_chrdev

 drivers/staging/fbtft/fbtft-core.c                 |   1 +
 drivers/staging/greybus/audio_manager.c            |   1 +
 drivers/staging/greybus/audio_topology.c           |   6 -
 drivers/staging/greybus/bootrom.c                  |   1 +
 drivers/staging/greybus/camera.c                   |   1 +
 drivers/staging/greybus/gbphy.c                    |   1 +
 drivers/staging/greybus/gpio.c                     |   1 +
 drivers/staging/greybus/hid.c                      |   1 +
 drivers/staging/greybus/i2c.c                      |   1 +
 drivers/staging/greybus/light.c                    |   1 +
 drivers/staging/greybus/log.c                      |   1 +
 drivers/staging/greybus/loopback.c                 |   1 +
 drivers/staging/greybus/power_supply.c             |   1 +
 drivers/staging/greybus/pwm.c                      |   1 +
 drivers/staging/greybus/raw.c                      |   1 +
 drivers/staging/greybus/sdio.c                     |   1 +
 drivers/staging/greybus/spi.c                      |   1 +
 drivers/staging/greybus/spilib.c                   |   1 +
 drivers/staging/greybus/uart.c                     |   1 +
 drivers/staging/greybus/usb.c                      |   1 +
 drivers/staging/greybus/vibrator.c                 |   1 +
 drivers/staging/nvec/nvec.c                        |  45 +-
 drivers/staging/rtl8192e/rtl8192e/r8190P_def.h     |   9 -
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c     |  21 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.h        |   1 +
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       |   6 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c         | 176 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h         |   6 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_pci.h        |   1 +
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c         |   2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c          |   4 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c          |  10 +-
 drivers/staging/rtl8192e/rtllib.h                  |  64 +-
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c       |   5 +-
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c       |  11 +-
 drivers/staging/rtl8192e/rtllib_crypt_wep.c        |   5 +-
 drivers/staging/rtl8192e/rtllib_module.c           |   1 +
 drivers/staging/rtl8192e/rtllib_rx.c               | 228 +++---
 drivers/staging/rtl8192e/rtllib_softmac.c          |   8 +-
 drivers/staging/rtl8192e/rtllib_tx.c               | 135 ++--
 drivers/staging/rtl8712/rtl8712_xmit.c             |   2 +-
 drivers/staging/rtl8712/rtl871x_event.h            |   2 +-
 drivers/staging/rtl8712/rtl871x_io.h               |   2 +-
 drivers/staging/rtl8712/rtl871x_mlme.c             |   2 +-
 drivers/staging/rtl8712/rtl871x_xmit.c             |  13 +-
 drivers/staging/rtl8712/rtl871x_xmit.h             |   1 -
 drivers/staging/rtl8712/usb_ops_linux.c            |   7 -
 drivers/staging/rtl8723bs/hal/Hal8723BReg.h        | 373 ---------
 drivers/staging/rtl8723bs/hal/HalHWImg8723B_BB.c   |  17 +-
 drivers/staging/rtl8723bs/hal/HalHWImg8723B_MAC.c  |  12 +-
 drivers/staging/rtl8723bs/hal/HalHWImg8723B_RF.c   |  12 +-
 drivers/staging/rtl8723bs/hal/odm.h                |   4 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c       |   4 +-
 drivers/staging/rtl8723bs/include/Hal8192CPhyReg.h | 882 +--------------------
 drivers/staging/rtl8723bs/include/HalPwrSeqCmd.h   |  11 -
 drivers/staging/rtl8723bs/include/drv_types.h      |   1 -
 drivers/staging/rtl8723bs/include/hal_com_h2c.h    |  76 --
 drivers/staging/rtl8723bs/include/hal_com_reg.h    | 792 ------------------
 .../staging/rtl8723bs/include/hal_phy_reg_8723b.h  |  69 --
 drivers/staging/rtl8723bs/include/hal_pwr_seq.h    |   7 -
 drivers/staging/rtl8723bs/include/rtl8723b_hal.h   |   2 +-
 drivers/staging/rtl8723bs/include/rtw_efuse.h      |  13 -
 drivers/staging/rtl8723bs/include/rtw_ht.h         |  22 -
 drivers/staging/rtl8723bs/include/rtw_io.h         |  57 --
 drivers/staging/rtl8723bs/include/rtw_mlme.h       | 182 -----
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h   |  37 -
 drivers/staging/rtl8723bs/include/rtw_mp.h         |  29 -
 drivers/staging/rtl8723bs/include/rtw_pwrctrl.h    |  38 -
 drivers/staging/rtl8723bs/include/rtw_recv.h       |  16 -
 drivers/staging/rtl8723bs/include/rtw_security.h   |   5 -
 drivers/staging/rtl8723bs/include/rtw_xmit.h       |  10 -
 drivers/staging/rtl8723bs/include/sdio_hal.h       |   4 -
 drivers/staging/rtl8723bs/include/sdio_osintf.h    |  16 -
 drivers/staging/rtl8723bs/include/sta_info.h       |  44 -
 drivers/staging/rtl8723bs/include/wifi.h           | 299 -------
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |  17 -
 .../vc04_services/bcm2835-camera/bcm2835-camera.c  |   8 +-
 drivers/staging/vc04_services/interface/TESTING    |  45 +-
 drivers/staging/vc04_services/interface/TODO       |   7 -
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  | 268 +++----
 .../vc04_services/interface/vchiq_arm/vchiq_arm.h  |   3 -
 .../vc04_services/interface/vchiq_arm/vchiq_core.c |  47 +-
 .../vc04_services/interface/vchiq_arm/vchiq_core.h |   6 -
 .../vc04_services/interface/vchiq_arm/vchiq_dev.c  |   2 +-
 .../staging/vc04_services/vchiq-mmal/mmal-vchiq.c  |   8 +-
 drivers/staging/vme_user/vme_user.c                |   1 +
 drivers/staging/vt6656/TODO                        |   1 -
 87 files changed, 617 insertions(+), 3623 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/include/hal_phy_reg_8723b.h
 delete mode 100644 drivers/staging/rtl8723bs/include/sdio_osintf.h

