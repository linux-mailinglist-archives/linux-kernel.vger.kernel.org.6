Return-Path: <linux-kernel+bounces-263159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F120693D1CE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279FF1C21D9E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A69A179965;
	Fri, 26 Jul 2024 11:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXa26red"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0241EF01;
	Fri, 26 Jul 2024 11:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721992411; cv=none; b=VMkyrtlhhHjv3i6Al9jQhfDKAZE2jbnzCvZquoipCg4u3emSMDqAjzmYzDers3EfF7wBfjqtaiRf/Xi1oHm5l6CQcN/Pzxxv2wGH4SkjNuJnYOH0R/C7ojGDhXddU2wQa+noyHbA4SkQwVQf1drii+2uCR1Rq44CWhpNkEjpmOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721992411; c=relaxed/simple;
	bh=GNp9b/IbFjkf96tOw/CL5ZPG53qyTDcT5rRgtMXQgqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aMgJ+2nIuRZeB1f770Tj279yYbYaBzZC3IRtdjE+wKI/DYW3GZpcWMkdpi3xVMLMyjKdQQvEkG2iQoJeqJYeYNZ2Mj/7/rVdARH2cbwC+KvD0hvoQAT8nBNVanpq9LwZ2jlILSKO05uKHzCY8YW2KZXzUTluPste/KU64kWw/F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXa26red; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4C4C32782;
	Fri, 26 Jul 2024 11:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721992411;
	bh=GNp9b/IbFjkf96tOw/CL5ZPG53qyTDcT5rRgtMXQgqE=;
	h=Date:Subject:List-Id:To:References:From:In-Reply-To:From;
	b=NXa26redIdNrVjfG0/5i/+L+ZCff5HQ3EHvHaCB5Z3S6jtCyz3hMaSSohlnBqqvgi
	 K9oviVnCRvWnsEZsYdsOAeWAf5/9DEC4y2hsl2PMvVHzX0tPhixxH7cR7a5J9PAsXj
	 q7N8yMOaa5gD7NROpBjmBsJsjVLciRqQjZTfCPGaAs7EkK31lHZDLY2M3qeQYST3Ee
	 Agmu0i+OQJcmejsZLGx1GjbZ3ROPwrsSYmpcJanWwgxy3yx5ZT6sycJN2gJmQg1d5C
	 0Yci5i6M/s7QpLrd1gXollKKZK+ZosJGvMv5Rmb8ugscTGQKTsd47/P7NCqOgjDrlN
	 cmEgIEt9mKWIg==
Message-ID: <fb3489cf-b288-426e-ace0-abf1d6b0fe0c@kernel.org>
Date: Fri, 26 Jul 2024 13:13:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/10] clk: ast2700: add clock controller
To: Kevin Chen <kevin_chen@aspeedtech.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
 andrew@codeconstruct.com.au, lee@kernel.org, catalin.marinas@arm.com,
 will@kernel.org, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
 quic_bjorande@quicinc.com, geert+renesas@glider.be,
 dmitry.baryshkov@linaro.org, shawnguo@kernel.org, neil.armstrong@linaro.org,
 m.szyprowski@samsung.com, nfraprado@collabora.com, u-kumar1@ti.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-4-kevin_chen@aspeedtech.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240726110355.2181563-4-kevin_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/07/2024 13:03, Kevin Chen wrote:
> Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>

So you did not write commit msgs to none of the commits?

> ---
>  drivers/clk/Makefile      |    1 +
>  drivers/clk/clk-ast2700.c | 1166 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 1167 insertions(+)
>  create mode 100644 drivers/clk/clk-ast2700.c
> 
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index f793a16cad40..0d5992ea0fa4 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_COMMON_CLK_FSL_SAI)	+= clk-fsl-sai.o
>  obj-$(CONFIG_COMMON_CLK_GEMINI)		+= clk-gemini.o
>  obj-$(CONFIG_COMMON_CLK_ASPEED)		+= clk-aspeed.o
>  obj-$(CONFIG_MACH_ASPEED_G6)		+= clk-ast2600.o
> +obj-$(CONFIG_MACH_ASPEED_G7)		+= clk-ast2700.o

