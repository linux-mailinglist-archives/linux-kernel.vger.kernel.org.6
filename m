Return-Path: <linux-kernel+bounces-354821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4CD9942FD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B72285743
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAE06A01E;
	Tue,  8 Oct 2024 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KI1ReXvH"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785FB13D601;
	Tue,  8 Oct 2024 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728377279; cv=none; b=AoTNsE3hn/pfJKwOt6V+RzJOhlWRoJ9bM+JkQAMHwV01hrvoi/B4qQihaFfl1eJZiPVzdZkocRamrSKMs/v26J1jFeM+QAciIZR5XeGJIk6KKygEd2z0FjpNRo309hh8NcpfX3WVy6b1GYUjTX1+ce+9PHxJQsnM5GEpazuggMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728377279; c=relaxed/simple;
	bh=7Y8lQEQ1hSkPSRcmmUUSa8wB76A6Q0NBQmCBMiUD9aE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZlzftTTBRW4IsxalyEvWyboyGzV0F5cSJ7NXFQpTWoMHhy/IrcsSz+AqEsivo6VV3rNC2qfA0Odk2H5pQPHnikoCUeYBaOSXrw9C3l96nGSy4E4ctCyWQnS3+uXPvbKTMhKJcMoIzGHEOPHzyXQ2f0Gzv1wj+8J+8REVF5Bc27o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KI1ReXvH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728377270;
	bh=7Y8lQEQ1hSkPSRcmmUUSa8wB76A6Q0NBQmCBMiUD9aE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KI1ReXvHXQ2poIhkcjZbkB7URqsfRYMuA9xMaic7FNi3sX+rZxp+mb/AJkzU4ZM1T
	 3+ytaIocV4KgBXsbqX59laXLsR016dAAp0Kz2pgkRPvQ9CVp+pePbWNEJHLReurHe4
	 l3OgU6HK1SAw6f72Gpljejv+iJUbuUhCfbZzcCRmEmRTM2yFQOeoqjMVLO2N6cYg0P
	 9aQE+P2BP+cV8RfMm5iudmY3fWdvUnw0ILp3mxexBL4/weEA4dZwAYGbYLgoze+fp9
	 3i6apt0HIxayZnS31vXWloCznUhEb/Ga7sl8ze/aaICSnLI0uREJYeN0b0SayRKUTM
	 vxog6+d/C3XxQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2F5FC17E10AF;
	Tue,  8 Oct 2024 10:47:50 +0200 (CEST)
Message-ID: <eab4ef1e-f63f-4561-b429-6dc3d7485871@collabora.com>
Date: Tue, 8 Oct 2024 10:47:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8173-elm-hana: Add vdd-supply to
 second source trackpad
To: Chen-Yu Tsai <wenst@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241008082051.4002438-1-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241008082051.4002438-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/10/24 10:20, Chen-Yu Tsai ha scritto:
> The Hana device has a second source option trackpad, but it is missing
> its regulator supply. It only works because the regulator is marked as
> always-on.
> 
> Add the regulator supply, and the required post-power-on delay.
> 
> Fixes: 689b937bedde ("arm64: dts: mediatek: add mt8173 elm and hana board")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>   arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
> index 8d1cbc92bce3..e03474702cad 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
> @@ -49,6 +49,12 @@ trackpad2: trackpad@2c {
>   		interrupts-extended = <&pio 117 IRQ_TYPE_LEVEL_LOW>;
>   		reg = <0x2c>;
>   		hid-descr-addr = <0x0020>;
> +		/*
> +		 * The supply is always on. Adding the delay here
> +		 * needlessly delays the readiness of the trackpad.

I'd say, let's be nice in this comment and let's explain the whole situation:

The trackpad needs a post power on delay of 100ms but, at the time
of writing, the power supply for it on this board is set as always-on,
so we don't add that to avoid useless delays in the readiness of this device.


...or....

The trackpad needs a post power on delay of 100ms but the power supply for
it on this board is always-on (and will always be), so we don't add delays
to avoid impacting on the time required for readiness of this device.

> +		 */
> +		/* post-power-on-delay-ms = <100>; */

Then you can remove this commented out property ;-)

P.S.: Just to be clear, what I dislike is to see a property that is commented out.

Cheers,
Angelo

> +		vdd-supply = <&mt6397_vgp6_reg>;
>   		wakeup-source;
>   	};
>   };


