Return-Path: <linux-kernel+bounces-540482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E41F1A4B130
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 12:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA4F01890511
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 11:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BF41DE4CE;
	Sun,  2 Mar 2025 11:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="zPitsCZV"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DEC1B6CFE
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740915245; cv=none; b=uVSADe3XHWyGEVRf7nDSmHL165dcfnoJ19U6H0sZhVC7SZJCdN34wT36acnui2hOgtO9+t+SDkZt24JqsyU9huaZVsdm9Za8wj6E37akYC0FtpWzI+nkX/YVYYHTr07adgVflbfyqgqEvm2ljjtBWQ8WXliWppOdO2XpItMMr6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740915245; c=relaxed/simple;
	bh=xV9ruAhVw/6avwA3fLN4Q5jp+kOcE/pwQnVQktM2J+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lsP54Ffs0DuWHVn7NFXAKBGIDM4A2rwjW5jUYmxyh0fnkvXEjWnWoDKVhGyVqHu8IR039MGzx0vJJvDFkatK7MtKncLpST9qpABmO6kLt3B903oMtmweQFzO6j6JbS8Dtv2AU0BfcCgbCdGH/smH20iar0bru3KuMZZFZ7o/6pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=zPitsCZV; arc=none smtp.client-ip=121.127.44.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1740915243;
 bh=2rZnsvHwyI+sU9+EF0i7TafNRHUGql1r6Nc38HeeaK4=;
 b=zPitsCZVDDz/gdJrhV059oOWSuq6Jiy0u/Zq7EHM16UYHpxIP2dPBThsoIWawdn9zHAQMc4Fr
 g1kR6j2FKNG0Xq6Seh9+hIspyed2NWETVrbeIbCGR/yAmCRI8VWL1hgEMrwgKxiixu/JCks6a5a
 EYDVEbcNmAXtjQ5B6L0M1e4Y+l5d/iaYfMEhI1GobJ4i5HA7lFSalmZ/o7xpbKqCJ3CAEfvOCRV
 1wP746xLApt0dufYRnrZyxeULBrFx/ErzIOYzI6K5Hh/EctcavP5AABZn/68gbsVLN869ahlgYy
 WPfuY42Ri7B5XcvhcXyuyPLizakkZZtg7y+Hg1jzZC0A==
X-Forward-Email-ID: 67c442264a29b97c03d4df09
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <b92c0f59-c721-4e91-ac41-267a81758916@kwiboo.se>
Date: Sun, 2 Mar 2025 12:33:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] arm64: dts: rockchip: Add SDMMC/SDIO controllers for
 RK3528
To: Yao Zi <ziyao@disroot.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Frank Wang <frank.wang@rock-chips.com>,
 Shresth Prasad <shresthprasad7@gmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Detlev Casanova <detlev.casanova@collabora.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20250301104250.36295-1-ziyao@disroot.org>
 <20250301104749.36423-1-ziyao@disroot.org>
 <9fd51bcb-3e6a-46b6-b1f7-ff16fa562d9e@kwiboo.se> <Z8MMm7X31p_CrStZ@pie>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <Z8MMm7X31p_CrStZ@pie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yao Zi,

