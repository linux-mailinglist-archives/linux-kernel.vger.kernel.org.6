Return-Path: <linux-kernel+bounces-268768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E17AF94290F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8161C20FCF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E095D1A7F93;
	Wed, 31 Jul 2024 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eQuyrOJM"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3AF1A71F7;
	Wed, 31 Jul 2024 08:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722414083; cv=none; b=oKfodqz5T9V6CQAbmetvpUp9eO1oo+TG89prFdq9kQZ9TRZXtPuTWtvwXeb2mMocr7ZAYTZp0yn3KoTJaTPp3uazFnuFZpRUsTFAeG6zaxs+vV/YABLBf7+E+PYz4Dj4MfdVHG9ZXWVwZolr41UwFAULhKsnHf3L8c7EFSqGOZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722414083; c=relaxed/simple;
	bh=XvOseKdPDeiZOL5iY3NTqf4lGmanWm38s3cef+z6OV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RtVRbbzKMu9102aC5C+jAAMiDHK71rkEkeWCK+s/mzpWe4S3aERrYY8TwMRSTmiy+soehUNCG+NlfAyjlMtmQetay1a4culHMYnmJz4IjtXLBqVwKjkjH5CvwS99XacVRk86G5zSl9SdxBUNqbzmFvmWpofCkwOd8FWh+rpFph8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eQuyrOJM; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722414080;
	bh=XvOseKdPDeiZOL5iY3NTqf4lGmanWm38s3cef+z6OV0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eQuyrOJMNX6MC7AYBXZyXiXDz3KkG4/EpJBC31guT23ZMqJo233kjA03RXD29lQ7w
	 HhzYHHlGhB/Epd7iR/sjmDZj8E4gCj+ASP+QVdu27pja1C15i/COtg0Brlz8u+na/s
	 PJyPiajPdgt7Y+oRDodb/Ysu+gxugSKkNxn/hECWHnNqqVA8qjZ99bYIdT3gm5hO2y
	 jrPwxasS+mH+eGfw6QeIQAozJp+9t7CjA6RRXfd+cSRmpE5TwomMVc+j4aOyupRzcu
	 r3gbtDTBZVWgbdanzx0zM2flmRcJEFeG/q1JgF8JnP+AWYhouuZvIjFEoQ1fkO+dTB
	 P4rZ7IHsPh2eg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 87CCC378000B;
	Wed, 31 Jul 2024 08:21:19 +0000 (UTC)
Message-ID: <8c4e777d-4698-446d-a29a-5df7e49e88d3@collabora.com>
Date: Wed, 31 Jul 2024 10:21:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: mt8183: Add kukui-jacuzzi-cerise
 series boards
To: Hsin-Te Yuan <yuanhsinte@chromium.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240731-jacuzzi_dt-v2-0-4995335daa30@chromium.org>
 <20240731-jacuzzi_dt-v2-1-4995335daa30@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240731-jacuzzi_dt-v2-1-4995335daa30@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 31/07/24 08:26, Hsin-Te Yuan ha scritto:
> Cerise is known as ASUS Chromebook CZ1.
> Stern is known as ASUS Chromebook Flip CZ1.
> 
> They are almost identical. The only difference is that Cerise is a
> clamshell device without touchscreen and Stern is a convertible device.
> 
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> ---
>   arch/arm64/boot/dts/mediatek/Makefile              |  4 +++
>   .../mediatek/mt8183-kukui-jacuzzi-cerise-rev3.dts  | 26 +++++++++++++++++++
>   .../dts/mediatek/mt8183-kukui-jacuzzi-cerise.dts   | 26 +++++++++++++++++++
>   .../dts/mediatek/mt8183-kukui-jacuzzi-cerise.dtsi  | 21 ++++++++++++++++
>   .../mediatek/mt8183-kukui-jacuzzi-stern-rev3.dts   | 29 ++++++++++++++++++++++
>   .../dts/mediatek/mt8183-kukui-jacuzzi-stern.dts    | 29 ++++++++++++++++++++++
>   6 files changed, 135 insertions(+)
> 

..snip..

> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cerise.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cerise.dtsi
> new file mode 100644
> index 000000000000..087a0ef33e13
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cerise.dtsi
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2021 Google LLC
> + */
> +
> +/dts-v1/;
> +#include "mt8183-kukui-jacuzzi.dtsi"
> +
> +&cpu_thermal {
> +	sustainable-power = <4500>; /* milliwatts */
> +};
> +
> +&mmc1_pins_uhs {
> +	pins-clk {
> +		drive-strength = <MTK_DRIVE_6mA>;

Sorry for not noticing that in v1, I have one more nit: please do not use
the MTK_DRIVE_(x)mA definitions.

This is just `drive-strength = <6>`.

Thanks,
Angelo



