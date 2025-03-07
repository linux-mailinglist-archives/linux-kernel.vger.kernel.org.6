Return-Path: <linux-kernel+bounces-551216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C170A56977
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07813B60E1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B0B21B1B4;
	Fri,  7 Mar 2025 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="itByubjh"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9289321ABDF;
	Fri,  7 Mar 2025 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355579; cv=none; b=Qdnn0biFiVKotqCAVo6ybuohAzbaIA1AjeNZxJxwUBe5GyU9lYirzJQ4oTvBSqxfCqzd/BK3EuWN3gSc7nI4/Lir/O4RqkGaNbgWyMMLTq6yTBB9VZPPSTmPwDghHRWtRwBYMUX1nMtCCDbHyHlAouSC2bx9+Toc3xt4JhXJOJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355579; c=relaxed/simple;
	bh=mCdBI6Z5L3tJDlvHuZWTZkdNcBYoijpcBDElXlPwaiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JD/7VpyT2hXGPicPW4sWd9N0hSFfzzLpluAua/2x0YxYDly8ws6ym/z22GpioJenkPCcS815NSQf5aC9TE2vGqEbqF8Xi5OOcdzVa6QRSNAbk1p3/fXXib9/4S/bs+W14uWHAzavxb3CbFU1WhUBQDaS8OY5F/kC1+nnZZDjgns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=itByubjh; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 61E161FA60;
	Fri,  7 Mar 2025 14:52:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1741355569;
	bh=d+EtShOh6U1fPrC6vMuiKTZrfrypZ+vkeL5O5TLnIQs=; h=From:To:Subject;
	b=itByubjhXldZMafmqazRBaQBwdG+nSBy1VNBgSAb9KQhhAlvchAK5it5TzrljUV+J
	 E4NiiDfv8E4nN3rGPeB/ZgDPAVetSI9meEWX0vhOYM5Iw6Z8SzcoNsVahbM0MQqDKp
	 gmttg+6cnGx5351q+PtcoxfytfMQDd/wqxs/ZGpVXClQW7Q0jDKRypYTAjwEfk+9Mg
	 nu3vBI69iH8quSUJXy6ycK+SzWdnPm7srEy4pWj8eHqVQrZsHkcXpy9crH3AEKn/2N
	 T1rxRbzR3tKSuxWjTnDzVCScalaJdv0egxyoVy8Kha0+8IcH4DSAaRfzOgk4acrkNo
	 z4ZYGK7EWVYHA==
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
Subject: [PATCH v3 2/5] ASoC: wm8904: Don't touch GPIO configs set to 0xFFFF
Date: Fri,  7 Mar 2025 14:52:41 +0100
Message-Id: <20250307135244.100443-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307135244.100443-1-francesco@dolcini.it>
References: <20250307135244.100443-1-francesco@dolcini.it>
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


