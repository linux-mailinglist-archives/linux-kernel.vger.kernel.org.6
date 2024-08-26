Return-Path: <linux-kernel+bounces-301162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B7A95ED2A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91EDA280DFA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6FE145B10;
	Mon, 26 Aug 2024 09:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="GbDhn75X"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAC9762DF;
	Mon, 26 Aug 2024 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724664618; cv=none; b=VKhCoLwTra4wLafudylWO9rypkmzQ7jsdPlY6gABXRfSmk/msisuw10wfonsQLAk8eo8UbB7fBVYAzBQsHK3tb48GYs1XXjV4WA/c2KymDDy8zaQyaU0ujgvunjTDDlpxQ5KrBOhO0uggbTXe4SRboU2pi4WI9wrhtjjvx9rtJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724664618; c=relaxed/simple;
	bh=HLok6mTPZERVJ+FSTOaHCaLiTx3Gv+uAP3XVDmphfg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=k48AtcVp7dMOyy/szAnVrLu5OLMjbvvEIISdfNgJ92Zy+RRn6QtPtK49wfhMsYXQzbcHu2fHBhLkcWbzLGnRsDeM2rvQThBKJO9CuWHcdEY6kltouu6X1/0oR6uxvCBQUdBgJSsDc5CWLxBa/NTupSv2uOIFqxglrLvffGB2xsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=GbDhn75X; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [14.153.79.170])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id BEBC3789E6;
	Mon, 26 Aug 2024 17:30:09 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn BEBC3789E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1724664612;
	bh=E1SNoYEZ4p+3pbRHYtbReN/JAn6omYUTA1ydrwnhtbg=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=GbDhn75XwbsxD891FZqbysU++x/WvI6aVU5RhB9FOJiQlwust3OwEXrxCZ8WnO/rO
	 FKP28r2SHmcYl7eYSaijA9UqLa/+J2ozqfKkY8uVuAZThtE3R/7FzL80bJhRPF2DqB
	 ZgIp7wm3XYbS/QWhcNr3qvp90QivOa/65GaWnWwk=
Message-ID: <38d627e8-3dd2-4042-a87d-21220fe9fb5a@classfun.cn>
Date: Mon, 26 Aug 2024 17:31:25 +0800
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
 <25346f43-642a-477d-8df5-91ddf2765d69@classfun.cn>
 <8e14d43b-598b-4aef-9c22-84122e17a77e@kernel.org>
Content-Language: en-US
From: Junhao Xie <bigfoot@classfun.cn>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jonas Karlman <jonas@kwiboo.se>, Chukun Pan <amadeus@jmu.edu.cn>,
 FUKAUMI Naoki <naoki@radxa.com>, Dragan Simic <dsimic@manjaro.org>,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <8e14d43b-598b-4aef-9c22-84122e17a77e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/8/26 16:08, Krzysztof Kozlowski wrote:
> On 26/08/2024 09:46, Junhao Xie wrote:
>> On 2024/8/26 14:06, Krzysztof Kozlowski  wrote:
>>> On Mon, Aug 26, 2024 at 12:44:13PM +0800, Junhao Xie wrote:
>>>> Add dts for LCKFB Taishan Pi.
>>>>
>>
>> [...]
>>
>>>
>>>> +	dc_12v: dc-12v {
>>>
>>> Use some reasonable prefix or suffix (regulator) for all regulator
>>> nodes. Or even: use name for all fixed regulators which matches current
>>> format recommendation: 'regulator-[0-9]v[0-9]'
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml?h=v6.11-rc1#n46
>>>
>>
>> Thanks, I will rename it to dc-12v-regulator
> 
> Well, this makes ordering tricky and is not the proposed policy, but
> sure... I gave you reference hoping you will read it.
> 
> Best regards,
> Krzysztof
> 
> 

Oh, sorry, it should be renamed to 'regulator-12v0-dcin',
as this name complies more with the policy.
Thank you for the reminder!

