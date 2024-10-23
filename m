Return-Path: <linux-kernel+bounces-378653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C19889AD3BA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D616E1C203A3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62141D0943;
	Wed, 23 Oct 2024 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMujR2cv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB4E1CBE9A;
	Wed, 23 Oct 2024 18:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729707265; cv=none; b=mBdJFcU8u12i1sI5Edie3JLO/vnvmKAOEOBQmTbTHKoqN3IhGhI73kH/VK9WzghILeqTbp4mdKZMEwAxajsjiEBZsNXSNykBPC8gv5Ta7xRnTuIDkPszpDz4QGWGOh0B0ODsJ8jxq/xHQvSDsL+wkGfbL/x6tzYH7VJ73DiuOYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729707265; c=relaxed/simple;
	bh=NkQ9rSmHASrg89hsQ5w9r7/BET67ZjInamDtzc0DG28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FT75K1HvJnGeFCCTHGC9wQYF873adw2rsASVt5CKV7/k0AX9vsUdcWBH1ghwItxiVoiejqRs5k5ar4FHaIVZj+iS/NIr/IGsxxmiWSOY+QCmfyOqCkddD5omHGTiL0v3B6gE65/+FHC+uS4w8n2bBfwziS1ceBBjC3JzlVffztc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMujR2cv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE848C4CEC6;
	Wed, 23 Oct 2024 18:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729707264;
	bh=NkQ9rSmHASrg89hsQ5w9r7/BET67ZjInamDtzc0DG28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eMujR2cvFI3sKuezOIzEMkmtbvxIUq6UuSbeV/rF+8sYtXdeszsbl/H5PeZY3cAOT
	 KrigchGMsOsWfx8IYTvqg+RIg1jNfvlIPn0elj5RMPpl+EFDTOwy6t1NoPJou4yjJx
	 3n1te5kDwlaYtoUGBNyX8wMbJ6Cyp/E/b1z6El/ijNXl0mhsLYu8jENCmoNZ/w/+p6
	 sBwT36s1c496RAVICejT/ISCVI+zvou/wM/Tz68V2AT1Pcr4uOed3+1PGNMbjfMTPo
	 qjV4fCQr00lU3YCgEx/ZQi7Yx8I4Q/uw7OA3UeWj4UKESC/qjjmpP/ae52jdpdjhOu
	 nWlw1e6J2McMg==
Date: Wed, 23 Oct 2024 19:14:20 +0100
From: Mark Brown <broonie@kernel.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: bug-bisect: Add a note about bisecting -next
Message-ID: <c58a5505-927d-4eba-8107-0e6ef18a2ca5@sirena.org.uk>
References: <20241022-doc-bisect-next-v1-1-196c0a60d554@kernel.org>
 <7cca53ec-1893-45dd-832b-dc845d08474e@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bWybS9e7LBuKh7iW"
Content-Disposition: inline
In-Reply-To: <7cca53ec-1893-45dd-832b-dc845d08474e@leemhuis.info>
X-Cookie: A bachelor is an unaltared male.


--bWybS9e7LBuKh7iW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 08:05:33PM +0200, Thorsten Leemhuis wrote:

> How about something like this instead:
>=20
> ---
>=20
> Bisecting linux-next
> --------------------
>=20
> If you face a problem that only happens in linux-next, bisect between
> the linux-next branches "stable" and "master". Use these commands to
> start the bisection for a linux-next tree you added as a remote called
> "next"::

This looks good to me.

Reviewed-by: Mark Brown <broonie@kernel.org>

--bWybS9e7LBuKh7iW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcZPPwACgkQJNaLcl1U
h9DAlgf/XZQT958MZMZ+PCFVjdH59D7nnZS+Z+rECH8/24i3eJPCQ437PV+4/ron
wDZGkcvUV0gau2BQx9hvlDW+NKBGRDW4XtooziE08MPcMbdM5bxRof8zhTkvqYBi
Ce0p/FOtB9G8hIbdl5wAXVp//t47vT9RjIKXm/hqQX575fx2w6u32TVihONiOBJ9
b6moCQwRPzggMSFQdkLoxq6jOw0JSnc68Wa/gii0/Yqaxk5CEoRiEqhP7lPxmC/+
LmliTIhwPCyWq8SSgcuZTph62QCIBBT48TXHEq7bj+IOT3+M2YsVM9kogGWcBsQS
+Er1EdMhESHPteiKusrKhWgo31P55Q==
=CWrT
-----END PGP SIGNATURE-----

--bWybS9e7LBuKh7iW--

