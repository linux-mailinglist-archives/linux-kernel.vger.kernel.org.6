Return-Path: <linux-kernel+bounces-203748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008AE8FDFEF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB7D288843
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468CE13BAD4;
	Thu,  6 Jun 2024 07:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qe2+BYMQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859AC132494;
	Thu,  6 Jun 2024 07:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717659300; cv=none; b=qzXobx5aD6z1sxIq3iPWJzGskV5R6qj4of17fc4vzU4PMdyAVEVqj71wLbqc8p+y1vLFj8z/ae2i7y+bCxR6O/E230fWIUfV5lcr3iq5dyi3ihZ8ZOzjxc7aKVOd07NcUNXOQfVmKjPz1l23YFIPNvM9xREON1y+cMFbeYzR4DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717659300; c=relaxed/simple;
	bh=OkV6XVuG6ybB4NCEJoskZZ1td3YrA3Uf2zmqvwKypac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+RVlY52+IqQXCMwc8MDzfXt4t8UfiNeKRZDH92a+ylVJhpUcZ2aZp4QMuyqQojk4EypbXh4gP7f1DY+XppbRmL9GpVjaj/ZgLT8aCGd9yPvystMMqYCgETjnL6Aio9Ltq7YpkZQOJrV/34O7GjojiB8brYYmThClyfbVp+9XYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qe2+BYMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDE9C2BD10;
	Thu,  6 Jun 2024 07:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717659300;
	bh=OkV6XVuG6ybB4NCEJoskZZ1td3YrA3Uf2zmqvwKypac=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qe2+BYMQ3QbD0U5WfbBYjUQxXAtvh+vjt7Mt0F+9By9hKlCM4Pk8Vl/UcqorQ03V7
	 pA6Y4hg0+vyur+eDqRFFe9XYqQHqHYMcSKiIe4/jFDcoxrMTJDue5CV/OSjG07nbiV
	 sD4KDDuhGDyvgITugBQ0NHFUY/zlpF8vrjn8cJf6nps/QhcCIQCrHKxAU9W6CHO8tn
	 0T29G18CSyLt8BqSZwUgWYEMRATMm5dSU5uTSBV7L/UMspr4XdBcnfIuVFDZ412ieM
	 glQs6KNZLtb9QrOtisbKzVn7aTpWppUxajFC43raAp6DP9thGC2mZSXJJhlkAhOCRK
	 Po05a2vI536Yw==
Message-ID: <c6d1b64b-48bf-435f-823c-fb4c588819cc@kernel.org>
Date: Thu, 6 Jun 2024 10:34:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] arm64: dts: ti: k3-j722s: Switch to
 k3-am62p-j722s-common.dtsi
To: Vignesh Raghavendra <vigneshr@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, nm@ti.com, afd@ti.com,
 kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, u-kumar1@ti.com, danishanwar@ti.com,
 srk@ti.com
References: <20240604085252.3686037-1-s-vadapalli@ti.com>
 <20240604085252.3686037-5-s-vadapalli@ti.com>
 <79eedaea-bf4f-4a20-8a52-751ce7187523@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <79eedaea-bf4f-4a20-8a52-751ce7187523@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06/06/2024 07:05, Vignesh Raghavendra wrote:
