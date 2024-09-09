Return-Path: <linux-kernel+bounces-321785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 939C7971F67
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70C61F22E78
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E6916A94F;
	Mon,  9 Sep 2024 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="CwhrgQs8"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5424206D;
	Mon,  9 Sep 2024 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899936; cv=none; b=DqGpu2Anojvg1xdJ7nNFVYI4GXX9jRUJcjlFheH44XLpUJuy7BZTcalRpE2sEqLL7S8iAr8O4Woi5q95O3bQYNf6jRKrv7bA0t8yBGLsQwJkQMJ4ZgqK+yaCFdHDjXIxeB8xAST6hqGCY9nvwLl2kZeJH4A6bdabn2fYwjMI4uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899936; c=relaxed/simple;
	bh=mLtUps/z9cLZlncaKlaCwtIFK+oWzMk5ItgTY7oPdyQ=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qTgl6x/F2C79dDgcMTUXsV5LXrAm3n4OpTZqtvMPQpw1fLvotzhS1UtFN6Kp7BT8xeCaMMksHYT3iiBYcV9aE21wOLhiU8jC3ANgKJn+umZSF+nHj0nQ/HcSOg40Yq/SwwfuXnJxmk6Y+a+28YzdIgHBhSjgLjvOEuuvsle5w6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=CwhrgQs8; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=wlefklfgcvcgjikhh4ya5zt5da.protonmail; t=1725899926; x=1726159126;
	bh=uaL6XOe7sG0b+3AP4HwLIJmsZwXJhASFgo5AWJciR3s=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CwhrgQs8NaLVsaYj3+XQyD2phnkr1WOCJDsKV4f44olw6lKDTK18IJxVNLpPp8+2R
	 Fjj0TVhIZ6l4GQ81+DeHCXwOD3ugRisYAGExL6ij0I+VpDyCqRi06UPgI/Os4O1Npv
	 k9UnmCluCINsptBD5L6iZ/ofDaUcYb4BRbgHkSOXeApz7YrnVhOFVfPzTA3E8F1igR
	 gtnTZ/FZDUvjmVulhWTJDbMaea6OZBQnhEKy2GyKz2/A0dLttQGImMtUBqHU+I/AyI
	 vxEOhQ8qsJeWhuoxZryhmh3lWiWqXMVfwODICCem9mqF3VQ+lNwlhra6gi1+l5rnsL
	 ox/33+DY52KSw==
Date: Mon, 09 Sep 2024 16:38:40 +0000
To: Patrick Miller <paddymills@proton.me>, a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, apw@canonical.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dwaipayanray1@gmail.com, gary@garyguo.net, joe@perches.com, linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com, ojeda@kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, wedsonaf@gmail.com
From: Benno Lossin <benno.lossin@proton.me>
Subject: Re: [PATCH 2/2] checkpatch: warn on known non-plural rust doc headers
Message-ID: <92be0b48-cde9-4241-8ef9-7fe4d7c42466@proton.me>
In-Reply-To: <a736d612-7484-4eba-9bcc-f9331e5ed976@proton.me>
References: <20240906180456.2302688-1-paddymills@proton.me> <a736d612-7484-4eba-9bcc-f9331e5ed976@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: ce474763051e7eb3ca3d8ca047202a4697e033dc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09.09.24 18:31, Benno Lossin wrote:
> Hi,
>=20
> Thanks for the patch!
>=20
> On 06.09.24 20:05, Patrick Miller wrote:
>> Adds a check for documentation in rust file. Warns if certain known
>> documentation headers are not plural. Even though some sections may
>> be singular (i.e. only one example), the header should still be plural
>> so that more examples can be added later without needing to change the
>> header.
>>
>> Fixed the whitespace issue on my previous patch.
>=20
> This line shouldn't be part of the commit message, as it only makes
> sense if you know there existed a previous version. You can put a
> changelog underneath the `---` line, that part won't be put into the
> final commit message.

Also one more thing that I forgot, when sending a new version of a
patch, please mark it in the patch title with `[PATCH v2 2/2]` (you can
do it with `git format-patch -v2`).

Also don't immediately resend it, but wait for other people to also
provide feedback.

---
Cheers,
Benno

> I am not familiar with perl, but the regex looks good to me.
>=20
> ---
> Cheers,
> Benno
>=20
>> Signed-off-by: Patrick Miller <paddymills@proton.me>
>> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
>> Link: https://github.com/Rust-for-Linux/linux/issues/1110
>>
>> ---
>>  scripts/checkpatch.pl | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 39032224d504..cb5ecdb6df9b 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -3900,6 +3900,13 @@ sub process {
>>  =09=09=09     "Avoid using '.L' prefixed local symbol names for denotin=
g a range of code via 'SYM_*_START/END' annotations; see Documentation/core=
-api/asm-annotations.rst\n" . $herecurr);
>>  =09=09}
>>
>> +# check that document sec
>> tion headers are plural in rust files
>> +=09=09if ($realfile =3D~ /\.rs$/
>> +=09=09=09&& $rawline =3D~ /^\+\s*\/\/\/\s+#+\s+(Example|Invariant|Guara=
ntee|Panic)\s*$/) {
>> +=09=09=09WARN( "RUST_DOC_HEADER",
>> +=09=09=09=09"Rust doc headers should be plural\n" . $herecurr );
>> +=09=09}
>> +
>>  # check we are in a valid source file C or perl if not then ignore this=
 hunk
>>  =09=09next if ($realfile !~ /\.(h|c|pl|dtsi|dts)$/);
>>
>> --
>> 2.46.0
>>
>=20
>=20


