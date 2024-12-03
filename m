Return-Path: <linux-kernel+bounces-429152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3589E1979
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C3BEB44BF8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520DC1E0B96;
	Tue,  3 Dec 2024 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gvQfEjCU"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDA61E008D;
	Tue,  3 Dec 2024 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218844; cv=none; b=qYE5nDabj0f9Zou7k6+M8sKgxL5uEy6HoKgpb/ePVVUgURpTpuJeI1hI5NGGxt2hDZfYtDr4MagFgO/RzQfQTGhh5vfKdEx46rQBZ+bI6rHff6z1FacC7RNcBRD+LwbHAyNUxDhYqqTmL+yrtitgGCVcCqXI9/PiPP1R8+gQ17I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218844; c=relaxed/simple;
	bh=D0B58GzI5QB13wGSjR1c1mA64LQkYZUYsyzm+is20bU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rn0gl3/6KbeymD4JQQOQTgXcGetO5o7SjfHja1ywLktztj6HNLimEEBDEb4/9UBS23+zoGKswQrpkh3ECln/TOdlzpFN/w8dcEBTv2yzadHQIZiDzPeacyWSQ9AMOV+FmQ9f7xJss8XjoCOXLMaN3L0p0W0ChpgOWDw0PBxZ/e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gvQfEjCU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733218840;
	bh=D0B58GzI5QB13wGSjR1c1mA64LQkYZUYsyzm+is20bU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gvQfEjCUIjD4obQXutdbugoSXBHO0hMk0J1IGshlcbGz1nwg1vNRQwJqpVzYiuk48
	 K6OxQ5OqoLPJcIkmAI1D99cchvCkgAJ69IKGgkNDbt4uc9QFgN2tHwhVlOZ0Lj3VPP
	 PjPnU/l1HJF2MdCqMQfmVtBNN6RjkH7ZoFNx2nBz9Cw1CHMh2rkBTYmoFJHTWs+qU2
	 Aoc4Vgvqn8V/8lVtTFpbTeapbWE/UWTcne5gH5ohFkQMUPwj4yy97Bv979twiG+WvB
	 pqE5GOGIdKTO2FNRAfwX86JNR0S32OlQKpSPaJy1Fb+AH6+nXD9wdcvOCkMi0UqN++
	 9IW5uWjIMru7Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A3EEE17E35F0;
	Tue,  3 Dec 2024 10:40:39 +0100 (CET)
Message-ID: <d4ccb1fd-29a8-474d-9fb8-1cdc327b83c2@collabora.com>
Date: Tue, 3 Dec 2024 10:40:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/18] arm64: dts: mediatek: mt7988: add chosen node on
 bpi-r4
To: Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241202122602.30734-1-linux@fw-web.de>
 <20241202122602.30734-12-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241202122602.30734-12-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/12/24 13:25, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 

arm64: dts: mediatek: mt7988a-bpi-r4: Add default bootargs and UART stdout

> Add chosen node on Bananapi R4 board with stdout and default bootargs.

> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
> index 9037f35857a9..1c2a806f6f6c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
> @@ -9,6 +9,11 @@ / {
>   	model = "Banana Pi BPI-R4";
>   	chassis-type = "embedded";
>   
> +	chosen {
> +		stdout-path = &serial0;
> +		bootargs = "console=ttyS0,115200n1";
> +	};
> +
>   	reg_1p8v: regulator-1p8v {
>   		compatible = "regulator-fixed";
>   		regulator-name = "fixed-1.8V";



