Return-Path: <linux-kernel+bounces-542846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4134FA4CE67
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD47173A69
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 22:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33700239585;
	Mon,  3 Mar 2025 22:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Rpblhqao"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988A422DFB6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 22:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741041405; cv=none; b=SGxcXY7XUbmBFwZ18GuFaTA9/NBrbfWeNYzhso70bhLq4yNJ2mSrRRja6e6xtyAyDFLOagTO7FFmOtNUHqAeKfBj8PZJ9nmGwJFUiHbvzjEh0pNGY0nbqDiWW9VGPmtrK8DvmQ5ai3Z8gTxRlTxrd8JRnuoz/kIK/66h20x8ikQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741041405; c=relaxed/simple;
	bh=yjhdlITOXY603XJTSLK2Nfm0O6a5v0EnDBsDSH4BAEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e3XSq2Wf/eZ7F+lj7UFt1ygNq81D1JXlf9JvuTGk0G2/ivq1WGZ3+0XFmxIvZt5CtifvK2w1F9dF0v1OOr2v30ghe0vmQZ9keykTSSOHsyB68RMKFfk1fpsb2JI5ba9FYhc835R7qs+5XUZ2p+5ll1vSvpCXuQ9DbV6e4D2jheA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Rpblhqao; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1A22F433EC;
	Mon,  3 Mar 2025 22:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741041401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DsWrwEPA0jf6ymSLm56xpLPPzeLpifAMOAkYO6Yfc2c=;
	b=Rpblhqao8kf5CWt6HF8hM5sP3Tvdp8xstZXn92PJGdHbs3OyuH9BEap43QkIEf5cJCeUMX
	stpwL9vYoSsajgkyN0q8uKU1ulrJh5C5K+bm5uGD89KXVsb0CMQqKL4WrqIR1PgRTrZVql
	MJSscjUf4FKka+jA5tr4Z/9a7pFYRgALMuo+4vMqCJRKF2x8fJextvyPR9EDVwyU2cOoMj
	/vyfOVZsIfaK/h3Z5p7WkogAslqAC5ycYNIgXcGf5QE2LQmrrFxTpQTPIpek/XxM4SxAH7
	fpDYx1s78NIu0Y9Xr7C8q97VYQ7PyeZ5CpC6Py0H7OpawQtbSywUmJhcDDGhsQ==
From: alexandre.belloni@bootlin.com
To: Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] rtc: mt6397: drop unused defines
Date: Mon,  3 Mar 2025 23:36:37 +0100
Message-ID: <20250303223637.1135362-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtfeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmnecuggftrfgrthhtvghrnhepgedtffeugeeftedtfffhiedtjeefieeuveelffetledvueeludeggedtjefgveevnecukfhppeejjedrudehtddrvdegiedrvdduheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeejjedrudehtddrvdegiedrvdduhedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepjedprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghtthhhihgrshdrsghgghesghhmrghilhdrtghomhdprhgtphhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtoheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgv
 ghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhmvgguihgrthgvkheslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
X-GND-Sasl: alexandre.belloni@bootlin.com

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

RTC_NUM_YEARS has never been used, the other defines are not used since
commit 34bbdc12d04e ("rtc: mt6359: Add RTC hardware range and add support
for start-year")

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 include/linux/mfd/mt6397/rtc.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/mfd/mt6397/rtc.h b/include/linux/mfd/mt6397/rtc.h
index 068ae1c0f0e8..27883af44f87 100644
--- a/include/linux/mfd/mt6397/rtc.h
+++ b/include/linux/mfd/mt6397/rtc.h
@@ -60,11 +60,6 @@
 #define RTC_PDN2               0x002e
 #define RTC_PDN2_PWRON_ALARM   BIT(4)
 
-#define RTC_MIN_YEAR           1968
-#define RTC_BASE_YEAR          1900
-#define RTC_NUM_YEARS          128
-#define RTC_MIN_YEAR_OFFSET    (RTC_MIN_YEAR - RTC_BASE_YEAR)
-
 #define MTK_RTC_POLL_DELAY_US  10
 #define MTK_RTC_POLL_TIMEOUT   (jiffies_to_usecs(HZ))
 
-- 
2.48.1


