Return-Path: <linux-kernel+bounces-441679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F63E9ED24F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F66165B6C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2EF1DDC11;
	Wed, 11 Dec 2024 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="knBUyeYE"
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0504748A;
	Wed, 11 Dec 2024 16:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935315; cv=none; b=gLJfxu73uwOnZnSKZT8frmWxLx5/5797dByypSIeQU1vsoB6IyArQ2RUWumEiIhIao0/rd/KEKmscyFxY+72tj39Zi4TgGAhYgXjDLC5Zf/RpPcW9SmoV7X9s+/W+0sGLcuzWAZteiIg7jah7PIji5aDq1xkbQIvYttzxT+jaYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935315; c=relaxed/simple;
	bh=TauuaZAnLDo86RzuTz8Dms6IVfYB+nsLkHsd/icBaUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VqzfNzOYBua76+/sV2MTUjARCOJTYU9DKWh+MfP8fFVTNML2j2tIPMcZecUqum9qjBxT5HyT9D+88V5l8NlEtfFlHp01bS1v8TadorFSVKUNoXTRUVQn4hFyJ8BXiD+k7jYQMJrHSiTQM3+4xXPcZ50mt0p+LsDZ9R0BqYALLzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=knBUyeYE; arc=none smtp.client-ip=80.12.242.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id LPdKthWn7o0aXLPdKtCOay; Wed, 11 Dec 2024 17:32:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733934742;
	bh=rFvBug3DUzjLBEcNi9uUdwbjorNapCxRmjkw85Q8Vp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=knBUyeYEBLfdwD5EXmZOH/SlwXvjLefr9EbzDdGg/TwZaTHYMCAsud/eKf6bt1bAz
	 qgwOAAriA+iqqB57DDrw3/jAZIeuN6C9W6XRg/CmX6O6uwt+DieesBbtCmElHdvYwc
	 ddUEYnNx52GQkJmnOl3tT+K89DHY4shp6uoHUfKEGL+4LYOU84w5Kt6KexKqZPqMPs
	 OcfqJ6W/VvLJK6mI8ledpqnag855eJbvc4PVrtmc2sDNn9zL8opFjdUIiUgxy+Kx00
	 CSW4yoksa177OKrVpJim9HdagDfDZTxCvMIl9GCgRh/00TgxSGs8WYsNK41Zmeixat
	 99Prm+U7eXMaw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Wed, 11 Dec 2024 17:32:22 +0100
X-ME-IP: 90.11.132.44
Message-ID: <0e50f6e5-2442-40e7-8baa-575f139fad37@wanadoo.fr>
Date: Wed, 11 Dec 2024 17:32:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] irqchip: Add the Sophgo SG2042 MSI interrupt
 controller
To: Chen Wang <unicornxw@gmail.com>, u.kleine-koenig@baylibre.com,
 aou@eecs.berkeley.edu, arnd@arndb.de, unicorn_wang@outlook.com,
 conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com,
 krzk+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
 robh@kernel.org, tglx@linutronix.de, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
References: <cover.1733726057.git.unicorn_wang@outlook.com>
 <c882fe329932409131be76ce47b81a6155595ce4.1733726057.git.unicorn_wang@outlook.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <c882fe329932409131be76ce47b81a6155595ce4.1733726057.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 09/12/2024 à 08:12, Chen Wang a écrit :
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add driver for Sophgo SG2042 MSI interrupt controller.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>

...

> +#define SG2042_VECTOR_MIN	64
> +#define SG2042_VECTOR_MAX	95

...

> +static struct irq_chip sg2042_msi_middle_irq_chip = {

const?

> +	.name			= "SG2042 MSI",
> +	.irq_ack		= sg2042_msi_irq_ack,
> +	.irq_mask		= irq_chip_mask_parent,
> +	.irq_unmask		= irq_chip_unmask_parent,
> +#ifdef CONFIG_SMP
> +	.irq_set_affinity	= irq_chip_set_affinity_parent,
> +#endif
> +	.irq_compose_msi_msg	= sg2042_msi_irq_compose_msi_msg,
> +};

...

> +static int sg2042_msi_probe(struct platform_device *pdev)
> +{
> +	struct of_phandle_args args = {};
> +	struct sg2042_msi_data *data;
> +	int ret;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(struct sg2042_msi_data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->reg_clr = devm_platform_ioremap_resource_byname(pdev, "clr");
> +	if (IS_ERR(data->reg_clr)) {
> +		dev_err(&pdev->dev, "Failed to map clear register\n");
> +		return PTR_ERR(data->reg_clr);
> +	}
> +
> +	if (of_property_read_u64(pdev->dev.of_node, "sophgo,msi-doorbell-addr",
> +				 &data->doorbell_addr)) {
> +		dev_err(&pdev->dev, "Unable to parse MSI doorbell addr\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = of_parse_phandle_with_args(pdev->dev.of_node, "msi-ranges",
> +					 "#interrupt-cells", 0, &args);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Unable to parse MSI vec base\n");
> +		return ret;
> +	}
> +	data->irq_first = (u32)args.args[0];
> +
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "msi-ranges",
> +					 args.args_count + 1, &data->num_irqs);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Unable to parse MSI vec number\n");
> +		return ret;
> +	}
> +
> +	if (data->irq_first < SG2042_VECTOR_MIN ||
> +	    (data->irq_first + data->num_irqs - 1) > SG2042_VECTOR_MAX) {
> +		dev_err(&pdev->dev, "msi-ranges is incorrect!\n");
> +		return -EINVAL;
> +	}
> +
> +	mutex_init(&data->msi_map_lock);
> +
> +	data->msi_map = bitmap_zalloc(data->num_irqs, GFP_KERNEL);

IIUC, num_irqs is between 0 and (SG2042_VECTOR_MAX - SG2042_VECTOR_MIN) 
(maybe + or -1).
So around 32.

Would it make sence to use DECLARE_BITMAP(msi_map, <correct_size>) in 
sg2042_msi_data to avoid this allocation and an indirection at runtime?

> +	if (!data->msi_map)
> +		return -ENOMEM;
> +
> +	ret = sg2042_msi_init_domains(data, pdev->dev.of_node);
> +	if (ret)
> +		bitmap_free(data->msi_map);
> +
> +	return ret;
> +}

...

CJ

