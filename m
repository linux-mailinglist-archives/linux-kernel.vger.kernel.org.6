Return-Path: <linux-kernel+bounces-572241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7DCA6C824
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 08:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D660B189F5DD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 07:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141B91C84C4;
	Sat, 22 Mar 2025 07:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="lwja6jsP"
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAD242052;
	Sat, 22 Mar 2025 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742629636; cv=none; b=aRCytsDBQ82h8r6nsE8VspB0rWTYT33wGcq0sqFHXhCrbioja8bq9WCHdGIcsPqsDKvrVBsW5dgcFPYlaDpOkuqDtIJGImsp4Va58e8jCbhvPoB5td1dgc5dPrLyv/rWd8dQdY7zXIzmf+8UpduqU3SY85RJ32y1fJdG3krpNPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742629636; c=relaxed/simple;
	bh=UHZUiU7dX/pHyv2rf9ZLUJy55sZsJfVgQiY2q7zHZ4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pzbRJ9ppgsaQjt/s/l9NyDXw/mwEytuMjYpwvseXaCcQrogLxxtzfVYAtRi1bKIGng5zH2lbN9GchJDMXbmp0LCdRj0sFAQoDd7VxYPiBYPGoTZl+EwUuQUO6LqEAtRG5NPKe1gpApV3RoRSH5vewkIzdi/lMOhvWdTjILnuUcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=lwja6jsP; arc=none smtp.client-ip=80.12.242.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id vtYItzm9oIuduvtYLtKJNN; Sat, 22 Mar 2025 08:45:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1742629558;
	bh=uUTkOo9pR0pRDuNpO1u/nY/LzT8p5BQ72XTrVx+PzRg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=lwja6jsP0K9ctAIcLIPFCWAzjNXFLhgavOlijF0hQ8QlXi3BYwl529X2dTnmne593
	 4xt9F1vw2orB8xd1SijYGg7qVb9kd4LkWGwruocfSj/U9ZtwxA6of80IW2tTXjAJQ6
	 pJH/RFNMiwOGy3aieYGhwWidjSeyZqskcNMZvU2Gu9IahXywx5HouZNoepUSki8Qaw
	 9zZ0JtfB1UY7Z5//Y4uZnj5s8jpuJKNxxGRE5tbp8OrmkF5URjyYLXgNk2BRvVKk0K
	 F6BmXZGRIiKA+3YNRjlViUL68QxClyDv8dvc7WYYBH8u+J1LJQF4U9mj4al+ev7AhM
	 zhU8CkAT3w1NA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 22 Mar 2025 08:45:58 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <bardliao@realtek.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-sound@vger.kernel.org
Subject: [PATCH] ASoC: codecs: rt5665: Fix some error handling paths in rt5665_probe()
Date: Sat, 22 Mar 2025 08:45:49 +0100
Message-ID: <e3c2aa1b2fdfa646752d94f4af968630c0d58248.1742629525.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Should an error occur after a successful regulator_bulk_enable() call,
regulator_bulk_disable() should be called, as already done in the remove
function.

Instead of adding an error handling path in the probe, switch from
devm_regulator_bulk_get() to devm_regulator_bulk_get_enable() and
simplify the remove function and some other places accordingly.

Finally, add a missing const when defining rt5665_supply_names to please
checkpatch and constify a few bytes.

Fixes: 33ada14a26c8 ("ASoC: add rt5665 codec driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 sound/soc/codecs/rt5665.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index e0d1991cffdb..bcb6d7c6f301 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -31,9 +31,7 @@
 #include "rl6231.h"
 #include "rt5665.h"
 
-#define RT5665_NUM_SUPPLIES 3
-
-static const char *rt5665_supply_names[RT5665_NUM_SUPPLIES] = {
+static const char * const rt5665_supply_names[] = {
 	"AVDD",
 	"MICVDD",
 	"VBAT",
@@ -46,7 +44,6 @@ struct rt5665_priv {
 	struct gpio_desc *gpiod_ldo1_en;
 	struct gpio_desc *gpiod_reset;
 	struct snd_soc_jack *hs_jack;
-	struct regulator_bulk_data supplies[RT5665_NUM_SUPPLIES];
 	struct delayed_work jack_detect_work;
 	struct delayed_work calibrate_work;
 	struct delayed_work jd_check_work;
@@ -4471,8 +4468,6 @@ static void rt5665_remove(struct snd_soc_component *component)
 	struct rt5665_priv *rt5665 = snd_soc_component_get_drvdata(component);
 
 	regmap_write(rt5665->regmap, RT5665_RESET, 0);
-
-	regulator_bulk_disable(ARRAY_SIZE(rt5665->supplies), rt5665->supplies);
 }
 
 #ifdef CONFIG_PM
@@ -4758,7 +4753,7 @@ static int rt5665_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt5665_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt5665_priv *rt5665;
-	int i, ret;
+	int ret;
 	unsigned int val;
 
 	rt5665 = devm_kzalloc(&i2c->dev, sizeof(struct rt5665_priv),
@@ -4774,24 +4769,13 @@ static int rt5665_i2c_probe(struct i2c_client *i2c)
 	else
 		rt5665_parse_dt(rt5665, &i2c->dev);
 
-	for (i = 0; i < ARRAY_SIZE(rt5665->supplies); i++)
-		rt5665->supplies[i].supply = rt5665_supply_names[i];
-
-	ret = devm_regulator_bulk_get(&i2c->dev, ARRAY_SIZE(rt5665->supplies),
-				      rt5665->supplies);
+	ret = devm_regulator_bulk_get_enable(&i2c->dev, ARRAY_SIZE(rt5665_supply_names),
+					     rt5665_supply_names);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
 		return ret;
 	}
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(rt5665->supplies),
-				    rt5665->supplies);
-	if (ret != 0) {
-		dev_err(&i2c->dev, "Failed to enable supplies: %d\n", ret);
-		return ret;
-	}
-
-
 	rt5665->gpiod_ldo1_en = devm_gpiod_get_optional(&i2c->dev,
 							"realtek,ldo1-en",
 							GPIOD_OUT_HIGH);
-- 
2.49.0


