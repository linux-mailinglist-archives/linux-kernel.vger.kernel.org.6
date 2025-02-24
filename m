Return-Path: <linux-kernel+bounces-529508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DB5A42730
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218A93B3ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AC526139D;
	Mon, 24 Feb 2025 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="aa/+cF1b"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A171EA7CD;
	Mon, 24 Feb 2025 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412517; cv=none; b=GmeEVmHU8+9uOh/JalYoR7GD8iUHp+0JxGyRxEe8P3fsZHIIyQ5Pd8p38D0diXh2dlgK16R0xIkqv4JMoBw8fCcM4flYprXWSR1uKWtP7YIsVBQSGK+F/5kGXGyM6aPGgxS1OYgvG691YtGOYx91L8fkIHBlH16YU1IF+2wZ0A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412517; c=relaxed/simple;
	bh=A3qeEz+9pLV6QWWtw7xiBTAslbXrwAaEOhYqq/vovyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u8Dikkq0Nd92Pd34lzl36yh0CGYzCZNIV3DFaZmamWujLLtW8ddVbJ+aDal/ZYufCp+ZUnIHoBgIt/own7frsnR27+j+nAqIVvKdACZOPn4IzCUEieQMf3cA4xIYaxzvmlir/QN0O37pKmrtPbRcQgM+WAXlwq9MuDs66nzA7/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=aa/+cF1b; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 54C9B1FB63;
	Mon, 24 Feb 2025 16:55:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1740412506;
	bh=cG2KL1C+siT8fcv/SCw1v2VQ+ORDUJNO06IZ2DBqSNc=; h=From:To:Subject;
	b=aa/+cF1bS+TAxNTMIjCFxFsCGTFrJnkEvxGjgXyVS/slaolBetxQWlYlZWtur/UXk
	 9EojtW1nZ7PDFre0HYm0Whu/jkzNwJ4PWbnvry0tL7rLMlef2YBCYzlWBdeIuHjXjQ
	 6k7lZ20WKVaGEVYtgKxDh8qvcLeJV9BNPyp4osYi0aEIdJyGLN6ZDweQROnvgIrruq
	 5gLjyHwgom/vXnyRqI+rv2u36zkE/LbNHMz87ayQJFuuh1u81u36awdrCrIiu/ih4i
	 DnSANLgnh8QMsRPe6BeB4ARvYlJ7vI8spCNChcpcJibZ9VGvR15n1XrZDbYFI9UT3X
	 dRuCc7P1SEzaw==
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
Subject: [PATCH v2 2/5] ASoC: wm8904: Don't touch GPIO configs set to 0xFFFF
Date: Mon, 24 Feb 2025 16:54:57 +0100
Message-Id: <20250224155500.52462-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224155500.52462-1-francesco@dolcini.it>
References: <20250224155500.52462-1-francesco@dolcini.it>
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


