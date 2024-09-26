Return-Path: <linux-kernel+bounces-340311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEB498716E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4E41C237E8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E23D1AF4DE;
	Thu, 26 Sep 2024 10:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vJKuX63K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6781AD5C0;
	Thu, 26 Sep 2024 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727346202; cv=none; b=sgA6DIonL6/AS/HkpCBko+MsxMtBkk6KJ9xcYBKSGYUJ4yPFL0A7Anr3nGa6UlzqVQxHuc5JVzoJ0hSlOWUB1P7A4WzajFIUrHK34TMdYrZ+mPGYOw2w6B/V7LrTWL+EuBZphqPNwAapiuwRkuV113PKuHhYsDxiThOgP2SL0ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727346202; c=relaxed/simple;
	bh=D4jvDGF6ZnWn8iTNny5C7zUKc73rcsyPXTCQOPVqwFY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tEwe+k0jD8KK+1mkD3i+4SbxNQQsBbBWZk/WIqsSzMR1Tpc88EhTTOAc1htz7m1J7clB9QlJr1cgQbsSp2klsRcMJ8GFlTVUdezbfNxjX1xnCLkFAcJRvIqX7GCHXKTwnaaJ/jGGGciKmMdZpDjPcFXint8gCkLCngTI5rMp8o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vJKuX63K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1795FC4CEC5;
	Thu, 26 Sep 2024 10:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727346201;
	bh=D4jvDGF6ZnWn8iTNny5C7zUKc73rcsyPXTCQOPVqwFY=;
	h=Date:From:To:Cc:Subject:From;
	b=vJKuX63K7Tims9eA5p9IXPyGG3WgzoeKqodGhSGxKZjyvY9tEMfQaWZnMingBO/pP
	 zszDF7EVSCH1/niNqHFB1pebSMi6t+vLSCUeebBVKqM9LB/GYKPaGRyN7NthYpVg9Z
	 FHeVsCUi4E8BwWjD1QVxzcP1OBwcOOtmDmOUN6QQ=
Date: Thu, 26 Sep 2024 12:23:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver updates for 6.12-rc1
Message-ID: <ZvU2EO4wb7RCUSSW@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.12-rc1

for you to fetch changes up to b4fdf9b1cd8b21a6569290a06b2a7df0eb071d6e:

  staging: vt6655: Rename variable apTD1Rings (2024-09-13 07:32:50 +0200)

----------------------------------------------------------------
Staging driver updates for 6.12-rc1

Here is the big set of staging driver cleanups and removals for
6.12-rc1.

Nothing exciting here, just slow, constant, forward progress in removing
code and cleaning up some old drivers, along with removing one of them
that was not being used anymore at all.  In discussions with some
developers this past week, even more deletions will be happening for the
next major merge window, as we seems to have code here that obviously no
one is using anymore.

Along with the normal cleanups is the good vme_user code forward
progress, the one major bright spot in the staging subsystem for code
that people rely on, and is getting good development behind it.
Hopefully it can graduate out of staging "soon".

All of these changes have been in linux-next for a long time with no
reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Agathe Porte (1):
      staging: vme_user: vme_irq_handler: name func ptr args

Alien Wesley (4):
      staging: rtl8192e: Fix blank line
      staging: rtl8192e: Fix Assignment operator '=' in rtl_dm.c:1488
      staging: rtl8192e: Fix multiple assignments in rtl_wx.c
      staging: rtl8192e: Fix Assignment operator '=' in rtl_wx.c

Ana Carolina Hernandes (1):
      Staging: rtl8192e: Fix arguments alignment

Benjamin Somers (1):
      staging: rtl8723bs: Fix spacing issues

Christian S Lima (1):
      staging: rtl8192e: fix parenthesis alignment

Colin Ian King (2):
      staging: rtl8723bs: make read-only array dot11_rate_table static const
      staging: rtl8723bs: Remove trailing space after \n newline

