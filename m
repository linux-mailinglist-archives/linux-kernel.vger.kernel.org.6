Return-Path: <linux-kernel+bounces-333491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA5997C990
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23F53B23298
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 12:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA0619E822;
	Thu, 19 Sep 2024 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="LOdJrGcu"
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3543719D8BB;
	Thu, 19 Sep 2024 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726750383; cv=none; b=qrmWfLI5YTbaGc7Bb4H3VAgON0TemHUSOmZTBct6EA1cKwLRllZdC2iUEC9GEPz6ZkXFGgpDzvn2G+a2mLp6/TjhBirbfK38XD3FCtlsu6hq0XRiUemSL0PC1uBnHXEj9az7YPj0eHojXIEiNp6lA0bwhqB26qXfPv1eAqtQFTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726750383; c=relaxed/simple;
	bh=Ph/oHin//pHNn53pb/cPXEAjtRG/v1xWFK7MeSfvfkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FDcr8Zww9E0FayTW+enhAvqCBb22ukbr9qqJLBhWdpsHJO+66MDEsPwhax47RvHaxXsqjK94ST4nTaOLxHp7nQUE6XAoF7rOejmMHAP3UjJ4YSq5wEr3yxl0UKqw8+jcs3WKKWhz5KLYkCIIfQqhftntilDVTwMDNh5hKS5VqcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=LOdJrGcu; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1726750380;
	bh=60bDgnFrrO+PEAycaO+HE7Dpyx2k7R6Ulk+P7uK3JEI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LOdJrGcu50/Li4tNNrzaVJwDoT5QmnBQ7VSLhBlMtrnxrZ19qCf8X9Q+JbgfDej4u
	 SzMLOujxnN4NeASyk0rZOraeamXO+K5wOhpHi4WluiBztB7r6uBdA7UBNc81WqGFM8
	 s3pOhqwB8MsloPefY6GGOVIg5gvptIS7PXbHwa0c=
Received: from [10.1.8.111] (unknown [10.1.8.111])
	by uho.ysoft.cz (Postfix) with ESMTP id DA291A05BD;
	Thu, 19 Sep 2024 14:52:59 +0200 (CEST)
Message-ID: <c4421504-2ccd-4adb-8df6-053c8085080a@ysoft.com>
Date: Thu, 19 Sep 2024 14:52:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: imx8mp-iota2: Enable the USB Type-C port
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Shawn Guo <shawnguo@kernel.org>, Petr Benes <petr.benes@ysoft.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Herburger <gregor.herburger@ew.tq-group.com>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Michael Walle <mwalle@kernel.org>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20240917151001.1289399-1-michal.vokac@ysoft.com>
 <20240917151001.1289399-5-michal.vokac@ysoft.com>
 <91d26ba6-01cd-4b45-8cca-689475285463@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
In-Reply-To: <91d26ba6-01cd-4b45-8cca-689475285463@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18. 09. 24 15:17, Krzysztof Kozlowski wrote:
> On 17/09/2024 17:10, Michal Vokáč wrote:
>> From: Petr Benes <petr.benes@ysoft.com>
>>
>> Enable the USB Type-C port with the Diodes PI5USB30213A port controller.
>> The port supports dual role data but can operate only in source power role
>> and PD is not supported.
>>
>> Signed-off-by: Petr Benes <petr.benes@ysoft.com>
>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
>> ---
>>   .../boot/dts/freescale/imx8mp-iota2-lumpy.dts | 96 +++++++++++++++++++
>>   1 file changed, 96 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts b/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
>> index 21d0899cabd5..b15d211e8667 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
>> +++ b/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
>> @@ -38,6 +38,17 @@ memory@40000000 {
>>   		      <0x1 0x00000000 0 0x80000000>;
>>   	};
>>   
>> +	reg_typec: regulator-typec {
>> +		compatible = "regulator-fixed";
>> +		enable-active-high;
>> +		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_usbc_vbus>;
>> +		regulator-max-microvolt = <5000000>;
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-name = "typec";
>> +	};
>> +
>>   	reg_usb_host: regulator-usb-host {
>>   		compatible = "regulator-fixed";
>>   		enable-active-high;
>> @@ -218,6 +229,47 @@ &i2c2 {
>>   	pinctrl-0 = <&pinctrl_i2c2>;
>>   	status = "okay";
>>   
>> +	tcpc@d {
> 
> typec@d
> 
>> +		compatible = "diodes,pi5usb30213a";
>> +		reg = <0xd>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_typec>;
>> +		interrupts-extended = <&gpio1 5 IRQ_TYPE_LEVEL_LOW>;
>> +		status = "okay";
> 
> Drop

OK. I will address both comments.

Thank you for the review,
Michal

