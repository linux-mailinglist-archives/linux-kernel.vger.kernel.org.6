Return-Path: <linux-kernel+bounces-537966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29913A492FC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1907188C78C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A039C1D63EE;
	Fri, 28 Feb 2025 08:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=freeshell.de header.i=@freeshell.de header.b="Iw+UFGMS"
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0B21D6193;
	Fri, 28 Feb 2025 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730116; cv=none; b=mSwxXW5/leCtYV/t3A1DQhEV7jNgo9AVcajaKKqSIjZDMxbE3I7fc90kKpxEqTv8PgRFlpemc0VHMfjItVHlObbbJWYzGMeaQOw5XfSESNYG0sS3g/j8PQBeTkwkOcttKspfhxpSUDR3wzsGs7BW72I/7dCNaYTNFlhLO7D03yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730116; c=relaxed/simple;
	bh=QRXY67sKFT732UFXXgYlkNi3EQgP5uLAonmdVG6CA9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MavbjP7yNc7+KeNiUZ4aM9usYKZwzKOs/paS2Ji8KLEWz+jpbiSGyXpy/XdxLhpVjiyiu4QyPZ0QqJQh/qrhA4vVBqCwkBAZbrCj9XuOY9tlraRMhLN2t2ynzFWOEfv42ShnO8rdWy1hU2EjzKM07Vc3Y6QtVFITfdd8BvtrK3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; dkim=pass (1024-bit key) header.d=freeshell.de header.i=@freeshell.de header.b=Iw+UFGMS; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from [192.168.2.35] (unknown [98.97.25.197])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 385A5B4C0BED;
	Fri, 28 Feb 2025 09:08:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
	s=mail; t=1740730109;
	bh=y3/lxwTSV3FOMdfhCnX/NXX3/QBA1di1DC9tJN9q3tM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Iw+UFGMSdNAV4OOX9Eyn601KjW8l1iL8pEUwjKZAd5xHW1CFfq8x/TYLt1BsteEcz
	 ao//xVm0pw6Fa6XSRmGD6Ofe3GnjdKEVEtSJXLihSFigfdDxH9Re+gwRtU2JVNudS6
	 nET/sK17aIo8+4CxZUqS28Hs0nOTevKkWpvihMqE=
Message-ID: <40d77aae-9e53-4981-a2aa-dcdc6f11ac83@freeshell.de>
Date: Fri, 28 Feb 2025 00:08:25 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] riscv: dts: starfive: jh7110-common: replace
 syscrg clock assignments
To: Hal Feng <hal.feng@starfivetech.com>,
 Hal Feng <hal.feng@linux.starfivetech.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Conor Dooley <conor@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <20250203013730.269558-1-e@freeshell.de>
 <20250203013730.269558-2-e@freeshell.de>
 <CAJM55Z-M9MsJAtPi-t=_tNV3oG_kdDiS6H=H3koJwTEwB8GJ-Q@mail.gmail.com>
 <981a3f30-c646-423a-a2dd-e19fef5c69e5@freeshell.de>
 <05B9953079BA21AF+fffef577-a880-4ed6-a71b-14ec82aeea97@linux.starfivetech.com>
 <b2d579e8-3535-4d7b-b0c1-8fab5fbd937f@freeshell.de>
 <ZQ2PR01MB1307DB02B26454DE62F30B24E6C4A@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <ZQ2PR01MB1307DB02B26454DE62F30B24E6C4A@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/19/25 22:38, Hal Feng wrote:
>> On 10.02.25 07:34, E Shattow wrote:
>> On 2/7/25 00:31, Hal Feng wrote:
>>> On 2/5/2025 8:52 PM, E Shattow wrote:
>>>>
>>>>
>>>> On 2/5/25 02:16, Emil Renner Berthing wrote:
>>>>> E Shattow wrote:
>>>>>> Replace syscrg assignments of clocks, clock parents, and rates with
>>>>>> default settings for compatibility with downstream boot loader SPL
>>>>>> secondary program loader.
>>>>>>
>>>>>> Signed-off-by: E Shattow <e@freeshell.de>
>>>>>> ---
>>>>>>  arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 11 ++++++++---
>>>>>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>>>>>> b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>>>>>> index 48fb5091b817..a5661b677687 100644
>>>>>> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>>>>>> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>>>>>> @@ -359,9 +359,14 @@ spi_dev0: spi@0 {  };
>>>>>>
>>>>>>  &syscrg {
>>>>>> -	assigned-clocks = <&syscrg JH7110_SYSCLK_CPU_CORE>,
>>>>>> -			  <&pllclk JH7110_PLLCLK_PLL0_OUT>;
>>>>>> -	assigned-clock-rates = <500000000>, <1500000000>;
>>>>>> +	assigned-clocks = <&syscrg JH7110_SYSCLK_CPU_ROOT>,
>>>>>> +			  <&syscrg JH7110_SYSCLK_BUS_ROOT>,
>>>>>> +			  <&syscrg JH7110_SYSCLK_PERH_ROOT>,
>>>>>> +			  <&syscrg JH7110_SYSCLK_QSPI_REF>;
>>>>>> +	assigned-clock-parents = <&pllclk JH7110_PLLCLK_PLL0_OUT>,
>>>>>> +				 <&pllclk JH7110_PLLCLK_PLL2_OUT>,
>>>>>> +				 <&pllclk JH7110_PLLCLK_PLL2_OUT>,
>>>>>> +				 <&syscrg JH7110_SYSCLK_QSPI_REF_SRC>;
>>>>>
>>>>> I think Conor asked about this too, but you still don't write why
>>>>> it's ok to drop the 500MHz and 1,5GHz assignments to the cpu-core
>>>>> and pll0 clocks respectively. You should add this to the commit message
>> itself.
>>>>>
>>>>> /Emil
>>>>
>>>> Is this a remedy for a bug in the JH7110 CPU? I'm not clear why
>>>> tweaking the frequencies and increasing core voltage was ever needed.
>>>>
>>>> This goes back to series "clk: starfive: jh7110-sys: Fix lower rate
>>>> of CPUfreq by setting PLL0 rate to 1.5GHz" [1].
>>>>
>>>> Since [1] I have had problems with several passively cooled Milk-V
>>>> Mars CM Lite systems powering off due to thermal limits. My
>>>> experience then is that the specialized 1.5GHz operation is not
>>>> appropriate for all
>>>> JH7110 CPU board layouts and applications.
>>>>
>>>> Hal says I failed to get these assignments in Linux to work in U-Boot
>>>> because U-Boot doesn't have driver support to increase CPU voltage,
>>>> and Hal offering to add this to a driver in U-Boot... but that's the
>>>> wrong way around in my opinion, unless there's some defect in the
>>>> JH7110 CPU that it won't run reliably with hardware defaults.
>>>>
>>>> 1:
>>>> https://lore.kernel.org/all/20240603020607.25122-1-xingyu.wu@starfive
>>>> tech.com/
>>>>
>>>> What is the correct thing to do here?
>>>>
>>>> -E
>>>>
>>>> From mboxrd@z Thu Jan  1 00:00:00 1970
>>>> Return-Path:
>>>> <linux-riscv-bounces+linux-riscv=archiver.kernel.org@lists.infradead.
>>>> org>
>>>> X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
>>>> 	aws-us-west-2-korg-lkml-1.web.codeaurora.org
>>>> Received: from bombadil.infradead.org (bombadil.infradead.org
>> [198.137.202.133])
>>>> 	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384
>> (256/256 bits))
>>>> 	(No client certificate requested)
>>>> 	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A24C02192
>>>> 	for <linux-riscv@archiver.kernel.org>; Wed,  5 Feb 2025 13:10:59
>>>> +0000 (UTC)
>>>> DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
>>>> 	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
>>>> 	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-
>> Help:List-Post:
>>>> 	List-Archive:List-Unsubscribe:List-Id:In-Reply-
>> To:From:References:Cc:To:
>>>> 	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-
>> ID:Content-Description:
>>>> 	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-
>> Cc:Resent-Message-ID:
>>>> 	List-Owner;
>> bh=GY86gaXkDRjEBAUNvogHkHuyO230wjLSabDM8v7zKQQ=;
>> b=Un7uhhDTAT8/9N
>>>>
>> 	FxyCZTIeuEf9Tz2EWguoSASPTIRzVsA8OD+zansoq7n0Em+ejnESLoVic
>> WRdNflaSCojelA6mxlZr
>>>>
>> 	79fy10oRgiIKMOAb1fwJcsq+rGF8jSdXwi0a2zKjGYb4u4ZNy/uLBiIynsS
>> H/VCYysTKQK6p7wAiC
>>>>
>> 	7RYsK3WfvbZKMTBmH2vKxA7ERtfZGfNAJqRjHzBM06+ZfEDf9V2UQ3p
>> GUdGPoTZYkQoS8smFEx47Z
>>>>
>> 	U3KclAiQD6NRzOmPD/VXwUGXQEpLonSaLk7kbAdo3cWww6Wyou3
>> w4XqxHQpym6FyLsKAWWSk7d4vx
>>>> 	ZbYQckPNKc65NmLst1TA==;
>>>> Received: from localhost ([::1] helo=bombadil.infradead.org)
>>>> 	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
>>>> 	id 1tffB9-00000003Lk1-2ly8;
>>>> 	Wed, 05 Feb 2025 13:10:55 +0000
>>>> Received: from freeshell.de ([2a01:4f8:231:482b::2])
>>>> 	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
>>>> 	id 1tfetw-00000003I2R-42Et
>>>> 	for linux-riscv@lists.infradead.org;
>>>> 	Wed, 05 Feb 2025 12:53:10 +0000
>>>> Received: from [192.168.2.35] (unknown [98.97.25.24])
>>>> 	(Authenticated sender: e)
>>>> 	by freeshell.de (Postfix) with ESMTPSA id 7ADA8B4C01E1;
>>>> 	Wed,  5 Feb 2025 13:53:01 +0100 (CET)
>>>> Message-ID: <981a3f30-c646-423a-a2dd-e19fef5c69e5@freeshell.de>
>>>> Date: Wed, 5 Feb 2025 04:52:59 -0800
>>>> MIME-Version: 1.0
>>>> User-Agent: Mozilla Thunderbird
>>>> Subject: Re: [PATCH v2 1/5] riscv: dts: starfive: jh7110-common:
>>>> replace  syscrg clock assignments
>>>> To: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
>>>>  Conor Dooley <conor@kernel.org>, Emil Renner Berthing
>>>> <kernel@esmil.dk>,  Rob Herring <robh@kernel.org>, Krzysztof
>>>> Kozlowski <krzk+dt@kernel.org>,  Paul Walmsley
>>>> <paul.walmsley@sifive.com>, Palmer Dabbelt  <palmer@dabbelt.com>,
>>>> Albert Ou <aou@eecs.berkeley.edu>
>>>> Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
>>>> linux-riscv@lists.infradead.org
>>>> References: <20250203013730.269558-1-e@freeshell.de>
>>>>  <20250203013730.269558-2-e@freeshell.de>
>>>>  <CAJM55Z-M9MsJAtPi-t=_tNV3oG_kdDiS6H=H3koJwTEwB8GJ-
>> Q@mail.gmail.com>
>>>> Content-Language: en-US
>>>> From: E Shattow <e@freeshell.de>
>>>> In-Reply-To:
>>>> <CAJM55Z-M9MsJAtPi-t=_tNV3oG_kdDiS6H=H3koJwTEwB8GJ-
>> Q@mail.gmail.com>
>>>> X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) )
>>>> MR-646709E3
>>>> X-CRM114-CacheID: sfid-20250205_045309_156119_468548BF
>>>> X-CRM114-Status: GOOD (  16.14  )
>>>> X-BeenThere: linux-riscv@lists.infradead.org
>>>> X-Mailman-Version: 2.1.34
>>>> Precedence: list
>>>> List-Id: <linux-riscv.lists.infradead.org>
>>>> List-Unsubscribe:
>>>> <http://lists.infradead.org/mailman/options/linux-riscv>,
>>>>  <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
>>>> List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
>>>> List-Post: <mailto:linux-riscv@lists.infradead.org>
>>>> List-Help:
>>>> <mailto:linux-riscv-request@lists.infradead.org?subject=help>
>>>> List-Subscribe:
>>>> <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
>>>>  <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
>>>> Content-Type: text/plain; charset="us-ascii"
>>>> Content-Transfer-Encoding: 7bit
>>>> Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
>>>> Errors-To:
>>>> linux-riscv-bounces+linux-riscv=archiver.kernel.org@lists.infradead.o
>>>> rg
>>>>
>>>>
>>>>
>>>> On 2/5/25 02:16, Emil Renner Berthing wrote:
>>>>> E Shattow wrote:
>>>>>> Replace syscrg assignments of clocks, clock parents, and rates with
>>>>>> default settings for compatibility with downstream boot loader SPL
>>>>>> secondary program loader.
>>>>>>
>>>>>> Signed-off-by: E Shattow <e@freeshell.de>
>>>>>> ---
>>>>>>  arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 11 ++++++++---
>>>>>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>>>>>> b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>>>>>> index 48fb5091b817..a5661b677687 100644
>>>>>> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>>>>>> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>>>>>> @@ -359,9 +359,14 @@ spi_dev0: spi@0 {  };
>>>>>>
>>>>>>  &syscrg {
>>>>>> -	assigned-clocks = <&syscrg JH7110_SYSCLK_CPU_CORE>,
>>>>>> -			  <&pllclk JH7110_PLLCLK_PLL0_OUT>;
>>>>>> -	assigned-clock-rates = <500000000>, <1500000000>;
>>>>>> +	assigned-clocks = <&syscrg JH7110_SYSCLK_CPU_ROOT>,
>>>>>> +			  <&syscrg JH7110_SYSCLK_BUS_ROOT>,
>>>>>> +			  <&syscrg JH7110_SYSCLK_PERH_ROOT>,
>>>>>> +			  <&syscrg JH7110_SYSCLK_QSPI_REF>;
>>>>>> +	assigned-clock-parents = <&pllclk JH7110_PLLCLK_PLL0_OUT>,
>>>>>> +				 <&pllclk JH7110_PLLCLK_PLL2_OUT>,
>>>>>> +				 <&pllclk JH7110_PLLCLK_PLL2_OUT>,
>>>>>> +				 <&syscrg JH7110_SYSCLK_QSPI_REF_SRC>;
>>>>>
>>>>> I think Conor asked about this too, but you still don't write why
>>>>> it's ok to drop the 500MHz and 1,5GHz assignments to the cpu-core
>>>>> and pll0 clocks respectively. You should add this to the commit message
>> itself.
>>>>>
>>>>> /Emil
>>>>
>>>> Is this a remedy for a bug in the JH7110 CPU? I'm not clear why
>>>> tweaking the frequencies and increasing core voltage was ever needed.
>>>>
>>>> This goes back to series "clk: starfive: jh7110-sys: Fix lower rate
>>>> of CPUfreq by setting PLL0 rate to 1.5GHz" [1].
>>>>
>>>> Since [1] I have had problems with several passively cooled Milk-V
>>>> Mars CM Lite systems powering off due to thermal limits. My
>>>> experience then is that the specialized 1.5GHz operation is not
>>>> appropriate for all
>>>> JH7110 CPU board layouts and applications.
>>>>
>>>> Hal says I failed to get these assignments in Linux to work in U-Boot
>>>> because U-Boot doesn't have driver support to increase CPU voltage,
>>>> and Hal offering to add this to a driver in U-Boot... but that's the
>>>> wrong way around in my opinion, unless there's some defect in the
>>>> JH7110 CPU that it won't run reliably with hardware defaults.
>>>>
>>>> 1:
>>>> https://lore.kernel.org/all/20240603020607.25122-1-xingyu.wu@starfive
>>>> tech.com/
>>>>
>>>> What is the correct thing to do here?
>>>
>>> Please see my reply in
>>>
>> https://lore.kernel.org/all/ZQ2PR01MB130736F5C893337606FD6937E6F1A@
>> ZQ2
>>> PR01MB1307.CHNPR01.prod.partner.outlook.cn/
>>>
>>> Thanks.
>>>
>>> Best regards,
>>> Hal
>>>
>>
>> What is the explanation to remove the (hardware default) CPU power supply
>> 0.9V operation, and remove hardware default CPU speed?
>>
>> I would think you will want jh7110.dtsi similar as follows:
>>
>>         cpu_opp: opp-table-0 {
>>                         compatible = "operating-points-v2";
>>                         opp-shared;
>>                         opp-250000000 {
>>                                         opp-hz = /bits/ 64 <250000000>;
>>                                         opp-microvolt = <800000>;
>>                         };
>>                         opp-333000000 {
>>                                         opp-hz = /bits/ 64 <333000000>;
>>                                         opp-microvolt = <800000>;
>>                         };
>>                         opp-375000000 {
>>                                         opp-hz = /bits/ 64 <375000000>;
>>                                         opp-microvolt = <800000>;
>>                         };
>>                         opp-500000000 {
>>                                         opp-hz = /bits/ 64 <500000000>;
>>                                         opp-microvolt = <800000>;
>>                         };
>>                         opp-750000000 {
>>                                         opp-hz = /bits/ 64 <750000000>;
>>                                         opp-microvolt = <800000>;
>>                         };
>>                         opp-1000000000 {
>>                                         opp-hz = /bits/ 64 <1000000000>;
>>                                         opp-microvolt = <900000>;
>>                         };
>>                         opp-1500000000 {
>>                                         opp-hz = /bits/ 64 <1500000000>;
>>                                         opp-microvolt = <1040000>;
>>                         };
>>         };
> 
> This method doesn't make sense, because the division factor is an integer
> and changing clock pll0 frequently may cause errors.
> 
>>
>> I guess at the voltages here, you will have to provide a correction about what
>> is realistic.
>>
>> Board makers are designing their board layout with opp-1000000000 default
>> voltage with default clock frequency and not opp-1500000000 on an
>> increased voltage and maximum clock speed yes?
> 
> No, default CPU supply voltage or frequency were never designed for the board
> and JH7110 SoC. The default voltage I said in [1] means the default output voltage
> of PMIC AXP15060. When the board is powered up, the CPU supply which comes
> from PMIC is 0.9V, so the CPU can just run at 1.0GHz or lower. After that, the board
> can run at other frequency if the CPU supply voltage, pll0 clock frequency, division
> factor are set correctly. 1.5GHz is a stable frequency to run. We had done a lot of test
> at this frequency. Actually, JH7110 can even run at 1.75GHz, but that is not stable.
> 
> [1] https://lore.kernel.org/all/ZQ2PR01MB130736F5C893337606FD6937E6F1A@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn/
> 
>>
>> We should not exceed the hardware default CPU voltage (and clock
>> frequency) for all boards without some very good reason, and I do not accept
>> "because more voltage and higher frequency is faster" to be a reason to do
>> this.
>>
>> Hal, you have not explained why it is *necessary* to have this non-default
>> voltage and clock frequency table for all boards. I know that using a JH7110
>> board that allows 1.5GHz operation results in thermal over-temperature and
>> shutdown, where it then does no work at all and is not useful to me. I do
> 
> Really? Could you please give more detail to us? Thanks for your feedback.
> We had tested 1.5GHz under large loads many times and running at 1.5GHz is
> the requirement from some developers, so we upstreamed it before.
> 
>> accept that you want 1.5GHz operation, for a specific board that is no problem
>> with me because I do not have that board to test if it is any problem; I have to
>> trust that you have done this testing, then.
>>
>> Summary of my thoughts are:
>>
>> 1. Yes to support for lower and higher core voltage and clock frequency
>>
>> 2. No to imposing non-default hardware profiles on all boards, unless there is
>> some actual reason why it is strictly necessary (thermal performance testing,
>> operational stability, power savings, ...)
> 
> If some boards can't run at 1.5GHz, we can move node opp-table-0 to the
> board device tree from jh7110.dtsi. Then each board can set its own CPU
> frequency.
> 
> Best regards,
> Hal
> 
>>
>> Question follow-up:
>>
>> 1. Can we restore 1GHz operation ?  I ask if there is a property or strategy
>> here to force 1GHz maximum operation unless the user decides for exceeding
>> the hardware default 0.9V ?
>>
>> -E

I apologize Hal, this topic is more in-depth than my basic understanding
about hardware design. Can we make this so we have six runtime
frequencies around the manufacturer StarFive suggestion of 1.5GHz?:

250MHz
500MHz
750MHz
1GHz
1.25GHz
1.5GHz
1.75GHz (seven? you say this doesn't work well though.)

Is 250MHz stable?

I hear you say that it is an integer division, okay. How about a
multiplier up from 250MHz though? That is a bad suggestion?

If you can be kind and explain to me - (I am dumb about this topic but
I do want to learn) - and explain what is the limitation why this is an
integer division and not a multiplier?

I've been asking other people in my peer group and none have this
knowledge, so I do need help with this because your explanation is clear
but lacks the basic theory which I did not learn yet (and no one I know
has this knowledge either).

-E