David Prévot (1):
      staging: rtl8192e: style fix - alignment to match parenthesis

Dominik Karol Piątkowski (4):
      staging: vt6655: Fix alignment to open parentheses
      staging: vt6655: Update maintainer in TODO
      staging: vt6655: Fix block comment alignment
      staging: vt6655: mac.h: Fix possible precedence issue in macros

Dorine Tipo (1):
      staging: rtl8712: Align parenthesis in usb_ops_linux.c

Emmanuel Arias (1):
      staging: rtl8723bs: replace indent space for tabs

Felix Yan (1):
      staging: rtl8712: remove trailing whitespace

Gabriel Maciel Raad (2):
      Staging: rtl8192e: Fix parenthesis alignment
      Staging: rtl8192e: Remove unnecessary blank line

Gabriel Tassinari (1):
      staging: rtl8192e: Fix parenthesis alignment in rtl_core.c

Griffin Kroah-Hartman (3):
      staging: vme_user: vme_tsi148.c: remove redundant newlines
      staging: vme_user: vme_tsi148.C: remove redundant newlines
      staging: vme_user: vme_tsi148.c: Change Formatting

Guilherme Puida Moreira (1):
      staging: rtl8723bs: place opening brace on previous line

Guillaume Lefèvre-Crimé (1):
      staging: rtl8723bs: add spaces arround operators

Hans Buss (1):
      staging: rtl8192e: Insert spaces around '|'

Jinjie Ruan (1):
      staging: nvec: Use IRQF_NO_AUTOEN flag in request_irq()

Jiwon Kim (1):
      staging: rtl8723bs: Delete unnecessary braces for single statement blocks in xmit_linux.c

Johan Hovold (1):
      Revert "staging: greybus: Fix capitalization and punctuation inconsistencies"

João Pedro Leôncio (1):
      staging: rtl8192e: Fix line ended with '('

Kartik Kulkarni (1):
      staging: rtl8723bs: remove space after pointer

Leonardo Kenji (1):
      staging: rtl8192e: Fix parenthesis alignment

Manisha Singh (2):
      staging: rtl8712: Fix style issues in rtl871x_io.c
      staging: rtl8712: Calculate size from pointer

Manjae Cho (1):
      staging: rtl8723bs: Improve clarity of MAR usage

Michael Straube (6):
      staging: rtl8192e: remove duplicate macros from rtllib.h
      staging: rtl8192e: remove RF90_PATH_{C,D} from enum rf90_radio_path
      staging: rtl8192e: adjust size of rx_pwr for new RF90_PATH_MAX
      staging: rtl8192e: adjust size of trsw_gain_X for new RF90_PATH_MAX
      staging: rtl8192e: adjust size of brfpath_rxenable for new RF90_PATH_MAX
      staging: rtl8192e: adjust size of RxMIMOSignalStrength

Moon Yeounsu (1):
      staging: rtl8712: style fix multiple line dereference

Pedro Orlando (1):
      staging: rtl8192e: Fix parenthesis alignment

Peter Robinson (1):
      staging: rtl8723bs: drop unnessary dep on CFG80211_WEXT

Philipp Hortmann (12):
      staging: ks7010: Remove unused driver
      staging: rtl8723bs: Remove unused function RTW_DISABLE_FUNC
      staging: rtl8723bs: Remove unused function rxmem_to_recvframe
      staging: rtl8723bs: Remove unused function rtw_hal_get_odm_var
      staging: rtl8723bs: Remove unused function rf_reg_dump
      staging: rtl8723bs: Remove unused function dump_4_rf_regs
      staging: rtl8723bs: Remove unused function bb_reg_dump
      staging: rtl8723bs: Remove unused function mac_reg_dump
      staging: rtl8723bs: Remove unused function dump_4_regs
      staging: rtl8723bs: Remove unused files rtw_debug.c and rtw_debug.h
      staging: rtl8723bs: Remove unused function rtw_ch2freq
      staging: rtl8723bs: Remove unused file rtw_rf.c

