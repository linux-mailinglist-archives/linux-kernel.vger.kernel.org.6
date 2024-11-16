Return-Path: <linux-kernel+bounces-411657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EC19CFD77
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 10:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83B4FB238DD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 09:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744D51392;
	Sat, 16 Nov 2024 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="f45LEZMN"
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1482F29
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 09:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731749477; cv=none; b=rqNEXKM6B/xkotuIKlCqnfXpliJow2e8Iof9Tw0wll8vrFyxoOgSVdNA0UNGOtPdFWhHdAHfL4K4TaoP+XN9/6ULrDsHs7k0zydidAKWdvuYn+9wEpTA0077NpB+o6FrjZSB9JJ/gZntPmMFKnqlpwe5bbtTNRymkRKm8zkeKk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731749477; c=relaxed/simple;
	bh=SatBi42+lwcERUNgUu7SiY8UjEWtxxqv9u0kRxFv23U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hk4EfG5089j+EY5xBCKtD5Udo6+xVVTJuoJf2dEdcP5A0qpRhgaJvANubOjBGYB8L3AeS5n1C01lLef59V9/H28ZEAyw7gXw682QnCqsMxaF9AQgPBATu3lPtRwKaBk87Bt5Vj5B7uQeg9Sc3Is86nzMBCFDIwG+iRAR3AlTH2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=f45LEZMN; arc=none smtp.client-ip=80.12.242.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id CF93tqk0pYfukCF94tlWwu; Sat, 16 Nov 2024 10:31:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731749472;
	bh=cGir6PONqA3MsyVFpBacoqiMohbq7usgi1fy6wC2H9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=f45LEZMNhPOcFj5iv/6C+Zlr4a223dihVBwVJ/UUA1AlRWE4/wXgtlmxpv3PiuXyM
	 r/pzboiJo8Z6S3f1kpe1F5codi2/orDBxc9rWk6s0skamlUekDoRy2W193JM8v5T+i
	 FxWAaIoyVkBybrQWh0An6fRous36nYtT0EmlH8RA2/mBVe7AC0139SwU+fzqP3U1gJ
	 e//IuwmZi6XYdvYKwKKrOEBw3qIetnKlg9Zf65zHIodQDRqZRD+OCI/kkpBCe6pfnY
	 nxbYtDAnegZ8Ki71ijQJATOFON0hAOlhTiZj4IbYDgIdjin+Z9TmKj1Hirna2huQiF
	 Wh7qr+CXmTXcg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 16 Nov 2024 10:31:12 +0100
X-ME-IP: 90.11.132.44
Message-ID: <8efcd579-15d5-4ea2-bbb9-f9b4969f031f@wanadoo.fr>
Date: Sat, 16 Nov 2024 10:31:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: loongson: add Loongson Security Module driver
To: Qunqin Zhao <zhaoqunqin@loongson.cn>, arnd@arndb.de, olof@lixom.net
Cc: soc@lists.linux.dev, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev
References: <20241116085729.12651-1-zhaoqunqin@loongson.cn>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241116085729.12651-1-zhaoqunqin@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 16/11/2024 à 09:57, Qunqin Zhao a écrit :
> This driver supports Loongson Security Module, which
> provides the control for it's hardware encryption
> acceleration child devices.
> 
> Only ACPI firmware is supported.
> 
> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> ---
>   MAINTAINERS                        |   7 +
>   drivers/soc/loongson/Kconfig       |   9 +
>   drivers/soc/loongson/Makefile      |   1 +
>   drivers/soc/loongson/loongson_se.c | 542 +++++++++++++++++++++++++++++
>   include/soc/loongson/se.h          | 135 +++++++
>   5 files changed, 694 insertions(+)
>   create mode 100644 drivers/soc/loongson/loongson_se.c
>   create mode 100644 include/soc/loongson/se.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fdeb3d12c..85fff2eb7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13379,6 +13379,13 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/hwinfo/loongson,ls2k-chipid.yaml
>   F:	drivers/soc/loongson/loongson2_guts.c
>   
> +LOONGSON SECURITY MODULE DRIVER
> +M:	Qunqin Zhao <zhaoqunqin@loongson.cn>
> +L:	loongarch@lists.linux.dev
> +S:	Maintained
> +F:	drivers/soc/loongson/loongson_se.c
> +F:	include/soc/loongson/se.h
> +
>   LOONGSON-2 SOC SERIES PM DRIVER
>   M:	Yinbo Zhu <zhuyinbo@loongson.cn>
>   L:	linux-pm@vger.kernel.org
> diff --git a/drivers/soc/loongson/Kconfig b/drivers/soc/loongson/Kconfig
> index 368344943..93ef1d205 100644
> --- a/drivers/soc/loongson/Kconfig
> +++ b/drivers/soc/loongson/Kconfig
> @@ -27,3 +27,12 @@ config LOONGSON2_PM
>   	  Disk), ACPI S5 (Soft Shutdown) and supports multiple wake-up methods
>   	  (USB, GMAC, PWRBTN, etc.). This driver was to add power management
>   	  controller support that base on dts for Loongson-2 series SoCs.
> +
> +config LOONGSON_SE
> +	tristate "LOONGSON SECURITY MODULE Interface"
> +	depends on LOONGARCH && ACPI
> +	help
> +	  The Loongson security module provides the control for hardware
> +	  encryption acceleration devices. Each device uses at least one
> +	  channel to interacts with security module, and each channel may

