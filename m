Return-Path: <linux-kernel+bounces-335576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E49A897E7A3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71B74B21866
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCB319343B;
	Mon, 23 Sep 2024 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="d7ao3V7m"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9197A1885B9;
	Mon, 23 Sep 2024 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727080554; cv=none; b=Ohw1nfFhk2+9vzsDPTWx5xLqQ6M7DJAHCytOBDWa4RrAJi50EWO9UpPuIoaVz02H1FM/ZpCwS0FiCFjAYRaAH7P6b+05f54HOoToj18zBFB/8DCtPIk1t5F9XT86mYpHo/jvysgphV0jDrzh/BelBIjWUHudGmdEQFgonihhbvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727080554; c=relaxed/simple;
	bh=e4cC60E4kblxFg6svxGrB/DLOt/LdtfLXEBt+zfPq6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JPCHFErq6/msvegOFtXMvE9SJB8/Ygko5YN3/LAYEp4M8ODUTAQeQbZcpgtDlurzMr7VN+hBPXv/FvMSjVhjTfZ7dRskmb0eVgjBqnspHqaYFi4/Vu8CRS3VNS1YdnZJfb/G4Lb2KKiYioErtmCDKC/VeGjZL/YWlDlH27lAPKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=d7ao3V7m; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727080545;
	bh=e4cC60E4kblxFg6svxGrB/DLOt/LdtfLXEBt+zfPq6o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d7ao3V7mR+5JAWYxPQVcVv2U5EBc7eBEh/CHW5gAfTscBY5DkJd2LtNLU7krxGtwf
	 Ar+5BgjAc05fixS48pzsFiL0l4PSFVeji3z/8/b3z5NgfveeGEiaAcHnZ1cQZB36kV
	 PevWGSG/be1uaMS3S6rIj1+H3bY14+D8GIl0co3yIO5mTU68e7fyF/fBnVLfJwgBsD
	 bmcF/pACl6dNYEhZE9SLVb+lJWe76pgIzlGxStouVxWOtZDM348tG0S1/EO6d7lyg7
	 Q+QpITPTTwbv5ugMx18Clob3e9GkyjCl0GHNcDusdVOORFk/EnRohAuTR+/GwZ49LT
	 KyEaoR2xMTRxw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 338A817E105F;
	Mon, 23 Sep 2024 10:35:45 +0200 (CEST)
Message-ID: <b05d0543-b4f4-463d-a56a-28f7fa99a3f0@collabora.com>
Date: Mon, 23 Sep 2024 10:35:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: mediatek: mt8186: add FHCTL node
To: Max Weng <max_weng@compal.corp-partner.google.com>,
 linux-kernel@vger.kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240923081340.860715-1-max_weng@compal.corp-partner.google.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240923081340.860715-1-max_weng@compal.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/09/24 10:13, Max Weng ha scritto:
> From: max_weng <max_weng@compal.corp-partner.google.com>
> 
> add fhctl device node.

Please clarify the commit description, like so:

Add FHCTL device node for Frequency Hopping and Spread Spectrum
clocking function.

After which,
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


> 
> Signed-off-by: max_weng <max_weng@compal.corp-partner.google.com>
> ---
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