Ping-Ke Shih (4):
      staging: rtl8712: remove unused drvinfo_sz from update_recvframe_attrib
      staging: rtl8723bs: remove unused efuseValue from efuse_OneByteWrite()
      staging: rtl8723bs: remove unused cnt from recv_func()
      staging: rtl8723bs: remove unused 'poll_cnt' from rtw_set_rpwm()

Qianqiang Liu (1):
      staging: rtl8723bs: Remove an unused struct in rtw_cmd.h

Riyan Dhiman (6):
      staging: fbtft: Remove ftrace-like logging
      staging: fbtft: Fix mutex and spinlock without comment warning
      staging: vme_user: vme.h: alignment of closing parenthesis should match open parenthesis in function declaration
      staging: vme_user: added bound check to geoid
      staging: rtl8192e: Constify struct pci_device_id
      staging: vme_user: changed geoid data type from int to u32

Roshan Khatri (6):
      staging: rtl8723bs: include: Fix spelling mistake in rtl8723b_hal.h
      staging: rtl8723bs: include: Fix spelling mistake in rtw_event.h
      staging: rtl8723bs: include: Fix spelling mistake in rtw_xmit.h
      staging: rtl8723bs: include: Fix spelling mistake in rtw_io.h
      staging: rtl8723bs: include: Fix spelling mistake in rtw_mlme.h
      staging: rtl8723bs: core: Fix spelling mistake in rtw_xmit.c

Sai Sree Kartheek Adivi (1):
      staging: rtl8723bs: style fix open brace on new line

Santiago Ruano Rincón (1):
      staging: rtl8723bs: rtw_mlme_ext: replace spaces by tabs

Sayyad Abid (8):
      staging: rtl8723bs: include: Fix open brace position in rtw_security.h
      staging: rtl8723bs: include: Fix indent for switch case in rtw_security.h
      staging: rtl8723bs: include: Fix indent for switch block in rtw_security.h
      staging: rtl8723bs: include: Fix use of tabs for indent in rtw_security.h
      staging: rtl8723bs: include: Fix indent for struct _byte_ in rtw_security.h
      staging: rtl8723bs: include: Fix indent for else block struct in rtw_security.h
      staging: rtl8723bs: include: Fix trailing */ position in rtw_security.h
      staging: rtl8723bs: include: Remove spaces before tabs in rtw_security.h

Simon Horman (2):
      staging: rtl8192e: remove set but otherwise unused local variable iv32
      staging: rtl8192e: remove set but otherwise unused local variable iv16

Steven Davis (3):
      staging: most: video: Fixed minor capitalization and grammatical issues
      staging: nvec: Capitalize outputs to match the rest of the driver
      staging: greybus: Fix capitalization and punctuation inconsistencies

Tchadel Icard (1):
      staging: rtl8712: Fix move '{' to previous line

Thais-ra (1):
      greybus: camera-gb: Fix a alignment bug on gb_camera_ops()

Thomas Zimmermann (2):
      staging: fbtft: Use backlight power constants
      staging: olpc_dcon: Use backlight power constants

