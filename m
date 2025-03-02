Return-Path: <linux-kernel+bounces-540476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DDCA4B120
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 12:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 502FD3A4167
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 11:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4711DF735;
	Sun,  2 Mar 2025 11:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="G2oeUQ0S"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD92179BC
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 11:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740914095; cv=none; b=ue3+twPAjdCZuS6QN1dfWOn5JTnHCfT1plpfD1mBfQlXybqZYuX6ClgH2BC5z8eg4JS8AJ20dv1Gqay6VYY5woIF6MPf/38wmVJif8E8YEbLjflYJ7IZ3KycI5bCN2m2ZgMMuWS2Vgzez220MB/2f/3pT4r05vHIPPcmteRAa88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740914095; c=relaxed/simple;
	bh=yCZBPiZpi5kycYTBGCYambADW5e5sm0mo0hX/9w6Gc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ImKXvqfh4bl9QzX5FFFq00pOLgbM1EFEVESUg3B9GbRCtfc7Efe4MTh82of8r/uRjBdf61ZrlCNYe8jemP05HGU6S1tC2uaq3zGJ93fdRIHfcK0xXwOe9tISVJbtlpF4UnEzTC0FMRAsSgiAW84B/YUu59N090zu2hcCSrMxMRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=G2oeUQ0S; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1740914093;
 bh=4aAL9kjHi8d7xZ8Th1ELQbazXnG5IgJFjgkhzp2InRQ=;
 b=G2oeUQ0SRsoK5jDzK8rxqS06+Y/hg/uasvwkzyfD4Zw3YMe/T8WHvOGwWDfo4oTOla6FAohM3
 dv3pQh1bTBb5++h/gVO7AgQP9ZCxP7QJvqcWW2zucmUywcVBH+9SuQUrZ5IpOfMJpWrWuHXm0OE
 tQqH4NqVy/qGCslzQ9Psg+1M5unJYkL6OQlwAkHzvU/T2r28XhzE/I4tLU8f3ZUeHdf4iZxKvyP
 MKhj1e3APpTIiVOuSyt9lJPvmlBgk+e1UOwAEkfLoyYv8y88bJ0xdfVoXqGCDA93ZE98b2bbE6k
 38QhLCmusARlihg9Ie0AbNkR1u1XbF3HQ7va4rmbH2XA==
X-Forward-Email-ID: 67c43dac4a29b97c03d4dc5d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <3f0cd767-1fd8-4c65-b8b4-e948288cd02a@kwiboo.se>
Date: Sun, 2 Mar 2025 12:14:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] arm64: dts: rockchip: Add pinctrl and gpio nodes for
 RK3528
To: Yao Zi <ziyao@disroot.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250228064024.3200000-1-jonas@kwiboo.se>
 <20250228064024.3200000-5-jonas@kwiboo.se> <Z8GT3rUEyXrTUgtJ@pie.lan>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <Z8GT3rUEyXrTUgtJ@pie.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yao Zi,

On 2025-02-28 11:46, Yao Zi wrote:
> On Fri, Feb 28, 2025 at 06:40:10AM +0000, Jonas Karlman wrote:
>> Add pinctrl and gpio nodes for RK3528 and import rk3528-pinctrl.dtsi
>> from vendor linux-6.1-stan-rkr5 kernel with the hdmi-pins-idle node
>> removed due to missing label reference to pcfg_output_low_pull_down.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> This was mostly imported from vendor kernel, however the main commit [1]
>> list 28 signed-off-by tags, unclear who I should use as author and what
>> signed-off-by tags to include.
>>
>> [1] https://github.com/rockchip-linux/kernel/commit/c17d6325959f0ec1af901e8a17919163454190a2
>> ---
>>  .../boot/dts/rockchip/rk3528-pinctrl.dtsi     | 1397 +++++++++++++++++
>>  arch/arm64/boot/dts/rockchip/rk3528.dtsi      |   82 +
>>  2 files changed, 1479 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-pinctrl.dtsi
>>
> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
>> index 0fb90f5c291c..d3e2a64ff2d5 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
>> @@ -4,8 +4,10 @@
>>   * Copyright (c) 2024 Yao Zi <ziyao@disroot.org>
>>   */
>>  
>> +#include <dt-bindings/gpio/gpio.h>
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>  #include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/pinctrl/rockchip.h>
>>  #include <dt-bindings/clock/rockchip,rk3528-cru.h>
>>  #include <dt-bindings/reset/rockchip,rk3528-cru.h>
>>  
>> @@ -17,6 +19,11 @@ / {
>>  	#size-cells = <2>;
>>  
>>  	aliases {
>> +		gpio0 = &gpio0;
>> +		gpio1 = &gpio1;
>> +		gpio2 = &gpio2;
>> +		gpio3 = &gpio3;
>> +		gpio4 = &gpio4;
>>  		serial0 = &uart0;
>>  		serial1 = &uart1;
>>  		serial2 = &uart2;
>> @@ -166,6 +173,11 @@ cru: clock-controller@ff4a0000 {
>>  			#reset-cells = <1>;
>>  		};
>>  
>> +		ioc_grf: syscon@ff540000 {
>> +			compatible = "rockchip,rk3528-ioc-grf", "syscon";
>> +			reg = <0x0 0xff540000 0x0 0x40000>;
>> +		};
>> +
>>  		uart0: serial@ff9f0000 {
>>  			compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
>>  			reg = <0x0 0xff9f0000 0x0 0x100>;
>> @@ -264,5 +276,75 @@ saradc: adc@ffae0000 {
>>  			#io-channel-cells = <1>;
>>  			status = "disabled";
>>  		};
>> +
>> +		pinctrl: pinctrl {
>> +			compatible = "rockchip,rk3528-pinctrl";
>> +			rockchip,grf = <&ioc_grf>;
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges;
> 
> I doubt whether the pincontroller should be placed under simple-bus:
> without a reg property, it doesn't look like a MMIO device.
> 
> Actually it is, although all the registers stay in the ioc grf. Maybe
> it should be considered as child of the grf.

This follows how pinctrl was added for RK3576 and what is proposed for
RK3562 [2]. I have too little knowledge to know if this needs to change
or if this should follow similar SoCs.

[2] https://lore.kernel.org/r/20250227111913.2344207-15-kever.yang@rock-chips.com

Regards,
Jonas

> 
> Best regards,
> Yao Zi


