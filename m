Return-Path: <linux-kernel+bounces-386363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3291F9B4271
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CAEC1C21347
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 06:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6275201253;
	Tue, 29 Oct 2024 06:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXVnYPEf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97A91E0B93;
	Tue, 29 Oct 2024 06:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730183757; cv=none; b=SEBoAaSavwn99zKbAfmxteuDAr1R/G/d8tspJawjn5jiBhHMExqSidFkAH9m4fkmmPt0aX+r8gxWfdcxDdgRRQeKnDA/t9OLxHuU2DJkrAC+XIwWjJ/ZU59CYvhUGPKjYKDTp7gQhHETRzoG6HktJ+8BEGHEs1MIVVYoDLBmTlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730183757; c=relaxed/simple;
	bh=uA9DtpHsaaw4aJ5j/ZBnH/JfArY2z5mmvy4OnUx8YrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6mZRdSbcHEPEw7iFLc4vm670pK65tLXCVBSc1RkhJwqSSLUOfhO/YQrSO7B4kR1sRfIl8q/kG9WdQZMHnQD4RS7uuxZFV2BC84+LY/G7qeRem7WF9pR/1wzkiKZhL0gWA7phsz363H3jPsV2VGbzBQEuqB1BD+pgQB+pZldKbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXVnYPEf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB41BC4CEE3;
	Tue, 29 Oct 2024 06:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730183757;
	bh=uA9DtpHsaaw4aJ5j/ZBnH/JfArY2z5mmvy4OnUx8YrU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qXVnYPEfpnMU1LeBFN7iKmIRiOVK+FH/Sb92vdU6OI2nacWdbvVwfCQGlsUCPhVzw
	 SSY47GC6oC2J6HPda3Hi6sUNw3D8pQWAZ+QHvz7+8iVwRAmzpYrOr9137uxD2gVRK2
	 rDPLJaYsc/TL0Az/VnFVxyl+niU+KmqYqsBG+LaRdZC6M6wmsX4e2UXsc+KZQLvOdQ
	 39gOScq0A0KSj/81t7zHxeGk8bSCixiuwLfs6DgsY3nNdMVRV7xTsU6b9L0oA2NGUT
	 +AnhniCdgPfbHqokStGkD4H65f3RvAjKdwmZQC6RgUISJCMvAIE1iO/GucFF0i1gE/
	 e59DMDDnULgOQ==
Message-ID: <05ee7331-c582-49ff-9f4e-2eee13f3a429@kernel.org>
Date: Tue, 29 Oct 2024 07:35:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] reset: mediatek: Add reset control driver for SMI
To: =?UTF-8?B?RnJpZGF5IFlhbmcgKOadqOmYsyk=?= <Friday.Yang@mediatek.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20240821082845.11792-1-friday.yang@mediatek.com>
 <20240821082845.11792-5-friday.yang@mediatek.com>
 <ce9a7ea1-67bc-42b8-836d-11932dcf3790@kernel.org>
 <2ef870eb2f654667723f7f2d38e7532a7d3cfc84.camel@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <2ef870eb2f654667723f7f2d38e7532a7d3cfc84.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/10/2024 03:29, Friday Yang (杨阳) wrote:
