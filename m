Return-Path: <linux-kernel+bounces-298250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EC295C4AF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81FAC2859FD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 05:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DB5502B1;
	Fri, 23 Aug 2024 05:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="aYvTZdC6"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB4C182DF;
	Fri, 23 Aug 2024 05:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724390110; cv=none; b=dQeQ4HNS3z3L7oPvdCZ/NiGRoXq++x6I7K5TiUA4W0VYB0PbWaab8BEshv+UnV2z2ClwBS2bqzd+/NLhr8neRTwCJSjMZVF6xXSWKiK+TIna9pAe7xRAVMOv3Kw/XmHtxQcXIXMxq1g7ss+J6uM4JzgRl1GBQT2LAdMbSeyMK0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724390110; c=relaxed/simple;
	bh=H2LaP7ummlpz6oEvS9dTNdFESEbFen0HKZMXxhurf08=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=GibEF57VnLQLOvsR7nZVhHcFbKS5djGaLEPVLcSAZBuOU/m122olrdp+jTXD7hQIS/KONGDrD5Q1wvKu2zAKnWPZzrji4t4tsnJYgwjle+lVE3NE3WjtJHoh+kIB5qnUt7xymf2z9ad0srd7oNDm46lGCYUujwTGXwWaz8Ksg0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=aYvTZdC6; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1724390103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qJ/dYXoEhpDVuQVnSYfBj14wdjtqMAfTyvwy7dxgMAE=;
	b=aYvTZdC6zh6xylfVznMaRkfyM/qJAUChkSgb+7jUoYDeXx73Y2/Knz2Bpsc1w5lCRrqKvl
	5Xd9b/6CQ6APdtMIQkHL5z9Y4QFjgIUUzLPAQR9aoFfgBj9qx7r5BhMzZ6OwPyZgtAD0jV
	TgCdZc8fLupAPpW3ZazlK1iJnsKX3IQ7JXFyQdxdAe084IhqsmprlptXz0x44tvNgFZnMf
	YZebmRrVk2Lea2r8Qdcx9ItIGk3Sb/hV6x8G4JLLbz1eZH7ghH+UkqSKp+vRMTF8mDcUom
	XxnCzxvPMzhfT19cLgvFJOjjwbHeFHFjXbxHO3NlohgQMpai2O58kQhfXuuaBg==
Date: Fri, 23 Aug 2024 07:15:03 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Philipp Zabel
 <p.zabel@pengutronix.de>, Elaine Zhang <zhangqing@rock-chips.com>,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 kernel@collabora.com
Subject: Re: [PATCH v6 2/3] clk: rockchip: Add new pll type pll_rk3588_ddr
In-Reply-To: <20240822194956.918527-3-detlev.casanova@collabora.com>
References: <20240822194956.918527-1-detlev.casanova@collabora.com>
 <20240822194956.918527-3-detlev.casanova@collabora.com>
Message-ID: <a0fb5f60e53b7862a6303032339b306b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Detlev,

On 2024-08-22 21:49, Detlev Casanova wrote:
> From: Elaine Zhang <zhangqing@rock-chips.com>
> 
> That PLL type is similar to the other rk3588 pll types but the actual
> rate is twice the configured rate.
> Therefore, the returned calculated rate must be multiplied by two.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> (cherry picked from commit c99648df60d3763723de9e443b862da44e8872fe)
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>

Thanks for the patch.  I had a rather detailed look at the patch,
while focusing on having no regressions introduced, and I found none.
So, please feel free to include:

Acked-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  drivers/clk/rockchip/clk-pll.c | 6 +++++-
>  drivers/clk/rockchip/clk.h     | 1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/rockchip/clk-pll.c 
> b/drivers/clk/rockchip/clk-pll.c
> index 606ce5458f54..fe76756e592e 100644
> --- a/drivers/clk/rockchip/clk-pll.c
> +++ b/drivers/clk/rockchip/clk-pll.c
> @@ -914,7 +914,10 @@ static unsigned long
> rockchip_rk3588_pll_recalc_rate(struct clk_hw *hw, unsigned
>  	}
>  	rate64 = rate64 >> cur.s;
> 
> -	return (unsigned long)rate64;
> +	if (pll->type == pll_rk3588_ddr)
> +		return (unsigned long)rate64 * 2;
> +	else
> +		return (unsigned long)rate64;
>  }
> 
>  static int rockchip_rk3588_pll_set_params(struct rockchip_clk_pll 
> *pll,
> @@ -1167,6 +1170,7 @@ struct clk *rockchip_clk_register_pll(struct
> rockchip_clk_provider *ctx,
>  		break;
>  	case pll_rk3588:
>  	case pll_rk3588_core:
> +	case pll_rk3588_ddr:
>  		if (!pll->rate_table)
>  			init.ops = &rockchip_rk3588_pll_clk_norate_ops;
>  		else
> diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
> index fd3b476dedda..40fc0e4703c1 100644
> --- a/drivers/clk/rockchip/clk.h
> +++ b/drivers/clk/rockchip/clk.h
> @@ -287,6 +287,7 @@ enum rockchip_pll_type {
>  	pll_rk3399,
>  	pll_rk3588,
>  	pll_rk3588_core,
> +	pll_rk3588_ddr,
>  };
> 
>  #define RK3036_PLL_RATE(_rate, _refdiv, _fbdiv, _postdiv1,	\

