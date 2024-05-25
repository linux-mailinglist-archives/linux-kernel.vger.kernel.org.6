Return-Path: <linux-kernel+bounces-189304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797F28CEE2F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 09:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99A56B21BE5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 07:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C54BFBF0;
	Sat, 25 May 2024 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I8l3VtoP"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A929C3C28
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 07:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716623548; cv=none; b=kuCQmcnGajcgyqmSAq8Bp5gW2nLtS2LGxTn8SEuNeWSnU1xEDTAWbc3qp9DB4teZ0Uz7shCmoFxMn/pnqlSrZEKT9ypq3Q4qO1MhuVNhz5BmeTKG8zowv/72ZRP+/eYCU8VnGv8y96uEdZSdcDiLRY6dmtiVz2VWBCJmzAPsKgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716623548; c=relaxed/simple;
	bh=NTE4aLUV/Me23bZw+dIv2vN6dOmlWJuGwpgYhYXpJxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CYu/wKCuqCM2s/3+4MneAbWTBzGWsFULu2dUQFKa3fyKrwJhcn0cft3QdvHtYibM6UmuBCmIjamBPosiF6Bcd/UVQaWc3hBTOh4LYHV5Sq/XKMOeNHu0MN4a+y3S+AdHSyFSBQCbBvE/3nQLP0IxEbUfSwxgJlvBU9Il7LH4pq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I8l3VtoP; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2D24C240005;
	Sat, 25 May 2024 07:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716623538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=hvYNI3hFtOWF93OT5lxSxIBWa6XcTcllEzru2wGd970=;
	b=I8l3VtoPj9ZtgN8UEtVxy1qJwEB7bIeRB418wizQS5AWI5SgCmTxUYtzVu9BuvOAEaOJxj
	oku/L1Y+pHzQgWxRgEffFFy6KuJ63AQxMhYDyOt3/C4MOyVzp4bx8xHbs4qCoxpvo2r9qW
	0kLPVgA/t8X5HL0Ua1qoY3ddd7M1vPmCyRiSFNcATJZvOnXWNn6xeXTWxBWrwU9tf1GfVH
	pn5bbpcMUqJYbBwXwjujMVzH974w7HfEn+UDSoOsRa8JQYgrm37y5jjKtg53jhcD1Vn2VN
	77gWLie5DidppbVv/6x7DXJqRzjaM1P7AyrFm7AkoWPd+nykZkVPq48bwU/OPw==
Date: Sat, 25 May 2024 09:52:17 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] I3C changes for 6.10
Message-ID: <20240525075217d90cc066@mail.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GND-Sasl: alexandre.belloni@bootlin.com

iHello Linus,

Here is the i3c subsytem pull request for 6.10. Runtime PM (power
management) is improved and hot-join support has been added to the dw
controller driver.

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.10

for you to fetch changes up to 1d08326020fba690cbb7b8f1b38ab4eab6745969:

  i3c: dw: Add hot-join support. (2024-05-23 00:29:19 +0200)

----------------------------------------------------------------
I3C for 6.10

Core:
 - Allow device driver to trigger controller runtime PM

Drivers:
 - dw: hot-join support
 - svc: better IBI handling

----------------------------------------------------------------
Billy Tsai (1):
      i3c: dw: Add hot-join support.

Frank Li (3):
      i3c: Add comment for -EAGAIN in i3c_device_do_priv_xfers()
      i3c: master: svc: change ENXIO to EAGAIN when IBI occurs during start frame
      i3c: master: svc: fix invalidate IBI type and miss call client IBI handler

Mukesh Kumar Savaliya (1):
      i3c: master: Enable runtime PM for master controller

 drivers/i3c/device.c                |  4 +++
 drivers/i3c/master.c                |  6 ++++
 drivers/i3c/master/dw-i3c-master.c  | 65 ++++++++++++++++++++++++++++++-------
 drivers/i3c/master/dw-i3c-master.h  |  2 ++
 drivers/i3c/master/svc-i3c-master.c | 18 +++++++---
 5 files changed, 79 insertions(+), 16 deletions(-)

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

