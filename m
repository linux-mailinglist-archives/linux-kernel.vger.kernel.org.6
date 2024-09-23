Return-Path: <linux-kernel+bounces-336345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 698699839DA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 923421F219EC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01F085C5E;
	Mon, 23 Sep 2024 22:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YWtiRgdM"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672148172D
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 22:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727130524; cv=none; b=Wtl/HzT7WW+CIEdgw1BDp7lnludfydqlDbT3BkSIUxQJX8EsRCwONzuXdobRx/49To+EnIhvP7W1G7qk7wBSzNLe5sQRWrZSJExeethkEAZ6mCWvFmPzLq4JH4vq7bAoBPN8Oa+zv+VSThli3IHFALGlAPDZz7D/wgNS99+e34M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727130524; c=relaxed/simple;
	bh=oXep8c6eQ7SzUtKlhMwRV+Snl52m1IhJqfC9jdkoe3I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nVbZc9K0zLYXx2P5PNFruEFLg6Y5iMe0HwVxt6WoxdUQ4lRSCg14CJy1j7Gv4ouB0j/gJIGirNyzvUnHjdMHXnO7AUPnKzjacZKDJXrkzcGf/x1Po/FnNimG8s6H8091B4AEwgPQ4F6gDygjQufGPSSIq6WU3j9Bp11eGTY17oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YWtiRgdM; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E0EC1BF203;
	Mon, 23 Sep 2024 22:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727130519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=6q4OUpNqHNINd6dQdsFhTzKMc3jCJy4Zxod9kfNrUZo=;
	b=YWtiRgdMfsWrdPVgh+EIrjP+8VBfXzOiaWvfvn9jjh2sjgkWb26SPACYDPoAkO9zDdda8z
	0mXepZNT3Q00jQa5KcOyXchPM/8so4FxvT9xSo2p7Sf1C+Uwf3FbhuK/L+nxkPXNw8bxW4
	9Xa5RR65ZFXBQdrQJyyRa7BSEd0wiVV3cRxQpXtLnc49IwvdA21+/6dPxldTPi/gYf4QsI
	H5Q4QEsK8o5UxubFonaYoJ2Og8n61kml1vBU0aqe0frT8cbmF81yDtKe6YCiAkD9HTw258
	dg0Y/jw+YIxWZH7vF8xTCp6rY5EUSOthjgRuR8ASCJtqsUn8GigjXAPCAjwxzA==
Date: Tue, 24 Sep 2024 00:28:39 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] I3C changes for 6.12
Message-ID: <20240923222839975a95a9@mail.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GND-Sasl: alexandre.belloni@bootlin.com

Hello Linus,

Here is the i3c subsystem pull request for 6.12. We get support for the
I3C HCI controller of the AMD SoC which as expected requires quirks. We
also have fixes for the other drivers, including rate selection fixes
for svc.

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.12

for you to fetch changes up to 61850725779709369c7e907ae8c7c75dc7cec4f3:

  i3c: master: svc: Fix use after free vulnerability in svc_i3c_master Driver Due to Race Condition (2024-09-17 16:51:45 +0200)

----------------------------------------------------------------
I3C for 6.12

Core:
 - allow adjusting first broadcast address speed

Drivers:
 - cdns: few fixes
 - mipi-i3c-hci: Add AMD SoC I3C controller support and quirks, fix get_i3c_mode
 - svc: adjust rates, fix race condition

----------------------------------------------------------------
Billy Tsai (1):
      i3c/master: cmd_v1: Fix the rule for getting i3c mode

Carlos Song (3):
      i3c: master: support to adjust first broadcast address speed
      i3c: master: svc: use slow speed for first broadcast address
      i3c: master: svc: adjust SDR according to i3c spec

Kaixin Wang (2):
      i3c: master: cdns: Fix use after free vulnerability in cdns_i3c_master Driver Due to Race Condition
      i3c: master: svc: Fix use after free vulnerability in svc_i3c_master Driver Due to Race Condition

Liao Chen (1):
      i3c: master: cdns: fix module autoloading

Shyam Sundar S K (6):
      i3c: mipi-i3c-hci: Add AMDI5017 ACPI ID to the I3C Support List
      i3c: mipi-i3c-hci: Read HC_CONTROL_PIO_MODE only after i3c hci v1.1
      i3c: mipi-i3c-hci: Add a quirk to set PIO mode
      i3c: mipi-i3c-hci: Relocate helper macros to HCI header file
      i3c: mipi-i3c-hci: Add a quirk to set timing parameters
      i3c: mipi-i3c-hci: Add a quirk to set Response buffer threshold

 drivers/i3c/master.c                         | 12 ++++
 drivers/i3c/master/i3c-master-cdns.c         |  2 +
 drivers/i3c/master/mipi-i3c-hci/Makefile     |  3 +-
 drivers/i3c/master/mipi-i3c-hci/cmd_v1.c     | 12 ++--
 drivers/i3c/master/mipi-i3c-hci/core.c       | 36 +++++++++---
 drivers/i3c/master/mipi-i3c-hci/hci.h        | 10 ++++
 drivers/i3c/master/mipi-i3c-hci/hci_quirks.c | 44 +++++++++++++++
 drivers/i3c/master/svc-i3c-master.c          | 84 +++++++++++++++++++++++++---
 include/linux/i3c/master.h                   | 16 ++++++
 9 files changed, 193 insertions(+), 26 deletions(-)
 create mode 100644 drivers/i3c/master/mipi-i3c-hci/hci_quirks.c

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