> 
> 
> On 04/06/24 14:22, Siddharth Vadapalli wrote:
>> Update "k3-j722s.dtsi" to use "k3-am62p-j722s-common.dtsi" which
>> contains the nodes shared with AM62P, followed by including the J722S
>> specific main domain peripherals contained in "k3-j722s-main.dtsi".
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>> v4:
>> https://lore.kernel.org/r/20240601121554.2860403-5-s-vadapalli@ti.com/
>> No changes since v4.
>>
>>  arch/arm64/boot/dts/ti/k3-j722s.dtsi | 97 +++++++++++++++++++++++++++-
>>  1 file changed, 96 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j722s.dtsi b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
>> index c75744edb143..9e04e6a5c0fd 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j722s.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
>> @@ -10,12 +10,107 @@
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>  #include <dt-bindings/soc/ti,sci_pm_domain.h>
>>  
>> -#include "k3-am62p5.dtsi"
>> +#include "k3-am62p-j722s-common.dtsi"
>> +#include "k3-j722s-main.dtsi"
>>  
>>  / {
>>  	model = "Texas Instruments K3 J722S SoC";
>>  	compatible = "ti,j722s";
>>  
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		cpu-map {
>> +			cluster0: cluster0 {
>> +				core0 {
>> +					cpu = <&cpu0>;
>> +				};
>> +
>> +				core1 {
>> +					cpu = <&cpu1>;
>> +				};
>> +
>> +				core2 {
>> +					cpu = <&cpu2>;
>> +				};
>> +
>> +				core3 {
>> +					cpu = <&cpu3>;
>> +				};
>> +			};
>> +		};
>> +
>> +		cpu0: cpu@0 {
>> +			compatible = "arm,cortex-a53";
>> +			reg = <0x000>;
>> +			device_type = "cpu";
>> +			enable-method = "psci";
>> +			i-cache-size = <0x8000>;
>> +			i-cache-line-size = <64>;
>> +			i-cache-sets = <256>;
>> +			d-cache-size = <0x8000>;
>> +			d-cache-line-size = <64>;
>> +			d-cache-sets = <128>;
>> +			next-level-cache = <&l2_0>;
>> +			clocks = <&k3_clks 135 0>;
>> +		};
>> +
>> +		cpu1: cpu@1 {
>> +			compatible = "arm,cortex-a53";
>> +			reg = <0x001>;
>> +			device_type = "cpu";
>> +			enable-method = "psci";
>> +			i-cache-size = <0x8000>;
>> +			i-cache-line-size = <64>;
>> +			i-cache-sets = <256>;
>> +			d-cache-size = <0x8000>;
>> +			d-cache-line-size = <64>;
>> +			d-cache-sets = <128>;
>> +			next-level-cache = <&l2_0>;
>> +			clocks = <&k3_clks 136 0>;
>> +		};
>> +
>> +		cpu2: cpu@2 {
>> +			compatible = "arm,cortex-a53";
>> +			reg = <0x002>;
>> +			device_type = "cpu";
>> +			enable-method = "psci";
>> +			i-cache-size = <0x8000>;
>> +			i-cache-line-size = <64>;
>> +			i-cache-sets = <256>;
>> +			d-cache-size = <0x8000>;
>> +			d-cache-line-size = <64>;
>> +			d-cache-sets = <128>;
>> +			next-level-cache = <&l2_0>;
>> +			clocks = <&k3_clks 137 0>;
>> +		};
>> +
>> +		cpu3: cpu@3 {
>> +			compatible = "arm,cortex-a53";
>> +			reg = <0x003>;
>> +			device_type = "cpu";
>> +			enable-method = "psci";
>> +			i-cache-size = <0x8000>;
>> +			i-cache-line-size = <64>;
>> +			i-cache-sets = <256>;
>> +			d-cache-size = <0x8000>;
>> +			d-cache-line-size = <64>;
>> +			d-cache-sets = <128>;
>> +			next-level-cache = <&l2_0>;
>> +			clocks = <&k3_clks 138 0>;
>> +		};
>> +	};
>> +
>> +	l2_0: l2-cache0 {
>> +		compatible = "cache";
>> +		cache-unified;
>> +		cache-level = <2>;
>> +		cache-size = <0x80000>;
>> +		cache-line-size = <64>;
>> +		cache-sets = <512>;
>> +	};
>> +
>>  	cbass_main: bus@f0000 {
>>  		compatible = "simple-bus";
>>  		#address-cells = <2>;
> 
> 
> You would need to move the rest of main domain overrides and cbass_main
> definitions to k3-j722s-main.dtsi and limit this file to CPU definitions
> similar to k3-am62p5.dtsi

Not exactly.
In existing cases there are 2 soc.dtsi files. e.g. k3-am62p.dtsi and k3-am62p5.dtsi.
or k3-am2.dtsi and k3-am625.dtsi.

The former includes everything that is required for the SOC variant except the CPU, OPP and cache.
The later includes just the CPU, OPP and cache.

I suppose this only makes sense if there are multiple variants of the SoC where only
the number of CPUs change. Would this be the case for J722S?

If not then one soc.dtsi file should be sufficient. If yes then we need to have 2 soc.dtsi files
for J722S like the rest.

-- 
cheers,
-roger

