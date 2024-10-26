Return-Path: <linux-kernel+bounces-383387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A35019B1AF4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 22:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69764282336
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 20:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747F51D86E4;
	Sat, 26 Oct 2024 20:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="e0K3HdA3"
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD89713A3E4;
	Sat, 26 Oct 2024 20:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729975681; cv=none; b=FetPxIMTi4S7RLsxq1BNlbbKCjxGuiNgUl//ZUUDl/zpwQzeKCmaYZPnW1mx0nYhnbvINOdENBH+aqPPqZFi7dtXgyopfNyuO7E4XnhDAn+8GO/V03ZBW7iN+MEEXzc7VUP7n0Chi5jS2tRjiGZ6rw2Fll1RKASPNdHmXOPcHSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729975681; c=relaxed/simple;
	bh=9FnWgsJSEVlXkZ1wLr3Wk4xUL0/ToS9bimclA0M8yXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SHu7mnRi1Nx9DvYrujnBybpse4Tq5lw0BYB95NCetj+196hf/rWxnZgr9Z7756k3kiLtGItb+qDmQqJ7jl9g4eR1ypclfhYzxPwqHDB9WzLBcCNrrkMA72QWmN65JZ45pPBl7iTc3j4W7geAh+BtKfmyOi1igEaylR0mYN4zfSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=e0K3HdA3; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 4ngLthueQ3B144ngMtGJoH; Sat, 26 Oct 2024 22:46:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1729975607;
	bh=jf1SaVNmJGrG77cLP6KwHHPTkgsjA5JbYdn77mtkQQQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=e0K3HdA3ZYu5Sps9ixCm3mKULZIN/4YcphUkfru8baAJzYuLfiSlKsUI33LJ0cPZS
	 /KfdLXGvRZ6itnJdm0axux2np6ho7nsAIHgR3w1eFgiAR4pn97sbSPIJXaW4j3D3RK
	 Gwbei18C6OruTpp6LbjSpqkR4QX/ZDcZ2atUlGkkGY1ADfVBetZ5SThS9Bfm2f3t5/
	 gc/A+17GjG2JEygpi3eTSRB/y1oM3UDeoxT4W5Nvwh62C1iwz08ny6xLxc7mnwq+Pe
	 ykB1jAGVZS97AKNy8PEFz9v7t8uxv8lWBM91MdrPQffnvGWe9Yqcg6kfYFvgnaFnuM
	 PrEY7asTZxvqA==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 26 Oct 2024 22:46:47 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Olivier Moysan <olivier.moysan@st.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: [PATCH] ASoC: cs42l51: Fix some error handling paths in cs42l51_probe()
Date: Sat, 26 Oct 2024 22:46:34 +0200
Message-ID: <a5e5f4b9fb03f46abd2c93ed94b5c395972ce0d1.1729975570.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If devm_gpiod_get_optional() fails, we need to disable previously enabled
regulators, as done in the other error handling path of the function.

Also, gpiod_set_value_cansleep(, 1) needs to be called to undo a
potential gpiod_set_value_cansleep(, 0).
If the "reset" gpio is not defined, this additional call is just a no-op.

This behavior is the same as the one already in the .remove() function.

Fixes: 11b9cd748e31 ("ASoC: cs42l51: add reset management")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 sound/soc/codecs/cs42l51.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index e4827b8c2bde..6e51954bdb1e 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -747,8 +747,10 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 
 	cs42l51->reset_gpio = devm_gpiod_get_optional(dev, "reset",
 						      GPIOD_OUT_LOW);
-	if (IS_ERR(cs42l51->reset_gpio))
-		return PTR_ERR(cs42l51->reset_gpio);
+	if (IS_ERR(cs42l51->reset_gpio)) {
+		ret = PTR_ERR(cs42l51->reset_gpio);
+		goto error;
+	}
 
 	if (cs42l51->reset_gpio) {
 		dev_dbg(dev, "Release reset gpio\n");
@@ -780,6 +782,7 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 	return 0;
 
 error:
+	gpiod_set_value_cansleep(cs42l51->reset_gpio, 1);
 	regulator_bulk_disable(ARRAY_SIZE(cs42l51->supplies),
 			       cs42l51->supplies);
 	return ret;
-- 
2.47.0


