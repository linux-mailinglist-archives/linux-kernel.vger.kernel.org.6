Return-Path: <linux-kernel+bounces-319779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DB2970219
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 13:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20161B220D0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 11:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4777815A87B;
	Sat,  7 Sep 2024 11:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="KLheceuY"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D184D43179
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 11:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725710234; cv=none; b=dtBAa7exXqICAk3AbZxqKjQl/YFAW55op+HjbvIxWYFqCV5Uf++NiH097GbSivOmWQO+ePjvu3GYEi7hIEHcMCeGXtVtsVcziBzrXEYWK1+lSqSSk85ywHovUL6N8bbV2QVCSfqk6m+NdGAkyfoTBL7LGsmbG/lRUrOcrEj41LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725710234; c=relaxed/simple;
	bh=Uf4proC+YOx9CyQkbPZT1xG3tF3zrbg5fNiG38DXiGc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IsGRfgRloeOHJ1BpoKExiAKi64JCfwP01Oct4yMGOHyooLaFEeKHtBAXUsG3MlsFAubtL/Ad7j6JQVWsqNttaJeFjzdtIvITlQWyKSfLYmycNkRv/nVqdJrgkKBzRLMKI8S8RGytut4XeqIZ6Py1UPUvH5iTazH+J24i5SBa2Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=KLheceuY; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725710231; x=1725969431;
	bh=Uf4proC+YOx9CyQkbPZT1xG3tF3zrbg5fNiG38DXiGc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KLheceuYuqLlJOht4r0kZk9EZ4xMw9QfirDm5UUf7+Ee6a5kfZJratT1Lv9bR8WC5
	 9n6pIHPL+b8wGtBr/X4ptXJiJZd5TD+IYjVQZNuq42euL0dihOvqtCCEUmFUa/hagI
	 kyo0Bwdxr85qsSmPh+qbQXeZvgLY1B6MSNGlmDrV3aA9kA/qGLj6EDCFaY+9RrI/Ag
	 SBkFZM46DwJ6JBzy/46SaEW4JqVVWIl4f3Yf9t+LVNdWA+C1AcUfn5FikB+Sg5yRB+
	 6u0qa3KVe0vTxXKNOVY33dh6cBusoWMLpebKPzRKO7wuR70DHXwOfF8MORW/T2s+qS
	 v258XMc84fpMg==
Date: Sat, 07 Sep 2024 11:57:02 +0000
To: Joe Perches <joe@perches.com>
From: Patrick Miller <paddymills@proton.me>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, apw@canonical.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dwaipayanray1@gmail.com, gary@garyguo.net, linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com, ojeda@kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, wedsonaf@gmail.com
Subject: Re: [PATCH 2/2] checkpatch: warn on known non-plural rust doc headers
Message-ID: <ct-Fmb-XUaJqIhpE1RlzXwIHxv2fWKgeiD4_j3xguKMCL4vwyYn8qzv_fKjulO9GmOW18h0jzPkiRgNfym5HyUhPVBAKHJnhAH5WhYAVKNg=@proton.me>
In-Reply-To: <db693ef6c064fa42eda323f067d4270baf68b1f5.camel@perches.com>
References: <20240906180456.2302688-1-paddymills@proton.me> <db693ef6c064fa42eda323f067d4270baf68b1f5.camel@perches.com>
Feedback-ID: 45271957:user:proton
X-Pm-Message-ID: 64a4f188b6bacd40c1f7f0e21e04ea4d78695384
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------c25aa81a236cb3efd22076370285a2ca0d870d6e96c31340e75228503c2d637e"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------c25aa81a236cb3efd22076370285a2ca0d870d6e96c31340e75228503c2d637e
Content-Type: multipart/mixed;boundary=---------------------6486fb8921cf390c01f25a6c9d911a1e

-----------------------6486fb8921cf390c01f25a6c9d911a1e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8






On Saturday, September 7th, 2024 at 6:53 AM, Joe Perches <joe@perches.com>=
 wrote:

> =


> =


> On Fri, 2024-09-06 at 18:05 +0000, Patrick Miller wrote:
> =


> > Adds a check for documentation in rust file. Warns if certain known
> > documentation headers are not plural. Even though some sections may
> > be singular (i.e. only one example), the header should still be plural
> > so that more examples can be added later without needing to change the
> > header.
> > =


> > Fixed the whitespace issue on my previous patch.
> =


