Return-Path: <linux-kernel+bounces-403104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 300A79C310E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 07:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C04B1C20A73
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 06:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A6014600F;
	Sun, 10 Nov 2024 06:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C/4ozmBd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9C51482ED;
	Sun, 10 Nov 2024 06:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731220339; cv=none; b=A047GanIgvXLb7boNpI9oI55I5Z6+pxVMO+b4WzmkVMHbqjtnt/fJfrL63eALfJM7bQsLqUKg9L+jb4VjoLcGOMVLKGVl2x3Yw37pPUng2Df8/m9LrUAml/Kmy2sXXZrGW4HE1OMH6LRfXATmnPD5m5C0ZuaAx2ZjvtEgAidM1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731220339; c=relaxed/simple;
	bh=AjhYlj8tyARTa2RCiia+7OSmZ8Ese3c76HgmSnjHpxA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rPt2MrAhQPCMytEw9hP6RItYMFiC5mYhDZvbf5TXkmwAXShgJKZ3pKSZrfDl+5M+1XWR28R4t3EtsX5fscj6O0nuFe6o9cSojU0r5x2TMovVZXMNPkQjgns4b627Oo8P3X08s3oloK5w/h0sgDGSWGfleVFOmYDpg3iV47QoLKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C/4ozmBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6E0C4CECD;
	Sun, 10 Nov 2024 06:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731220339;
	bh=AjhYlj8tyARTa2RCiia+7OSmZ8Ese3c76HgmSnjHpxA=;
	h=Date:From:To:Cc:Subject:From;
	b=C/4ozmBd4UQQ0vsJq6vpV4rDLkKjDld95JAaJsj5iN21HzRxh9EvhvIfYbeOg4xP6
	 tJa977w0ocEnlH58e+F/fCyB5cTPKNY4ijGo8OzmXdDR/ufl5A3z1Vrl13SVRfQaaR
	 cMs1zd7hIf9W+EGtOTUdN4B9Ly1uxYa4RuP5zXI0=
Date: Sun, 10 Nov 2024 07:31:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 6.12-rc7
Message-ID: <ZzBTXpQKqugWe1vN@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 59b723cd2adbac2a34fc8e12c74ae26ae45bf230:

  Linux 6.12-rc6 (2024-11-03 14:05:52 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.12-rc7

for you to fetch changes up to 742afcc22d8eb5dcc67c1dc58ed249851e7cdbdf:

  Merge tag 'usb-serial-6.12-rc7' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus (2024-11-08 08:36:31 +0100)

----------------------------------------------------------------
USB/Thunderbolt fixes for 6.12-rc7

Here are some small remaining USB and Thunderbolt fixes and device ids
for 6.12-rc7.  Included in here are:
  - new USB serial driver device ids
  - thunderbolt driver fixes for reported problems
  - typec bugfixes
  - dwc3 driver fix
  - musb driver fix

All of these have been in linux-next this past week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Benoît Monin (1):
      USB: serial: option: add Quectel RG650V

Dan Carpenter (2):
      USB: serial: io_edgeport: fix use after free in debug printk
      usb: typec: fix potential out of bounds in ucsi_ccg_update_set_new_cam_cmd()

Greg Kroah-Hartman (2):
      Merge tag 'thunderbolt-for-v6.12-rc7' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-linus
      Merge tag 'usb-serial-6.12-rc7' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Jack Wu (1):
      USB: serial: qcserial: add support for Sierra Wireless EM86xx

Mika Westerberg (2):
      thunderbolt: Add only on-board retimers when !CONFIG_USB4_DEBUGFS_MARGINING
      thunderbolt: Fix connection issue with Pluggable UD-4VPD dock

Reinhard Speyerer (1):
      USB: serial: option: add Fibocom FG132 0x0112 composition

Rex Nie (1):
      usb: typec: qcom-pmic: init value of hdr_len/txbuf_len earlier

Roger Quadros (1):
      usb: dwc3: fix fault at system suspend if device was already runtime suspended

Zijun Hu (1):
      usb: musb: sunxi: Fix accessing an released usb phy

 drivers/thunderbolt/retimer.c                      |  2 ++
 drivers/thunderbolt/usb4.c                         |  2 +-
 drivers/usb/dwc3/core.c                            | 25 +++++++++++-----------
 drivers/usb/musb/sunxi.c                           |  2 --
 drivers/usb/serial/io_edgeport.c                   |  8 +++----
 drivers/usb/serial/option.c                        |  6 ++++++
 drivers/usb/serial/qcserial.c                      |  2 ++
 .../usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c    |  8 +++----
 drivers/usb/typec/ucsi/ucsi_ccg.c                  |  2 ++
 9 files changed, 33 insertions(+), 24 deletions(-)

