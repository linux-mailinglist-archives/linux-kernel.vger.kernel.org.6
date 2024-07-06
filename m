Return-Path: <linux-kernel+bounces-243209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 266E7929315
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54BBE1C212D8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B6E158D91;
	Sat,  6 Jul 2024 11:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ROV2pcBa"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1954C155CB0
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720264924; cv=none; b=XV9IVftUokPhjXY+gc1q8Uc0ugp0J8hN8e0iKskO29Pf8Afy+XNa60MIgRZ+QFRzurha9CVG3fX4KFxrJixgqY7P7dM4S7r6r1PXeFceRedI11PaAtHfDDmgWL1CP2GXDom+fJ5TI5YjdzmEBN4ohQe4BThvhx8cs3BI0WCnf/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720264924; c=relaxed/simple;
	bh=uASGBnRIOAUunsBu4PC5+W+eVdqyB+P6JqFrF86wJMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEZUC3ZqbJXcH45ecCyVcDzUFbg/JMIa1D3xo+m6vQ7GBoPafgh8fKh9gjjJPLYxQ0AG4Y+cvt7lBNOW7jTxlr8ER2O2RIysYIuOXsGZhu93+Ef7bUZnv5yZwzCsNe1eaQP78RPIvYK7AIxf1WePY6lLjZ9z9rweqIxx0NRDdSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ROV2pcBa; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=V5hj0O5AUmD5ufh1dIsleSmlRFxggB91JNffQLCPKFw=; b=ROV2pc
	Ba428bheivtFBYD/QwxY/9Kvx7XxiagtsvF6mukI71+L7d+D9IO2mZ8P8h/Rephw
	BtNaV4HMC2sX90EmjNu7etGSNic774+haT93E9uIrEc+Kv2BPXKP15aCSBUKmgHU
	QLK5vlBmNX9HkeL9dKtZYFi+iV1/hzuNcB0oigv/8nszVpoSkRelEVraIRtvRN6D
	IaCEi8rNlYfyM9siyztZTMqAphmilqzWiTq3OIVbXsFXScm6yFtqYvgzbS/qc6cC
	OoUFyz2EP7GPy0kFx06SqtDo6GtAFb2rOnQoGZ3HdQBh0uMLehO/g5EWr84BvwE2
	kDzLL6Pdj1RyaEpQ==
Received: (qmail 3810456 invoked from network); 6 Jul 2024 13:21:45 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Jul 2024 13:21:45 +0200
X-UD-Smtp-Session: l3s3148p1@HzibYpIc/sFQT+F6
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 33/60] i2c: ocores: reword according to newest specification
Date: Sat,  6 Jul 2024 13:20:33 +0200
Message-ID: <20240706112116.24543-34-wsa+renesas@sang-engineering.com>
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

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-ocores.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 4ad670a80a63..482b37c8a129 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -444,8 +444,8 @@ static u32 ocores_func(struct i2c_adapter *adap)
 }
 
 static struct i2c_algorithm ocores_algorithm = {
-	.master_xfer = ocores_xfer,
-	.master_xfer_atomic = ocores_xfer_polling,
+	.xfer = ocores_xfer,
+	.xfer_atomic = ocores_xfer_polling,
 	.functionality = ocores_func,
 };
 
@@ -682,13 +682,13 @@ static int ocores_i2c_probe(struct platform_device *pdev)
 	}
 
 	if (irq == -ENXIO) {
-		ocores_algorithm.master_xfer = ocores_xfer_polling;
+		ocores_algorithm.xfer = ocores_xfer_polling;
 	} else {
 		if (irq < 0)
 			return irq;
 	}
 
-	if (ocores_algorithm.master_xfer != ocores_xfer_polling) {
+	if (ocores_algorithm.xfer != ocores_xfer_polling) {
 		ret = devm_request_any_context_irq(&pdev->dev, irq,
 						   ocores_isr, 0,
 						   pdev->name, i2c);
-- 
2.43.0


