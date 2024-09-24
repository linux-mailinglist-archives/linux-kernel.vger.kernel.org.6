Return-Path: <linux-kernel+bounces-336792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C64DA9840EB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88FD1285282
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFFE14F9F7;
	Tue, 24 Sep 2024 08:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JvmBVifE"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E467315443D;
	Tue, 24 Sep 2024 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727167574; cv=none; b=Ff/jt8iJWv7Pjqif8ZIr5KBxwg0EL3A2ii6Fw/V5O6Xd1Iqm6ebgPpk/wMhTNkxr8Terf5hyrq+4cXGoJiuvbs4zFYmZdiAPQLmssoLLJXOxRqVO0bVk/IrcXs+rYRBCeZy1CY5Ieb1NhLU1bgbWeiLaxBL170IIEVeHKDXvsCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727167574; c=relaxed/simple;
	bh=nGDzu/0Mn1eGGrYd8jEPlVx2PsirGUvhYIZqwNI7mtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jnHV+VqutCNL5RQjTCaimRTo7BxAwf/weRl2X86xC6PVBdn3cgk4IOI+JS2zlgpQsmb6fveXEcnHPJOllAW18euMyhMfl4LEoqhCk1WyjdxpzLrUOFAv1rqCdNdFC+ftX4sQ6JEJ1xbrUybPop1uZD2U5kMWrVmxr5+OiMYgUSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JvmBVifE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727167571;
	bh=nGDzu/0Mn1eGGrYd8jEPlVx2PsirGUvhYIZqwNI7mtQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JvmBVifEXHe67RfNDQ1bcVV3X4iffDdzY05u9F0Nqzx2nCf5GUhMMwKWDKSt5PGL3
	 83yxSam5NrEmI880ihsFhfyaO4PeYw9+D1I9ly3e/QW80JCGjoJ6O7v6U8PrJ6/M0L
	 t2Y0bMe8tOG7BKJkgwHBodHdom511MkZBwP7j++jqH+8dL2Y742suaeKGkzaSDnJDl
	 j8ge0NB+219O42x/pzpM2lvssF8HUFaWJExfTdR+quY5QBzexxR3plJ+kb7lfXtgl9
	 wpfoaoVklTteV1VdChgiWfRcNo2D4lSJJl81ZdU3mzBSd2qmca8q7z2ZYWtOT3fort
	 TyHcVFC5cShpA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BBCAE17E1068;
	Tue, 24 Sep 2024 10:46:10 +0200 (CEST)
Message-ID: <69fcaf74-ddf5-4bd8-8f0b-3d1a1793c0f7@collabora.com>
Date: Tue, 24 Sep 2024 10:46:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: mediatek: mt8186: add FHCTL node
To: Max Weng <max_weng@compal.corp-partner.google.com>,
 linux-kernel@vger.kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240923144728.870285-1-max_weng@compal.corp-partner.google.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240923144728.870285-1-max_weng@compal.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/09/24 16:47, Max Weng ha scritto:
> From: max_weng <max_weng@compal.corp-partner.google.com>
> 
> add FHCTL device node for Frequency Hopping and Spread Spectrum clock function.
> 
> Change-Id: I7f9f2991978df7d5d3a6a8bc78f6f443f2f0460d

Please remove the useless Change-Id tag, this means nothing upstream, after which,
on V3:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> Signed-off-by: Max Weng <max_weng@compal.corp-partner.google.com>
> ---
>   Change frome v1 to v2
>   * Modify the commit description
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> index 148c332018b0..d3c3c2a40adc 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -29,6 +29,13 @@ aliases {
>   		rdma1 = &rdma1;
>   	};
>   
> +	fhctl: fhctl@1000ce00 {
> +		compatible = "mediatek,mt8186-fhctl";
> +		clocks = <&apmixedsys CLK_APMIXED_TVDPLL>;
> +		reg = <0 0x1000ce00 0 0x200>;
> +		status = "disabled";
> +	};
> +
>   	cci: cci {
>   		compatible = "mediatek,mt8186-cci";
>   		clocks = <&mcusys CLK_MCU_ARMPLL_BUS_SEL>,


