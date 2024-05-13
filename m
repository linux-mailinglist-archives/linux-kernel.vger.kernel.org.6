Return-Path: <linux-kernel+bounces-177654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DBE8C4270
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5DF1C2162E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB79154BE3;
	Mon, 13 May 2024 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="ZCv4ip+v"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A5115444B
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607952; cv=none; b=HHbHVTwCZpTBDd3WsUjb7TwqWZqVirfKk30+MdlPlh5WDXGuLfwNDp3f8vXbcwzlWDBHLrvr8xps9UwJEzkWvx7C4kmsoP/I/Q/ua5wzKheXd3ae2Z3zoa1yEAJIVKTnRuFqlhxCSwXUm/x9ApmNf+Ars427gkLPb4VuN8LHmyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607952; c=relaxed/simple;
	bh=ylIY415x1u+fz98l0xba+ARbUiy+30TF8SbO3zlEu4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UAJuGzzjqZJ4whWEBcwhi8upnTBlkdzhyjg/ZmsUf4Rh1JInE0kzealOiJt8YNRTEcn0S5qHOJu4Pb1xp74XxhtfSDbwoA3aGoRFmRzEqiyzC+202NE1YiypJQEMf1Zgh8EVkxtoLtpFTSsMLTjQaMa4T3XqWmIV31b3o8uK68U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=ZCv4ip+v; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1715607947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jDa7ygJBRT9N2NOt4r2Vw3CrChE0WUo+YyuQWql0zRU=;
	b=ZCv4ip+vbuzjXRiP+qoQF95iEFK6Njq0mu4g0wuVsQFsol3r/HKYwfCzP9k2vm1i8KWV4W
	EuQr9LjLp/pBbOPKEdUU8MnadukM/ntTGaIlcXUS5v82himOBjd0aGpmNv28VUkEvr51K3
	2FFjHuaZUDr84VVyjtzPEnFaKaeI+DHTO1/Xu7hTdqYAq2M6j8PtZkjhjAYvtxdpkDxq14
	2p4d4n3U7dA+zkwemnY0dC92kMfsRtXF9Ip9wsF82MuURx6wTibT8yi9KSUTBM78JEcifc
	ceyY8CGnj+E8cKDdmFah1elYVV18RebQo8lebQfSPmtzFCAM9IUHCIGL+VX0ag==
From: Diederik de Haas <didi.debian@cknow.org>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>, Joe Perches <joe@perches.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] docs: dev-tools: checkpatch: Add targets for checkpatch tags
Date: Mon, 13 May 2024 15:45:35 +0200
Message-ID: <10035992.Dr8D0Bp7vt@bagend>
Organization: Connecting Knowledge
In-Reply-To:
 <CAKXUXMzw6_JnPxXfgU2tEU-VkU6E_=ee-V4MUzGX8MQCSXLuNA@mail.gmail.com>
References:
 <20240513102237.112376-1-didi.debian@cknow.org> <87a5kuez97.fsf@intel.com>
 <CAKXUXMzw6_JnPxXfgU2tEU-VkU6E_=ee-V4MUzGX8MQCSXLuNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1882286.OJMM5I3xxo";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart1882286.OJMM5I3xxo
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
Date: Mon, 13 May 2024 15:45:35 +0200
Message-ID: <10035992.Dr8D0Bp7vt@bagend>
Organization: Connecting Knowledge
MIME-Version: 1.0

On Monday, 13 May 2024 13:46:39 CEST Lukas Bulwahn wrote:
> On Mon, May 13, 2024 at 1:18=E2=80=AFPM Jani Nikula <jani.nikula@linux.in=
tel.com>=20
wrote:
> > On Mon, 13 May 2024, Diederik de Haas <didi.debian@cknow.org> wrote:
> > > Make the tags directly linkable by defining targets for them.
> > >=20
> > > Closes: https://lore.kernel.org/r/8090211.0vHzs8tI1a@bagend/
> > > Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
> > > ---
> > >=20
> > >  Documentation/dev-tools/checkpatch.rst | 216 +++++++++++++++++++++++=
++
> > >  1 file changed, 216 insertions(+)
> > >=20
> > > diff --git a/Documentation/dev-tools/checkpatch.rst
> > > b/Documentation/dev-tools/checkpatch.rst index
> > > 127968995847..6499e29c3a19 100644
> > > --- a/Documentation/dev-tools/checkpatch.rst
> > > +++ b/Documentation/dev-tools/checkpatch.rst
> > > @@ -242,6 +242,8 @@ This section contains a description of all the
> > > message types in checkpatch.> >=20
> > >  Allocation style
> > >  ----------------
> > >=20
> > > +  .. _alloc-array-args:
> > > +
> > >=20
> > >    **ALLOC_ARRAY_ARGS**
> >=20
> > Alternatively, you could just convert the definition lists into section
> > titles to make them implicit hyperlink targets. The rst stays cleaner
> > and there's no manual updating.

Yeah, makes sense.

Indented boldface letters (as it is now), stands out visually much more the=
n=20
an ``<h4>`` header (tried it with "^ for subsubsections").

Is being able to use URLs/Links like this:
https://docs.kernel.org/dev-tools/checkpatch.html#BAD_FIXES_TAG

considered worth the (visual) trade-off?

> Agree with Jani. It is important to check that the verbose option of
> the checkpatch still works. The script actually parses the
> documentation and then shows the relevant parts as verbose output to
> the user. It currently relies on the specific format, but it is not
> difficult to change that to use a different pattern, see sub load_docs
> in checkpatch.pl.
>=20
> So, please make sure the current --verbose option in checkpatch.pl
> does not break.

It's a bit more challenging for me being (mostly) clueless about Perl.

Cheers,
  Diederik
--nextPart1882286.OJMM5I3xxo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZkIZfwAKCRDXblvOeH7b
blIzAP9EhFqKBYgRIDerE91l8NptluoQXqKx9QvAq7kcZbepUQEAokli6UYhQg8y
U9NYbmo7PCn4oAITKqG5tfuRdYPHLgY=
=KViu
-----END PGP SIGNATURE-----

--nextPart1882286.OJMM5I3xxo--




