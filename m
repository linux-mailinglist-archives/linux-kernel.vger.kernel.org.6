Return-Path: <linux-kernel+bounces-444612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8EB9F0991
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8931613FB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6151C0DF0;
	Fri, 13 Dec 2024 10:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ryhuf5kI"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B42E1BAEFD;
	Fri, 13 Dec 2024 10:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734085989; cv=none; b=jsVCRQ+b63QzRCMUw/3pbxj25Z4Y52q1Zp2AKuizK3FO4GAfSc8vqk7IHNMym/mlD6oxZDWtPF+A/lC2cygmkXHe04BFbhp23dhCtRG0k5uTtqInKF4U2nAouPNpYGYS2oWpM66pX2u1h/ncMp63DyusFj2KQunMUAwVu5VLRTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734085989; c=relaxed/simple;
	bh=yx1so4SVqMJRI+3G1bJUtF2KS6HaHhebzPeIaKasoZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PxNpWitCakUAEzW4WWTGDr2FwTJYjdBVPnJGmNMDBILAR5gF6HDzsE0K70rjQkuWQDwForlwnC1CG0N/ytT15oT63OLpo5l/f0Nh/nCmhOJ8wO6UOV88bUzFYffffcuIbWfPtweI41tGOEQ2FYGOGoXd73H9Di3wxQP7fUOhzCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ryhuf5kI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734085985;
	bh=yx1so4SVqMJRI+3G1bJUtF2KS6HaHhebzPeIaKasoZE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ryhuf5kIIPp+ofnHBbFh6PFetgQYqNWjnSfZ53iZlSYOF/9f5Ug3yaysVeygh3n4f
	 +6Znj4Wr8YzNoxfFNb+7WTJ2dnBFFu8C9+aMh6b/3pdKIcYyfnjKYeRz58K7OEH5wv
	 K1VoxQkEYa4lOVdHXnZlwMs00EqequPJNHJ2hMtlXcHsT2+0OTgEiWFTVm1KkE7Kg0
	 rZ9MZpGHdVZUTyjvtvUKFDwZCCc6tVLYZgID//UEJ/DWTe8TO/5rADt/2Z3x3+roAe
	 QhtFNu65WKLEdCtcolwoyQRBq+yJMjhhp6TYEUrw+vpcogRtvO/UhoDsY6+OxBmSh7
	 vG9UxhOHmGGMg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 83FCF17E3610;
	Fri, 13 Dec 2024 11:33:04 +0100 (CET)
Message-ID: <980d28d6-52f0-4430-954b-da673fcd92df@collabora.com>
Date: Fri, 13 Dec 2024 11:33:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] dts: arm64: mediatek: mt8195: Remove MT8183
 compatible for OVL
To: Pin-yen Lin <treapking@chromium.org>,
 "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
 Shawn Sung <shawn.sung@mediatek.com>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 Fei Shao <fshao@chromium.org>
References: <20241213095044.23757-1-jason-jh.lin@mediatek.com>
 <20241213095044.23757-4-jason-jh.lin@mediatek.com>
 <CAEXTbpfOv876s3NLTO3oMTtVi_BwBtgb-816Gt5ZjKMjTZZKQg@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAEXTbpfOv876s3NLTO3oMTtVi_BwBtgb-816Gt5ZjKMjTZZKQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 13/12/24 11:27, Pin-yen Lin ha scritto:
> Hi Jason,
> 
> On Fri, Dec 13, 2024 at 5:50 PM Jason-JH.Lin <jason-jh.lin@mediatek.com> wrote:
>>
>> The OVL hardware capabilities have changed starting from MT8195,
>> making the MT8183 compatible no longer applicable.
>> Therefore, it is necessary to remove the MT8183 compatible for OVL.
> 
> Similar to patch 2/3, we need a:
> 
> Fixes: b852ee68fd72 ("arm64: dts: mt8195: Add display node for vdosys0")
> 

No, we don't, for reasons that are similar to the ones that I explained in the
MT8188 commit.

Besides, this one was already featureful before this commit, so really this is
not worth backporting at all.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

>>
>> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>> index ade685ed2190..137ee8929e01 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>> @@ -3138,7 +3138,7 @@ larb20: larb@1b010000 {
>>                  };
>>
>>                  ovl0: ovl@1c000000 {
>> -                       compatible = "mediatek,mt8195-disp-ovl", "mediatek,mt8183-disp-ovl";
>> +                       compatible = "mediatek,mt8195-disp-ovl";
>>                          reg = <0 0x1c000000 0 0x1000>;
>>                          interrupts = <GIC_SPI 636 IRQ_TYPE_LEVEL_HIGH 0>;
>>                          power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
>> --
>> 2.43.0
>>
> 
> Regards,
> Pin-yen



