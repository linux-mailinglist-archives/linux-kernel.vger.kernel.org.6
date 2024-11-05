Return-Path: <linux-kernel+bounces-396310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FE19BCB52
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE36D28417F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD89C1D359C;
	Tue,  5 Nov 2024 11:10:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5085A1D2716;
	Tue,  5 Nov 2024 11:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730805044; cv=none; b=DoEVccf0BSPQH92KNCCGddB5A1dwIMo6WO4/NLb5hemRfrlQKuZlISw/Y0RnnJWyYpHWVK7SwOm9dnFCr+hp0FdrmmWW0MVCQsZ3pXcWnvm5zon3DcaWb8jM3GAckpSeYyoxyDxEs3iovuJInmyHLJHV0YbXTQO80o9ATWkJWDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730805044; c=relaxed/simple;
	bh=ImwJg+WVAMwlkrc/JFWtaHbZmvhhjV1TC5GgA3Ye4S0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QCKnCYY1tUYM8IqCeHgR9eW7xeERrpxI05RG16JZfaaXl4/BiF0uj1CGZaN3h8ZW9EdMDRwyYV7sSpipGyjR/ISFQUEnRkdwigzjZFsuPyOY8pACJPlliLGiLYJoSWMI0HrujpJZvQcYjisBxBjTUKR2qOgOAymGABgrUG3MiwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69134339;
	Tue,  5 Nov 2024 03:11:10 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DCA03F6A8;
	Tue,  5 Nov 2024 03:10:37 -0800 (PST)
Date: Tue, 5 Nov 2024 11:10:33 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: "=?UTF-8?B?Q3PDs2vDoXMs?= Bence" <csokas.bence@prolan.hu>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Enric Balletbo i Serra
 <eballetbo@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 "Tony Lindgren" <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>,
 "Kunihiko Hayashi" <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH] ARM: dts: allwinner: Remove accidental suniv duplicates
Message-ID: <20241105111033.462acd82@donnerap.manchester.arm.com>
In-Reply-To: <20241104230628.3736186-1-csokas.bence@prolan.hu>
References: <20241104230628.3736186-1-csokas.bence@prolan.hu>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Nov 2024 00:06:27 +0100
"Cs=C3=B3k=C3=A1s, Bence" <csokas.bence@prolan.hu> wrote:

Hi,

> Allwinner suniv boards' DT files were accidentally duplicated
> in the Makefile when they were moved to the new directory
> structure. Remove these duplicates for code cleanness.
>=20
> Fixes: 724ba6751532 ("ARM: dts: Move .dts files to vendor sub-directories=
")
> Signed-off-by: Cs=C3=B3k=C3=A1s, Bence <csokas.bence@prolan.hu>

Ah, good catch!

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arch/arm/boot/dts/allwinner/Makefile | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/allwinner/Makefile b/arch/arm/boot/dts/all=
winner/Makefile
> index cd0d044882cf..2ea5df3d9894 100644
> --- a/arch/arm/boot/dts/allwinner/Makefile
> +++ b/arch/arm/boot/dts/allwinner/Makefile
> @@ -268,7 +268,3 @@ dtb-$(CONFIG_MACH_SUNIV) +=3D \
>  	suniv-f1c100s-licheepi-nano.dtb \
>  	suniv-f1c200s-lctech-pi.dtb \
>  	suniv-f1c200s-popstick-v1.1.dtb
> -dtb-$(CONFIG_MACH_SUNIV) +=3D \
> -	suniv-f1c100s-licheepi-nano.dtb \
> -	suniv-f1c200s-lctech-pi.dtb \
> -	suniv-f1c200s-popstick-v1.1.dtb


