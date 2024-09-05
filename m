Return-Path: <linux-kernel+bounces-316367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A460B96CE7B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 263F8B2189F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F813188A37;
	Thu,  5 Sep 2024 05:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="BEpbo9Gx"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D16A79F5;
	Thu,  5 Sep 2024 05:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725514559; cv=none; b=ouE53cA8i5SOUIRmEJjklgqUzpUQiA+a4SvIyXwbHbmMfCUFWi1LzW7oKKz+QwY/JS8eC53zrhC6J5/zj3Pn1rl+/o+/Oh71yUWsSZLyx9rKdR2BzFMbmBrJCD3Kj/RAcNeRUkLr3XG0ffasa4z7KU7vvBMo0Qvay5MGKkKp9so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725514559; c=relaxed/simple;
	bh=osc/smiOWFFNrU4OiWoZZ3YpfJzqbUUrBExgfChP/RE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=dboa5yiNrODzylbMPciWNs5QOdeExAvJP2yFIHQIRY8+zkTNE+/XNIpIB+FFaNV8pUcKEOrVQ+LTceN4IIhC79R16TqZw30P5ilsfh+xFhh/wLWl+iQxbbwti2sv9aByT5CFUKq5cxwrpXYnJPtGIVnBH01m5G530CdKguxmVTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=BEpbo9Gx; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [14.155.100.110])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 9BB38789E6;
	Thu,  5 Sep 2024 13:35:51 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 9BB38789E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725514552;
	bh=Hyq7RqSAoGC1rJ0dAnU4OWaWJgGE8rjFiQIsdvKZxrE=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=BEpbo9Gxr0f/JzpbESCFyy+vrgyiztBYy3YF9ldf8uy/I7cfJRoPr/SQ4Y0I+lPva
	 dF2Gl8+FxzzowZOAGFiQ/h6WCyKA7TJaI8UylOzC82VVCzZZXksxxBbDRaoGhVX0Ei
	 4COSwaqLPQHkTp7A8dOz/olPzxiwDB7pDCimUlaE=
Message-ID: <f8a5018f-113d-4d9d-9223-954d054796a6@classfun.cn>
Date: Thu, 5 Sep 2024 13:37:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add support for Ariaboard Photonicat RK3568
To: "Rob Herring (Arm)" <robh@kernel.org>
References: <20240904111456.87089-1-bigfoot@classfun.cn>
 <172545685977.2410524.10394848640957143488.robh@kernel.org>
Content-Language: en-US
From: Junhao Xie <bigfoot@classfun.cn>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jonas Karlman <jonas@kwiboo.se>, Chukun Pan <amadeus@jmu.edu.cn>,
 FUKAUMI Naoki <naoki@radxa.com>, Dragan Simic <dsimic@manjaro.org>,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Junhao Xie <bigfoot@classfun.cn>
In-Reply-To: <172545685977.2410524.10394848640957143488.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/9/4 21:36, Rob Herring (Arm) wrote> On Wed, 04 Sep 2024 19:14:53 +0800, Junhao Xie wrote:
>> Add dts for Ariaboard Photonicat RK3568.
>>
[...]
> 
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>   pip3 install dtschema --upgrade
> 
> 
> New warnings running 'make CHECK_DTBS=y rockchip/rk3568-ariaboard-photonicat.dtb' for 20240904111456.87089-1-bigfoot@classfun.cn:
> 
> arch/arm64/boot/dts/rockchip/rk3568-ariaboard-photonicat.dtb: phy@fe8c0000: 'phy-supply' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/phy/rockchip,pcie3-phy.yaml#

I will remove it in PATCH v2

> arch/arm64/boot/dts/rockchip/rk3568-ariaboard-photonicat.dtb: rfkill-modem: 'reset-gpios' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/net/rfkill-gpio.yaml#

The modem in Photonicat must have a reset signal to work properly.
I can find reset-gpios in net/rfkill/rfkill-gpio.c, but it is not in the schema.
Maybe reset-gpios is missing in rfkill-gpio.yaml? or this property cannot be used in dts?

> 

Thanks for your reply, I will fix them in PATCH v2.

Best regards,
Junhao

