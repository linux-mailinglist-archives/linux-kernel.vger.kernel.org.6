Return-Path: <linux-kernel+bounces-321772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF401971F45
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBA011C2359A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9B21662E4;
	Mon,  9 Sep 2024 16:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="KNrBinPD"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2DD15B134;
	Mon,  9 Sep 2024 16:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899524; cv=none; b=ZaMhQmT3sWg19Pj3C90XVlSbTW8JbJe+phmqkecAvLoELcOfmlVcfDpsAHR1ti2LbMKW6tkC28tbcML7/BdXG5y7AdkE8mHEvCEnBZLYxjUAaTkW9iTUu7fElqsC6qeOfRysnc+zx8rAvv2kZF41BCQwcXjp9TpRv+YyiIsM8XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899524; c=relaxed/simple;
	bh=4CZwxJBbWxWCsg5YCXkGI2ewv6grMpHPhj599vj9Axc=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJydIpoEnO4Yv1T9DNz4D4DDgzEAMn8oswvgS08hNI5EezE7UGdoAHP1muAkiJUViMKCJt+zS4SBZ/5Nm7xc8Z9Ypqg+pPvn+e3ZIVgvMEjjBkHbyFVRfhnRKMyTrTv0M61sSk9B3pjKYijvN/jgJI9uON9Jb/OPffCydvid6qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=KNrBinPD; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725899521; x=1726158721;
	bh=pglrHc+owpO38UuwlAlT67y8QX6+R6hVo9C+YIfTMdo=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KNrBinPDkvuNLlZgUEkImruSSvAJyfAwYiTMDXtQm4JgaeeAlCT6Sm0xbCmcWjYHq
	 k/ro1ss8glb+8MP1fcjG+QqmUhfOqxEjA3aM8eZwuHb7sEwWVi1luQt8fOtUtfP1b3
	 W0lsxfbLTFNrTn2bIaDXeXbm5ObMfFAgrJGAv0Q6tTKjbZBsYIEwrflY00IBHSnfkl
	 0FF3/yrruxmfMLe1BJ7mGGz5knEfyDeXgcvhe4tyJs/XrylAzFbpY2hklO4THBWhm4
	 r1FywUeXWeGSyTXjRBw5IylwvB/h/HR926IAqFeMj2lhI1OX9kFeSTmxJfpJy/2c23
	 D7D9XEKS/2w+g==
Date: Mon, 09 Sep 2024 16:31:58 +0000
To: Patrick Miller <paddymills@proton.me>, a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, apw@canonical.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dwaipayanray1@gmail.com, gary@garyguo.net, joe@perches.com, linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com, ojeda@kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, wedsonaf@gmail.com
From: Benno Lossin <benno.lossin@proton.me>
Subject: Re: [PATCH 2/2] checkpatch: warn on known non-plural rust doc headers
Message-ID: <a736d612-7484-4eba-9bcc-f9331e5ed976@proton.me>
In-Reply-To: <20240906180456.2302688-1-paddymills@proton.me>
References: <20240906180456.2302688-1-paddymills@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 66b1b9f815d45c3002b7e54c7513f94c35266d68
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the patch!

On 06.09.24 20:05, Patrick Miller wrote:
> Adds a check for documentation in rust file. Warns if certain known
> documentation headers are not plural. Even though some sections may
> be singular (i.e. only one example), the header should still be plural
> so that more examples can be added later without needing to change the
> header.
>=20
> Fixed the whitespace issue on my previous patch.

This line shouldn't be part of the commit message, as it only makes
sense if you know there existed a previous version. You can put a
changelog underneath the `---` line, that part won't be put into the
final commit message.

I am not familiar with perl, but the regex looks good to me.

---
Cheers,
Benno

> Signed-off-by: Patrick Miller <paddymills@proton.me>
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1110
>=20
> ---
>  scripts/checkpatch.pl | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 39032224d504..cb5ecdb6df9b 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3900,6 +3900,13 @@ sub process {
>  =09=09=09     "Avoid using '.L' prefixed local symbol names for denoting=
 a range of code via 'SYM_*_START/END' annotations; see Documentation/core-=
api/asm-annotations.rst\n" . $herecurr);
>  =09=09}
>=20
> +# check that document sec
> tion headers are plural in rust files
> +=09=09if ($realfile =3D~ /\.rs$/
> +=09=09=09&& $rawline =3D~ /^\+\s*\/\/\/\s+#+\s+(Example|Invariant|Guaran=
tee|Panic)\s*$/) {
> +=09=09=09WARN( "RUST_DOC_HEADER",
> +=09=09=09=09"Rust doc headers should be plural\n" . $herecurr );
> +=09=09}
> +
>  # check we are in a valid source file C or perl if not then ignore this =
hunk
>  =09=09next if ($realfile !~ /\.(h|c|pl|dtsi|dts)$/);
>=20
> --
> 2.46.0
>=20


