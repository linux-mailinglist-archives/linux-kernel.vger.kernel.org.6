Return-Path: <linux-kernel+bounces-286298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B3D95193A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13BB32827F9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9722D1AE043;
	Wed, 14 Aug 2024 10:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJHtR8tB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC0633993;
	Wed, 14 Aug 2024 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723632263; cv=none; b=QqKB7W8WwtYwKkLXic+UKtTss5PcU0CHRh8jTrLioRx7B6RSDnpjzxn5Xvv60VdWWNBEeEp5bPBaUZ3wUm0h7Dlg6tmiURp5+DgXyjSPgMecVZsCmElW5dNdY8GnEypN7QXWL2PyUx72hZ9C1+p8Uh7NV9F+kh2yl34dtgEilZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723632263; c=relaxed/simple;
	bh=9Kd4y0d1+E9MxTccvXn5CITcKmt48Cgk8WWylCrsQ/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECjRjNkWxWOYYhA0X4lAVa78CenGUA7w4xeEWKR2TH99UpapbTCv+24A/mhBAjvPTDrFmBDraut/PTrgVQB7+jGSgcPPD2BoApr45G3Uzs4ehFQuI/U+DvVo7p9LAgTTb9yFrf1i5SBOrW23P3+Vx8ODbGIJC6Os30b1cSiolHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJHtR8tB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62538C32786;
	Wed, 14 Aug 2024 10:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723632263;
	bh=9Kd4y0d1+E9MxTccvXn5CITcKmt48Cgk8WWylCrsQ/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hJHtR8tB1RmDBKm5/Xns2VjpCZr2G8X0P0FpsAn71HGj/IEfKbAymIVlJKshlxEfM
	 bXeMeDC4dmD+klmqUUkdtDRdwDqMVsMVvF1teyw3SsTC4FSJ96b1cPPhKl+9ozTc9/
	 rq2TIFbvwOU6SVX8B5gHxh/Uz3Z6LUClyFnBpTAlbqh4NXVK2iQFPeR07djjcxTDhd
	 8A3Sm3fixMhEW/VPn0rbPiBvlWVB8SiwKUY7iXuMs82S4uwD6af4bFZmmx0JmdbokQ
	 Tzgi+cvL8mvK9G0wcUcDT7Vi1PmWeg0b2sD9lEGAi7dm+g7iC5FT3+IauxC52Jh6uC
	 W05NwUurvKQBQ==
Date: Wed, 14 Aug 2024 11:44:20 +0100
From: Conor Dooley <conor@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] LKMP(Bug fixing fall 2024): Fix documentation spelling
 errors
Message-ID: <20240814-vexingly-gigahertz-b4fca46f4626@spud>
References: <20240814103620.8912-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4iROHHSOyiKn+nX0"
Content-Disposition: inline
In-Reply-To: <20240814103620.8912-1-abhashkumarjha123@gmail.com>


--4iROHHSOyiKn+nX0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 14, 2024 at 04:06:18PM +0530, Abhash Jha wrote:

btw, your commit $subject is rather odd, as it contains
"LKMP(Bug fixing fall 2024):".


>  Documentation/arch/riscv/vector.rst       | 2 +-
> --- a/Documentation/arch/riscv/vector.rst
> +++ b/Documentation/arch/riscv/vector.rst
> @@ -15,7 +15,7 @@ status for the use of Vector in userspace. The intended usage guideline for
>  these interfaces is to give init systems a way to modify the availability of V
>  for processes running under its domain. Calling these interfaces is not
>  recommended in libraries routines because libraries should not override policies
> -configured from the parant process. Also, users must noted that these interfaces
> +configured from the parent process. Also, users must noted that these interfaces
                                                        ^^^^^
						There's a second mistake
						in this line.


Cheers,
Conor.

--4iROHHSOyiKn+nX0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZryKhAAKCRB4tDGHoIJi
0lTTAQC/CF8ZwTLXN272gEpuoSA1OK4uBgfD2TeN3pGpYT3EOQD+Kdjn18yMUi/i
k9jGJvlo4swoYVeWrKN8Uk6AQCFO5wE=
=LHxm
-----END PGP SIGNATURE-----

--4iROHHSOyiKn+nX0--

