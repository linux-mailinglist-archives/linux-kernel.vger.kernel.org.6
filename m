Return-Path: <linux-kernel+bounces-183572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0895D8C9AD3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97D04B210E6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443DF4AEF0;
	Mon, 20 May 2024 09:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pEp44sC8"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AB6481AA;
	Mon, 20 May 2024 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716199099; cv=none; b=L7ITdvg2AYeD/WZPzxwph8EZ61lG+wdfneLeeiR/qcJyCNtJyDhkpnQD/mGXHn7qjAbs5BEq9Kssgxtoz+sb1bPXJ8rfyEv6t5lVABmDIGzwyPGYzGu3olZY4pbhxuCJznjEGS8TTlJI5mc5W/GiQY7nlcnlVEfKfqYA9HmWoy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716199099; c=relaxed/simple;
	bh=9GSZX+aKLnx8y8TUWKzJzkq8VGJDTGApJAWDt61fS7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WiQEwLdvy76wGpnc5PdIhHCJn6eH6n2JCh4s7tmZo9wjPoX38/MzdrwkEmbnMsdzL3OqR1d2W4u0TAvZzACg+ifAv9IhN6uc2HqU7fsvxFkp/BMcXLtlddgwJumqdye87ROT4Wq/Y9OVEZewaew8mzWb47vFkCanvvbHfgdeXkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pEp44sC8; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716199096;
	bh=9GSZX+aKLnx8y8TUWKzJzkq8VGJDTGApJAWDt61fS7U=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=pEp44sC8Kg7b5wvV8lTZxd1j2+1nCYixzWpOUBTyDht6mzgSywYdW3sNAopDUn58i
	 i6qXK/vRW0yMdqdoL1hDe2fSVYa39bo0eN+DshkXDOYp7gooJ9pjpl4X8EFPAy8FbA
	 +DyACb7P6HMurzFKbpVT/NgpylCb5edcJK48oxfuBfAYyU4hMJNnA7r472ElyhA3Qw
	 Ieqi3gIR1K357QSiTdOZReaFjC1z99t88w8SwBNKJQGLgO1XfsbCfaM0nmnAk23tB3
	 uJRd4fp1EOnPl1z09eVhne8VZNnCIGP93pVxSkOVDTRiNyHbpsaDPEuWNoTMntLWaB
	 V0X+JjMN2aM0Q==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D611537820CD;
	Mon, 20 May 2024 09:58:15 +0000 (UTC)
Message-ID: <3b1be547-ac49-40fb-909f-96952c299545@collabora.com>
Date: Mon, 20 May 2024 11:58:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: mediatek: mt8365: drop incorrect
 power-domain-cells
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 MandyJH Liu <mandyjh.liu@mediatek.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240518211159.142920-1-krzysztof.kozlowski@linaro.org>
 <20240518211159.142920-3-krzysztof.kozlowski@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240518211159.142920-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/05/24 23:11, Krzysztof Kozlowski ha scritto:
> The top SCPSYS node is not a power domain provider.  It's child
> "power-controller" is instead.  Fix dtbs_check warnings like:
> 
>    mt8365-evk.dtb: syscon@10006000: '#power-domain-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Well if you're fixing that by migrating to scpsys compatible, you might as well
resolve all of the warnings in one commit, removing that power-domain-cells
property in patch [2/4], otherwise this one is technically a fix for that.

Please squash [2/4] and [3/4], like that it just makes more sense.

Cheers,
Angelo

> ---
>   arch/arm64/boot/dts/mediatek/mt8365.dtsi | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> index d3da5a22c2d2..eb449bfa8803 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> @@ -302,7 +302,6 @@ syscfg_pctl: syscfg-pctl@10005000 {
>   		scpsys: syscon@10006000 {
>   			compatible = "mediatek,mt8365-scpsys", "syscon", "simple-mfd";
>   			reg = <0 0x10006000 0 0x1000>;
> -			#power-domain-cells = <1>;
>   
>   			/* System Power Manager */
>   			spm: power-controller {


