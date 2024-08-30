Return-Path: <linux-kernel+bounces-308098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C97D965731
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E762866C2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 05:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FF72F2C;
	Fri, 30 Aug 2024 05:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="wXcaaVJU";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="ETEKpY8Z"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DA11531F9
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 05:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724997405; cv=none; b=fx5aX4kdL4eWxYL+9uZ6hjtZrQoJmGEmcdzsv4+4C/4oZOvYhtmlzXpCEfMkDxWHgFzP4ssRWtjPnFfhS54xoHAxZpJTgNGqL9ChGXspM8nHEucGGLlqGtR4kMWTE5spM3HmFIuqS/e17ZRP1sOqqagv1Ne+4vGjpihSQtUbQeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724997405; c=relaxed/simple;
	bh=x9yjOjFAohZtscac1sFvxpeu7yLK+GwtoV5bfW1JrOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PztpyA/az8N6c+zaL8eQPD9EaL1ccQRcl2LNwdhmrakqtpSm6cRlttxPb7fECM061a6+GSC1L74KCCmqQQ6NpRkbWWygF9V8r+CrpCMvu8ekmS88fk5joV3Dy2Itqv4JVs4roN0yPxPGe2NT5iZFzozVy1IGcaxf/H1gbxxXTSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=wXcaaVJU; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=ETEKpY8Z; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1724997397;
	bh=x9yjOjFAohZtscac1sFvxpeu7yLK+GwtoV5bfW1JrOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wXcaaVJUCXBWpGxgdT3ZXp3PUtR1mfC92445ncE9J5Hhp60v4Nm+H29gfkbQODNSr
	 8OdCMlo/ZuLmlYmX9XhILyiP4BCsn94ymbuFdM/wga9/Y10z0StkqDYWvUBN7U7ZMg
	 2zauCYVfGANlzVyieFXKONS4h6jJPMZ61dlM0Z5v5c+Y5gAegH6T5frUJLy5okLMv/
	 F/eLMfhT4rMRC9opHOF6i83BsX3xTtmwSlxKtcoFh0yco1zH61yTSflcpxWBN81Hnj
	 wapTx9r43kX/21f+XiK4izKaOHTH8gi4R4Ns/sP0tm4kcno/pmsbkP2kyTtZbyTXHc
	 rhP5mz3FK/INg==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 5411D7B4
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 14:56:37 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=ETEKpY8Z;
	dkim-atps=neutral
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id D0AE275B
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 14:56:35 +0900 (JST)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7143d66b510so1738639b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 22:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1724997395; x=1725602195; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mkYZPDGmaBN190bl0HbQlkXjB4c4DMUzWPODIPceod0=;
        b=ETEKpY8ZjGtoYchD21JPEWfhwq48fGYDBhi4s8DTbn4Dirw81tPytuPFkM0zB5058M
         tCAzybDa9R3WQiZnE6OVIRrlpsPFILy/YyvJJcjvr99YgwIaoQ2bgKZq6cc8k/km6B68
         yQkVI6NYdNuEFXhGM8/vVu+L729ta859jTqI4usCfZh5ARG6jnS+S51dUo8LmL7l17L6
         utacPd2PRnEj88EqrqLzbH3UmdoBs0drG7i/Gg7txkEF0PeW1NZcwDD3CcFub/uypQK5
         PffR6AvJmLuGDlqql7LEXHo1grLLeOTEC6SE54cVbYLO9pKfUCyuWagDLY8GJDc486f1
         P+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724997395; x=1725602195;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mkYZPDGmaBN190bl0HbQlkXjB4c4DMUzWPODIPceod0=;
        b=Hs+uz4VLc52yuJOKUCeUaKgavctdHhizAZrv6FE8ixofEAzae02AcNVpxTeELDzCKX
         tUPxNV9JmIR53RljWFmdFZA5vZpBCBBQDWfpBlO2pJib8QEvuLnwfVefbCUGfhdg747O
         Uw6GZj+8wFnC0mmTZgJ51VunMoRxORHdwFtdSddftGhG43gORQwx5jX9eynBBg5kC4pM
         1QkdRcaGycbW6qajKr6E2bUlCfQdRbxxYaKAx46H4pVQzGkKYtmmrLInpeut9SqCMqci
         SKmhgE+lj/VVNmn6VU4p8ve1kOF+Y0JSyy/39bqEU30W30vMAbx5roFi0YY8EPYXAdq2
         QByQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCq9HZK5+1bEn6CirugJ/uKmJkmsYQWgT57BhspE8soBbb6RuF5Q21dmEPnUKVS77xB3RB+FNxpE2SEFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf9/vZGjJoS55aHqnf2ouaxzKvzUXASQx6OLREX6BYG+eQ56h5
	M0GLHmN7mhjNvbX2z8eBnEsDVvwiKDLdqr1Xm6GpIzYlMnhFmFRoHnWicjsXDny44CHYNfS+BlC
	Jz6W2Y1i5beorvJ4xevhk2eugOUrKuPi9NzpfVsqBLTQFYr+PUZR0JzbDNP5G9oU=
