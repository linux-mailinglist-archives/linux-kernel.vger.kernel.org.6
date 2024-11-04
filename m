Return-Path: <linux-kernel+bounces-395221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2D69BBA74
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1885B1C215AB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A36E1C243C;
	Mon,  4 Nov 2024 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWjugrvu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B287F1C07F1;
	Mon,  4 Nov 2024 16:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730738479; cv=none; b=u87HNAexi6DDes3PF4f/IOMGSrC1TYqOirXhJ8GYIVUn3+85xNaaSFP2Mrp3Mn9uiR2us+ZAW0FmpqKFMwBBx9/hmBpoaAbd8nlqg0kcSz9/p0wgUZKb7VXfjawz20UrE/oKWcR4LGCXusALmUujso1FbXv06gA0pGvkiOt0AOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730738479; c=relaxed/simple;
	bh=+B9xFugGobw2ZRWDNdrYNv/jQoedsgnzX20cqqtb3i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuODPNyIFffkZxCQhsICGvEOWLVdBnxutNUTLddZJEfOxanS92UZhvHa72euQw5bZMr6i84HMu2shsmgZHokZ2oi1CKmbyqARYQuHZYZlHZkZUaiZFovDZx7XTXcMruphskAsmfG6FGSTJGNvJklEnQ+UeGvtpEiTVu0emBSuCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWjugrvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D29C4CECE;
	Mon,  4 Nov 2024 16:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730738479;
	bh=+B9xFugGobw2ZRWDNdrYNv/jQoedsgnzX20cqqtb3i8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OWjugrvuDz6ff1jX/EzVG4/5uQaUmp1rB0aAZ84F+JUT2zEz56uX+cXmYmmDbldk2
	 UbhbOGj3IXz8OKNgB2+5YfAEdCUCMImjpwSQ7RqsxtwYDe5v1KA9Bjf8gJOBqPCswA
	 6EnDbu8MrjWQszhTFJwgJK3Qi7rRh4x6YoFVpDBHZnXBPv321bpIic0X87FGSnk09b
	 x4epqNCrtv9imO8+7YX4eRYgmRYegPpjGWCDyfGOsckK+wtSzunlOLmlD7WKqRyEct
	 41BYaHLIba6sMWBmPxbjI3w6OvSq6rSnjk3alY9Iw9RuS+d+pW45muP1DwnAzha6X7
	 eySOu/81VHVkw==
Date: Mon, 4 Nov 2024 16:41:14 +0000
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Ki-Seok Jo <kiseok.jo@irondevice.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] ASoC: dt-bindings: irondevice,sma1307: Add
 initial DT binding
Message-ID: <ac5ad26e-ef76-4ad9-9396-2b175276a5c8@sirena.org.uk>
References: <20241104-irondevice-sma1307-v3-0-4bbe79895f54@irondevice.com>
 <20241104-irondevice-sma1307-v3-1-4bbe79895f54@irondevice.com>
 <SL2P216MB23377A60BEC4396ADFA78A6A8C512@SL2P216MB2337.KORP216.PROD.OUTLOOK.COM>
 <20241104161751.GA320514-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oagKkKyvt1o8YX1v"
Content-Disposition: inline
In-Reply-To: <20241104161751.GA320514-robh@kernel.org>
X-Cookie: The meek are contesting the will.


--oagKkKyvt1o8YX1v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2024 at 10:17:51AM -0600, Rob Herring wrote:
> On Mon, Nov 04, 2024 at 07:33:47AM +0000, Ki-Seok Jo wrote:

> > +    enum:
> > +      - irondevice,sma1307a
> > +      - irondevice,sma1307aq
> > +    description:
> > +      If a 'q' is added, it indicated the product is AEC-Q100
> > +      qualified for automotive applications. SMA1307A supports
> > +      both WLCSP and QFN packages. However, SMA1307AQ only
> > +      supports the QFN package.

> Is this difference visible to software? The package is not, so that part=
=20
> is irrelevant.

It seems reasonable to allow it as a compatible if it's sold as a
separate part, even if we don't need to care.

--oagKkKyvt1o8YX1v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmco+SkACgkQJNaLcl1U
h9C3WQf/cvCLIIc9BSmHgNbLWWFbm12PJ+ga/IEM7Ud6luckZzqyjyZRvFV/uy0E
JabJmdMpallRe/VTN0/0aXbMFY66Jw+3QVCyLprfuYr6GtItgkLxE7SdO32bmp6N
1Qj5qXJETVb2PWiVsvmVjRitxuKTfLJms0HGgaK5VMwdkV6nTjujPDhKLfIzbgOl
kDEI+s+aZXcOSbqk69XjFrRtXMiiGZKqbFbdfOncUdt6i1UeiM7AuIvJzjLh18gp
o2v7CQ5BI+/WXKEk3Mqz8c16WBBiJYmihPraozovwIlDRp7BH7o3qBqX/SxR5TLz
OkBQzrEMqk42cfC+HVpeWVHb6ML8TA==
=ZsMY
-----END PGP SIGNATURE-----

--oagKkKyvt1o8YX1v--

