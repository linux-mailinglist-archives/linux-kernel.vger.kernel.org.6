Return-Path: <linux-kernel+bounces-374971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E42019A72A2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BD8D1F2213E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B551FAC34;
	Mon, 21 Oct 2024 18:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UUFdLXU2"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEB81D07A1;
	Mon, 21 Oct 2024 18:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729536665; cv=none; b=hTj2CXUoBbzMwV2u/HWc65shy3h0DNZO4oVmRvg+Tj22z8wMRql4I2vYkyFRlUu/0T4eRdODD9rzVGdpYTAwJkxp/n5Cf19/epDpB0zp/f/QG2Z9EG5MNpJsFl7O/U7OPgid8W6kApjBmCMIlrhumjEqTQYE+xKNtB0qqY55yMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729536665; c=relaxed/simple;
	bh=c1L7b4KjHyaDOWTiFdUHcYaqE6QeCKPONNoMW8jTU44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kU3pkcqwhC7+1P9YHivjEJNfGKsqjWzACahgpgRYG0ansgMr0i9aoAPyKDVY8Wg+9VKuu+dITQJEMClqnDf8cYP4Synzb2KQ3KrLBDVOd2ecsiIiK0vInya+FYL6Rkk+SH6Nup3r12j3MTgqfoe8lALuOfHEZTUO0DxnsQyxp4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UUFdLXU2; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729536657;
	bh=c1L7b4KjHyaDOWTiFdUHcYaqE6QeCKPONNoMW8jTU44=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UUFdLXU2XZwN1mO16qE1B3uaHX5rMiu0aoBttN4RjqbwgNq7tohGS0bO8yt0l5pxR
	 ya/yJic/jqu4RNC7lFwZ1lqTxegm2XsH44PssiA0OL7a0/MY4lyeZ3mGGhFUyuPedm
	 rD/8wI9TM+Z+1TSsGu5oXxCsgc+aBxvdnWK9YlU34vrHglu0xzovxtMeioHIJfyQw4
	 F4vM39jENZSuNo6Cr2cGBcOd4hJ5wCtXrVjdIIqm6/gsolZE9SQXQjU35dvsISZ00O
	 DkphpJyBSYcAgXoZwxyZiprXfC0QFC8x09yWZfhR1KzUUASdm8Y9nOJS8hBCyW743g
	 vflQOmX59dH4w==
Received: from [192.168.1.90] (unknown [188.24.146.62])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8724217E362A;
	Mon, 21 Oct 2024 20:50:57 +0200 (CEST)
Message-ID: <1624395d-f4e9-4c82-a5ef-c05e2f3505db@collabora.com>
Date: Mon, 21 Oct 2024 21:50:56 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: Drop invalid clock-names from
 es8388 codec nodes
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241019-es8328-dt-fixes-v1-1-ca77d5ce21ad@collabora.com>
 <172953337556.748331.14779753664880128918.robh@kernel.org>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <172953337556.748331.14779753664880128918.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/24 8:58 PM, Rob Herring (Arm) wrote:
> 
> On Sat, 19 Oct 2024 03:38:10 +0300, Cristian Ciocaltea wrote:
>> The binding for Everest ES8328/ES8388 audio CODEC doesn't support the
>> 'clock-names' property:
>>
>>   rk3588-orangepi-5-plus.dtb: audio-codec@11: 'clock-names' does not match any of the regexes: 'pinctrl-[0-9]+'
>>     from schema $id: http://devicetree.org/schemas/sound/everest,es8328.yaml#
>>
>> Since the related audio driver is also not making use of it, drop the
>> invalid property from all es8388 codec nodes.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>> Several DT fixes involving the usage of the Everest ES8328/ES8388 audio
>> CODEC.
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts      | 1 -
>>  arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts  | 1 -
>>  arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts      | 1 -
>>  arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts | 1 -
>>  4 files changed, 4 deletions(-)
>>
> 
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
> New warnings running 'make CHECK_DTBS=y rockchip/rk3399-roc-pc-plus.dtb rockchip/rk3588-orangepi-5-plus.dtb rockchip/rk3588-quartzpro64.dtb rockchip/rk3588s-indiedroid-nova.dtb' for 20241019-es8328-dt-fixes-v1-1-ca77d5ce21ad@collabora.com:
> 
> arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dtb: audio-codec@11: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/sound/everest,es8328.yaml#
 
This warning is unrelated, but eventually fixed via:

https://lore.kernel.org/lkml/20241019-es8328-doc-port-v1-1-25c1d1b5c65c@collabora.com/

Regards,
Cristian

