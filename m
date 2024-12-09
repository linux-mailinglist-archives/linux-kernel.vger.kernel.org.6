Return-Path: <linux-kernel+bounces-438161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40109E9DA5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9114282E8D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833801B424D;
	Mon,  9 Dec 2024 17:57:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C591ACEC2;
	Mon,  9 Dec 2024 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733767022; cv=none; b=TCcuSGWGoLM+PJtLHJxapaS4Kx6o6nmEIr06LY9jPYjoZkE9P8PQQfyOWw/5KmVkAI5S3/so1ib6rq3vslkni/jUVZfv2TFo0/aVSMxfiqh/g97PGBN/SQ/qDVaWLSAcSUOm4FCQiDTNFkSVafurcJFYqFD5HjP0WklL83Q0hlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733767022; c=relaxed/simple;
	bh=j3n107nydMG2CyqGPgfya3Iv7yen6+NhL5BGnlDuAe8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mSnNm7oixJW5os+tnRpc/Xh5v+N+UarD5muN9agFPlG255LmA/gqbx0Zx89/8sSLmOLTM19FAnpY7SE6C0tKSXxmF1ew/VUkgbXJ9Qi02AODjLeKIhIru5HFK6Bny1iyT3Jx1204kD2wb6i5KaNzKWHSOQjng8Fctug7jpnpeFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC4551650;
	Mon,  9 Dec 2024 09:57:27 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB7173F720;
	Mon,  9 Dec 2024 09:56:57 -0800 (PST)
Date: Mon, 9 Dec 2024 17:56:54 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: "=?UTF-8?B?Q3PDs2vDoXMs?= Bence" <csokas.bence@prolan.hu>
Cc: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Mesih Kilinc
 <mesihkilinc@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>
Subject: Re: [PATCH 2/3] ARM: dts: suniv: f1c100s: Add support for Audio
 Codec
Message-ID: <20241209175654.673cf172@donnerap.manchester.arm.com>
In-Reply-To: <20241205000137.187450-3-csokas.bence@prolan.hu>
References: <20241205000137.187450-1-csokas.bence@prolan.hu>
	<20241205000137.187450-3-csokas.bence@prolan.hu>
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

On Thu, 5 Dec 2024 01:01:37 +0100
"Cs=C3=B3k=C3=A1s, Bence" <csokas.bence@prolan.hu> wrote:

> From: Mesih Kilinc <mesihkilinc@gmail.com>
>=20
> Allwinner suniv F1C100s now has basic audio codec support. Enable it
> under device tree.
>=20
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> [ csokas.bence: Rebased on current master ]
> Signed-off-by: Cs=C3=B3k=C3=A1s, Bence <csokas.bence@prolan.hu>

Compared against the F1C200s user manual:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi b/arch/arm/bo=
ot/dts/allwinner/suniv-f1c100s.dtsi
> index 290efe026ceb..e4b41bc93852 100644
> --- a/arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi
> +++ b/arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi
> @@ -336,5 +336,19 @@ uart2: serial@1c25800 {
>  			resets =3D <&ccu RST_BUS_UART2>;
>  			status =3D "disabled";
>  		};
> +
> +		codec: codec@1c23c00 {
> +			#sound-dai-cells =3D <0>;
> +			compatible =3D "allwinner,suniv-f1c100s-codec";
> +			reg =3D <0x01c23c00 0x400>;
> +			interrupts =3D <21>;
> +			clocks =3D <&ccu CLK_BUS_CODEC>, <&ccu CLK_CODEC>;
> +			clock-names =3D "apb", "codec";
> +			dmas =3D <&dma SUN4I_DMA_NORMAL 12>,
> +			       <&dma SUN4I_DMA_NORMAL 12>;
> +			dma-names =3D "rx", "tx";
> +			resets =3D <&ccu RST_BUS_CODEC>;
> +			status =3D "disabled";
> +		};
>  	};
>  };


