Return-Path: <linux-kernel+bounces-409228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A77D9C893E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F4166284A10
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1AD1F9420;
	Thu, 14 Nov 2024 11:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrI3dRjl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83821F891E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731584959; cv=none; b=KKWqFOiBFPNIFbG15GcFWM3lNn5Sa1eUQr6BtRxb65hH/MC0DDgieRMDZ4Pi/D/yimNBosHt4YfKUlmr1fhq/GPoWlVhqa4EVNy6s9MKU/bmE7ohuWYlZqLETwa5EhLOWX0qJyrLameyVq2tHFZ3RImfGwJvxb/qqEcfPUMXTlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731584959; c=relaxed/simple;
	bh=80RfyrS7acqSY3cbsQjPVsHwJPl09r5jmSGAmJTUIRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iV6Pz/53m+VfnC0MXYgTZmmbtFVnOpNp6FreabFPfESg1dyKAmfyOR1mW575C0RCQNuiBgOaYfY1auE6g93FTNg6i4nU9ymBL6u1dZOKQpfRjqGLuciohgLpgywy8bXByG+27nIjNuLRi9DKuWFxCEpTrjloYWNQOM/pDRwNvNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrI3dRjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E13C4CECD;
	Thu, 14 Nov 2024 11:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731584959;
	bh=80RfyrS7acqSY3cbsQjPVsHwJPl09r5jmSGAmJTUIRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XrI3dRjl/xMXjfZuE5+kaPd6dB3D8d11elYtDzJU42W8Xznzm86hC0YpIhj/grBah
	 0nY7UxemIhmFTNQGx1qIlZQ9j29HelBEUaNcyHaBTOuJEHO+b3cVJarDeYPT7MROt9
	 3xOJxYfdeJ+3aZKd94D9hGiYDiRyy4xsmhy/xyl2XSg15VH8LQcB3HRqzAmgvZkNLx
	 X9AVi8bvEEGbOipRWTJCFh6owwC8Eqbo2xBBUIB0IWoqEeO/EOIQTEKVTY9pmowcTE
	 bNlzCLv5usgU+QDtkYaZXcgWBgz082Slsq0ZvtwI9Ey8SBEShXFAzLvpOXDWy4iTKh
	 1LmedVzdYtgrg==
Date: Thu, 14 Nov 2024 11:49:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] regulator: bd96801: Add ERRB IRQ
Message-ID: <ZzXjvHvOlP6VCzcI@finisterre.sirena.org.uk>
References: <ZzWkny4lKpY09SX5@mva-rohm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4g4PaPB7Fk8gogpb"
Content-Disposition: inline
In-Reply-To: <ZzWkny4lKpY09SX5@mva-rohm>
X-Cookie: Editing is a rewording activity.


--4g4PaPB7Fk8gogpb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 09:19:59AM +0200, Matti Vaittinen wrote:

> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> ---
>=20
> This patch was part of the:
> https://lore.kernel.org/all/cover.1727931468.git.mazziesaccount@gmail.com/
> The MFD part was applied by Lee, but I didn't see the regulator part in
> MFD or regulator repository. Perhaps it fell through the cracks? I know
> we're late in the cycle but I re-spin this now before I forgot... We do
> always have the next cycle, right? :)

If this is part of a MFD series I'd have expected it to go in with
that...

--4g4PaPB7Fk8gogpb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmc147sACgkQJNaLcl1U
h9BGiwf9FUZsPdGyI+6KlePgavGtjOenz9bFOPwRDNRFfYKyKPqIcB+bTBcG1GBg
RMNFPt/JOyoBVUM+vNR+7pATHJuBpLlQDB3JZE8SjHDa+ud+yB2WYW6bxMk7b9lG
s50Qqk1vH9zIJda3lStA5ELcMkK7FTX5rogoZnR59UdsHx7r8XdlE3IVuQJTV7oC
AVZUBuxRVFT6YT3Bv3begE3A7YkhT1BT4KnGss7UhmZJOjxQaBc8/rB9xUGNEkdW
xI/hb0rJfe84+15RimAckEQTrNHb7LSktyOIsrpCqIHeblHepKLG47YJlcFGq6NM
UNCRsLLakUK6e12BflY5TM2h7vzgwA==
=+R3J
-----END PGP SIGNATURE-----

--4g4PaPB7Fk8gogpb--

