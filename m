Return-Path: <linux-kernel+bounces-534421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE3FA466D8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC8D17CF11
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADDA22156D;
	Wed, 26 Feb 2025 16:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="V9gpZOds"
Received: from smtp.smtpout.orange.fr (smtp-82.smtpout.orange.fr [80.12.242.82])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E623A22068B;
	Wed, 26 Feb 2025 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740587214; cv=none; b=Ap2pxoms/pFyhqJfGWV4tBYP/rDtJUmcfr+NfT1jdAU02XiAJnWy6PUFe4tpOjWZ51pxBajmllEUSavL0EBuqMU7+MswcPFhEWA2l9r5OCbcSwj2ejO3azbd4/xt5IvHkDRdNNgxkR/DrT2DLtm72MacpiSmWFKWfrZ/w06LD8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740587214; c=relaxed/simple;
	bh=YJ/+P3P/Fn2JvqI3zjsXaQHPUu/Jy5T9+fh/ITKJfPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oun6DJIFE3VPVbCoyQjXHjQVaAd5DoEO3o7wFlPLWYM53kM7JSZRrt/VVvtSR+lHSi5LytGSGxLFvBicRGd17FXC4jgjHvPkug2dRLKRBFII4mIY1HtjJ5X/dA0Tz2/OtbgQ4q1XNsIzAeA5PtfEkBnR2i7Nn/nkMF1FbvCprJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=V9gpZOds; arc=none smtp.client-ip=80.12.242.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id nKE7t7elVLJNynKEAt1BPh; Wed, 26 Feb 2025 17:25:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1740587143;
	bh=jHYBM0RY1+uRab10Zpvkox4s6qLlIbyBWl1J3zSisU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=V9gpZOdsxmg54ji2qNTr5bCpRjzD5IfC744BKjoCpYnPF65LaysHOmtTVeMeVoqAO
	 2L49GkKqABvSc19hk/3MBbxEMOkxaIum1rh1DAYqvtKEpv5kGKRGUkt4QuKMmybf3T
	 UvLH3J+7bXlrmXPBTtxCz9FKEBHc0RQ3qnWiUZkYmr5R6y5cGIjl2vm8jHi7Lv/e70
	 y3yIs5+1Z1AmJAFpTyBg4j4ktdDQSO4Vx2oSFZCSkWIfMncOs7KHQRM726c/F/eRBA
	 mio+9BsgDnQuDX1Uy0VjHYAcD9il+F8CvVp27rg5/5rAT4f9Q/QwHuCswFYxZtsD/9
	 2L4wVlRJT5NFQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Wed, 26 Feb 2025 17:25:43 +0100
X-ME-IP: 90.11.132.44
Message-ID: <9625cd57-dc1d-4455-af12-aac0e2ba5392@wanadoo.fr>
Date: Wed, 26 Feb 2025 17:25:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (max77705) add initial support
To: Dzmitry Sankouski <dsankouski@gmail.com>, Jean Delvare
 <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250225-initial-support-for-max77705-sensors-v1-1-2be6467628b0@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250225-initial-support-for-max77705-sensors-v1-1-2be6467628b0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 25/02/2025 à 20:11, Dzmitry Sankouski a écrit :
> Add support for max77705 hwmon. Includes charger input, system bus, and
> vbyp measurements.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

...

> +static int max77705_hwmon_probe(struct platform_device *pdev)
> +{
> +	struct i2c_client *i2c;
> +	struct device *hwmon_dev;
> +	struct max77705_hwmon *drv_data;
> +
> +	drv_data = devm_kzalloc(&pdev->dev, sizeof(struct max77705_hwmon),
> +			GFP_KERNEL);
> +	if (!drv_data)
> +		return -ENOMEM;
> +
> +	i2c = to_i2c_client(pdev->dev.parent);
> +	drv_data->regmap = devm_regmap_init_i2c(i2c, &max77705_hwmon_regmap_config);
> +	if (IS_ERR(drv_data->regmap))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(drv_data->regmap),
> +				"Failed to register max77705 hwmon regmap\n");
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev, "max77705", drv_data,
> +			&max77705_chip_info, NULL);
> +	if (IS_ERR(hwmon_dev)) {
> +		return dev_err_probe(&i2c->dev, PTR_ERR(hwmon_dev),

No strong opinion, but why &i2c->dev and not &pdev->dev?

> +				"Unable to register hwmon device\n");
> +	}

Extra { } can be removed, as done a few lines above

> +
> +	return 0;
> +};
> +

...

CJ

