Return-Path: <linux-kernel+bounces-337330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2D79848C2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDFF81F227F3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684091AB536;
	Tue, 24 Sep 2024 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiwZvOHw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C3A1A76CB;
	Tue, 24 Sep 2024 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727191990; cv=none; b=tPr0Cy5a+909ZLQLgH9q9eNDI1+8UyknKJzIWfYqBUq8DPGuwVUfuoNt/7fmImnHzTw1HoaaFtsojAW3neX/CE7tdIll8jz7IGkhGeDNkTkRPhpnO90un28b+T2TGoaCw4s3OcNXDjAIE4Inin9ZORAhDCksLPXTs0IXLmbSddo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727191990; c=relaxed/simple;
	bh=rp42thTCOVk9AW470ux8OLLnl4FRDnW/Qwc1oElGne8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMYABvSrIIcY/za2N8HYvoAsoHSpFndPXm6yMcZL1LVa+8atzOdBgFhXQcmMcRPJapeFlqWqr1ztoAyakQOi5Ng9CJU0TekPTVS0ZtnFevzjD2BBoIqDfwZXv5DwWi0vH7u3SPhB5sAHQzKTWb9fM79fZ6yaEqgTrsi/x7QSjmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiwZvOHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFB7C4CEC4;
	Tue, 24 Sep 2024 15:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727191989;
	bh=rp42thTCOVk9AW470ux8OLLnl4FRDnW/Qwc1oElGne8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MiwZvOHw1hEGfIjkgfneL+vA0eAlqa9gZSQDAkxKYhwyQYhZO94x06FCzjZjMTClq
	 G7/ouUlPVwsrCv5S1V3Lz5xIAXoOF2qgGA1vQyyPXzVPEchYYxzhTBYGhtLgSPvaXp
	 F8t4iAXzDSMPztjt6laZ4a/lwhIFeqo2A/lpjORNT0BBeU5cZO5We4ETRVqurHHiy0
	 JnoDMTREp2zRWUFR/ak6ZzCGO5pTJ6pfEIipS4Hagq5WPUmORaxn5CPkeG5vTSS3kD
	 ftAPsrDoVuGAlEc+syEzXLX7wcfq5Y40ea7/EU95VGZggWlBOF8xoGkj1M8bPcxYxu
	 zWCQ4oyz9eKWQ==
Date: Tue, 24 Sep 2024 16:33:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: arm: ti: Add verdin am62 ivy board
Message-ID: <20240924-covenant-pretzel-27ee6de1e4f9@spud>
References: <20240924120044.130913-1-francesco@dolcini.it>
 <20240924120044.130913-2-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="69juAoSdyOKEhvH8"
Content-Disposition: inline
In-Reply-To: <20240924120044.130913-2-francesco@dolcini.it>


--69juAoSdyOKEhvH8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 02:00:42PM +0200, Francesco Dolcini wrote:
> From: Jo=E3o Paulo Gon=E7alves <joao.goncalves@toradex.com>
>=20
> Add Toradex Verdin Ivy carrier board support.
>=20
> https://www.toradex.com/products/carrier-board/ivy-carrier-board
>=20
> Signed-off-by: Jo=E3o Paulo Gon=E7alves <joao.goncalves@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

o/

--69juAoSdyOKEhvH8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvLbsAAKCRB4tDGHoIJi
0nQVAP9BJDN8DV6msorupLqcbNkzNeZJXds89KYxmdY/1MyHhQEA5UOKgEojzKTR
qyZY0xk5lZXAcVrVStM9Z+xaB4DnZww=
=czOm
-----END PGP SIGNATURE-----

--69juAoSdyOKEhvH8--

