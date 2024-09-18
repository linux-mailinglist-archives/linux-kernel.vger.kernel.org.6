Return-Path: <linux-kernel+bounces-332414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C0797B967
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72725283F90
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84F31741C8;
	Wed, 18 Sep 2024 08:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="gtTqPTWV"
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EDA1509AB;
	Wed, 18 Sep 2024 08:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726648363; cv=none; b=c8dav+Awe5YE6JczAWPo0JsivrY+ZvP2ekyH6aOpZuxHHu+guCdR3215irAznRBrX2vMV7p9CfhmVgymXeeCiqJCWLADLwODYNope2eGKWr2Q9+zfdS6EtatJqfYprBmr7+qd+j4zy+m9u5wqWJ04yIhFBSJiW/x+zDh3cmMdfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726648363; c=relaxed/simple;
	bh=4bdcaWigprfYvBVzSps/LxeQRSmCfy9YoxxwSIdXq2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HsbNv26qcxLOnmIPp2GEh1ulEkZ7QAOvGMivEiZFzf2k6GwHRpjNjaBY9pPvvL5vLdwEDFPv/yCGZlDYWvZ7HoNYK5mo7TjFP6MS3fT5mON4/HkTbzHc5169V6fOxeQPNkU5qzPendP/y0/vgrd9lcdTVk9wxzVbfCmOBSK5zf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=gtTqPTWV; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1726648359;
	bh=Y6OULQl6Ue3orcYsxG9AXjPiGVo+Zb0pbCMaMnhulC8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gtTqPTWVle/Hnqk+/UsZ5sGyHLenCiRzDxJgz0bNIUW3j7YymUZCb3uKf2ot9Le06
	 TSnlO5Tp0TEMq2Y7MPI1PyUhQVHyHoWFACpsCRkVpYsFCUyUxDADQT/itSt0aOSrKb
	 AsB4C/WwxTDSg5eSQdSa6GF8rMOBmlpyfJN70j4w=
Received: from [10.1.8.111] (unknown [10.1.8.111])
	by uho.ysoft.cz (Postfix) with ESMTP id 32E4FA0419;
	Wed, 18 Sep 2024 10:32:39 +0200 (CEST)
Message-ID: <9c8410cb-cae4-458c-ac08-0fbe30956414@ysoft.com>
Date: Wed, 18 Sep 2024 10:32:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: imx: Add imx8mp-iota2-lumpy board
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Shawn Guo <shawnguo@kernel.org>, Petr Benes <petr.benes@ysoft.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
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
 <20240917151001.1289399-3-michal.vokac@ysoft.com>
 <ZunTWqY6oLZibZXj@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
In-Reply-To: <ZunTWqY6oLZibZXj@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17. 09. 24 21:07, Frank Li wrote:
> On Tue, Sep 17, 2024 at 05:09:59PM +0200, Michal Vokáč wrote:
>> The IOTA2 Lumpy board is based on the i.MX8MPlus EVK.
>>
>> Basic features are:
>> - 4GB LPDDR4
>> - 64GB eMMC
>> - 2x 1GB Ethernet
>> - USB 3.0 Type-C dual role port, without power delivery
>> - USB 3.0 Type-A host port
>> - RGB LED - PWM driven
>> - speaker - PWM driven
>> - RTC with super capacitor backup
>>
>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
>> ---
> 
> Suggest you try tools https://github.com/lznuaa/dt-format
> 
> Any issue let me know.

Hi Frank,
I was aware of some non-written rules how the nodes
and properties should be sorted but this will definitely help!

I will try it for v2.
Thanks a lot.

>>   arch/arm64/boot/dts/freescale/Makefile        |   1 +
>>   .../boot/dts/freescale/imx8mp-iota2-lumpy.dts | 425 ++++++++++++++++++
>>   2 files changed, 426 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
>>
>> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
>> index f04c22b7de72..421c36c5ae68 100644
>> --- a/arch/arm64/boot/dts/freescale/Makefile
>> +++ b/arch/arm64/boot/dts/freescale/Makefile
>> @@ -171,6 +171,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk2.dtb
>>   dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk3.dtb
>>   dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
>>   dtb-$(CONFIG_ARCH_MXC) += imx8mp-icore-mx8mp-edimm2.2.dtb
>> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-iota2-lumpy.dtb
>>   dtb-$(CONFIG_ARCH_MXC) += imx8mp-msc-sm2s-ep1.dtb
>>   dtb-$(CONFIG_ARCH_MXC) += imx8mp-navqp.dtb
>>   dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts b/arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
>> new file mode 100644
...
[snip]
...
>> +
>> +&pwm4 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_pwm4>;
>> +	pwm-gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;

^^^ The pwm-gpios property should not be here. I will remove it in v2.

>> +	status = "okay";
>> +};


