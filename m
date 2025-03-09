Return-Path: <linux-kernel+bounces-553295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F02FA5870F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02990188B8DF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9672135AB;
	Sun,  9 Mar 2025 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="oGpco80+"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00431F4CB4;
	Sun,  9 Mar 2025 18:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544200; cv=none; b=coMboosqOPVv4inimj+uq8ySFPsXZYW+85JaKTiFJpNPy14Zl1Rh4KeGs1bSFHYADzSQV0JpS9z8+azS9lcQbkwoW3tcvHHPblMO+IJSCxX1H8dRtEto4awFQUENOkH8oYWSZhWnDvq7EHtsZZw24IACj+PyAJNhFBC4MbmEUOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544200; c=relaxed/simple;
	bh=lfFN7Dt8QPuDyo6K8aPY6I+2L5WQNxo7eEeXPSz7AAs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GFm+Ryc0F/bp+OpaQt48uF8fnD6S+TrVXRPlvjx//3pZvt2Xx6oOwBSgeCIFCgDAiftYOSs212QN6PtKGDwNTppA/BLfrcjA7N3OWdPdnq2hIPNW6xmIHudCTQxyNNFPVyJy4fBYkNyHw/EvKMVJ0zYraDB/YBxPyMh5MRhrNmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=oGpco80+; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id CFD9F100006;
	Sun,  9 Mar 2025 21:16:36 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru CFD9F100006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1741544196;
	bh=FOhTJF1m94YRb8vnMnDJmrMMQMYxHqwVlUi4dxU65dc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=oGpco80+PNb7jQKyS/TEc9NqqxkVvP5L98kQxSa3eUuFNHS5bY/tivxT8x0c4tAaj
	 hpg4urBMiHK4CVU0tvm93v6j691GJATzuTgpd4bDKfXEkvWQ6k6oASrIrKLvfdiU3n
	 WTA6zBugdfrbaJ8lq6ncFOrjr2fMkWw4Ptwp2hG0tmFOwK/J5OgkZnZ/Mak5Lwm6dk
	 NHImZZH5Vd3zWDN0WdZb1ZgAdXQLma84CG5CoK/nIy/3QbYT1If0eLQ7McJ75vXSa/
	 jxjSJFMun+Jd+XBwXLB0WxEzW67cyDB7oHqpq4uRpbvyZRpdUXrrIMwYCNPKQuO6Cv
	 UNOVNQ+kierAA==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun,  9 Mar 2025 21:16:36 +0300 (MSK)
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Conor Dooley
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman
	<khilman@baylibre.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, Takashi Iwai
	<tiwai@suse.com>
Subject: [PATCH v2 1/3] ASoC: meson: t9015: prepare to adding new platforms
Date: Sun, 9 Mar 2025 21:16:28 +0300
Message-ID: <20250309181630.1322745-2-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309181630.1322745-1-jan.dakinevich@salutedevices.com>
References: <20250309181630.1322745-1-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 191599 [Mar 09 2025]
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_smtp_not_equal_from}, 127.0.0.199:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, FromAlignment: n
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/03/09 17:28:00 #27692143
X-KSMG-AntiVirus-Status: Clean, skipped

Move platform specific code to make the reading of upcoming commit
easier.

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 sound/soc/meson/t9015.c | 71 ++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 23 deletions(-)

diff --git a/sound/soc/meson/t9015.c b/sound/soc/meson/t9015.c
index a80e9c9d6288..919a2413038d 100644
--- a/sound/soc/meson/t9015.c
+++ b/sound/soc/meson/t9015.c
@@ -51,6 +51,12 @@ struct t9015 {
 	struct regulator *avdd;
 };
 
+struct t9015_match_data {
+	const struct snd_soc_component_driver *component_drv;
+	struct snd_soc_dai_driver *dai_drv;
+	unsigned int max_register;
+};
+
 static int t9015_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_component *component = dai->component;
@@ -112,6 +118,11 @@ static SOC_ENUM_SINGLE_DECL(dacl_in_enum, BLOCK_EN, DACL_SRC, dacl_in_txt);
 static const char * const mono_txt[] = { "Stereo", "Mono"};
 static SOC_ENUM_SINGLE_DECL(mono_enum, VOL_CTRL1, DAC_MONO, mono_txt);
 
