Return-Path: <linux-kernel+bounces-321765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 300BB971F1B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648231C22A46
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115C21531C7;
	Mon,  9 Sep 2024 16:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="RCA3BELB"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC4214B09F;
	Mon,  9 Sep 2024 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899109; cv=none; b=B/iVre95G4wHdtjnbJpPQj50iBZzY5xIQBnw7R1M3T5gzcAQgKV6VssrOW0Z0Pt+Ies3ej5mx+HDXvo0i/v9QSsIzLHwW+89cV+k8mGe66qYWEr36d7uZoHHYAg/t75Ee/aPGU+wrB733/m+341IV0pwoA+93MG78HGOosmoRxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899109; c=relaxed/simple;
	bh=xhsqEHr5Lya2HrKdzyJ7IGw9smbplfMqwbvY3nAvQys=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=noQoXd1RGg37ZsxWNVWklGFthQDLz4R49p7+G6GAcVTJCrX4gvp3WyBNG6Weg82LFoT5ejFHKqgDhBwEw/mejxEsad2fC8OF4rz0uwXwmtxHKyfMtpfjW73LakcqmoIC7dCouP6WAKx+v5Zoejuo0T46xB1Y9xSw2v7bw0tViqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=RCA3BELB; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725899099; x=1726158299;
	bh=oi3Y34JIxk7wPwLnhM8Uobni8KdU1kfw/MqLzQcy9io=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RCA3BELBCMZaPLDsOWi874Ao5HLYr4EFaSED1f2asV2g+sZhGUJ6IsHw65PZ83nvC
	 iKKTPP1MsjiMScfYyORGBANfdIPAYvcNdfwMHJvJdvuSC0w7Pwx8B2LQkFdyKTMH4z
	 +1744BkKAG189dSZgpTQttpgs5NEVY/asxzM6GnAJzPz+ToZa3BvYRXdNxgKSBngCe
	 jp8HS8U8XOnmix2ct5bntknMlCQmOeA9nDn6t8jLn+vK8t5WgJli9/yOG5TTNxGrec
	 T8SjB6752qkLiSQ6rPvJqpZMjzAdq2dYUNLXP38MulsDEQjESD1i7Ml2Udeiwpnc0S
	 uip/5poy2KLag==
Date: Mon, 09 Sep 2024 16:24:55 +0000
To: Joe Perches <joe@perches.com>, Patrick Miller <paddymills@proton.me>, a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, apw@canonical.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dwaipayanray1@gmail.com, gary@garyguo.net, linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com, ojeda@kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, wedsonaf@gmail.com
From: Benno Lossin <benno.lossin@proton.me>
Subject: Re: [PATCH 2/2] checkpatch: warn on known non-plural rust doc headers
Message-ID: <de23288b-6d98-4808-98a8-32830165650d@proton.me>
In-Reply-To: <db693ef6c064fa42eda323f067d4270baf68b1f5.camel@perches.com>
References: <20240906180456.2302688-1-paddymills@proton.me> <db693ef6c064fa42eda323f067d4270baf68b1f5.camel@perches.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 1381c960fa16e2a7121a1c924455fa9af9a59940
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.09.24 12:53, Joe Perches wrote:
> On Fri, 2024-09-06 at 18:05 +0000, Patrick Miller wrote:
>> Adds a check for documentation in rust file. Warns if certain known
>> documentation headers are not plural. Even though some sections may
>> be singular (i.e. only one example), the header should still be plural
>> so that more examples can be added later without needing to change the
>> header.
>>
>> Fixed the whitespace issue on my previous patch.
>=20
> Well, one of them.
>=20
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -3900,6 +3900,13 @@ sub process {
>>  =09=09=09     "Avoid using '.L' prefixed local symbol names for denotin=
g a range of code via 'SYM_*_START/END' annotations; see Documentation/core=
-api/asm-annotations.rst\n" . $herecurr);
>>  =09=09}
>>
>> +# check that document section headers are plural in rust files
>> +=09=09if ($realfile =3D~ /\.rs$/
>> +=09=09=09&& $rawline =3D~ /^\+\s*\/\/\/\s+#+\s+(Example|Invariant|Guara=
ntee|Panic)\s*$/) {
>> +=09=09=09WARN( "RUST_DOC_HEADER",
>> +=09=09=09=09"Rust doc headers should be plural\n" . $herecurr );
>=20
> There is no autoformatter for checkpatch/perl/etc.
>=20
> Continuation && on previous line
> No space after open paren
> Align to open paren
> No space before close paren
>=20
> I think this is an overly trivial addition.

We want this so we don't have to manually remind people to fix their
documentation sections. Quoting Miguel from the issue [1]:

> We prefer plurals when writing code documentation sections:
> `# Examples`, `# Invariants`, `# Guarantees` and `# Panics`, so that
> it is consistent and so that one can add more examples without having
> to change the section name.

[1]: https://github.com/Rust-for-Linux/linux/issues/1110

---
Cheers,
Benno