> =


> Well, one of them.
> =


> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> =


> []
> =


> > @@ -3900,6 +3900,13 @@ sub process {
> > "Avoid using '.L' prefixed local symbol names for denoting a range of =
code via 'SYM_*_START/END' annotations; see Documentation/core-api/asm-ann=
otations.rst\n" . $herecurr);
> > }
> > =


> > +# check that document section headers are plural in rust files
> > + if ($realfile =3D~ /\.rs$/
> > + && $rawline =3D~ /^\+\s*\/\/\/\s+#+\s+(Example|Invariant|Guarantee|P=
anic)\s*$/) {
> > + WARN( "RUST_DOC_HEADER",
> > + "Rust doc headers should be plural\n" . $herecurr );
> =


> =


> There is no autoformatter for checkpatch/perl/etc.
> =


> Continuation && on previous line
Will fix this. Is there a code style document for the perl scripts?
> No space after open paren
> Align to open paren
> No space before close paren
I based my coding style off of the if statement directly above mine,
although I did miss the continuation of &&

> =


> I think this is an overly trivial addition.
I am responding to an issue that is part of rust-for-linux. Maybe
Miguel Ojeda has something to add on this matter?
-----------------------6486fb8921cf390c01f25a6c9d911a1e
Content-Type: application/pgp-keys; filename="publickey - paddymills@proton.me - 0xDCA74891.asc"; name="publickey - paddymills@proton.me - 0xDCA74891.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - paddymills@proton.me - 0xDCA74891.asc"; name="publickey - paddymills@proton.me - 0xDCA74891.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWWs0UnNSWUpLd1lCQkFI
YVJ3OEJBUWRBU1FhVy9FUmQ4dGZncXNNSHQweTY3ZFdRTEU3UnV2T3gKM2p6YWdhRWI0c0xOSzNC
aFpHUjViV2xzYkhOQWNISnZkRzl1TG0xbElEeHdZV1JrZVcxcGJHeHpRSEJ5CmIzUnZiaTV0WlQ3
Q2p3UVFGZ29BSUFVQ1lrNFJzUVlMQ1FjSUF3SUVGUWdLQWdRV0FnRUFBaGtCQWhzRApBaDRCQUNF
SkVKdFJHcnN1cjU0UkZpRUUzS2RJa1N2VW5DdmU4MDFtbTFFYXV5NnZuaEZpcUFFQXQwVCsKcGdw
MFJvV3dJZm1EUEZUbjNsbVRRcVA0dUEreDRnNXB2OG5SSHBJQS8xVU1YLzh3akZlK24wZUM0V0pq
Cnk0bjUvTmVLcTF6LzhQSnRZYXVzZVZnT3pqZ0VZazRSc1JJS0t3WUJCQUdYVlFFRkFRRUhRRi9m
TnBEZgpsbERSbkhIcmVIdlR0SXRGd3VETDNLWkFhaDhZd3dxV0FyNFJBd0VJQjhKNEJCZ1dDQUFK
QlFKaVRoR3gKQWhzTUFDRUpFSnRSR3JzdXI1NFJGaUVFM0tkSWtTdlVuQ3ZlODAxbW0xRWF1eTZ2
bmhHR2Z3RUFuWkFzCkdwb0w3UWk5VkNOT3Bja3IwdjhONUt4YnNsSUxmZVArMmNJU0hlY0Erd1Rx
WDNsZ3dnNVJDN1lBT1MvUQowQ3NxMGNrT0kwSm5zTEtVWlNyOE5Sb0IKPVcxOG4KLS0tLS1FTkQg
UEdQIFBVQkxJQyBLRVkgQkxPQ0stLS0tLQo=
-----------------------6486fb8921cf390c01f25a6c9d911a1e--

--------c25aa81a236cb3efd22076370285a2ca0d870d6e96c31340e75228503c2d637e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmbcP4QJkJtRGrsur54RFiEE3KdIkSvUnCve801mm1Eauy6v
nhEAANjSAP0R1y6G1QSPp2cntnwCBGd930ErjNDr+EI9Oli/tQGNMQEAhlYq
Y5+u3eQVtDws6WjGuY9qPRHVMMzlj3qvDF3G9ww=
=YzhF
-----END PGP SIGNATURE-----


--------c25aa81a236cb3efd22076370285a2ca0d870d6e96c31340e75228503c2d637e--


