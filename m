Return-Path: <linux-kernel+bounces-331110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2558697A894
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 23:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F5B2839CD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2094015B119;
	Mon, 16 Sep 2024 21:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="yWEpc4Mx"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E04517753
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 21:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726520944; cv=none; b=gcUWfVHRaa/ZajVah/woMJRWxFKvyksjJUrAV7ZITAVtdC7Y9LwIfskJaF9xC2VabVJH4tLo1zwE+r2eBEV2et8Qe2XGColdIzNQu9Z9MeBqqpro+4cIY7nZOkpsJPCiGB5SZphj9GiDcAsMRiJORKROENXqCAbv1Pul8kSoMWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726520944; c=relaxed/simple;
	bh=XxHAzuzTBnI5+iA9KB4svNMS3G+AiWxXLZfSvGHjSsk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tr9kWHDibkGBYxLcjPGub+ftnMOpB6vBRExnbGOZQZ08KnRGwVfBW/3FkBbvkHl+Thzs8SPVQXfcJFWxPRnF9VEKGcdiRvlEhz6cFXVSj7MeENpwv7FiI1/obgd/zNlyHffPEAbPaGphLCT06Ttt51Dp3uvRSKFr2E3ezCH3Le4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=yWEpc4Mx; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1726520932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLi7styXVTGwuulx+I+C4Q/VsEp7/nuBRguC7NX3Iyc=;
	b=yWEpc4MxBG2Jma2/Wb7G1Mu7zsAxnPzsj/UgMq65kTbw4qi7W+oNb7EhKwj+SGqJDnAo4e
	gBbecq6n84cDJ1mzPlR8LIYRWiK1Wag0fC/YbNrDGoaJopM9UDyF6LkaMDfejibvRevO5o
	FN4rrstZJEKkoRXWb2XxCqpuP/8XqRQMMeBV4LzTBp9iN2Vn27iiUbUYwHD6gNdzaSP0gR
	aRVIBKzMCxzDmHOTAIDn8iCTL6JlowFcyl1wsVGGxBC/l9FFboBJdBiVYY3/CY9wse9eii
	QLFFhLqANy//67VQbZrqXLBkUecv+X8Qp4TlwfE9y0fmTQ9QBA68oclFq1xKwQ==
Date: Mon, 16 Sep 2024 23:08:51 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>
Subject: Re: [PATCH] arm64: dts: sun50i-a64-pinephone: Add mount matrix for
 accelerometer
In-Reply-To: <20240916204521.2033218-1-andrej.skvortzov@gmail.com>
References: <20240916204521.2033218-1-andrej.skvortzov@gmail.com>
Message-ID: <6e5d0e9978bff30559c17f30d1495b59@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Andrey,

On 2024-09-16 22:45, Andrey Skvortsov wrote:
> From: Ondřej Jirman <megi@xff.cz>
> 
> accelerometer is mounted the way x and z-axis are invereted, x and y
> axis have to be spawed to match device orientation.
> The mount matrix is based on PCB drawing and was tested on the device.

This commit summary should be copyedited for grammar and style.  If
you want, I can provide a copyedited version?

> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> index bc6af17e9267a..1da7506c38cd0 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> @@ -229,6 +229,9 @@ accelerometer@68 {
>  		interrupts = <7 5 IRQ_TYPE_EDGE_RISING>; /* PH5 */
>  		vdd-supply = <&reg_dldo1>;
>  		vddio-supply = <&reg_dldo1>;
> +		mount-matrix = "0", "1", "0",
> +				"-1", "0", "0",
> +				"0", "0", "-1";
>  	};
>  };

