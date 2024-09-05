Return-Path: <linux-kernel+bounces-316898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2260A96D6B1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEDC3B24E13
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26CF1991D6;
	Thu,  5 Sep 2024 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="TUAvXYNd"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA549195B37;
	Thu,  5 Sep 2024 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725534335; cv=none; b=tdCqFipGYYw2LU35ho2UMaVUhrLzOLWJVFhvBZbSQql1zaIG1aFgX4xlncAM+AW4AHPFz5aCLQpNiPy4UKGn2KrWfrlxNSOQbGS9yRxk3Up/wrpQD4mg0WsWBrBkl/+6sCGbH2av5fQ/EqKr9lAg0ob+Xbp/WsnqeOIhcivzq5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725534335; c=relaxed/simple;
	bh=jh9R+58gp0EaUpQ0MtSEHWV+UrVP5s4/LQSZNzCl8Ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=QXwIST7F7tVEiOUUkScjJNNrlx1JnbJ/DF9bh8SV6VWrIqMNQ5711RyZRNM7dRFRNArevxOwno/eIGG/aZAoLUh1Ng69ionnt2eRGxk2vbdRzvhykE2ybiVcY2S8sWJNviAHHGVfTsoBVnCSqok/6dxsx1i1IpRxoZ3Hsqph/AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=TUAvXYNd; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [14.155.100.110])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 8DB27789EE;
	Thu,  5 Sep 2024 19:05:27 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 8DB27789EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725534328;
	bh=pJfwzVFsBxD8QgeCLnJpuG01Hv3jSe19yTLA9YcFox4=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=TUAvXYNdg2ZrNCB9GNG9exshtyxtjwaz1qS6De3IEaR2MCp8GfQaAXr75zrEMRb3y
	 NuPmSkAKHBieMFrdosT8AmUP7XZzW+/S0kDqMezq2ti0NzJfy916AHHNe6G335XLHy
	 bwN3tedJGfx7ZQp8VM4gyLk6lvJIJvjKECDnBwAk=
Message-ID: <61bccef8-8cb1-4224-accd-0468e8892b91@classfun.cn>
Date: Thu, 5 Sep 2024 19:06:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: add dts for Ariaboard
 Photonicat RK3568
To: Chukun Pan <amadeus@jmu.edu.cn>
References: <010a9c5e-205b-40b9-9655-9e168b2def97@classfun.cn>
 <20240905100100.348444-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Junhao Xie <bigfoot@classfun.cn>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jonas Karlman <jonas@kwiboo.se>, Chukun Pan <amadeus@jmu.edu.cn>,
 FUKAUMI Naoki <naoki@radxa.com>, Dragan Simic <dsimic@manjaro.org>,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Junhao Xie <bigfoot@classfun.cn>
In-Reply-To: <20240905100100.348444-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/9/5 18:01, Chukun Pan wrote:
> Hi Junhao,
> 
>>>> +	vcc5v0_usb_modem: regulator-5v0-vcc-usb-modem {
>>>
>>> Are you sure this regulator is 5v?
>>>
>>
>> It should actually be 3.3V, I will fix it and rename
>> to vcc3v3_usb_modem
> 
> I prefer vcc3v3_rf or vcc3v3_ngff,
> this is closer to the schematics.
> 

Yes, I changed it to vcc3v3_rf, this is the name used in the schematics.

>>>> +	pinctrl-names = "default";
>>>> +	pinctrl-0 = <&pcie30x2m1_pins>;
>>>
>>> These are actually pcie30x1m0_pins.
>>
>> pcie30x1m0_pins seems to conflict with sdmmc0,
>> I changed it to pcie30x1m1_pins
> 
> This is obviously incorrect. I didn't notice that
> your pinctrl for sdmmc0 is wrong.
> (Because the cd pin are different)

After fixing sdmmc0, using pcie30x1m0_pins can work normally.

Best regards,
Junhao

