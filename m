Return-Path: <linux-kernel+bounces-350768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB39990957
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8F61F219A1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273601CACDB;
	Fri,  4 Oct 2024 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="LXMyixRN"
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987121E3788;
	Fri,  4 Oct 2024 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059708; cv=none; b=VnuDkMHpdhEN+tAbEaanecdiMksw5E5fTfuWykUMDOM8iNHyoLGqGDjmNjQkdkAKgLgbdMbBpTIh/xHyZY3g5o1MCARPzek0CT9pmVRzooM5o6AXnCKSQ3MFSQoUc0h3YDEr93QNqa7KAykJILvBVQHlJ4cEZJAYu2fZJGmChA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059708; c=relaxed/simple;
	bh=diUUycR6+ooXPRLOO+BIOHZpS588LA7rLTJGJatDnms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g18Mf0Aj5t3fh0RRTSvEvz9clw6zqKXKfQBtw5li9x32y/ydUye3B1oZP9FnwsxuVz37d2jk1ghtBPoE4pYovfNr8inqJYcpkQDonvC5aET3+Yz+Ik4HgGknpapk6S9qU6RxJBCgl5QaKMBaM5ttXzVKJzFvnhZgKQz95LBtq0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=LXMyixRN; arc=none smtp.client-ip=80.12.242.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id wlGbsPLnFNgC2wlGbstPZy; Fri, 04 Oct 2024 18:34:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1728059698;
	bh=0M0uxOekSSBYumgofd6cg8jRm/StSafXgAMhA9nh22s=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=LXMyixRNqutaKsdCewv4YGQ6iZQOeECWvsey6Xmda2IuyePW2k8ON0Mge6rNwFu6o
	 V4pZ58jqp8BpUm+6zPmuSlBz3rQ146svxCL8Te2voBLyDqbaYU5+n23TcNRMXcgdwZ
	 efTnCD8i3/APr2Ee0QVGEoBZ83BkiEt4Y5Z4xvaFm0nSmdzmOwFmWzVBhL57qqIhXa
	 FOPYl0X5M2V8ypiS5qzLkhZuCIQzq4pxw7KcjfFyj5qVJEaQyk5OFeezleJoGSEjnf
	 VX81mSnyypCUf2UZHq/v9imAR2ZZ2jzTChLD94VyQrSifbJas5rM+b7WxJmZENw2Qu
	 caLp1Oai0uPEw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 04 Oct 2024 18:34:58 +0200
X-ME-IP: 90.11.132.44
Message-ID: <75884d07-f052-435d-9f1a-44e9e0bb755f@wanadoo.fr>
Date: Fri, 4 Oct 2024 18:34:57 +0200
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
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241004-mbly-clk-v4-4-c72c2e348e1f@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 04/10/2024 à 17:45, Théo Lebrun a écrit :
> Add Mobileye EyeQ5, EyeQ6L and EyeQ6H clock controller driver. It is
> both a platform driver and a hook onto of_clk_init() used for clocks
> required early (GIC timer, UARTs).
> 
> For some compatible, it is both at the same time. eqc_early_init()
> initialises early PLLs and stores clock array in a static linked list.
> It marks other clocks as deferred. eqc_probe() retrieves the clock
> array and adds all remaining clocks.
> 
> It exposes read-only PLLs derived from the main crystal on board.
> It also exposes another type of clocks: divider clocks.
> They always have even divisors and have one PLL as parent.
> 
> This driver also bears the responsability for optional reset and pinctrl
> auxiliary devices. The match data attached to the devicetree node
> compatible indicate if such devices should be created. They all get
> passed a pointer to the start of the OLB region.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---

Hi,

> +static void eqc_probe_init_plls(struct device *dev, struct eqc_priv *priv)
> +{
> +	const struct eqc_match_data *data = priv->data;
> +	unsigned long mult, div, acc;
> +	const struct eqc_pll *pll;
> +	struct clk_hw *hw;
> +	unsigned int i;
> +	u32 r0, r1;
> +	u64 val;
> +	int ret;
> +
> +	for (i = 0; i < data->pll_count; i++) {
> +		pll = &data->plls[i];
> +
> +		val = readq(priv->base + pll->reg64);
> +		r0 = val;
> +		r1 = val >> 32;
> +
> +		ret = eqc_pll_parse_registers(r0, r1, &mult, &div, &acc);
> +		if (ret) {
> +			dev_warn(dev, "failed parsing state of %s\n", pll->name);
> +			priv->cells->hws[pll->index] = ERR_PTR(ret);
> +			continue;
> +		}
> +
> +		hw = clk_hw_register_fixed_factor_with_accuracy_fwname(dev,
> +				dev->of_node, pll->name, "ref", 0, mult, div, acc);

Should this be freed somewhere or is it auto-magically freed by a 
put_something()?
Maybe devm_action_or_reset()?

> +		priv->cells->hws[pll->index] = hw;
> +		if (IS_ERR(hw))
> +			dev_warn(dev, "failed registering %s: %pe\n", pll->name, hw);
> +	}
> +}
> +
> +static void eqc_probe_init_divs(struct platform_device *pdev, struct device *dev,
> +				struct eqc_priv *priv)
> +{
> +	const struct eqc_match_data *data = priv->data;
> +	const struct eqc_div *div;
> +	struct clk_hw *parent;
> +	void __iomem *reg;
> +	struct clk_hw *hw;
> +	unsigned int i;
> +
> +	for (i = 0; i < data->div_count; i++) {
> +		div = &data->divs[i];
> +		reg = priv->base + div->reg;
> +		parent = priv->cells->hws[div->parent];
> +
> +		hw = clk_hw_register_divider_table_parent_hw(dev, div->name,
> +				parent, 0, reg, div->shift, div->width,
> +				CLK_DIVIDER_EVEN_INTEGERS, NULL, NULL);

Same.

CJ

> +		priv->cells->hws[div->index] = hw;
> +		if (IS_ERR(hw))
> +			dev_warn(dev, "failed registering %s: %pe\n",
> +				 div->name, hw);
> +	}
> +}

