Return-Path: <linux-kernel+bounces-406463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A99DE9C5F60
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8C7282615
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CCE2141A4;
	Tue, 12 Nov 2024 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALyCMJsv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1B61A4F21;
	Tue, 12 Nov 2024 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731433564; cv=none; b=AorQLm+bwe/lgN3z2wzESEYIg6/euNhDJcUGMLX1R4U3lycMMvljZTGT8NX00nhWPSOVzn/PKL7DiBbLGE44yngwo2VZmiRXUm07KnH2LBf9Aj1pamblu2uEqWzduMjq3FyhY1zF+oTRkrBY0Yr3wwVQypYwbkdACxThx/tu9hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731433564; c=relaxed/simple;
	bh=FYqoPFYrwvLuyx28eQcUzR0RgOVazKdDDyp0xfXcmhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0DchZwbjterXO82ga+cxj7RT9jNOggEZfioTUvVKydUGWzm0ec5GiN025UDvD2j7i0+4fppQJU1pGkWEDkOZdXk9CQO/NB8e1e1ogQjjM/P9mnzCL0PS48+S2GuyAWRklH2nKsrxB29ShAitj5ul+M4nUckL1lT0noDk8HjGTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALyCMJsv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA232C4CECD;
	Tue, 12 Nov 2024 17:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731433563;
	bh=FYqoPFYrwvLuyx28eQcUzR0RgOVazKdDDyp0xfXcmhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ALyCMJsvDL5DSsX2uc3VXK/FIfxoPaKy5rin8YjJyqrGqzv5cAR00nWAHnIKe4Gru
	 qoXL4+x6tplC+JDI1pKY+a7p1U7LBo/qpVj0t5ssEPW+iosdkaPOGp4TAKkQDjarsp
	 UzIdr1/sIcguMN7RhT/nuI8TLUMI0fUunqF2Mq3gUH55ezTd5ceONhmgWwWyW7C+dl
	 NAT3NduKG6E1Q07kGKnpFc+6HYaVJXF3rvzBMhqmGCVNzlW9Lr/AO2FILHgpI/zLVv
	 +ppRyjj7Jfoqk625EcRMZkLEuN7YDANyroAC3xMuD2FazhBwcdM3N53Voo71Zfdr6H
	 oMS/LBxU/LEYQ==
Date: Tue, 12 Nov 2024 17:45:59 +0000
From: Conor Dooley <conor@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andreas Kemnade <andreas@kemnade.info>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: bd71815: Fix rsense and typos
Message-ID: <20241112-surgery-clean-f1f6c0bb5248@spud>
References: <0efd8e9de0ae8d62ee4c6b78cc565b04007a245d.1731430700.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tJUu9GKmxcfm3z/Q"
Content-Disposition: inline
In-Reply-To: <0efd8e9de0ae8d62ee4c6b78cc565b04007a245d.1731430700.git.mazziesaccount@gmail.com>


--tJUu9GKmxcfm3z/Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 07:01:06PM +0200, Matti Vaittinen wrote:
> The sense resistor used for measuring currents is typically some tens of
> milli Ohms. It has accidentally been documented to be tens of mega Ohms.
> Fix the size of this resistor and a few copy-paste errors while at it.
>=20
> Drop the unsuitable 'rohm,charger-sense-resistor-ohms' property (which
> can't represent resistors smaller than one Ohm), and introduce a new
> 'rohm,charger-sense-resistor-micro-ohms' property with appropriate
> minimum, maximum and default values instead.
>=20
> Fixes: 4238dc1e6490 ("dt_bindings: mfd: Add ROHM BD71815 PMIC")
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--tJUu9GKmxcfm3z/Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzOUVwAKCRB4tDGHoIJi
0lWgAP45+Y1GowIP1Po4Q4NZAG32naTgDZYWqPixI9b8VI/eSQD/Z4FcBK1IX+Tt
KALW4R1IyiVjqCHlvjIsmEIC3QbW2Q0=
=0mRa
-----END PGP SIGNATURE-----

--tJUu9GKmxcfm3z/Q--

