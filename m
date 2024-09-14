Return-Path: <linux-kernel+bounces-329493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD1E979204
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 18:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2091C20D29
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 16:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67BE1D0975;
	Sat, 14 Sep 2024 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="gbZ+d2IZ"
Received: from msa.smtpout.orange.fr (smtp-75.smtpout.orange.fr [80.12.242.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6D61D0154
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726330276; cv=none; b=VXdtNUGHbg0XKSDNW5Rv+OJPqtWFl0jDGvhaniJaXip/l7/zSHOjOlj2ZaQgXXEm24Oqgat5kqGgfzwv5CgVoLBJCur42v7ZdoEr6VhTWq2j2w59o4GZuJcXYNOWhJoFw6v78Crt9XcAjOFCrhvhWBVuPU4oEoUApXneIx4F+qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726330276; c=relaxed/simple;
	bh=wYT0kK43we2wiETMCUmETovHzAPRqIAVy6XfTCki770=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sg2msbkNcL29no04vcKVB7vN/SHJPnE6m8IqSipkBwlxosvdWYuopxkGED4YVf+EXLhzvJeK/tIfvM0/eBCaRykAeu37aJYxcj6zUs6kSM3GZ0rTeok+qNzpnKrZ2hXAPP7W07Lj7dH4qGfE2ai9csw1xS/xR7NfKPifU/45/o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=gbZ+d2IZ; arc=none smtp.client-ip=80.12.242.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id pVMSsua8GqXJQpVMSsnqpy; Sat, 14 Sep 2024 18:11:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1726330265;
	bh=MBuP/BOaPyMnGuO0PoHHXki8MmwwuT9/WeXZMzNlRZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=gbZ+d2IZsZQv279daBVzp+/rWbquiYMr+ne+KDPjK07JlAArSJEHwv9f4sAFiaX6n
	 /DfTgWeka0+Ct5qMqN4v2r1jAna9g6OnyuugmVnEq13lrwnBi4+BtcGPE4Qc+rQvFW
	 O/zx7XsMA0ZoX3S90R16h9xLPUeodkRw/EsPD4fkeG3Qtz/A9YPpC0sasXQM1ZOt1C
	 GSHk9T8LTJVbXnT8eKKuX1nhjpM7YPy8UV44DI60K+PCeXXHa5GYNE5eorqs/zjoyr
	 GdVzuTgJg2tanmf4PQ+jsEpxJIhtlQkic4S8Nr4gBbWq6dvxpvYa/sGwKBf58l/WSg
	 x7eoFP9mP3LJw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 14 Sep 2024 18:11:05 +0200
X-ME-IP: 90.11.132.44
Message-ID: <c394ebc5-c19d-4e52-9cb1-939be554a153@wanadoo.fr>
Date: Sat, 14 Sep 2024 18:11:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] phy: renesas: rcar-gen3-usb2: Fix an error handling
 path in rcar_gen3_phy_usb2_probe()
To: biju.das.jz@bp.renesas.com,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-phy@lists.infradead.org
References: <290b25827e3f0742808940719455ff0c5cb9d01d.1726329925.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <290b25827e3f0742808940719455ff0c5cb9d01d.1726329925.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 14/09/2024 à 18:07, Christophe JAILLET a écrit :
> If an error occurs after the reset_control_deassert(),
> reset_control_assert() must be called, as already done in the remove
> function.
> 
> Use devm_add_action_or_reset() to add the missing call and simplify the
> .remove() function accordingly.
> 
> Fixes: 4eae16375357 ("phy: renesas: rcar-gen3-usb2: Add support to initialize the bus")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch changes the order of function calls when releasing the resources
> in the .remove function(). Looks fine to me, but pm_ functions are
> sometimes tricky.
> 
> Changes in v3:
>    - Use devm_add_action_or_reset()   [Biju Das]
> 
> Changes in v2: (broken proposal)
>    - Re-use 'error' to simplify the patch   [claudiu beznea]
>    - Update the commit description to explain why it is safe.
> v2: https://lore.kernel.org/all/4efe2d0419cbe98163e2422ebe0c7896b8a5efed.1725717505.git.christophe.jaillet@wanadoo.fr/
> 
> v1: https://lore.kernel.org/all/fc9f7b444f0ca645411868992bbe16514aeccfed.1725652654.git.christophe.jaillet@wanadoo.fr/
> ---
>   drivers/phy/renesas/phy-rcar-gen3-usb2.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> index 58e123305152..c8a3727f56aa 100644
> --- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> +++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> @@ -668,6 +668,13 @@ static enum usb_dr_mode rcar_gen3_get_dr_mode(struct device_node *np)
>   	return candidate;
>   }
>   
> +static void rcar_gen3_reset_assert(void *data)
> +{
> +	struct reset_control *rstc = data;
> +
> +	reset_control_assert(rstc);
> +}
> +
>   static int rcar_gen3_phy_usb2_init_bus(struct rcar_gen3_chan *channel)
>   {
>   	struct device *dev = channel->dev;
> @@ -686,6 +693,11 @@ static int rcar_gen3_phy_usb2_init_bus(struct rcar_gen3_chan *channel)
>   	if (ret)
>   		goto rpm_put;
>   
> +	ret = devm_add_action_or_reset(dev, rcar_gen3_reset_assert,
> +				       channel->rstc);
> +	if (ret)
> +		return ret;

NACK

This is still broken.
Should be goto rpm_put;

I'll send a v4.

CJ

> +
>   	val = readl(channel->base + USB2_AHB_BUS_CTR);
>   	val &= ~USB2_AHB_BUS_CTR_MBL_MASK;
>   	val |= USB2_AHB_BUS_CTR_MBL_INCR4;
> @@ -815,7 +827,6 @@ static void rcar_gen3_phy_usb2_remove(struct platform_device *pdev)
>   	if (channel->is_otg_channel)
>   		device_remove_file(&pdev->dev, &dev_attr_role);
>   
> -	reset_control_assert(channel->rstc);
>   	pm_runtime_disable(&pdev->dev);
>   };
>   


