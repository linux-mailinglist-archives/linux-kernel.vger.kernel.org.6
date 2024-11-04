Return-Path: <linux-kernel+bounces-394222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DE09BAC19
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 06:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B3B1F21436
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 05:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E1C18BC06;
	Mon,  4 Nov 2024 05:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="UT1udimv"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EB0189916;
	Mon,  4 Nov 2024 05:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730698591; cv=none; b=nAzt5BbPjMp7ia3t5EhysvrJg1WOBLfJ9EcupS7MGPj7onA2n4AuRkZ8/EZACTnXDwrc81SxxwoDv9e5KE7/oLPWDTIuYOYRT3/5kg03ZhtkN3WDXDUpww+X8h5WVyPimShb2R/4okpB1T0sjN/k6QfmUiwoiRGsaV5hBLlAq+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730698591; c=relaxed/simple;
	bh=M8fiDdWP9TqU5G7C4KsM1hZt+cILpRsYqCPpihJWIdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S1Fp5rR+OTIXm7F27j9YXPY3FLNW1HiTFtiHtGpcMRrzQDSd2YehKLFB61Nvbimp0k1yxuKeIcA6u/NoqqgfnbgY6RIA9r0K/laXveFlCILxWM9sg+Y25A+0+CmuOjpm4ih/4EGByUEbv3DbalO6T3BvTUj44xkTXYdyrIU/kAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=UT1udimv; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [192.168.1.107] (87-97-112-21.pool.digikabel.hu [87.97.112.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: hs@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id A4FEF89138;
	Mon,  4 Nov 2024 06:36:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730698586;
	bh=zNgk47u3wRfC4zw7b391h07FE1WMd6Q9cZ/grbxNFII=;
	h=Date:Subject:To:Cc:References:From:Reply-To:In-Reply-To:From;
	b=UT1udimvre//bCB8aCJMPmxDMRwwAdn3E0ZYyRJVoH2NwLTtZRBNze6zYt5Ai4F5J
	 DSLoOd20gmFYKvNu30OaNmNsPZpYPlZOysocQX8dPiRiJ7fi29vW9opYLE4HTOhex2
	 5aszpyqKACMCbtew+NhiUORrALUxkUVALm98l5aTTqts2bwvJXQX29gBhuajSrr5QA
	 0S/DRJLoQcTgmA3qYXiAWgbiNcmhvtGSnS86UVlU3bAHsotu9vWbk8WQcvzvDLdiy0
	 SOlyOu5xuNfMCkbYiVKI5JYdrFc8zc/e8c+jFBOzasqiM+u9U8n7ZF5sPYeyNHFNDK
	 B/8BeSD3YBJUA==
Message-ID: <5340fb82-bda0-d22f-23df-de620c8d61c3@denx.de>
Date: Mon, 4 Nov 2024 06:33:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 3/3] arm64: dts: imx8mp: add aristainetos3 board
 support
Content-Language: en-US
To: Shawn Guo <shawnguo2@yeah.net>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20241031151238.67753-1-hs@denx.de>
 <20241031151238.67753-4-hs@denx.de> <ZydFO6b6oe9widaa@dragon>
From: Heiko Schocher <hs@denx.de>
Reply-To: hs@denx.de
In-Reply-To: <ZydFO6b6oe9widaa@dragon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Shawn,

removed the changes which are clear...

On 03.11.24 10:41, Shawn Guo wrote:
> On Thu, Oct 31, 2024 at 04:12:37PM +0100, Heiko Schocher wrote:
>> Add support for the i.MX8MP based aristainetos3 boards from ABB.
>>
>> The board uses a ABB specific SoM from ADLink, based on NXP
>> i.MX8MP SoC. The SoM is used on 3 different carrier boards,
>> with small differences.
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> ---
>>
[...]
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dtsi
>> new file mode 100644
>> index 000000000000..ced35e1d72b7
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dtsi
[...]
>> +	pcie0_refclk: pcie0-refclk {
> 
> Can we name the node clock-xxx?

renamed from rename pcie0-refclk to clock-pcie0-ref

[...]
>> +	/* SX1509(0) U2605 */
>> +	gpio6: pinctrl@3f {
>> +		#gpio-cells = <2>;
>> +		#interrupt-cells = <2>;
>> +		compatible = "semtech,sx1509q";
>> +		reg = <0x3f>;

I moved compatible and reg to the beginning of the node,
as you commented this also on other places.

>> +
>> +		semtech,probe-reset;
>> +		gpio-controller;
>> +		interrupt-controller;
>> +
>> +		interrupt-parent = <&gpio1>;
>> +		interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
>> +	};

Should I remove newlines here too?... but looking into the example from

Documentation/devicetree/bindings/pinctrl/semtech,sx1501q.yaml

there are this newlines ... so I let this lines in... or?

>> +
>> +	/* SX1509(1) U2606 */
>> +	gpio7: pinctrl@70 {
>> +		#gpio-cells = <2>;
>> +		#interrupt-cells = <2>;
>> +		compatible = "semtech,sx1509q";
>> +		reg = <0x70>;

I moved compatible and reg to the beginning of the node here too.

>> +
>> +		semtech,probe-reset;
>> +		gpio-controller;
>> +		interrupt-controller;
>> +
>> +		interrupt-parent = <&gpio4>;
>> +		interrupts = <19 IRQ_TYPE_EDGE_FALLING>;
>> +
>> +		gpio6-cfg {
>> +			pins = "gpio6";
>> +			output-high;
>> +		};
>> +
>> +		gpio7-cfg {
>> +			pins = "gpio7";
>> +			output-high;
>> +		};
>> +	};

and let the newlines as I did...

>> +
>> +	/* RTC U2607 */
>> +	rtc0: rtc@51 {
> 
> I2C slave nodes should be sorted in addresses.

done.

> 
>> +		compatible = "nxp,pcf8563";
>> +		reg = <0x51>;
>> +		#clock-cells = <0>;
>> +	};
>> +};
>> +
>> +&irqsteer_hdmi {
>> +	status = "okay";
>> +};
>> +
>> +&lcdif1 {
>> +	status = "disabled";
>> +};
>> +
>> +&lcdif2 {
>> +	status = "disabled";
>> +};
>> +
>> +/* HDMI */
>> +&lcdif3 {
>> +	status = "okay";
>> +
> 
> Unneeded newline.

Many thanks for your review, and sorry, for trivial fixes...

bye,
Heiko

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

