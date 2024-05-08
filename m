Return-Path: <linux-kernel+bounces-173265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 554C18BFDE5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A301F23227
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE8F5820C;
	Wed,  8 May 2024 13:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5pETPso"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A45371743;
	Wed,  8 May 2024 13:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715173378; cv=none; b=GqxsT7H0TL0j/pE4C3mgNWrT2A2CO9rC0S8SAPksQdEuQ2zw+svVqJEB6cZ2MU6jHXzyNB612JkMk1slN5ix/QiZFW96WBRgemkpLeSG0yaIo7es3/fS+u8sdObASfn4xBR7Z2rz5RMHZYUrZAoO3PS9F88dVY8cBdm8CBY+Cf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715173378; c=relaxed/simple;
	bh=89gxv2OmVIXBpKJ0KBrURw3KAXhqx4LlM2G16y5n01A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FAvVWCSaecMEd5+tyW1juo1lr+AlBUnHY4BEkcnEWkta7FS2F3v8nkGVlq6/ZDy5Lnx6BZuyTk/j+NYshwMlIddls+yF+TvsGoEVWPCUf3vdakwoXhQ4xUklF48JZNRu1dpTF35JAlyg7sFC1w0DmEFn9SPgwdwdyV26sTpf7OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5pETPso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7BFDC113CC;
	Wed,  8 May 2024 13:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715173377;
	bh=89gxv2OmVIXBpKJ0KBrURw3KAXhqx4LlM2G16y5n01A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s5pETPso8jBS3NSdnAZS+wlXawBmUR6L0T1YsuuQI6S9oW1KMSQZbu0YM15kjsk9L
	 0QDVPXdoHIyULFovIc7h+Xrn+B4jUmXUaOFwtzHHVMMcoXuHPPuyGbcGbq6ratQD+m
	 2gceAk+4j1hCi9d3uO9hMyTB0NA72yRyc+Z1qm28+AZrY1R1fVUIok976sWC0ZM+jm
	 IA0+9OFh1r1YWe8dBqKDT+gf2mKYuGAuoMugvdSxIMd5/5ExzP3voekmXBSG6hanCm
	 XdqPkQsaLNIoI26ZfL+Oi8gL2t6fcIlCromh6vCJ6MIJXfENnaLLtQdmYMYytGSrV1
	 2A5kigeqUHDOw==
Message-ID: <59d8af19-5b2b-486a-9e03-2db2568b0b00@kernel.org>
Date: Wed, 8 May 2024 16:02:52 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-j722s: Add support for SERDES0
To: Ravi Gunasekaran <r-gunasekaran@ti.com>, nm@ti.com, vigneshr@ti.com
Cc: kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, srk@ti.com, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240429120932.11456-1-r-gunasekaran@ti.com>
 <20240429120932.11456-2-r-gunasekaran@ti.com>
 <41047a89-2787-422f-a643-3e2d850da6dd@kernel.org>
 <588e4d0a-78c6-553f-3c40-0d248f4c92f9@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <588e4d0a-78c6-553f-3c40-0d248f4c92f9@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 08/05/2024 15:34, Ravi Gunasekaran wrote:
> 
> 
> On 5/8/24 5:29 PM, Roger Quadros wrote:
>>
>>
>> On 29/04/2024 15:09, Ravi Gunasekaran wrote:
>>> Add SERDES0 and its wrapper description to support USB3
>>> and SGMII interfaces.
>>>
>>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>>> ---
>>>  arch/arm64/boot/dts/ti/k3-j722s.dtsi | 54 ++++++++++++++++++++++++++++
>>>  1 file changed, 54 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-j722s.dtsi b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
>>> index c75744edb143..beba5a3ea6cc 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j722s.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
>>> @@ -9,6 +9,7 @@
>>>  #include <dt-bindings/interrupt-controller/irq.h>
>>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>  #include <dt-bindings/soc/ti,sci_pm_domain.h>
>>> +#include <dt-bindings/phy/phy-ti.h>
>>>  
>>>  #include "k3-am62p5.dtsi"
>>>  
>>> @@ -75,6 +76,50 @@
>>>  			 <0x00 0x78000000 0x00 0x78000000 0x00 0x00008000>,
>>>  			 <0x00 0x78100000 0x00 0x78100000 0x00 0x00008000>;
>>>  	};
>>> +
>>> +	serdes_refclk: clock-cmnrefclk {
>>
>> What could be the generic name here?
>>
> 
> How about phy-clk or serdes-clk?
> I searched for "fixed-clock" and wide range of naming conventions is followed.

We shouldn't encode the clock function in the name. How about just clk-<n> ?
where <n> is an integer starting from 0 for such fixed-clocks on the platform?

e.g. from arch/arm64/boot/dts/ti/k3-am62p5-sk.dts

        tlv320_mclk: clk-0 {
                #clock-cells = <0>;
                compatible = "fixed-clock";
                clock-frequency = <12288000>;
        };

> 
>>> +		compatible = "fixed-clock";
>>> +		#clock-cells = <0>;
>>> +		clock-frequency = <0>;
>>> +	};
>>> +
>>> +	serdes_wiz0: wiz@f000000 {
>>
>> Should generic name be phy?
> 
> Since serdes is used for both USB and PCIe,
> I can go with "phy".
> 
>>
>>> +		compatible = "ti,am64-wiz-10g";
>>> +		ranges = <0x0f000000 0x0 0x0f000000 0x00010000>;
>>> +		#address-cells = <1>;
>>> +		#size-cells = <1>;
>>> +		power-domains = <&k3_pds 279 TI_SCI_PD_EXCLUSIVE>;
>>> +		clocks = <&k3_clks 279 0>, <&k3_clks 279 1>, <&serdes_refclk>;
>>> +		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
>>> +		num-lanes = <1>;
>>> +		#reset-cells = <1>;
>>> +		#clock-cells = <1>;
>>> +
>>> +		assigned-clocks = <&k3_clks 279 1>;
>>> +		assigned-clock-parents = <&k3_clks 279 5>;
>>> +
>>> +		serdes0: serdes@f000000 {
>>
>> here too?
> 
> I could use "phy" here as well. 
> https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/qcom/sa8775p.dtsi#L1853
> https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/renesas/r8a779f0.dtsi#L563
> 
>>
>>> +			compatible = "ti,j721e-serdes-10g";
> 
> [...]
> 
>>
> 

-- 
cheers,
-roger

