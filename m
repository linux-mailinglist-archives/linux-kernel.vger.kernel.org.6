Return-Path: <linux-kernel+bounces-173110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 404498BFBA8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 641141C21700
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D87823AF;
	Wed,  8 May 2024 11:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="A3CV+ykc"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABA281AC9;
	Wed,  8 May 2024 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166954; cv=none; b=gGZMaarYkR80XABYxpxp6MGgFDEi9TJf3Q57JKmWfZJjhG7DAt3Qv0peXVIcrQ/qOJiTJcYwOD/PbuYrAU/TbIwQVvU86096vOk4A9LRN8aA6gQVpynq0m1g6RR7lMwtQSZlNTZfTDyCZPNc8FYjW17MwAFyglR2zkFrJZuD8YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166954; c=relaxed/simple;
	bh=cve9M7sxnq78lOjxsDLvb1DRis1ryDNYsPrCw+TPGNo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ZII0Cud3TvBEavFkovp6LuDZpeN86dstjOxwQW76r8qncOknQdwGp0yediDsN6Bfqn/LoB6pKo2eeNfeNeotYwVi8MXln6i46q34QgH9sKXL04GO4MEYmA9AHzj3jqrcDH309m7kJSivAIpM419dihalrB9G7FfplxlCtftOdqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=A3CV+ykc; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1715166950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QPAEeA0CkPDdIv/ooRd8/ifVd6EJ9Y9Yw4vH9Idab5k=;
	b=A3CV+ykcWtjFC4VIfZzkPFMB1SqTDE53BHPWarYAgqWl9vrzWDdQqMTxOoV8EoRO5bHIzL
	ihDTQPLzw24Gaxr53riaY1sngR0ayqcgachm2BLYCBX4nP83aiP3/EE2Y7vyC/DAC3jf5x
	HtaBPCQK7QgBMvz5NtnfnB35zMLLa9r49FN1Tam57jhWsIrd84wFSbBBPEnkH/uNEnZZaZ
	lr6jgT2+Y+BQaYIoulVgUStynOhMi5nhCdf8X9CWIc/6k1W3J5s0RMYbLb37yTX7Y2EOeM
	Pd/ObldnRpXIwva6vWTntS7INu/a9xWw4PTRFYPhon/AYy2mBVOrndLEaHr3xQ==
Date: Wed, 08 May 2024 13:15:49 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: linux-sunxi@lists.linux.dev, wens@csie.org, jernej.skrabec@gmail.com,
 samuel@sholland.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: Add cache information to the SoC
 dtsi for H616
In-Reply-To: <20240508120511.53bbac31@donnerap.manchester.arm.com>
References: <9d52e6d338a059618d894abb0764015043330c2b.1714727227.git.dsimic@manjaro.org>
 <20240508120511.53bbac31@donnerap.manchester.arm.com>
Message-ID: <122e231c7bb8c7bfc5fe7da745040608@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Andre,

On 2024-05-08 13:05, Andre Przywara wrote:
> On Fri,  3 May 2024 11:09:41 +0200
> Dragan Simic <dsimic@manjaro.org> wrote:
> 
>> Add missing cache information to the Allwinner H616 SoC dtsi, to allow
>> the userspace, which includes lscpu(1) that uses the virtual files 
>> provided
>> by the kernel under the /sys/devices/system/cpu directory, to display 
>> the
>> proper H616 cache information.
>> 
>> Adding the cache information to the H616 SoC dtsi also makes the 
>> following
>> warning message in the kernel log go away:
>> 
>>   cacheinfo: Unable to detect cache hierarchy for CPU 0
>> 
>> Rather conspicuously, almost no cache-related information is available 
>> in
>> the publicly available Allwinner H616 datasheet (version 1.0) and H616 
>> user
>> manual (version 1.0).  Thus, the cache parameters for the H616 SoC 
>> dtsi were
>> obtained and derived by hand from the cache size and layout 
>> specifications
>> found in the following technical reference manual, and from the cache 
>> size
>> and die revision hints available from the following community-provided 
>> data
>> and memory subsystem benchmarks:
>> 
>>   - ARM Cortex-A53 revision r0p4 TRM, version J
>>   - Summary of the two available H616 die revisions and their 
>> differences
>>     in cache sizes observed from the CSSIDR_EL1 register readouts, 
>> provided
>>     by Andre Przywara [1][2]
>>   - Tinymembench benchmark results of the H616-based OrangePi Zero 2 
>> SBC,
>>     provided by Thomas Kaiser [3]
>> 
>> For future reference, here's a brief summary of the available 
>> documentation
>> and the community-provided data and memory subsystem benchmarks:
>> 
>>   - All caches employ the 64-byte cache line length
>>   - Each Cortex-A53 core has 32 KB of L1 2-way, set-associative 
>> instruction
>>     cache and 32 KB of L1 4-way, set-associative data cache
>>   - The size of the L2 cache depends on the actual H616 die revision 
>> (there
>>     are two die revisions), so the entire SoC can have either 256 KB 
>> or 1 MB
>>     of unified L2 16-way, set-associative cache [1]
>> 
>> Also for future reference, here's the relevant excerpt from the 
>> community-
>> provided H616 memory subsystem benchmark, [3] which confirms that 32 
>> KB and
>> 256 KB are the L1 data and L2 cache sizes, respectively:
>> 
>>     block size : single random read / dual random read
>>           1024 :    0.0 ns          /     0.0 ns
>>           2048 :    0.0 ns          /     0.0 ns
>>           4096 :    0.0 ns          /     0.0 ns
>>           8192 :    0.0 ns          /     0.0 ns
>>          16384 :    0.0 ns          /     0.0 ns
>>          32768 :    0.0 ns          /     0.0 ns
>>          65536 :    4.3 ns          /     7.3 ns
>>         131072 :    6.6 ns          /    10.5 ns
>>         262144 :    9.8 ns          /    15.2 ns
>>         524288 :   91.8 ns          /   142.9 ns
>>        1048576 :  138.6 ns          /   188.3 ns
>>        2097152 :  163.0 ns          /   204.8 ns
>>        4194304 :  178.8 ns          /   213.5 ns
>>        8388608 :  187.1 ns          /   217.9 ns
>>       16777216 :  192.2 ns          /   220.9 ns
>>       33554432 :  196.5 ns          /   224.0 ns
>>       67108864 :  215.7 ns          /   259.5 ns
> 
> Thanks for dumping the elaborate information here!

