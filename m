Return-Path: <linux-kernel+bounces-404659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7649C464F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568C21F220B0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C677F1ABEC2;
	Mon, 11 Nov 2024 20:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rn9etF7X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D5619E98C;
	Mon, 11 Nov 2024 20:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731355463; cv=none; b=NFStaGmQRT91L5cvIY88WV2AwTqiI45qRwizhJkCk6c/md1iGlWQOSw+SUGRai7DHRrCZ/a8uCs4ZbdiXin0YwtF8hG7/f2OATS0sMU58eYnPNSNuTBrTWlZkLn7khw+sZVplpBbsWHGX8F3v/ywVHIWnUki9ZPX/6hZV/McP/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731355463; c=relaxed/simple;
	bh=v6+m/s+QeGeixlzJPxZyipchH0n2hYfrSg8Jh/JRQuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiTaRvFOb50gLBGGeFIJjYr2/ke4xwaNVkM4eKGX82adzYJgxwnm0AtSMC1RGVImrGTXwd6iMW/OEcAMjg/vazqFFZwFAx7/ubmbfhNoRXg5k/oQv9aXm6yC8hnDlCBrcz/H4qsuj/TSSFQloblrBxdmAEJg3TaZTJtGlq53i0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rn9etF7X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611F2C4CECF;
	Mon, 11 Nov 2024 20:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731355462;
	bh=v6+m/s+QeGeixlzJPxZyipchH0n2hYfrSg8Jh/JRQuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rn9etF7XIiu3wEh1IeIpq2fQ84uKYd6LujL4Yl3r1Mvrkr0ACzne0+PnR8uY0mW4x
	 gV5jYbu8p6gHwUDlpGtrXA54rJAXPGu/NI2yEPm/f4vHH35Cnb+NetBxN0zN0rGjsd
	 xYWV8hUeBUeKNWG5Jdjah3WLQeGw9B4bl/xQXpFs5/krwFDsRboaBe2uzjD4PGR+te
	 V4eaCcCPxcjTZu2n8wnmmJF9d/b8cHho+YxSMpF5rTEtarIDXrjZYGYwuryuhkBpxV
	 sYwoRkPoG6gSshMbW+MiyB85n23zRVr0AdDQQZIGMK8L/B9ojKdBXqUZR1a1yyXN7U
	 Lh2QG8AkSF/WA==
Date: Mon, 11 Nov 2024 20:04:17 +0000
From: Conor Dooley <conor@kernel.org>
To: codekipper@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@vger.kernel.org,
	linux-sunxi@googlegroups.com, linux-sunxi@lists.linux.dev,
	devicetree@vger.kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org, jernej.skrabec@gmail.com, samuel@sholland.org,
	andre.przywara@arm.com, wens@csie.org, macromorgan@hotmail.com,
	jszhang@kernel.org, uwu@icenowy.me, ryan@testtoast.com,
	dsimic@manjaro.org, mripard@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: sunxi: Add the X96Q Pro board name
Message-ID: <20241111-drank-spindle-68237e9c75e8@spud>
References: <20241111162524.46812-1-codekipper@gmail.com>
 <20241111162524.46812-2-codekipper@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9nO1kpF93hm9EhKP"
Content-Disposition: inline
In-Reply-To: <20241111162524.46812-2-codekipper@gmail.com>


--9nO1kpF93hm9EhKP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 05:25:05PM +0100, codekipper@gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>=20
> The X96Q-Pro TV box is a Chinese Android TV box, using the
> Allwinner H313 SoC. It is sold under the X96mini brand which
> is a subsidiary of the Shenzhen Amedia Technology Co., Ltd
>=20
> Add the board/SoC compatible string pair to the list of known
> boards. Since the H313 does not look different from a software
> point of view, we keep the H616 compatible string.
>=20
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--9nO1kpF93hm9EhKP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzJjQAAKCRB4tDGHoIJi
0oUXAQCl7ID5xf3x6WIKRRZfLVcTsY+tUmyigc08YwS0XGBgLQD/dPW8qr1Ihyiz
l7fyKWTEdjXiLo0zjGnWNihx8PrEmQM=
=n1Ep
-----END PGP SIGNATURE-----

--9nO1kpF93hm9EhKP--

