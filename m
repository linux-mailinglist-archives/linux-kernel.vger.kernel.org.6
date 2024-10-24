Return-Path: <linux-kernel+bounces-379760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 032169AE361
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B145C283D42
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2B81CACD4;
	Thu, 24 Oct 2024 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ExhvZejg"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD941C9EB7;
	Thu, 24 Oct 2024 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767888; cv=none; b=H2rT3slFI/7M69VMoUR3D3Z+Nut3JPzlu/aY5esP7LjVBD7Cx0iY4jUsmV3YjhFXcerMkgNvkTVuWJGJpXXErFl13U5igXv4Qj13Sdm8I4iLE7SvBUFpop8naMt4zqcronHvvzlWKsCErk5C7pTbTKnqaRxg15LT0MZNun30ze4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767888; c=relaxed/simple;
	bh=I8sml6uDNlHPGmsEvOztafV3mvtBmsbMcN9VIAjLwxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3bVDTDGzuPUPg997oQJPIDEcngiKmsn4X5cJfuQ9DxKU4Q3plCcBt/eM7Fr8RuNUoUURd1T4KHMrKowWxefXNqEloio6Cm7TctTkORt7Yqbh/RvAcIXH3JQnXlduwCT1oaRx02665Gw7FbatDvRSkWMIkSVR7iahIDP62RRcXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ExhvZejg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729767878;
	bh=I8sml6uDNlHPGmsEvOztafV3mvtBmsbMcN9VIAjLwxg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ExhvZejgit+g0Twwfm0aK57iw5FIpcTNRsst/r/UXsaiCpVyLCKAhBHqqURFiRlsU
	 iIkinTxlcbwJJWE9005GnIsp7LSOfGRjwmNfPxgdMW8Ks+ruC0angQqDvpUYXzVS9j
	 1dMiUiq0mIIaHwr5tnTLkcA7gcI/x06G/zSIcIA0lVOuivd8vYjJtcQPIPxD9e0nMN
	 pUbYneasQNkklKbK6DP7+EynHDTPwyHQAbpzXQJC4IVMdRz8EWpq75RnjXHpqB9w5X
	 XcmoIV0J4230dgdnFNcNmmBxHfyrSIGBceX9MBvvwovG4iHieZIWtb0sMCuyTK5SPQ
	 ukknep0E1Xvzg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 095DA17E1524;
	Thu, 24 Oct 2024 13:04:37 +0200 (CEST)
Message-ID: <083c8f7b-0969-4ca3-8a91-35f5767c5f32@collabora.com>
Date: Thu, 24 Oct 2024 13:04:37 +0200
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
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Chungying Lu <chungying.lu@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20241024092608.431581-1-karl.li@mediatek.com>
 <20241024092608.431581-4-karl.li@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241024092608.431581-4-karl.li@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/10/24 11:25, Karl.Li ha scritto:
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
>   drivers/mailbox/Kconfig                 |   9 +
>   drivers/mailbox/Makefile                |   2 +
>   drivers/mailbox/mtk-apu-mailbox.c       | 222 ++++++++++++++++++++++++
>   include/linux/mailbox/mtk-apu-mailbox.h |  20 +++
>   4 files changed, 253 insertions(+)
>   create mode 100644 drivers/mailbox/mtk-apu-mailbox.c
>   create mode 100644 include/linux/mailbox/mtk-apu-mailbox.h
> 
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index 6fb995778636..2338e08a110a 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -240,6 +240,15 @@ config MTK_ADSP_MBOX
>             between processors with ADSP. It will place the message to share
>   	  buffer and will access the ipc control.
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
>   config MTK_CMDQ_MBOX
>   	tristate "MediaTek CMDQ Mailbox Support"
>   	depends on ARCH_MEDIATEK || COMPILE_TEST
> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> index 3c3c27d54c13..6b6dcc78d644 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -53,6 +53,8 @@ obj-$(CONFIG_STM32_IPCC) 	+= stm32-ipcc.o
>   
>   obj-$(CONFIG_MTK_ADSP_MBOX)	+= mtk-adsp-mailbox.o
>   
> +obj-$(CONFIG_MTK_APU_MBOX)	+= mtk-apu-mailbox.o
> +
>   obj-$(CONFIG_MTK_CMDQ_MBOX)	+= mtk-cmdq-mailbox.o
>   
>   obj-$(CONFIG_ZYNQMP_IPI_MBOX)	+= zynqmp-ipi-mailbox.o
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

struct mbox_controller mbox;

...it's shorter and consistent with at least other MTK mailbox drivers.

> +	u32 msgs[MSG_MBOX_SLOTS];

Just reuse struct mtk_apu_mailbox_msg instead.....

> +};
> +
> +struct mtk_apu_mailbox *g_mbox;

That global struct must disappear - and if you use the mailbox API correctly
it's even simple.

Also, you want something like....

static inline struct mtk_apu_mailbox *get_mtk_apu_mailbox(struct mbox_controller *mbox)
{
	return container_of(mbox, struct mtk_apu_mailbox, mbox);
}

