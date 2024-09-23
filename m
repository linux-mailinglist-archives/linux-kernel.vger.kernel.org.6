Return-Path: <linux-kernel+bounces-335849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4C097EB79
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F681F21C7E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A07198826;
	Mon, 23 Sep 2024 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Tj/L4nvR"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B966E195B14;
	Mon, 23 Sep 2024 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727094313; cv=none; b=erdPkMrWxTzSNyp+gAhospmI4QhrqNapgKlAiPYGF5SmOgL2Uqt1hkpCw8g18fHzFDGvt7I3whRRuyBY47TFgQgqQ9rNoE6vVN3YnNXPO55KjjiYdX18WT3+YVvxX/R31GCKm2FBPEoiIgtEW1UVbiHPSRwzw37+viTPULPzcUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727094313; c=relaxed/simple;
	bh=oVnappwI2asg1Mmf+oMcKojkg9+Z0J7WmOxhJWSM3kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UsGAD2KnKSWsSxZ4WrEQ8pfNVupEAVxhnafJ4mLJ2o45LkxrIZvppKb8xpJoA78F2LeKJReNcc3BomtoLFTlnHp7UDkyL5UQeSNTkPBNngIB1N/6KNJXljevmmZx4MpewxN5hWx1cN7h1IoFPA63tlvQP+3tANFoetLVxjP1vL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Tj/L4nvR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727094309;
	bh=oVnappwI2asg1Mmf+oMcKojkg9+Z0J7WmOxhJWSM3kc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Tj/L4nvRSp5Oa5oywuog3blCYKnRcOhvwJvam8UXfvTh1zG0pASOMhRoDtDkiGfqO
	 pB6vekai1WFqwSw3bww3yvYXWjavV6cR/8bTXfAUex/Zuvw2K6uvq3HAwegPKO3M9i
	 DNjlEJLMjzrbxxnmHjsk1zEV8/T2cuyQbAombyyddafGJMMIcEjsPBlC6eUHTvdDLn
	 TfP1T2k5CDNte7JF9YXwQ4e7QfHt0kXR7FY8B95H8Wi3xWZ9IInMzsEUPSyJG6P+GI
	 y+fxOvLEU486ptT4KFrQlH3ZZsyZvZ/wPmXbQrMWncY3tYS1XeBB53x+mItSG24WP2
	 1Q7KulaV9+G7A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7E36817E121B;
	Mon, 23 Sep 2024 14:25:09 +0200 (CEST)
Message-ID: <228c9508-76c3-4772-bf0a-56e85a47af78@collabora.com>
Date: Mon, 23 Sep 2024 14:25:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: mediatek: mt8390-genio-700-evk: Enable
 Mali GPU
To: Pablo Sun <pablo.sun@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-clk@vger.kernel.org
References: <20240920134111.19744-1-pablo.sun@mediatek.com>
 <20240920134111.19744-6-pablo.sun@mediatek.com>
 <eb17085d-78ff-4833-a4de-17b9327d776c@collabora.com>
 <bf45531a-eacf-22a9-65f1-f6474a2ca843@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <bf45531a-eacf-22a9-65f1-f6474a2ca843@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/09/24 12:14, Pablo Sun ha scritto:
> Hi Angelo,
> 
> On 9/23/24 16:45, AngeloGioacchino Del Regno wrote:
> [snipped]
>>
>> Is there any real difference between MT8390 and MT8188 in terms of the GPU OPPs?
>>
>> I see that on MT8188, frequencies up to 880MHz want a DVDD_SRAM_GPU of 0.750V,
>> then 0.775/0.762/0.750 (bin1-4/5/6) on 915MHz, and 0.800/0.775/0.750 (bin1-4/5/6)
>> on 950MHz.
>>
>> Those never call for 0.850V...! So is MT8188 (Chromebooks) wrong, or is MT8390
>> different in that?
> 
> To the best of my knowledge, MT8390 and MT8188 has identical GPU
> subsystem. Thus, the OPP table should have no difference.
> 
> To be specific, I list the link to the OPP table of Genio 700 EVK
> (MT8390) in reference in [1]. It should match the setting in Chromebook
> kernel branches.
> 
> The "typical" voltage in the datasheet is the voltage that would work
> for all frequency settings. As long as it is smaller than the maximum
> operating voltage, setting voltages higher than the ones specified in
> the OPP table does not damage the hardware.
> 
> But this 0.85V setting is indeed not optimal. We should follow the
> voltages described in the OPP table, if we want power savings.
> 
> I also considered model the regulator setting with 'regulator-coupled-with' and 
> 'regulator-coupled-max-spread', but I am not entirely sure how to describe the 
> relation that "DVDD_GPU_SRAM should follow DVDD_GPU
> if and only if DVDD_GPU is higher than 0.75V" - should I simply
> set min-voltage to 0.75V and set 'regulator-coupled-with' ?
> 

VSRAM_GPU regulator:

	regulator-min-microvolt = <750000>;
	regulator-max-microvolt = <800000>;
	regulator-coupled-with = <&(vgpu regulator)>;
	regulator-coupled-max-spread = <1000>;

VGPU regulator:
	regulator-min-microvolt = <400000>;
	regulator-max-microvolt = <800000>;
	regulator-coupled-with = <&(vsram_gpu regulator)>;
	regulator-coupled-max-spread = <1000>;

Cheers,
Angelo

> [1]: 
> https://gitlab.com/mediatek/aiot/rity/meta-mediatek-bsp/-/blob/kirkstone/recipes-kernel/dtbo/mt8390/gpu-mali.dts
> 
> Many thanks,
> Pablo
> 




