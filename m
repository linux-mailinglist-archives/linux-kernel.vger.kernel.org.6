Return-Path: <linux-kernel+bounces-232116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA41591A3B3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8321F283EB6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3666B13D62E;
	Thu, 27 Jun 2024 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="sOQNER4X"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2239222EF2
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.40.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719483976; cv=none; b=nf7+9C3s6dfcJYqohmGExoCUOaO1Le09+72/WKe7Ee8pTeKg4Y/YO4ushkDEqWYTP+WGJcC8zn0w3plclUuPbTvEL2AoXWkIzu8E0Lrzi27utOVu4qUgqPWgiEp8VDjppyoaPJztM2QrbJoSpZuRfv1mmrO+yQzlnh49epl5umo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719483976; c=relaxed/simple;
	bh=gsNzAo9KUosgB4ZSjznR3d4Um2Q5eipfXMK4EM/EyO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twgwoQdrIVBmM+B2XtW+bJFepQDuEfa28I2gtODzgVrK/jEQp3TZlr6XmQtfWMuEgwdGbhwfQ7/JneqXRmVnU1+cK+JajN5vxPkzLQaQ4JwPY16Jiq76Slnt8BMlJ9xA2ntAm5h4Vn0b4yqePOiQwzcAx0an8NUCV1j6/n/FlHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=sOQNER4X; arc=none smtp.client-ip=167.172.40.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1719483960;
 bh=TWiLySO7b3v99TTKx2kmRds/R3UK6iiDnVWH7RwG6BY=;
 b=sOQNER4X/NOVN8zr2BOJM2/pj3ShiaN1dTBG1B5oazg8inZhTsURxynpvCv4WGsKG6innSDLN
 JWInwSCw9lHVVnszI9R3q+biNcuVTq9RIz/z1xV35Uw8RW/gcA6gsC29pVh/a5e3BMI+eyZFsue
 HQhGVJrEWRsufC7nx0B6D1jZ/WhmyHnZh9wF8Xl47j+DEkB3n2PguSV2a1nrSbJrEPYKBW8U8nz
 ISrXiVmUVDqtO6Ht+K8kbTBIdgJt0drP89tERK7sHWBQN5keHHhHT0z2JmPsOs1UxjH4Yh+fc6o
 n4K66vezVNmnWF0hLIpOyb/fYYZcmPt0OcDNPBmmFqYA==
Message-ID: <c67f6ada-3a64-4453-a739-583bbdee4185@kwiboo.se>
Date: Thu, 27 Jun 2024 12:25:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: Add Radxa ROCK 3B
To: FUKAUMI Naoki <naoki@radxa.com>, Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240626201502.1384123-1-jonas@kwiboo.se>
 <20240626201502.1384123-3-jonas@kwiboo.se>
 <7F75D4B7290C2A91+8b029861-21dc-4f52-acbc-89087b4c0f0d@radxa.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <7F75D4B7290C2A91+8b029861-21dc-4f52-acbc-89087b4c0f0d@radxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 667d3e35392543b4ce9a5535

Hi,

On 2024-06-27 00:29, FUKAUMI Naoki wrote:
> Hi,
> 
> thank you very much for your effort!
> 
> On 6/27/24 05:14, Jonas Karlman wrote:
>> The Radxa ROCK 3B is a single-board computer based on the Pico-ITX form
>> factor (100mm x 75mm). Two versions of the ROCK 3B exists, a community
>> version based on the RK3568 SoC and an industrial version based on the
>> RK3568J SoC.
>>
>> Add initial support for eMMC, SD-card, Ethernet, HDMI, PCIe and USB.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> v2:
>> - Use regulator-.* nodename for fixed regulators
>> - Drop rockchip,mic-in-differential prop
>> - Shorten Ethernet phy reset-deassert-us to 50 ms
>> - Fix pcie pinctrl
>> - Add keep-power-in-suspend to sdmmc2
>>
>> Following issue is reported by dtbs_check and is fixed by series at [1]:
>>
>>    pmic@20: '#sound-dai-cells', 'assigned-clock-parents', 'assigned-clocks', 'clock-names', 'clocks'
>>      do not match any of the regexes: 'pinctrl-[0-9]+'
>>    from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk809.yaml#
>>
>> [1] https://lore.kernel.org/all/20240622-rk809-fixes-v2-0-c0db420d3639@collabora.com/
>> ---
>>   arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>>   .../boot/dts/rockchip/rk3568-rock-3b.dts      | 780 ++++++++++++++++++
>>   2 files changed, 781 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
>> index 90f5172f37e6..ae0ae02f51e9 100644
>> --- a/arch/arm64/boot/dts/rockchip/Makefile
>> +++ b/arch/arm64/boot/dts/rockchip/Makefile
>> @@ -114,6 +114,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-qnap-ts433.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-radxa-e25.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-roc-pc.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-rock-3a.dtb
>> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-rock-3b.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-display-vz.dtbo
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-io-expander.dtbo
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
>> new file mode 100644
>> index 000000000000..46c959f1c6ad
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
>> @@ -0,0 +1,780 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/leds/common.h>
>> +#include <dt-bindings/pinctrl/rockchip.h>
>> +#include <dt-bindings/soc/rockchip,vop2.h>
>> +#include "rk3568.dtsi"
>> +
>> +/ {
>> +	model = "Radxa ROCK 3B";
>> +	compatible = "radxa,rock-3b", "rockchip,rk3568";
>> +
>> +	aliases {
>> +		ethernet0 = &gmac0;
>> +		ethernet1 = &gmac1;
>> +		mmc0 = &sdhci;
>> +		mmc1 = &sdmmc0;
>> +		mmc2 = &sdmmc2;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial2:1500000n8";
>> +	};
>> +
>> +	hdmi-con {
>> +		compatible = "hdmi-connector";
>> +		type = "a";
>> +
>> +		port {
>> +			hdmi_con_in: endpoint {
>> +				remote-endpoint = <&hdmi_out_con>;
>> +			};
>> +		};
>> +	};
>> +
>> +	ir-receiver {
>> +		compatible = "gpio-ir-receiver";
>> +		gpios = <&gpio0 RK_PC2 GPIO_ACTIVE_LOW>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pwm3_ir>;
>> +	};
>> +
>> +	leds {
>> +		compatible = "gpio-leds";
>> +
>> +		led-green {
> 
> led-0 or just led (leds-gpio.yaml)

Thanks, I will fix in v3.

Regards,
Jonas

> 
> Best regards,
> 
> --
> FUKAUMI Naoki
> Radxa Computer (Shenzhen) Co., Ltd.
> 

[snip]

