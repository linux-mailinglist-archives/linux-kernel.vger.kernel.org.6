Return-Path: <linux-kernel+bounces-319826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B059702AE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 16:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB0A1F2232D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 14:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394ED15CD4A;
	Sat,  7 Sep 2024 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Eth7ZvsN"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08438611E;
	Sat,  7 Sep 2024 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725718938; cv=none; b=Lk6keVknEVld6pf0SVYCcIEjJTj9ZFloLDnAPQmotkR3dFlSp+lB7jJoU1VhTbDITgqe86dVD/oSxL91jn6naXuNYlCed0zS/eKcO/IXpt2JlBGL/8tRN5BGHijbQXRQS75FXfKqhOOJLuJ+CWnlgSDPCOFfCxLfgNL7vjGhfaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725718938; c=relaxed/simple;
	bh=9igshsaAyQ/GLgh1kcsgoPnRPY88NTKuYGNQTpOA7QY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EswjjQoa33rGxuh5EE/3lgkoS9k969v0FbjA2/Y1VaK49PIZ1O9vAdGHp84obCts1Cp905lYKzTv3FYsZ0kSbUab/cj6mdaQioOjK2YdWCcFjDZtxYSxTJ16oghnkIi3kW65LxvBZtdpzIO5VcgbmQF//zEhV6JJWagfZfbU6pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Eth7ZvsN; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=tco66llvtnctdn5j4xkh4t2hoe.protonmail; t=1725718932; x=1725978132;
	bh=9igshsaAyQ/GLgh1kcsgoPnRPY88NTKuYGNQTpOA7QY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Eth7ZvsNwEHaQXqLYXUsqicNb303C92aOeoFC/Ty9rjMjN3/wCYm0CVNcH50/Zajc
	 MOu4gaQqWbTZqrcTuQ6rV30Qvdb0d+N/7ormU1kz6hLGDNZPdyIyGdWPaa2jxntjH7
	 cRwMoDs7ikfBf0tYhhTjlpefho2GQ8ug/7yoU9PacrVH2N37cheAqNqHHoywE3t97i
	 Jwl/5nUa30+CajVB2Wgv0F4QUVXnKus+CzTbNWghT44lL56Aapdxh9f5FDwCO+1zDu
	 oFBbif/ZqfsQxNY+drvOLH0QEsRtGFeu6Yr+CZRd6nLc3YdZG1Cz3RlE16ZGCP5BcY
	 VMP+6kvQ49u5w==
Date: Sat, 07 Sep 2024 14:22:07 +0000
To: Joe Perches <joe@perches.com>
From: Patrick Miller <paddymills@proton.me>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, apw@canonical.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dwaipayanray1@gmail.com, gary@garyguo.net, linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com, ojeda@kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, wedsonaf@gmail.com
Subject: Re: [PATCH 2/2] checkpatch: warn on known non-plural rust doc headers
Message-ID: <M4qWISlO9z_OnOQGC5Gqb0ROgBLsxM35tR9HU_DMJKExPFpJrEYTuBa2mO5YQqvQK4h65hZrNB165qJlOnexLXaDscRuZcmAkOC0AH4SO04=@proton.me>
In-Reply-To: <ct-Fmb-XUaJqIhpE1RlzXwIHxv2fWKgeiD4_j3xguKMCL4vwyYn8qzv_fKjulO9GmOW18h0jzPkiRgNfym5HyUhPVBAKHJnhAH5WhYAVKNg=@proton.me>
References: <20240906180456.2302688-1-paddymills@proton.me> <db693ef6c064fa42eda323f067d4270baf68b1f5.camel@perches.com> <ct-Fmb-XUaJqIhpE1RlzXwIHxv2fWKgeiD4_j3xguKMCL4vwyYn8qzv_fKjulO9GmOW18h0jzPkiRgNfym5HyUhPVBAKHJnhAH5WhYAVKNg=@proton.me>
Feedback-ID: 45271957:user:proton
X-Pm-Message-ID: a45ab90f34133690fd4120dabe97cceae1dd2aea
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------0b957b126bcb9d3ba13b6629ccc3f424f5620c22715be5619e109bbc1bece0f9"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------0b957b126bcb9d3ba13b6629ccc3f424f5620c22715be5619e109bbc1bece0f9
Content-Type: multipart/mixed;boundary=---------------------74b4039bec29a5add5ea1367f84b4bfb

-----------------------74b4039bec29a5add5ea1367f84b4bfb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8






On Saturday, September 7th, 2024 at 7:57 AM, Patrick Miller <paddymills@pr=
oton.me> wrote:

> =


> =


> =


> =


> =


> =


> =


> On Saturday, September 7th, 2024 at 6:53 AM, Joe Perches joe@perches.com=
 wrote:
> =


> > On Fri, 2024-09-06 at 18:05 +0000, Patrick Miller wrote:
> > =


> > > Adds a check for documentation in rust file. Warns if certain known
> > > documentation headers are not plural. Even though some sections may
> > > be singular (i.e. only one example), the header should still be plur=
al
> > > so that more examples can be added later without needing to change t=
he
> > > header.
> > > =


> > > Fixed the whitespace issue on my previous patch.
> > =


> > Well, one of them.
> > =


> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > =


> > []
> > =


> > > @@ -3900,6 +3900,13 @@ sub process {
> > > "Avoid using '.L' prefixed local symbol names for denoting a range o=
f code via 'SYM_*_START/END' annotations; see Documentation/core-api/asm-a=
nnotations.rst\n" . $herecurr);
> > > }
> > > =


> > > +# check that document section headers are plural in rust files
> > > + if ($realfile =3D~ /\.rs$/
> > > + && $rawline =3D~ /^\+\s*\/\/\/\s+#+\s+(Example|Invariant|Guarantee=
|Panic)\s*$/) {
> > > + WARN( "RUST_DOC_HEADER",
> > > + "Rust doc headers should be plural\n" . $herecurr );
> > =


> > There is no autoformatter for checkpatch/perl/etc.
Can you elaborate on what you mean by this? I'm not following.
Is there documentation you can point me to that I need to review?
> > =


> > Continuation && on previous line
> =


> Will fix this. Is there a code style document for the perl scripts?
> =


> > No space after open paren
> > Align to open paren
> > No space before close paren
> =


> I based my coding style off of the if statement directly above mine,
> although I did miss the continuation of &&
Sorry, looked at this again and realize you're talking about the `WARN` st=
atement.
> =


> > I think this is an overly trivial addition.
> =


> I am responding to an issue that is part of rust-for-linux. Maybe
> Miguel Ojeda has something to add on this matter?
-----------------------74b4039bec29a5add5ea1367f84b4bfb--

--------0b957b126bcb9d3ba13b6629ccc3f424f5620c22715be5619e109bbc1bece0f9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmbcYYUJkJtRGrsur54RFiEE3KdIkSvUnCve801mm1Eauy6v
nhEAAF/cAQDaY1bygYwQZoteVOw9G8VSOjPf9AmTFO937vuUFZsliAD/eJmH
wa7B3plgdbx29pv5aFhtc4Z09juB93e08tR5jQs=
=M2/Z
-----END PGP SIGNATURE-----


--------0b957b126bcb9d3ba13b6629ccc3f424f5620c22715be5619e109bbc1bece0f9--


