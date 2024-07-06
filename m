Return-Path: <linux-kernel+bounces-243231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 545E4929344
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB6C2843AF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CC517B504;
	Sat,  6 Jul 2024 11:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="BhHMmA2M"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ECC178395
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 11:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720264943; cv=none; b=m2ZbvaiVHb1RhJHR74jvFXUJOAMKZqF60LGzVghzcF9eZCQ6GWsJlL/dn5gk3flkwF5KP9h6Sse1aZfLNpCClZS6f/VSlacD8og7hYme/DZB45lXcbGY1Dqxp6BhUUCbY35FMCOSq2dTLPeW0mvrVKLtdkFPB/B5+yo6mYhUCXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720264943; c=relaxed/simple;
	bh=ILpyGAT8PH5cBPd/u77XyqG3keeBSAhNNTzknC5K6B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUaYkr8jXrbr/xTbbdvkvchTCC3wj8U2wNTiiBS6SXNkyBVg6gzmIVN2IeqFC37IC4YtJrtXAhR0ERmf/jzDvOB5r5WgE4eqD2yBZEt0SWsPm/sSdqa7HiR61O8JeytB81h01t+QPsvMtFgH4uOvEkZEOm0KipAS0qsxOBhh47w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=BhHMmA2M; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=zqYCUBvfBDZC4N4gYZQotgieK/uKq8Y98h1CwEc6O/8=; b=BhHMmA
	2MJObwxT32OjiAFdwaPl377lcNswQUA9m9rriVeO7WIeRfLBqqjPd2cYhpZzYrk+
	sEJxZk9e40HKGNHmO06npLXdJc1bH9Fh2JQ7lzQqhETBRERGMnS8Z4zc1iFnQGkq
	FckJfrRIvKgJJjMiSbt3QtLqnDPjkl731qHnUcL9OJvCwsuhiTyMlxiiIptgkegu
	7hMKTOXS8kU+sGtMLUkAszepmE3BdiGkcUWdI/uhyG/GvAXNpIkaJ8asHhZqn+uJ
	sdS9ZoR6+05B4JbhVAuOtUfpyb9rGV7mZV3qSc1YbMZLR9yj0HldIP6AecovqBnp
	IDRi+JsHmklqmrkw==
Received: (qmail 3811159 invoked from network); 6 Jul 2024 13:22:01 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Jul 2024 13:22:01 +0200
X-UD-Smtp-Session: l3s3148p1@esmFY5IcpOFQT+F6
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 55/60] i2c: viperboard: reword according to newest specification
Date: Sat,  6 Jul 2024 13:20:55 +0200
Message-ID: <20240706112116.24543-56-wsa+renesas@sang-engineering.com>
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
Remove a superfluous debug output which is already available via
tracing.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-viperboard.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-viperboard.c b/drivers/i2c/busses/i2c-viperboard.c
index 3784b07f5371..2ed4130c0339 100644
--- a/drivers/i2c/busses/i2c-viperboard.c
+++ b/drivers/i2c/busses/i2c-viperboard.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *  Nano River Technologies viperboard i2c master driver
+ *  Nano River Technologies viperboard i2c controller driver
  *
  *  (C) 2012 by Lemonage GmbH
  *  Author: Lars Poeschel <poeschel@lemonage.de>
@@ -273,8 +273,6 @@ static int vprbrd_i2c_xfer(struct i2c_adapter *i2c, struct i2c_msg *msgs,
 		(struct vprbrd_i2c_addr_msg *)vb->buf;
 	struct vprbrd_i2c_status *smsg = (struct vprbrd_i2c_status *)vb->buf;
 
-	dev_dbg(&i2c->dev, "master xfer %d messages:\n", num);
-
 	for (i = 0 ; i < num ; i++) {
 		pmsg = &msgs[i];
 
@@ -345,8 +343,8 @@ static u32 vprbrd_i2c_func(struct i2c_adapter *i2c)
 
 /* This is the actual algorithm we define */
 static const struct i2c_algorithm vprbrd_algorithm = {
-	.master_xfer	= vprbrd_i2c_xfer,
-	.functionality	= vprbrd_i2c_func,
+	.xfer = vprbrd_i2c_xfer,
+	.functionality = vprbrd_i2c_func,
 };
 
 static const struct i2c_adapter_quirks vprbrd_quirks = {
@@ -460,6 +458,6 @@ static void __exit vprbrd_i2c_exit(void)
 module_exit(vprbrd_i2c_exit);
 
 MODULE_AUTHOR("Lars Poeschel <poeschel@lemonage.de>");
-MODULE_DESCRIPTION("I2C master driver for Nano River Techs Viperboard");
+MODULE_DESCRIPTION("I2C controller driver for Nano River Techs Viperboard");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:viperboard-i2c");
-- 
2.43.0


