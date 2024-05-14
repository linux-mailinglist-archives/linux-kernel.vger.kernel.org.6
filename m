Return-Path: <linux-kernel+bounces-179220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 489028C5D98
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 00:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E62282AAC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 22:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11AC181D14;
	Tue, 14 May 2024 22:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="ABVrdqsn"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A789181D08;
	Tue, 14 May 2024 22:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715725092; cv=none; b=NBBHDn2CIONroCJtTQAsd8YLhqnMiLNLxawyHuBSecvdcWmSjZTYDa8k6bwlhUeE0zUec57D4t38iE2RetWMe21wAr56H0lBFPk9fxooI+BW+ocUUfKu4TPB51YnQSmMHUz0jI2bJ05VV3KNxMWaGQkZiSIljJCiY0KaaEE7gdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715725092; c=relaxed/simple;
	bh=9ciPSoqqMHTtFS8nutcgS4ikRZ/tBFIV3ZdrBc/NiWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HHWJbNyi7ygXd8FJAJ9zWiHmuoOTTuF9VhGj3uk2odVQXUpAmCtgqkPll8XIsTjccrG6oSysVjO5kkqqr7mhP50syEzQxZyDph0jNJ450BZ22MuwIhJWB+1ihA5gtHMeFIHe5m2W/pGPLl47JPjCdqugOwoaZXQewVTiBFt4AlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=ABVrdqsn; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 5AF00876D3;
	Wed, 15 May 2024 00:18:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715725087;
	bh=CsNoWcXM1ppcN0YOlwJ4B/BYSvwggX+9BTCQYNe9hWI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ABVrdqsnvRAtXScssnktnh1qHNWzKJIRDs1HmZFPIKdpdO9F8hGtzscoeXFQ3odgz
	 JXvGs8d8pvJSI7+L5kY6K/VIzZd0bcjnvITGshseTd9Q382QLR1mU3TSB2rFwovLe0
	 xME8aKImNN7f6Ye7dDa6MSk1dxoJfroerq6oBpoi4lQXzs220MQEnqc8Je4A5hMPmB
	 hNX3rJRUSa26TklWwV4LgCVvHfLQHGB9Sargv9KuztVkAS1GHsOlPRiQIYe7/zBdpu
	 J1I8fzq9vrU7rUKTIaZHzyybDtTxEORH7rhpBL6X2bIKL9gkK7Q83JA3V/9BpyPm4y
	 cxRNchqKD2KEQ==
Message-ID: <68faa6d9-2053-4b7c-bf34-5b0132234fdb@denx.de>
Date: Wed, 15 May 2024 00:18:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx8mp: Enable HDMI on i.MX8MP DHCOM PDK2 and
 PDK3
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, kernel@dh-electronics.com,
 linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
References: <20240514010706.245874-1-marex@denx.de>
 <171569116690.1193972.14506684066492342240.robh@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <171569116690.1193972.14506684066492342240.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 5/14/24 2:53 PM, Rob Herring (Arm) wrote:
> 
> On Tue, 14 May 2024 03:06:42 +0200, Marek Vasut wrote:
>> Enable HDMI output on i.MX8MP DHCOM PDK2 and PDK3. The I2C5 on PDK2 and
>> I2C mux port 1 on PDK3 respectively are used in regular I2C mode instead
>> of HDMI DDC mode to permit connection of other I2C devices on those buses.
>> The pinctrl_hdmi node is part of the SoM DTSI already.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Conor Dooley <conor+dt@kernel.org>
>> Cc: Fabio Estevam <festevam@gmail.com>
>> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
>> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> Cc: Shawn Guo <shawnguo@kernel.org>
>> Cc: devicetree@vger.kernel.org
>> Cc: imx@lists.linux.dev
>> Cc: kernel@dh-electronics.com
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   .../boot/dts/freescale/imx8mp-dhcom-pdk2.dts  | 39 +++++++++++++++++++
>>   .../boot/dts/freescale/imx8mp-dhcom-pdk3.dts  | 39 +++++++++++++++++++
>>   2 files changed, 78 insertions(+)
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
>    pip3 install dtschema --upgrade
> 
> 
> New warnings running 'make CHECK_DTBS=y freescale/imx8mp-dhcom-pdk2.dtb freescale/imx8mp-dhcom-pdk3.dtb' for 20240514010706.245874-1-marex@denx.de:
> 
> arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb: hdmi@32fd8000: Unevaluated properties are not allowed ('ddc-i2c-bus' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/display/bridge/fsl,imx8mp-hdmi-tx.yaml#
> arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk3.dtb: hdmi@32fd8000: Unevaluated properties are not allowed ('ddc-i2c-bus' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/display/bridge/fsl,imx8mp-hdmi-tx.yaml#

Should be fixed in:
[PATCH] dt-bindings: display: synopsys,dw-hdmi: Document ddc-i2c-bus in core

