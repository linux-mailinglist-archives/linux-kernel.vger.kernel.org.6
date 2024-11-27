Return-Path: <linux-kernel+bounces-423508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F106F9DA895
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 769EDB2359D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA6B1FCFF9;
	Wed, 27 Nov 2024 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Cnm7vLuE"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293691FCF4F;
	Wed, 27 Nov 2024 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732714492; cv=none; b=IqAr2RbEx6FRB0p2keuebu15TgvDdEO27jt1m7ZbhEPAQB+1ZP6FSfe2tQHSGecdTbSmg3UAycFcBnV1/kerz4TQRw8c3Fo/TX6TxP0w0E00hYNtI3/Ef6XQwvqd89lN7R9bXx8dTnW6kqHe8l/WRJpH3ui8DD9vOPrjUscSv+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732714492; c=relaxed/simple;
	bh=0DzS/hvPSQk+b4l5NxoXfskV324Gt7SiupY5t/eSfvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AvfDvfxmk4dhv73iq1LYBPaI3lI2upMEpk59kIsIW9hTlR7ksAJQN0p48nms6/MiP5LWpvAwXwzg7s30jtmXtE4BthSfySrpk8tJB7woldZn6JhxeLKJrlasscVwR1PKkxLNZC0XIFX69fu3x9u8xBzt5l3uAUXFkjdr7MesG5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Cnm7vLuE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732714489;
	bh=0DzS/hvPSQk+b4l5NxoXfskV324Gt7SiupY5t/eSfvA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Cnm7vLuEBZFdHgwxtj6D+qc4jelg37ktPyxqpJ1rDcqdT3g55CP+Y1biMLEekWwzJ
	 uqmyOaEgiSm/JCqIcKDa585u5aEUHoU+iDgGTHGCIGs0vGg5FTqSLMPzvKEgyqxJ5B
	 ce67AmuqSqc+/YqzsGmdlHa/MYcQyyEuor9WKUWKW3T/hYEmPX+c/MYKPnTboxsHDy
	 0R5JbYa6RHyXu9CH7QpKf0Fwte1DRputK60swXDJhXhs8I3gwH9oANCRGpzKIRtUZN
	 XnsfQlwHLnJHXL2spxqV/wDX0X82fLAF7yQmKyIOZg3JX5cVMKNAPgYoImA3j3LWTg
	 asephOtb7jp4Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E14E217E374C;
	Wed, 27 Nov 2024 14:34:48 +0100 (CET)
Message-ID: <adda796e-e03f-40f3-aefa-5fa8a9092844@collabora.com>
Date: Wed, 27 Nov 2024 14:34:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 11/14] arm64: dts: mediatek: mt7988: add thermal-zone
To: Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241029103937.45852-1-linux@fw-web.de>
 <20241029103937.45852-12-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241029103937.45852-12-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/10/24 11:39, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add basic thermal-zone node.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>   arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 39 +++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> index de9a9ff2edd8..a3a7deda35a5 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> @@ -379,6 +379,45 @@ clock-controller@15031000 {
>   		};
>   	};
>   
> +	thermal-zones {
> +		cpu_thermal: cpu-thermal {
> +			polling-delay-passive = <1000>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&lvts 0>;
> +			trips {
> +				cpu_trip_crit: crit {
> +					temperature = <125000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};

No, please just add "crit" - as that is the one that is used to not let the
SoC to reach Tj.

All of the others are board specific, so the trips down there (hot->low) are
to be added to your board dts instead.

Cheers,
Angelo

> +
> +				cpu_trip_hot: hot {
> +					temperature = <120000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};
> +
> +				cpu_trip_active_high: active-high {
> +					temperature = <115000>;
> +					hysteresis = <2000>;
> +					type = "active";
> +				};
> +
> +				cpu_trip_active_med: active-med {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "active";
> +				};
> +
> +				cpu_trip_active_low: active-low {
> +					temperature = <40000>;
> +					hysteresis = <2000>;
> +					type = "active";
> +				};
> +			};
> +		};
> +	};
> +
>   	timer {
>   		compatible = "arm,armv8-timer";
>   		interrupt-parent = <&gic>;



