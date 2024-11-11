Return-Path: <linux-kernel+bounces-404187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7EA9C4067
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B3B282292
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3621A0716;
	Mon, 11 Nov 2024 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="c/edJvfM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="p5hlPuYP"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE4C19EED6
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334296; cv=none; b=Zz0JgHHoL3O6J+6OGW8PYKRY299SyEYTmazOVU3gxKuKwq6BI2UPYibyWFk9Iu1UQLZPBFKLrQQcVnA2/V9Ngelu4H7yVHsRdSJP2Ny1jkgja3Pw3cZgCfsswBUZlWM3qPSUWlnTvuLNEDI3a7OHqdL7WlA1di4uq8yXrtUySz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334296; c=relaxed/simple;
	bh=8pb4UR4/zwLbkpEYgyhu1nBJvL4J6fIO1wRkKUpzm4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1k3/wB8otWnQCANPMsCUqsIi52KAqiY/IqFsuI3UJeWh2t3m521Qb5DnAqIB1Xk96zSqixUew/nOFM5AcLRZYZjb1KvVdqILDAkhP8KuqqIxAbM4yGMqUfjOSopAaqCDE+tQpk25cnOGJVF2+2i/yTGD1j0nAlepSV2T1jeqP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=c/edJvfM; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=p5hlPuYP reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1731334294; x=1762870294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WR1WQ/cnkQsXrWWXZYmpm17RJl4u8k3dN8N9efKquJU=;
  b=c/edJvfMXsRmL76q5qUz5W2Ljsdmnd/uwVuH+C4Xqt2AfCkkQuXJl4jF
   hUzUg1PpCs73nIxiRfQEQqHVfigTJs9GeP4/YQ3ZQDVpVDeMD5dFKYE/p
   +WcM8qxf/NYjaZxtkBCIPm6nCI81UZYNavvAFOkR0EGz21Al+s9leVM+/
   a3xlOWtxXqRMEVeRVXB/Vg65zG/xLwYe7aTH8BT/I7l+s7ZnOTI8rnMYw
   1jgbEMvxDZPQwAev+EszjMXvoV2e6XgPRnJ5VK2gZZ7D3VUMffcv+ODWw
   0DkUCJ8ow6+HfhxubxYdbl1FvESbw90qZReq1JyDHySYKRJXMviyMsHSn
   Q==;
X-CSE-ConnectionGUID: UAqgTLXhQuyKpxnEyE9YAg==
X-CSE-MsgGUID: Go7VMIUVRru87jnOUl2ypQ==
X-IronPort-AV: E=Sophos;i="6.12,145,1728943200"; 
   d="scan'208";a="39967039"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 11 Nov 2024 15:11:33 +0100
X-CheckPoint: {67321095-1A-F5DC7025-F79421CB}
X-MAIL-CPID: 743DB381725107AB55C2ACF803FC5396_0
X-Control-Analysis: str=0001.0A682F16.67321095.00AE,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 27920166E07;
	Mon, 11 Nov 2024 15:11:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1731334289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WR1WQ/cnkQsXrWWXZYmpm17RJl4u8k3dN8N9efKquJU=;
	b=p5hlPuYPYKgqS6vlz/bWFZHZ9u2fBSMbwttKWgCcNUKnaqm2lToUTUaWpCMk0Kb6Owpvs4
	lPt7P1bruvtm3y3p+U+5kZ7Ha8jZTxFYd+e4F9TR3U+uLHwVc500b9wUsVnjDDxSLMbuEv
	cRodO35YdYPKkeOU/muI7FyDyWjfvc2ehBdh1D6hLCGhpDWq+t9zVR0/IPnhHXnJjydWfB
	qWkGMfhbkF/kZZqglmnm6ePeqlATumIqyQeWr00eIn45VRqkrJV6wovwgyylkMAyzFrsHZ
	QQxEvbvWOeNJHbbgTjXqFTmoa07yuL1mfcccL5YbX+aNDllafjfWIhgcxSjFNw==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v7 4/5] mfd: tqmx86: make IRQ setup errors non-fatal
Date: Mon, 11 Nov 2024 15:10:31 +0100
Message-ID: <2b5522362098d54c6203be6da95bbc545a21fd49.1731325758.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731325758.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1731325758.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

GPIO IRQ setup can fail either because an invalid IRQ was passed as a
parameter, or because the GPIO controller does not support interrupts.
Neither is severe enough to stop the whole probe; simply disable IRQ
support in the GPIO resource when setup fails.

The code is made a bit more robust by introduing an enum for the
resource list indices instead of assuming that the IRQ is at index 0.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/mfd/tqmx86.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index 8aa448a67c9a5..d2704526f9d4b 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -68,13 +68,15 @@ static const struct resource tqmx_watchdog_resources[] = {
 	DEFINE_RES_IO(TQMX86_IOBASE_WATCHDOG, TQMX86_IOSIZE_WATCHDOG),
 };
 
-/*
- * The IRQ resource must be first, since it is updated with the
- * configured IRQ in the probe function.
- */
+enum tqmx86_gpio_resource_type {
+	TQMX86_GPIO_IO,
+	TQMX86_GPIO_IRQ,
+};
+
 static struct resource tqmx_gpio_resources[] = {
-	DEFINE_RES_IRQ(0),
-	DEFINE_RES_IO(TQMX86_IOBASE_GPIO, TQMX86_IOSIZE_GPIO),
+	[TQMX86_GPIO_IO] = DEFINE_RES_IO(TQMX86_IOBASE_GPIO, TQMX86_IOSIZE_GPIO),
+	/* Placeholder for IRQ resource */
+	[TQMX86_GPIO_IRQ] = {},
 };
 
 static struct i2c_board_info tqmx86_i2c_devices[] = {
@@ -255,13 +257,8 @@ static int tqmx86_probe(struct platform_device *pdev)
 	if (gpio_irq) {
 		err = tqmx86_setup_irq(dev, "GPIO", gpio_irq, io_base,
 				       TQMX86_REG_IO_EXT_INT_GPIO_SHIFT);
-		if (err)
-			return err;
-
-		/* Assumes the IRQ resource is first. */
-		tqmx_gpio_resources[0].start = gpio_irq;
-	} else {
-		tqmx_gpio_resources[0].flags = 0;
+		if (!err)
+			tqmx_gpio_resources[TQMX86_GPIO_IRQ] = DEFINE_RES_IRQ(gpio_irq);
 	}
 
 	ocores_platform_data.clock_khz = tqmx86_board_id_to_clk_rate(dev, board_id);
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


