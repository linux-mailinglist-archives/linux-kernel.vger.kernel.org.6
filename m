Return-Path: <linux-kernel+bounces-224036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3330911C54
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9E91F2500C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FF6168C2C;
	Fri, 21 Jun 2024 06:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="fCQgsxBN"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1DA12D1EB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718953115; cv=none; b=rGlCtQxGoGgPmbOiSbnp/xV3+azAdLKGDpU1IB9ZO4s/sPrCNG9LhxAdpWyfFLvimUAVEq22p2nsX1QaYeaBV/sU/vxeGziGbRvb6tV2BQ0K27YMACNsiax329NtsDkNvD9A7/6LTd+wqfkdP7Uv9bSd6vplJIQiAM01tCeynOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718953115; c=relaxed/simple;
	bh=VB3sa7wRXdFENiXd89umSPAzZXPKf6iCSmNFgLdO8uA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nh0Ez64gzjdiVac3VojNZLy2wGA+t0nnZwU3OI3nLM1ck8CA87D3k4+IPRUSbasvO6F4oJsVxYdIO7kIbfpOlUGQ/7wRIBpd7eQPgn4gGHXVML8P1N2aD35TQY4AbmeSR2MJI28OkFBdzMt3hMursB73tPI3CUj0ClXAbEpeNL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=fCQgsxBN; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1718953096;
 bh=wuLrixmm9mNItymNAgLNb/E3azKTDfSKGMXK8se96Fg=;
 b=fCQgsxBNHkuFS1z62RU/VUZaXp3TsQ9b5GHwAzHFImPMWn/gWKBocMV2QIzE6YS7Aj5/zWpXt
 4bklNla1MfdslTLQZmQLnTdeYgaIa8k2mPn5FSyn1IwDtUiF87trVsJE/h3b5AEjt8lWaMTX5vN
 sBV9z8Hp0bhGNoEtr0vXrsQTiBfH24BD96l5etYOnv8xQHHFcZg6+3xASN1NpaV2hYpRmBiwb+F
 J43Xok0sVtX6irfEJQaRkJ3i/tOB0bfak/AiAtFvBDWCjPRc/26P6G+gsVeqttuKWEm9a5apsrw
 iG7mBOCNT5qsqPHtFDpQ8F1G8FLEGW/IcueQ/2Dpwmlw==
Message-ID: <dbf9d54e-1197-4731-80f2-91ff7c9954e4@kwiboo.se>
Date: Fri, 21 Jun 2024 08:58:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dts: rockchip: Fix mic-in-differential usage
 on rk3568-rock-3a
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiko
 Stuebner <heiko@sntech.de>, Chris Zhong <zyw@rock-chips.com>, Zhang Qing
 <zhangqing@rock-chips.com>, Chris Morgan <macromorgan@hotmail.com>, Furkan
 Kardame <f.kardame@manjaro.org>, Michael Riesch
 <michael.riesch@wolfvision.net>, kernel@collabora.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240619-rk809-fixes-v1-0-fa93bc5313f4@collabora.com>
 <20240619-rk809-fixes-v1-3-fa93bc5313f4@collabora.com>
 <c35b3e80-7889-473d-8365-88436c3cb9a9@kwiboo.se>
 <4015ded1-5ec4-4374-982e-9c7f23b43884@collabora.com>
 <1fce65a2-b752-4bab-84e5-314b60d682f0@collabora.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <1fce65a2-b752-4bab-84e5-314b60d682f0@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 667524847560ce51b8f26441

Hi Cristian,

On 2024-06-21 03:23, Cristian Ciocaltea wrote:
> On 6/19/24 3:56 PM, Cristian Ciocaltea wrote:
>> Hi Jonas,
>>
>> On 6/19/24 3:22 PM, Jonas Karlman wrote:
>>> Hi Cristian,
>>>
>>> On 2024-06-19 13:23, Cristian Ciocaltea wrote:
>>>> The 'mic-in-differential' DT property supported by the RK809/RK817 audio
>>>> codec driver is actually valid if prefixed with 'rockchip,':
>>>>
>>>>   DTC_CHK arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dtb
>>>>   rk3568-rock-3a.dtb: pmic@20: codec: 'mic-in-differential' does not match any of the regexes: 'pinctrl-[0-9]+'
>>>> 	from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk809.yaml#
>>>>
>>>> Make use of the correct property name.
>>>>
>>>> Fixes: a84ffd2ef1ff ("arm64: dts: rockchip: Fix mic-in-differential usage on rock-3a")
>>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>>> ---
>>>>  arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
>>>> index ebdedea15ad1..0b54dfe92d6e 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
>>>> @@ -533,7 +533,7 @@ regulator-state-mem {
>>>>  		};
>>>>  
>>>>  		codec {
>>>> -			mic-in-differential;
>>>> +			rockchip,mic-in-differential;
>>>
>>> If I understand the schematics correctly, only one wire is connected so
>>> this board cannot really use differential signaling, and this should
>>> probably instead be dropped.
>>
>> Thanks for pointing this out, I will drop it in v2.
> 
> I've also checked the schematics which indicate the PMIC RK809 CODEC
> receives both MIC1_INN and MIC1_INP signals; the former comes from the
> Jack input, while the latter is generated by the SLM42Q3AT MEMS Microphone.
> 
> However, I'm not sure the Mic presence on the board is dependent on the
> HW revision - on REV V1.3 the "NC_" prefix under U24 component label
> suggests it is not connected.  So maybe we should keep the property?!

There is no such mic on the board, at least on the rev 1.3 that I have.

This prop should be used to indicate that the attached microphone uses
differential signaling, e.g. should have its two output signals
connected to both INP(+) and INN(-).

The SLM42Q3AT or the single wire from headphone jack indicate that a
single-ended microphone is/can be used/wired on this board.

The current use of non-working mic-in-differential was wrong, adding
the rockchip,mic-in-differential would change behavior and wrongly
describe hw of this board.

Regards,
Jonas

> 
> Cristian


