Return-Path: <linux-kernel+bounces-216989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAAE90A96D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 676B2B2E870
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B0919309C;
	Mon, 17 Jun 2024 09:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Kkao4Wws"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A090B191499;
	Mon, 17 Jun 2024 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615809; cv=none; b=Or4wX2CrLomWMqZkqeHzLldJmrx85whygjPzHZp2TudCdHAj/BOU+kw0Mo6Per5i/XdIebnXYXHYwUxhoNdn6U25jM2GdlFiLsENx1JFFSNSj8G8MIJfRU3Wt8GHVBnuklWADDKEvWiSW2udnpn6ySyHJMlc1CyxYqVhZKIpinU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615809; c=relaxed/simple;
	bh=Vpr+wMRG2V0VYI/abS+c/Zr6kX377Gfc2/aC8MAVBUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eW4p9R32XfeEozLskuh7R30mpebM6Ng2B3YQwjzljlMESAmFQhYZIUsVV+NxuVXDFsUEk4PFIg0XhkbGeMr4yjHf+Cu2CEOJTHAMakN9PRS5JAYVou9FM4aSI1XNx3QH7TslGgPR8VfLO+WAGm4AjleVL37OlPLd/ANje1zhDdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Kkao4Wws; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 53061FF804;
	Mon, 17 Jun 2024 09:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718615797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hWiLB1H/el64qMPYokxKIuSo3yitbl9iDJ4QLffkaTM=;
	b=Kkao4WwsvjbCNWSEo1UTINUchJhVT+f/G3cY4QYNPK0h1XWnIHuanNcbPmm8oc3UfiQp3G
	MaEEKqw7Tne7mFSyz3Q2WqvguQd/sbEhvlBJBG1917rfvb2w3pAIQSFmIK9lRkh9JiXDho
	+kbm2cXY8gol3ubTrKgsySjvYeRPr4Vg3wwUjRE/F/SAbM3OX8Ec63toljJb5ZuIS4o+bA
	uNSkjrhxtqD3f9Y6BBV15BuX89QE8vtsbO0jBGysCbt0V7CCzuw0othg9vtWzeor+1sGwy
	brPnaujQcOB1JjqCh6nuyHNRNt4AtywZ2nFrgNbQIwhRVTkOPU/xbvE+4LS5qw==
Message-ID: <c75601a1-1389-400e-90b9-99c1e775a866@bootlin.com>
Date: Mon, 17 Jun 2024 11:16:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] riscv: dts: sophgo: Put sdhci compatible in dt of
 specific SoC
To: Yixun Lan <dlan@gentoo.org>, Inochi Amaoto <inochiama@outlook.com>
Cc: Jisheng Zhang <jszhang@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Chen Wang <unicorn_wang@outlook.com>, Chao Wei <chao.wei@sophgo.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20240612-sg2002-v2-0-19a585af6846@bootlin.com>
 <20240612-sg2002-v2-1-19a585af6846@bootlin.com>
 <IA1PR20MB49534C9E29E86B478205E4B3BBC02@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240616235829.GA4000183@ofsar>
Content-Language: en-US
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
In-Reply-To: <20240616235829.GA4000183@ofsar>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.bonnefille@bootlin.com



On 6/17/24 1:58 AM, Yixun Lan wrote:
> Hi
> 
> On 18:47 Wed 12 Jun     , Inochi Amaoto wrote:
>> On Wed, Jun 12, 2024 at 10:02:31AM GMT, Thomas Bonnefille wrote:
>>> Remove SDHCI compatible for CV1800b from common dtsi file to put it in
>>> the specific dtsi file of the CV1800b.
>>> This commits aims at following the same guidelines as in the other nodes
>>> of the CV18XX family.
> is there any URL of guideline? or did I miss anything
> couldn't find any discussion about this in v1
> 

Not explicitly, the fact is that I had to use a specific compatible on 
SG2002 for the sdhci (it is already defined mainline), I had to choose 
between :

1. cv18xx.dtsi : compatible cv1800b-dwcmshc
    cv1800b.dtsi : no redefined compatible
    sg2002.dtsi : overwrite the previous compatible to use sg2002-dwcmshc

2. cv18xx.dtsi : no compatible
    cv1800b.dtsi : compatible for cv1800b-dwcmshc
    sg2002.dtsi : compatible for sg2002-dwcmshc

As in the plic and clint controllers, the second option was chosen I 
consider this as a "guideline" and reformat the dtsis accordingly.

>>>
>>> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
>>> ---
>>>   arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 4 ++++
>>>   arch/riscv/boot/dts/sophgo/cv18xx.dtsi  | 1 -
>>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
>>> index ec9530972ae2..b9cd51457b4c 100644
>>> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
>>> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
>>> @@ -25,3 +25,7 @@ &clint {
>>>   &clk {
>>>   	compatible = "sophgo,cv1800-clk";
>>>   };
>>> +
>>> +&sdhci0 {
>>> +	compatible = "sophgo,cv1800b-dwcmshc";
>>> +};
>>> diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
>>> index 891932ae470f..7247c7c3013c 100644
>>> --- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
>>> +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
>>> @@ -288,7 +288,6 @@ uart4: serial@41c0000 {
>>>   		};
>>>   
>>>   		sdhci0: mmc@4310000 {
>>> -			compatible = "sophgo,cv1800b-dwcmshc";
>>>   			reg = <0x4310000 0x1000>;
>>>   			interrupts = <36 IRQ_TYPE_LEVEL_HIGH>;
>>>   			clocks = <&clk CLK_AXI4_SD0>,
>>>
>>> -- 
>>> 2.45.2
>>>
>>
>> Hi, Jisheng,
>>
>> Is this change necessary? IIRC, the sdhci is the same across
>> the whole series.
> I tend to agree with Inochi here, if it's same across all SoC, then no bother to
> split, it will cause more trouble to maintain..
> 

To be honest, I agree with this to, but as a specific compatible for the 
SG2002 was created in commit 849e81817b9b, I thought that the best 
practice was to use it.

>>
>> Regards,
>> Inochi
> 

