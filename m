Return-Path: <linux-kernel+bounces-243188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3879292EA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 207CAB203DF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580B713DB8D;
	Sat,  6 Jul 2024 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="EzPI1NPE"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0DD13AD2B
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720264908; cv=none; b=Pcd55Nj7MKTmPftrAWQywNuEl72XqqWwOWgF13OtRKEraJvI9oSxdy2DvBk7Y8yEeGqTkitfcqUMr0l0NhiBTbFDY25RHo6/i9T5UMXZJDYX42RXjc7VceP64+UveKH9zuYO9MWXBiB6D30dyOeMGhC2UqoY6+npi2JNP/gw7/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720264908; c=relaxed/simple;
	bh=WXFufwTgiKGZ3wQTvX5QSIoPVyXoxhTxDW+DHQ8mI1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWZbvECxoptxGETSVq52j9vPsYuQrIbdesurFpWdP32EV5E5v0u8xRjT9N1TmyViFgoU3hYk/kDRaRC8TUlvxEp9Kq/BaVLgSZwsHPMGcOZlwr7cgVRZgrLlwk5B2TgZByu1MWPSqzym+f8q4q5hRelZJkqcK8kIdpH01aiZ8W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=EzPI1NPE; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=yucbiOR5K/HLeLxrTAh5H0/2HYPSbOao0ZNDnyc3lAQ=; b=EzPI1N
	PEKD/56rXHsmWq+hT3mJWaMbCa3M0gqfgzIBR0QAMr9G//BwiYPW/GPPUnL/ffrZ
	83C1mOG1ulYAiKknth3p6HDQfbIjWSxiuatQtlPqkwuQ1YI0xAYhfFzEbaRZCa8F
	ZnMLWrrHqRxGxt41rCSgNxB2FacMHVNI2P1KVv3I+Ir3euVVAeGBZxZmaG6C5qu4
	HsjfmOkD9UE9S8BdU5tEwgcprogBY/Z6NSK9srrDQryFGopaxIrlTW8kY4/PDfN4
	T7XEWU1aPWE89fs+0dbdpBQ2DVcGlpPwxFNQ/kZ98GFQduVMrHRqDbOiIO1aVvWT
	aTZPzHTCNx6f04lg==
Received: (qmail 3809685 invoked from network); 6 Jul 2024 13:21:30 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Jul 2024 13:21:30 +0200
X-UD-Smtp-Session: l3s3148p1@9n+uYZIcgJBQT+F6
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/60] i2c: davinci: reword according to newest specification
Date: Sat,  6 Jul 2024 13:20:11 +0200
Message-ID: <20240706112116.24543-12-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240706112116.24543-1-wsa+renesas@sang-engineering.com>
References: <20240706112116.24543-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the wording of this driver wrt. the newest I2C v7 and SMBus 3.2
specifications and replace "master/slave" with more appropriate terms.
Remove and reword comments while here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/i2c/busses/i2c-davinci.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 7ae611120cfa..c4fb5e9ab506 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -263,7 +263,7 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 	/* compute clock dividers */
 	i2c_davinci_calc_clk_dividers(dev);
 
-	/* Respond at reserved "SMBus Host" slave address" (and zero);
+	/* Respond at reserved "SMBus Host" target address" (and zero);
 	 * we seem to have no option to not respond...
 	 */
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_OAR_REG, DAVINCI_I2C_OWN_ADDRESS);
@@ -407,8 +407,8 @@ static int i2c_davinci_wait_bus_not_busy(struct davinci_i2c_dev *dev)
 }
 
 /*
- * Low level master read/write transaction. This function is called
- * from i2c_davinci_xfer.
+ * Low level read/write transaction. This function is called from
+ * i2c_davinci_xfer.
  */
 static int
 i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
@@ -428,7 +428,7 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 	if (pdata->bus_delay)
 		udelay(pdata->bus_delay);
 
-	/* set the slave address */
+	/* set the target address */
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_SAR_REG, msg->addr);
 
 	dev->buf = msg->buf;
@@ -440,10 +440,9 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 	reinit_completion(&dev->cmd_complete);
 	dev->cmd_err = 0;
 
-	/* Take I2C out of reset and configure it as master */
+	/* Take I2C out of reset and configure it as controller */
 	flag = DAVINCI_I2C_MDR_IRS | DAVINCI_I2C_MDR_MST;
 
-	/* if the slave address is ten bit address, enable XA bit */
 	if (msg->flags & I2C_M_TEN)
 		flag |= DAVINCI_I2C_MDR_XA;
 	if (!(msg->flags & I2C_M_RD))
@@ -687,7 +686,7 @@ static irqreturn_t i2c_davinci_isr(int this_irq, void *dev_id)
 			break;
 
 		case DAVINCI_I2C_IVR_AAS:
-			dev_dbg(dev->dev, "Address as slave interrupt\n");
+			dev_dbg(dev->dev, "Address as target interrupt\n");
 			break;
 
 		default:
@@ -744,8 +743,8 @@ static inline void i2c_davinci_cpufreq_deregister(struct davinci_i2c_dev *dev)
 #endif
 
 static const struct i2c_algorithm i2c_davinci_algo = {
-	.master_xfer	= i2c_davinci_xfer,
-	.functionality	= i2c_davinci_func,
+	.xfer = i2c_davinci_xfer,
+	.functionality = i2c_davinci_func,
 };
 
 static const struct of_device_id davinci_i2c_of_match[] = {
-- 
2.43.0


