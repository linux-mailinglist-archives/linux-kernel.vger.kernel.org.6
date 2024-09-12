Return-Path: <linux-kernel+bounces-326667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FCC976B82
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98E111F2297C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5991A706B;
	Thu, 12 Sep 2024 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="YMX/+hCi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="j87axvrk"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924431B12D4
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726149901; cv=none; b=pqdK8Si6J85qsI3HYD9gbuYJGz5uCpIhEZDewBrjPg2pjSZTarwakR8G4+7sjrCIhwaKjMy23E4RIelRLIZla2hoQM9lgBeyQrCPnqGBf38KsaIubXpk1niWGXBZvtSKfhT4XNdF9R67U9S9cvGb0iyzTxwOZsi0UJy4vMLSj48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726149901; c=relaxed/simple;
	bh=cVf67LgbWC7c10VaEOw6bU4q3wdcfTppmyd18LSPRns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y7xuVoeSgxp3sM7ZUEn1zjMM2VLgQ7ViLh1O+7hZQZ1vsVyO1xSRfZVGTRSWMX7OyHVGp7TwKHPnuSXIwl5oYNvHsoh1gbeC1kDQEbTWnZUdoPGcx2ls/HczpCzDg6AJAahOSx4GKYQVvyp/y1RS8Vjjw8FrxVlh3tXiPqVRTzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=YMX/+hCi; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=j87axvrk reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1726149899; x=1757685899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K7wx+SOr1nMnGECauQGMnSmAs9lCy7lfVf77KqJ735E=;
  b=YMX/+hCiPlIwmsGJ6S4Bc1SEol4/iyydZN/XCy+XexcO8enVj5EIo6/A
   pXYMGgWWyohKdhuHYdtbeW5x6FcxZ+aAyaFil5GxRubnMtvchgdQWbPbL
   aog3vf0UQ5KbZpUCTFcVNe8h5DaT+kz0+KuUqeCxyt41JnmCAt9G8Lz0b
   fz9T+30Fm+F0zqoFF32Pu3vWReAhFd7+DamVEi/UOFSj7iiW1tlDMA23S
   8DqJf8UGkHduTtQRn5XKQ0JEdhQt9UDrOx0TQ0YfkUzyufgTFuJMjY4K+
   mWnNHPrGvML97SMyf850yrLctWvze4PUZehqUqphxtKLxE4J1hcH8oTx3
   A==;
X-CSE-ConnectionGUID: T/TukFMRS5WEK4bEKm2+fA==
X-CSE-MsgGUID: 6cwK2BKPRBuTocBP+OrLbg==
X-IronPort-AV: E=Sophos;i="6.10,223,1719871200"; 
   d="scan'208";a="38915418"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 12 Sep 2024 16:04:58 +0200
X-CheckPoint: {66E2F50A-11-E520F13A-D17B83D9}
X-MAIL-CPID: AB6ECD4D007D479A1924B05A209CF784_2
X-Control-Analysis: str=0001.0A782F15.66E2F50A.00F4,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0449E166F05;
	Thu, 12 Sep 2024 16:04:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1726149894;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=K7wx+SOr1nMnGECauQGMnSmAs9lCy7lfVf77KqJ735E=;
	b=j87axvrk3ZvbJtACYQ90sDSHkPtKv5uzF9dxrhkB+bHnYYORJNGNdGUO7luBKIAYgs1aN2
	DCod8gP3ZD0zsa5nXyht9a+v6Ey/RCZdXF6bCqOP0QZ1wfb03CTVV4CJh8Xt/00RzbeE2l
	Lbq+e0iuhh4n69SOqHLcoMzuBgw2taSetOwQfIT625dFFijWFa5yVhuodIePzxub3zjwqE
	ze0pKSyN9/jMaMhdtlDhTd3yRews9uqO2ADOE+ORTas2ZmROnh8TejA0Hzy3AwsX4MztQY
	u4PljMrH8CIn3xncrNG0Hqp+76uVDwtCJGpfVoMhRmUVmdU728avdD++AJkC3Q==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Gregor Herburger <gregor.herburger@tq-group.com>
Subject: [PATCH v3 3/5] mfd: tqmx86: refactor GPIO IRQ setup
Date: Thu, 12 Sep 2024 16:04:10 +0200
Message-ID: <00708dee4281943a8da8dc2fee63388c9f923048.1726148801.git.matthias.schiffer@ew.tq-group.com>
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

