Return-Path: <linux-kernel+bounces-409172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFD99C8845
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B96D2820B2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3680B1F8F0B;
	Thu, 14 Nov 2024 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=merzmedtech.de header.i=@merzmedtech.de header.b="OmZE+v/E";
	dkim=pass (1024-bit key) header.d=merzmedtech.de header.i=@merzmedtech.de header.b="Kg6nndgZ"
Received: from mailout03.agenturserver.de (mailout03.agenturserver.de [153.92.196.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933A61F81AB;
	Thu, 14 Nov 2024 11:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=153.92.196.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582097; cv=none; b=JPDQ/ounW5SNTWFSOoukS13jKWlk4VJmmImT8W5lE9sQsyxktjwKoftVLusVCkE5opJf2Y0ql/SKyTg12m2DqWrCHAv7SQQ2k5qa+aJ2MAdyyo5IFK5KhidRp5s12eCbRgxSiR3zh6AsMyL2g5M7vfbQ7xPwLsE88xt6Sclql7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582097; c=relaxed/simple;
	bh=1LqwXNRMQeQh9/IOT33Rg0yODwYJ/vaPYLyvgtvHhQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ihMZlcm5Nmwjo4ANaYLUbwa80uZ3rGgli2RVO/KKPqoHppiBq2mz4VttzHVPRvleCyqSlBSGxBrF2wyeecHPulVN4GbxaMkb2yH2jjN+402I3/UN1kBeUy4NqOh+L0B9dY6fYfjg+Rotsviu8Pe2+MRF4TtVTG2Yv9mI1bW5Q34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merzmedtech.de; spf=pass smtp.mailfrom=merzmedtech.de; dkim=pass (2048-bit key) header.d=merzmedtech.de header.i=@merzmedtech.de header.b=OmZE+v/E; dkim=pass (1024-bit key) header.d=merzmedtech.de header.i=@merzmedtech.de header.b=Kg6nndgZ; arc=none smtp.client-ip=153.92.196.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merzmedtech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merzmedtech.de
Received: from mail03.agenturserver.de (mail03.internal [192.168.51.40])
	by mailout03.agenturserver.de (Postfix) with ESMTP id 0A7C75A13;
	Thu, 14 Nov 2024 12:01:34 +0100 (CET)
Received: from XXX.XXX.XXX.XXX (XXXXX.XX [XXX.XXX.XXX.XXX])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: h.v.raven@merzmedtech.de)
	by mail.agenturserver.de (Postfix) with ESMTPSA id 681636136B;
	Thu, 14 Nov 2024 12:01:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=merzmedtech.de;
	s=agenturserver2048; t=1731582093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yynhzXzdtIkw3UZnXZUYTxOA8YlxAS9zm3bzoAWv2KI=;
	b=OmZE+v/E6zKZOGyH8aBu06//HZ/E1/R72Z5s5wQRunwyZcqtwWH/p9vWyC1PtaACbyOTRu
	9vmxfbPEshxj+A79zyLEG4vIEzplmCq47NykaAaMoFnZTnDElmONLIaGSsY7gdY4o8vBcI
	Ep8tr1rL4od+NYFAZ/tJLR8/1bWxMWL014YVthT/4onVwfYCX1FmECS0TRKmdebPE3Pglz
	nqf9tprmy0vSZJCCG4vtLJM294piC2VNmwq6UAkkM4YkpBQEiXXXKmpHzXVFNBSuA5ZAgx
	VBg1f0KsBk/jKlwux9nAmUKPZNv8hwB7xJSlf/yadkJeG61zaq8WQoqNpCiiMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=merzmedtech.de;
	s=agenturserver; t=1731582093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yynhzXzdtIkw3UZnXZUYTxOA8YlxAS9zm3bzoAWv2KI=;
	b=Kg6nndgZOGytNRlT8i1TUAxHbR7T7kTh2jNkBb6FdBto9VjJ7bb9C+jF762rJKzlqrU9Nc
	XA8UfZ+4m6W3ohLCB4c8A0zsqltMQCG+KJFXCKlEtsBaKkf9eTlbugqMYtHurKsNBUHgQs
	MkZ8E+Fc3wSd4i4TaHOsU3qZjIMtk6Y=
From: "Hendrik v. Raven" <h.v.raven@merzmedtech.de>
Date: Thu, 14 Nov 2024 12:01:25 +0100
Subject: [PATCH v2 1/2] ASoc: simple-mux: add idle-state support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-simple-mux-idle-state-v2-1-a30cb37d2be2@merzmedtech.de>
References: <20241114-simple-mux-idle-state-v2-0-a30cb37d2be2@merzmedtech.de>
In-Reply-To: <20241114-simple-mux-idle-state-v2-0-a30cb37d2be2@merzmedtech.de>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Belloni <aleandre.belloni@bootlin.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, "Hendrik v. Raven" <h.v.raven@merzmedtech.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3916;
 i=h.v.raven@merzmedtech.de; h=from:subject:message-id;
 bh=1LqwXNRMQeQh9/IOT33Rg0yODwYJ/vaPYLyvgtvHhQs=;
 b=owEBzQIy/ZANAwAKAQP8mG1lSaY7AcsmYgBnNdiMkc4Uwx1+3iv9fLWZIcdxNz0csJrkDwaAB
 ENZNiXVfi+JApMEAAEKAH0WIQRfy2xFNGjRY609IOcD/JhtZUmmOwUCZzXYjF8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0NUZDQjZDNDUzNDY
 4RDE2M0FEM0QyMEU3MDNGQzk4NkQ2NTQ5QTYzQgAKCRAD/JhtZUmmO//PD/93ndobBGav+clq5g
 CBfERwX+b6AzKn9tvjV6WUn6WAarDhG9OoiNKHkd4lhLJRu/hkFqrX+ulHeVrgIgD+fnEEJcDZL
 AN8YbvoIK2a54e24MQdvNmEHPCAmPWdot/1icwveAhd5PkYwWoc32bUSyZt3Khfm2Fnq0nNQ4hJ
 o2Mi44ZWW+E77VWqM9a81xFVru4gzEg4ZtLf8HLXTH7LuLfHoC+OjmoB7Drbu03YanvgSMesl+8
 GNNTRuNmZiQulHYZYUQr/PcX4cxrQUTE3AimJWqWrOa3Ln66Moy2ynmQNUvm+u/B4RSHzpQ4vr+
 LmDajezaPNerZ9rayFnNJIkEyWBKmt/BE1GvCymO4+If0QJhSMLNN2nxXmgoW/VyqjBguBaTJw7
 95YjA0n5DKGaJ8Tg14mn5NFfTVdev7uyPpTo2+27Sbm4zyb+5gzW9WUgWrTmUthFAu+Bpn7fgx3
 9gddKhCNvHjxvvZmrhUIg3kQ8qHRhb9etMHNdZCphfk3sESjGfsQ6cgYp1DP1hrv1Lg8LcIT7sS
 NURLfKVsV18yQXPcTITMv8k9nAWbROZVLljPAU34JYfGgLf9quFnKuXUKyxSnSiO2qmNoXOzJ6O
 oVdAHV8UOgf6llttYpOYS/o9eLt0KEYDFkI8WJ6TDuBurQtMgBfZloXP0LI440sVGMwA==
X-Developer-Key: i=h.v.raven@merzmedtech.de; a=openpgp;
 fpr=7A67B9A9F57B4F324AB6B8EB045B81F5FB5BA3AE
X-purgate-original-type: suspect.url-count
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 3918
X-purgate-ID: 155922::1731582093-1D5D8432-844E68A6/2/61233497599

So far the mux changes it state immediately, even when not in use. Allow
overriding this behaviour by specifying an optional idle-state. This
state is used whenever the mux is powered down, only switching to the
selected state on power up. If unspecified it defaults to as-is,
maintaining the previous behaviour.

Signed-off-by: Hendrik v. Raven <h.v.raven@merzmedtech.de>
---
Changes in v2:
- fix nullpointer dereference in simple_mux_event
---
 sound/soc/codecs/simple-mux.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/simple-mux.c b/sound/soc/codecs/simple-mux.c
index 240af0563283e5a9dd720d51a2cefd22bd241faa..3906964401557db7799a2e1a8dd8abd445e841f4 100644
--- a/sound/soc/codecs/simple-mux.c
+++ b/sound/soc/codecs/simple-mux.c
@@ -6,6 +6,7 @@
 
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
+#include <linux/mux/driver.h>
 #include <linux/regulator/consumer.h>
 #include <sound/soc.h>
 
@@ -16,6 +17,7 @@ struct simple_mux {
 	struct gpio_desc *gpiod_mux;
 	unsigned int mux;
 	const char *mux_texts[MUX_TEXT_SIZE];
+	unsigned int idle_state;
 	struct soc_enum mux_enum;
 	struct snd_kcontrol_new mux_mux;
 	struct snd_soc_dapm_widget mux_widgets[MUX_WIDGET_SIZE];
@@ -57,6 +59,9 @@ static int simple_mux_control_put(struct snd_kcontrol *kcontrol,
 
 	priv->mux = ucontrol->value.enumerated.item[0];
 
+	if (priv->idle_state != MUX_IDLE_AS_IS && dapm->bias_level < SND_SOC_BIAS_PREPARE)
+		return 0;
+
 	gpiod_set_value_cansleep(priv->gpiod_mux, priv->mux);
 
 	return snd_soc_dapm_mux_update_power(dapm, kcontrol,
@@ -75,10 +80,33 @@ static unsigned int simple_mux_read(struct snd_soc_component *component,
 static const struct snd_kcontrol_new simple_mux_mux =
 	SOC_DAPM_ENUM_EXT("Muxer", simple_mux_enum, simple_mux_control_get, simple_mux_control_put);
 
+static int simple_mux_event(struct snd_soc_dapm_widget *w,
+			    struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *c = snd_soc_dapm_to_component(w->dapm);
+	struct simple_mux *priv = snd_soc_component_get_drvdata(c);
+
+	if (priv->idle_state != MUX_IDLE_AS_IS) {
+		switch (event) {
+		case SND_SOC_DAPM_PRE_PMU:
+			gpiod_set_value_cansleep(priv->gpiod_mux, priv->mux);
+			break;
+		case SND_SOC_DAPM_POST_PMD:
+			gpiod_set_value_cansleep(priv->gpiod_mux, priv->idle_state);
+			break;
+		default:
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget simple_mux_dapm_widgets[MUX_WIDGET_SIZE] = {
 	SND_SOC_DAPM_INPUT("IN1"),
 	SND_SOC_DAPM_INPUT("IN2"),
-	SND_SOC_DAPM_MUX("MUX", SND_SOC_NOPM, 0, 0, &simple_mux_mux), // see simple_mux_probe()
+	SND_SOC_DAPM_MUX_E("MUX", SND_SOC_NOPM, 0, 0, &simple_mux_mux, // see simple_mux_probe()
+			   simple_mux_event, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_OUTPUT("OUT"),
 };
 
@@ -93,6 +121,7 @@ static int simple_mux_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct simple_mux *priv;
+	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -121,6 +150,14 @@ static int simple_mux_probe(struct platform_device *pdev)
 	/* Overwrite text ("Input 1", "Input 2") if property exists */
 	of_property_read_string_array(np, "state-labels", priv->mux_texts, MUX_TEXT_SIZE);
 
+	ret = of_property_read_u32(np, "idle-state", &priv->idle_state);
+	if (ret < 0) {
+		priv->idle_state = MUX_IDLE_AS_IS;
+	} else if (priv->idle_state != MUX_IDLE_AS_IS && priv->idle_state >= 2) {
+		dev_err(dev, "invalid idle-state %u\n", priv->idle_state);
+		return -EINVAL;
+	}
+
 	/* switch to use priv data instead of default */
 	priv->mux_enum.texts			= priv->mux_texts;
 	priv->mux_mux.private_value		= (unsigned long)&priv->mux_enum;

-- 
2.47.0


