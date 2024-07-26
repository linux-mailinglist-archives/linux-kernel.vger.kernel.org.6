Return-Path: <linux-kernel+bounces-263803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0604C93DAA8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B52A1F2366A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A352E14D29B;
	Fri, 26 Jul 2024 22:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Ac8iGGH/"
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE9638396;
	Fri, 26 Jul 2024 22:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722032495; cv=none; b=Fcm+aVPvrzkE+5YmCO3nD7V/c2c+dv9zhg7fbzaJNagixY5MUWCwEsdQxBQwp3sqiWfmbm9jgQB4O5pP0FmYeEG5LneTyu21wNlDZ8gWVVD4cL9W3Tr81z0EA6o02KuMU9mIgac87DMMKST6rzFw32Tb53uO5HFRy7/85ytvBZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722032495; c=relaxed/simple;
	bh=q/n6PcUaVriZ5zKOypNdR0dyEftojKdvFe83CfyZmBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lwdcFs+jlQt4jBFRf7B6FGSISGxce7ugRlGTXQC2j7u+YnNfPkpv/b3gfc0wqeIfS81uK//l142TVPtcgjdPBoFQ/Pr7cQS8i4IswwZi4xvLiShLlg3JYpwFQ9O8x2vdXGcWtcl1M4+qQhFu4TpDMVSsz2D17Y62SqwGhub3tec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Ac8iGGH/; arc=none smtp.client-ip=80.12.242.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id XTAQsjdCkkc2vXTAQs9rLV; Sat, 27 Jul 2024 00:12:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722031924;
	bh=fqthNsWy0oH2Iy/PS67VSQTwdel4fdgwtHMQu+8NrBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Ac8iGGH/X4G8xAezKh9iyzgS3yqpgtHDctEn2nwG4hZHl4z64/jLsMWakClqt9hJR
	 YoeQEY5COqLGx3qOeRtrInaGO3kvvUVvs+JyyVjw7AL4YLUQr2TG9ReisOAg8jZWRv
	 8cqHMtrRTS0QguWmPZ6O+JyuPiMesS2xldgRY/dDJuhIRbfrNlUGbdxXv+pT5FYfqo
	 eLCXzprqtCwXGqCYlgqMdwia23UuhO8mGR8QyxQ8EocjegdtFLtAjSkmAechDE1jWi
	 38854Vwg2TgYlk5aQ67RnM7wj/0ESw5RFKcA7DrCJ4lThbfmoVepI3hjm0PFoj912p
	 DJkwYT1G9tsrQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 27 Jul 2024 00:12:04 +0200
X-ME-IP: 90.11.132.44
Message-ID: <0c759c38-eebb-4889-b748-3fd5925d0690@wanadoo.fr>
Date: Sat, 27 Jul 2024 00:12:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/tiny: Add driver for Sharp Memory LCD
To: lanzano.alex@gmail.com
Cc: airlied@gmail.com, christophe.jaillet@wanadoo.fr, conor+dt@kernel.org,
 daniel@ffwll.ch, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, krzk+dt@kernel.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mehdi.djait@bootlin.com, mripard@kernel.org, robh@kernel.org,
 tzimmermann@suse.de
References: <20240725004734.644986-1-lanzano.alex@gmail.com>
 <20240726194456.1336484-1-lanzano.alex@gmail.com>
 <20240726194456.1336484-3-lanzano.alex@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240726194456.1336484-3-lanzano.alex@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 26/07/2024 à 21:44, Alex Lanzano a écrit :
> Add support for the monochrome Sharp Memory LCDs.
> 
> Signed-off-by: Alex Lanzano <lanzano.alex-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Co-developed-by: Mehdi Djait <mehdi.djait-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Mehdi Djait <mehdi.djait-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
> ---
>   MAINTAINERS                         |   7 +
>   drivers/gpu/drm/tiny/Kconfig        |  20 +
>   drivers/gpu/drm/tiny/Makefile       |   1 +
>   drivers/gpu/drm/tiny/sharp-memory.c | 726 ++++++++++++++++++++++++++++
>   4 files changed, 754 insertions(+)
>   create mode 100644 drivers/gpu/drm/tiny/sharp-memory.c
> 

Hi,

below some other tiny comments, hoping it helps.

Also "./scripts/checkpatch.pl --strict" gives some hints, should some be 
of interest.

