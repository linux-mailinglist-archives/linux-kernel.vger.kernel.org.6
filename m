Return-Path: <linux-kernel+bounces-428047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094989E0966
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F6C2824F8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8155C1DA0EB;
	Mon,  2 Dec 2024 17:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="VJZ4NDMG"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82C21D6DB0
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159122; cv=none; b=fNisRdEk9RZiYwtFvN3cVsL+nyoTbN88dP40iI64PMdPBM/+BKcPF650sjb5WUaTqZ9LEC9w/TlBQ6gKJlt6UkaHyoY02A7pqsyw1p4OjWyPexn7/hqYIdxy3uBPRCiAj4xHCx3bn48roYWFKXin1YkEPisf6PBS5UBGAw+sVH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159122; c=relaxed/simple;
	bh=zJYXkTKsJoO27+zOwQFYPrBEnFxvuMvJSvVvulZQuxs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sMYlJ2JDpGb6DmOQU+szmEciTz4Ayer5q7XI5LMAqwTyVQp3X/dXr2opjsRx5UX90DYNAgFWSGomVVOAeOx+jbTGYqey4T0tOxO8xDI8IxlFFlVCL6hsGgyKs8Z/b/VjYk6g1pUGjrcySVx2wKX/x026oxgxWNEf/O9RbIBsVOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=VJZ4NDMG; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1733159115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gOAOvw778ddifzLBAVTAVA7ViPhpzAN8s/3Zy+v6TwY=;
	b=VJZ4NDMGPhmVUUl1yFPrEKK3II45/5cEG2KXmEIfKitVGXhwnFNbVoGxcw2RA2nGUo9wBD
	fv4uKeEhwV74RapauaXWTUbqb33nust/6u4NsclfxW9Bs2kKz3+XoSnJq2I04iI/JbZkII
	RfnXhA530DawCl08cSo2nGgTJdfxn3RAGqK26ITNMxYy3QqAjtIfTIrqLRGO55MuXb1zQ4
	cOY2Hs9H+0qN/b2nnO6ELaMVgL0IrjPsZ+2W2OpwQv0+HyYt/x7BJv/TbUrVq1BK0KCiBx
	t17qD8DWYubEJviYSZYrX/sKuksIoEhA15bjiuRjnI1AWh3BUW5qGLBjBW0hiw==
Content-Type: multipart/signed;
 boundary=7e48cb5c561c9c94c8ce91377d76abea74c76a1a74e817be5c3f74398612;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Mon, 02 Dec 2024 18:05:03 +0100
Message-Id: <D61DMK8O9JCR.1C62A5UGI51BT@cknow.org>
Cc: <heiko@sntech.de>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <marcin.juszkiewicz@linaro.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Describe why is HWRNG disabled in
 RK356x base dtsi
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Dragan Simic" <dsimic@manjaro.org>,
 <linux-rockchip@lists.infradead.org>
References: <6b272e2f8f916c04b05db50df621659a5a7f29ab.1733149874.git.dsimic@manjaro.org>
In-Reply-To: <6b272e2f8f916c04b05db50df621659a5a7f29ab.1733149874.git.dsimic@manjaro.org>
X-Migadu-Flow: FLOW_OUT

--7e48cb5c561c9c94c8ce91377d76abea74c76a1a74e817be5c3f74398612
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

I'd have swapped 'is' and 'HWRNG' in the subject, but otherwise ...

On Mon Dec 2, 2024 at 3:44 PM CET, Dragan Simic wrote:
> Despite the presence of the hardware random number generator (HWRNG) in t=
he
> different Rockchip RK356x SoC variants, it remains disabled for the RK356=
6
> SoC because testing showed [1] that it produces unacceptably low quality =
of
> random data, for some yet unknown reason.  The HWRNG is enabled for the R=
K3568
> SoC, on which the testing showed good quality of the generated random dat=
a.
>
> To avoid possible confusion in the future, [2] let's have this described
> briefly in the RK356x base SoC dtsi.
>
> [1] https://lore.kernel.org/linux-rockchip/cover.1720969799.git.daniel@ma=
krotopia.org/T/#u
> [2] https://lore.kernel.org/linux-rockchip/20241201234613.52322-1-pbrobin=
son@gmail.com/T/#u
>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/b=
oot/dts/rockchip/rk356x-base.dtsi
> index 62be06f3b863..ab8f42c0a843 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
> @@ -1032,6 +1032,11 @@ sdhci: mmc@fe310000 {
>  		status =3D "disabled";
>  	};
> =20
> +	/*
> +	 * Testing showed that the HWRNG found in RK3566 produces unacceptably
> +	 * low quality of random data, so the HWRNG isn't enabled for all RK356=
x
> +	 * SoC variants despite its presence.
> +	 */
>  	rng: rng@fe388000 {
>  		compatible =3D "rockchip,rk3568-rng";
>  		reg =3D <0x0 0xfe388000 0x0 0x4000>;

Reviewed-by: Diederik de Haas <didi.debian@cknow.org>

Thanks for this :-)

--7e48cb5c561c9c94c8ce91377d76abea74c76a1a74e817be5c3f74398612
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZ03oxAAKCRDXblvOeH7b
bnskAQCQUuFH8eysdScwXJpiPkXXRdU7mTDzJMtkUptCsFOzoQD/XP1IvlnN/atD
YZ36wXEYt7ZtYgV2N+r28ZD2HWPOIgY=
=+WZI
-----END PGP SIGNATURE-----

--7e48cb5c561c9c94c8ce91377d76abea74c76a1a74e817be5c3f74398612--