Tree Davies (32):
      Staging: rtl8192e: Rename variable nSubframe_Length
      Staging: rtl8192e: Rename variable CmdID_End
      Staging: rtl8192e: Rename variable CmdID_SetTxPowerLevel
      Staging: rtl8192e: Rename variable CmdID_BBRegWrite10
      Staging: rtl8192e: Rename variable CmdID_WritePortUlong
      Staging: rtl8192e: Rename variable CmdID_WritePortUshort
      Staging: rtl8192e: Rename variable CmdID_WritePortUchar
      Staging: rtl8192e: Rename variable CurPsLevel
      Staging: rtl8192e: Rename variable bLastIniPkt
      Staging: rtl8192e: Rename variable CmdID_RF_WriteReg
      Staging: rtl8192e: Rename variable CmdID
      Staging: rtl8192e: Rename variable msDelay
      Staging: rtl8192e: Rename variable bCmdOrInit
      Staging: rtl8192e: Rename variable pNetwork
      Staging: rtl8192e: Rename variable bHwError
      Staging: rtl8192e: Add spaces around operators.
      Staging: rtl8192e: Rename variable pReorderEntry
      Staging: rtl8192e: Rename variable SeqNum
      Staging: rtl8192e: Rename variable SignalStrength
      Staging: rtl8192e: Rename variable pFrame
      Staging: rtl8192e: Rename variable bPacketToSelf
      Staging: rtl8192e: Rename variable Para1
      Staging: rtl8192e: Rename variable Para2
      Staging: rtl8192e: Rename variable ScanOperationBackupHandler
      Staging: rtl8192e: Rename variable Operation
      Staging: rtl8192e: Rename variable bAssoc
      Staging: rtl8192e: Rename variable SignalQuality
      Staging: rtl8192e: Rename variable isEncrypt
      Staging: rtl8192e: Rename variable nStuckCount
      Staging: rtl8192e: Rename variable bAddNewTs
      Staging: rtl8192e: Rename variable RxBufShift
      Staging: rtl8192e: Rename variable RxDrvInfoSize

Túlio Fernandes (1):
      staging: rtl8192e: Fix parenthesis alignment

Umang Jain (7):
      staging: vchiq: Factor out bulk transfer for VCHIQ_BULK_MODE_WAITING
      staging: vchiq_core: Simplify vchiq_bulk_transfer()
      staging: vchiq_core: Factor out bulk transfer for blocking mode
      staging: vchiq_core: Factor out bulk transfer for (no/)callback mode
      staging: vchiq_core: Drop vchiq_bulk_transfer()
      staging: vchiq_core: Remove unused function argument
      staging: vchiq_core: Pass enumerated flag instead of int

Vinicius Peixoto (2):
      staging: rtl8192e: insert blank line after function declaration
      staging: rtl8192e: Fix parenthesis alignment

Xingquan Liu (2):
      staging: vt6655: Rename variable apTD0Rings
      staging: vt6655: Rename variable apTD1Rings

Yang Yingliang (1):
      staging: greybus: spi: switch to use spi_alloc_host()

Yuesong Li (1):
      staging: vme: vme_user: Remove NULL check of list_entry()

thdecamargoj (1):
      staging: rtl8192e: change logical continuation to previous line on file r8192E_dev.c