...

> +
> +static const char *const pspclk_sel[] = {
> +	"soc0-mpll",
> +	"soc0-hpll",
> +};
> +
> +static const char *const soc0_uartclk_sel[] = {
> +	"soc0-clk24Mhz",
> +	"soc0-clk192Mhz",
> +};
> +
> +static const char *const emmcclk_sel[] = {
> +	"soc0-mpll_div4",
> +	"soc0-hpll_div4",
> +};
> +
> +static int ast2700_soc0_clk_init(struct device_node *soc0_node)
> +{
> +	struct clk_hw_onecell_data *clk_data;
> +	void __iomem *clk_base;
> +	struct ast2700_reset *reset;
> +	struct clk_hw **clks;
> +	int div;
> +	u32 val;
> +	int ret;
> +
> +	clk_data = kzalloc(struct_size(clk_data, hws, SOC0_NUM_CLKS), GFP_KERNEL);
> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	clk_data->num = SOC0_NUM_CLKS;
> +	clks = clk_data->hws;
> +
> +	clk_base = of_iomap(soc0_node, 0);
> +	if (WARN_ON(IS_ERR(clk_base)))

Drop WARN_ON

> +		return PTR_ERR(clk_base);
> +
> +	reset = kzalloc(sizeof(*reset), GFP_KERNEL);
> +	if (!reset)
> +		return -ENOMEM;
> +
> +	reset->base = clk_base;
> +
> +	reset->rcdev.owner = THIS_MODULE;
> +	reset->rcdev.nr_resets = SOC0_RESET_NUMS;
> +	reset->rcdev.ops = &ast2700_reset_ops;
> +	reset->rcdev.of_node = soc0_node;
> +
> +	ret = reset_controller_register(&reset->rcdev);
> +	if (ret) {
> +		pr_err("soc0 failed to register reset controller\n");
> +		return ret;
> +	}
> +
> +	//refclk

Weird comment. Please read Coding Style.


> +	clks[SCU0_CLKIN] =
> +		clk_hw_register_fixed_rate(NULL, "soc0-clkin", NULL, 0, SCU_CLK_25MHZ);
> +
> +	clks[SCU0_CLK_24M] =
> +		clk_hw_register_fixed_rate(NULL, "soc0-clk24Mhz", NULL, 0, SCU_CLK_24MHZ);
> +
> +	clks[SCU0_CLK_192M] =
> +		clk_hw_register_fixed_rate(NULL, "soc0-clk192Mhz", NULL, 0, SCU_CLK_192MHZ);
> +
> +	//hpll
> +	val = readl(clk_base + SCU0_HWSTRAP1);
> +	if ((val & GENMASK(3, 2)) != 0) {
> +		switch ((val & GENMASK(3, 2)) >> 2) {
> +		case 1:
> +			clks[SCU0_CLK_HPLL] =
> +				clk_hw_register_fixed_rate(NULL, "soc0-hpll", NULL, 0, 1900000000);
> +			break;
> +		case 2:
> +			clks[SCU0_CLK_HPLL] =
> +				clk_hw_register_fixed_rate(NULL, "soc0-hpll", NULL, 0, 1800000000);
> +			break;
> +		case 3:
> +			clks[SCU0_CLK_HPLL] =
> +				clk_hw_register_fixed_rate(NULL, "soc0-hpll", NULL, 0, 1700000000);
> +			break;
> +		}
> +	} else {
> +		val = readl(clk_base + SCU0_HPLL_PARAM);
> +		clks[SCU0_CLK_HPLL] = ast2700_soc0_hw_pll("soc0-hpll", "soc0-clkin", val);
> +	}
> +	clks[SCU0_CLK_HPLL_DIV2] = clk_hw_register_fixed_factor(NULL, "soc0-hpll_div2", "soc0-hpll", 0, 1, 2);
> +	clks[SCU0_CLK_HPLL_DIV4] = clk_hw_register_fixed_factor(NULL, "soc0-hpll_div4", "soc0-hpll", 0, 1, 4);
> +
> +	//dpll



Best regards,
Krzysztof


