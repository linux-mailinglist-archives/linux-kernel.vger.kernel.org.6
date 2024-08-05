Return-Path: <linux-kernel+bounces-274598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99550947A8E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500211F219E4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC4C155C88;
	Mon,  5 Aug 2024 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=angelogioacchino.delregno@collabora.com header.b="XDfhqTdl"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1D66A01E;
	Mon,  5 Aug 2024 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722858399; cv=pass; b=VxtmjkKcnmv/OAlpdFYTx5ASzxVFzgDDiM3ZEiS50UEFBNqR+lZz9mQwOiTBPOQ0ltVG8w3tcT8ST/ZI+dFnGNT/tNRQDUlearAFNiwWHvxU46vD7ZPmPvaPUUwx+wA6Of1TZUp1dTF/h8ipTmL8Y08WD5NOj3zO4GulWp1YtUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722858399; c=relaxed/simple;
	bh=n2RIdq0IhbLmXmjAwSSrkKNPZZqVEDlZIcgiYy6XeRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvwkPP54wEhY6OgWN/cJBGMI/3HUal057H9I61ga7sxql3G2+MxUgeeRF+v+77/fbIdF2p8oGMqu50NQRfU2WgmuvBkc7C7gSzaafUIO9wHJP08Lv2X16Ohy9lVarwiIn9B92ZuS3gbzyNI6IyhliIyLCB9gJJTYPM2N0Kyiqbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=angelogioacchino.delregno@collabora.com header.b=XDfhqTdl; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1722858388; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=htvigfJC5EE5OUW4sYp3r5WBLqdNXcFAmIPRyp1SE9DlZ1c7gxDV62g1HfApsKF63nP9eboL/Mz/sgheTr/5nq8VLOeOm9HPJCcgIxM0XzDcOuCSU9RD52xh8iQOaOgZ/8wCd2KKxh3o4qdr3+fdqeKepz3LKgNkW2sqleCoiqI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1722858388; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=X4Ff1KkmwJm2DOFKLyyKLVFzHm+3uoyXpl1wKGlTGBM=; 
	b=QAdToZY6fesMjZctA4OtfUOm1ouu1PXwuNaoXg4MLQPOFLnoRBKfhl7d6id8l3c564BB2uuOPRICzppaEiURh/cdVCvGUtdQ4Nr8JHFYCsXilYZAIptM0NPPquLod7OoyeL3H7h4ttlocrQ2vSopRGohDYGfqeJzujW1z9ZTkf0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=angelogioacchino.delregno@collabora.com;
	dmarc=pass header.from=<angelogioacchino.delregno@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1722858388;
	s=zohomail; d=collabora.com;
	i=angelogioacchino.delregno@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=X4Ff1KkmwJm2DOFKLyyKLVFzHm+3uoyXpl1wKGlTGBM=;
	b=XDfhqTdlISYLqA4ixKVW7Y7gbbMAkBx7gr27w681BTZeNhM6zNNj6bSwthcEYVce
	rzCVttxHDVF1KPO5f1OftyGFth25N46u/sqzo85aRIthpIw/gZbxXLaMKXV0rKJoHoN
	XKbDlwNQHLhh+a40VEjF43hiTlMNho9HcFI1MZTQ=
Received: by mx.zohomail.com with SMTPS id 1722858386516862.2880586091179;
	Mon, 5 Aug 2024 04:46:26 -0700 (PDT)
Message-ID: <8e089dc0-9342-480f-ac8a-93b5bfe1241e@collabora.com>
Date: Mon, 5 Aug 2024 13:46:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183: Remove clock from mfg_async
 power domain
To: Pin-yen Lin <treapking@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
 Kiwi Liu <kiwi.liu@mediatek.corp-partner.google.com>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Hsin-Te Yuan <yuanhsinte@chromium.org>, Chen-Yu Tsai <wenst@chromium.org>
References: <20240805065051.3129354-1-treapking@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240805065051.3129354-1-treapking@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Il 05/08/24 08:50, Pin-yen Lin ha scritto:
> This clock dependency introduced a mutual dependency between mfg_async
> power domain and mt8183-mfgcfg clock, and Mediatek has confirmed that
> this dependency is not needed. Remove this to avoid potential deadlock.
> 

Uhm, have you tested this upstream with Panfrost, or only downstream with the
proprietary Mali stack?

Regards,
Angelo

> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> Fixes: 37fb78b9aeb7 ("arm64: dts: mediatek: Add mt8183 power domains controller")
> 
> ---
> 
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index fbf145639b8c..267378fa46c0 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -872,8 +872,6 @@ power-domain@MT8183_POWER_DOMAIN_CONN {
>   
>   				mfg_async: power-domain@MT8183_POWER_DOMAIN_MFG_ASYNC {
>   					reg = <MT8183_POWER_DOMAIN_MFG_ASYNC>;
> -					clocks = <&topckgen CLK_TOP_MUX_MFG>;
> -					clock-names = "mfg";
>   					#address-cells = <1>;
>   					#size-cells = <0>;
>   					#power-domain-cells = <1>;


