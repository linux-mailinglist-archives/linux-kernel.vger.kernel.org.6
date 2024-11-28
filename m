Return-Path: <linux-kernel+bounces-424910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2F19DBB15
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 17:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A1628213A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BA41BD4F1;
	Thu, 28 Nov 2024 16:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRZLKX6u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F663232;
	Thu, 28 Nov 2024 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810629; cv=none; b=j3z5/t/6DaS0qj+UwjqbdftvhxDX3R68IbBGyZIYAsaxzHvbgTtKFneu9FEGwI7NyRy4xjceI2Rmz++rEt6ezvF0vX88AEEF2H7IgeCrEu5PqDGBUmYVIidUxCdOfFG3eygRVqvP5j1D+l9C+NiQhHlSxHTwknx412s4LOsW09U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810629; c=relaxed/simple;
	bh=bzIfG7ojcLYalTUxMR/ta1j2LYd/2tdQNDKZEPMhGeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvANqtiXOrTOySFVcdegctMVWMsGlOgVk9QHt5nYRDan8zzC2vWZ4ya8SaLK5t8teHNtyNGmd0Sebh6C5lo3rGsmH1umYGfV2RC8oSTE+s0Vg3PR7UEGrw2R4wMfa63nSIRaPiOenL1rVgDd6kdg78oHyyXVquII4G0sCmp/XEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRZLKX6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE21C4CECE;
	Thu, 28 Nov 2024 16:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732810628;
	bh=bzIfG7ojcLYalTUxMR/ta1j2LYd/2tdQNDKZEPMhGeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PRZLKX6uyEJmj8EQqx/ahzLAp163LjDFFk4o7RDVHvcfW9Yj1QnlViRhOwmyTt7u4
	 sl7UOWI16s8fxKv907GVCq7/PDGZsZ00/atHRLOns6uQesFZF03Fu87iTRh87r+JfK
	 8vFB1TuJ11AWg4uh6pxAPZDEPBDOFeBh6szyGwbw4DrEA+qHX01Vj2jqmv4j+w3eCI
	 HbOqmfv6+dc/jWb1z3lIpR2wBYMzcFqI/yhHxyIu0ZH+iNf9PRTJ0ca9T2CCIc0sm0
	 BYcqjCJngFbfEEhRN7HFW70ULnatM4zyPdkhYzxRaqv2dKBdJZ02YU+Dgs+OE4b2Ch
	 5rrBOnrllTv9Q==
Date: Thu, 28 Nov 2024 16:17:04 +0000
From: Mark Brown <broonie@kernel.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: lgirdwood@gmail.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: devres: Remove unused
 devm_regulator_bulk_register_supply_alias
Message-ID: <1b775e08-4883-4676-8e78-e5ef21e3e884@sirena.org.uk>
References: <20241028021500.478043-1-linux@treblig.org>
 <Z0iWtV6XQKNHDqf-@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ahbHQncaEVFQYx8n"
Content-Disposition: inline
In-Reply-To: <Z0iWtV6XQKNHDqf-@gallifrey>
X-Cookie: Close cover before striking.


--ahbHQncaEVFQYx8n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 04:13:41PM +0000, Dr. David Alan Gilbert wrote:
> * linux@treblig.org (linux@treblig.org) wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >=20
> > devm_regulator_bulk_register_supply_alias() has been unused since 2014's
> > commit d137be00ee01 ("mfd: core: Don't use devres functions before devi=
ce
> > is added")
> >=20
> > Remove it, and the static helpers only it used.
> >=20
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

> Ping.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--ahbHQncaEVFQYx8n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdIl38ACgkQJNaLcl1U
h9C/Tgf9FK+Xx5Ni9gze8ykxCwwyFRX3kLOCnrAyKy+gAu45H28M0J73oaC38YWG
wavqk9dHo8gmH5xc0j/3vYN/rAC+GjSEzLbpLVJGopTo6z71ITOvaxV49n6Lfnqb
fMXAR5tSrYWVqDH0x+h1701iCBbAPJy+It8RyiqXFijxx36unsIuT8rWA2u+jY3Y
236L4CsGLs9kDxzXG5cDZaUqStXUOwtk3RaNLW0Z+pfwnEMABoBsrOuMN85J9YPD
fvAAG8zcV8kVLin3ARwBCO2ujl+yx6E7mXwtcaFgbUevh/fuOoMO4zAd06lIuFPO
V6uzz2qgwxVaG1JJ9WqlxOIU0u+zdQ==
=mj49
-----END PGP SIGNATURE-----

--ahbHQncaEVFQYx8n--