+static const struct snd_kcontrol_new t9015_right_dac_mux =
+	SOC_DAPM_ENUM("Right DAC Source", dacr_in_enum);
+static const struct snd_kcontrol_new t9015_left_dac_mux =
+	SOC_DAPM_ENUM("Left DAC Source", dacl_in_enum);
+
 static const struct snd_kcontrol_new t9015_snd_controls[] = {
 	/* Volume Controls */
 	SOC_ENUM("Playback Channel Mode", mono_enum),
@@ -126,11 +137,6 @@ static const struct snd_kcontrol_new t9015_snd_controls[] = {
 	SOC_SINGLE("Unmute Ramp Switch", VOL_CTRL1, UNMUTE_MODE, 1, 0),
 };
 
-static const struct snd_kcontrol_new t9015_right_dac_mux =
-	SOC_DAPM_ENUM("Right DAC Source", dacr_in_enum);
-static const struct snd_kcontrol_new t9015_left_dac_mux =
-	SOC_DAPM_ENUM("Left DAC Source", dacl_in_enum);
-
 static const struct snd_soc_dapm_widget t9015_dapm_widgets[] = {
 	SND_SOC_DAPM_AIF_IN("Right IN", NULL, 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("Left IN", NULL, 0, SND_SOC_NOPM, 0, 0),
@@ -223,7 +229,20 @@ static int t9015_set_bias_level(struct snd_soc_component *component,
 	return 0;
 }
 
+static int t9015_component_probe(struct snd_soc_component *component)
+{
+	/*
+	 * Initialize output polarity:
+	 * ATM the output polarity is fixed but in the future it might useful
+	 * to add DT property to set this depending on the platform needs
+	 */
+	snd_soc_component_write(component, LINEOUT_CFG, 0x1111);
+
+	return 0;
+}
+
 static const struct snd_soc_component_driver t9015_codec_driver = {
+	.probe			= t9015_component_probe,
 	.set_bias_level		= t9015_set_bias_level,
 	.controls		= t9015_snd_controls,
 	.num_controls		= ARRAY_SIZE(t9015_snd_controls),
@@ -235,22 +254,25 @@ static const struct snd_soc_component_driver t9015_codec_driver = {
 	.endianness		= 1,
 };
 
-static const struct regmap_config t9015_regmap_config = {
-	.reg_bits		= 32,
-	.reg_stride		= 4,
-	.val_bits		= 32,
-	.max_register		= POWER_CFG,
-};
-
 static int t9015_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	const struct t9015_match_data *data;
 	struct t9015 *priv;
 	void __iomem *regs;
+	struct regmap_config config = {
+		.reg_bits = 32,
+		.reg_stride = 4,
+		.val_bits = 32,
+	};
 	struct regmap *regmap;
 	struct clk *pclk;
 	int ret;
 
+	data = device_get_match_data(dev);
+	if (!data)
+		dev_err_probe(dev, -ENODEV, "failed to match device\n");
+
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -276,25 +298,28 @@ static int t9015_probe(struct platform_device *pdev)
 		return PTR_ERR(regs);
 	}
 
-	regmap = devm_regmap_init_mmio(dev, regs, &t9015_regmap_config);
+	config.max_register = data->max_register;
+	regmap = devm_regmap_init_mmio(dev, regs, &config);
 	if (IS_ERR(regmap)) {
 		dev_err(dev, "regmap init failed\n");
 		return PTR_ERR(regmap);
 	}
 
-	/*
-	 * Initialize output polarity:
-	 * ATM the output polarity is fixed but in the future it might useful
-	 * to add DT property to set this depending on the platform needs
-	 */
-	regmap_write(regmap, LINEOUT_CFG, 0x1111);
-
-	return devm_snd_soc_register_component(dev, &t9015_codec_driver,
-					       &t9015_dai, 1);
+	return devm_snd_soc_register_component(dev, data->component_drv,
+					       data->dai_drv, 1);
 }
 
+static const struct t9015_match_data t9015_match_data = {
+	.component_drv = &t9015_codec_driver,
+	.dai_drv = &t9015_dai,
+	.max_register = POWER_CFG,
+};
+
 static const struct of_device_id t9015_ids[] __maybe_unused = {
-	{ .compatible = "amlogic,t9015", },
+	{
+		.compatible = "amlogic,t9015",
+		.data = &t9015_match_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, t9015_ids);
-- 
2.34.1