s/interacts/interact/

> +	  has its own buffer provided by security module.

s/has/have/

> diff --git a/drivers/soc/loongson/Makefile b/drivers/soc/loongson/Makefile
> index 4118f50f5..503075042 100644
> --- a/drivers/soc/loongson/Makefile
> +++ b/drivers/soc/loongson/Makefile
> @@ -5,3 +5,4 @@
>   
>   obj-$(CONFIG_LOONGSON2_GUTS)		+= loongson2_guts.o
>   obj-$(CONFIG_LOONGSON2_PM)		+= loongson2_pm.o
> +obj-$(CONFIG_LOONGSON_SE)		+= loongson_se.o
> diff --git a/drivers/soc/loongson/loongson_se.c b/drivers/soc/loongson/loongson_se.c
> new file mode 100644
> index 000000000..d85db8423
> --- /dev/null
> +++ b/drivers/soc/loongson/loongson_se.c

...

> +static int loongson_se_get_res(struct loongson_se *se, u32 int_bit, u32 cmd,
> +			       struct se_data *res)
> +{
> +	int err = 0;
> +
> +	res->int_bit = int_bit;
> +
> +	if (se_get_response(se, res)) {
> +		dev_err(se->dev, "Int 0x%x get response fail.\n", int_bit);
> +		return -EFAULT;
> +	}
> +
> +	/* Check response */
> +	if (res->u.res.cmd == cmd)
> +		err = 0;

Not needed, err is already 0.

> +	else {
> +		dev_err(se->dev, "Response cmd is 0x%x, not expect cmd 0x%x.\n",
> +			res->u.res.cmd, cmd);
> +		err = -EFAULT;
> +	}
> +
> +	return err;
> +}

...

> +static int loongson_se_set_msg(struct lsse_ch *ch)
> +{
> +	struct loongson_se *se = ch->se;
> +	struct se_data req = {0};
> +	struct se_data res = {0};
> +	int err;
> +
> +	req.int_bit = SE_INT_SETUP;
> +	req.u.gcmd.cmd = SE_CMD_SETMSG;
> +	/* MSG off */
> +	req.u.gcmd.info[0] = ch->id;
> +	req.u.gcmd.info[1] = ch->smsg - se->mem_base;
> +	req.u.gcmd.info[2] = ch->msg_size;
> +
> +	dev_dbg(se->dev, "Set Channel %d msg off 0x%x, msg size %d\n",
> +		ch->id, req.u.gcmd.info[1], req.u.gcmd.info[2]);
> +
> +	err = se_send_genl_cmd(se, &req, &res, 5);
> +	if (res.u.res.cmd_ret)

In the fnction above, we test (err || ...)
Is it needed here as well (or can it be removed in se_send_genl_cmd())

Also, below se_send_genl_cmd() errors are checked only with err.
Should it be consistent?

> +		return res.u.res.cmd_ret;
> +
> +	return err;
> +}

