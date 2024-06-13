Return-Path: <linux-kernel+bounces-213385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF870907477
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205CD1C24275
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79161459ED;
	Thu, 13 Jun 2024 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="clhcumvE"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB041448FA;
	Thu, 13 Jun 2024 13:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287073; cv=none; b=B35G4heZNrHB8annJL0W1lQj5FgAZAE+PABf4dxX0vAGU1stxk3F+zuISZm6L2T6aOwi6N4IHDO1kt993uOfQ6yx5kTtWNLoj6LQG3t/9blNE9C0ICBgidseSrSzmdWAy8URp17ig/NTrHKWkT0/kagdXjJFrESvsqOlXTOuWXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287073; c=relaxed/simple;
	bh=B9iVUMQ7iBXze38SIjww4yo0dWA0ImTuZmCEx2SUH78=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n49cG20qcV3BpfWi6pQU5sPBGjKGy+8uX1FkcnroS66EFWJKvj44pSFjG4HH8avmjbgPtJH3et0yViC7/Upl1JCmdp4FZNmCn1Jk7gjm9q4lyG5M/dnaU2Er6SWcZ/EovXrQIdJMQjjSqFIkGax27kwg0f6kgVYje6T6QRF8PMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=clhcumvE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718287069;
	bh=B9iVUMQ7iBXze38SIjww4yo0dWA0ImTuZmCEx2SUH78=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=clhcumvEQ0/iPFIHMumilHTeupRda3bSPQoO+EK+KvqQFqFcvN56KlAR+nRGIn9gI
	 2gIHi1sp/et2YyoI0MqHtdDj5xP9lVvrruVhoZwzmMRvyutGXUYe/b4sZdw1NL5gmw
	 oY/v7KA9DFu2I7vftH4E2+BUsvtz8pXrmbteLat8Aa/qKGOBl2UFjbTcRycyJaK1RS
	 V7ZAkRkiEUl/tw68f641kOAvCXE9u3XHjcL6FMIIT1h9pWs2pEGT+PwmZSUUl56VwF
	 6wqPs/w3WpjxQEPxaXMGU6r5G1qp1+OrR3xE/8dN2LSj0MI6J3amlSVO/zmeGAVnsX
	 GGCAF9wSWRVYQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EE6B337820CD;
	Thu, 13 Jun 2024 13:57:48 +0000 (UTC)
Message-ID: <25c8432c-7e2c-4d32-bf5a-225aeaaa809a@collabora.com>
Date: Thu, 13 Jun 2024 15:57:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: ARM: airoha: add entry to cover Airoha SoC
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
References: <20240613133840.6949-1-krzysztof.kozlowski@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240613133840.6949-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 13/06/24 15:38, Krzysztof Kozlowski ha scritto:
> Airoha SoC is not covered by any maintainer entry so relevant patches
> can be missed.  It seems Mediatek SoC maintainers were covering some
> parts of Airoha and Airoha itself is subsidiary of Mediatek, so assign
> the Airoha maintenance to Matthias and AngeloGioacchino.
> 
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


> ---
>   MAINTAINERS | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fb32a2fe3a79..e7fd595b8f5e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1924,6 +1924,15 @@ F:	include/dt-bindings/reset/actions,*
>   F:	include/linux/soc/actions/
>   N:	owl
>   
> +ARM/AIROHA SOC SUPPORT
> +M:	Matthias Brugger <matthias.bgg@gmail.com>
> +M:	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
> +S:	Odd Fixes
> +F:	arch/arm/boot/dts/airoha/
> +F:	arch/arm64/boot/dts/airoha/
> +
>   ARM/Allwinner SoC Clock Support
>   M:	Emilio López <emilio@elopez.com.ar>
>   S:	Maintained


