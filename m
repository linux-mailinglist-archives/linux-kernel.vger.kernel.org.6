Return-Path: <linux-kernel+bounces-243227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FA592933B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014161F22523
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE736178380;
	Sat,  6 Jul 2024 11:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="i2FX1UCT"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390B516B38E
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 11:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720264940; cv=none; b=MeW6fVB6yyMNqlyEwVMVV+mBPY5TuxJHRRTiWPnzwIAzQbONJalUOXZ39C6Nc2oifytw1tHEIRJeffRis/7/Bf7TZ6r/VlwV4c5XDU6H1Tlhoczq2wXa3gIu5SqHeGbUDvAeWrIjw29Urt9wEqMVSoaZVjqmqOHnV551qoHgZg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720264940; c=relaxed/simple;
	bh=ay0NNYp6uB+Hzz66hQmEVe14Hbw3ALbsqZ22fhHX/ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5apHSoZoqCilL19C/hrYuG8oTVXygTO+LoUcXEtni6891yc9c9uh2NteTJnjDu6k84ykXQ9HI/EHmmLE9N9/AO6Ew/xPY3JhgL/dMMRMRe3Af0e6roeKWpZIUDkYHjfwTcUHw4Hdk30N0V846gyTQTTaCWJZteORJRiIrLqUhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=i2FX1UCT; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=/7futhidHP5gSersG6I/0JwsF+rinC/q3OXwrLgvIjY=; b=i2FX1U
	CThJagfpuhB9HEIXbAPHzXQKPTA86+2GDZY5JSShYE/8EwJGbEz5fzXO8/+4Uncm
	YyejBkkdbEI2C9wtliJEG59GuRP52GbU1VfSuijw9Ap2sfj6GtE8zUUlZASt3CJL
	gS6m6BgTlsCdiLY/BubVSLcVgBvE4m4CnYzMZEiUSLRWuf3ZT+OgLU6MN713+p7h
	MnT8IGy7gFDYyln3ns3l+x4wrEWWfKr5xabgf+0Or3Fq7+0pxHj97PuiCR1rwthZ
	vSLmzAAujQeIxrPKDR+1LKfpiHb070i0MFDsoMyX3+rgjT4bDkSKYvlKtePSd48+
	9AiJjDYtdU4RPz3Q==
Received: (qmail 3811008 invoked from network); 6 Jul 2024 13:21:58 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Jul 2024 13:21:58 +0200
X-UD-Smtp-Session: l3s3148p1@XelaY5IcduFQT+F6
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Robert Richter <rric@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 51/60] i2c: thunderx-pcidrv: reword according to newest specification
Date: Sat,  6 Jul 2024 13:20:51 +0200
Message-ID: <20240706112116.24543-52-wsa+renesas@sang-engineering.com>
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
 drivers/i2c/busses/i2c-thunderx-pcidrv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-thunderx-pcidrv.c b/drivers/i2c/busses/i2c-thunderx-pcidrv.c
index 32d0e3930b67..143d012fa43e 100644
--- a/drivers/i2c/busses/i2c-thunderx-pcidrv.c
+++ b/drivers/i2c/busses/i2c-thunderx-pcidrv.c
@@ -72,7 +72,7 @@ static u32 thunderx_i2c_functionality(struct i2c_adapter *adap)
 }
 
 static const struct i2c_algorithm thunderx_i2c_algo = {
-	.master_xfer = octeon_i2c_xfer,
+	.xfer = octeon_i2c_xfer,
 	.functionality = thunderx_i2c_functionality,
 };
 
-- 
2.43.0


