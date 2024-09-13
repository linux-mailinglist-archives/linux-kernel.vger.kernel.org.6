Return-Path: <linux-kernel+bounces-328851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CA99789E8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 22:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51701F260EA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B9F1527AC;
	Fri, 13 Sep 2024 20:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="I1ZXgwCx"
Received: from msa.smtpout.orange.fr (smtp-65.smtpout.orange.fr [80.12.242.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DFD14F102
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726259086; cv=none; b=jdF3BSy36Jgx9Ib6+OTu62CuRK3kZImHnNEmdJ0l169YPvc09yPPy0Eg4B4x3wFzr++I51OSly+5syqa4R/LEaE02lx6PZanoBpBG5PJuNo4jFx69/4xdWO4ZeXUtpzyoU7l5aUWIQ9KMWfGXTezut42oMYSqcGzXZOF+mG0Ce4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726259086; c=relaxed/simple;
	bh=aeHHirsDTzlsKVKlkvJxIJprybC9ohBEqeiu92MY3xU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKUHFxVgWvlQDngKfZK0XZIrD8JZIN/04O3focZWjh0FVmDAYlaqrYbweCG2EJMjYNKSlyQ+N25fzxVgW1z7rRyTALQeSzulWGfdGl9R7DbmQLdidHFaGFYxp7Zr+48eVs3poHmeKXFSZX7EPxsxL0KvkMrMBXkbQnK6Ot6BmuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=I1ZXgwCx; arc=none smtp.client-ip=80.12.242.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id pCqCs5pkRXiYbpCqDs5fby; Fri, 13 Sep 2024 22:24:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1726259074;
	bh=IFlge7GQc7i+yk+ZZfEDZaPwa4VYufyWQBRelpdZhAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=I1ZXgwCxzN4AkerjsejnGQV9v+1T/tFRqmuj96Ku2S9RRbEmqH/TvBEk+/RpBUKbU
	 hIx/QEzJ9R7AuM6YDPGKYxSplhCPdfDUFQVVSr4OQamd2cDwYcUjfEuKxhPL3T1Osd
	 hBbNLS8eHOodu0R+vLSGe/5SiQco1FBGrPnaIXk0QFR/cdcQpbKpg8ljcAnivBWIlL
	 /81LRski1PZZ9fAZxpXzZM462Y2jHiIzfjxabcMrlP/3ZANdY5qg4RjQ4+yd2qrCyg
	 qfKtXVN9Pdi4yBF/5/pPGlUhH560RBO/0RN3lWnyvRFwyMhr7qowwYiSPyC5oLFtO6
	 3D5kOkPeCdcvg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 13 Sep 2024 22:24:34 +0200
X-ME-IP: 90.11.132.44
Message-ID: <4e4defa9-ef2f-4ff1-95ca-6627c24db20c@wanadoo.fr>
Date: Fri, 13 Sep 2024 22:24:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 7/8] net: ethernet: fs_enet: simplify clock
 handling with devm accessors
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Pantelis Antoniou <pantelis.antoniou@gmail.com>, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Herve Codina <herve.codina@bootlin.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20240904171822.64652-1-maxime.chevallier@bootlin.com>
 <20240904171822.64652-8-maxime.chevallier@bootlin.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240904171822.64652-8-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 04/09/2024 à 19:18, Maxime Chevallier a écrit :
> devm_clock_get_enabled() can be used to simplify clock handling for the
> PER register clock.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>   .../ethernet/freescale/fs_enet/fs_enet-main.c    | 16 ++++------------
>   drivers/net/ethernet/freescale/fs_enet/fs_enet.h |  2 --
>   2 files changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> index c96a6b9e1445..ec43b71c0eba 100644
> --- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> +++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> @@ -900,14 +900,9 @@ static int fs_enet_probe(struct platform_device *ofdev)
>   	 * but require enable to succeed when a clock was specified/found,
>   	 * keep a reference to the clock upon successful acquisition
>   	 */
> -	clk = devm_clk_get(&ofdev->dev, "per");
> -	if (!IS_ERR(clk)) {
> -		ret = clk_prepare_enable(clk);
> -		if (ret)
> -			goto out_deregister_fixed_link;
> -
> -		fpi->clk_per = clk;
> -	}
> +	clk = devm_clk_get_enabled(&ofdev->dev, "per");
> +	if (IS_ERR(clk))
> +		goto out_deregister_fixed_link;

Hi,

I don't know if this can lead to the same issue, but a similar change 
broke a use case in another driver. See the discussion at[1].

It ended to using devm_clk_get_optional_enabled() to keep the same 
behavior as before.

CJ

[1]: 
https://lore.kernel.org/all/20240912104630.1868285-2-ardb+git@google.com/

>   
>   	privsize = sizeof(*fep) +
>   		   sizeof(struct sk_buff **) *
> @@ -917,7 +912,7 @@ static int fs_enet_probe(struct platform_device *ofdev)
>   	ndev = alloc_etherdev(privsize);
>   	if (!ndev) {
>   		ret = -ENOMEM;
> -		goto out_put;
> +		goto out_deregister_fixed_link;
>   	}
>   
>   	SET_NETDEV_DEV(ndev, &ofdev->dev);
> @@ -979,8 +974,6 @@ static int fs_enet_probe(struct platform_device *ofdev)
>   	fep->ops->cleanup_data(ndev);
>   out_free_dev:
>   	free_netdev(ndev);
> -out_put:
> -	clk_disable_unprepare(fpi->clk_per);
>   out_deregister_fixed_link:
>   	of_node_put(fpi->phy_node);
>   	if (of_phy_is_fixed_link(ofdev->dev.of_node))
> @@ -1001,7 +994,6 @@ static void fs_enet_remove(struct platform_device *ofdev)
>   	fep->ops->cleanup_data(ndev);
>   	dev_set_drvdata(fep->dev, NULL);
>   	of_node_put(fep->fpi->phy_node);
> -	clk_disable_unprepare(fep->fpi->clk_per);
>   	if (of_phy_is_fixed_link(ofdev->dev.of_node))
>   		of_phy_deregister_fixed_link(ofdev->dev.of_node);
>   	free_netdev(ndev);
> diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h b/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
> index ee49749a3202..6ebb1b4404c7 100644
> --- a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
> +++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
> @@ -119,8 +119,6 @@ struct fs_platform_info {
>   	int napi_weight;	/* NAPI weight			*/
>   
>   	int use_rmii;		/* use RMII mode		*/
> -
> -	struct clk *clk_per;	/* 'per' clock for register access */
>   };
>   
>   struct fs_enet_private {


