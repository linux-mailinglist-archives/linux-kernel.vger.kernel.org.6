Return-Path: <linux-kernel+bounces-351441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA7899113E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 23:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1391C23701
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 21:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6B0231CAC;
	Fri,  4 Oct 2024 21:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="XiLSxzr7"
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE7F83CC7;
	Fri,  4 Oct 2024 21:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728076911; cv=none; b=syV92irpCT+dGGJNgVMc01RCJFWRvcuxa8mGxJuAnrHzyspyzTTI9kMNB1x6LemVJS244yZDGJ4s2f+XKjajr5e3ORH2ZFNahg8jLvNjU/PPnHujxB8dX5EoNwfEYhMeBwJSxpvwvlJ9K2uOcxiFB3Or/9MUdPpR31Ayga4GZmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728076911; c=relaxed/simple;
	bh=6GcKyhloN4GANHNYMbyds7oq2HhvQnkSfXd8F0xWXY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twbSuI7QYmhsa4Q0OHdD0qmgfgDAmQqQgDBRDUd6JT/KYFUKDY6jslOWsIL3JboTxVhGtrMozZvADsGlHHsGq3fHrAbb7pEpBBU6kMXD7XaAkXbu5/9Jv5KsdNIisyQoEt06dOJ3rxW2lV7Y8CR93WPsBu0VvrojuimHAewXWos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=XiLSxzr7; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id wpixsDSdxDZIAwpj0svTBI; Fri, 04 Oct 2024 23:20:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1728076835;
	bh=rXaWLfvU0d1YuQl1F4v9J51EjQC/lsdynJrwZhlFI/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=XiLSxzr7/1ktmr/6cZudt/x+6ENoOXOOdQdXe5rMuqEuGCxwLHzqBWdWNZgwXqac2
	 Wn8IZxQCLltv5LTy0zs0AQx/z12Xk33l9bg+oxEoFTOknudA64BYuk99uuElyq7hYY
	 83pFo0Vjx6ymhkdwymSBE+1qn824IPS6tMvdQC5CY/yCH+uisSwS1fde2s88j3HUDU
	 FN1/fI7ym3KPaMS+jf9tTbG94loLJ8zv89NMcw8BudZelk6T/siRFajGQrCUClqfLm
	 EwU0w8Mz1gB+jg79U4R7mhuQeBwV/HmPrOtYBJFU/qXUzSweKhSKivaEYCgu/Vw5/v
	 EcpBcGMfgF6+w==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 04 Oct 2024 23:20:35 +0200
X-ME-IP: 90.11.132.44
Message-ID: <8334a319-96e4-4249-9659-132c8698c895@wanadoo.fr>
Date: Fri, 4 Oct 2024 23:20:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] clk: eyeq: add driver
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>
References: <20241004-mbly-clk-v4-0-c72c2e348e1f@bootlin.com>
 <20241004-mbly-clk-v4-4-c72c2e348e1f@bootlin.com>
 <75884d07-f052-435d-9f1a-44e9e0bb755f@wanadoo.fr>
 <D4N6GX6P0ZCH.2PJGDMKEZ6LLQ@bootlin.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <D4N6GX6P0ZCH.2PJGDMKEZ6LLQ@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 04/10/2024 à 18:55, Théo Lebrun a écrit :
> Hello Christophe,
> 
> On Fri Oct 4, 2024 at 6:34 PM CEST, Christophe JAILLET wrote:
>> Le 04/10/2024 à 17:45, Théo Lebrun a écrit :
>>> +static void eqc_probe_init_plls(struct device *dev, struct eqc_priv *priv)
>>> +{
>>> +	const struct eqc_match_data *data = priv->data;
>>> +	unsigned long mult, div, acc;
>>> +	const struct eqc_pll *pll;
>>> +	struct clk_hw *hw;
>>> +	unsigned int i;
>>> +	u32 r0, r1;
>>> +	u64 val;
>>> +	int ret;
>>> +
>>> +	for (i = 0; i < data->pll_count; i++) {
>>> +		pll = &data->plls[i];
>>> +
>>> +		val = readq(priv->base + pll->reg64);
>>> +		r0 = val;
>>> +		r1 = val >> 32;
>>> +
>>> +		ret = eqc_pll_parse_registers(r0, r1, &mult, &div, &acc);
>>> +		if (ret) {
>>> +			dev_warn(dev, "failed parsing state of %s\n", pll->name);
>>> +			priv->cells->hws[pll->index] = ERR_PTR(ret);
>>> +			continue;
>>> +		}
>>> +
>>> +		hw = clk_hw_register_fixed_factor_with_accuracy_fwname(dev,
>>> +				dev->of_node, pll->name, "ref", 0, mult, div, acc);
>>
>> Should this be freed somewhere or is it auto-magically freed by a
>> put_something()?
>> Maybe devm_action_or_reset()?
> 
> This driver does not support being removed. It provides essential PLLs
> and the system has not chance of working without them.
> 
> Almost all instances will be instantiated at of_clk_init() stage by the
> way (ie before platform bus infrastructure init). Devres isn't a
> solution in those cases.

eqc_probe_init_plls() and eqc_probe_init_divs() are called from 
eqc_probe(), which has several devm_ function calls.

Would it make sense to remove these devm_ ?


devm_platform_ioremap_resource(),
devm_kzalloc(),
devm_of_clk_add_hw_provider(),
eqc_auxdev_create() which calls devm_add_action_or_reset().

I sent this patch because of these calls.

Either I miss something, either maybe things can be simplified.

CJ


> 
> We are missing suppress_bind_attrs though.
> I can add that at next revision.
> 
> Thanks,
> 
> --
> Théo Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 
> 
> 


