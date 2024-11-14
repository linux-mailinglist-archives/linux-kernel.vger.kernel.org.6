Return-Path: <linux-kernel+bounces-409165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAF79C8835
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42649281F88
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9021F81AC;
	Thu, 14 Nov 2024 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=merzmedtech.de header.i=@merzmedtech.de header.b="H9Pi5bH9";
	dkim=pass (1024-bit key) header.d=merzmedtech.de header.i=@merzmedtech.de header.b="TuQgU5p0"
Received: from mailout02.agenturserver.de (mailout02.agenturserver.de [178.16.56.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028D1192D9D;
	Thu, 14 Nov 2024 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.16.56.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731581977; cv=none; b=bGDzNQuWkW5aDOs+TEc6H9oCdiUCqoezZhROjxveXieTJx2LUvbP+/0lfvDWzs6kNdJt9OQKAJ8VLndQhw/ZKhxTCRBbpRhUnI+Y+5TNlgFBveceA0O49CkqvWtiRrn7iQBXEpOEdWhxM+SSvXyd5JM/izfT1YrxfMB9Naccrmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731581977; c=relaxed/simple;
	bh=OVX7M0N9GoN3kG3D0ZOZcMB4O0EwU1cj7nCysaQjlSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UsFopFjZ7J8wRen2wYPsd9COWwwakgfF1WCpq7ZzJ5WOyi1GwaXZFBqaDQwdvXcFhpI3EMU2l24FmDSwa0VPfxf1wl5YnnZDluQyWb9IKjbxJynuVXug1Uw+wnvN44wZMFUZLkl6ljaRk9Pr+40XkjqOiMvZ5wr7QaW6X5HyvSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merzmedtech.de; spf=pass smtp.mailfrom=merzmedtech.de; dkim=pass (2048-bit key) header.d=merzmedtech.de header.i=@merzmedtech.de header.b=H9Pi5bH9; dkim=pass (1024-bit key) header.d=merzmedtech.de header.i=@merzmedtech.de header.b=TuQgU5p0; arc=none smtp.client-ip=178.16.56.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merzmedtech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merzmedtech.de
Received: from mail02.agenturserver.de (mail02.internal [192.168.51.35])
	by mailout02.agenturserver.de (Postfix) with ESMTP id 2032F6D29;
	Thu, 14 Nov 2024 11:51:18 +0100 (CET)
Received: from XXX.XXX.XXX.XXX (XXXXX.XX [XXX.XXX.XXX.XXX])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: h.v.raven@merzmedtech.de)
	by mail.agenturserver.de (Postfix) with ESMTPSA id C017EA11FB;
	Thu, 14 Nov 2024 11:51:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=merzmedtech.de;
	s=agenturserver2048; t=1731581478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/guqjSuTwKI0Oo4uyiMsmxSgHJhxety89uZKLJHzqC0=;
	b=H9Pi5bH9A159Gh3GiKkNz6DxXoJJFLoZQpLk5pHN4R9dNYz9NJoTVFRqhpEbgkfhIcnzW2
	ZlcacSTV3w6d62F6XfuBP6sDiBptLrlQQnl599RMWDlpAkIQGYXKRs7htV7PXaD4dosHzh
	rlVNG/qWMsGZ7rwleYJeYbNTDh6D03rDZ3cMyf6hZsjNZ2pkE2AL6olM8Y0zVoafmorJ8q
	hJQ92AeZAwKRGlR0J2A8/ZTczhZw1w7+QZ5W4MJ1C2UDqvH58RhS+pe0MOLVQG9wyXNbUw
	aXLgtxkBnS2yRHKB3jA8YZg3y0EHg2gxjd0446YfqWxGvhqYzpvrGjySuY6BKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=merzmedtech.de;
	s=agenturserver; t=1731581478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/guqjSuTwKI0Oo4uyiMsmxSgHJhxety89uZKLJHzqC0=;
	b=TuQgU5p0vaDrGi/JmKRMB3jGWuVm9CSU3vDMz1Q2QCqmzeao5dNnQeGcnWPQZG84ZWnUKD
	Bi/NVVfu6eeVj8Gapkbu47UCzZDW9+rBjAF61wZ0AB8iGPi+NLyuZrC6U6uQpJLbSsQd1e
	qKjtWSDO0FDDzaIEifCGLSKTrj8B2RI=
Message-ID: <f47a1935-fe38-4f17-a46f-5bc591713b6c@merzmedtech.de>
Date: Thu, 14 Nov 2024 11:51:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoc: simple-mux: add idle-state support
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexandre Belloni <aleandre.belloni@bootlin.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20241114-simple-mux-idle-state-v1-0-0b082dd6549b@merzmedtech.de>
 <20241114-simple-mux-idle-state-v1-1-0b082dd6549b@merzmedtech.de>
Content-Language: de-DE, en-GB
From: "Hendrik v. Raven" <h.v.raven@merzmedtech.de>
Organization: Merz Medtech Entwicklungsgesellschaft mbH
In-Reply-To: <20241114-simple-mux-idle-state-v1-1-0b082dd6549b@merzmedtech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-purgate-original-type: suspect.url-count
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 4333
X-purgate-ID: 155922::1731581477-5A422432-0168AE4B/2/61233497599

Managed to send an old version. This one will fail when getting the dapm 
handle in the event. Will send a v2, sorry for the noise.

On 14/11/2024 11:38, Hendrik v. Raven wrote:
> So far the mux changes it state immediately, even when not in use. Allow
> overriding this behaviour by specifying an optional idle-state. This
> state is used whenever the mux is powered down, only switching to the
> selected state on power up. If unspecified it defaults to as-is,
> maintaining the previous behaviour.
> 
> Signed-off-by: Hendrik v. Raven <h.v.raven@merzmedtech.de>
> ---
>   sound/soc/codecs/simple-mux.c | 40 +++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/simple-mux.c b/sound/soc/codecs/simple-mux.c
> index 240af0563283e5a9dd720d51a2cefd22bd241faa..e99fea9eedc58954af3b4381873224c280b1edd2 100644
> --- a/sound/soc/codecs/simple-mux.c
> +++ b/sound/soc/codecs/simple-mux.c
> @@ -6,6 +6,7 @@
>   
>   #include <linux/gpio/consumer.h>
>   #include <linux/module.h>
> +#include <linux/mux/driver.h>
>   #include <linux/regulator/consumer.h>
>   #include <sound/soc.h>
>   
> @@ -16,6 +17,7 @@ struct simple_mux {
>   	struct gpio_desc *gpiod_mux;
>   	unsigned int mux;
>   	const char *mux_texts[MUX_TEXT_SIZE];
> +	unsigned int idle_state;
>   	struct soc_enum mux_enum;
>   	struct snd_kcontrol_new mux_mux;
>   	struct snd_soc_dapm_widget mux_widgets[MUX_WIDGET_SIZE];
> @@ -57,6 +59,9 @@ static int simple_mux_control_put(struct snd_kcontrol *kcontrol,
>   
>   	priv->mux = ucontrol->value.enumerated.item[0];
>   
> +	if (priv->idle_state != MUX_IDLE_AS_IS && dapm->bias_level < SND_SOC_BIAS_PREPARE)
> +		return 0;
> +
>   	gpiod_set_value_cansleep(priv->gpiod_mux, priv->mux);
>   
>   	return snd_soc_dapm_mux_update_power(dapm, kcontrol,
> @@ -75,10 +80,34 @@ static unsigned int simple_mux_read(struct snd_soc_component *component,
>   static const struct snd_kcontrol_new simple_mux_mux =
>   	SOC_DAPM_ENUM_EXT("Muxer", simple_mux_enum, simple_mux_control_get, simple_mux_control_put);
>   
> +static int simple_mux_event(struct snd_soc_dapm_widget *w,
> +			    struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
> +	struct snd_soc_component *c = snd_soc_dapm_to_component(dapm);
> +	struct simple_mux *priv = snd_soc_component_get_drvdata(c);
> +
> +	if (priv->idle_state != MUX_IDLE_AS_IS) {
> +		switch (event) {
> +		case SND_SOC_DAPM_PRE_PMU:
> +			gpiod_set_value_cansleep(priv->gpiod_mux, priv->mux);
> +			break;
> +		case SND_SOC_DAPM_POST_PMD:
> +			gpiod_set_value_cansleep(priv->gpiod_mux, priv->idle_state);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   static const struct snd_soc_dapm_widget simple_mux_dapm_widgets[MUX_WIDGET_SIZE] = {
>   	SND_SOC_DAPM_INPUT("IN1"),
>   	SND_SOC_DAPM_INPUT("IN2"),
> -	SND_SOC_DAPM_MUX("MUX", SND_SOC_NOPM, 0, 0, &simple_mux_mux), // see simple_mux_probe()
> +	SND_SOC_DAPM_MUX_E("MUX", SND_SOC_NOPM, 0, 0, &simple_mux_mux, // see simple_mux_probe()
> +			   simple_mux_event, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
>   	SND_SOC_DAPM_OUTPUT("OUT"),
>   };
>   
> @@ -93,6 +122,7 @@ static int simple_mux_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct device_node *np = dev->of_node;
>   	struct simple_mux *priv;
> +	int ret;
>   
>   	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>   	if (!priv)
> @@ -121,6 +151,14 @@ static int simple_mux_probe(struct platform_device *pdev)
>   	/* Overwrite text ("Input 1", "Input 2") if property exists */
>   	of_property_read_string_array(np, "state-labels", priv->mux_texts, MUX_TEXT_SIZE);
>   
> +	ret = of_property_read_u32(np, "idle-state", &priv->idle_state);
> +	if (ret < 0) {
> +		priv->idle_state = MUX_IDLE_AS_IS;
> +	} else if (priv->idle_state != MUX_IDLE_AS_IS && priv->idle_state >= 2) {
> +		dev_err(dev, "invalid idle-state %u\n", priv->idle_state);
> +		return -EINVAL;
> +	}
> +
>   	/* switch to use priv data instead of default */
>   	priv->mux_enum.texts			= priv->mux_texts;
>   	priv->mux_mux.private_value		= (unsigned long)&priv->mux_enum;
> 


