Return-Path: <linux-kernel+bounces-572546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FCAA6CB4D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 16:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192723AD43D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 15:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A44322F38B;
	Sat, 22 Mar 2025 15:50:42 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9762309A8;
	Sat, 22 Mar 2025 15:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742658641; cv=none; b=Yk/CadieM6sYgX+Vr+z9sfv8kok47mJrgPtdrWhVVoZREKAqxjdhHWY3unvc3t4KEg/qRf2SlDZmEgasMuTI55koyJW21IPWJLnbg488o7h2oat3FKESpeW/OZpdU58wvwMhrRHd4ik3RZBoZ3AfJKd+dbb1OyM0VwHIncG+DkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742658641; c=relaxed/simple;
	bh=ToanPTkWfdU1oudw87qywX95hSjmLXb5mXOdPJgmqT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GI5+Scq/bTdWxlAQXEXpWMGd1FdKsg7UxqJOb6CtZ7XJzmsmbqT0VUmY3zqtNqLygWJpSqqM8VU+iRq8JCruGlI1x6v2vpf0slL9rt/m2YyKEOqAyYemr0btkmc5+bJG/j8lFVos13BDJwUSOwUvV6eie+uH9a1s4TZA3z6ZNRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 137C73431B5;
	Sat, 22 Mar 2025 15:50:38 +0000 (UTC)
Date: Sat, 22 Mar 2025 15:50:34 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Alex Elder <elder@riscstar.com>
Cc: p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heylenay@4d2.org, guodong@riscstar.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, spacemit@lists.linux.dev,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 2/7] clk: spacemit: define struct k1_ccu_data
Message-ID: <20250322155034-GYB11633@gentoo>
References: <20250321151831.623575-1-elder@riscstar.com>
 <20250321151831.623575-3-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321151831.623575-3-elder@riscstar.com>

Hi Alex:

this patch change relate to clock only, so how about let's fold
it into clk patches (which now has not been merged), so we make
the code right at first place? cause some moving around and renaming

On 10:18 Fri 21 Mar     , Alex Elder wrote:
> Define a new structure type to be used for describing the OF match data.
> Rather than using the array of spacemit_ccu_clk structures for match
> data, we use this structure instead.
> 
> Move the definition of the spacemit_ccu_clk structure closer to the top
> of the source file, and add the new structure definition below it.
> 
> Shorten the name of spacemit_ccu_register() to be k1_ccu_register().
any good reason to change this? it make the code style inconsistent,
do you just change it for shorten function, or want it to be more k1
specific, so next SoC - e.g maybe k2? will introduce another function?

> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  drivers/clk/spacemit/ccu-k1.c | 58 ++++++++++++++++++++++++++---------
>  1 file changed, 43 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
> index 44db48ae71313..f7367271396a0 100644
> --- a/drivers/clk/spacemit/ccu-k1.c
> +++ b/drivers/clk/spacemit/ccu-k1.c
> @@ -129,6 +129,15 @@
>  #define APMU_EMAC0_CLK_RES_CTRL		0x3e4
>  #define APMU_EMAC1_CLK_RES_CTRL		0x3ec
>  
> +struct spacemit_ccu_clk {
> +	int id;
> +	struct clk_hw *hw;
> +};
> +
> +struct k1_ccu_data {
> +	struct spacemit_ccu_clk *clk;		/* array with sentinel */
> +};
> +
>  /*	APBS clocks start	*/
>  
>  /* Frequency of pll{1,2} should not be updated at runtime */
> @@ -1359,11 +1368,6 @@ static CCU_GATE_DEFINE(emmc_bus_clk, CCU_PARENT_HW(pmua_aclk),
>  		       0);
>  /*	APMU clocks end		*/
>  
> -struct spacemit_ccu_clk {
> -	int id;
> -	struct clk_hw *hw;
> -};
> -
>  static struct spacemit_ccu_clk k1_ccu_apbs_clks[] = {
>  	{ CLK_PLL1,		&pll1.common.hw },
>  	{ CLK_PLL2,		&pll2.common.hw },
> @@ -1403,6 +1407,10 @@ static struct spacemit_ccu_clk k1_ccu_apbs_clks[] = {
>  	{ 0,			NULL },
>  };
>  
> +static const struct k1_ccu_data k1_ccu_apbs_data = {
> +	.clk		= k1_ccu_apbs_clks,
> +};
> +
>  static struct spacemit_ccu_clk k1_ccu_mpmu_clks[] = {
>  	{ CLK_PLL1_307P2,	&pll1_d8_307p2.common.hw },
>  	{ CLK_PLL1_76P8,	&pll1_d32_76p8.common.hw },
> @@ -1440,6 +1448,10 @@ static struct spacemit_ccu_clk k1_ccu_mpmu_clks[] = {
>  	{ 0,			NULL },
>  };
>  
> +static const struct k1_ccu_data k1_ccu_mpmu_data = {
> +	.clk		= k1_ccu_mpmu_clks,
> +};
> +
>  static struct spacemit_ccu_clk k1_ccu_apbc_clks[] = {
>  	{ CLK_UART0,		&uart0_clk.common.hw },
>  	{ CLK_UART2,		&uart2_clk.common.hw },
> @@ -1544,6 +1556,10 @@ static struct spacemit_ccu_clk k1_ccu_apbc_clks[] = {
>  	{ 0,			NULL },
>  };
>  
> +static const struct k1_ccu_data k1_ccu_apbc_data = {
> +	.clk		= k1_ccu_apbc_clks,
> +};
> +
>  static struct spacemit_ccu_clk k1_ccu_apmu_clks[] = {
>  	{ CLK_CCI550,		&cci550_clk.common.hw },
>  	{ CLK_CPU_C0_HI,	&cpu_c0_hi_clk.common.hw },
> @@ -1610,9 +1626,13 @@ static struct spacemit_ccu_clk k1_ccu_apmu_clks[] = {
>  	{ 0,			NULL },
>  };
>  
> -static int spacemit_ccu_register(struct device *dev,
> -				 struct regmap *regmap, struct regmap *lock_regmap,
> -				 const struct spacemit_ccu_clk *clks)
> +static const struct k1_ccu_data k1_ccu_apmu_data = {
> +	.clk		= k1_ccu_apmu_clks,
> +};
> +
> +static int k1_ccu_register(struct device *dev, struct regmap *regmap,
> +			   struct regmap *lock_regmap,
> +			   struct spacemit_ccu_clk *clks)
>  {
>  	const struct spacemit_ccu_clk *clk;
>  	int i, ret, max_id = 0;
> @@ -1648,15 +1668,24 @@ static int spacemit_ccu_register(struct device *dev,
>  
>  	clk_data->num = max_id + 1;
>  
> -	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_data);
> +	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_data);
> +	if (ret)
> +		dev_err(dev, "error %d adding clock hardware provider\n", ret);
> +
> +	return ret;
I'd use "return 0;", nothing different, just explicitly short

ok, I can understand this change ease debug procedure once there is problem.
(but I'm fine with either way, failure should rarely happen & will
identify early)

>  }
>  
>  static int k1_ccu_probe(struct platform_device *pdev)
>  {
>  	struct regmap *base_regmap, *lock_regmap = NULL;
>  	struct device *dev = &pdev->dev;
> +	const struct k1_ccu_data *data;
>  	int ret;
>  
> +	data = of_device_get_match_data(dev);
> +	if (!data)
> +		return -EINVAL;
> +
>  	base_regmap = device_node_to_regmap(dev->of_node);
>  	if (IS_ERR(base_regmap))
>  		return dev_err_probe(dev, PTR_ERR(base_regmap),
> @@ -1677,8 +1706,7 @@ static int k1_ccu_probe(struct platform_device *pdev)
>  					     "failed to get lock regmap\n");
>  	}
>  
> -	ret = spacemit_ccu_register(dev, base_regmap, lock_regmap,
> -				    of_device_get_match_data(dev));
> +	ret = k1_ccu_register(dev, base_regmap, lock_regmap, data->clk);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed to register clocks\n");
>  
> @@ -1688,19 +1716,19 @@ static int k1_ccu_probe(struct platform_device *pdev)
>  static const struct of_device_id of_k1_ccu_match[] = {
>  	{
>  		.compatible	= "spacemit,k1-pll",
> -		.data		= k1_ccu_apbs_clks,
> +		.data		= &k1_ccu_apbs_data,
>  	},
>  	{
>  		.compatible	= "spacemit,k1-syscon-mpmu",
> -		.data		= k1_ccu_mpmu_clks,
> +		.data		= &k1_ccu_mpmu_data,
>  	},
>  	{
>  		.compatible	= "spacemit,k1-syscon-apbc",
> -		.data		= k1_ccu_apbc_clks,
> +		.data		= &k1_ccu_apbc_data,
>  	},
>  	{
>  		.compatible	= "spacemit,k1-syscon-apmu",
> -		.data		= k1_ccu_apmu_clks,
> +		.data		= &k1_ccu_apmu_data,
>  	},
>  	{ }
	{ /* sentinel */ }
>  };
> -- 
> 2.43.0
> 

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