...

> +void se_deinit_ch(struct lsse_ch *ch)
> +{
> +	struct loongson_se *se = ch->se;
> +	unsigned long flag;
> +	int first, nr;
> +	int id = ch->id;
> +
> +	if (!se) {
> +		pr_err("SE has bot been initialized\n");
> +		return;
> +	}
> +
> +	if (id == 0 || id > SE_CH_MAX) {
> +		dev_err(se->dev, "Channel number %d is invalid\n", id);
> +		return;
> +	}
> +
> +	if (!se_ch_status(se, BIT(id))) {
> +		dev_err(se->dev, "Channel number %d has not been initialized\n", id);
> +		return;
> +	}
> +
> +	spin_lock_irqsave(&se->dev_lock, flag);
> +
> +	se->ch_status &= ~BIT(ch->id);
> +
> +	first = (ch->data_buffer - se->mem_base) / PAGE_SIZE;
> +	nr = round_up(ch->data_size, PAGE_SIZE) / PAGE_SIZE;
> +	bitmap_clear(se->mem_map, first, nr);
> +
> +	first = (ch->smsg - se->mem_base) / PAGE_SIZE;
> +	nr = round_up(ch->msg_size, PAGE_SIZE) / PAGE_SIZE;
> +	bitmap_clear(se->mem_map, first, nr);
> +
> +	se_disable_int(se, ch->int_bit);
> +
> +	spin_unlock_irqrestore(&se->dev_lock, flag);
> +

Uneeded empty line

> +}
> +EXPORT_SYMBOL_GPL(se_deinit_ch);
> +
> +static int loongson_se_probe(struct platform_device *pdev)
> +{
> +	struct loongson_se *se;
> +	struct device *dev = &pdev->dev;
> +	int nr_irq, irq, err, size;
> +
> +	se = devm_kmalloc(dev, sizeof(*se), GFP_KERNEL);
> +	if (!se)
> +		return -ENOMEM;
> +	se->dev = dev;
> +	dev_set_drvdata(dev, se);
> +	init_completion(&se->cmd_completion);
> +	spin_lock_init(&se->cmd_lock);
> +	spin_lock_init(&se->dev_lock);
> +	/* Setup DMA buffer */
> +	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	if (device_property_read_u32(dev, "dmam_size", &size))
> +		return -ENODEV;
> +	size = roundup_pow_of_two(size);
> +	se->mem_base = dmam_alloc_coherent(dev, size, &se->mem_addr, GFP_KERNEL);
> +	if (!se->mem_base)
> +		return -ENOMEM;
> +	memset(se->mem_base, 0, size);

I don't think that it is needed. dmam_alloc_coherent() should return 
zeroed memory.

> +	se->mem_map_pages = size / PAGE_SIZE;
> +	se->mem_map = devm_bitmap_zalloc(dev, se->mem_map_pages, GFP_KERNEL);
> +	if (!se->mem_map)
> +		return -ENOMEM;
> +
> +	se->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(se->base))
> +		return PTR_ERR(se->base);
> +
> +	nr_irq = platform_irq_count(pdev);
> +	if (nr_irq <= 0)
> +		return -ENODEV;
> +	while (nr_irq) {
> +		irq = platform_get_irq(pdev, --nr_irq);
> +		if (irq < 0)
> +			return -ENODEV;
> +		/* Use the same interrupt handler address.
> +		 * Determine which irq it is accroding
> +		 * SE_S2LINT_STAT register.
> +		 */
> +		err = devm_request_irq(dev, irq, se_irq, 0,
> +				       "loongson-se", se);
> +		if (err)
> +			dev_err(dev, "failed to request irq: %d\n", err);
> +	}
> +
> +	err = se_init_hw(se, se->mem_addr, size);
> +	if (err)
> +		se_disable_hw(se);
> +
> +	return err;
> +}
> +
> +static struct acpi_device_id loongson_se_acpi_match[] = {

const?

> +	{"LOON0011", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, loongson_se_acpi_match);

...

CJ

