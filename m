Return-Path: <linux-kernel+bounces-260133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BE393A39F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477931F23BAB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3521B156F34;
	Tue, 23 Jul 2024 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="PyltflEA"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157C93D55D;
	Tue, 23 Jul 2024 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721747765; cv=none; b=qgwAesU4Pis4IXmMQ9DMigjMoXoDWKG+gb/ok2JUXhL6oaZFw/cDcHTvuRnvlRUgSx0vM0XMctf5DdDqzfYxBjqa0lrpCWFrk4//abr1g1UVnwguWiBmWJWT5aUKMDJrjiXNzkfllpAJzNxJ79aQnhDgpoJ12XGzhu0SW0e67vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721747765; c=relaxed/simple;
	bh=wcmAco8bkzi70O9n+d6uvvToZXg1RK9zjr+X5LzojVw=;
	h=From:To:Cc:Date:Message-Id:MIME-Version:Subject; b=mx/gmsH8dRbiXVSIVVEsfoTTldmhZKSLPJ0ya8x7yUbHEr2CXo/vCVMAHvc641yiqHj37Mqgagpxagj1hE/RfG5ItKun8lEUAl2yFrWl1JiJu5C4VwMLN635E4SbbDd5j8zpM9hqBTZwIfkczrf+JO2O3GyMiq4JJVgAs2Ae8Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=PyltflEA; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=Y2b2wyHe/Scg6YoHbNFbNDMijEkXHLcw9K/zw4LWlE0=; b=PyltflEAT72vIxHXC5uuoWyL6V
	ZBr6/u3LuZkePxDFimN8cxHr0giBdTAVa9m9N83C8PUR6EiFSE9TS5AUMPFwqx5jAGOMKMdQlqdKZ
	zknBIL07QMoikhnNlMShepd3HOfKKp3FxJ+pc75LVgfswC1GUhWmDxuZngI3iEFPBmas=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:36238 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1sWGwG-0003Y2-QS; Tue, 23 Jul 2024 10:56:29 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	hvilleneuve@dimonoff.com,
	jringle@gridpoint.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com
Date: Tue, 23 Jul 2024 08:52:59 -0400
Message-Id: <20240723125302.1305372-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
Subject: [PATCH 0/2] serial: sc16is7xx: fix registers accesses and Tx FIFO corruption
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hello,
this patch series fixes enhanced/special register set accesses and Tx
FIFO corruption.

I have tested the changes on a custom board with two SC16IS752 DUART over
a SPI interface using a Variscite IMX8MN NANO SOM. The four UARTs are
configured in RS-485 mode.

Thank you.

Hugo Villeneuve (2):
  serial: sc16is7xx: fix TX fifo corruption
  serial: sc16is7xx: fix invalid FIFO access with special register set

 drivers/tty/serial/sc16is7xx.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)


base-commit: 933069701c1b507825b514317d4edd5d3fd9d417
-- 
2.39.2