On 2025-03-01 14:33, Yao Zi wrote:
> On Sat, Mar 01, 2025 at 01:47:47PM +0100, Jonas Karlman wrote:
>> Hi,
>>
>> On 2025-03-01 11:47, Yao Zi wrote:
>>> RK3528 features two SDIO controllers and one SD/MMC controller, describe
>>> them in devicetree. Since their sample and drive clocks are located in
>>> the VO and VPU GRFs, corresponding syscons are added to make these
>>> clocks available.
>>>
>>> Signed-off-by: Yao Zi <ziyao@disroot.org>
>>> ---
>>>  arch/arm64/boot/dts/rockchip/rk3528.dtsi | 62 ++++++++++++++++++++++++
>>>  1 file changed, 62 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
>>> index 5b334690356a..078c97fa1d9f 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
>>> @@ -7,6 +7,7 @@
>>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>  #include <dt-bindings/interrupt-controller/irq.h>
>>>  #include <dt-bindings/clock/rockchip,rk3528-cru.h>
>>> +#include <dt-bindings/reset/rockchip,rk3528-cru.h>
>>>  
>>>  / {
>>>  	compatible = "rockchip,rk3528";
>>> @@ -122,6 +123,16 @@ gic: interrupt-controller@fed01000 {
>>>  			#interrupt-cells = <3>;
>>>  		};
>>>  
>>> +		vpu_grf: syscon@ff340000 {
>>> +			compatible = "rockchip,rk3528-vpu-grf", "syscon";
>>
>> vpu_grf is also used for gmac1, so should possible be a "syscon",
>> "simple-mfd", or have I misunderstood when to use simple-mfd ?
> 
> Just as Heiko explained, "simple-mfd" is only required when the child
> nodes should be populated automatically. Here these two GRFs are only
> referenced and have no child, thus "simple-mfd" compatible isn't useful.

Thanks for the explanations.

> 
>>> +			reg = <0x0 0xff340000 0x0 0x8000>;
>>> +		};
>>> +
>>> +		vo_grf: syscon@ff360000 {
>>> +			compatible = "rockchip,rk3528-vo-grf", "syscon";
>>
>> similar here, vo_grf is also used for gmac0.
>>
>>> +			reg = <0x0 0xff360000 0x0 0x10000>;
>>> +		};
>>> +
>>>  		cru: clock-controller@ff4a0000 {
>>>  			compatible = "rockchip,rk3528-cru";
>>>  			reg = <0x0 0xff4a0000 0x0 0x30000>;
>>> @@ -251,5 +262,56 @@ uart7: serial@ffa28000 {
>>>  			reg-shift = <2>;
>>>  			status = "disabled";
>>>  		};
>>> +
>>> +		sdio0: mmc@ffc10000 {
>>> +			compatible = "rockchip,rk3528-dw-mshc",
>>> +				     "rockchip,rk3288-dw-mshc";
>>> +			reg = <0x0 0xffc10000 0x0 0x4000>;
>>> +			clocks = <&cru HCLK_SDIO0>,
>>> +				 <&cru CCLK_SRC_SDIO0>,
>>> +				 <&cru SCLK_SDIO0_DRV>,
>>> +				 <&cru SCLK_SDIO0_SAMPLE>;
>>> +			clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
>>> +			fifo-depth = <0x100>;
>>> +			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
>>> +			max-frequency = <150000000>;
>>> +			resets = <&cru SRST_H_SDIO0>;
>>> +			reset-names = "reset";
>>> +			status = "disabled";
>>> +		};
>>> +
>>> +		sdio1: mmc@ffc20000 {
>>> +			compatible = "rockchip,rk3528-dw-mshc",
>>> +				     "rockchip,rk3288-dw-mshc";
>>> +			reg = <0x0 0xffc20000 0x0 0x4000>;
>>> +			clocks = <&cru HCLK_SDIO1>,
>>> +				 <&cru CCLK_SRC_SDIO1>,
>>> +				 <&cru SCLK_SDIO1_DRV>,
>>> +				 <&cru SCLK_SDIO1_SAMPLE>;
>>> +			clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
>>> +			fifo-depth = <0x100>;
>>> +			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
>>> +			max-frequency = <150000000>;
>>> +			resets = <&cru SRST_H_SDIO1>;
>>> +			reset-names = "reset";
>>> +			status = "disabled";
>>> +		};
>>> +
>>> +		sdmmc: mmc@ffc30000 {
>>> +			compatible = "rockchip,rk3528-dw-mshc",
>>> +				     "rockchip,rk3288-dw-mshc";
>>> +			reg = <0x0 0xffc30000 0x0 0x4000>;
>>> +			clocks = <&cru HCLK_SDMMC0>,
>>> +				 <&cru CCLK_SRC_SDMMC0>,
>>> +				 <&cru SCLK_SDMMC_DRV>,
>>> +				 <&cru SCLK_SDMMC_SAMPLE>;
>>> +			clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
>>> +			fifo-depth = <0x100>;
>>> +			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
>>> +			max-frequency = <150000000>;
>>> +			resets = <&cru SRST_H_SDMMC0>;
>>> +			reset-names = "reset";
>>
>> Suggest adding default pinctrl props here:
>>
>>   pinctrl-names = "default";
>>   pinctrl-0 = <&sdmmc_bus4>, <&sdmmc_clk>, <&sdmmc_cmd>, <&sdmmc_det>;
>>
>> And possible also for sdio0 and sdio1.
>>
>> Regards,
>> Jonas
> 
> It makes sense. As mentioned in the cover letter, I depended on the
> bootloader to setup pinctrl, to minimize dependency of the series.

BootROM typically setup pinctrl for the storage media when probing for
idblock and mainline U-Boot will setup pinctrl based on the board device
tree synced from Linux. Adding pinctrl early in Linux will help avoid a
need for using workarounds in U-Boot.

For RK3528 there only seem to be one option for sdmmc/sdio pins, adding
a default to soc dtsi should help reduce duplication in future board
device trees.

> 
> Will complete the pinctrl properties in next version.

Thanks :-)

Regards,
Jonas

> 
>>> +			status = "disabled";
>>> +		};
>>>  	};
>>>  };
>>
> 
> Best regards,
> Yao Zi


