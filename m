Return-Path: <linux-kernel+bounces-372743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206D49A4C93
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 11:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B7621C212F9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 09:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B5B1DEFC2;
	Sat, 19 Oct 2024 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PE1db8Qj"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28B818D645;
	Sat, 19 Oct 2024 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729330006; cv=none; b=eLIvaVpZefdRidz71BzoMZpzhauSitzJEq1y65Qd9v1FkMB9cPyr35gYRD/Gy46xWgYX8fyzx7FlNN7mrxzUihDQdCGQcq4Po7Xj5ukdnzx4K9cgO2AdTRQaSE2JdOHlS12M8CIx37FcGzCbskdt43Z87jZVsjhEGVH53hznlmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729330006; c=relaxed/simple;
	bh=A12LOSwmWFWHo6OAqeCHBFM788woPfeCycyMJZEpZNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=piExGEXs1B0yJb0oWvjrrF4DIgvch3jid1DGr83Giiq4+kRBmWB0gIrPuEfHxTmRuKE+dj/p6J4UIAWok5OPVfZs1+cTSIqHENCAagMScttUAqAM8oqOkMMpJRddOOSdZdd6c4zbTb9QBYetClXBhIcS3ID5rv9SJWmtJZiMFxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PE1db8Qj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729330001;
	bh=A12LOSwmWFWHo6OAqeCHBFM788woPfeCycyMJZEpZNE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PE1db8QjIBupkMdNIrG4YsYoZRKa5J9xhd2j6Omop7Dd3oakQwCE1QFjAR06nef/i
	 Kgypx0zlrxxotC9eqe98yc/UBsoIdRdWWGiHg9IZybMYj8ZWvN/m+IIBFRRqnfVbiO
	 8Zu+XAugPRAJpMLLpQmxyQJYNiG0XBOkAUeCDHhQCRL1aj6mfoBQU0HyIAP9mKxgC7
	 2cFMnp6AxO/r3Q3l29Z5aSzxHGVgbCVSjX8WC6sc4cptQ9bkEi8a5rQfg+rnOeyetb
	 TCQs/f7/yB/9T457Y5hh5vZXOQkTlPGyW3MJtKhiOIJnkUr7+dNJ9ULEJNYK8zPTjb
	 +gfPNC7tYOmCg==
Received: from [192.168.1.90] (unknown [188.24.146.62])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7981017E124E;
	Sat, 19 Oct 2024 11:26:41 +0200 (CEST)
Message-ID: <a8a29b83-b76a-42a7-a383-6b82731d13fd@collabora.com>
Date: Sat, 19 Oct 2024 12:26:41 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH UNTESTED 5/5] arm64: dts: rockchip: Enable HDMI0 on
 rock-5a
To: FUKAUMI Naoki <naoki@radxa.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Luis de Arquer <ldearquer@gmail.com>, Alexandre ARNOUD <aarnoud@me.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241019-rk3588-hdmi0-dt-v1-0-bd8f299feacd@collabora.com>
 <20241019-rk3588-hdmi0-dt-v1-5-bd8f299feacd@collabora.com>
 <6FF0CF3856870371+bbebd66b-e19c-40c2-863b-1d6c5c30c461@radxa.com>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <6FF0CF3856870371+bbebd66b-e19c-40c2-863b-1d6c5c30c461@radxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/19/24 7:42 AM, FUKAUMI Naoki wrote:
> Hi,
> 
> On 10/19/24 06:39, Cristian Ciocaltea wrote:
>> Add the necessary DT changes to enable HDMI0 on Rock 5A.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts | 47 ++++++++++++++
>> ++++++++++
>>   1 file changed, 47 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/
>> arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
>> index
>> 87fce8d9a964cd53d179ce214ae1c0ff505a2dce..1fd122250b0c70e729b7a2239ab5f288a6387a70 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
>> @@ -5,6 +5,7 @@
>>   #include <dt-bindings/gpio/gpio.h>
>>   #include <dt-bindings/leds/common.h>
>>   #include <dt-bindings/pinctrl/rockchip.h>
>> +#include <dt-bindings/soc/rockchip,vop2.h>
>>   #include "rk3588s.dtsi"
>>     / {
>> @@ -35,6 +36,17 @@ chosen {
>>           stdout-path = "serial2:1500000n8";
>>       };
>>   +    hdmi0-con {
>> +        compatible = "hdmi-connector";
>> +        type = "a";
>> +
>> +        port {
>> +            hdmi0_con_in: endpoint {
>> +                remote-endpoint = <&hdmi0_out_con>;
>> +            };
>> +        };
>> +    };
>> +
>>       leds {
>>           compatible = "gpio-leds";
>>           pinctrl-names = "default";
>> @@ -296,6 +308,26 @@ &gmac1_rgmii_clk
>>       status = "okay";
>>   };
>>   +&hdmi0 {
>> +    status = "okay";
>> +};
> 
> on ROCK 5A, HPD pin is different.
> 
> how about this?
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/
> arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
> index f4293d666368..600028fcad88 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
> @@ -314,6 +314,9 @@ &gmac1_rgmii_clk
>  };
> 
>  &hdmi0 {
> +    pinctrl-names = "default";
> +    pinctrl-0 = <&hdmim0_tx0_cec &hdmim1_tx0_hpd
> +             &hdmim0_tx0_scl &hdmim0_tx0_sda>;
>      status = "okay";
>  };
> 

Thanks for figuring this out!

Regards,
Cristian


