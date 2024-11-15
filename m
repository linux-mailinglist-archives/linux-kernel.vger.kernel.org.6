Return-Path: <linux-kernel+bounces-410771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBFC9CE0CE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8CAF1F20F8A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C151CDA19;
	Fri, 15 Nov 2024 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2Feadav"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ED21CD20F;
	Fri, 15 Nov 2024 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679186; cv=none; b=S2NDjm93tn+KJXaK94zqONVzmpMip4jdS+raWUdJskgTI2pNWJckLD/HegkS1RidLevS8wd1augv/rXva/kjITg3ZEPKZbSPUHTnWNRyT0LNhEKhcbpQVLMMr7NQ1TfmcPee5Ly9FregJ4KOl2yfKw0+LvRbGYDDzsDt+jQG410=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679186; c=relaxed/simple;
	bh=PSfsjIXrqm6BSGG68frO5ZsOFBb9yWeIaF0QJ1XDYLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sRei337vy6UEGl7Gvy83SDhvLx7PEZg2hcLVKCJdN4A5pEswzPEmqW4/BECWpFgRNBiNkUfYPioAmzclSFPVRJof7Jnakvzuf3TQZHS4HJu4NMuK3BzwCqtQEsU9HSlhIJ2ZhLzJT/rAO6F1JOlmkzH0TJl/KjoUArC3wwjQhm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2Feadav; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAE4C4CECF;
	Fri, 15 Nov 2024 13:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731679186;
	bh=PSfsjIXrqm6BSGG68frO5ZsOFBb9yWeIaF0QJ1XDYLQ=;
	h=Date:From:To:Cc:Subject:From;
	b=F2FeadavcKqIauy+ZIJj+LYyecKj41wVfymZ0bA9zSGrjgOJjCNMzxTI0G91s+PJu
	 ZunKnxGVklhIvsY7pBomeOxB/uq+vFzbfEOFgXd93TDfpMUwy6SkSMKxIzB+r72Xdl
	 mcxwYqJQLKvHrRmhNAg3raQi/0Rk60YlAGqCHE1c4UG5MRNAtbppE7uVIGNrz6jEpk
	 VhcIElSiXEpLhz4qGW9/ph+KVq34Y2AV1Ds1/JWeB998hFJpWeFCC7SPnSIhmJMzbR
	 rMLnm/mC+yuezmdr0DMr+YNDQzTxHyZTwde7DAXWMXSpWED7HQGbqEwrbHAT6SuVKC
	 OdbOtu7SO9ONg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tBwrJ-0000000009b-3V5B;
	Fri, 15 Nov 2024 14:59:37 +0100
Date: Fri, 15 Nov 2024 14:59:37 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial updates for 6.13-rc1
Message-ID: <ZzdTyegI_dodavrc@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 59b723cd2adbac2a34fc8e12c74ae26ae45bf230:

  Linux 6.12-rc6 (2024-11-03 14:05:52 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.13-rc1

for you to fetch changes up to 8b524944f92ccad925b574f645e9c2709cf60d1e:

  USB: serial: ftdi_sio: Fix atomicity violation in get_serial_info() (2024-11-07 17:21:10 +0100)

----------------------------------------------------------------
USB-serial updates for 6.13-rc1

Here are the USB-serial updates for 6.13-rc1, including:

 - improved support for quirky pl2303 hxd devices
 - make sure ftdi_sio TIOCGSERIAL returns consistent data

Everything has been in linux-next with no reported issues.

----------------------------------------------------------------
Jan Kiszka (1):
      USB: serial: pl2303: account for deficits of clones

Qiu-ji Chen (1):
      USB: serial: ftdi_sio: Fix atomicity violation in get_serial_info()

 drivers/usb/serial/ftdi_sio.c |  2 ++
 drivers/usb/serial/pl2303.c   | 38 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

