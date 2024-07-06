Return-Path: <linux-kernel+bounces-243205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2261792930D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD6D7B21EA4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47A7155743;
	Sat,  6 Jul 2024 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="DkyU674e"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E25982D98
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 11:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720264921; cv=none; b=o3UiSji6G9MdDskdZKuos559OrCBskW7lclubdiZkWAioYcDmZhC90wOw2dfYKSsan5/E/VturRcgJd/QKLM//Ew7E/Auj4Iw4J6ydzAv00YxHqhoLWeieCEIHm0mA5+57fUU8UVM99TLKiqOQgLHkyuy4Xk8NAERD9LJs6A0vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720264921; c=relaxed/simple;
	bh=GQ7AscxsiB7KIMXnS10kEk9JG7HElWTNr/HQFaAEMhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgVZOiccEzMjSFMwbQ24nc4Wy9j0onQopG2bpwFnwO7zihbEBgOXF5XJ131WNi6QmM6ezPEie/r5eiuFGH00Twa1bRvKEyMm/z3wXqzWBXRvh3wyasGqdvHp2jT/c57H2x4fJWCe0mYU+SY5UQrFHg4l5iEZ/Xd8g4W4RbvsIZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=DkyU674e; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=cp618S8vHhzxJdcIjg6Ny+vaCeHJI56nQ4VnW8vX7Yw=; b=DkyU67
	4eIORXOVGvvWCQ0bDVFn0oL0wSuz+Oap8H4NrESaJlabd4v+2z9iePfGUaUR2u/y
	HX+kXF0nnULB0p6csq+/ESX1vT5dnvqDCoc/GFjy8JXsIeYMU2Ai9u/WLRio9FPl
	sXGYOZSNTAi1GxbuWrF8/lvflt55as9xRf6zwGYUWdTndQp5+35vhI9VjHv0FdvV
	uPTECT39ErGJ085rVxBsUwXQng34qPG5Y0dhDWuEsWh/ItraVYH39r0kTzYKByTd
	32NQBZOAr433nEcSlF0lofVH7Z6gczFoiI+j8Z/517+sHsDiEVBE3zivuQeV5G/B
	BZu9GqFirYHg73AQ==
Received: (qmail 3810285 invoked from network); 6 Jul 2024 13:21:42 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Jul 2024 13:21:42 +0200
X-UD-Smtp-Session: l3s3148p1@jitnYpIcaoZQT+F6
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 28/60] i2c: ls2x: reword according to newest specification
Date: Sat,  6 Jul 2024 13:20:28 +0200
Message-ID: <20240706112116.24543-29-wsa+renesas@sang-engineering.com>
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
 drivers/i2c/busses/i2c-ls2x.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ls2x.c b/drivers/i2c/busses/i2c-ls2x.c
index ebae6035701d..8821cac3897b 100644
--- a/drivers/i2c/busses/i2c-ls2x.c
+++ b/drivers/i2c/busses/i2c-ls2x.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Loongson-2K/Loongson LS7A I2C master mode driver
+ * Loongson-2K/Loongson LS7A I2C controller mode driver
  *
  * Copyright (C) 2013 Loongson Technology Corporation Limited.
  * Copyright (C) 2014-2017 Lemote, Inc.
@@ -51,7 +51,7 @@
 /* Control Register Bit */
 #define LS2X_CTR_EN		BIT(7) /* 0: I2c frequency setting 1: Normal */
 #define LS2X_CTR_IEN		BIT(6) /* Enable i2c interrupt */
-#define LS2X_CTR_MST		BIT(5) /* 0: Slave mode 1: Master mode */
+#define LS2X_CTR_MST		BIT(5) /* 0: Target mode 1: Controller mode */
 #define CTR_FREQ_MASK		GENMASK(7, 6)
 #define CTR_READY_MASK		GENMASK(7, 5)
 
@@ -251,8 +251,7 @@ static int ls2x_i2c_xfer_one(struct ls2x_i2c_priv *priv,
 	return ret;
 }
 
-static int ls2x_i2c_master_xfer(struct i2c_adapter *adap,
-				struct i2c_msg *msgs, int num)
+static int ls2x_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 {
 	int ret;
 	struct i2c_msg *msg, *emsg = msgs + num;
@@ -273,8 +272,8 @@ static unsigned int ls2x_i2c_func(struct i2c_adapter *adap)
 }
 
 static const struct i2c_algorithm ls2x_i2c_algo = {
-	.master_xfer	= ls2x_i2c_master_xfer,
-	.functionality	= ls2x_i2c_func,
+	.xfer = ls2x_i2c_xfer,
+	.functionality = ls2x_i2c_func,
 };
 
 static int ls2x_i2c_probe(struct platform_device *pdev)
-- 
2.43.0


