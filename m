Return-Path: <linux-kernel+bounces-443425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 139429EF004
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 479351888F4D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B37231A27;
	Thu, 12 Dec 2024 16:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TLW5LTOp"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1F12309BA;
	Thu, 12 Dec 2024 16:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019541; cv=none; b=OqUSLDLT/yRvD3TugdZ4g7Fknxpbx7LJo9bKFVXP8bWRfUQXoBY1vZL36XsGREnvOKmpVM/wqLhfroD1fxY0DbMhtodCT0TDB+DN9bzSSF8Aqlsi0hxMdI1/7UB0rIU2G3yIhV2A0cOIJiZ7HVmzYTdy1SPlFztnUhaytG/M4Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019541; c=relaxed/simple;
	bh=J1scdp67Yf0dN731s+TeIiFUh/val29sz3XZEjfTzxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=umfPNqSsXEu46oNQmTRzNWFz+bqWuxApw9yTpCpWbwZLKkx4PNnul9YKNNGfU/e7hzg4djSkkzE1tv4CmDz5Q8fZtv+V6oNyByOU5Jc1V5z6DFLk/Mu2E9i+RedmztKiPXOhdLsK/2W13GM6KLxA0dj1iGv0L1OyPO3Q3amG6wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TLW5LTOp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734019537;
	bh=J1scdp67Yf0dN731s+TeIiFUh/val29sz3XZEjfTzxU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TLW5LTOpDIKHws5iJ9xFtxE1SpY4vug6sm8YNGS9UMeD/RRqKXzTAAtKX20365AJh
	 kILazhLvIPfBGbHfUhkqqWlYRkMyX87RVJY6maxF5yVxSg0qzxMMnqywXWBqdGdtMM
	 L1wKaWDqLDWhCzJ9zS7wvrLU48dloqzWKKFjqumNdiNkF1nvBEAK4BjAoWtvXB2HuY
	 SZFeZAfjqFp8elCWJTxyvNMYMd89BIcZRkkrYwl3mSC6m1xXhK3QhA2nMHECjSTJev
	 TFgFupVDtvA6s9cAe6sZ0iFiJ3oo0P3EaGbrhYcgCqrzramOKQHrjReMSuwLpg09Ah
	 Cqt0DYXeNJ9AA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C079417E37A4;
	Thu, 12 Dec 2024 17:05:36 +0100 (CET)
Message-ID: <6710abd1-128d-48ff-84a1-880053fd9e84@collabora.com>
Date: Thu, 12 Dec 2024 17:05:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dts: arm64: mediatek: mt8188: Update OVL compatible
 from MT8183 to MT8195
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
 Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
 Shawn Sung <shawn.sung@mediatek.com>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 Fei Shao <fshao@chromium.org>
References: <20241212153344.27408-1-jason-jh.lin@mediatek.com>
 <20241212153344.27408-3-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241212153344.27408-3-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 12/12/24 16:33, Jason-JH.Lin ha scritto:
> The OVL hardware capabilities have changed starting from MT8195,
> making the MT8183 compatible no longer applicable.
> Therefore, it is necessary to update the OVL compatible from MT8183 to
> MT8195.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Jason, just so you know - I have patches here adding DSC and merge components of
VDO0, other than all MDP3 components.

Those are almost ready to send, I only need to finish some testing before ;-)

For this one, anyway:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


> ---
>   arch/arm64/boot/dts/mediatek/mt8188.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> index faccc7f16259..23ec3ff6cad9 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> @@ -2488,7 +2488,7 @@ jpeg_decoder: jpeg-decoder@1a040000 {
>   		};
>   
>   		ovl0: ovl@1c000000 {
> -			compatible = "mediatek,mt8188-disp-ovl", "mediatek,mt8183-disp-ovl";
> +			compatible = "mediatek,mt8188-disp-ovl", "mediatek,mt8195-disp-ovl";
>   			reg = <0 0x1c000000 0 0x1000>;
>   			clocks = <&vdosys0 CLK_VDO0_DISP_OVL0>;
>   			interrupts = <GIC_SPI 636 IRQ_TYPE_LEVEL_HIGH 0>;



