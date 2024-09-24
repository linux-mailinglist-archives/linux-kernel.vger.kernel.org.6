Return-Path: <linux-kernel+bounces-336844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44359841A8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0033D1C22A9A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5B8154C12;
	Tue, 24 Sep 2024 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="QgR/OzzZ"
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649AE154426;
	Tue, 24 Sep 2024 09:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168916; cv=none; b=QEA0F2GjG7Md1bSAkdkdn1VFunVXwFkmTT6UhG17z9EtBc5bYLClaNIB2hF9g9gJkgr9jTMrG+KB+5imt6+Jrvs/xgWi9qs6aVbbYFjtCQe8ialvpmXcmuZsv1QT2oqjZdYP6Y+JfN3VcUp7olZlGToYq0lHFOejRk7KwznLmjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168916; c=relaxed/simple;
	bh=d7EY5tsnn1elXfO6jeltwzLTltARsNPOzMCSYKPTZfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GRFxTaMyqfrcpmx2rnfnQzv4oovHpvq8sAstA8+iXzlvY8y1slDdlTtjeLLzMMr7+7sv4U5qW4BrK7vUuzOZs+mnRl1RHCjkG77x5ZprzktXMmoxKJGDeiJPATXVO6boyT6mtaXw7ydH2rZ65a3HnjVK0vmHgdbM7oIkthqqe1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=QgR/OzzZ; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1727168913;
	bh=7ht41c+0HfkzO8ZIPDa1z7YU24EqFA6JgQQheNZ1rAQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QgR/OzzZuxJBwFjO9puIZF7wXkjhi307BMRTYeXG3KK/hMEO7vNjGjHusOh/eChd9
	 Bed2G6ExhE9gX0iRUSHcmdGmeyFHoSHiu2cy6t47OKOlFBrcfhViJ3zo7iXLmVCWMN
	 I3Zg+TOqbUSe1/wR0GCb7Wb/D8PIVSyAKng/bLlo=
Received: from [10.1.8.111] (unknown [10.1.8.111])
	by uho.ysoft.cz (Postfix) with ESMTP id CED7AA0419;
	Tue, 24 Sep 2024 11:08:32 +0200 (CEST)
Message-ID: <831dbda0-f787-43d5-b771-c837412be10b@ysoft.com>
Date: Tue, 24 Sep 2024 11:08:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] arm64: dts: imx8mp-iota2: Enable the USB Type-C
 port
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Shawn Guo <shawnguo@kernel.org>, Petr Benes <petr.benes@ysoft.com>,
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
 Michael Walle <mwalle@kernel.org>, imx@lists.linux.dev,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, linux-kernel@vger.kernel.org,
 Hiago De Franco <hiago.franco@toradex.com>,
 Herburger <gregor.herburger@ew.tq-group.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
References: <20240923151417.1665431-1-michal.vokac@ysoft.com>
 <20240923151417.1665431-5-michal.vokac@ysoft.com>
 <20240924072349.a446hzxw2lfpg34i@pengutronix.de>
Content-Language: en-US
From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
In-Reply-To: <20240924072349.a446hzxw2lfpg34i@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24. 09. 24 9:23, Marco Felsch wrote:
> On 24-09-23, Michal Vokáč wrote:
>> From: Petr Benes <petr.benes@ysoft.com>
>>
>> Enable the USB Type-C port with the Diodes PI5USB30213A port controller.
>> The port supports dual role data but can operate only in source power role
>> and PD is not supported.
>>
>> Signed-off-by: Petr Benes <petr.benes@ysoft.com>
>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
>> ---
>> v3:
>> - none
>> v2:
>> - Use typec instead of tcpc.
>> - Drop unneeded status.
>>
>>   .../boot/dts/freescale/imx8mp-iota2-lumpy.dts | 94 +++++++++++++++++++
>>   1 file changed, 94 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts b/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
>> index 120e6b87a000..bfed410339a4 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
>> +++ b/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
>> @@ -32,6 +32,17 @@ button-reset {
>>   		};
>>   	};
>>   
>> +	reg_typec: regulator-typec {
>> +		compatible = "regulator-fixed";
>> +		enable-active-high;
>> +		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
> 
> Can you please put the enable-active-high and gpio property below the
> regualtor-* properties?

Sure.

>> +		pinctrl-0 = <&pinctrl_usbc_vbus>;
>> +		pinctrl-names = "default";
>> +		regulator-max-microvolt = <5000000>;
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-name = "typec";
>> +	};
>> +
>>   	reg_usb_host: regulator-usb-host {
>>   		compatible = "regulator-fixed";
>>   		enable-active-high;

>> @@ -389,15 +451,47 @@ &uart2 {
>>   	status = "okay";
>>   };
>>   
>> +&usb3_0 {
>> +	status = "okay";
>> +};
>> +
>>   &usb3_1 {
>>   	status = "okay";
>>   };
>>   
>> +&usb3_phy0 {
>> +	status = "okay";
>> +};
>> +
>>   &usb3_phy1 {
>>   	vbus-supply = <&reg_usb_host>;
>>   	status = "okay";
>>   };
>>   
>> +&usb_dwc3_0 {
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	dr_mode = "otg";
>> +	usb-role-switch;
>> +	status = "okay";
>> +
> 
> 	ports {
> 		#address-cells = <1>;
> 		#size-cells = <0>;

OK.

>> +	port@0 {
>> +		reg = <0>;
>> +
>> +		typec_hs: endpoint {
>> +			remote-endpoint = <&usb_con_hs>;
>> +		};
>> +	};
>> +
>> +	port@1 {
>> +		reg = <1>;
>> +
>> +		typec_ss: endpoint {
>> +			remote-endpoint = <&usb_con_ss>;
>> +		};
>> +	};
> 
> 	}
> 
> 	like you did for the connector node.

OK, I will do so.
Thank you for the review,
Michal

