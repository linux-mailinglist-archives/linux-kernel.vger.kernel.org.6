Return-Path: <linux-kernel+bounces-328062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE7B977E79
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D98F286FED
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD771D86DC;
	Fri, 13 Sep 2024 11:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="XKXZ8DDC"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BED19C57E;
	Fri, 13 Sep 2024 11:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726227068; cv=none; b=Cetr7DA60kuECg4pKiqtdwlWm4HQkGXoj5iBv9s+mOcxM1g8RWXJ8kJFJ4M4cD/QmNr2J5P+bg6je9Keen2HsY6LPio7TMsN7VTgz5VJW5HonWVGrdx6gn3GVDeWuVJziNerGt/cQ8qtPhlHnhU3h1M30g2NTTMXiin3FqxWdu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726227068; c=relaxed/simple;
	bh=PBiyvnFxb3gq0sSh6looQHeFgt+o5fyRNAGt4jP8Das=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZuZzm3wvr+1nHT6zpAMmv/gkOcu4ShBGuso8SL7Z3LrCJGfSWBODLrycNAQrJISeOKgmz+jt/OTh/kEUMmgKl8Daj7Tw6HgBX0yAMZYXyloG9cGEiNmziIJ5niHPt0AyoVUP9WqBLhZ8cDAtOTU4jSjjDkxgJFywLSQKRrmNxRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=XKXZ8DDC; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=rd35sziulreebakooj7htuyhta.protonmail; t=1726227064; x=1726486264;
	bh=qud21Kk3XyEwvYAeTcmW9H0401PiuN9myDU9jIykWFk=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XKXZ8DDCG2+sYvepf1usAAXc0kIIhrXEbPuZl8WzKACvwSxViDFUPjiV0fAhBxpoz
	 5mTD4QqHeKf/oThmqAruKm8WXMv2W1RkvgCxVifqt9Pm4N7PWHObtLmVRJekVGk01P
	 ALuizn2fDpCKI8uGbt0jkI65YuNT4R6KG1wLz5wOmzziGqNetg3lWqsYAG90DIkGv1
	 cO69/M0CqxO18OoLvokGpGGjD5ubrfIL3EyZYkBTL5r+H7E09GQWA6fkW0wJ+3e0bG
	 VBpJPTfdcdBnGWWbLe3xvp09LL/cHly3pp7WT3WstKyhcC4Z2SGPVitfnbxnMdZDKo
	 tzcQBdJ9rgSEg==
Date: Fri, 13 Sep 2024 11:30:58 +0000
To: Patrick Miller <paddymills@proton.me>, a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, apw@canonical.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dwaipayanray1@gmail.com, gary@garyguo.net, joe@perches.com, linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com, ojeda@kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, wedsonaf@gmail.com
From: Benno Lossin <benno.lossin@proton.me>
Subject: Re: [PATCH v3 2/2] checkpatch: warn on known non-plural rust doc headers
Message-ID: <da34f89c-f94c-43aa-946c-57fec3597974@proton.me>
In-Reply-To: <20240912195649.227878-1-paddymills@proton.me>
References: <20240912195649.227878-1-paddymills@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 17aa4962786633573ca30a74d31b385608d19a9e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.09.24 21:56, Patrick Miller wrote:
> Adds a check for documentation in rust file. Warns if certain known
> documentation headers are not plural.
>=20
> The rust maintainers prefer document headers to be plural. This is to enf=
orce
> consistency among the documentation as well as to protect against errors =
when
> additions are made. For example, if the header said "Example" because the=
re was
> only 1 example, if a second example was added, making the header plural c=
ould
> easily be missed and the maintainers prefer to not have to remind people =
to fix
> their documentation.

Nit: this is wrapped to 80 chars, but a maximum of 75 columns is
preferred. I usually use 72.

---
Cheers,
Benno

> Link: https://github.com/Rust-for-Linux/linux/issues/1110
>=20
> v1: https://lore.kernel.org/rust-for-linux/2024090628-bankable-refusal-5f=
20@gregkh/T/#t
> v2: https://lore.kernel.org/rust-for-linux/92be0b48-cde9-4241-8ef9-7fe4d7=
c42466@proton.me/T/#t
>   - fixed whitespace that was formatted due to editor settings
> v3:
>   - move && to previous line and remove whitespace in WARN per Joe Perche=
s
>   - reformat following C coding style
> ---
>  scripts/checkpatch.pl | 7 ++++
> +++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 39032224d504..5b18246ad511 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3900,6 +3900,13 @@ sub process {
>  =09=09=09     "Avoid using '.L' prefixed local symbol names for denoting=
 a range of code via 'SYM_*_START/END' annotations; see Documentation/core-=
api/asm-annotations.rst\n" . $herecurr);
>  =09=09}
>=20
> +# check that document section headers are plural in rust files
> +=09=09if ($realfile =3D~ /\.rs$/ &&
> +=09=09    $rawline =3D~ /^\+\s*\/\/\/\s+#+\s+(Example|Invariant|Guarante=
e|Panic)\s*$/) {
> +=09=09=09WARN("RUST_DOC_HEADER",
> +=09=09=09     "Rust doc headers should be plural\n" . $herecurr);
> +=09=09}
> +
>  # check we are in a valid source file C or perl if not then ignore this =
hunk
>  =09=09next if ($realfile !~ /\.(h|c|pl|dtsi|dts)$/);
>=20
> --
> 2.46.0
>=20