vivek t s (1):
      Staging: rtl8723bs: Rename function SelectChannel()

 drivers/staging/Kconfig                            |    2 -
 drivers/staging/Makefile                           |    1 -
 drivers/staging/fbtft/fb_ili9320.c                 |    2 -
 drivers/staging/fbtft/fb_ra8875.c                  |    7 -
 drivers/staging/fbtft/fb_sh1106.c                  |    3 -
 drivers/staging/fbtft/fb_ssd1289.c                 |    3 -
 drivers/staging/fbtft/fb_ssd1306.c                 |    3 -
 drivers/staging/fbtft/fb_ssd1325.c                 |    9 -
 drivers/staging/fbtft/fb_ssd1331.c                 |    2 -
 drivers/staging/fbtft/fb_ssd1351.c                 |    5 +-
 drivers/staging/fbtft/fb_uc1611.c                  |    3 -
 drivers/staging/fbtft/fbtft-bus.c                  |    9 -
 drivers/staging/fbtft/fbtft-core.c                 |   13 +-
 drivers/staging/fbtft/fbtft-sysfs.c                |    4 -
 drivers/staging/fbtft/fbtft.h                      |    2 +
 drivers/staging/greybus/gb-camera.h                |    4 +-
 drivers/staging/greybus/spilib.c                   |    6 +-
 drivers/staging/ks7010/Kconfig                     |   14 -
 drivers/staging/ks7010/Makefile                    |    4 -
 drivers/staging/ks7010/TODO                        |   36 -
 drivers/staging/ks7010/eap_packet.h                |   70 -
 drivers/staging/ks7010/ks7010_sdio.c               | 1143 ---------
 drivers/staging/ks7010/ks_hostif.c                 | 2312 -----------------
 drivers/staging/ks7010/ks_hostif.h                 |  617 -----
 drivers/staging/ks7010/ks_wlan.h                   |  567 -----
 drivers/staging/ks7010/ks_wlan_ioctl.h             |   61 -
 drivers/staging/ks7010/ks_wlan_net.c               | 2676 --------------------
 .../iterator/iterator_1.0/ia_css_iterator.host.c   |    3 +-
 drivers/staging/most/video/video.c                 |    6 +-
 drivers/staging/nvec/nvec.c                        |   17 +-
 drivers/staging/olpc_dcon/olpc_dcon.c              |    2 +-
 drivers/staging/rtl8192e/rtl8192e/r8190P_def.h     |    5 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c  |   10 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c     |   89 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h      |    2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c     |   67 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h     |    6 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       |   20 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h       |    2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c         |    3 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c         |    3 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c         |   15 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c          |   40 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c          |   30 +-
 drivers/staging/rtl8192e/rtllib.h                  |  141 +-
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c       |    6 -
 drivers/staging/rtl8192e/rtllib_rx.c               |  140 +-
 drivers/staging/rtl8192e/rtllib_softmac_wx.c       |    4 +-
 drivers/staging/rtl8712/rtl8712_recv.c             |    4 -
 drivers/staging/rtl8712/rtl871x_cmd.c              |    5 +-
 drivers/staging/rtl8712/rtl871x_cmd.h              |    2 +-
 drivers/staging/rtl8712/rtl871x_io.c               |    4 +-
 drivers/staging/rtl8712/usb_ops_linux.c            |    2 +-
 drivers/staging/rtl8723bs/Kconfig                  |    1 -
 drivers/staging/rtl8723bs/Makefile                 |    2 -
 drivers/staging/rtl8723bs/core/rtw_ap.c            |    5 +-
 drivers/staging/rtl8723bs/core/rtw_btcoex.c        |    1 -
 drivers/staging/rtl8723bs/core/rtw_cmd.c           |    4 -
 drivers/staging/rtl8723bs/core/rtw_debug.c         |   68 -
 drivers/staging/rtl8723bs/core/rtw_efuse.c         |   60 +-
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c     |    5 +-
 drivers/staging/rtl8723bs/core/rtw_io.c            |    1 -
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c     |    1 -
 drivers/staging/rtl8723bs/core/rtw_mlme.c          |    1 -
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c      |    7 +-
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c       |    3 -
 drivers/staging/rtl8723bs/core/rtw_recv.c          |    6 +-
 drivers/staging/rtl8723bs/core/rtw_rf.c            |   34 -
 drivers/staging/rtl8723bs/core/rtw_security.c      |    1 -
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c       |    1 -
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c     |    3 +-
 drivers/staging/rtl8723bs/core/rtw_xmit.c          |    3 +-
 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c     |    1 -
 drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c       |    1 -
 drivers/staging/rtl8723bs/hal/hal_btcoex.c         |    1 -
 drivers/staging/rtl8723bs/hal/hal_com.c            |    1 -
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c     |    1 -
 drivers/staging/rtl8723bs/hal/hal_intf.c           |    7 -
 drivers/staging/rtl8723bs/hal/hal_sdio.c           |    1 -
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c       |    1 -
 drivers/staging/rtl8723bs/hal/rtl8723b_dm.c        |    1 -
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c  |    1 -
 drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c    |    1 -
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c     |    1 -
 drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c     |    1 -
 drivers/staging/rtl8723bs/hal/sdio_halinit.c       |    5 +-
 drivers/staging/rtl8723bs/hal/sdio_ops.c           |    1 -
 drivers/staging/rtl8723bs/include/drv_types.h      |    7 -
 drivers/staging/rtl8723bs/include/hal_intf.h       |    1 -
 drivers/staging/rtl8723bs/include/hal_pwr_seq.h    |    2 +-
 drivers/staging/rtl8723bs/include/osdep_service.h  |    4 +-
 .../rtl8723bs/include/osdep_service_linux.h        |   68 +-
 drivers/staging/rtl8723bs/include/rtl8723b_hal.h   |    2 +-
 drivers/staging/rtl8723bs/include/rtw_cmd.h        |    4 -
 drivers/staging/rtl8723bs/include/rtw_debug.h      |   14 -
 drivers/staging/rtl8723bs/include/rtw_event.h      |    2 +-
 drivers/staging/rtl8723bs/include/rtw_io.h         |    2 +-
 drivers/staging/rtl8723bs/include/rtw_mlme.h       |    2 +-
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h   |    6 +-
 drivers/staging/rtl8723bs/include/rtw_recv.h       |   10 -
 drivers/staging/rtl8723bs/include/rtw_rf.h         |    2 -
 drivers/staging/rtl8723bs/include/rtw_security.h   |  127 +-
 drivers/staging/rtl8723bs/include/rtw_xmit.h       |    2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |    1 -
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c     |    1 -
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c      |    1 -
 drivers/staging/rtl8723bs/os_dep/os_intfs.c        |    1 -
 drivers/staging/rtl8723bs/os_dep/osdep_service.c   |    1 -
 drivers/staging/rtl8723bs/os_dep/recv_linux.c      |    1 -
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c       |    1 -
 drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c  |    1 -
 drivers/staging/rtl8723bs/os_dep/wifi_regd.c       |    1 -
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c      |    4 +-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |   20 +-
 .../vc04_services/interface/vchiq_arm/vchiq_core.c |  343 ++-
 .../vc04_services/interface/vchiq_arm/vchiq_core.h |   16 +-
 .../vc04_services/interface/vchiq_arm/vchiq_dev.c  |   15 +-
 drivers/staging/vme_user/vme.c                     |   10 +-
 drivers/staging/vme_user/vme.h                     |   17 +-
 drivers/staging/vme_user/vme_fake.c                |   10 +-
 drivers/staging/vme_user/vme_tsi148.c              |  155 +-
 drivers/staging/vt6655/TODO                        |    2 +-
 drivers/staging/vt6655/card.c                      |   12 +-
 drivers/staging/vt6655/card.h                      |    4 +-
 drivers/staging/vt6655/device.h                    |   12 +-
 drivers/staging/vt6655/device_main.c               |   34 +-
 drivers/staging/vt6655/mac.h                       |    4 +-
 drivers/staging/vt6655/rxtx.c                      |   14 +-
 128 files changed, 835 insertions(+), 8539 deletions(-)
 delete mode 100644 drivers/staging/ks7010/Kconfig
 delete mode 100644 drivers/staging/ks7010/Makefile
 delete mode 100644 drivers/staging/ks7010/TODO
 delete mode 100644 drivers/staging/ks7010/eap_packet.h
 delete mode 100644 drivers/staging/ks7010/ks7010_sdio.c
 delete mode 100644 drivers/staging/ks7010/ks_hostif.c
 delete mode 100644 drivers/staging/ks7010/ks_hostif.h
 delete mode 100644 drivers/staging/ks7010/ks_wlan.h
 delete mode 100644 drivers/staging/ks7010/ks_wlan_ioctl.h
 delete mode 100644 drivers/staging/ks7010/ks_wlan_net.c
 delete mode 100644 drivers/staging/rtl8723bs/core/rtw_debug.c
 delete mode 100644 drivers/staging/rtl8723bs/core/rtw_rf.c
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_debug.h

