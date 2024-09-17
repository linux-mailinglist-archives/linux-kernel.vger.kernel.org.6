Return-Path: <linux-kernel+bounces-331520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAF997ADDF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2D65B2C388
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBEF15958E;
	Tue, 17 Sep 2024 09:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgmb0QCQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FF31474B5;
	Tue, 17 Sep 2024 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726565007; cv=none; b=mOHdC5riK66eY6feZNOrdyQjaFgThlx40M4fZY/ZcsyJBAQVLFETDFvIDkvtl1ow/+debxnBDbh86q7Jt4fR52QCsXps9ajBBO0jgn3oW3GdemefLT/dk0P2/0yI4H2MYerNiDCvtRnq1UVoQX03WuktxAcPG5734gBUEVrEJco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726565007; c=relaxed/simple;
	bh=nsRUUHtPJFFITXgQq/oXznG1F1LUC1JFyN5PWBkyW+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDvspwJH7GRRfJSSKx8IXyrTBUF/FolqBKPfwJqY+6O4qV0x9SO9774orz7q6z0gSmeQxC9AeUIvl5X1EYI0vD/vMq8yUrh95oyhBf6uy2r8swHkJ7W9/3ShUW6qC4q8UeAEcYUVaQ8eT327BkFV313vuiwsUEGeGU284qtAFnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgmb0QCQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC92C4CEC5;
	Tue, 17 Sep 2024 09:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726565006;
	bh=nsRUUHtPJFFITXgQq/oXznG1F1LUC1JFyN5PWBkyW+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hgmb0QCQzPC3Q6oJcFI0FfPNgXUvSd2K7Tz5dhQPE5mUauSzv7oEYvcErLSqRgqLC
	 9DuBr8LzqV4+ynkLxFuInKVDesFMiPlAEYwWogiCypuzIkCNNJU+dUdx+xheY1LAJY
	 7czsGYGaiSIxiwrP2x52uuiSLzxR0dtlcTpxuWQhyTsZt98MwHY3REbmk1KNWdsyAJ
	 MJJcPJr7x9mRwXrgRHVXNZEJyZQqjIB3v5ccaXHTHPDd8AWiTCDJC/exa9rCqNUUii
	 vjg3la3ZMotgDh4LWpdqnKUq1ldbM3+T2PWaAhcfKJQXFiiI0IeCiJ40xYzY/Ff5PA
	 +sg7kIXXF7/WQ==
Date: Tue, 17 Sep 2024 11:23:22 +0200
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
	yung-chuan.liao@linux.intel.com, lgirdwood@gmail.com,
	tiwai@suse.com, Basavaraj.Hiregoudar@amd.com,
	Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: amd: acp: don't set card long_name
Message-ID: <ZulKiltQog5Dqo5h@finisterre.sirena.org.uk>
References: <20240916061318.3147988-1-Vijendar.Mukunda@amd.com>
 <0ab48a05-54fa-45ff-9613-62dfff2fa699@perex.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LSgi9HRq9ifp+Unz"
Content-Disposition: inline
In-Reply-To: <0ab48a05-54fa-45ff-9613-62dfff2fa699@perex.cz>
X-Cookie: Editing is a rewording activity.


--LSgi9HRq9ifp+Unz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 10:25:37AM +0200, Jaroslav Kysela wrote:
> On 16. 09. 24 8:13, Vijendar Mukunda wrote:
> > UCM can load a board-specific file based on the card long_name. Remove
> > the constant "AMD Soundwire SOF" long_name so that the ASoC core can
> > set the long_name based on DMI information.
> >=20
> > Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>=20
> I have to say, that DMI information in long name is really confusing for
> users for GUI. UCM can fetch DMI information directly using sysfs. This t=
ype
> of hardware identification is no longer required.

I dunno, a lot of Windows sound cards seem to end up with something that
looks a lot like the sort of thing you might get from DMI showing right
up in the UI - vendors seem keen on it.

--LSgi9HRq9ifp+Unz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbpSokACgkQJNaLcl1U
h9AAkAf9E4sw0qTTWfzfUii9Rufag8+mTscuyht6+cmj4gtc3Uvw5qTWie+cjNGI
NYWD9GQE5AXX493y08Zq06yrBgObrK/Au+gJtA26IOID9+lLdRivMwqf301YH4QX
TwsBj6no41KshlD5BVqVs6wLNeTMnMs7Cvx2St34mD9G9C2GvgToSuGVb9Qdfchu
frobzzalewtdUZ2QBtraMMVlPiJRHnfobIE71MFhz2SsB9vQqIKvLalxvfiwwRck
1OXbHbbvQTIA5Zni5LsVfiCnnrGeTPcdi9BtPJOyNCjEjgW7z90XlmI5Su3+/Qff
8PeFpQ4bcn7bR7af9jV1zBUo0MyGFQ==
=s6El
-----END PGP SIGNATURE-----

--LSgi9HRq9ifp+Unz--

