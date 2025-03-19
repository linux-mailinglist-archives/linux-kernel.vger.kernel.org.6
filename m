Return-Path: <linux-kernel+bounces-568164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE420A68EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6128E887FF5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8521C7013;
	Wed, 19 Mar 2025 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Jibu6CaD"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5365C14B950;
	Wed, 19 Mar 2025 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394070; cv=none; b=Tq08MZIpLtlYTxdJJCrqy0JEtj0PBu+CuBkGDEjxUrZtB76IsmYWdq8OkKL1W+JDJQ65fJch1WdV670fGdhmt/2VoPD34UVg/JNKSHwtbk4UVF1UudPFEMWnsLRL3vtO8kdtH5/WWCHKCp3641EKj114audBPDFmeIOQZnbaSLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394070; c=relaxed/simple;
	bh=FQxRNM5XnCtf4UMQ+MfLlmdP6dCYsJNtxEj4OuhWFqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lcZLVahosNqo/8+jcCuo1rM4AmL8GhkSMWrB01jpC1cMq3HjPQaOfMwpd5ozts+yygj4qn0XHxamkXF4Nl57idyr7kb/hACo8SnAmuqpuWPxnEKXgILLb1t36HCrXsVKcMC3UK7BKYMVHfAVfo1ZAjx4QRlo2aEs0CBKnaNvoyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Jibu6CaD; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id D7D1023520;
	Wed, 19 Mar 2025 15:21:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1742394066;
	bh=5+MRCcfCqueOSg83ou2BCANGo2BO9TTreKrGyAQvogM=; h=From:To:Subject;
	b=Jibu6CaDGtPoGmax0X9mlnvyU2LfvT6GxCB+vOiLhoWxHa4kL1B45A8J+Uk8f+OYS
	 mcgSpzmodbrtDD7Q2lDRAmJw7YNUoXkba8MCzi9mMqpUp/D5jcvzv0fd45dwFO1apw
	 EG8pLqWwIoU4WzNb72GtEQD/zYBbodW8gxjQdjjEva+Cbhb4AAZuH5Z0LxLO/wsJhk
	 00lUgKwiiu/eY7cxjZVQpsW7ENYzbLlwks0TisR6tYBHCYeDYAm7sDuv6BsxXToVss
	 s6PllA4/hTk4xUNSxt/lho+EOocRAM+COT9Bh7Dqra1g19SEVdw6Kw3oEa0QVTBCKk
	 mnOGFgDrP1ZMw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	patches@opensource.cirrus.com
Cc: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v4 2/5] ASoC: wm8904: Don't touch GPIO configs set to 0xFFFF
Date: Wed, 19 Mar 2025 15:20:56 +0100
Message-Id: <20250319142059.46692-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250319142059.46692-1-francesco@dolcini.it>
References: <20250319142059.46692-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

When updating the GPIO registers, do nothing for all fields of gpio_cfg
that are "0xFFFF".

This "do nothing" flag used to be 0 to easily check whether the gpio_cfg
field was actually set inside pdata or left empty (default).

However, 0 is a valid configuration for these registers, while 0xFFFF is
not.

With this change, users can explicitly set them to 0.
Not setting gpio_cfg in the platform data will now lead to setting all
GPIO registers to 0 instead of leaving them unset.

No one is using this platform data with this codec.

The change gets the driver ready to properly set gpio_cfg from the DT.

Datasheet: https://statics.cirrus.com/pubs/proDatasheet/WM8904_Rev4.1.pdf
Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
v4: no changes
v3: no changes
v2: no changes
v1: https://lore.kernel.org/lkml/20250206163152.423199-3-francesco@dolcini.it/
---
 sound/soc/codecs/wm8904.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index aef82532f8cf..2082ff12d336 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -2270,7 +2270,8 @@ static int wm8904_i2c_probe(struct i2c_client *i2c)
 	/* Apply configuration from the platform data. */
 	if (wm8904->pdata) {
 		for (i = 0; i < WM8904_GPIO_REGS; i++) {
-			if (!wm8904->pdata->gpio_cfg[i])
+			/* 0xFFFF in this config means "don't touch" */
+			if (wm8904->pdata->gpio_cfg[i] == 0xffff)
 				continue;
 
 			regmap_update_bits(wm8904->regmap,
-- 
2.39.5


