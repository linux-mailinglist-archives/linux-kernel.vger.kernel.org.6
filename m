Return-Path: <linux-kernel+bounces-256293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8063A934C25
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3567828143E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1775F12D1FC;
	Thu, 18 Jul 2024 11:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="qQxVXHas"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47364639;
	Thu, 18 Jul 2024 11:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721300573; cv=none; b=hmlo7tBiSmcU0v36cKLlGuync8ny10y9iagAyJYtngpAGTWmJFmIfdLW3VkQkzDJ+y5nb7T9MUp/kUDlwTev0JudrhzEEAETB0b+ViZA1aJy8tn2ns2pOIU8H8ZxPDsQKJ1JKL8fB7vJ/z4tDkmZJ1gUdhK/gI4Zb+L0PPrTbFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721300573; c=relaxed/simple;
	bh=X/HQm62ChmQqbf7vNuPH4/wMzrEn5xIr+iFUFrsKV1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Zt2S/aGQ+QDYfW2oOCA/z+DphOUaZu4R+H88mUMD2nW4U21c3/vcZR0WKaXqX64ePLInzCPYD9O/qhHdY8L66J0ebbf6JKFrFczHwRbOZju3gFrE4K50ynM2edV1UmfPib18kdDWq9KmmJeX5NIW+6eZ5DV2l8Pok+xZR/3wi1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=qQxVXHas; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 80F4412000C;
	Thu, 18 Jul 2024 14:02:44 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 80F4412000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1721300564;
	bh=ZDQSOG3k8ZUK0B9MteuPszxC5L5ry7AyEP36vu1Itk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=qQxVXHasMXN8r6lXaxzAK9/pPEFCfPJsyUPD988Ue1spPsgnoOsWmqwvdC1ftnMOb
	 dsxjiA4h04AvZ3Ixut7YqRJ6sNrxLZKufHxHAqBYzkHiibPzelpEDt6tep00Y344Dk
	 JwRqcyheNhncy7xR3EGERiFALa9duR9cWrcDKtFXPoVj2yrjuzIboe7H8zQdM1s/dQ
	 fNlfAWIy1/6ZfTRXvvkHQew4ELq/jpTXycmZQFT8wULxZwOXy7syS8YlOxbdGo+aiJ
	 WsapW2y8e3qv5qnuk84AZukVVnXAwnBayXUUAIGwRoETgnmU7feV8PfV++P0kdK+QQ
	 xtfn0sN5GJBgg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 18 Jul 2024 14:02:44 +0300 (MSK)
Received: from [172.28.192.11] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 18 Jul 2024 14:02:43 +0300
Message-ID: <f5bc9590-f37e-491e-9978-c1eab8914c30@salutedevices.com>
Date: Thu, 18 Jul 2024 14:01:28 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] reset: amlogic: convert driver to regmap
To: Jerome Brunet <jbrunet@baylibre.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>, <linux-kernel@vger.kernel.org>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>
References: <20240710162526.2341399-1-jbrunet@baylibre.com>
 <20240710162526.2341399-2-jbrunet@baylibre.com>
 <b12ac6b2-cb46-4410-9846-86ed4c3aea1f@salutedevices.com>
 <1jv813makr.fsf@starbuckisacylon.baylibre.com>
