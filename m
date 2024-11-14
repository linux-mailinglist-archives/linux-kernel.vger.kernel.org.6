Return-Path: <linux-kernel+bounces-409894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE059C92FC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37CD81F22481
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5871AB50B;
	Thu, 14 Nov 2024 20:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifBLn+y6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CF51A9B5D;
	Thu, 14 Nov 2024 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731615100; cv=none; b=Lhy9Q79MsNndFhp6Xmjwrtt5xGLAcHnx9t/viaMKzXfWTVxuU4hEwfsB0yY3GlAQT+0yARHzrrfbzsvAVhkb2MfHEHusgyOi+bwSbZFVIvurDonW539Dm0fi4N4St3eRFIMjhbeQb0uaWPQUkDgSPfVURHhzGpMdZUMzAQYIUXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731615100; c=relaxed/simple;
	bh=GStnpoZ+VQ6uDrKHaa71APEXa76ZcpeNnKiOpUy9XOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVAYElbgR6wlO1+3i+fJN0D/4218wGGavf0rqyiJvmk2a7KblrqLorYBk2ROLX9HfM2svLNUhurk3TzX714n6G+02juJwJmMaEb/mx2whYMIhs9Rsp1SCAmKLiFbjs7GdvUNZYh3PAJexd7KQrbJN6sImLIEViUgiMHFWu6hTH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifBLn+y6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8272BC4CECD;
	Thu, 14 Nov 2024 20:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731615100;
	bh=GStnpoZ+VQ6uDrKHaa71APEXa76ZcpeNnKiOpUy9XOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ifBLn+y62V3OgsjgceF9S0OjLQq2V2zdc5EvQrPQ2LsdRtb5KMuqfW5qZ9iM0oPDI
	 f5nqFA5ySmqKwJwV7+tCuCtWg893zbyZrtLubPym2lnbZlyYnZsbB0Xd9DFWZCgBAw
	 WmMZE68SS74Myf2E2eh30vivlLqQNlji2dknEOdoSva4VYXTM0vtHFO55mO7INKMVK
	 YTeyIEQz1TM7AAfxZQuLbk8xeeONbPk+q9R+1OsPfcTB2TD+E33TlM/KKIkf7NnsXf
	 lqL8o/D0N7B/arozKflimwe8EFFqrqI4zpcJKfHbyzv8GfuRvHMoBz0dlOdd6OS3Pn
	 38dhUZnaMoeKg==
Date: Thu, 14 Nov 2024 20:11:35 +0000
From: Conor Dooley <conor@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	ssantosh@kernel.org, nm@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	s-anna@ti.com, kristo@kernel.org, srk@ti.com,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: soc: ti: pruss: Add clocks for ICSSG
Message-ID: <20241114-convene-reseller-84a0bcd98882@spud>
References: <20241113110955.3876045-1-danishanwar@ti.com>
 <20241113110955.3876045-2-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V/kjFjce5AftHnAw"
Content-Disposition: inline
In-Reply-To: <20241113110955.3876045-2-danishanwar@ti.com>


--V/kjFjce5AftHnAw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 04:39:54PM +0530, MD Danish Anwar wrote:
> The ICSSG module has 7 clocks for each instance.
>=20
> These clocks are ICSSG0_CORE_CLK, ICSSG0_IEP_CLK, ICSSG0_ICLK,
> ICSSG0_UART_CLK, RGMII_MHZ_250_CLK, RGMII_MHZ_50_CLK and RGMII_MHZ_5_CLK
> These clocks are described in AM64x TRM Section 6.4.3 Table 6-398.
>=20
> Add these clocks to the dt binding of ICSSG.
>=20
> Link: https://www.ti.com/lit/pdf/spruim2 (AM64x TRM)
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--V/kjFjce5AftHnAw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzZZdwAKCRB4tDGHoIJi
0nMTAP4yuPMHFxAERFbK6P2x0JNdAaZSUYUH7R613NAJWVXPUgD/V3Qi3VBQ6Qtx
zaDDBbWph9y+Hetql40pzTNs2EvwjQQ=
=Anq3
-----END PGP SIGNATURE-----

--V/kjFjce5AftHnAw--