> +static int sharp_memory_probe(struct spi_device *spi)
> +{
> +	int ret;
> +	struct device *dev;
> +	struct sharp_memory_device *smd;
> +	enum sharp_memory_model model;
> +	struct drm_device *drm;
> +	const char *vcom_mode_str;
> +
> +	ret = spi_setup(spi);
> +	if (ret < 0)
> +		return dev_err_probe(&spi->dev, ret, "Failed to setup spi device\n");
> +
> +	dev = &spi->dev;

6 times below, &spi->dev could be replaced by dev, to slightly simplify 
things.

> +	if (!dev->coherent_dma_mask) {
> +		ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to set dma mask\n");
> +	}
> +
> +	smd = devm_drm_dev_alloc(&spi->dev, &sharp_memory_drm_driver,
> +				 struct sharp_memory_device, drm);

Missing error handling.

> +
> +	spi_set_drvdata(spi, smd);
> +
> +	smd->spi = spi;
> +	drm = &smd->drm;
> +	ret = drmm_mode_config_init(drm);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to initialize drm config\n");
> +
> +	smd->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);
> +	if (smd->enable_gpio == NULL)

Nitpick: if (!smd->enable_gpio)

> +		dev_warn(&spi->dev, "Enable gpio not defined\n");
> +
> +	/*
> +	 * VCOM is a signal that prevents DC bias from being built up in
> +	 * the panel resulting in pixels being forever stuck in one state.
> +	 *
> +	 * This driver supports three different methods to generate this
> +	 * signal depending on EXTMODE pin:
> +	 *
> +	 * software (EXTMODE = L) - This mode uses a kthread to
> +	 * periodically send a "maintain display" message to the display,
> +	 * toggling the vcom bit on and off with each message
> +	 *
> +	 * external (EXTMODE = H) - This mode relies on an external
> +	 * clock to generate the signal on the EXTCOMM pin
> +	 *
> +	 * pwm (EXTMODE = H) - This mode uses a pwm device to generate
> +	 * the signal on the EXTCOMM pin
> +	 *
> +	 */
> +	smd->vcom = 0;

Nitpick: devm_drm_dev_alloc() already zeroes the allocated memory. So 
this is useless. Unless you think it gives some useful hint, it could be 
removed.

> +	if (device_property_read_string(&spi->dev, "vcom-mode", &vcom_mode_str))
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Unable to find vcom-mode node in device tree\n");
> +
> +	if (!strcmp("software", vcom_mode_str)) {
> +		smd->vcom_mode = SHARP_MEMORY_SOFTWARE_VCOM;

...

> +	smd->pitch = (SHARP_ADDR_PERIOD + smd->mode->hdisplay + SHARP_DUMMY_PERIOD) / 8;
> +	smd->tx_buffer_size = (SHARP_MODE_PERIOD +
> +			       (SHARP_ADDR_PERIOD + (smd->mode->hdisplay) + SHARP_DUMMY_PERIOD) *
> +			       smd->mode->vdisplay) / 8;
> +
> +	smd->tx_buffer = devm_kzalloc(&spi->dev, smd->tx_buffer_size, GFP_KERNEL);
> +	if (!smd->tx_buffer)
> +		return dev_err_probe(&spi->dev, -ENOMEM, "Unable to alloc tx buffer\n");

There is no need to log a message for memory allocation failure.
return -ENOMEM; should be just fine IMHO.

> +
> +	mutex_init(&smd->tx_mutex);
> +
> +	drm->mode_config.min_width = smd->mode->hdisplay;
> +	drm->mode_config.max_width = smd->mode->hdisplay;
> +	drm->mode_config.min_height = smd->mode->vdisplay;
> +	drm->mode_config.max_height = smd->mode->vdisplay;
> +
> +	ret = sharp_memory_pipe_init(drm, smd,
> +				     sharp_memory_formats,

Nitpick: you could save 1 LoC if this is put at the end of the previous 
line.

> +				     ARRAY_SIZE(sharp_memory_formats),
> +				     NULL);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to initialize display pipeline.\n");
> +
> +	drm_plane_enable_fb_damage_clips(&smd->plane);
> +	drm_mode_config_reset(drm);
> +
> +	ret = drm_dev_register(drm, 0);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register drm device.\n");
> +
> +	drm_fbdev_dma_setup(drm, 0);
> +
> +	return 0;
> +}

...

CJ



