Return-Path: <linux-kernel+bounces-326669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B439976B85
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5411C237B3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28671B9826;
	Thu, 12 Sep 2024 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="FKtmYPHx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="dEXjazML"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67131B9833
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726149910; cv=none; b=HGruInf9GNKe8oASeMm7YsPKgJt+j0hjXijGJTT49qtmLzPQ11APCZ34H7w04iyge2IxYa1tmNN/AY/EURa0xA4pElComSiG5wvUfyb2E5iPFvExm16pfAf7t7L0Ao7J9B6A5Y7x/YK9UeQ0jtGSOwKWyJAuk2YBqNXm6bV8/Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726149910; c=relaxed/simple;
	bh=sfS2d7/ZFrK2eSh5ttMjXV9ZFIaMIaOr6osVgffMd0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iGkiRwS+ZeMwYIIaAoigDVzPTyC6qkGk+osd/csDVEj7fuT7Ov5+6WxjuOpkkIvwJUnLpFyussW5ilwsfSm2FxvyVCZXVRyGW9RK5rJWnYUnedONaut52Ay+ieKAbZjE9IfgfL9bPKpH8dG6c7THO94UTdDBCLZfAqK1fiwugQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=FKtmYPHx; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=dEXjazML reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1726149908; x=1757685908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eLMZQORqOFDZQXLolUrCyhPHVFrKxvZGHRY2FdlUp58=;
  b=FKtmYPHxFBOxLrVvsbpCtZbHwRhcnhQdMLeekZH4xYVPQ42icD4OSTH+
   Ozp1bIqw5RuRedcDvucMBoL882xCGt8L3CMyd+mgdnG92L2Y8CT6rJNd3
   QMNKnxhUox71RYeML7dE+4oLxwEtsOPnXnuh0TxEgcYiI/s/S2uHnNvC6
   NNJ8yVSJ19R+BktbexWDdZAJd9wpedlEaNzlHqiKj9prqLSBBP5AcFMXz
   7+PT9cgypYCI7zKZVWc02SKMtYlVSjDJaFvoyHfd0pq9b/oefj5COVc1f
   g26YSx8ax/0xY+B1fYkedwu4/NhbMe7jIZEYWoCiC0B3N3P1SdHQgOuqv
   g==;
X-CSE-ConnectionGUID: dCQtbDcKRTeFhQKGkvbUuQ==
X-CSE-MsgGUID: 23rgBulMTnSFgSj5uWeOMQ==
X-IronPort-AV: E=Sophos;i="6.10,223,1719871200"; 
   d="scan'208";a="38915426"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 12 Sep 2024 16:05:07 +0200
X-CheckPoint: {66E2F513-1A-E520F13A-D17B83D9}
X-MAIL-CPID: 7F4EC17551F8AA45C923140128B7180D_2
X-Control-Analysis: str=0001.0A782F17.66E2F513.00A3,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DBA1D166F63;
	Thu, 12 Sep 2024 16:05:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1726149903;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=eLMZQORqOFDZQXLolUrCyhPHVFrKxvZGHRY2FdlUp58=;
	b=dEXjazMLgjlhe65qn+mkg4vFWgyiq+X2k08qNClhJY2r0ioMN4jR52aj1J4WFKSLWQC8zG
	DNPLy1geqOqokRYrnHk80oH5/RqEF54XGhk10WHnq+RKlJekby4G06knReKwZDNox0SLEs
	eWu7gH69NW2cicZMlkojN6xG+uplKlFw1pbgaz3jth/xzBWFVTrFBo9k8PQPRCusul+prL
	lAZH1Dxyry7wNenH44b6Ks/o63I+h6HKnaLxb2xfM3BREYRqkgfBs0cPXD4ZSIPq/HJ/KA
	Rbu5OHIKIkfAv7SM2k44sz3UD0VfxNpG/om/v+0QGH8rvwsUsgk2zuTxk1Wj7A==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com,
	linux-kernel@vger.kernel.org,
	Gregor Herburger <gregor.herburger@tq-group.com>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v3 5/5] mfd: tqmx86: add I2C IRQ support
Date: Thu, 12 Sep 2024 16:04:12 +0200
Message-ID: <6a195791010e6b2a74d3e9643e444e546fc4b8ca.1726148801.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726148801.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1726148801.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Gregor Herburger <gregor.herburger@tq-group.com>

The i2c-ocores controller can run in interrupt mode on tqmx86 modules.
Add module parameter to allow configuring the IRQ number, similar to the
handling of the GPIO IRQ.

Signed-off-by: Gregor Herburger <gregor.herburger@tq-group.com>
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: improve module parameter description (was patch 4/4)
v3: replace IRQ 0 resource with an empty placeholder to simplify error handling

 drivers/mfd/tqmx86.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index 979b6816adfa7..1bb7179a8c0a6 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -50,6 +50,7 @@
 #define TQMX86_REG_IO_EXT_INT_9			2
 #define TQMX86_REG_IO_EXT_INT_12		3
 #define TQMX86_REG_IO_EXT_INT_MASK		0x3
+#define TQMX86_REG_IO_EXT_INT_I2C_SHIFT		0
 #define TQMX86_REG_IO_EXT_INT_GPIO_SHIFT	4
 #define TQMX86_REG_SAUC		0x17
 
@@ -60,7 +61,16 @@ static uint gpio_irq;
 module_param(gpio_irq, uint, 0);
 MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (valid parameters: 7, 9, 12)");
 
-static const struct resource tqmx_i2c_soft_resources[] = {
+static uint i2c_irq;
+module_param(i2c_irq, uint, 0);
+MODULE_PARM_DESC(i2c_irq, "I2C IRQ number (valid parameters: 7, 9, 12)");
+
+static struct resource tqmx_i2c_soft_resources[] = {
+	/*
+	 * Placeholder for IRQ resource - must come first to be filled in by the
+	 * probe function.
+	 */
+	{},
 	DEFINE_RES_IO(TQMX86_IOBASE_I2C, TQMX86_IOSIZE_I2C),
 };
 
@@ -266,6 +276,14 @@ static int tqmx86_probe(struct platform_device *pdev)
 	ocores_platform_data.clock_khz = tqmx86_board_id_to_clk_rate(dev, board_id);
 
 	if (i2c_det == TQMX86_REG_I2C_DETECT_SOFT) {
+		if (i2c_irq) {
+			err = tqmx86_setup_irq(dev, "I2C", i2c_irq, io_base,
+					       TQMX86_REG_IO_EXT_INT_I2C_SHIFT);
+			if (!err)
+				/* Assumes the IRQ resource placeholder is first */
+				tqmx_i2c_soft_resources[0] = DEFINE_RES_IRQ(i2c_irq);
+		}
+
 		err = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
 					   tqmx86_i2c_soft_dev,
 					   ARRAY_SIZE(tqmx86_i2c_soft_dev),
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

