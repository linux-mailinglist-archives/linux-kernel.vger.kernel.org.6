Return-Path: <linux-kernel+bounces-221076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE9390EB80
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C701F23DCD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088C4143C4E;
	Wed, 19 Jun 2024 12:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PvvATBFX"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3666FC1F;
	Wed, 19 Jun 2024 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801802; cv=none; b=V11O+xQf6G6V9l9tdqW/+PyO+p333GfhiCmjnvkaCrjYaNIYw/KkE1yryK7TuggYgNdvznMzhrT0qejLJRy/wbKpCmq5UGYtt3rNDxMD3AREen+NHizq+EBkAr4PEb2LG+r8sIbGkGAf/pZbAT+TfkwgN2PdP1RQ1XLcQ9jZ2sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801802; c=relaxed/simple;
	bh=CV/Tc2pxa3ANa+QjAhEaKD0qTxtoiav6L/E0jjqRJCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TRqoe2L25PICzsq4llzett1ehU9KWZOktlCfHEFj9OhXuQUpUkzsHIdRNemdCYewjJQChFI/1xnBK2Sr19RuxKIxLRQKBJ9r0G4zcT8chJsaEKVJmWrYqzA1J22s9BGwHjHP4EjoWymoU99urT3JlYYR+kCb8QbhT290FlCo9Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PvvATBFX; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718801799;
	bh=CV/Tc2pxa3ANa+QjAhEaKD0qTxtoiav6L/E0jjqRJCk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PvvATBFX0Wxgq+KNUYEvS5s5cgTMyRVf4WFkP7aAQB+TC60caSub09yxcSvVThweQ
	 f9v/oh0xyWBBBuBxD1+ESODj9UPfP9DFA8Gusc0DQn3MrDH2rD0da17kyWUt4RuBdU
	 lcDDNArCF3ok60MZCCaNXEu7qoqNz5rcf48oBTRqL38cgFTi0tP48pWsEdVcWiFmyI
	 yhVzpDNuKbv+I5jEN4jKslvRKwo/HWqzB/sI0NaBcslu2q/uY0LOIoocKYFmV2RnC9
	 tGCuWJ5XXmpU9NR/VlfSefVcxT1S4RosNeDV/UzrMMa9RZli03QZ6QIBVBA83WlBrM
	 5sqUP75zGOD4w==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 08FF73782159;
	Wed, 19 Jun 2024 12:56:37 +0000 (UTC)
Message-ID: <4015ded1-5ec4-4374-982e-9c7f23b43884@collabora.com>
Date: Wed, 19 Jun 2024 15:56:37 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dts: rockchip: Fix mic-in-differential usage
 on rk3568-rock-3a
To: Jonas Karlman <jonas@kwiboo.se>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Chris Zhong <zyw@rock-chips.com>, Zhang Qing <zhangqing@rock-chips.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Furkan Kardame <f.kardame@manjaro.org>,
 Michael Riesch <michael.riesch@wolfvision.net>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240619-rk809-fixes-v1-0-fa93bc5313f4@collabora.com>
 <20240619-rk809-fixes-v1-3-fa93bc5313f4@collabora.com>
 <c35b3e80-7889-473d-8365-88436c3cb9a9@kwiboo.se>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <c35b3e80-7889-473d-8365-88436c3cb9a9@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonas,

On 6/19/24 3:22 PM, Jonas Karlman wrote:
> Hi Cristian,
> 
> On 2024-06-19 13:23, Cristian Ciocaltea wrote:
>> The 'mic-in-differential' DT property supported by the RK809/RK817 audio
>> codec driver is actually valid if prefixed with 'rockchip,':
>>
>>   DTC_CHK arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dtb
>>   rk3568-rock-3a.dtb: pmic@20: codec: 'mic-in-differential' does not match any of the regexes: 'pinctrl-[0-9]+'
>> 	from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk809.yaml#
>>
>> Make use of the correct property name.
>>
>> Fixes: a84ffd2ef1ff ("arm64: dts: rockchip: Fix mic-in-differential usage on rock-3a")
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
>> index ebdedea15ad1..0b54dfe92d6e 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
>> @@ -533,7 +533,7 @@ regulator-state-mem {
>>  		};
>>  
>>  		codec {
>> -			mic-in-differential;
>> +			rockchip,mic-in-differential;
> 
> If I understand the schematics correctly, only one wire is connected so
> this board cannot really use differential signaling, and this should
> probably instead be dropped.

Thanks for pointing this out, I will drop it in v2.

Regards,
Cristian

