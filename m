Return-Path: <linux-kernel+bounces-257128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAEE9375A6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372751F2255D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1EB81AB6;
	Fri, 19 Jul 2024 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rM3sazl2"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B4784A3F;
	Fri, 19 Jul 2024 09:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721380923; cv=none; b=afeg/2DJIg53NlSqcIBBpARF+UrI/KQgi+sxIZ5ssZLQAlXFqXYX95OMYx2i3EQTfO6YSu5FoGn3UWAcf3bqWOgpdl40qOhkXgXXq1gx1/IKTfMyIwuFdkKbE0Kummg4izvO3AjKZBjcQ6pLXWyd8R3x5xsV1h0aEjnEFpKOKGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721380923; c=relaxed/simple;
	bh=eS6RH9QK9rYxbfVs8pehMWbyqub53ZmzaWMZBeeTaVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYhapaczCf4fAMLnAtex8ZAntuJ+iJDtMTyO41RvxieXZfKSYw5lPj4sVU4n/j+QYDdojHY/is39oIpIyasu4+175tHZy+OhaWJ4XE05jCUyvHDExSlSo18NJfANKu5rtU5Ro27tvOiTXlscA2k2O2oCNpTdg/+cLRHs/V0KUpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rM3sazl2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721380919;
	bh=eS6RH9QK9rYxbfVs8pehMWbyqub53ZmzaWMZBeeTaVM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rM3sazl2tpTny5XXnNeEJodgIs3YkhAEUwTlvB8tfimcS0Xsc/VAT6cAs6pNK1kZi
	 lyW6FETwNpq2fqBl9DvWeyePLLIcXxSlTScWNes9/6eUs8R8XZS/BFTazZGihZcMNL
	 G7uPD2PWNDsJoL8fkJVudVps6eM6qw3uik533wCfNFK1ks+S2NBNlqDealE7173ENS
	 LCIJ+4zbUFWBhRS7dE35P+dzfTxN0PDu0zvyelj8pkct87PLyEOV5H31y9kokEFDUh
	 a+SapZPRXDg7/enmu1zrw8C0y47IFuqB2jjkpuB0hDmLWrF4rquSklbxGP7HwpkFD1
	 JL+lsLROsLaZA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 560BE3782063;
	Fri, 19 Jul 2024 09:21:59 +0000 (UTC)
Message-ID: <7edb3361-9e53-44ad-82ec-b2c81834b2ea@collabora.com>
Date: Fri, 19 Jul 2024 11:21:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186-corsola: Update ADSP
 reserved memory region
To: Fei Shao <fshao@chromium.org>, Chen-Yu Tsai <wenst@chromium.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20240719045823.3264974-1-fshao@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240719045823.3264974-1-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/07/24 06:58, Fei Shao ha scritto:
> Corsola firmware reserves the memory region of [0x60000000, 0x61100000)

Sorry but if the region is supposed to be 0x1100000 long....

> exclusively for ADSP usage.
> But in fact, a 6 MB "hole" of [0x60A00000, 0x61000000) didn't get
> assigned to the ADSP node in the Corsola device tree, meaning no audio
> tasks can access and utilize that memory section.
> 
> Update the reserved ADSP memory region to fill the gap.
> 
> Fixes: 8855d01fb81f ("arm64: dts: mediatek: Add MT8186 Krabby platform based Tentacruel / Tentacool")
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
> 
>   arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
> index afdab5724eaa..0c4a26117428 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
> @@ -169,7 +169,7 @@ adsp_dma_mem: memory@61000000 {
>   
>   		adsp_mem: memory@60000000 {
>   			compatible = "shared-dma-pool";
> -			reg = <0 0x60000000 0 0xA00000>;
> +			reg = <0 0x60000000 0 0x1000000>;

...why are you making it 0x1000000 long?

Cheers,
Angelo

>   			no-map;
>   		};
>   



