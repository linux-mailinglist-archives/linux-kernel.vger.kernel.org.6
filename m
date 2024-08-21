Return-Path: <linux-kernel+bounces-295397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FAF959A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25CE1C2235B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCEE1CDA23;
	Wed, 21 Aug 2024 11:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ck8kFNAW"
Received: from msa.smtpout.orange.fr (out-71.smtpout.orange.fr [193.252.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5991CDA0D
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239121; cv=none; b=IBne+u48PU0EMcScCyQKszLYLsngAypyugI/3NqUSnNzwvgD3+o+lsD/xQp9YZLRhapOIeqogCRkcxpxioiZpdZY2X49SVC1Vbn3xO6caYf8P+wGJPNroIZFcc0F+5E17mwo3WKMmq8m8kP46aroK85b4Ta5vEJaChjw112RoM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239121; c=relaxed/simple;
	bh=WwgXbpLqgBQF0a/xYLjADJ5Yia3dV3k05o2a7s9dT7k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=p2uj+dvryaTCSJeeUbKNm6NHGVZjBE2S2HpkcVofIkQrBa03H148GrKNtXL4j6Ej5g/O7oyNM9Z3X8hIWedndDjm1IiWPJA0ibcuxcPSO9pIHEmfIljIZH2Qpbx38AGLEzx1rV7sye5PwuWKnFKStdu/iWo2cnagfaXLpTiBeA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ck8kFNAW; arc=none smtp.client-ip=193.252.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id gjL9sQFngCul1gjL9sEtOj; Wed, 21 Aug 2024 13:17:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724239046;
	bh=kr2KiH+kUfl/3dNGPVMYeEb8Ymgpv3gnzcFAS84Bn34=;
	h=Message-ID:Date:MIME-Version:From:Subject:To;
	b=ck8kFNAWQa0WtgUERuyPYqzkZxKa72JzNcJByRCWnakgkadAr8dFipxmsG4UZ9bdW
	 Jr+5KXc24nDNVWnadOtk/G9/TqoGPZ2WUtGFuVYLlTmGif0g/bAkaJZh//detw497N
	 ZwB+3ftk1K8SMqXVLZj0InF1VWJLMnMrUPkp0Ae47Xu7WfAcwPXqhOpdBOyFw9+pTG
	 RYsCGkbv6eVjpGNUKQR1N2fNnUw8zbPzMmkUn69Q4qsjF7NTbgSxAYbhebqnwbBzBB
	 9ls4gxSoq4ZNLuxOhA5I3a06REGzn8VmNyH68ZarY/JcIRW04psooOs80zwqNfqTTO
	 Zwu7WUfaweXdg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Wed, 21 Aug 2024 13:17:26 +0200
X-ME-IP: 90.11.132.44
Message-ID: <816aa82c-1f50-4dfe-a41f-e396e0bdf219@wanadoo.fr>
Date: Wed, 21 Aug 2024 13:17:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v2 2/3] phy: phy-rockchip-inno-usb2: Handle failed extcon
 allocation better
To: Dragan Simic <dsimic@manjaro.org>, linux-rockchip@lists.infradead.org,
 linux-phy@lists.infradead.org
Cc: vkoul@kernel.org, kishon@kernel.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1724225528.git.dsimic@manjaro.org>
 <96200baf794a0c451f3bbc3f5530b8cf0e359dfc.1724225528.git.dsimic@manjaro.org>
X-Mozilla-News-Host: news://news.gmane.io
Content-Language: en-US, fr-FR
In-Reply-To: <96200baf794a0c451f3bbc3f5530b8cf0e359dfc.1724225528.git.dsimic@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 21/08/2024 à 09:37, Dragan Simic a écrit :
> Return the actual error code upon failure to allocate extcon device, instead
> of hardcoding -ENOMEM.  Use dev_err_probe() to also log appropriate messages,
> which is fine because the containing function is used in the probe path.
> 
> Helped-by: Heiko Stubner <heiko@sntech.de>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>   drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index 113bfc717ff0..05af46dda11d 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -435,7 +435,8 @@ static int rockchip_usb2phy_extcon_register(struct rockchip_usb2phy *rphy)
>   						rockchip_usb2phy_extcon_cable);
>   
>   		if (IS_ERR(edev))
> -			return -ENOMEM;
> +			return dev_err_probe(rphy->dev, PTR_ERR(edev),
> +					     "failed to allocate extcon device\n");

Returning PTR_ERR(edev) may make sense, but I don't think that adding a 
dev_err_probe() really helps.

devm_extcon_dev_allocate() can only return -EINVAL if it 2nd argument is 
NULL. It is trivial to see that it can't happen here, 
rockchip_usb2phy_extcon_cable is a global variable.

in all other cases, it returns -ENOMEM because of a failed memory 
allocation. In this case, usually it is not needed to log anything 
because it is already loud enough.

Just my 2c.

CJ


>   
>   		ret = devm_extcon_dev_register(rphy->dev, edev);
>   		if (ret) {
> 
> 