> On Wed, 2024-08-21 at 10:58 +0200, Krzysztof Kozlowski wrote:
>>  	 
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>  On 21/08/2024 10:26, friday.yang wrote:
>>> Add a reset-controller driver for performing reset management of
>>> SMI LARBs on MediaTek platform. This driver uses the regmap
>>> frameworks to actually implement the various reset functions
>>> needed when SMI LARBs apply clamp operations.
>>
>> How does this depend on memory controller patches? Why is this
>> grouped
>> in one patchset?
>>
> 
> How about changing it like this,
> patchset1:
> (1)SMI reset control driver
> (2)SMI reset bindings
> patchset2
> (1)SMI driver
> (2)SMI bindings
> 
>>>
>>> Signed-off-by: friday.yang <friday.yang@mediatek.com>
>>> ---
>>>  drivers/reset/Kconfig              |   9 ++
>>>  drivers/reset/Makefile             |   1 +
>>>  drivers/reset/reset-mediatek-smi.c | 152
>> +++++++++++++++++++++++++++++
>>>  3 files changed, 162 insertions(+)
>>>  create mode 100644 drivers/reset/reset-mediatek-smi.c
>>>
>>> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
>>> index 67bce340a87e..e984a5a332f1 100644
>>> --- a/drivers/reset/Kconfig
>>> +++ b/drivers/reset/Kconfig
>>> @@ -154,6 +154,15 @@ config RESET_MESON_AUDIO_ARB
>>>    This enables the reset driver for Audio Memory Arbiter of
>>>    Amlogic's A113 based SoCs
>>>  
>>> +config RESET_MTK_SMI
>>> +bool "MediaTek SMI Reset Driver"
>>> +depends on MTK_SMI
>>
>> compile test
> 
> Thanks, I will fix it to 'depends on MTK_SMI || COMPILE_TEST'
> 
>>
>>> +help
>>> +  This option enables the reset controller driver for MediaTek
>> SMI.
>>> +  This reset driver is responsible for managing the reset signals
>>> +  for SMI larbs. Say Y if you want to control reset signals for
>>> +  MediaTek SMI larbs. Otherwise, say N.
>>> +
>>>  config RESET_NPCM
>>>  bool "NPCM BMC Reset Driver" if COMPILE_TEST
>>>  default ARCH_NPCM
>>> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
>>> index 27b0bbdfcc04..241777485b40 100644
>>> --- a/drivers/reset/Makefile
>>> +++ b/drivers/reset/Makefile
>>> @@ -22,6 +22,7 @@ obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
>>>  obj-$(CONFIG_RESET_MCHP_SPARX5) += reset-microchip-sparx5.o
>>>  obj-$(CONFIG_RESET_MESON) += reset-meson.o
>>>  obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
>>> +obj-$(CONFIG_RESET_MTK_SMI) += reset-mediatek-smi.o
>>>  obj-$(CONFIG_RESET_NPCM) += reset-npcm.o
>>>  obj-$(CONFIG_RESET_NUVOTON_MA35D1) += reset-ma35d1.o
>>>  obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
>>> diff --git a/drivers/reset/reset-mediatek-smi.c
>> b/drivers/reset/reset-mediatek-smi.c
>>> new file mode 100644
>>> index 000000000000..ead747e80ad5
>>> --- /dev/null
>>> +++ b/drivers/reset/reset-mediatek-smi.c
>>> @@ -0,0 +1,152 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Reset driver for MediaTek SMI module
>>> + *
>>> + * Copyright (C) 2024 MediaTek Inc.
>>> + */
>>> +
>>> +#include <linux/mfd/syscon.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/reset-controller.h>
>>> +
>>> +#include <dt-bindings/reset/mt8188-resets.h>
>>> +
>>> +#define to_mtk_smi_reset_data(_rcdev)\
>>> +container_of(_rcdev, struct mtk_smi_reset_data, rcdev)
>>> +
>>> +struct mtk_smi_larb_reset {
>>> +unsigned int offset;
>>> +unsigned int value;
>>> +};
>>> +
>>> +static const struct mtk_smi_larb_reset rst_signal_mt8188[] = {
>>> +[MT8188_SMI_RST_LARB10]= { 0xC, BIT(0) }, /* larb10 */
>>> +[MT8188_SMI_RST_LARB11A]= { 0xC, BIT(0) }, /* larb11a */
>>> +[MT8188_SMI_RST_LARB11C]= { 0xC, BIT(0) }, /* larb11c */
>>> +[MT8188_SMI_RST_LARB12]= { 0xC, BIT(8) }, /* larb12 */
>>> +[MT8188_SMI_RST_LARB11B]= { 0xC, BIT(0) }, /* larb11b */
>>> +[MT8188_SMI_RST_LARB15]= { 0xC, BIT(0) }, /* larb15 */
>>> +[MT8188_SMI_RST_LARB16B]= { 0xA0, BIT(4) }, /* larb16b */
>>> +[MT8188_SMI_RST_LARB17B]= { 0xA0, BIT(4) }, /* larb17b */
>>> +[MT8188_SMI_RST_LARB16A]= { 0xA0, BIT(4) }, /* larb16a */
>>> +[MT8188_SMI_RST_LARB17A]= { 0xA0, BIT(4) }, /* larb17a */
>>> +};
>>> +
>>> +struct mtk_smi_larb_plat {
>>> +const struct mtk_smi_larb_reset*reset_signal;
>>> +const unsigned intlarb_reset_nr;
>>> +};
>>> +
>>> +struct mtk_smi_reset_data {
>>> +const struct mtk_smi_larb_plat *larb_plat;
>>> +struct reset_controller_dev rcdev;
>>> +struct regmap *regmap;
>>> +};
>>> +
>>> +static const struct mtk_smi_larb_plat mtk_smi_larb_mt8188 = {
>>> +.reset_signal = rst_signal_mt8188,
>>> +.larb_reset_nr = ARRAY_SIZE(rst_signal_mt8188),
>>> +};
>>> +
>>> +static int mtk_smi_larb_reset(struct reset_controller_dev *rcdev,
>> unsigned long id)
>>> +{
>>> +struct mtk_smi_reset_data *data = to_mtk_smi_reset_data(rcdev);
>>> +const struct mtk_smi_larb_plat *larb_plat = data->larb_plat;
>>> +const struct mtk_smi_larb_reset *larb_rst = larb_plat-
>>> reset_signal + id;
>>> +int ret;
>>> +
>>> +ret = regmap_set_bits(data->regmap, larb_rst->offset, larb_rst-
>>> value);
>>> +if (ret)
>>> +return ret;
>>> +ret = regmap_clear_bits(data->regmap, larb_rst->offset, larb_rst-
>>> value);
>>> +
>>> +return ret;
>>> +}
>>> +
>>> +static int mtk_smi_larb_reset_assert(struct reset_controller_dev
>> *rcdev, unsigned long id)
>>> +{
>>> +struct mtk_smi_reset_data *data = to_mtk_smi_reset_data(rcdev);
>>> +const struct mtk_smi_larb_plat *larb_plat = data->larb_plat;
>>> +const struct mtk_smi_larb_reset *larb_rst = larb_plat-
>>> reset_signal + id;
>>> +int ret;
>>> +
>>> +ret = regmap_set_bits(data->regmap, larb_rst->offset, larb_rst-
>>> value);
>>> +if (ret)
>>> +dev_err(rcdev->dev, "[%s] Failed to shutdown larb %d\n", __func__,
>> ret);
>>> +
>>> +return ret;
>>> +}
>>> +
>>> +static int mtk_smi_larb_reset_deassert(struct reset_controller_dev
>> *rcdev, unsigned long id)
>>> +{
>>> +struct mtk_smi_reset_data *data = to_mtk_smi_reset_data(rcdev);
>>> +const struct mtk_smi_larb_plat *larb_plat = data->larb_plat;
>>> +const struct mtk_smi_larb_reset *larb_rst = larb_plat-
>>> reset_signal + id;
>>> +int ret;
>>> +
>>> +ret = regmap_clear_bits(data->regmap, larb_rst->offset, larb_rst-
>>> value);
>>> +if (ret)
>>> +dev_err(rcdev->dev, "[%s] Failed to reopen larb %d\n", __func__,
>> ret);
>>> +
>>> +return ret;
>>> +}
>>> +
>>> +static const struct reset_control_ops mtk_smi_reset_ops = {
>>> +.reset= mtk_smi_larb_reset,
>>> +.assert= mtk_smi_larb_reset_assert,
>>> +.deassert= mtk_smi_larb_reset_deassert,
>>> +};
>>> +
>>> +static int mtk_smi_reset_probe(struct platform_device *pdev)
>>> +{
>>> +struct device *dev = &pdev->dev;
>>> +const struct mtk_smi_larb_plat *larb_plat =
>> of_device_get_match_data(dev);
>>> +struct device_node *np = dev->of_node, *reset_node;
>>> +struct mtk_smi_reset_data *data;
>>> +struct regmap *regmap;
>>> +
>>> +data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>>> +if (!data)
>>> +return -ENOMEM;
>>> +
>>> +reset_node = of_parse_phandle(np, "mediatek,larb-rst-syscon", 0);
>>> +if (!reset_node)
>>
>> This looks just wrong. This looks like a child of whatever phandle
>> points here.
>>
>> Why do you create MMIO-using node as not MMIO?
>>
> 
> This is the definition for imgsys1_dip_top and imgsys1_dip_top_rst.
> SMI reset controller driver parse the 'mediatek,larb-rst-syscon'
> to get the 'imgsys1_dip_top' device node and regmap.
> Then SMI driver could read and write the register by the regmap
> to apply reset operations here.
> 
> 	imgsys1_dip_top: clock-controller@15110000 {
> 		compatible = "mediatek,mt8188-imgsys1-dip-top";
> 		reg = <0 0x15110000 0 0x1000>;
> 		#clock-cells = <1>;
> 	};
> 
> 	imgsys1_dip_top_rst: reset-controller0 {
> 		compatible = "mediatek,smi-reset-mt8188";
> 		#reset-cells = <1>;
> 		mediatek,larb-rst-syscon = <&imgsys1_dip_top>;

This is obviously incorrect DTS code. Run standard checks on your DTS
code first.


> 	};
> 	
> 	larb10: smi@15120000{
> 		resets = <&imgsys1_dip_top_rst MT8188_SMI_RST_LARB10>;
> 		reset-names = "larb_rst";
> 	};
> 
> I am not so sure the meaning "MMIO-using" here. 

You pretend that something is MMIO but you do not use it as MMIO.

Anyway, this was 2 months ago, I lost all the context, all the emails
and I am not going back.

Respond to feedback in reasonable time, if you want to keep discussion
going.

All this is so far: NAK

Best regards,
Krzysztof


