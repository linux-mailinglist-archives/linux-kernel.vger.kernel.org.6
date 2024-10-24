Return-Path: <linux-kernel+bounces-379632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 439399AE14C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6487A1C217C0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D09A1B21AD;
	Thu, 24 Oct 2024 09:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMB4oMO5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D0E15886D;
	Thu, 24 Oct 2024 09:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729763161; cv=none; b=KZy6uFHN3E4O0vyklEvUD+sNV8v7TIORwmCcHWFAA2vKYRzDPC57wcD+XXCB686AiesPKZQsJiR0MD8In8zRoC3USu345y6yI1I3CpB5jtktxlr4mzCIIhmq6E60pvQhgRPMTLkUj95ycMNPWCaOIVHXNga5lh6c20guiEsdmcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729763161; c=relaxed/simple;
	bh=TP20U8M2gkMXngG5jt8yo0o5myFCfbGLJyktlLYRLxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lsWsQi7A4f+8XVHKwvrrtRoLiX1aZhFxnoHMrDJ3bTAdtf9v6+QLwnHCHPyjGku22hZfO9rSMDW5UfGysflryaslEhN9kJF9iU6fAGUEtrRC5bli0LICXNuSV/aW47YoM0h4jEeMkmqjcKfjHi3BGlKzS6aPE3KPNCgDKLyKWoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMB4oMO5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199C8C4CECC;
	Thu, 24 Oct 2024 09:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729763161;
	bh=TP20U8M2gkMXngG5jt8yo0o5myFCfbGLJyktlLYRLxE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nMB4oMO5FoeZ4p/LGdZ2lPbtjU5xPPsN3KJwkC0MLrR5sq8z2LkktpgmETu+logty
	 7GijuQcd0H0U/78gM/myotb56r8FN02IiSc5LW4Nf4mAvry78k9Vr5RQx2aLvjFF5J
	 51C8eeJFIWig6dQixaMrBWlLQbW7EDpLG48ilXUv+cEVCI3azduXCYv2xTcJdFo4CR
	 KiMH5A8zOqRwhOxYKh+LH/twQNWPnaGtzmNpeOQnCiyNtId8MR25BrhhtbMKnWWIiz
	 clzm1vlY4dQ9sjh/mYDeUgeYMMCTfCz9araohAyeFokTgj+09tStr7aq+EfcsGscPR
	 Y30Tz1IKbvD4Q==
Message-ID: <d1264f6b-07bd-41e4-848d-1775a1f45884@kernel.org>
Date: Thu, 24 Oct 2024 11:45:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mailbox: mediatek: Add mtk-apu-mailbox driver
To: "Karl.Li" <karl.li@mediatek.com>, Jassi Brar <jassisinghbrar@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Chungying Lu <chungying.lu@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20241024092608.431581-1-karl.li@mediatek.com>
 <20241024092608.431581-4-karl.li@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20241024092608.431581-4-karl.li@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/10/2024 11:25, Karl.Li wrote:
> From: Karl Li <karl.li@mediatek.com>
> 
> Add mtk-apu-mailbox driver to support the communication with
> APU remote microprocessor.
> 
> Also, the mailbox hardware contains extra spare (scratch) registers
> that other hardware blocks use to communicate through.
> Expose these with custom mtk_apu_mbox_(read|write)() functions.
> 
> Signed-off-by: Karl Li <karl.li@mediatek.com>
> ---
>  drivers/mailbox/Kconfig                 |   9 +
>  drivers/mailbox/Makefile                |   2 +
>  drivers/mailbox/mtk-apu-mailbox.c       | 222 ++++++++++++++++++++++++
>  include/linux/mailbox/mtk-apu-mailbox.h |  20 +++
>  4 files changed, 253 insertions(+)
>  create mode 100644 drivers/mailbox/mtk-apu-mailbox.c
>  create mode 100644 include/linux/mailbox/mtk-apu-mailbox.h
> 
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index 6fb995778636..2338e08a110a 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -240,6 +240,15 @@ config MTK_ADSP_MBOX
>            between processors with ADSP. It will place the message to share
>  	  buffer and will access the ipc control.
>  
> +config MTK_APU_MBOX
> +	tristate "MediaTek APU Mailbox Support"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	help
> +	  Say yes here to add support for the MediaTek APU Mailbox
> +	  driver. The mailbox implementation provides access from the
> +	  application processor to the MediaTek AI Processing Unit.
> +	  If unsure say N.
> +
>  config MTK_CMDQ_MBOX
>  	tristate "MediaTek CMDQ Mailbox Support"
>  	depends on ARCH_MEDIATEK || COMPILE_TEST
> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> index 3c3c27d54c13..6b6dcc78d644 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -53,6 +53,8 @@ obj-$(CONFIG_STM32_IPCC) 	+= stm32-ipcc.o
>  
>  obj-$(CONFIG_MTK_ADSP_MBOX)	+= mtk-adsp-mailbox.o
>  
> +obj-$(CONFIG_MTK_APU_MBOX)	+= mtk-apu-mailbox.o
> +
>  obj-$(CONFIG_MTK_CMDQ_MBOX)	+= mtk-cmdq-mailbox.o
>  
>  obj-$(CONFIG_ZYNQMP_IPI_MBOX)	+= zynqmp-ipi-mailbox.o
> diff --git a/drivers/mailbox/mtk-apu-mailbox.c b/drivers/mailbox/mtk-apu-mailbox.c
> new file mode 100644
> index 000000000000..b347ebd34ef7
> --- /dev/null
> +++ b/drivers/mailbox/mtk-apu-mailbox.c
> @@ -0,0 +1,222 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 MediaTek Inc.
> + */
> +
> +#include <asm/io.h>
> +#include <linux/bits.h>
> +#include <linux/interrupt.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/mailbox/mtk-apu-mailbox.h>
> +#include <linux/platform_device.h>
> +
> +#define INBOX		(0x0)
> +#define OUTBOX		(0x20)
> +#define INBOX_IRQ	(0xc0)
> +#define OUTBOX_IRQ	(0xc4)
> +#define INBOX_IRQ_MASK	(0xd0)
> +
> +#define SPARE_OFF_START	(0x40)
> +#define SPARE_OFF_END	(0xB0)
> +
> +struct mtk_apu_mailbox {
> +	struct device *dev;
> +	void __iomem *regs;
> +	struct mbox_controller controller;
> +	u32 msgs[MSG_MBOX_SLOTS];
> +};
> +
> +struct mtk_apu_mailbox *g_mbox;

