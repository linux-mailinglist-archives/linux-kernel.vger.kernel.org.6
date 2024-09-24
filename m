Return-Path: <linux-kernel+bounces-336841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26FA9841A1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35871C243E6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83271155345;
	Tue, 24 Sep 2024 09:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="AsK+i3b9"
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EC81547CE;
	Tue, 24 Sep 2024 09:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168768; cv=none; b=jsqyw/SmHEnh1ob3McrfwrLskLCOMAmEavjzDM+HwPcRUyHxkfA1C/PEZWowYBikFxmd0vn1l/KSw8Dodzm+TrBN9CtCkzzQj6dm+UlQKzhdyymnFZ4TQZIyo76YCv3BSY4ekDM9VRD3CSwZ16gCj7RBYuBvaaWMuUaAZxEvvCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168768; c=relaxed/simple;
	bh=wovpaHFB10LIzs3fdJJq/mz5svW1UsFrygXXIzMeKXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLGkRD+X+9iQeI5+kgEQ9OHt0sE4iNkM/fdhuBsUGMtvG8x5SBfu69OYFvbudZ+szu/0RLkRSJ7gWRhepprN98ikWm+MEMNHnlnyWo6zTMTzjW6OX+kXIsKmCA8nua3aZZBEDcTeohy/CjHvLaCY871zayu/112OHQPkQVfZs7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=AsK+i3b9; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1727168765;
	bh=ujzDlHPlpBvvQmrIa8ds3zxcHct8rpP9W2AqvjbIiPk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AsK+i3b9AM3mTox1EabGSAaWX7EOfkME4RFlZXX2KWwyge1Bb6tugp4Jugn2mXSHj
	 3ohe2knCCdYtodJjBL1qZWf0aQ0bv7Xq8lhs4h7XKuHSZkvno5STzmDF2ow90MhxX5
	 B5dIXYW5WrNa69Q40Zd86xyjTHsCPDqLNit/E/hQ=
Received: from [10.1.8.111] (unknown [10.1.8.111])
	by uho.ysoft.cz (Postfix) with ESMTP id CD345A0419;
	Tue, 24 Sep 2024 11:06:04 +0200 (CEST)
Message-ID: <8243ef43-cb5b-4aef-88cd-7aeffa9eeff6@ysoft.com>
Date: Tue, 24 Sep 2024 11:06:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] arm64: dts: imx: Add imx8mp-iota2-lumpy board
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
 <20240923151417.1665431-3-michal.vokac@ysoft.com>
 <20240924071651.e2a3uxhzp3h5f722@pengutronix.de>
Content-Language: en-US
From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
In-Reply-To: <20240924071651.e2a3uxhzp3h5f722@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24. 09. 24 9:16, Marco Felsch wrote:
> Hi Michael,
> 
> thanks for the patch, please see below some notes but nothing crucial.
> 
>> +
>> +&i2c1 {
>> +	clock-frequency = <400000>;
>> +	pinctrl-0 = <&pinctrl_i2c1>;
>> +	pinctrl-names = "default";
>> +	status = "okay";
>> +
>> +	pmic@25 {
>> +		compatible = "nxp,pca9450c";
>> +		reg = <0x25>;
>> +		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
>> +		interrupt-parent = <&gpio1>;
>> +		pinctrl-0 = <&pinctrl_pmic>;
>> +		pinctrl-names = "default";
>> +
>> +		regulators {
>> +			BUCK1 {
>> +				regulator-always-on;
> 
> All your PMIC rails are marked as regulator-always-on. I didn't expect
> this from a (battery backed) IOT platform.

These are correct. I is not a battery backed device. It operates on 12V
from wall power adapter. It is more like an Ethernet router/edge device
for a B2B solution.

>> +				regulator-boot-on;
>> +				regulator-max-microvolt = <1000000>;
>> +				regulator-min-microvolt = <720000>;
>> +				regulator-name = "BUCK1";
>> +				regulator-ramp-delay = <3125>;
>> +			};
>> +


>> +
>> +&iomuxc {
> 
> Albeit we do sort the node names alphabetical we put the iomuxc at the
> very end at least for the i.MX platforms. Maybe this is something
> Frank's tool should be aware of in the future :)

I am used to do it the way you say. I just accepted Frank's comment
and that it is maybe a new standard to sort all nodes strictly alphabetically.

OK, I will move the iomuxc node back to the end as usual.

>> +&usdhc3 {
>> +	assigned-clocks = <&clk IMX8MP_CLK_USDHC3>;
>> +	assigned-clock-rates = <400000000>;
>> +	bus-width = <8>;
>> +	non-removable;
> 
> Please move the bus-width and non-removeable properties below the
> pinctrl-* properties.

OK.

>> +	pinctrl-0 = <&pinctrl_usdhc3>;
>> +	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
>> +	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
>> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
>> +	status = "okay";
>> +};
>> +
>> +&wdog1 {
>> +	fsl,ext-reset-output;
> 
> This property should be put below the pinctrl-* properties.

OK.

Thank you for the review,
Michal

>> +	pinctrl-0 = <&pinctrl_wdog>;
>> +	pinctrl-names = "default";
>> +	status = "okay";
>> +};

