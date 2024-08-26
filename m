Return-Path: <linux-kernel+bounces-300931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D810C95EAC0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8461C2152F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 07:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2BE13A3F6;
	Mon, 26 Aug 2024 07:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="UYIt0vym"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0802D052;
	Mon, 26 Aug 2024 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724658344; cv=none; b=E5Jn/AyJnZ+u96IAkk5CCVSyKatFrGdVkyg49B3t2x6dYGaIWu8XvTLoANx3BDJS9v/MNk4OJlSPVp01KusKt0JyXCE8WfETtDFcMfW7AtdwMKBJhHqP2qlLcvL3TYA3ZA16G4Wn6wZsYxqOsArf0BGEpNg2S9yYzlIuKc3U9Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724658344; c=relaxed/simple;
	bh=vgiDjg6ERTOokHd3WN2U4z0/E/rvw7eX4pWbXDCewGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=kmjpSREbp1Q1E8Nd6arn1W6JzMfGOcw1eB5rrSjQ8AlYTMv7KZsYq7E0Ju7G6jYDux06D3OsfOzYjjyKW4YJJXZ5LhGAzJEo9Myw3LGl/Mf7n9Rsfe5u9tM8eR/+DmgkkBR+AmPBKIVcbt5X/eX+8mztKfQEzW9+3b+BmK3R7f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=UYIt0vym; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [14.153.79.170])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 21858789DF;
	Mon, 26 Aug 2024 15:45:33 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 21858789DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1724658338;
	bh=m5/rFI10QPDFYm6oHs30udevEbWy1s0fAFZ7HUo6nKU=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=UYIt0vymjXO0pPbBCdZajGwZOFuifJhyVT320kIjBgeOkzFuxZibkag7/1fN8mo9i
	 pOfrm20CGGJwuthziD0PI73lrTeK1LUgMduoyDvNK2U9zJ5yextJaxLvEpiipo3u0k
	 mqXx5XSzzywBQ6HS7qNVPRR0CLJQX4fdD75kHPqE=
Message-ID: <25346f43-642a-477d-8df5-91ddf2765d69@classfun.cn>
Date: Mon, 26 Aug 2024 15:46:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: add dts for LCKFB Taishan Pi
 RK3566
To: Krzysztof Kozlowski <krzk@kernel.org>
References: <20240826044530.726458-1-bigfoot@classfun.cn>
 <20240826044530.726458-4-bigfoot@classfun.cn>
 <wacysftuozwpumrw262tltoxqrldlju7mzj5fnxxcjheycjvzr@wb7mcnbiv6ic>
Content-Language: en-US
From: Junhao Xie <bigfoot@classfun.cn>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jonas Karlman <jonas@kwiboo.se>, Chukun Pan <amadeus@jmu.edu.cn>,
 FUKAUMI Naoki <naoki@radxa.com>, Dragan Simic <dsimic@manjaro.org>,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Junhao Xie <bigfoot@classfun.cn>
In-Reply-To: <wacysftuozwpumrw262tltoxqrldlju7mzj5fnxxcjheycjvzr@wb7mcnbiv6ic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/8/26 14:06, Krzysztof Kozlowski  wrote:
> On Mon, Aug 26, 2024 at 12:44:13PM +0800, Junhao Xie wrote:
>> Add dts for LCKFB Taishan Pi.
>>

[...]

> 
>> +	dc_12v: dc-12v {
> 
> Use some reasonable prefix or suffix (regulator) for all regulator
> nodes. Or even: use name for all fixed regulators which matches current
> format recommendation: 'regulator-[0-9]v[0-9]'
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml?h=v6.11-rc1#n46
> 

Thanks, I will rename it to dc-12v-regulator

[...]

>> +
>> +&sdhci {
>> +	bus-width = <8>;
>> +	max-frequency = <200000000>;
>> +	non-removable;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe &emmc_rstnout>;
>> +	status = "okay";
> 
> Keep status the last.
> 
> Best regards,
> Krzysztof
> 
> 

Thanks for your review, I will fix all problems and post patch v2!

