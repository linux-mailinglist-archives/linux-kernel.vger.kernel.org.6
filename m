Return-Path: <linux-kernel+bounces-352937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B700299265D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79AEF2856DC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72091184522;
	Mon,  7 Oct 2024 07:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="HJtk+Tqy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="f/BL8tTT"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815F218A95F
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287397; cv=none; b=arsptPSe2oFZs3JFTmndMquGhszKBOjLb2OD2Ul1iqgiKPJ2XeY/2RzLlHBoAHFekdvx8A0Fo8sFmOMuakWsatoI6Kzo0cOIq4Zkjmy8l3GHkRKGwxZblPG5xoCWZkM0+GCMpEeaK/AdOazoBcGNZTNOb2wGcwvYpl9KMa6kCEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287397; c=relaxed/simple;
	bh=+JvcitsLBRq0PI86c4PobYUhsNFXv1qCXs/r9THHVXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aS+CGo68TVy05xngiA6xXHUcqsbeOI/AnDy19HgIy6/GoUHdPhzeoYwqvIp7x722QAvwn4Xq/gqum3vM/dOED9PAiJ07TP131fnQ3E2c78VtOOQPYldaYfXI5arobq+2QOB23bVqnIYxJ3fDjMoYJubBZFPJYyHKNq7P343nLEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=HJtk+Tqy; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=f/BL8tTT reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1728287395; x=1759823395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=33Y+AmTApWWVjsUux29vl1VsE0lKQwC+p3SmjObu5z8=;
  b=HJtk+TqychTR8BwF7EhkT0z99kNE+cYMHGI2HUnSkjJwnydpPoxwP9Tp
   MHYoV+0j1VXvn1snStlE8ZExdE82aMDmJN3xcTr4tMIxARBO3PRVVF8DU
   7Lq4m9oWbbuXOpBZ3mB02nJv+c/BGK8Ncaeh4y97JLCkWlJZQ/qSdAXFU
   jp2Jeqwkqa9J7PbNr2rFcPRvjEdWUaBp/pIft4wsDCzEMR/TKiPXvw634
   8Lle2Gb4+MPFq6Brbc3TQa3LZzOIyCn3wmdtYF+onildtzi934xkJPrEO
   e0CG6pZ7iL46++MgyQpNofaIOqVF3gmOhvYD8hND7qv6mXedUb0x5ydzW
   g==;
X-CSE-ConnectionGUID: F4IAbebaQbq3d7uZtZR+oQ==
X-CSE-MsgGUID: DYCAL3wxTUmg2eGrT2DdvQ==
X-IronPort-AV: E=Sophos;i="6.11,183,1725314400"; 
   d="scan'208";a="39297577"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 07 Oct 2024 09:48:52 +0200
X-CheckPoint: {67039264-1E-514F5986-FE9EEFAE}
X-MAIL-CPID: 36E0A6C5F53499E13ED3BAE7FE6E1F2D_5
X-Control-Analysis: str=0001.0A682F28.67039264.00FD,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0EA7916A9AE;
	Mon,  7 Oct 2024 09:48:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1728287328;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=33Y+AmTApWWVjsUux29vl1VsE0lKQwC+p3SmjObu5z8=;
	b=f/BL8tTTp9Q6hsyo+h09URWGTUjDytpesppZmwvXwfxgKQIPw8/IMZvrXwKd1dzcC1x4At
	IvVsGyrFapaB86+XVw1fFh+6RIUat4UAkZdR/cmyK3dKi7c8XgxoQYSkkkOUQNw0+wUQHg
	Y8ez/eF97HZ9BnPkZ3UywfDxedIIE4MP1DUjy5OcgfwPZ4wpijoU3A6aKNtPUxLHUkkVz/
	PPwlmo+1IirurVP6zq4Ii+LKyvzghLqDRJApZwLrJsopT9+cByHldcnJrn8APUcAmMi+cw
	QExzvo0+4Pvx741lv0LOc+oItt5G4q7OjSOmXvR1FZAMy/aWOA3pUlt/X96D7g==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Gregor Herburger <gregor.herburger@tq-group.com>
Subject: [PATCH v4 3/5] mfd: tqmx86: refactor GPIO IRQ setup
Date: Mon,  7 Oct 2024 09:48:06 +0200
Message-ID: <ed38f83848bab013944cf8b848e8c64bd9eae1d8.1728286453.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1728286453.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1728286453.git.matthias.schiffer@ew.tq-group.com>
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
v4: drop tqmx86_irq_to_irq_cfg() function, handle IRQ-to-register-value
    mapping in tqmx86_setup_irq() instead

 drivers/mfd/tqmx86.c | 59 +++++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index 7b2f9490a9af5..8aa448a67c9a5 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -186,33 +186,52 @@ static int tqmx86_board_id_to_clk_rate(struct device *dev, u8 board_id)
 	}
 }
 
-static int tqmx86_probe(struct platform_device *pdev)
+static int tqmx86_setup_irq(struct device *dev, const char *label, u8 irq,
+			    void __iomem *io_base, u8 reg_shift)
 {
-	u8 board_id, sauc, rev, i2c_det, io_ext_int_val;
-	struct device *dev = &pdev->dev;
-	u8 gpio_irq_cfg, readback;
-	const char *board_name;
-	void __iomem *io_base;
-	int err;
+	u8 val, readback;
+	int irq_cfg;
 
-	switch (gpio_irq) {
+	switch (irq) {
 	case 0:
-		gpio_irq_cfg = TQMX86_REG_IO_EXT_INT_NONE;
+		irq_cfg = TQMX86_REG_IO_EXT_INT_NONE;
 		break;
 	case 7:
-		gpio_irq_cfg = TQMX86_REG_IO_EXT_INT_7;
+		irq_cfg = TQMX86_REG_IO_EXT_INT_7;
 		break;
 	case 9:
-		gpio_irq_cfg = TQMX86_REG_IO_EXT_INT_9;
+		irq_cfg = TQMX86_REG_IO_EXT_INT_9;
 		break;
 	case 12:
-		gpio_irq_cfg = TQMX86_REG_IO_EXT_INT_12;
+		irq_cfg = TQMX86_REG_IO_EXT_INT_12;
 		break;
 	default:
-		pr_err("tqmx86: Invalid GPIO IRQ (%d)\n", gpio_irq);
+		dev_err(dev, "invalid %s IRQ (%d)\n", label, irq);
 		return -EINVAL;
 	}
 
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
+
 	io_base = devm_ioport_map(dev, TQMX86_IOBASE, TQMX86_IOSIZE);
 	if (!io_base)
 		return -ENOMEM;
@@ -233,15 +252,11 @@ static int tqmx86_probe(struct platform_device *pdev)
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


