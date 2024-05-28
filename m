Return-Path: <linux-kernel+bounces-191927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8E58D162E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A781F22940
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1783A13C3D7;
	Tue, 28 May 2024 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="u+oFxHHp"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F208113AA32
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716884671; cv=none; b=CXe3XUxK1SowuJZ6WlTd6efxuUC1UptqCp6+oXgLFz3WG3URxG4DMnxJKDFhBflYOSdNRjZpFqHp77vruXTGxuO8EDdLHhp3h4B3ruFtcWqPQcYs8bBBcuughLghths+6OCQSCsvXEUi8p//Hvhvpa/8oc+CByld1IHoUPrRUO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716884671; c=relaxed/simple;
	bh=GCQ1m9J8lKx87/HGO9hdjPvS6kXTUT6TzFBSOkaPGOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uxfzl4Jzorp1j64NIEUsoVEY5pkp6qHHRM0yrZ8XIguUSsmdaHd0WPwueBceAu03+movDbYH1tCKhF4GFORFqz45n6/U4o3f6EtpI00HCzxt4nV7vY/aZNz4AnTzf0FslJGqyxEBqQAfDvwxGgaN/DR3eHWrQsk1Ul0mNR2LL0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=u+oFxHHp; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1716884661;
 bh=qPh1TUYouNens2NOG5rWGJXtGraotD7+jWwwz6GP7ds=;
 b=u+oFxHHpkVFzEXeLc7mOk22RSaekNUZUh0XXUoJqceI7t5Jep7dWMU3cZ7LG8Z2ybq1XOld4b
 Z6RcbRlhgJOlEozpcRSs9P8tI3SGh/M0BodCjQ/OC9173nYseoX6iXheH0vqbAVNgm3XNhTlZG0
 sfs8JKepIcqX83vlii8Qn9Hb5uxEqkyrdP4au3xLKGJ5fX11UnVVTTf/Oo3V3sA0TrEN7/6awXA
 4vkP4JjTTbEuGKmDiSg01QUmjqTG37cFednn3XBTZebhxhq/68ZhpVQuz4jSGPNrroZ26yQb5qE
 +TUP5+TOlY4+FfkJ++yK7EY0iTyWHpL0uz2WzZlArnJA==
Message-ID: <ecc0ddd7-531f-4d4b-8132-9851dae4af67@kwiboo.se>
Date: Tue, 28 May 2024 10:24:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH 00/13] rockchip: Fixes and improvements for ROCK
 Pi S
To: "=?UTF-8?Q?Heiko_St=C3=BCbner?=" <heiko@sntech.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240521211029.1236094-1-jonas@kwiboo.se>
 <171684956152.1783037.15483261423757153532.b4-ty@sntech.de>
 <1750846.QkHrqEjB74@diego>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <1750846.QkHrqEjB74@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 665594b3d1d2529ec2df17a9

Hi Heiko,

On 2024-05-28 00:43, Heiko Stübner wrote:
> Am Dienstag, 28. Mai 2024, 00:42:16 CEST schrieb Heiko Stuebner:
>> On Tue, 21 May 2024 21:10:03 +0000, Jonas Karlman wrote:
>>> This series include fixes for DT schema validation, fixes and improve
>>> support for onboard features of the Radxa ROCK Pi S board.
>>>
>>> Patch 1-2 fixes DT schema validation of ethernet and audio codec.
>>>
>>> Patch 3 fixes use of onboard SD NAND and eMMC.
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [02/13] arm64: dts: rockchip: rk3308: Fix codec@ff560000 reset-names
>>         commit: cb1622df6a28e3eac34a8b95feba2dd2dc6cd887
>> [03/13] arm64: dts: rockchip: rk3308-rock-pi-s: Fix SD NAND and eMMC init
>>         commit: 1fb98c855ccd7bc7f50c7a9626fbb8440454760b
>> [04/13] arm64: dts: rockchip: rk3308-rock-pi-s: Add sdmmc related properties
>>         commit: fc0daeccc384233eadfa9d5ddbd00159653c6bdc
>> [05/13] arm64: dts: rockchip: rk3308-rock-pi-s: Add pinctrl for UART0
>>         commit: 7affb86ef62581e3475ce3e0a7640da1f2ee29f8
>> [06/13] arm64: dts: rockchip: rk3308-rock-pi-s: Rename LED related pinctrl nodes
>>         commit: d2a52f678883fe4bc00bca89366b1ba504750abf
>> [07/13] arm64: dts: rockchip: rk3308-rock-pi-s: Add mdio and ethernet-phy nodes
>>         commit: 4b64ed510ed946a4e4ca6d51d6512bf5361f6a04
>> [08/13] arm64: dts: rockchip: Add OTP device node for RK3308
>>         commit: 36d3bbc8cdbef2f83391f7708888265ac4c37a99
>> [09/13] dt-bindings: power: rockchip: Document RK3308 IO voltage domains
>>         commit: 579e5b476307797b3a1260bec544dbbabcce1de5
>> [10/13] soc: rockchip: io-domain: Add RK3308 IO voltage domains
>>         commit: 0536fa6e6fa3e48f4ca11855b586c277be524fbe
>> [11/13] arm64: dts: rockchip: Add RK3308 IO voltage domains
>>         commit: d1829ba469d5743734e37d59fece73e3668ab084
>> [12/13] arm64: dts: rockchip: rk3308-rock-pi-s: Enable the io-domains node
>>         commit: 100b3bdee6035192f6d4a1847970fe004bb505fb
>> [13/13] arm64: dts: rockchip: rk3308-rock-pi-s: Update WIFi/BT related nodes
>>         commit: 12c3ec878cbe3709782e85b88124abecc3bb8617
>>
>> I've split this up slightly.
>> Some patches for 6.10 as fixes, and the rest for 6.11 .
>> Edited patch7 (for 6.11) to apply without patch6 (6.10)
>> That disappears during a merge of those branches.
> 
> and as stated, please re-send patch1 separately.

Thanks!, I will re-send first patch shortly :-)

Regards,
Jonas

> 
> Thanks
> Heiko
> 
> 


