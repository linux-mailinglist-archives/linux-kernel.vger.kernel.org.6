Return-Path: <linux-kernel+bounces-374201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 592479A66AF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5BE1F222CB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1781E7C29;
	Mon, 21 Oct 2024 11:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="YmIz9YXz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="hmmdSEaY"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4091E909F
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729510514; cv=none; b=ofWx1hCcU5sfocS0/xoqn8JDAxg5Wuc+1RFNmsbN/jCvOUUadP9Dzu+oxM8fHtTYTnLsNspIMu5WlIgeSUKPlJNH5wj4itmCxTZc4Lv/7SU2pfobqjoKcxYNMILSB5LMoZKCqsnkjozUtjxBvvrnBBV1+IByhPqupXB5ggsVPik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729510514; c=relaxed/simple;
	bh=WA/4uKfUsD44pjBCULZxuAlLuwB456I0k5rzgWYSiTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujMw7puDzK8w+G6/IllYLcsA0t7djI62DUHsOA9fAq6Qcu6c1Tv8f24pGGur/CMbk6EJMUw2v8yL8noxhMtXV6fS13juoRVNLifpnMOe6VfRqEAwt3mcpceRrr26fw9R8DH+EdY2D4GXtwNdVFR0EMTcwo0vrlvuO+Rl1XFo7Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=YmIz9YXz; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=hmmdSEaY reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1729510512; x=1761046512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eER0iIIf1vXWwp4jkMn6PNdl/e0XfRg68y+teb4/R6w=;
  b=YmIz9YXzbdn6UCtXW3bLSjH8rAsxO+rkbnHKTiXfwjDLcNX+3MA1THgF
   JpxUNhZ610eTml+RwUaE2FwymjoNkV/psqt7ALLz3MGaKTsCAAUWiMFZR
   YSKyt+YZliJCCy2+oM5vMhj0Z5byDKrXtsxlnD2omvH92qu7fc3OlX2dG
   MIvCj+0SBkJBQvA1aKKdUJuLY1Zu1CkLhZkiS2IQOkyOcTMt/CDZ5MN0w
   JTjgeFd68yRegyS1voBRy2Eb3FKRFUAfNSoWe3pTzRDEXTmaTC+pVoejE
   4YTUg7yLxtnGrzhrZ/HldGl2myz4lxp+zsFSOGji61u/rs5mA5p+LrRU5
   Q==;
X-CSE-ConnectionGUID: Xaen60zNRQG6GBVjetv1zA==
X-CSE-MsgGUID: chFPbu+6TkGNrrOBlLRCig==
X-IronPort-AV: E=Sophos;i="6.11,220,1725314400"; 
   d="scan'208";a="39572178"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 21 Oct 2024 13:35:10 +0200
X-CheckPoint: {67163C6E-53-21611FC3-DAD22B0C}
X-MAIL-CPID: 20F6F9CCED11484797F4B29287C975C4_4
X-Control-Analysis: str=0001.0A682F17.67163C6F.0056,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 871C216B31D;
	Mon, 21 Oct 2024 13:35:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1729510506;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=eER0iIIf1vXWwp4jkMn6PNdl/e0XfRg68y+teb4/R6w=;
	b=hmmdSEaYHt2wbNJD2vs2VrvRzymnBBagwBjpoMkX+FtshORlZvrl1egi70l7Usvstmx3cI
	by6n0eJiEp1LKwTRfoStN9kckisCriM1C1xIw3RumIf/oFwYVKzUCJJudU2k5sZgcLAcYN
	/+KDbgbeXXDLYzTGtoROC1y/9alXgWqJy4k76iHDIAByWjY0d154i8734Z67nwyHiJmS7p
	yFStGjZqKMvSiLTXT505XdcBq/LzZSiUjeMEOanPix+WtT8d1OJ4C+yYdgdt9KfAiO3H0P
	0s9CiSGebONeOUx8jvkdFwTheZtPeP990BNpjcVl7IxKXJ9flCUMSO8HrlrvSA==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com,
	linux-kernel@vger.kernel.org,
	Gregor Herburger <gregor.herburger@tq-group.com>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v5 5/5] mfd: tqmx86: add I2C IRQ support
Date: Mon, 21 Oct 2024 13:34:27 +0200
Message-ID: <1d2477439ec2bb7f5145648da4be5dcd8cfb6847.1729509613.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729509613.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1729509613.git.matthias.schiffer@ew.tq-group.com>
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
v4: no changes
v5: move placeholder to the end of the resource array, use define for index

 drivers/mfd/tqmx86.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index 1fd2212bf492c..94126a484c412 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -50,6 +50,7 @@
 #define TQMX86_REG_IO_EXT_INT_9			2
 #define TQMX86_REG_IO_EXT_INT_12		3
 #define TQMX86_REG_IO_EXT_INT_MASK		0x3
+#define TQMX86_REG_IO_EXT_INT_I2C_SHIFT		0
 #define TQMX86_REG_IO_EXT_INT_GPIO_SHIFT	4
 #define TQMX86_REG_SAUC		0x17
 
@@ -60,11 +61,18 @@ static uint gpio_irq;
 module_param(gpio_irq, uint, 0);
 MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (valid parameters: 7, 9, 12)");
 
+static uint i2c_irq;
+module_param(i2c_irq, uint, 0);
+MODULE_PARM_DESC(i2c_irq, "I2C IRQ number (valid parameters: 7, 9, 12)");
+
 /* Index of IRQ placeholder in resource list */
 #define TQMX86_IRQ_GPIO 1
+#define TQMX86_IRQ_I2C 1
 
-static const struct resource tqmx_i2c_soft_resources[] = {
+static struct resource tqmx_i2c_soft_resources[] = {
 	DEFINE_RES_IO(TQMX86_IOBASE_I2C, TQMX86_IOSIZE_I2C),
+	/* Placeholder for IRQ resource - filled in by the probe function */
+	[TQMX86_IRQ_I2C] = {},
 };
 
 static const struct resource tqmx_watchdog_resources[] = {
@@ -262,6 +270,14 @@ static int tqmx86_probe(struct platform_device *pdev)
 	ocores_platform_data.clock_khz = tqmx86_board_id_to_clk_rate(dev, board_id);
 
 	if (i2c_det == TQMX86_REG_I2C_DETECT_SOFT) {
+		if (i2c_irq) {
+			err = tqmx86_setup_irq(dev, "I2C", i2c_irq, io_base,
+					       TQMX86_REG_IO_EXT_INT_I2C_SHIFT);
+			if (!err)
+				/* Assumes the IRQ resource placeholder is first */
+				tqmx_i2c_soft_resources[TQMX86_IRQ_I2C] = DEFINE_RES_IRQ(i2c_irq);
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

