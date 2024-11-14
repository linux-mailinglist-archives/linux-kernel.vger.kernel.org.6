Return-Path: <linux-kernel+bounces-409146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1AE9C87F7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41BB1F211B9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515FA1F891C;
	Thu, 14 Nov 2024 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=merzmedtech.de header.i=@merzmedtech.de header.b="dya6xIrH";
	dkim=pass (1024-bit key) header.d=merzmedtech.de header.i=@merzmedtech.de header.b="QJLLuXHb"
Received: from mailout01.agenturserver.de (mailout01.agenturserver.de [185.15.192.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C061F77AF;
	Thu, 14 Nov 2024 10:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.15.192.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731581182; cv=none; b=ipXUmetvkME3O+kKBh2iOXIJDcqLC0nGpOgkAds2o+4c5xjJsMxr5Jh4w5AtY0vU2hiHF+WjIkYMzd9Su4PCetJP+o/I4ZAfvHFxz92Rpn7C+6ZAgOIw6ZD+J+X6my5VufqWFOwk+ahssMVsvBNpCKeuz1NKJ31bevPDfWaxusI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731581182; c=relaxed/simple;
	bh=WWd/Eq3pT8KwIv8lHZqCx2t4m/QPon2WGFjntn0TcoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A/5s2Tb+N+5qAQxvXMyVGTv0BTXqSA0qbrT1FotGEBi83+8+rAP9menvZmT90VMia3Vj5kJZ5gdFNuStaEYgW/GauAXhZOrv+h0eOGnxaYentBjHBWkhXZgNs/7+eBbj8POtgiQsBylrDpnkoINtoKo6LBsiwkrO0SAGKtsA4eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merzmedtech.de; spf=pass smtp.mailfrom=merzmedtech.de; dkim=pass (2048-bit key) header.d=merzmedtech.de header.i=@merzmedtech.de header.b=dya6xIrH; dkim=pass (1024-bit key) header.d=merzmedtech.de header.i=@merzmedtech.de header.b=QJLLuXHb; arc=none smtp.client-ip=185.15.192.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merzmedtech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merzmedtech.de
Received: from mail02.agenturserver.de (mail02.internal [192.168.51.35])
	by mailout01.agenturserver.de (Postfix) with ESMTP id D0F9070ED;
	Thu, 14 Nov 2024 11:38:58 +0100 (CET)
Received: from XXX.XXX.XXX.XXX (XXXXX.XX [XXX.XXX.XXX.XXX])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: h.v.raven@merzmedtech.de)
	by mail.agenturserver.de (Postfix) with ESMTPSA id 6325BA11D2;
	Thu, 14 Nov 2024 11:38:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=merzmedtech.de;
	s=agenturserver2048; t=1731580738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zYkj1QCwnKkTL0lEk6ZUdZzjGNnTMqxoJhoVSEzjf/I=;
	b=dya6xIrHm06jLux8TEoZ5Bu6p0+ijRLvYUImd5Yy5d8w1g3P3O09djCDs0MQakLKClVR3h
	FEW4fX7s7ns7TrVu5Pa4SscHjfUCQL6WIoGXDVjc0TqTRWsv2OwOq8EzIzMD2/DuM+a/j8
	x7XG2IwXZELrsFTUUGCGGt+9/RHtO9H8KeehiYTjJXmR/MfMrsaVBGZFoHMKxQP6KwauqT
	PDs/hst+8LaYWMKKSQTgkQ5jOXYS5dgsoK+eXVtOgigZSBxII4e4yWfkz/h3kvcvSGFROy
	xS2DgiIuYytAXTxBWbDNacAVSp0xUPxr65VmkkbZFTE7yHNiOaazxECGCUFKbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=merzmedtech.de;
	s=agenturserver; t=1731580738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zYkj1QCwnKkTL0lEk6ZUdZzjGNnTMqxoJhoVSEzjf/I=;
	b=QJLLuXHbADywHWF0Ys4ar0BKhvsc/C9KSxihNL2ld786wqSyq2EDbYRDfcogoN6cwYS47I
	+fJ85dYZOL8vU/2PKIqNLU8k51MHIsa3M5AHOiu3ZLqwwdJFqfvv1jTnBs5B9BD8gSr6ua
	g//AqeEWJ7x+rxidbPbG1HAQvERzl3E=
From: "Hendrik v. Raven" <h.v.raven@merzmedtech.de>
Date: Thu, 14 Nov 2024 11:38:38 +0100
Subject: [PATCH 1/2] ASoc: simple-mux: add idle-state support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-simple-mux-idle-state-v1-1-0b082dd6549b@merzmedtech.de>
References: <20241114-simple-mux-idle-state-v1-0-0b082dd6549b@merzmedtech.de>
In-Reply-To: <20241114-simple-mux-idle-state-v1-0-0b082dd6549b@merzmedtech.de>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Belloni <aleandre.belloni@bootlin.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, "Hendrik v. Raven" <h.v.raven@merzmedtech.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3919;
 i=h.v.raven@merzmedtech.de; h=from:subject:message-id;
 bh=WWd/Eq3pT8KwIv8lHZqCx2t4m/QPon2WGFjntn0TcoQ=;
 b=owEBzQIy/ZANAwAKAQP8mG1lSaY7AcsmYgBnNdNBHTV13FdICnVJwhTKRJMY6YvV8Vkz9L3Jz
 EiIS6XlEQyJApMEAAEKAH0WIQRfy2xFNGjRY609IOcD/JhtZUmmOwUCZzXTQV8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0NUZDQjZDNDUzNDY
 4RDE2M0FEM0QyMEU3MDNGQzk4NkQ2NTQ5QTYzQgAKCRAD/JhtZUmmO39dEACNLOwS+pLykn+3wC
 ITrjjk7OAaRAmHK+OprZPfo00u7bw8vdxit1I7hgvM6wy664edEEJ5a+FYVudjtEcAscsawpixl
 /MHMC7nhkuq6U05TNFs5FwxrTR7S/e6mss+sqc9BaWhCRnBwwi6CuEEGbHJXvfU2UdyTLTQxBYV
 MDuKg8jnzAhBysRk7AZbMB9g/XkuhzoJZrWcj6elfoNyW0JSvvIcbxmcgTVLVjfAvx93fq3tJIS
 X3zrADbJQpI0/+kmbxzSB9ry3u4S7hPdFWNN61u4Zd9gzqarza2hDEoV8eSzjov3BgPP+dgxifZ
 MefXqgUw0GmLeyxasLE2SlTeqyXxzav/xGtvmE4akXCOBNp9pjpS66HLJ5J6LYCKzGyb9HoS91v
 NsWF6tuYs3r1Mi8cS617xTfpy1gEfUiodp/b7X/qUHQK61t+iNWZF/fhbmHPG01FW52vMQLbSvK
 8APsKdR/QfSRV/6iQQhyuefrdefUC2yaChYaQB8wB85WdqbncApgJ9oMLeOycdF1WWPSXJ0iPpB
 tdmsgNJkBKau31blTt5MtIA6SLkKuFpWF2kBFq+AamoXplIE9QHK581nw0ss3Zwk6v1W8sS0cdg
 UDaUc7GqwwTdXW0jO/KZ8rKyae/xkUULkPSaHprYvAkyCPCXIHo7zRN9VkvvMrPeuqyA==
X-Developer-Key: i=h.v.raven@merzmedtech.de; a=openpgp;
 fpr=7A67B9A9F57B4F324AB6B8EB045B81F5FB5BA3AE
X-purgate-original-type: clean
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 3921
X-purgate-ID: 155922::1731580738-D8CA1432-D10B7445/0/0

So far the mux changes it state immediately, even when not in use. Allow
overriding this behaviour by specifying an optional idle-state. This
state is used whenever the mux is powered down, only switching to the
selected state on power up. If unspecified it defaults to as-is,
maintaining the previous behaviour.

Signed-off-by: Hendrik v. Raven <h.v.raven@merzmedtech.de>
---
 sound/soc/codecs/simple-mux.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/simple-mux.c b/sound/soc/codecs/simple-mux.c
index 240af0563283e5a9dd720d51a2cefd22bd241faa..e99fea9eedc58954af3b4381873224c280b1edd2 100644
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
@@ -75,10 +80,34 @@ static unsigned int simple_mux_read(struct snd_soc_component *component,
 static const struct snd_kcontrol_new simple_mux_mux =
 	SOC_DAPM_ENUM_EXT("Muxer", simple_mux_enum, simple_mux_control_get, simple_mux_control_put);
 
+static int simple_mux_event(struct snd_soc_dapm_widget *w,
+			    struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct snd_soc_component *c = snd_soc_dapm_to_component(dapm);
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
 
@@ -93,6 +122,7 @@ static int simple_mux_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct simple_mux *priv;
+	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -121,6 +151,14 @@ static int simple_mux_probe(struct platform_device *pdev)
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


