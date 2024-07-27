Return-Path: <linux-kernel+bounces-264018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0CC93DDEC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1760B1C215F1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 09:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A7842AAD;
	Sat, 27 Jul 2024 09:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDCNYx6o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2827C446A5;
	Sat, 27 Jul 2024 09:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722071006; cv=none; b=Lm7f7NxqXKP0TqXSCdLfwBylexdWtIV/xatXphgxBfzZb4ojgmgAeqEh2u710Sfrxo1b4UU8PQulePTB+4EW1Eh2pZAs0x8pkqDmXY11hl3VHam5RlB3g9IoeKDOcwl3zarhVHzbXjR4bHKVOjxVQY8kpkA+2oxXN1CgdSBR1ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722071006; c=relaxed/simple;
	bh=vuzJjbJxlWslldrS96nzbWjN24fcUOlWq0xB/Pgml3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P6UpUkIqomZqBJFwcdr2+NCcOzKrTq2H2XvxbEInR5FBzkstfjNlBDxfhU0d/2HLEZczUGXp2dx4UKZrPM/IgVld+GSVdSODhjMcb9toFfkXcia8b6qipiIIs5oee+UzVCMYXZMNw3UobIxdyespnGguPE63pYpz78ldAEeEHd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDCNYx6o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80484C32781;
	Sat, 27 Jul 2024 09:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722071005;
	bh=vuzJjbJxlWslldrS96nzbWjN24fcUOlWq0xB/Pgml3M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LDCNYx6ofosQ9xO0I4LleWBNXOMRmMWYtdD4Eg9PI2afjGX8G+xr1hy9S5i4L2wge
	 48T7n5XfdIbN7iTljIgQ+uT6EzyAw288ru9hLrMnLkC98X7slptpFEGsrUrMC7ImZv
	 smaHjVSsKtny7qY7ou3+58TkGnVofflUlOiyStp91ZQtwrhjunDw67NIalcDoSwjct
	 73sB7FCIt/3EGhW5CQCriHb/D7OJBoTg/bqBxjNAkPVVY/KAe5NM9ISQiskkRofarS
	 VFHWkv59kax+1+F6MOq/WlEWALrAyXo3uXSZa2aF1IeT36J/X8+0fpEXLRAPcKz82F
	 10ULQyiui9F1g==
Message-ID: <3b6297d6-f954-499a-9504-233b27ff686a@kernel.org>
Date: Sat, 27 Jul 2024 11:03:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/tiny: Add driver for Sharp Memory LCD
To: Alex Lanzano <lanzano.alex@gmail.com>, mehdi.djait@bootlin.com,
 christophe.jaillet@wanadoo.fr,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240725004734.644986-1-lanzano.alex@gmail.com>
 <20240726194456.1336484-1-lanzano.alex@gmail.com>
 <20240726194456.1336484-3-lanzano.alex@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240726194456.1336484-3-lanzano.alex@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/07/2024 21:44, Alex Lanzano wrote:
> Add support for the monochrome Sharp Memory LCDs.
> 
> Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
> Co-developed-by: Mehdi Djait <mehdi.djait@bootlin.com>
> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> ---
>  MAINTAINERS                         |   7 +
>  drivers/gpu/drm/tiny/Kconfig        |  20 +
>  drivers/gpu/drm/tiny/Makefile       |   1 +
>  drivers/gpu/drm/tiny/sharp-memory.c | 726 ++++++++++++++++++++++++++++
>  4 files changed, 754 insertions(+)
>  create mode 100644 drivers/gpu/drm/tiny/sharp-memory.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 71b739b40921..b5b08247a994 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7123,6 +7123,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
>  F:	drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
>  
> +DRM DRIVER FOR SHARP MEMORY LCD
> +M:	Alex Lanzano <lanzano.alex@gmail.com>
> +S:	Maintained
> +T:	git git://anongit.freedesktop.org/drm/drm-misc


Do you have drm-misc commit rights? If not, drop it. There is no point
to put some other maintainer's tree in your entry. Git tree is already
present in the maintainer's entry who is going to apply the patches.


> +F:	Documentation/devicetree/bindings/display/sharp,sharp-memory.yaml

If you rename the file in your patchset, you must rename it EVERYWHERE.


> +F:	drivers/gpu/drm/tiny/sharp-memory.c
> +
>  DRM DRIVER FOR SITRONIX ST7586 PANELS


...

> +	smd->spi = spi;
> +	drm = &smd->drm;
> +	ret = drmm_mode_config_init(drm);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to initialize drm config\n");
> +
> +	smd->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);
> +	if (smd->enable_gpio == NULL)
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
> +	if (device_property_read_string(&spi->dev, "vcom-mode", &vcom_mode_str))
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Unable to find vcom-mode node in device tree\n");
> +
> +	if (!strcmp("software", vcom_mode_str)) {
> +		smd->vcom_mode = SHARP_MEMORY_SOFTWARE_VCOM;
> +
> +	} else if (!strcmp("external", vcom_mode_str)) {
> +		smd->vcom_mode = SHARP_MEMORY_EXTERNAL_VCOM;
> +
> +	} else if (!strcmp("pwm", vcom_mode_str)) {
> +		smd->vcom_mode = SHARP_MEMORY_PWM_VCOM;
> +		ret = sharp_memory_init_pwm_vcom_signal(smd);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to initialize external COM signal\n");
> +	} else {
> +		return dev_err_probe(dev, -EINVAL, "Invalid value set for vcom-mode\n");
> +	}
> +
> +	drm->mode_config.funcs = &sharp_memory_mode_config_funcs;
> +
> +	/* Set the DRM display mode depending on panel model */
> +	model = (uintptr_t)spi_get_device_match_data(spi);
> +	switch (model) {
> +	case LS013B7DH03:
> +		smd->mode = &sharp_memory_ls013b7dh03_mode;
> +		break;
> +
> +	case LS010B7DH04:
> +		smd->mode = &sharp_memory_ls010b7dh04_mode;
> +		break;
> +
> +	case LS011B7DH03:
> +		smd->mode = &sharp_memory_ls011b7dh03_mode;
> +		break;
> +
> +	case LS012B7DD01:
> +		smd->mode = &sharp_memory_ls012b7dd01_mode;
> +		break;
> +
> +	case LS013B7DH05:
> +		smd->mode = &sharp_memory_ls013b7dh05_mode;
> +		break;
> +
> +	case LS018B7DH02:
> +		smd->mode = &sharp_memory_ls018b7dh02_mode;
> +		break;
> +
> +	case LS027B7DH01:
> +		fallthrough;
> +	case LS027B7DH01A:
> +		smd->mode = &sharp_memory_ls027b7dh01_mode;
> +		break;
> +
> +	case LS032B7DD02:
> +		smd->mode = &sharp_memory_ls032b7dd02_mode;
> +		break;
> +
> +	case LS044Q7DH01:
> +		smd->mode = &sharp_memory_ls044q7dh01_mode;
> +		break;

This is over-complicated. Just store the mode in device match data.


> +
> +	default:
> +		return dev_err_probe(&spi->dev, -EINVAL, "Invalid DRM display mode\n");
> +	}


Best regards,
Krzysztof


