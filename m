Return-Path: <linux-kernel+bounces-423507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1469DA893
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6687016329E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B1E1FCFDA;
	Wed, 27 Nov 2024 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nQgV+ldI"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724E41F76A5;
	Wed, 27 Nov 2024 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732714492; cv=none; b=OVDIUmuC2EzgEw28MIG/7X/B/sBQyUf/rJzWq9YOntr++HMFtJ33iyrUvIpwhAY9FiWQH449UM6+OoLmVzQByNCSrTles79aKRadvF45WaKKsCJuqyXKL/Wv4ezk+VsJ675JD/ugeQpZRaGmjGY/aJVgmEkCTKeFA73cOiHtuVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732714492; c=relaxed/simple;
	bh=A8gAgVEiZnE1R/aMVQBm05Lt+bamxYymAWe7jZVjljk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7QwlgAu11hKafpEzSPklxTprh6d9T6NRvdifaPrcGKSHwmaIKxvlkBTb4h26As9fMYTsL9wotvCVjit8UFvQcl66YQM8S4vJD6H+ffmicEdr+BEwNq/ov5W8xel8a040J/iTaJigMrMSu002lLm874iBKnC9z13lavZdTL0aQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nQgV+ldI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732714488;
	bh=A8gAgVEiZnE1R/aMVQBm05Lt+bamxYymAWe7jZVjljk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nQgV+ldIPj1gKbmYnxdVD91tLqAhTi0nkIptkvrBJCc5RVTHj0ouPwEWS0nGifcu0
	 swz8eJNPtF4yK7AuDy6qN9kDFyGVF/SjB+stwyZv8kf71sxZpLyWXwDrLMRAPTy7Lf
	 QTGGXxC67U9KecN0wvFYtgNJi5WKlL7uNLEO1DwhQunY9cEBW+9et1SwCVg6Q/Okqf
	 yOIYU7w3zWdV4xOGZIF83Qp+XDDeJNUqU88gVw8Gq5INwnyKBsbXgEYAie7fOQitv+
	 vb7X4Cz6a8tWwkPGeSq64FfmQD937gZ5vQ9UdajAB90HlgQev7ezaPofUgd/SdNwvG
	 B4uirEwJFBfSg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 387F717E3706;
	Wed, 27 Nov 2024 14:34:48 +0100 (CET)
Message-ID: <369df136-220a-44c9-a48c-1307f3741d27@collabora.com>
Date: Wed, 27 Nov 2024 14:34:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 12/14] arm64: dts: mediatek: mt7988: add reserved memory
To: Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241029103937.45852-1-linux@fw-web.de>
 <20241029103937.45852-13-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241029103937.45852-13-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/10/24 11:39, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add memory range handled by ATF to not be touched by linux kernel.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

If you are really sure that this is always the same for all boards based on MT7988,
I will trust you and give you my R-b once this series gets out of RFC state.

Cheers,
Angelo

> ---
>   arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> index a3a7deda35a5..7721d2ec06ee 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> @@ -81,6 +81,18 @@ reg_3p3v: regulator-3p3v {
>   		regulator-always-on;
>   	};
>   
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/* 320 KiB reserved for ARM Trusted Firmware (BL31 and BL32) */
> +		secmon_reserved: secmon@43000000 {
> +			reg = <0 0x43000000 0 0x50000>;
> +			no-map;
> +		};
> +	};
> +
>   	soc {
>   		compatible = "simple-bus";
>   		ranges;


