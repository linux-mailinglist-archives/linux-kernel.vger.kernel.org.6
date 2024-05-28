Return-Path: <linux-kernel+bounces-192124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C44A8D18B0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 144B0281DE5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A14516B736;
	Tue, 28 May 2024 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LXFy8R1p"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B87213AD3E;
	Tue, 28 May 2024 10:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716892584; cv=none; b=SxX/RBYcEWqgpeIbg/ebvwZiDLNbX3aSDBkvd1y4CL6j54jsogsbTlENg9eMDtcrsZSGZBHFinE043DLUtlVLfM1xPI5Cdsom+dyEF4MOkIoXAi298ypS8kav7bEf9xgbAUgeo4FBXkGzXZfPI4vwDNJRcOIHcbf+zl3WyW1lDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716892584; c=relaxed/simple;
	bh=b3vuLqhp0ef7XqKQvTQFMeMDrvPq6HyeO8+lLKTbJSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VKxaOQ5SLf348LklIk+JSbkyV+PC8ZEVaxMIR7ed1CePmn6Gyp1KRE2YHJsZLTXxU3SgHC0xoe4hkKAZyu9CUVsT/aqyJgwZKRl1yqfb7ba+62sNjEZOQBft5GilhulvXfUq90kwlX5dVKNXYLpnAQz9mvzSrcWSlek7Z6B582I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LXFy8R1p; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716892581;
	bh=b3vuLqhp0ef7XqKQvTQFMeMDrvPq6HyeO8+lLKTbJSY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LXFy8R1p8kuFePDa1i1nalhPAAsmqdiOx83mTVivtvHTODCspq5MRcKMfAOJHe0JH
	 /q52FTKniqX1aStX8z41RvLYwHIYSAcd5BWdp67QZ9TUpvjSMuppjeKG2oasRG0wS0
	 mcsIThu5QV71DxY3WLxzq4jtEU1Ic7DVAzrnEMNhscG2AcGGLRa5bCxriAp7wyQHB/
	 /ulZioTQ7rA4BDVec9qmHnYfkSJdKJVIKlfut4gHnDbGHSvMVCkPQL+sPs3lABckJ4
	 18NHPQmHSRqwipg/xsvqor+USo01QgaOJ9DZm5duWxbk/8TUCGIuFp6DGMBcP6Fr7W
	 6OLuvV386PnTw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 752583782113;
	Tue, 28 May 2024 10:36:20 +0000 (UTC)
Message-ID: <4715d477-5f66-47db-973f-af64a3009113@collabora.com>
Date: Tue, 28 May 2024 12:36:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: mediatek: mt8188: Add support for Mali
 GPU on Panfrost
To: Julien Panis <jpanis@baylibre.com>, linux-mediatek@lists.infradead.org
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, mandyjh.liu@mediatek.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20240527093908.97574-1-angelogioacchino.delregno@collabora.com>
 <20240527093908.97574-6-angelogioacchino.delregno@collabora.com>
 <f553b3f2-d895-446a-a741-7a151ebeb3ed@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <f553b3f2-d895-446a-a741-7a151ebeb3ed@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 27/05/24 16:53, Julien Panis ha scritto:
> On 5/27/24 11:39, AngeloGioacchino Del Regno wrote:
>> Add the necessary OPP table for the GPU and also add a GPU node
>> to enable support for the Valhall-JM G57 MC3 found on this SoC,
>> using the Panfrost driver.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
> 
> [...]
> 
>> +        gpu: gpu@13000000 {
>> +            compatible = "mediatek,mt8188-mali", "arm,mali-valhall-jm";
>> +            reg = <0 0x13000000 0 0x4000>;
>> +
>> +            clocks = <&mfgcfg CLK_MFGCFG_BG3D>;
>> +            interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                     <GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                     <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            interrupt-names = "job", "mmu", "gpu";
>> +            operating-points-v2 = <&gpu_opp_table>;
>> +            power-domains = <&spm MT8188_POWER_DOMAIN_MFG2>,
>> +                    <&spm MT8188_POWER_DOMAIN_MFG3>,
>> +                    <&spm MT8188_POWER_DOMAIN_MFG4>;
>> +            power-domain-names = "core0", "core1", "core2";
> 
> Hi Angelo,
> 
> I think you should add something like that here:
> #cooling-cells = <2>;
> (the warning is raised when I run 'make dtbs_check')
> 
> Julien
> 

I can either add it to a v2 of this series, or you can add it in your patch where
you're actually adding the thermal support.

I have no preferences about who adds it, and I agree that cooling-cells should
eventually get there, so I'll leave the choice to you :-)

Cheers,
Angelo

