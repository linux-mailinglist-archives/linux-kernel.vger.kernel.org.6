Return-Path: <linux-kernel+bounces-372972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B30F29A5021
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 19:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E4BB1F23021
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 17:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C7518E37B;
	Sat, 19 Oct 2024 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ncLvRWwy"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B72C18FC9D;
	Sat, 19 Oct 2024 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729359905; cv=none; b=BOT31fIztWkeniyfkTPho1rgpIYhziGOzcC30dOsAOsulg17vr1jmm0WjVWHPjeun79bw7o0lgLmRZ09p76gSWgaTeocts7HjifakWJ+ZGiZGU7/mo265uniX0MV/2w1v45Jd5hZy+9GmyMcESO8ihcuTd/h0VKk0Gnez/loonI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729359905; c=relaxed/simple;
	bh=NZE8zSnUWmDXLsUVhD56gHK8qtI4r/t43Zp/rgthYv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z5dJJnfcADyyeU4YUY6/1Jay49QKyR7hRb9MbE4gOKZSlzIm+C6o/MoanIBZqWxlg7zo67wqZc33V1FuAEJPcPAKuzIsa+dEdQvbLs+qngoLXYjW2lfkrtmnMKpe1YFIbQkR7vLhV6X7MnXvAu0uvhI6ATJRyYKWe4fw/VgEzFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ncLvRWwy; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729359896;
	bh=NZE8zSnUWmDXLsUVhD56gHK8qtI4r/t43Zp/rgthYv4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ncLvRWwyS8rIrN2bKTiI/fsu2q66JQH4rEBbEW/WUACLWcqYhrbV2WQ7f87gi/aVN
	 VKlBxPCk3c6V6KXoFU47xRhYk0lU9bjAu0fpCokbvbHRcatfoKtT+Pah+scR4tblfv
	 Ih7tIBIqwLi7kuTpGmcP1TIXkkRCnKYuOs0r/FhnhHbOX304xlvHJhIm9gQywLIZmd
	 yQfNTwxeXUu36dCDlfxr+Hrw3aABFKjjBMz6mLqgx4tb4A0OXotwPwJTvfhXBKlT0r
	 IdgNGZVUY9MSo+6bXpW5I6kv4en23W6ZhXEtgwSRlt2kGAZG/1NhXJZkyivPLEZE8y
	 0ysbkTdNiyBiw==
Received: from [192.168.1.90] (unknown [188.24.146.62])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DF67517E3692;
	Sat, 19 Oct 2024 19:44:55 +0200 (CEST)
Message-ID: <d4dd6971-7a01-40d3-a25b-dc56a9630442@collabora.com>
Date: Sat, 19 Oct 2024 20:44:55 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] arm64: dts: rockchip: Enable HDMI0 on rock-5a
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Luis de Arquer <ldearquer@gmail.com>, Alexandre ARNOUD <aarnoud@me.com>,
 kernel@collabora.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241019-rk3588-hdmi0-dt-v2-0-466cd80e8ff9@collabora.com>
 <20241019-rk3588-hdmi0-dt-v2-5-466cd80e8ff9@collabora.com>
 <a90437be-eae6-4dc9-93fa-fd4af8ad9bed@kwiboo.se>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <a90437be-eae6-4dc9-93fa-fd4af8ad9bed@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonas,

On 10/19/24 4:02 PM, Jonas Karlman wrote:
> Hi Cristian,
> 
> On 2024-10-19 12:12, Cristian Ciocaltea wrote:
>> Add the necessary DT changes to enable HDMI0 on Radxa ROCK 5A.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts | 52 ++++++++++++++++++++++++
>>  1 file changed, 52 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
>> index 87fce8d9a964cd53d179ce214ae1c0ff505a2dce..2b141af5e709b0bc2193dbfb2327e6bc1fdaa502 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
>> @@ -5,6 +5,7 @@
>>  #include <dt-bindings/gpio/gpio.h>
>>  #include <dt-bindings/leds/common.h>
>>  #include <dt-bindings/pinctrl/rockchip.h>
>> +#include <dt-bindings/soc/rockchip,vop2.h>
>>  #include "rk3588s.dtsi"
>>  
>>  / {
>> @@ -35,6 +36,17 @@ chosen {
>>  		stdout-path = "serial2:1500000n8";
>>  	};
>>  
>> +	hdmi0-con {
>> +		compatible = "hdmi-connector";
>> +		type = "a";
> 
> ROCK 5A use micro HDMI connector type, so this should be type = "d".

Indeed, good catch, will fix in v3.

Thanks,
Cristian