Move IRQ setup into a helper function. The string "GPIO" for error
messages is replaced with a label argument to prepare for reusing the
function for the I2C IRQ.

No functional change intended.

Co-developed-by: Gregor Herburger <gregor.herburger@tq-group.com>
Signed-off-by: Gregor Herburger <gregor.herburger@tq-group.com>
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: no changes (was patch 2/4)
v3: no changes

 drivers/mfd/tqmx86.c | 72 +++++++++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 27 deletions(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index 7b2f9490a9af5..5aa51ead00a28 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -186,32 +186,54 @@ static int tqmx86_board_id_to_clk_rate(struct device *dev, u8 board_id)
 	}
 }
 
-static int tqmx86_probe(struct platform_device *pdev)
+static int tqmx86_irq_to_irq_cfg(struct device *dev, const char *label, u8 irq)
 {
-	u8 board_id, sauc, rev, i2c_det, io_ext_int_val;
-	struct device *dev = &pdev->dev;
-	u8 gpio_irq_cfg, readback;
-	const char *board_name;
-	void __iomem *io_base;
-	int err;
-
-	switch (gpio_irq) {
+	switch (irq) {
 	case 0:
-		gpio_irq_cfg = TQMX86_REG_IO_EXT_INT_NONE;
-		break;
+		return TQMX86_REG_IO_EXT_INT_NONE;
 	case 7:
-		gpio_irq_cfg = TQMX86_REG_IO_EXT_INT_7;
-		break;
+		return TQMX86_REG_IO_EXT_INT_7;
 	case 9:
-		gpio_irq_cfg = TQMX86_REG_IO_EXT_INT_9;
-		break;
+		return TQMX86_REG_IO_EXT_INT_9;
 	case 12:
-		gpio_irq_cfg = TQMX86_REG_IO_EXT_INT_12;
-		break;
+		return TQMX86_REG_IO_EXT_INT_12;
 	default:
-		pr_err("tqmx86: Invalid GPIO IRQ (%d)\n", gpio_irq);
+		dev_err(dev, "invalid %s IRQ (%d)\n", label, irq);
 		return -EINVAL;
 	}
+}
+
+static int tqmx86_setup_irq(struct device *dev, const char *label, u8 irq,
+			    void __iomem *io_base, u8 reg_shift)
+{
+	u8 val, readback;
+	int irq_cfg;
+
+	irq_cfg = tqmx86_irq_to_irq_cfg(dev, label, irq);
+	if (irq_cfg < 0)
+		return irq_cfg;
+
+	val = ioread8(io_base + TQMX86_REG_IO_EXT_INT);
+	val &= ~(TQMX86_REG_IO_EXT_INT_MASK << reg_shift);
+	val |= (irq_cfg & TQMX86_REG_IO_EXT_INT_MASK) << reg_shift;
+
+	iowrite8(val, io_base + TQMX86_REG_IO_EXT_INT);
+	readback = ioread8(io_base + TQMX86_REG_IO_EXT_INT);
+	if (readback != val) {
+		dev_warn(dev, "%s interrupts not supported\n", label);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int tqmx86_probe(struct platform_device *pdev)
+{
+	u8 board_id, sauc, rev, i2c_det;
+	struct device *dev = &pdev->dev;
+	const char *board_name;
+	void __iomem *io_base;
+	int err;
 
 	io_base = devm_ioport_map(dev, TQMX86_IOBASE, TQMX86_IOSIZE);
 	if (!io_base)
@@ -233,15 +255,11 @@ static int tqmx86_probe(struct platform_device *pdev)
 	 */
 	i2c_det = inb(TQMX86_REG_I2C_DETECT);
 
-	if (gpio_irq_cfg) {
-		io_ext_int_val =
-			gpio_irq_cfg << TQMX86_REG_IO_EXT_INT_GPIO_SHIFT;
-		iowrite8(io_ext_int_val, io_base + TQMX86_REG_IO_EXT_INT);
-		readback = ioread8(io_base + TQMX86_REG_IO_EXT_INT);
-		if (readback != io_ext_int_val) {
-			dev_warn(dev, "GPIO interrupts not supported.\n");
-			return -EINVAL;
-		}
+	if (gpio_irq) {
+		err = tqmx86_setup_irq(dev, "GPIO", gpio_irq, io_base,
+				       TQMX86_REG_IO_EXT_INT_GPIO_SHIFT);
+		if (err)
+			return err;
 
 		/* Assumes the IRQ resource is first. */
 		tqmx_gpio_resources[0].start = gpio_irq;
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

