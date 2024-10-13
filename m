Return-Path: <linux-kernel+bounces-362995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC2399BC4D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 23:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5839E1F222EF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 21:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAA3148827;
	Sun, 13 Oct 2024 21:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQ78OwrS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA8683CC7
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 21:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728855489; cv=none; b=GnJIpRunpburntOj0W4z0d/0j3tpeFMEBG6Hz1i9bvQUlsBuV72/AmiqEDcKV4tmXTKesOlePEnCRD5+jU2mdJ9X9Ud9hXm3yRj8gb4RRRIP3Lr6rsH436QGkdu/EBqVAxJbORLiyfpytUpM/Cc6iPbK9vbDY/CAocmBUV+W6Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728855489; c=relaxed/simple;
	bh=2DA3rk9n0GtiD0Tsqz64NhpGXZ1o3dDwLXGxKxz+E8Q=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=D4rzWNvQbKshfEV6HUDkYgHjQAyjLW9nyqlHtu9xBFOAaoFnmF8L0lIy04B9nRaRMJLQMSk/aJKHu9IiJQ2XJeIrWnCqnlLoJvx1zgL7TTP1EHAIKxg5DOdHNhV4GMOopN2u2N8QGKH/ZWLRMUc7RpOKMlEU8xxeQh7v9EuIHhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQ78OwrS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D410C4CECF;
	Sun, 13 Oct 2024 21:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728855489;
	bh=2DA3rk9n0GtiD0Tsqz64NhpGXZ1o3dDwLXGxKxz+E8Q=;
	h=Date:From:To:cc:Subject:From;
	b=gQ78OwrS7MtiebyTaxYsgnoha+TtOGZdLDygSZxvZhPXFfX1bzTS2Vz4Sh+gYYzx/
	 alavgF78NkuMYXs0f2VJROn56VtY5pZIbfTh55j8xwYZrDCTwhBLIj/L1YOKwtyDB1
	 Xy7knjA9PZBhwLbQq52jjbmMaCJXy1GvzJ07ZTbU/5B2Xyo5LkyfEzB5BydReTTjLv
	 1K8bU1t8dYc32S9x3DyorlsAtMsZNxSa1SW5iArMpuM6NzteKbK/YLNRxFki0s0A34
	 PPD7ZHn9lSTRN+xyM813B7rAe8IX3nEBy7GsZfEXvGnkG2BfZA3VqtxUok8OhKO5RK
	 wogtKsAjgxnow==
Date: Sun, 13 Oct 2024 23:38:06 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2410132332520.20286@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024101301

to receive HID subsystem fixes, namely:

=====
- fix for memory corruption regression in amd_sfh driver (Basavaraj 
  Natikar)
- fix for mis-reporting of BTN_TOOL_PEN and BTN_TOOL_RUBBER for AES 
  sensors tools in Wacom driver (Jason Gerecke) 
- fix for unitialized variable use in intel-ish-hid driver 
  (SurajSonawane2415)
- a few device-specific quirks / device ID additions
=====

Thanks.

----------------------------------------------------------------
Basavaraj Natikar (1):
      HID: amd_sfh: Switch to device-managed dmam_alloc_coherent()

Jason Gerecke (1):
      HID: wacom: Hardcode (non-inverted) AES pens as BTN_TOOL_PEN

Stefan Blum (1):
      HID: multitouch: Add support for B2402FVA track point

SurajSonawane2415 (1):
      hid: intel-ish-hid: Fix uninitialized variable 'rv' in ish_fw_xfer_direct_dma

Wade Wang (1):
      HID: plantronics: Workaround for an unexcepted opposite volume key

WangYuli (1):
      HID: multitouch: Add quirk for HONOR MagicBook Art 14 touchpad

 drivers/hid/amd-sfh-hid/amd_sfh_client.c    | 14 +++-----------
 drivers/hid/hid-ids.h                       |  2 ++
 drivers/hid/hid-multitouch.c                |  9 +++++++++
 drivers/hid/hid-plantronics.c               | 23 +++++++++++++++++++++++
 drivers/hid/intel-ish-hid/ishtp-fw-loader.c |  2 +-
 drivers/hid/wacom_wac.c                     |  2 ++
 6 files changed, 40 insertions(+), 12 deletions(-)

-- 
Jiri Kosina
SUSE Labs


