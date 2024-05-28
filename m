Return-Path: <linux-kernel+bounces-192775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A87F88D21E1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36EB61F22B79
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAAD173337;
	Tue, 28 May 2024 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ydiItdTX"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6238D172BD5;
	Tue, 28 May 2024 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914826; cv=none; b=j8wqtf7o2X67vIOz8GK2pHR12rtAtj3qguEBoUKELg98g0LUcIzST+H9TNnQJisv1c5q9ZDoQY3Hs3HRHv5+noz85OTpFDmHFO5uaZgNlQsDb9FSOncP8xGY0xG4V1d2jMLMxw1r+xoRbaycJGKntHVgM6daW9crtsNVt2/HoSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914826; c=relaxed/simple;
	bh=9f98Kmm3d3bSNYMIWqiavWx9R40hd/YbT2c4KoMgECA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tl39mYyU6A/DGd0h2UdYF8sASWOEAdU7sDnIj3jW+EVDl27su+WeN3BGnd98udB6Z59MlePowlG1kPBiWS1L2QXyGwsQGPRDYqSQE6c+B2cys5CPIfprWbuUjfbKODPL3YdYWwgVPdux+tVrs1uuWQ2TgsYWsw/dvnie8Bl6jZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ydiItdTX; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716914822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mewpeG/oQrRUoqEYjnpfCeHsOPPX6uge+W3bTrG1cqw=;
	b=ydiItdTXF2o462cyuK3OiiVo/UBHUxzUxBGNTKrdPDVhjHWbBuIAO0BTEemm+b0anubWhU
	iAeUVUoN45JUmzx4SHGpkUvjeMLsp5m+ElPQj4fA2V3kk0QVvlyWt8ohFfyQgcab5Dx+WM
	645w/4WgNkVNcbAICbJ1sJB4dgfgWFdpa6fuI3LWc34pmPbNAm13xV2iwxBWGAx0VGwQ3f
	hA85QiAE11EKPLsSvdBqIetuZmmqiWxtySyTXOIs761ytCBiYzs3XgO8NoWLDxepv7elZF
	7cgMGqs6KnHi+Dj9Et4cqDqfbi3iuUmi+Tb+hws+DYglUoS9WlrpEpwasYiGkw==
Date: Tue, 28 May 2024 18:47:02 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: wens@csie.org
Cc: linux-sunxi@lists.linux.dev, jernej.skrabec@gmail.com,
 samuel@sholland.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org, Andre Przywara
 <andre.przywara@arm.com>
Subject: Re: [PATCH] arm64: dts: allwinner: Add cache information to the SoC
 dtsi for H616
In-Reply-To: <CAGb2v67_4MHEZned0X1sFxisySahemHYo6sjn9sttQY+RO=VQw@mail.gmail.com>
References: <9d52e6d338a059618d894abb0764015043330c2b.1714727227.git.dsimic@manjaro.org>
 <CAGb2v67_4MHEZned0X1sFxisySahemHYo6sjn9sttQY+RO=VQw@mail.gmail.com>
Message-ID: <252b1cc5a04fb5d3703388df1470b9b3@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-28 18:08, Chen-Yu Tsai wrote:
> On Fri, May 3, 2024 at 5:09 PM Dragan Simic <dsimic@manjaro.org> wrote:
>> 
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
>> 
>> The changes introduced to the H616 SoC dtsi by this patch specify 256 
>> KB as
>> the L2 cache size.  As outlined by Andre Przywara, [2] a follow-up 
>> TF-A patch
>> will perform runtime adjustment of the device tree data, making the 
>> correct
>> L2 cache size of 1 MB present in the device tree for the boards based 
>> on the
>> revision of H616 that actually provides 1 MB of L2 cache.
>> 
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
>>                         reg = <0>;
>>                         enable-method = "psci";
>>                         clocks = <&ccu CLK_CPUX>;
>> +                       i-cache-size = <0x8000>;
>> +                       i-cache-line-size = <64>;
>> +                       i-cache-sets = <256>;
>> +                       d-cache-size = <0x8000>;
>> +                       d-cache-line-size = <64>;
>> +                       d-cache-sets = <128>;
>> +                       next-level-cache = <&l2_cache>;
> 
> This no longer applies due to the CPU DVFS stuff getting merged.
> Can you rebase and resend?

Sure, just sent the rebased version as the v2. [1]

[1] 
https://lore.kernel.org/linux-sunxi/e4b9cc3e3d366a571e552c31dafa5de847bc1c12.1716914537.git.dsimic@manjaro.org/

