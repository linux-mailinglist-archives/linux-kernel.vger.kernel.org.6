Return-Path: <linux-kernel+bounces-442892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0F49EE38A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7ADB167FF1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A258210188;
	Thu, 12 Dec 2024 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SPWr87xS"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC873210185;
	Thu, 12 Dec 2024 09:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733997462; cv=none; b=L4NDnXiweLIB2lpMY6Qh48lPR9fgGVdWwSN7yJWaZ0g3/2kvkvMNlLLHdFquk0RFhaupRizuB+FcXj9FlVmK9p7I2tT332g3m033L96ISPz3thoSZMcb/PrE5TtXETTBiKCy/yt74VIa3QFLm6VmBAJlaRZkyDkwK79Eek2H2uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733997462; c=relaxed/simple;
	bh=EIy2s9I6WHzZK3FvcYCQrjFobBckSkgRpj7z3oxitPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DcA4hHF23bvM0Uovvfd6IuPNJ5rkESZs/XbfOZ9VmcjJT34jEdDYouVoPfqGMAnDNd/E/9x91Wb7XjYvqE3qXnNO7sI5ulXZSToabNJwR2KWTsQJ+mszr8Ek1uD1Ied6YrjtZx5XzkEveFnpktoT1zp0OsEkkXlCZkFRWhXHsss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SPWr87xS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733997459;
	bh=EIy2s9I6WHzZK3FvcYCQrjFobBckSkgRpj7z3oxitPY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SPWr87xSoeMQkThh2m5MniNqFXTztuhtlzryUoPsCt5oYe33inIHYRG07sjoizb1q
	 ThsfiXhfZpF6ceHzcGos3xSdn+Yj7eT3RsRTZUHWN5cMBSKrzhjLIBfIvTYuWEpXOD
	 v44/+QOKyDUHtqgjKbz4RMzQZos97hbwE2jiwDPxefyECJhsiB8ZoXd8HQjj2IDl51
	 xXem6k62rPiL501890eYyzVVDK1B2lWYmTPpnbx9NBm3cvON4MCKeBC2YLIt9vLzpK
	 Dad5zOzAnV9HTQaH0TCUcluRKO+9ENDVpDFTcSIBiXsGDAg2VvLfDA280/C+nSLKi1
	 Vd0/H5vq5t4NQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7F6C917E35F0;
	Thu, 12 Dec 2024 10:57:38 +0100 (CET)
Message-ID: <1b75d7ee-38d7-47fc-b7df-c46793a85036@collabora.com>
Date: Thu, 12 Dec 2024 10:57:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] arm64: dts: mediatek: Drop regulator-compatible
 property
To: Chen-Yu Tsai <wenst@chromium.org>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241211052427.4178367-1-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241211052427.4178367-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 11/12/24 06:24, Chen-Yu Tsai ha scritto:
> Hi folks,
> 
> This series drops usage of the long deprecated "regulator-compatible"
> property from MediaTek device tree files. The property was introduced
> in 2012, and then subsequently deprecated after two months. It was
> never carried over during the binding YAML conversion.
> 
> Drop the property from the MT6315 regulator binding, and all MediaTek
> device tree files. IMO it should never have been used to begin with.
> This also gets rid of any validation errors [1] related to them.
> 
> Please have a look.
> 

Whole series is

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> 
> Thanks
> ChenYu
> 
> [1] https://lore.kernel.org/all/173386568696.497617.3727087837255802552.robh@kernel.org/
> 
> Chen-Yu Tsai (8):
>    regulator: dt-bindings: mt6315: Drop regulator-compatible property
>    arm64: dts: mediatek: mt8173-evb: Drop regulator-compatible property
>    arm64: dts: mediatek: mt8173-elm: Drop regulator-compatible property
>    arm64: dts: mediatek: mt8192-asurada: Drop regulator-compatible
>      property
>    arm64: dts: mediatek: mt8195-cherry: Drop regulator-compatible
>      property
>    arm64: dts: mediatek: mt8195-demo: Drop regulator-compatible property
>    arm64: dts: medaitek: mt8395-nio-12l: Drop regulator-compatible
>      property
>    arm64: dts: mediatek: mt8395-genio-1200-evk: Drop regulator-compatible
>      property
> 
>   .../bindings/regulator/mt6315-regulator.yaml  |  6 -----
>   arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi  | 23 -------------------
>   arch/arm64/boot/dts/mediatek/mt8173-evb.dts   | 23 -------------------
>   .../boot/dts/mediatek/mt8192-asurada.dtsi     |  3 ---
>   .../boot/dts/mediatek/mt8195-cherry.dtsi      |  2 --
>   arch/arm64/boot/dts/mediatek/mt8195-demo.dts  |  9 --------
>   .../dts/mediatek/mt8395-genio-1200-evk.dts    |  2 --
>   .../dts/mediatek/mt8395-radxa-nio-12l.dts     |  2 --
>   8 files changed, 70 deletions(-)
> 



