Return-Path: <linux-kernel+bounces-563579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFBFA6449D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD97170A36
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F283021ABD8;
	Mon, 17 Mar 2025 08:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="cjVU4suM"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5FB199252
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742198501; cv=none; b=IWy8MFAMSe5I/0uWCIHrJkhVpPLuLhu24vXFeh9Gz530IXe37aMxH4wby7/kTPMaLZw3dA2JXu3pxnaNfbWTyn540VzOvrB8+aCBCw31lY+S2TORnqWcRavNCm+KGXOpfF7PEGOlkSWfRmM07alh5eozZ+sZ+I8MNfSWiTFYna0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742198501; c=relaxed/simple;
	bh=g1ZDFBHMJhbCn2huwa39URgbhTaTzoxEPanrgFu50HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LCO3ZE9sKF1aYSX1Nq/ZGbsvdUT+qyuKs3aZnDvYWbPaACvn5ptIh+qEG+z/DQ+c7jMeJEKRS/WWhzzzY8/YYPmM0dBYXf86u0jw4rF/TsvUGrM5euNGEubyUYlXe2nHxe/AgQ46iAymKqnCPqglUfKTD2r88xL+m2NEDoJcvLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=cjVU4suM; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1742198498;
 bh=W5O/hxV8vbhDPZf+MT7E5Xer9GBrYGhbr052JbAP7DU=;
 b=cjVU4suM240N8aGS6MV6d+doIi5CHJPlomtBuncUhTK8X14Y1dCQeIvzaMfpyQYw92U5NDDIv
 WgZad8WKK+S9fbWyw26eO49BSTpmhh6KnoVhqRq3+HQ6jJurWQKS7b4JG/1tIVdLhCDF/yieg3n
 ixS4HHN9MQz2wkgAU/ForNKLbnInSevoDprbBk10LwC5eaZVmtef6zkSwVo7kNHvSondm1xABdF
 qr8p3WPhEFEvmCEj2pzUcTJajvhl1FJJs1C5ziproDTNJk2rkVUcaS6Pg2qiydbUswNKTy6tMEx
 Mq4Ten/2637Gj56GOgxePTaNp9tMq8fhgxVWLsleLrRg==
X-Forward-Email-ID: 67d7d6dac3abe04af7200682
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <da550920-bb2e-4032-82a9-1bf02aae9e17@kwiboo.se>
Date: Mon, 17 Mar 2025 09:01:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] pinctrl: rockchip: Add support for RK3528
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "heiko@sntech.de" <heiko@sntech.de>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "ziyao@disroot.org" <ziyao@disroot.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20250228064024.3200000-4-jonas@kwiboo.se>
 <20250317070002.707674-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250317070002.707674-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Chukun,

On 2025-03-17 08:00, Chukun Pan wrote:
> Hi,
> 
>> Add gpio and pinctrl support for the 5 GPIO banks on RK3528.
> 
> https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/blob/rk3528/drivers/pinctrl/rockchip/pinctrl-rk3528.c#L204-L207
> 
> I noticed that there is a little difference between u-boot and kernel
> pinctrl driver. Does kernel need to sync this changes from u-boot?

RK3568_SCHMITT_BITS_PER_PIN is defined as 2 and RK3528_SMT_BITS_PER_PIN
as 1 so I think this code is correct, however I can probably update the
U-Boot code to use similar pattern as in Linux driver before sending a
new revision of the U-Boot series (probably after v6.15-rc1-dts).

Regards,
Jonas

> 
> ```
> diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
> index 930c454e0cec..c77d9a6cd535 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.c
> +++ b/drivers/pinctrl/pinctrl-rockchip.c
> @@ -3070,6 +3070,7 @@ static int rockchip_get_schmitt(struct rockchip_pin_bank *bank, int pin_num)
>  
>  	data >>= bit;
>  	switch (ctrl->type) {
> +	case RK3528:
>  	case RK3562:
>  	case RK3568:
>  		return data & ((1 << RK3568_SCHMITT_BITS_PER_PIN) - 1);
> @@ -3100,6 +3101,7 @@ static int rockchip_set_schmitt(struct rockchip_pin_bank *bank,
>  
>  	/* enable the write to the equivalent lower bits */
>  	switch (ctrl->type) {
> +	case RK3528:
>  	case RK3562:
>  	case RK3568:
>  		data = ((1 << RK3568_SCHMITT_BITS_PER_PIN) - 1) << (bit + 16);
> ```
> 
> Thanks,
> Chukun
> 
> --
> 2.25.1
> 


