Return-Path: <linux-kernel+bounces-343676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFA2989E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780C91C21853
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BED7188710;
	Mon, 30 Sep 2024 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="b/TUIaH9"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C17E1885BE;
	Mon, 30 Sep 2024 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688208; cv=none; b=iBwG9pVIryavmSr72MtDsnt/BS+0zYRVerIBapJMC0uba4PP7Zz6SeWJ++Rq+QoM9k29CHcVzC6d/2AwnTX1ou+kkoBs/+z3RePc1jKIw8eWQ7qD019rz88zNxIeXzejk+yNjC63+AA3U4lsSlkcJq2+EVuSDGzpKXQJ9ODG2Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688208; c=relaxed/simple;
	bh=H78v4z8F6OouxmM7kvdruy1KbUGRwDt9Sl8HITuykgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UnYVP74LEcwGKxM1RvHqvpiC6IakCFdaQd8ZS4W5S3DqE0AjfxNdMZZUoAxdrK02C1FY9Tu4XvoKN4F/YpOeQrMNc+dV35B3bbfQupob6EHXqjSlMb8YNA8zL9iy1C9eGSYkr2n04bmt2zgqH5hF/vt6ZBqekmxoOQLgHbPG8OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=b/TUIaH9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727688204;
	bh=H78v4z8F6OouxmM7kvdruy1KbUGRwDt9Sl8HITuykgI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b/TUIaH9WcMHPZxb+dWhv/n3SDpnlPtKLp9X4Fax/mdh4Pe9c4JSl604D4ZHWsiQd
	 FDtNQhE6l1BrnLLzhpk395sWaVkz7Q3hoUGlDs+ZaUnFU6xIXtPZqQPvfcu/bEfDUT
	 QiLOYSCxzCt5t/r6+roLhdmsHVaEBmX958BQEuoP45X/FKKWa/pOjG47Z8e9YpOCFH
	 synU7eiVevxVQU9rBifj5ajrMDlHmMoW6WIJxYY8MCUE6x7pT/1N1CZ1DLBNWKzdBr
	 oShgrkE6Y87PP/70HH6M7L6ymeEdY/akD7c8buKeThLcusS4OQFj5bERg7hpBRVS6I
	 2UFobEu5a6NBA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0251017E1091;
	Mon, 30 Sep 2024 11:23:23 +0200 (CEST)
Message-ID: <2c5614f7-0ada-453a-bd81-2f0054a919a0@collabora.com>
Date: Mon, 30 Sep 2024 11:23:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: mediate: Introduce MT8186
 Chinchou/Chinchou360 Chromebooks
To: =?UTF-8?Q?Albert_Jakie=C5=82a?= <jakiela@google.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 wenst@chromium.org, rafal@milecki.pl, hsinyi@chromium.org,
 nfraprado@collabora.com, sean.wang@mediatek.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240927122940.4190949-1-jakiela@google.com>
 <20240927122940.4190949-2-jakiela@google.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240927122940.4190949-2-jakiela@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 27/09/24 14:29, Albert Jakieła ha scritto:
> The MT8186 Chinchou/Chinchou360, also known as the Asus Chromebook
> CZ12/CZ11 Flip, is a clamshell or convertible device with touchscreen,
> stylus and extra buttons.
> 

You have a typo in your commit title `mediate` -> `mediatek`

> Signed-off-by: Albert Jakieła <jakiela@google.com>
> ---
> Changes in v2:
> - PATCH 2/2: Remove sku2147483647, remove duplicate nodes, add model
> 	and remove uneccecery nodes from sound card.
> - Link to v1: https://lore.kernel.org/all/20240925080353.2362879-2-jakiela@google.com/
> 
> ---
>   arch/arm64/boot/dts/mediatek/Makefile         |   3 +
>   .../mediatek/mt8186-corsola-chinchou-sku0.dts |  18 +
>   .../mediatek/mt8186-corsola-chinchou-sku1.dts |  34 ++
>   .../mt8186-corsola-chinchou-sku16.dts         |  28 ++
>   .../dts/mediatek/mt8186-corsola-chinchou.dtsi | 432 ++++++++++++++++++
>   5 files changed, 515 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.dtsi
> 

..snip..


> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.dtsi
> new file mode 100644
> index 000000000000..96cc3c267c20
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.dtsi
> @@ -0,0 +1,432 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2023 Google LLC
> + */
> +
> +/dts-v1/;
> +#include "mt8186-corsola.dtsi"
> +
> +/ {

..snip..

> +
> +&sound {
> +	status = "okay";
> +
> +	compatible = "mediatek,mt8186-mt6366-rt5650-sound";

Why did you keep the compatible string override?

> +	model = "mt8186_rt5650";
> +

Regards,
Angelo





