Return-Path: <linux-kernel+bounces-444611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BA79F098F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DADFA160681
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380951B982C;
	Fri, 13 Dec 2024 10:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="S4bN2vIn"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC301B3958;
	Fri, 13 Dec 2024 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734085986; cv=none; b=DbsA4Fk2uUWLnC2FcGTfI8VL0Hvv7ZSFRQoQh+/Y3c9a6orkoD5pimcxm8T1x521dmF6IqlJ/sb6t6ZuCwtdqyB7hVZflNpGn5yBQljeETlZIQJUd4NEgHSBBZWOvOcitHsvlNEhENkSKgoGs3hRN/Q6qVB5YTAQThhouY3Scig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734085986; c=relaxed/simple;
	bh=ApsrYFswezGftMuwmeTEeSUOM/0FX0NYslGs2NfWs0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9LznlzLJvNAGNvkcjp6AiXXGkLrjc0N4DWLJ/6vqn2eRP+SWO/Fka6se1j3RGT4fpgpdNa/YRkI4K2HMJPoW10k9VRbZvC+RNnk1pUDcJUv1cwuKsRoaXYIroEMXgyTFVoiZaEigmaf/7c6SK/HATCdt4DBSuQlLjqFmhWHLME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=S4bN2vIn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734085982;
	bh=ApsrYFswezGftMuwmeTEeSUOM/0FX0NYslGs2NfWs0A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S4bN2vIn3fGXb5uMGXT0vcyMbMw3mhQFzQZojR301P8vZS9U28S7S3EUbZnggWInf
	 ReLSvhnbcbTXwl1X43tNyQSV1AjUFEtU/z1PS4t8rvL/O2htkfPu+WYdbxXue8MTOj
	 948x6TUMPeUJil2itKHbFYBg79Qve/EdnetOQ+aR3VQ6ezzc/gaosjIxNtH7K6Wyj3
	 uckNr+NcwYacsFRb4zutjG/sw4YDgoStxcCxAvEc8BrBDPs9Uqnvi6riCNKf7lBfZu
	 Jnlbh3vEqAEvjsa5OCOYfzPrg3CpUBLI0kM/logl8RF+WL5fO9++Fk1eW56v1BavOx
	 Lr+tx/BsNwjdQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C203117E360E;
	Fri, 13 Dec 2024 11:33:01 +0100 (CET)
Message-ID: <e1909a09-f871-4c8b-825e-835605ff92a5@collabora.com>
Date: Fri, 13 Dec 2024 11:33:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dts: arm64: mediatek: mt8188: Update OVL
 compatible from MT8183 to MT8195
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
 <20241213095044.23757-3-jason-jh.lin@mediatek.com>
 <CAEXTbpcp31oWOCh2c41QbWOc5F_gpD1Bia0NiZeVyDbqKo98Lw@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAEXTbpcp31oWOCh2c41QbWOc5F_gpD1Bia0NiZeVyDbqKo98Lw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 13/12/24 11:26, Pin-yen Lin ha scritto:
> Hi Jason,
> 
> On Fri, Dec 13, 2024 at 5:50 PM Jason-JH.Lin <jason-jh.lin@mediatek.com> wrote:
>>
>> The OVL hardware capabilities have changed starting from MT8195,
>> making the MT8183 compatible no longer applicable.
>> Therefore, it is necessary to update the OVL compatible from MT8183 to
>> MT8195.
> 
> This probably doesn't need an (immediate) respin, but this patch needs:
> 
> Fixes: 7075b21d1a8e ("arm64: dts: mediatek: mt8188: Add display nodes
> for vdosys0")

No, because the binding must otherwise get a Fixes tag.

This is not a fix anyway, and is technically adding new features to the MT8188
OVL; without the additional features, the MT8188 is still compatible with the
MT8183 OVL, as much as MT8195.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

>>
>> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8188.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
>> index faccc7f16259..23ec3ff6cad9 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
>> @@ -2488,7 +2488,7 @@ jpeg_decoder: jpeg-decoder@1a040000 {
>>                  };
>>
>>                  ovl0: ovl@1c000000 {
>> -                       compatible = "mediatek,mt8188-disp-ovl", "mediatek,mt8183-disp-ovl";
>> +                       compatible = "mediatek,mt8188-disp-ovl", "mediatek,mt8195-disp-ovl";
>>                          reg = <0 0x1c000000 0 0x1000>;
>>                          clocks = <&vdosys0 CLK_VDO0_DISP_OVL0>;
>>                          interrupts = <GIC_SPI 636 IRQ_TYPE_LEVEL_HIGH 0>;
>> --
>> 2.43.0
>>
> 
> Regards,
> Pin-yen


