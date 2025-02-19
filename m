Return-Path: <linux-kernel+bounces-521348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13751A3BC0E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070021771A0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368E21DE4D4;
	Wed, 19 Feb 2025 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X/ZfTCbq"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467B215B971
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 10:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962386; cv=none; b=GZBx6EWXczatmRGbkEg+Yu7Xs87zxejxxAx/7inV6LVgFDq8LSdt7XjJCnW82Q6Z6F+eqG3gDg82AcixUtfeM/1dGcUNBznjx0Uab1w0UVC1V302gA4aZsTvVrLRnX+Bsi8mCaqB/wd4ANp+KAx724gxTwdjEAvh43zoVrMcGt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962386; c=relaxed/simple;
	bh=oi7lV/lrHT+EHF4OxEPCf+t4jtrbHvMpeUS9/w8MW9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hIHQN/HuR4MFp4kXGUAQ+M3xrTo2FiX1s9J/7y6sfkos5o5toYDwqFtCXrOtymELvqeivmGWuQSmvxB8jnNBTBqMLH2d2XVf13CrfV54WFTWHM51UASwKk5lXgRIEC/RlFEh39dNxjNn2Lf3cT0QrO4wT0lty15T7FWYGHrT15Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X/ZfTCbq; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739962371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hR+XlzJzGTiqSgbWiAdN0TiNYvqq5BOnYBxudITTpnY=;
	b=X/ZfTCbqt8S3TXgZWPaB5DTi2BMriADAuNdAmmOfqz6vNjEgFRcubn/nS/q4rR5USNFtAm
	0VEUX4prAFXyh4jxWaccIySk1RN8TTUc1g+pwa963SY4VRpDkFxGHfMYGBjPrSUqbsa12L
	RVTP6JOjaNuVaRTCtMro/vUBUNwITOI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] sbus: envctrl: Fix typo in comment
Date: Wed, 19 Feb 2025 11:52:33 +0100
Message-ID: <20250219105236.1736-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

s/disinguish/distinguish/

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/sbus/char/envctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
index 81918aa67109..69e49da93b8b 100644
--- a/drivers/sbus/char/envctrl.c
+++ b/drivers/sbus/char/envctrl.c
@@ -734,7 +734,7 @@ static void envctrl_set_mon(struct i2c_child_t *pchild,
 {
 	/* Firmware only has temperature type.  It does not distinguish
 	 * different kinds of temperatures.  We use channel description
-	 * to disinguish them.
+	 * to distinguish them.
 	 */
 	if (!(strcmp(chnl_desc,"temp,cpu")) ||
 	    !(strcmp(chnl_desc,"temp,cpu0")) ||
-- 
2.48.1


