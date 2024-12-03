Return-Path: <linux-kernel+bounces-429150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7AA9E17F4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E6E5165D08
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F8E1E04B4;
	Tue,  3 Dec 2024 09:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="okF8SQ8E"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1835F1DFE07;
	Tue,  3 Dec 2024 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218843; cv=none; b=ZaVdI8/Ek8ZU/NTf1czQzri2lWyFWYPj+W9AAbIon4UAG+A6n1JN0/EA8yAjvU5TG059qYrFONmad/n6cqPDMxEZSipAMmFgGonWU9SsGIVAZSrBHrBwUu9vOFSVDbWykPbzHtRd8Iqlt2ul++HsCWWPL9lJO32R5gqSIL6js28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218843; c=relaxed/simple;
	bh=MzJvlx12NKKjiAgZHOfk0XXECEkWtTXteFRLJ6O9MBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIy+sIk6stE0JUocT7rmlXb3waov+xvCGDcpV0ceK/9Wc9gwHTIk9Ms3HtD/RkQuLWKbqHx6ROa7RRaFbeT3aXYB66D9ikVBTVvbIPpwisYzhuP+zrKoy1Ayi4b3ES7E1TOAh0uVGwO9Z7EQNoIjDWe8i/r2ItcGQLKrH8pGt1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=okF8SQ8E; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733218834;
	bh=MzJvlx12NKKjiAgZHOfk0XXECEkWtTXteFRLJ6O9MBo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=okF8SQ8EBXtW0i3uAWtClMnke9gWINz/POqh41lzX/5uj8RWgEij+J2gyler0bucl
	 NCoCTNvBqc0plk4L6Q7z7XZM9kTx9vNMzKd0G3lI6qDxOPcS/12KZSC2cpuV9VZDv0
	 hJQaHpr1yBhy5BIcTRctmF1aRV8G5Nt9e6LTWvsztD71OdrHQnrtLGeHCID9dZ3V5q
	 dBg7ZY6Uqdh2hx5kPIi0lz5YVw2BHUxonCm2I2YtgjZ0K8P/SFVCC+5Ot3ygq/XpYx
	 B/Q9yUemTAz3VZu9t32qC6x2gWxSTF7HsiLm0XsmE9MsKvJqT3YRo6PPgIDZtWzwET
	 pj365kgZUUwYw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9441217E35E0;
	Tue,  3 Dec 2024 10:40:33 +0100 (CET)
Message-ID: <a521663e-f2f3-4602-8d0e-2f3841eb080b@collabora.com>
Date: Tue, 3 Dec 2024 10:40:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/18] arm64: dts: mediatek: mt7988: add i2c-mux on
 bpi-r4
To: Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241202122602.30734-1-linux@fw-web.de>
 <20241202122602.30734-17-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241202122602.30734-17-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/12/24 13:25, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 

arm64: dts: mediatek: mt7988-bpi-r4: Add PCA9545 I2C Mux

> Bananapi R4 uses an i2c multiplexer for SFP slots, rtc and eeprom.
> Add its node to the right i2c controller.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> ---
>   .../dts/mediatek/mt7988a-bananapi-bpi-r4.dts  | 40 +++++++++++++++++++
>   1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
> index 550c373b3d70..9ceefc990000 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
> @@ -2,6 +2,7 @@
>   
>   /dts-v1/;
>   
> +#include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/regulator/richtek,rt5190a-regulator.h>
>   
>   #include "mt7988a.dtsi"
> @@ -138,6 +139,45 @@ &i2c2 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&i2c2_1_pins>;
>   	status = "okay";
> +
> +	pca9545: i2c-mux@70 {
> +		reg = <0x70>;
> +		compatible = "nxp,pca9545";

reg goes after compatible... :-)

After which

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


