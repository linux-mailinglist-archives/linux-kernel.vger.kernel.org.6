Return-Path: <linux-kernel+bounces-550082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAE0A55B21
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3333A18965C2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078CE1FFC70;
	Thu,  6 Mar 2025 23:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="GpgPu2AU"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01C12010FD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 23:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741304990; cv=none; b=m5ne8Jr9AsFus93cl/aOOhXgkv7D5XowsL5rwETOuxfhOmJ6xB44eP3PEGyG2ZBSiESAJijL4af6XXiAxxlfFOORtBAN6xc/zJ6CvodR9dIohyScLWXtzJxKG4nVGAIbgRIN5DEq2xIwfwV3yhSo+7+B+Yieg1C6nvq4wGQGIdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741304990; c=relaxed/simple;
	bh=TjTyGrcYB8Jm7rM3KapsODrBwAs8Avyb2414zXyldW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QTJ6WZZP9vpX5L0s5WeunApwe1jWSftZIn1jS9MOEdcQtfwAlkfvbvPwL04n+h27hqqgb7ynaHJp2/1STCvd0HN+ZYmUx9+mfgUdDBY2u9K84ML/Obxl+89XMWjuD7/5hT/TeDY/jU1oNjMHOJVVjaj4+GD0VXrdJQMpfl7limg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=GpgPu2AU; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1741304988;
 bh=oDJmvAX7nAqa4Vhl4U1zjfFrd0jhOQ7wzffB0eGRfkE=;
 b=GpgPu2AUbNHWX+mccsHZrxMS9C0kNVY/jogO8MGd7AU16uNQp1F2ta7r2T0DUxb7T+PeDDll2
 ZhFMpb7A8SJgrQAfzUIlYRzT7O7vqWAvJmEDEE8BvZdFRmwJgxtkaw8JghJESJam7daGsqJzb7B
 itd8zx5mo/o1lupzrdlLlbdUNNp0DCBEM82XvhTmd6v2n11R27aTnLQ3rsSf3m8S/Qw38SFaRHf
 mmylCyhyGnqqWXXwDP+ppOZ4bR06jiWHE13mBRAEhKPpVGdEJx4ec3350Kt4dj1oe5NsHFnPMy5
 TxuWYmGucI9HRylCH870G9CPRGm3R0DIPJUxFzEKeZSQ==
X-Forward-Email-ID: 67ca3498c1763851c065d4e9
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <1dd9e663-561e-4d6c-b9d9-6ded22b9f81b@kwiboo.se>
Date: Fri, 7 Mar 2025 00:49:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: stmmac: dwmac-rk: Validate rockchip,grf and
 php-grf during probe
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20250306210950.1686713-1-jonas@kwiboo.se>
 <20250306210950.1686713-3-jonas@kwiboo.se>
 <bab793bb-1cbe-4df6-ba6b-7ac8bfef989d@lunn.ch>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <bab793bb-1cbe-4df6-ba6b-7ac8bfef989d@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 2025-03-06 23:37, Andrew Lunn wrote:
> On Thu, Mar 06, 2025 at 09:09:46PM +0000, Jonas Karlman wrote:
>> All Rockchip GMAC variants require writing to GRF to configure e.g.
>> interface mode and MAC rx/tx delay. The GRF syscon regmap is located
>> with help of a rockchip,grf and rockchip,php-grf phandle.
> 
>> @@ -1813,8 +1564,24 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
>>  
>>  	bsp_priv->grf = syscon_regmap_lookup_by_phandle(dev->of_node,
>>  							"rockchip,grf");
>> -	bsp_priv->php_grf = syscon_regmap_lookup_by_phandle(dev->of_node,
>> -							    "rockchip,php-grf");
>> +	if (IS_ERR(bsp_priv->grf)) {
>> +		ret = PTR_ERR(bsp_priv->grf);
>> +		dev_err_probe(dev, ret, "failed to lookup rockchip,grf\n");
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	bsp_priv->php_grf =
>> +		syscon_regmap_lookup_by_phandle_optional(dev->of_node,
>> +							 "rockchip,php-grf");
>> +	if ((of_device_is_compatible(dev->of_node, "rockchip,rk3588-gmac") ||
>> +	     of_device_is_compatible(dev->of_node, "rockchip,rk3576-gmac")) &&
>> +	    !bsp_priv->php_grf)
>> +		bsp_priv->php_grf = ERR_PTR(-ENODEV);
> 
> It seems odd you say all variants need this property, and then you
> look for two specific variants here and do something different? Why
> are these two special?

rockchip,grf is required for all GMACs, rockchip,php-grf is also needed
on rk3576 and rk3588 (+rk3562 that has been posted on ML) :-S

Above use of of_device_is_compatible() was my attempt at requiring the
syscon regmap for those variants that make use of php_grf. And still not
break rk3562 depending on the order these would land.

Should probably clarify a little bit with a code comment in a v2.

Regards,
Jonas

> 
> 	Andrew


