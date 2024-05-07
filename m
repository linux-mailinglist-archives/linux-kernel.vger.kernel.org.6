Return-Path: <linux-kernel+bounces-171608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A7A8BE659
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72DB8287CC6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275D215FCF9;
	Tue,  7 May 2024 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUTozYw0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D41314F9E7;
	Tue,  7 May 2024 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093174; cv=none; b=XyNL1p3GivzTASML7PFDxM092krvcJC8jHfgBsfAGL8OTvtiQFbu4pUu9kGFfG3F0zZpU6Ig6qMi9QBEdGBvWvrnZ0KP0X0MX8BZ3N8kMQMlJzduE2SwLHD5LYNfClWE2OuG7miqhmn1vYx+O/O8Rrq9qH4Y0uYCicg9SD3MUIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093174; c=relaxed/simple;
	bh=qiFNPy/M5xOU5Apj9nac5g7waihj20lGR0JTxp/W0yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpKJAnoG9Hpefm9FSpiznRC3Wgs3u9zbtF8+jrCzS74PGhzzPw+fcDRu/o2qt6aXFEKice4WYH0RZuKqobr2OoBCiGQuJn4JC0s3MQd+mLyF/NHVCxiAS2pTnKgU9RuiNqWkUn701OcrC6N7SKlqGeS+/KsBEhb6v2eYJaB4AF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUTozYw0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418CAC2BBFC;
	Tue,  7 May 2024 14:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715093173;
	bh=qiFNPy/M5xOU5Apj9nac5g7waihj20lGR0JTxp/W0yE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YUTozYw0dRedidCouZw5ma8UL+1Fw04tn0qL3gQV5eRykuOLDq1S7+JwGKmTojTu/
	 EaeeuOozEFEQXsDLLDBs1eTwEZEXDNVQRoSDJ1cbDiRDSMULGuCSg8IdOskoFryVKm
	 rz+VjcEMRi7fxAYj3sHK3PnTJZeObHZMoATG9zDtC98PENpUET/5Dz0jdKUAfSDRT6
	 1caDXiaAwVs4lXMDKMU/qJSd1d5JGOZHWT9PpMqNaqyNGYSzl3kjzNXfxLa+ygZE7c
	 IYYhG0H4h+EiWY/BR/BfQ+okjP3CfEUGzRVKHYRfzwyFfJ/vYJJiegawG+mipEZFRb
	 R3nifGxAGFMBQ==
Date: Tue, 7 May 2024 23:46:10 +0900
From: Mark Brown <broonie@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH RESEND v5 0/2] regulator: sun20i: Add Allwinner D1 LDOs
 driver
Message-ID: <Zjo-sri2pdGvKhSf@finisterre.sirena.org.uk>
References: <20240507041343.272569-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UCN6/5XXExvlKu29"
Content-Disposition: inline
In-Reply-To: <20240507041343.272569-1-wens@kernel.org>
X-Cookie: Accuracy, n.:


--UCN6/5XXExvlKu29
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 07, 2024 at 12:13:41PM +0800, Chen-Yu Tsai wrote:

> This is a resend of the Allwinner D1 LDO driver series, separated by
> subsystem. This part contains just the regulator driver bits. The sunxi
> SRAM binding part will be sent out after the merge window due to a
> conflict in next.

..

> A binding and driver change is required for the SRAM controller, to
> accept the regulators device as its child node.

This says that the driver depends on the SRAM change which isn't getting
merged this time round?

--UCN6/5XXExvlKu29
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmY6PrIACgkQJNaLcl1U
h9AD3Af+IWzVr09AiNNVmrouYJlCu8NcxH1hYJ+2QieMfh4KGAydlzDNG3vVqbgJ
mU2B5b9vHImlN81O9JXUigPatD37A3/r6qWdbrkBm2dNjVyClnVSfyYx6206X9jY
hX0vP8E38zX/H7WOQUNu3H1JHb9ZXKk5R0glOxD5Og2R4uYL4z8hLa95a5kwE0cr
N+m1+a3cCwUHoCTjDrF89ohW5uvc0kYNfoL2AOXBm4wBGp2h5OdkuQZ+zZIm/Spm
/muzCAR2NPm4KPDVRPOfnEFV9Owi7S7MXqKiDSRjw3vwj48B3iNf5mi3rzbQtZeM
XdazcU716hFKn5T7zftKinJZMyFAeQ==
=w44p
-----END PGP SIGNATURE-----

--UCN6/5XXExvlKu29--

