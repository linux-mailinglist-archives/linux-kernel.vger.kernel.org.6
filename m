Return-Path: <linux-kernel+bounces-422234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F469D964B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 12:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08458165832
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C16C1CEE9A;
	Tue, 26 Nov 2024 11:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VLkKuPDD"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A504C1CDA04;
	Tue, 26 Nov 2024 11:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732620930; cv=none; b=ZaCODG841v5Hicc8A69K9S9ZdlxHX25X2OOP7Go6UZE1rFQbGLc6D2l7Riqo1CE1ITKMVKlj31GMBdRcxM5yU9n/g8TnW1kYOf2qu8UAOoArnAL55iIq9F/KRNlVOC2iiINwEnMdSphe3tNfUakbWeZHCXqi5TCjlCLL2DOpXpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732620930; c=relaxed/simple;
	bh=QKn+D2JA1x9aHpNwHEHtqeGvHQ9SrMz5QDwoqSS7K8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=krEYbRCuHAcTQV1KruW1KjojIQH66vXFaQuECnfq6W7fsVP0oqqxQ6jMMEwOu/I5onqkQ3f0/p1X5ri8u+TnLGl7wzR5ypN95cxtyFscQ6btH0/RBeE8a5OhTjN56v1OPnGfglWkBugmT4GRQrBIOPqni5u5B4HCL84ep3jzlFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VLkKuPDD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732620926;
	bh=QKn+D2JA1x9aHpNwHEHtqeGvHQ9SrMz5QDwoqSS7K8Y=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=VLkKuPDD7AoYEKzEuIF4jtm58yDWLQdccmF9eJSeg4PCGVC9DMyUvD1a+G/+nRsq6
	 nxtc0jsjw3Z0wdM3mzKvfn2vL5IoNbQcBGJB2pTSCQDgVSqkZt0xGUOcGnC8wcblgX
	 Dsn1Z4hLNXlAA4XnQJsLik5J+YheWem23AyC8w1oFfkSvInHFTxgYR7hk9FnIMxSIs
	 e4UusOTHL47OAYP7zam8TIrvZVlb3WAXE4RdDJ/d5m5TiigI6R0baAN5UY4b5tjMHA
	 iLNajeM+LRTxhDT34dufQ44F0Dcl0vZbP2zS8Xt3e97b7kIifTG8Ip8Q2+KUCttRvW
	 WzUVK+mjyVydA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5442017E3628;
	Tue, 26 Nov 2024 12:35:26 +0100 (CET)
Message-ID: <473283aa-fc84-4b3f-93bc-653c9d83c837@collabora.com>
Date: Tue, 26 Nov 2024 12:35:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: mediatek: mt8186: Add Starmie device
To: Wojciech Macek <wmacek@chromium.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Rafal Milecki <rafal@milecki.pl>,
 Hsin-Yi Wang <hsinyi@chromium.org>, Sean Wang <sean.wang@mediatek.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20241126103632.419469-1-wmacek@chromium.org>
 <20241126103632.419469-3-wmacek@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241126103632.419469-3-wmacek@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/11/24 11:36, Wojciech Macek ha scritto:
> Add support for Starmie Chromebooks.
> 
> Signed-off-by: Wojciech Macek <wmacek@chromium.org>
> ---
> Changelog v3-v2:
>   - Cleaned up DTS
>     - Re-using dsi_out node
>     - Removed unnecessary delete-nodes
>     - Moved touchpads to per-board dts
>     - Modified 3.3/6V power regulator node
> Changelog v2-v1:
>   - No changes
>   arch/arm64/boot/dts/mediatek/Makefile         |   2 +
>   .../mediatek/mt8186-corsola-starmie-sku0.dts  |  31 ++
>   .../mediatek/mt8186-corsola-starmie-sku1.dts  |  31 ++
>   .../dts/mediatek/mt8186-corsola-starmie.dtsi  | 465 ++++++++++++++++++
>   4 files changed, 529 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie-sku0.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie-sku1.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie.dtsi
> 

..snip..
> +/*
> + * Battery on Starmie is using a different address than default.
> + */
> +&battery {

I didn't ask you to do it this way, and that was for a good reason.

Besides, you haven't run dtbs_check before sending this.
Give it a go and you'll see why.

Regards,
Angelo

> +	reg = <0xf>;
> +};