Why this is global? And why do you support only one device?

No, drop.

> +
> +static irqreturn_t mtk_apu_mailbox_irq_top_half(int irq, void *dev_id)
> +{
> +	struct mtk_apu_mailbox *mbox = dev_id;
> +	struct mbox_chan *link = &mbox->controller.chans[0];
> +	int i;
> +
> +	for (i = 0; i < MSG_MBOX_SLOTS; i++)
> +		mbox->msgs[i] = readl(mbox->regs + OUTBOX + i * sizeof(u32));
> +
> +	mbox_chan_received_data(link, &mbox->msgs);
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +

...

> +/**
> + * mtk_apu_mbox_write - Write value to specifice mtk_apu_mbox spare register.
> + * @val: Value to be written.
> + * @offset: Offset of the spare register.
> + *
> + * Return: 0 if successful
> + *	   negative value if error happened
> + */
> +int mtk_apu_mbox_write(u32 val, u32 offset)
> +{
> +	if (!g_mbox) {
> +		pr_err("mtk apu mbox was not initialized, stop writing register\n");
> +		return -ENODEV;
> +	}
> +
> +	if (offset < SPARE_OFF_START || offset >= SPARE_OFF_END) {
> +		dev_err(g_mbox->dev, "Invalid offset %d for mtk apu mbox spare register\n", offset);
> +		return -EINVAL;
> +	}
> +
> +	writel(val, g_mbox->regs + offset);
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS(mtk_apu_mbox_write, MTK_APU_MAILBOX);

Use mailbox API. This is really poor solution.

> +
> +/**
> + * mtk_apu_mbox_read - Read value to specifice mtk_apu_mbox spare register.
> + * @offset: Offset of the spare register.
> + * @val: Pointer to store read value.
> + *
> + * Return: 0 if successful
> + *	   negative value if error happened
> + */
> +int mtk_apu_mbox_read(u32 offset, u32 *val)
> +{
> +	if (!g_mbox) {
> +		pr_err("mtk apu mbox was not initialized, stop reading register\n");
> +		return -ENODEV;
> +	}
> +
> +	if (offset < SPARE_OFF_START || offset >= SPARE_OFF_END) {
> +		dev_err(g_mbox->dev, "Invalid offset %d for mtk apu mbox spare register\n", offset);
> +		return -EINVAL;
> +	}
> +
> +	*val = readl(g_mbox->regs + offset);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS(mtk_apu_mbox_read, MTK_APU_MAILBOX);
> +
> +static int mtk_apu_mailbox_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mtk_apu_mailbox *mbox;
> +	int irq = -1, ret = 0;
> +
> +	mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
> +	if (!mbox)
> +		return -ENOMEM;
> +
> +	mbox->dev = dev;
> +	platform_set_drvdata(pdev, mbox);
> +
> +	mbox->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(mbox->regs))
> +		return PTR_ERR(mbox->regs);
> +
> +	mbox->controller.txdone_irq = false;
> +	mbox->controller.txdone_poll = true;
> +	mbox->controller.txpoll_period = 1;
> +	mbox->controller.ops = &mtk_apu_mailbox_ops;
> +	mbox->controller.dev = dev;
> +	/*
> +	 * Here we only register 1 mbox channel.
> +	 * The remaining channels are used by other modules.
> +	 */
> +	mbox->controller.num_chans = 1;
> +	mbox->controller.chans = devm_kcalloc(dev, mbox->controller.num_chans,
> +					      sizeof(*mbox->controller.chans),
> +					      GFP_KERNEL);
> +	if (!mbox->controller.chans)
> +		return -ENOMEM;
> +
> +	ret = devm_mbox_controller_register(dev, &mbox->controller);
> +	if (ret)
> +		return ret;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_threaded_irq(dev, irq, mtk_apu_mailbox_irq_top_half,
> +					mtk_apu_mailbox_irq_btm_half, IRQF_ONESHOT,
> +					dev_name(dev), mbox);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to request IRQ\n");
> +
> +	g_mbox = mbox;
> +
> +	dev_dbg(dev, "registered mtk apu mailbox\n");

No, drop such stuff.

> +
> +	return 0;
> +}
> +
> +static void mtk_apu_mailbox_remove(struct platform_device *pdev)
> +{
> +	g_mbox = NULL;
> +}
> +
> +static const struct of_device_id mtk_apu_mailbox_of_match[] = {
> +	{ .compatible = "mediatek,mt8188-apu-mailbox" },
> +	{ .compatible = "mediatek,mt8196-apu-mailbox" },

So devices are compatible? Make them compatible in the binding and drop
unneeded compatible here.

Best regards,
Krzysztof


