Return-Path: <linux-kernel+bounces-407693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C332D9C72BF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 182B4B33282
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB09420100C;
	Wed, 13 Nov 2024 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtFUw7RA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182841EF928
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731505166; cv=none; b=rrGkmzomLXXkdopb7Cbkrf+/L79lo8y4v1I02EG1q8xFYOdK4jwvMJ3Zig8gb8HdXPINalsN/kh1M20y8ksGuOyxBfErDeyJXbfGMYYlY+0tqhO8hBd/CmjQ5jWAyYB6yjvpkjmqSAqe5cQXImCk65sZrzJwZIm59Y3V9bBZVlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731505166; c=relaxed/simple;
	bh=PUyWdRAPor1HzPSdiot0ngp/W3MbSaespHAsyVU7718=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XovMNdtSBcg9Izk2lBFwzskMVUME3kbjP2jiEXhVJPi+tyUXu3F4pf0kOGTdHPU3ycMabrrJ+tMnO5xOfMEhiigap3pv9YYu/b22n16ejGxYBqbF5nZR9fKrmrZZHXX9XDswYvyCN22Rm01k6tx4roIIT2WDFGihD0tF42fpawI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtFUw7RA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A240C4CECD;
	Wed, 13 Nov 2024 13:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731505165;
	bh=PUyWdRAPor1HzPSdiot0ngp/W3MbSaespHAsyVU7718=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OtFUw7RAXuI0Ss8WniSQQV7EGUxzQ7nhdrikjhDDVJ6cwGec5TZniWU4I7AKRDxFy
	 o+CsrdZkJeEFpi/m0PCqeww84iFuN+89ytAAFByeP9+PVArtjfaRfJ0ZOVPM1ee4V5
	 jKyIQpFy71Wdwj0tqovCFicX7PxtoxceB5hDm8GvK3ayLAXazocu/qfV1x2CdbO8gQ
	 nO3mfGFbgzw4r2YAANCnllOtmTqJGypOK4oiiok5jBN8HrNmT2Q/n4esHqZ3pWsUoN
	 bswIfp2QvWbgEi6wZqpnJyG1xNfgFPIp2z8YaFz+wTPWvvXOmXwoDjqKoGfFGjzGzo
	 oyoyBXTeL968g==
Date: Wed, 13 Nov 2024 13:39:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Suraj Sonawane <surajsonawane0215@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: aat2870-regulator: replace division condition
 with direct comparison
Message-ID: <ZzSsCoYy-Cs7d_Q7@finisterre.sirena.org.uk>
References: <20241112202041.16980-1-surajsonawane0215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nLVQnhLQ/VajP+vb"
Content-Disposition: inline
In-Reply-To: <20241112202041.16980-1-surajsonawane0215@gmail.com>
X-Cookie: Editing is a rewording activity.


--nLVQnhLQ/VajP+vb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 01:50:41AM +0530, Suraj Sonawane wrote:
> Fix an issue detected by the Smatch tool:
>=20
> drivers/regulator/aat2870-regulator.c:142 aat2870_get_regulator() warn:
> replace divide condition '(id - 1) / 2' with '(id - 1) >=3D 2'
>=20
> The division '(id - 1) / 2' was used to check if the regulator ID
> is greater than or equal to 2, which can be confusing and less
> readable. Replacing it with '(id - 1) >=3D 2' makes the code clearer

This is absolute nonsense, the tool should be fixed instead.  Writing a=20
division as a shift when the intent is a division is a microoptimisation
which modern compilers really should figure out where it's relevant.

> -	ri->voltage_addr =3D (id - AAT2870_ID_LDOA) / 2 ?
> +	ri->voltage_addr =3D (id - AAT2870_ID_LDOA) >=3D 2 ?
>  			   AAT2870_LDO_CD : AAT2870_LDO_AB;

Neither version of this is particularly readable, but the new form here
seems fairly clearly worse rather than better.

--nLVQnhLQ/VajP+vb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmc0rAkACgkQJNaLcl1U
h9ClDgf9F4AxWYIVBbx058j1yhrt2sJBOo5GQxOaNO1IpCmhAIYS8yFXLylbbGYs
Mx96eQMGubs7yJwMJtj4dD7MKe4UsFg/WyAv9XoQbhgVuJli9WdfxNsD9WOxi0Pf
pcmoQWDwlgzBfkSCLHdsWRIoedBzaggjlA8qL4oy37G01eUmEOiSIKLszPWxau61
sT3Vflpgo1Am2AhvZRIHqv9K5Q4027+alpxPhEqXZNL4dBxIjsbmE7JYRF8eI0Mo
76VcyEr/mh90nj5yysfWH/vMbz53b1jaem3Bn15jUj+Dx9QYx6PmcjHT16QPp0Fj
M3aVnSDg1j+8C6y0pUCRztUNuDoc5A==
=0SWd
-----END PGP SIGNATURE-----

--nLVQnhLQ/VajP+vb--

