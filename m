Return-Path: <linux-kernel+bounces-237990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A18C69241CE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FF1BB26B7F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0AF1BA89C;
	Tue,  2 Jul 2024 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbDrvLqA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1A51BA09A;
	Tue,  2 Jul 2024 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932526; cv=none; b=G07zHyCAbH02jhLwgh6X6GUJ2J6NY0KBHdcmpIW2QBVQftmw0C8A4+12mWLXMV9KGWoRm2kKQpP76HBO6ciYgrnDYckVnXuPHDr1sIayQXAg+2eaW9ghu2jd++x/Wr8aU1PLBFxUgQhUKiJqHLjqbcA7M/Om1ZpnpGXD3/Az7K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932526; c=relaxed/simple;
	bh=B6tjxGnLQgoj1IytQ/eo5Iu+R/q+hbepkK4xDFWja10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgZqLlPp738HWmceebC59xuokYknC2qOGOPWp7Rr6CwqWlCL0RseBGpSB/NvILhZOKbL0PZ3CTCOkAhpAqVCJvTJkLOCVfLmLZVGw4rz8etfXyh3zNbYSJDzmxryz7eA4J+lc2nAo/ho76OxI4bH8pYa33MiTdKwYa12+XoDAB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbDrvLqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B19C116B1;
	Tue,  2 Jul 2024 15:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719932526;
	bh=B6tjxGnLQgoj1IytQ/eo5Iu+R/q+hbepkK4xDFWja10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mbDrvLqAfr4EkF0ngzbtNAxvqJxvlPYJgHBuOYeheEWJNgYfZeOxVTEckERxqu5hf
	 VWxmzMFWByxd5WPqk9abRZlRvxrWTPFIJbZwiuOB/f6ZVrcFSG0RKGLaeZyLnQMSuX
	 /LlhFgm6Ub24+efRXxocYe61vEKAZfI2IQfX5IfNuvbFdl8Rt85M2mA7R1tgYDRrOh
	 c1YeR5zgpKPsixLHqC1rsnNeIGR9jYadtSCK5qJNxkhfyG1pWDmQvB8Q+tHBKDXn9y
	 1C8a7HYh+ryHWfPYxDVFPG/A3HPAMvZUd6ge2owX1KG7IV1VUkfecD3BwVvXXEEY3B
	 qOTvz48Hm7myw==
Date: Tue, 2 Jul 2024 16:02:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Ved Shanbhogue <ved@rivosinc.com>, Matt Evans <mev@rivosinc.com>,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: riscv: Add Svvptc ISA extension
 description
Message-ID: <20240702-levitate-yearling-ccaf46b3f3fd@spud>
References: <20240702085034.48395-1-alexghiti@rivosinc.com>
 <20240702085034.48395-3-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qgVSvZz6tV6lbu8E"
Content-Disposition: inline
In-Reply-To: <20240702085034.48395-3-alexghiti@rivosinc.com>


--qgVSvZz6tV6lbu8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2024 at 10:50:32AM +0200, Alexandre Ghiti wrote:
> Add description for the Svvptc ISA extension which was ratified recently.
>=20
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--qgVSvZz6tV6lbu8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoQWaQAKCRB4tDGHoIJi
0t4RAP0YMZ30aVVzvbxUbn8v2FFdUJrA5ZRltgEOSgdCP7X5WwD/YF2VzRyRAHAs
o3Z63Gv1hdsVHwsL9qo8IICWs8kNSQA=
=7tPq
-----END PGP SIGNATURE-----

--qgVSvZz6tV6lbu8E--