You're welcome! :)  I like when patch descriptions provide as much
relevant information as possible, so I always try to do that myself.

>> The changes introduced to the H616 SoC dtsi by this patch specify 256 
>> KB as
>> the L2 cache size.  As outlined by Andre Przywara, [2] a follow-up 
>> TF-A patch
>> will perform runtime adjustment of the device tree data, making the 
>> correct
>> L2 cache size of 1 MB present in the device tree for the boards based 
>> on the
>> revision of H616 that actually provides 1 MB of L2 cache.
> 
> I pushed that TF-A patch for review now:
> https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/28694/1
> On my OrangePi Zero3 (with an 1MB H618 SoC) the size and number of sets
> get adjusted to describe 1MB:
> => fdt list /cpus/l2-cache
> l2-cache {
>         compatible = "cache";
>         cache-level = <0x00000002>;
>         cache-unified;
>         cache-size = <0x00100000>;
>         cache-line-size = <0x00000040>;
>         cache-sets = <0x00000400>;
>         phandle = <0x00000003>;
> };

Awesome, thanks for the follow-up TF-A patch!  I'll keep an eye
on your TF-A patch submission.

>> [1] 
>> https://lore.kernel.org/linux-sunxi/20240430114627.0cfcd14a@donnerap.manchester.arm.com/
>> [2] 
>> https://lore.kernel.org/linux-sunxi/20240501103059.10a8f7de@donnerap.manchester.arm.com/
>> [3] 
>> https://raw.githubusercontent.com/ThomasKaiser/sbc-bench/master/results/4knM.txt
>> 
>> Suggested-by: Andre Przywara <andre.przywara@arm.com>
>> Helped-by: Andre Przywara <andre.przywara@arm.com>
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> 
> So I can confirm that the information above is correct, and also 
> matches
> the DT properties added below.
> 
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks!

>> ---
>>  .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 37 
>> +++++++++++++++++++
>>  1 file changed, 37 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi 
>> b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
>> index b2e85e52d1a1..4faed88d8909 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
>> @@ -26,30 +26,67 @@ cpu0: cpu@0 {
>>  			reg = <0>;
>>  			enable-method = "psci";
>>  			clocks = <&ccu CLK_CPUX>;
>> +			i-cache-size = <0x8000>;
>> +			i-cache-line-size = <64>;
>> +			i-cache-sets = <256>;
>> +			d-cache-size = <0x8000>;
>> +			d-cache-line-size = <64>;
>> +			d-cache-sets = <128>;
>> +			next-level-cache = <&l2_cache>;
>>  		};
>> 
>>  		cpu1: cpu@1 {
>>  			compatible = "arm,cortex-a53";
>>  			device_type = "cpu";
>>  			reg = <1>;
>>  			enable-method = "psci";
>>  			clocks = <&ccu CLK_CPUX>;
>> +			i-cache-size = <0x8000>;
>> +			i-cache-line-size = <64>;
>> +			i-cache-sets = <256>;
>> +			d-cache-size = <0x8000>;
>> +			d-cache-line-size = <64>;
>> +			d-cache-sets = <128>;
>> +			next-level-cache = <&l2_cache>;
>>  		};
>> 
>>  		cpu2: cpu@2 {
>>  			compatible = "arm,cortex-a53";
>>  			device_type = "cpu";
>>  			reg = <2>;
>>  			enable-method = "psci";
>>  			clocks = <&ccu CLK_CPUX>;
>> +			i-cache-size = <0x8000>;
>> +			i-cache-line-size = <64>;
>> +			i-cache-sets = <256>;
>> +			d-cache-size = <0x8000>;
>> +			d-cache-line-size = <64>;
>> +			d-cache-sets = <128>;
>> +			next-level-cache = <&l2_cache>;
>>  		};
>> 
>>  		cpu3: cpu@3 {
>>  			compatible = "arm,cortex-a53";
>>  			device_type = "cpu";
>>  			reg = <3>;
>>  			enable-method = "psci";
>>  			clocks = <&ccu CLK_CPUX>;
>> +			i-cache-size = <0x8000>;
>> +			i-cache-line-size = <64>;
>> +			i-cache-sets = <256>;
>> +			d-cache-size = <0x8000>;
>> +			d-cache-line-size = <64>;
>> +			d-cache-sets = <128>;
>> +			next-level-cache = <&l2_cache>;
>> +		};
>> +
>> +		l2_cache: l2-cache {
>> +			compatible = "cache";
>> +			cache-level = <2>;
>> +			cache-unified;
>> +			cache-size = <0x40000>;
>> +			cache-line-size = <64>;
>> +			cache-sets = <256>;
>>  		};
>>  	};
>> 

