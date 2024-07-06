Return-Path: <linux-kernel+bounces-243180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBED39292D3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29DC01C20F7B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF53C132494;
	Sat,  6 Jul 2024 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ijjZ2CCp"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E15358ABF
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 11:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720264901; cv=none; b=pjiPGzOfiDLjeacuyIjtcsEEGgoEJIMl3xb8b5V5hr3TEjkxVp7OjLCIwJEycXRtZea9gAvEzx8rYke1CxlHc0oAGgUsdDCP8qyjGTiw0VJW8IPH80YuI8ygT41ivon2BLm8MYL4iN0ZibKPCpglSTuOvJKibyOHuotIcle7+sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720264901; c=relaxed/simple;
	bh=OX9CjYRsfJ22YYXwzBRTLJyGxtenvozbtleXFhMnIP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VEIqLMBDAtoasBRgOHC6ZpYTTkxIARh5rDZ3Yn1kJ2yLMUDuLUoh15/32SnpiGyu0fclqDJy98afvA3FIi2jdhC18wLO7Fq6lwH6l0osuL2XXig2tOf+7FOK36OQn4kWrfRRxsNajSBxEnAxX9Zr9GoAkXGda4ljEq4fEWEuKN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ijjZ2CCp; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=+cVn6HCJi9F61+sEb1wYIiiZCk6zR3MKCVcbdGfMsoA=; b=ijjZ2C
	CpVFTNHD/mz72bK98pUY287VltQbhGcOEdB3mobuPV3XiWokp+6k59EWniRbAihG
	102sHRy1IJsvu8ErQ+sfBUlbErtTIetQcTNqim3AC77qJ7CKxEPPqv+9Z92Q0Fac
	Fjo3w1yrTs65Zs0zjB+75yc667NA0cxGCL23UUmb6LxFeeFLrocWMbtNnixptLb/
	TG7KOfbLpymsAYfuNaKrytxqPD1yC8vZ/8dRs25BV+W/Ez+76pFN2c15h0oSDJ58
	4+cMhifuvoZBoBwpaCly8akz5E0itiDY+zUWE2F7GSmB9ye82MUtsHvI6UrnrnSq
	WoAaPZ3alBW92F8Q==
Received: (qmail 3809506 invoked from network); 6 Jul 2024 13:21:24 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Jul 2024 13:21:24 +0200
X-UD-Smtp-Session: l3s3148p1@18NXYZIcxNJQT+F6
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Thor Thayer <thor.thayer@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/60] i2c: altera: reword according to newest specification
Date: Sat,  6 Jul 2024 13:20:03 +0200
Message-ID: <20240706112116.24543-4-wsa+renesas@sang-engineering.com>
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
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
---
 drivers/i2c/busses/i2c-altera.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-altera.c b/drivers/i2c/busses/i2c-altera.c
index 252fbd175fb1..f4dde08a3b92 100644
--- a/drivers/i2c/busses/i2c-altera.c
+++ b/drivers/i2c/busses/i2c-altera.c
@@ -168,7 +168,7 @@ static void altr_i2c_init(struct altr_i2c_dev *idev)
 	/* SDA Hold Time, 300ns */
 	writel(3 * clk_mhz / 10, idev->base + ALTR_I2C_SDA_HOLD);
 
-	/* Mask all master interrupt bits */
+	/* Mask all interrupt bits */
 	altr_i2c_int_enable(idev, ALTR_I2C_ALL_IRQ, false);
 }
 
@@ -376,7 +376,7 @@ static u32 altr_i2c_func(struct i2c_adapter *adap)
 }
 
 static const struct i2c_algorithm altr_i2c_algo = {
-	.master_xfer = altr_i2c_xfer,
+	.xfer = altr_i2c_xfer,
 	.functionality = altr_i2c_func,
 };
 
-- 
2.43.0