> +
> +static irqreturn_t mtk_apu_mailbox_irq_top_half(int irq, void *dev_id)
> +{
static irqreturn_t mtk_apu_mailbox_irq(int irq, void *data)
{
	struct mbox_chan *chan = data;
	struct mtk_apu_mailbox = get_mtk_apu_mailbox(chan->mbox);

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
> +static irqreturn_t mtk_apu_mailbox_irq_btm_half(int irq, void *dev_id)

....mtk_apu_mailbox_irq_thread(...)

> +{
> +	struct mtk_apu_mailbox *mbox = dev_id;
> +	struct mbox_chan *link = &mbox->controller.chans[0];
> +
> +	mbox_chan_received_data_bh(link, &mbox->msgs);

I don't think that you really need this _bh variant, looks more like you wanted
to have two callbacks instead of one.

You can instead have one callback and vary functionality based based on reading
a variable to decide what to actually do inside. Not a big deal.

> +	writel(readl(mbox->regs + OUTBOX_IRQ), mbox->regs + OUTBOX_IRQ);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int mtk_apu_mailbox_send_data(struct mbox_chan *chan, void *data)
> +{
> +	struct mtk_apu_mailbox *mbox = container_of(chan->mbox,
> +						    struct mtk_apu_mailbox,
> +						    controller);
> +	struct mtk_apu_mailbox_msg *msg = data;
> +	int i;
> +
> +	if (msg->send_cnt <= 0 || msg->send_cnt > MSG_MBOX_SLOTS) {
> +		dev_err(mbox->dev, "%s: invalid send_cnt %d\n", __func__, msg->send_cnt);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 *	Mask lowest "send_cnt-1" interrupts bits, so the interrupt on the other side
> +	 *	triggers only after the last data slot is written (sent).
> +	 */
> +	writel(GENMASK(msg->send_cnt - 2, 0), mbox->regs + INBOX_IRQ_MASK);
> +	for (i = 0; i < msg->send_cnt; i++)
> +		writel(msg->data[i], mbox->regs + INBOX + i * sizeof(u32));
> +
> +	return 0;
> +}
> +
> +static bool mtk_apu_mailbox_last_tx_done(struct mbox_chan *chan)
> +{
> +	struct mtk_apu_mailbox *mbox = container_of(chan->mbox,
> +						    struct mtk_apu_mailbox,
> +						    controller);
> +
> +	return readl(mbox->regs + INBOX_IRQ) == 0;
> +}
> +
> +static const struct mbox_chan_ops mtk_apu_mailbox_ops = {
> +	.send_data = mtk_apu_mailbox_send_data,
> +	.last_tx_done = mtk_apu_mailbox_last_tx_done,
> +};
> +
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

There's something odd in what you're doing here, why would you ever need
a function that performs a writel just like that? What's the purpose?

What are you writing to the spare registers?
For which reason?

I think you can avoid (read this as: you *have to* avoid) having such a
function around.

> +	return 0;
> +}
> +EXPORT_SYMBOL_NS(mtk_apu_mbox_write, MTK_APU_MAILBOX);
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

Same goes for this one.

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

Please move the platform_get_irq call here or anyway before registering the
mbox controller: in case anything goes wrong, devm won't have to unregister
the mbox afterwards because it never got registered in the first place.

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

What other modules? I don't really see any - so please at least explain that in the
commit description.

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

pass mbox->chans to the isr

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to request IRQ\n");
> +
> +	g_mbox = mbox;
> +
> +	dev_dbg(dev, "registered mtk apu mailbox\n");
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

Just mediatek,mt8188-apu-mailbox is fine; you can allow mt8196==mt8188 in the
binding instead.

> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, mtk_apu_mailbox_of_match);
> +
> +static struct platform_driver mtk_apu_mailbox_driver = {
> +	.probe = mtk_apu_mailbox_probe,
> +	.remove = mtk_apu_mailbox_remove,

You don't need this remove callback, since g_mbox has to disappear :-)

> +	.driver = {
> +		.name = "mtk-apu-mailbox",
> +		.of_match_table = mtk_apu_mailbox_of_match,
> +	},
> +};
> +
> +module_platform_driver(mtk_apu_mailbox_driver);
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("MediaTek APU Mailbox Driver");
> diff --git a/include/linux/mailbox/mtk-apu-mailbox.h b/include/linux/mailbox/mtk-apu-mailbox.h
> new file mode 100644
> index 000000000000..d1457d16ce9b
> --- /dev/null
> +++ b/include/linux/mailbox/mtk-apu-mailbox.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2024 MediaTek Inc.
> + *
> + */
> +
> +#ifndef __MTK_APU_MAILBOX_H__
> +#define __MTK_APU_MAILBOX_H__
> +
> +#define MSG_MBOX_SLOTS	(8)
> +
> +struct mtk_apu_mailbox_msg {
> +	int send_cnt;

u8 data_cnt;

> +	u32 data[MSG_MBOX_SLOTS];

With hardcoded slots, what happens when we get a new chip in the future that
supports more slots?

Please think about this now and make the implementation flexible before that
happens because, at a later time, it'll be harder.

Regards,
Angelo

> +};
> +
> +int mtk_apu_mbox_write(u32 val, u32 offset);
> +int mtk_apu_mbox_read(u32 offset, u32 *val);
> +
> +#endif /* __MTK_APU_MAILBOX_H__ */