X-Received: by 2002:a05:6a00:234a:b0:714:1fc3:79f7 with SMTP id d2e1a72fcca58-715dfc506a0mr7113315b3a.17.1724997394663;
        Thu, 29 Aug 2024 22:56:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEospLhuiiaJ+JXW7SbcBkbVDDo2i03cNpb6xUMWtOllEbOfcXeI36XV92dVw14GmctIFDlqw==
X-Received: by 2002:a05:6a00:234a:b0:714:1fc3:79f7 with SMTP id d2e1a72fcca58-715dfc506a0mr7113295b3a.17.1724997394145;
        Thu, 29 Aug 2024 22:56:34 -0700 (PDT)
Received: from pc-0182.atmarktech (117.209.187.35.bc.googleusercontent.com. [35.187.209.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a44e4sm2019480b3a.56.2024.08.29.22.56.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2024 22:56:33 -0700 (PDT)
Received: from martinet by pc-0182.atmarktech with local (Exim 4.96)
	(envelope-from <martinet@pc-zest>)
	id 1sjuca-00E9Fv-0o;
	Fri, 30 Aug 2024 14:56:32 +0900
Date: Fri, 30 Aug 2024 14:56:22 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Adam Ford <aford173@gmail.com>
Cc: linux-phy@lists.infradead.org, linux-imx@nxp.com, festevam@gmail.com,
	frieder.schrempf@kontron.de, aford@beaconembedded.com,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org,
	Makoto Sato <makoto.sato@atmark-techno.com>
Subject: Re: [RFC V3 3/3] phy: freescale: fsl-samsung-hdmi: Support dynamic
 integer
Message-ID: <ZtFfBs4HEShmJKsi@atmark-techno.com>
References: <20240830032442.226031-1-aford173@gmail.com>
 <20240830032442.226031-3-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240830032442.226031-3-aford173@gmail.com>

Adam Ford wrote on Thu, Aug 29, 2024 at 10:24:27PM -0500:
> There is currently a look-up table for a variety of resolutions.
> Since the phy has the ability to dynamically calculate the values
> necessary to use the intger divider which should allow more
> resolutions without having to update the look-up-table.
> 
> If the lookup table cannot find an exact match, fall back to the
> dynamic calculator of the integer divider.
> 
> Previously, the value of P was hard-coded to 1, this required an
> update to the phy_pll_cfg table to add in the extra value into the
> table, so if the value of P is calculated to be something else
> by the PMS calculator, the calculated_phy_pll_cfg structure
> can be used instead without having to keep track of which method
> was used.

Thank you!

I've updated to v3 and we must have missed something fiddling with v1
but our 31.5MHz-only screen turns on with this!

Unfortunately among the other odd devices we support, there's one
whose native resolution only supports 83.5MHz, and that doesn't come out
right with the integer divider (that function returns 83.2MHz, which is
0.4%off)
If we force the round/set rate functions to prefer the calculated value
and allow that in imx8mp_hdmi_check_clk_rate (dw_hdmi-imx.c) then it
also works, so I don't think we actually need to affine the model...
Coming back to what Lucas replied to my initial mail HDMI would also a
rate mismatch of ±0.5%, so the integer calculator works for all the
frequencies we've currently added manually if we fix the check to allow
that as well:
32000000: found 32000000 (100.0% match): p 1 / m 80 / s 12
51200000: found 51200000 (100.0% match): p 1 / m 64 / s 6
65000000: found 64800000 (99.6% match): p 1 / m 54 / s 4
71000000: found 70800000 (99.7% match): p 1 / m 59 / s 4
83500000: found 83200000 (99.6% match): p 1 / m 104 / s 6

(only actually tested 51.2 and 83.5 here, we don't have all the hardware
available; I'll try to play with normal monitors that support more modes
once the patch gets further finalized)


So, as far as I'm concerned I'd be happy to move forward with that and
will backport this to our tree/remove our kludged values, would "just"
need to properly pick the closest value if no exact match instead of
always falling back to the table (or just remove the table altogether if
we can test a few monitors?)

A couple of style nitpicks below

> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> index a700a300dc6f..3fab40cde40d 100644
> --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> @@ -16,6 +16,8 @@
>  
>  #define PHY_REG(reg)		(reg * 4)
>  
> +#define REG01_PMS_P_MASK	GENMASK(3, 0)
> +#define REG03_PMS_S_MASK	GENMASK(7, 4)
>  #define REG12_CK_DIV_MASK	GENMASK(5, 4)
>  #define REG13_TG_CODE_LOW_MASK	GENMASK(7, 0)
>  #define REG14_TOL_MASK		GENMASK(7, 4)
> @@ -29,281 +31,296 @@
>  #define REG34_PLL_LOCK		BIT(6)
>  #define REG34_PHY_CLK_READY	BIT(5)
>  
> -#define PHY_PLL_DIV_REGS_NUM 6
> +#ifndef MHZ
> +#define MHZ	(1000UL * 1000UL)
> +#endif
> +
> +#define PHY_PLL_DIV_REGS_NUM 7
>  
>  struct phy_config {
>  	u32	pixclk;
>  	u8	pll_div_regs[PHY_PLL_DIV_REGS_NUM];
>  };
>  
> +/*
> + * The calculated_phy_pll_cfg only handles integer divider for PMS only,
> + * meaning the last four entries will be fixed, but the first three will
> + * be calculated by the PMS calculator
> + */
> +static struct phy_config calculated_phy_pll_cfg = {

I'd change cur_cfg from pointer to the struct itself like this (partial
patch that probably won't even apply on your branch:)
----
diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index 9048cdc760c2..d7124604819c 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -402,7 +402,7 @@ struct fsl_samsung_hdmi_phy {
 
 	/* clk provider */
 	struct clk_hw hw;
-	const struct phy_config *cur_cfg;
+	struct phy_config cur_cfg;
 };
 
 static inline struct fsl_samsung_hdmi_phy *
@@ -562,9 +562,9 @@ static int phy_clk_set_rate(struct clk_hw *hw,
 	if (i < 0)
 		return -EINVAL;
 
-	phy->cur_cfg = &phy_pll_cfg[i];
+	phy->cur_cfg = phy_pll_cfg[i];
 
-	return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
+	return fsl_samsung_hdmi_phy_configure(phy, &phy->cur_cfg);
 }
 
 static const struct clk_ops phy_clk_ops = {
----

Then you can just set it directly for calculated values.
But conceptually it's the same, just one less indirection.

> @@ -406,6 +424,76 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(struct fsl_samsung_hdmi_phy *phy,
>  	       phy->regs + PHY_REG(14));
>  }
>  
> +static unsigned long fsl_samsung_hdmi_phy_find_pms(unsigned long fout, u8 *p, u16 *m, u8 *s)
> +{
> +	unsigned long best_freq = 0;
> +	u32 min_delta = 0xffffffff;
> +	u8 _p, best_p;
> +	u16 _m, best_m;
> +	u8 _s, best_s;
> +
> +	/* The ref manual states the values of 'P' rannge from 1 to 11 */

typo: range

> +	for (_p = 1; _p <= 11; ++_p) {
> +		for (_s = 1; _s <= 16; ++_s) {
> +			u64 tmp;
> +			u32 delta;
> +
> +			/* s must be one or even */
> +			if (_s > 1 && (_s & 0x01) == 1)
> +				_s++;
> +
> +			/* _s cannot be 14 per the TRM */
> +			if (_s == 14)
> +				continue;
> +
> +			/*
> +			 * TODO: Ref Manual doesn't state the range of _m
> +			 * so this should be further refined if possible.
> +			 * This range was set based on the original values
> +			 * in the look-up table
> +			 */
> +			tmp = (u64)fout * (_p * _s);
> +			do_div(tmp, 24 * MHZ);
> +			_m = tmp;
> +			if (_m < 0x30 || _m > 0x7b)
> +				continue;
> +
> +			/*
> +			 * Rev 2 of the Ref Manual states the
> +			 * VCO can range between 750MHz and
> +			 * 3GHz.  The VCO is assumed to be _m x
> +			 * the reference frequency of 24MHz divided
> +			 * by the prescaler, _p
> +			 */
> +			tmp = (u64)_m * 24 * MHZ;
> +			do_div(tmp, _p);
> +			if (tmp < 750 * MHZ ||
> +			    tmp > 3000 * MHZ)
> +				continue;
> +
> +			tmp = (u64)_m * 24 * MHZ;
> +			do_div(tmp, _p * _s);
> +
> +			delta = abs(fout - tmp);
> +			if (delta < min_delta) {
> +				best_p = _p;
> +				best_s = _s;
> +				best_m = _m;
> +				min_delta = delta;
> +				best_freq = tmp;
> +			}
> +		}
> +	}
> +
> +	if (best_freq) {
> +		*p = best_p;
> +		*m = best_m;
> +		*s = best_s;
> +	}
> +
> +	return best_freq;
> +}
> +
>  static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
>  					  const struct phy_config *cfg)
>  {
> @@ -419,13 +507,13 @@ static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
>  	for (i = 0; i < ARRAY_SIZE(common_phy_cfg); i++)
>  		writeb(common_phy_cfg[i].val, phy->regs + common_phy_cfg[i].reg);
>  
> -	/* set individual PLL registers PHY_REG2 ... PHY_REG7 */
> +	/* set individual PLL registers PHY_REG1 ... PHY_REG7 */
>  	for (i = 0; i < PHY_PLL_DIV_REGS_NUM; i++)
> -		writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG(2) + i * 4);
> +		writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG(1) + i * 4);
>  
> -	/* High nibble of pll_div_regs[1] contains S which also gets written to REG21 */
> +	/* High nibble of PHY_REG3 and low nibble of PHY_REG21 both contain 'S' */
>  	writeb(REG21_SEL_TX_CK_INV | FIELD_PREP(REG21_PMS_S_MASK,
> -	       cfg->pll_div_regs[1] >> 4), phy->regs + PHY_REG(21));
> +	       cfg->pll_div_regs[2] >> 4), phy->regs + PHY_REG(21));
>  
>  	fsl_samsung_hdmi_phy_configure_pll_lock_det(phy, cfg);
>  
> @@ -453,29 +541,70 @@ static unsigned long phy_clk_recalc_rate(struct clk_hw *hw,
>  static long phy_clk_round_rate(struct clk_hw *hw,
>  			       unsigned long rate, unsigned long *parent_rate)
>  {
> +	u32 int_div_clk;
>  	int i;
> +	u16 m;
> +	u8 p, s;
> +
> +	/* If the clock is out of range return error instead of searching */
> +	if (rate > 297000000 || rate < 22250000)
> +		return -EINVAL;
>  
> +	/* Check the look-up table */
>  	for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
>  		if (phy_pll_cfg[i].pixclk <= rate)
> -			return phy_pll_cfg[i].pixclk;
> +			break;
> +	/* If the rate is an exact match, return it now */
> +	if (rate == phy_pll_cfg[i].pixclk)
> +		return phy_pll_cfg[i].pixclk;
> +
> +	/*
> +	 * The math on the lookup table shows the PMS math yields a
> +	 * frequency 5 x pixclk.
> +	 * When we check the integer divider against the desired rate,
> +	 * multiply the rate x 5 and then divide the outcome by 5.
> +	 */
> +	int_div_clk = fsl_samsung_hdmi_phy_find_pms(rate * 5, &p, &m, &s) / 5;

I'd move that comment and both multiplication and division inside
fsl_samsung_hdmi_phy_find_pms, since it's a property of the computation
(not having the comment made me ask last time, with the comment it's
fine -- thanks for adding these comments, very helpful.)

-- 
Dominique



