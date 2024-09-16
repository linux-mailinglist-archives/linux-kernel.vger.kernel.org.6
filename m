Return-Path: <linux-kernel+bounces-330755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D448497A3D2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E98128A318
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E75715AD9C;
	Mon, 16 Sep 2024 14:08:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E2A15AADE;
	Mon, 16 Sep 2024 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495702; cv=none; b=lOWfsERvlRatBkXHdnZNez2A/pr/d3LI2Ub0qUhVE6RerPjsLqpABEddZNIA8Lwrp9yZqCfwN4pkSXlXK0uQ6n4a16qEcI54wEHgNMOQBR1vmCNAkU9ys/o1mnfqKB036CBoChlHHRYdyRTMNRCMxJyZfPjiWvvulm34Zqg6Tps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495702; c=relaxed/simple;
	bh=Y711tuCYCYeQ4ybUBi0ujUdlz7nkpz+HULZZPQxPNpM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ct9i23QzoZTSZlMVXwhNieV4M5RDkjvCADG+KEr/yVvwm7JhjzFieutvxPox1QrsDyqGRCEOU+goXQAni4sjhPNg6dqlkFcGihqzrnvjoetWPHb1n8H/elIrCyC2fm7G8AzvC75gWuMzSIHvY7I+6pbk1IQ/yXtARXHTBk7XFJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E34911FB;
	Mon, 16 Sep 2024 07:08:49 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DB623F64C;
	Mon, 16 Sep 2024 07:08:18 -0700 (PDT)
Date: Mon, 16 Sep 2024 15:08:09 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: =?UTF-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: h5: NanoPi NEO Plus2: Add
 disable-wp to mmc0
Message-ID: <20240916150809.21889537@donnerap.manchester.arm.com>
In-Reply-To: <20240914-b4-nanopineoplus2-fix-mmc0-wp-v1-1-12f54f0d6620@gmail.com>
References: <20240914-b4-nanopineoplus2-fix-mmc0-wp-v1-1-12f54f0d6620@gmail.com>
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

On Sat, 14 Sep 2024 12:07:00 +0200
Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com> wrote:

> The board does not have wp pin/switch for micro SD card (mmc0).

That is true, but for *every* microSD card. So I wonder if we should add
this property to all of the boards? I believe none of the arm64 boards have
full size SD card slots?

Cheers,
Andre

> Signed-off-by: Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts=
 b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
> index 526443bb736c..18fa541795a6 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
> @@ -136,6 +136,7 @@ &mmc0 {
>  	vmmc-supply =3D <&reg_vcc3v3>;
>  	bus-width =3D <4>;
>  	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
> +	disable-wp;
>  	status =3D "okay";
>  };
> =20
>=20
> ---
> base-commit: 57f962b956f1d116cd64d5c406776c4975de549d
> change-id: 20240914-b4-nanopineoplus2-fix-mmc0-wp-9d77fb9e6513
>=20
> Best regards,


