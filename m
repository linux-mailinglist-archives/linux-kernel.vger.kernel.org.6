Return-Path: <linux-kernel+bounces-181289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99558C7A05
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 18:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6010CB21018
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4FA14D712;
	Thu, 16 May 2024 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+Hvg3eQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DE214D452;
	Thu, 16 May 2024 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715875461; cv=none; b=GG/HM1PgjLpCLBzUPM4gjy8yC/Law/2+pdUOGFeOjx2f5GJaZjfL4IvDtOkyJuQHqzQezVQuhuGPB9RICZP4j5iY+mCrROn4Srvz8dRG+nK8ZRPIKj6L0YFFlv+BgUH+mA2AhsCxWjOwYQMTfwsqoWoakLhyXc4gp0fY16dEhho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715875461; c=relaxed/simple;
	bh=w/VCxKOJAzskajQyGDqLy9NBiE2zC4FfWI7LfgmWFfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXcI0iApu/Tq+/OsBBhG9t/x5Xc3c6nbW5J26C+J9ibaexJYKl+Dgfn76OmYXRVNetHjec8zX8b9H9UBjmTx1KlwESJU1KPi7Mmg6+RF8H0cm2Q7TE0QrORW80w+4POmn//AVAl5O9Blu5GT99NXvQ4QjxqvSQU60+Lsa1WVhvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+Hvg3eQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7E3C32786;
	Thu, 16 May 2024 16:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715875460;
	bh=w/VCxKOJAzskajQyGDqLy9NBiE2zC4FfWI7LfgmWFfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k+Hvg3eQLJ4lIBsk6+vsvR2fp7IKceiyjLvU8HaXSbVWJ2AAGtSFGQxKUVyW4mYLb
	 1jhtdzpmD/PK3YwTEIaaP718jLsO4oV9Qz+yWqRsQEaRxJoIctWWYgPMQdkqiqPthy
	 jR4FYUN8jnkuQAhiBhTNJchXpbFKYakPdP/fy271WL+ve30xsuqS7PWE7zVKaqguUr
	 y5IUPGGLLX+dd/BVVLn6HuqeAxlqemyf/86swKuesbIQTQoP7AymmoZMCMO/i8nroK
	 F9xu8rBIVZjyJ3IABAtEvYF6eCPzV3XyasJVbcYVjI/MjSAR2yqV+0nXnQam2KfVSj
	 mZjzXZ+P2kyzg==
Date: Thu, 16 May 2024 17:04:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Kanak Shilledar <kanakshilledar111@protonmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Conor Dooley <conor.dooley@microchip.com>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] Documentation: process: Revert "Document suitability
 of Proton Mail for kernel development"
Message-ID: <20240516-tattered-rival-f443328b5971@spud>
References: <20240516-groin-slingshot-c3c3734d2f10@spud>
 <4oW9pC38sSYZn96BW8abMfVpDDCmG4MDHwwmL73o5bP-WyHAutJ5j2GrSU17MCSWOKufViNl4q2zZUmwmN40evP5OK3QiMnUn2hsgWCYhl4=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="M4UZhHp/KDapPJjU"
Content-Disposition: inline
In-Reply-To: <4oW9pC38sSYZn96BW8abMfVpDDCmG4MDHwwmL73o5bP-WyHAutJ5j2GrSU17MCSWOKufViNl4q2zZUmwmN40evP5OK3QiMnUn2hsgWCYhl4=@protonmail.com>


--M4UZhHp/KDapPJjU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 04:00:10PM +0000, Kanak Shilledar wrote:
> On Thursday, May 16th, 2024 at 9:05 PM, Conor Dooley <conor@kernel.org> w=
rote:
>=20
> > From: Conor Dooley conor.dooley@microchip.com
> >=20
> >=20
> > Revert commit 1d2ed9234c85 ("Documentation: process: Document
> > suitability of Proton Mail for kernel development") as Proton disabled
> > WKD for kernel.org addresses as a result of some interaction with
> > Konstantin on social.kernel.org
> >=20
> > Signed-off-by: Conor Dooley conor.dooley@microchip.com
> >=20
> > ---
> >=20
> > I tried to find the stuff on social.korg to provide a link
> > but could not.
> >=20
> > CC: kanakshilledar111@protonmail.com
> > CC: Konstantin Ryabitsev konstantin@linuxfoundation.org
> >=20
> > CC: Mark Brown broonie@kernel.org
> >=20
> > CC: Jonathan Corbet corbet@lwn.net
> >=20
> > CC: workflows@vger.kernel.org
> > CC: linux-doc@vger.kernel.org
> > CC: linux-kernel@vger.kernel.org
> > ---
> > Documentation/process/email-clients.rst | 20 --------------------
> > 1 file changed, 20 deletions(-)
> >=20
> > diff --git a/Documentation/process/email-clients.rst b/Documentation/pr=
ocess/email-clients.rst
> > index 471e1f93fa09..fc2c46f3f82d 100644
> > --- a/Documentation/process/email-clients.rst
> > +++ b/Documentation/process/email-clients.rst
> > @@ -350,23 +350,3 @@ although tab2space problem can be solved with exte=
rnal editor.
> >=20
> > Another problem is that Gmail will base64-encode any message that has a
> > non-ASCII character. That includes things like European names.
> > -
> > -Proton Mail
> > -***********
> > -
> > -Proton Mail has a "feature" where it looks up keys using Web Key Direc=
tory
> > -(WKD) and encrypts mail to any recipients for which it finds a key.
> > -Kernel.org publishes the WKD for all developers who have kernel.org ac=
counts.
> > -As a result, emails sent using Proton Mail to kernel.org addresses wil=
l be
> > -encrypted.
> > -Unfortunately, Proton Mail does not provide a mechanism to disable the
> > -automatic encryption, viewing it as a privacy feature.
> > -The automatic encryption feature is also enabled for mail sent via the=
 Proton
> > -Mail Bridge, so this affects all outgoing messages, including patches =
sent with
> > -`git send-email`.
> > -Encrypted mail adds unnecessary friction, as other developers may not =
have mail
> > -clients, or tooling, configured for use with encrypted mail and some m=
ail
> > -clients may encrypt responses to encrypted mail for all recipients, in=
cluding
> > -the mailing lists.
> > -Unless a way to disable this "feature" is introduced, Proton Mail is u=
nsuited
> > -to kernel development.
>=20
> Instead of completely removing the Proton Mail section, can we keep the
> mention about the Proton Mail bridge and the third-party hydroxide
> (https://github.com/emersion/hydroxide) bridge.

I think that is probably reasonable, but I think writing the replacement
text is up to someone who actually uses protonmail.

--M4UZhHp/KDapPJjU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkYugAAKCRB4tDGHoIJi
0omAAQD2PDht18QafEYRX8KcAkFSW+u0xgTPRkv1jW67OHnXUQD/b7l2pDkiHGJO
H0NRHTXedMoiytMxuVkw1tu7zM96SwE=
=qAQV
-----END PGP SIGNATURE-----

--M4UZhHp/KDapPJjU--

