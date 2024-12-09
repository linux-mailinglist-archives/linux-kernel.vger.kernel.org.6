Return-Path: <linux-kernel+bounces-438160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6E69E9DA3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4BF41882394
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AEF1B4222;
	Mon,  9 Dec 2024 17:56:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E691ACECC;
	Mon,  9 Dec 2024 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733767013; cv=none; b=U93A1pOJbURPHOfDn9xBEpYNX4cOae+NqqfGIU7MiSA9O1MnBiJcNbbN6gx9KwCzPH00zloQB84ofNEMI+JKrU4K1Yx3zJCWH7BqXKF7NXnx+W1q8mU1/nXKJZaGudaq2UMuC2NHkkeaPXgH/VH4Ng6QXJ9mFlzTXz6ReyK7/sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733767013; c=relaxed/simple;
	bh=W9FPQOutx8gVYOk7R1nb+m7MpLo7h3sgEOsxlikF1NA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qbdrjcy8Ty9dkQexlf5CyN/6Sgr7NrG6DjAeNnKT3ZFJSao30M5QOvNuAhJxKyfbKHUcjKABy/afJGpSldujy8jowN8uEeQ5bTdqi0S9XLrnu12TyVkjhC83DIDSUbwZO8m0KSiq/H+9oXh+FpZ2Gs8ACZ8Q6HhJljY4kqBG51M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF9531650;
	Mon,  9 Dec 2024 09:57:17 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 899D53F720;
	Mon,  9 Dec 2024 09:56:47 -0800 (PST)
Date: Mon, 9 Dec 2024 17:56:37 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: "=?UTF-8?B?Q3PDs2vDoXMs?= Bence" <csokas.bence@prolan.hu>
Cc: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Mesih Kilinc
 <mesihkilinc@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>
Subject: Re: [PATCH 1/3] ARM: dts: suniv: f1c100s: Add support for DMA
Message-ID: <20241209175637.283312fa@donnerap.manchester.arm.com>
In-Reply-To: <20241205000137.187450-2-csokas.bence@prolan.hu>
References: <20241205000137.187450-1-csokas.bence@prolan.hu>
	<20241205000137.187450-2-csokas.bence@prolan.hu>
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

On Thu, 5 Dec 2024 01:01:36 +0100
"Cs=C3=B3k=C3=A1s, Bence" <csokas.bence@prolan.hu> wrote:

> From: Mesih Kilinc <mesihkilinc@gmail.com>
>=20
> Allwinner suniv F1C100s now has DMA support. Enable it under device
> tree.
>=20
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> [ csokas.bence: Rebased on current master ]
> Signed-off-by: Cs=C3=B3k=C3=A1s, Bence <csokas.bence@prolan.hu>

Compared against the manual:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi b/arch/arm/bo=
ot/dts/allwinner/suniv-f1c100s.dtsi
> index 3c61d59ab5f8..290efe026ceb 100644
> --- a/arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi
> +++ b/arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi
> @@ -6,6 +6,7 @@
> =20
>  #include <dt-bindings/clock/suniv-ccu-f1c100s.h>
>  #include <dt-bindings/reset/suniv-ccu-f1c100s.h>
> +#include <dt-bindings/dma/sun4i-a10.h>
> =20
>  / {
>  	#address-cells =3D <1>;
> @@ -159,6 +160,15 @@ usbphy: phy@1c13400 {
>  			status =3D "disabled";
>  		};
> =20
> +		dma: dma-controller@1c02000 {
> +			compatible =3D "allwinner,suniv-f1c100s-dma";
> +			reg =3D <0x01c02000 0x1000>;
> +			interrupts =3D <18>;
> +			clocks =3D <&ccu CLK_BUS_DMA>;
> +			resets =3D <&ccu RST_BUS_DMA>;
> +			#dma-cells =3D <2>;
> +		};
> +
>  		ccu: clock@1c20000 {
>  			compatible =3D "allwinner,suniv-f1c100s-ccu";
>  			reg =3D <0x01c20000 0x400>;