Content-Language: en-US
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <1jv813makr.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186588 [Jul 18 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24 186c4d603b899ccfd4883d230c53f273b80e467f, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/18 08:29:00 #26061289
X-KSMG-AntiVirus-Status: Clean, skipped



On 7/18/24 10:19, Jerome Brunet wrote:
> On Thu 18 Jul 2024 at 05:39, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:
> 
>> On 7/10/24 19:25, Jerome Brunet wrote:
>>> To allow using the same driver for the main reset controller and the
>>> auxiliary ones embedded in the clock controllers, convert the
>>> the Amlogic reset driver to regmap.
>>>
>>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>>> ---
>>>  drivers/reset/reset-meson.c | 80 ++++++++++++++++++++-----------------
>>>  1 file changed, 44 insertions(+), 36 deletions(-)
>>>
>>> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
>>> index f78be97898bc..8f3d6e9df235 100644
>>> --- a/drivers/reset/reset-meson.c
>>> +++ b/drivers/reset/reset-meson.c
>>> @@ -11,36 +11,44 @@
>>>  #include <linux/of.h>
>>>  #include <linux/module.h>
>>>  #include <linux/platform_device.h>
>>> +#include <linux/regmap.h>
>>>  #include <linux/reset-controller.h>
>>>  #include <linux/slab.h>
>>>  #include <linux/types.h>
>>>  
>>> -#define BITS_PER_REG	32
>>> -
>>>  struct meson_reset_param {
>>>  	int reg_count;
>>>  	int level_offset;
>>>  };
>>>  
>>>  struct meson_reset {
>>> -	void __iomem *reg_base;
>>>  	const struct meson_reset_param *param;
>>>  	struct reset_controller_dev rcdev;
>>> -	spinlock_t lock;
>>> +	struct regmap *map;
>>>  };
>>>  
>>> +static void meson_reset_offset_and_bit(struct meson_reset *data,
>>> +				       unsigned long id,
>>> +				       unsigned int *offset,
>>> +				       unsigned int *bit)
>>> +{
>>> +	unsigned int stride = regmap_get_reg_stride(data->map);
>>> +
>>> +	*offset = (id / (stride * BITS_PER_BYTE)) * stride;
>>> +	*bit = id % (stride * BITS_PER_BYTE);
>>> +}
>>> +
>>>  static int meson_reset_reset(struct reset_controller_dev *rcdev,
>>> -			      unsigned long id)
>>> +			     unsigned long id)
>>>  {
>>>  	struct meson_reset *data =
>>>  		container_of(rcdev, struct meson_reset, rcdev);
>>> -	unsigned int bank = id / BITS_PER_REG;
>>> -	unsigned int offset = id % BITS_PER_REG;
>>> -	void __iomem *reg_addr = data->reg_base + (bank << 2);
>>> +	unsigned int offset, bit;
>>>  
>>> -	writel(BIT(offset), reg_addr);
>>> +	meson_reset_offset_and_bit(data, id, &offset, &bit);
>>>  
>>> -	return 0;
>>> +	return regmap_update_bits(data->map, offset,
>>> +				  BIT(bit), BIT(bit));
>>
>> regmap_update_bits() is not equal to writel(), I suppose regmap_write()
>> should be here.
>>
>> I'm still under testing, but I see unexpected behavior on A1 SoC:
>>
>> [    1.482446] Call trace:
>> [    1.484860]  dump_backtrace+0x94/0xec
>> [    1.488482]  show_stack+0x18/0x24
>> [    1.491754]  dump_stack_lvl+0x78/0x90
>> [    1.495377]  dump_stack+0x18/0x24
>> [    1.498654]  __report_bad_irq+0x38/0xe4
>> [    1.502453]  note_interrupt+0x324/0x374
>> [    1.506244]  handle_irq_event+0x9c/0xac
>> [    1.510039]  handle_fasteoi_irq+0xa4/0x238
>> [    1.514093]  generic_handle_domain_irq+0x2c/0x44
>> [    1.518664]  gic_handle_irq+0x40/0xc4
>> [    1.522287]  call_on_irq_stack+0x24/0x4c
>> [    1.526168]  do_interrupt_handler+0x80/0x84
>> [    1.530308]  el1_interrupt+0x34/0x68
>> [    1.533844]  el1h_64_irq_handler+0x18/0x24
>> [    1.537898]  el1h_64_irq+0x64/0x68
>> [    1.541262]  default_idle_call+0x28/0x3c
>> [    1.545143]  do_idle+0x208/0x260
>> [    1.548334]  cpu_startup_entry+0x38/0x3c
>> [    1.552220]  kernel_init+0x0/0x1dc
>> [    1.555579]  start_kernel+0x5ac/0x6f0
>> [    1.559206]  __primary_switched+0x80/0x88
> 
> That stack trace is not helping
> >>
>>
>> and using of regmap_write() (apparently) fixes it.
> 
> Nor does that conclusion.
> > It is perfectly possible I have made mistake somewhere (I have already
> fixed one in v2), but sending incomplete report like this, with
> unargumented conclusion is just noise in the end.
> 
> No, there is no situation in which `regmap_write` would solve a problem
> with `regmap_update_bits`.
> 

What is the default regs' value of this reset controller? The doc that I
have doesn't clearly specifies it, but it tells that "the reset will
auto-cover to 0 by HW". However pr_info() say that there is 0xffffffff
before write (I am talking about A1).

Also we know, that reset is triggered by writing 1 to specific bit. So,
what will happen if 1 will be written where we did not intend to write it?

> Either send a full analysis of the problem you found, if you did one, or
> at least send the full dump, explaining that you don't know what is
> happening.
> 

Full analysis is following:
- using regmap_update_bits() instead of writel() is incorrect because
this changes the behavior of the driver
- regmap_update_bits() should not be used here because default value of
regs isn't taken into account and (_apparently_, the doc is terse) these
regs could be updated by hw itself.

> I'll also point that I did not send g12 clock along with v1 and that a1
> support is not upstream or even reviewed. So this 'tests' obviously rely
> on an integration of v1, rfc and your custom develpment. That is hardly a
> reference at this point.
> 
> This patches address g12 and sm1. If you want to contribute with tests,
> please test on these platforms. a1 will be addressed in due time.
> 

Where did you find in my words any reference to not upstreamed
functionality? Support of A1 SoC is here since commit bdb369e1e98a
("reset: add support for the Meson-A1 SoC Reset Controller").

> Testing is good but making complete report (trace and environment
> details) is equally important, especially for maintainers who might not
> be following Amlogic development as much as you do.
> 
>>
>>>  }
>>>  
>>>  static int meson_reset_level(struct reset_controller_dev *rcdev,
>>> @@ -48,25 +56,13 @@ static int meson_reset_level(struct reset_controller_dev *rcdev,
>>>  {
>>>  	struct meson_reset *data =
>>>  		container_of(rcdev, struct meson_reset, rcdev);
>>> -	unsigned int bank = id / BITS_PER_REG;
>>> -	unsigned int offset = id % BITS_PER_REG;
>>> -	void __iomem *reg_addr;
>>> -	unsigned long flags;
>>> -	u32 reg;
>>> +	unsigned int offset, bit;
>>>  
>>> -	reg_addr = data->reg_base + data->param->level_offset + (bank << 2);
>>> +	meson_reset_offset_and_bit(data, id, &offset, &bit);
>>> +	offset += data->param->level_offset;
>>>  
>>> -	spin_lock_irqsave(&data->lock, flags);
>>> -
>>> -	reg = readl(reg_addr);
>>> -	if (assert)
>>> -		writel(reg & ~BIT(offset), reg_addr);
>>> -	else
>>> -		writel(reg | BIT(offset), reg_addr);
>>> -
>>> -	spin_unlock_irqrestore(&data->lock, flags);
>>> -
>>> -	return 0;
>>> +	return regmap_update_bits(data->map, offset,
>>> +				  BIT(bit), assert ? 0 : BIT(bit));
>>>  }
>>>  
>>>  static int meson_reset_assert(struct reset_controller_dev *rcdev,
>>> @@ -113,30 +109,42 @@ static const struct of_device_id meson_reset_dt_ids[] = {
>>>  };
>>>  MODULE_DEVICE_TABLE(of, meson_reset_dt_ids);
>>>  
>>> +static const struct regmap_config regmap_config = {
>>> +	.reg_bits   = 32,
>>> +	.val_bits   = 32,
>>> +	.reg_stride = 4,
>>> +};
>>> +
>>>  static int meson_reset_probe(struct platform_device *pdev)
>>>  {
>>> +	struct device *dev = &pdev->dev;
>>>  	struct meson_reset *data;
>>> +	void __iomem *base;
>>>  
>>> -	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>>> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>>>  	if (!data)
>>>  		return -ENOMEM;
>>>  
>>> -	data->reg_base = devm_platform_ioremap_resource(pdev, 0);
>>> -	if (IS_ERR(data->reg_base))
>>> -		return PTR_ERR(data->reg_base);
>>> +	base = devm_platform_ioremap_resource(pdev, 0);
>>> +	if (IS_ERR(base))
>>> +		return PTR_ERR(base);
>>>  
>>> -	data->param = of_device_get_match_data(&pdev->dev);
>>> +	data->param = of_device_get_match_data(dev);
>>>  	if (!data->param)
>>>  		return -ENODEV;
>>>  
>>> -	spin_lock_init(&data->lock);
>>> +	data->map = devm_regmap_init_mmio(dev, base, &regmap_config);
>>> +	if (IS_ERR(data->map))
>>> +		return dev_err_probe(dev, PTR_ERR(data->map),
>>> +				     "can't init regmap mmio region\n");
>>>  
>>>  	data->rcdev.owner = THIS_MODULE;
>>> -	data->rcdev.nr_resets = data->param->reg_count * BITS_PER_REG;
>>> +	data->rcdev.nr_resets = data->param->reg_count * BITS_PER_BYTE
>>> +		* regmap_config.reg_stride;
>>>  	data->rcdev.ops = &meson_reset_ops;
>>> -	data->rcdev.of_node = pdev->dev.of_node;
>>> +	data->rcdev.of_node = dev->of_node;
>>>  
>>> -	return devm_reset_controller_register(&pdev->dev, &data->rcdev);
>>> +	return devm_reset_controller_register(dev, &data->rcdev);
>>>  }
>>>  
>>>  static struct platform_driver meson_reset_driver = {
> 

-- 
Best regards
Jan Dakinevich

