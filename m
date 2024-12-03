Return-Path: <linux-kernel+bounces-429157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AEE9E189A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61DA8B38B8A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925911E1C3A;
	Tue,  3 Dec 2024 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qCJD+dRu"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450021E0E02;
	Tue,  3 Dec 2024 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218848; cv=none; b=u5bmFU370VEMQiSxnI1n2vsihfkiWVFqHFcL+nk6WieQAuNCWdm4gAWIWnK3xgfNzCQ0sYTomltEIPyyo8LfVQxrmB3Tyom1sfbp2gNZ4JhPhTRDMQIhnZ/wGgrSTCOA7CkhSgHZH90Wlyf13Z6JNCLZjFbGjVItW3kV72Hf2YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218848; c=relaxed/simple;
	bh=gYMPaFGeU3S7YRLBugo5a0sqD9zXBU5qIQijbCskzNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MA5yWLW7gMsY2abdviZXTzg3HEJkeo3r4o0lP/owfgmuhU2m4e61D9UZjhu2CTpXEDb7r4NxdiGssB/R/IM83RHNRpl3wO54/lBxQ+BNrJB5J/cDZt6KwCcQAyLHoOSvnkmes7xhBQBdOKp0V/bEleOvmV5MuoJJOloVrqxiS4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qCJD+dRu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733218844;
	bh=gYMPaFGeU3S7YRLBugo5a0sqD9zXBU5qIQijbCskzNA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qCJD+dRuSqYKWH8eBzj/Tze8DaM+btMEpKNjlrm2TaRpQxFuLatXgGnbzBrPhjIeU
	 uPwVK90bv9gKNOmf1+88aipUUOloXzo4KfiSa51s+BG7D9Al+sT1Ayj4DrF4fiEPha
	 IXgXbRnUb9mfmHN63eXsnv8n8y7X4QTxvYQx4McknAJCWud9QcwjiP4AKch5u1j7kU
	 TTdq8e5WU7DfbLnhmLxYXQt4q6CxkBDw40Q5dJi+FpXT7wvPPVuiMpadwtwdthtOWr
	 RMN9mpdowXT8Wp5URcdUa7WgmSkBXfo8RhQttbqHtPii6lgkmhrYG7EY802q9I7k3u
	 ukArmGA1mOS5g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4CF5C17E35D8;
	Tue,  3 Dec 2024 10:40:44 +0100 (CET)
Message-ID: <e2b381ee-f4d0-4780-b539-53de4477d1c3@collabora.com>
Date: Tue, 3 Dec 2024 10:40:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/18] arm64: dts: mediatek: mt7988: add reserved
 memory
To: Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241202122602.30734-1-linux@fw-web.de>
 <20241202122602.30734-8-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241202122602.30734-8-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/12/24 13:25, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add memory range handled by ATF to not be touched by linux kernel.
> ATF is SoC specific and not board-specific so add it to mt7988.dtsi.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Since you have to send a v3, can you please move this to be the first commit
of the series?

Would make a lot of sense :-)

> ---
>   arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> index 09dcb39ad098..1cf801486e61 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> @@ -63,6 +63,18 @@ psci {
>   		method = "smc";
>   	};
>   
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/* 320 KiB reserved for ARM Trusted Firmware (BL31 and BL32) */
> +		secmon_reserved: secmon@43000000 {

Are you ever modifying this outside of mt7988a.dtsi?

No!

So you don't need to add the `secmon_reserved` handle..... :-)

> +			reg = <0 0x43000000 0 0x50000>;
> +			no-map;
> +		};
> +	};
> +
>   	soc {
>   		compatible = "simple-bus";
>   		ranges;



