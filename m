Return-Path: <linux-kernel+bounces-319751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCF09701C5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 12:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 762DD1C215D6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 10:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BF2158536;
	Sat,  7 Sep 2024 10:59:11 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4803127E01;
	Sat,  7 Sep 2024 10:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725706751; cv=none; b=L9gbKVXOqc3YyFQlNzc9HAPHSGUWxQXixj9SYM6S/8k6mwJCWU3iyRVkeYxkrTUR3cn8218aSSEFq/LPTBkXcICQRx3De4KPpV2ha4rtU/C8VGB3ZAOvxmkFQiAKiWZQyMoau2bEBpP65gIVQyZi9znMAaeego3M/PVZ4Cqn0DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725706751; c=relaxed/simple;
	bh=kpxElk2dkoAlcFJ5feqpmZiQ58Ydf62BvvTiM22WHms=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pYHLQPbBoP7py91G5jz44fsWV0qpw/mrJKragYx5U5FFrjUgCrSawsJUhWycPbs/Oj3GVmGv97Truk7FbU2+FJ46jPEDhozP2cpuX/SP4d306xTsR23LajBwYLRFIPdIZTPbau4d5A57qaVAeYC+e1GBqT2T2grdw/aYQpx0QPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id E81831617C4;
	Sat,  7 Sep 2024 10:53:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id BA24B6000B;
	Sat,  7 Sep 2024 10:53:04 +0000 (UTC)
Message-ID: <db693ef6c064fa42eda323f067d4270baf68b1f5.camel@perches.com>
Subject: Re: [PATCH 2/2] checkpatch: warn on known non-plural rust doc
 headers
From: Joe Perches <joe@perches.com>
To: Patrick Miller <paddymills@proton.me>, a.hindborg@samsung.com, 
	alex.gaynor@gmail.com, aliceryhl@google.com, apw@canonical.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	dwaipayanray1@gmail.com, gary@garyguo.net, linux-kernel@vger.kernel.org, 
	lukas.bulwahn@gmail.com, ojeda@kernel.org, rust-for-linux@vger.kernel.org, 
	tmgross@umich.edu, wedsonaf@gmail.com
Date: Sat, 07 Sep 2024 03:53:03 -0700
In-Reply-To: <20240906180456.2302688-1-paddymills@proton.me>
References: <20240906180456.2302688-1-paddymills@proton.me>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: BA24B6000B
X-Rspamd-Server: rspamout01
X-Stat-Signature: 835gqfdxxbzxjbte386dejxc7ucdzbck
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19J62pEc0qGcTEGxQZhEymOZJlI8WC6kkg=
X-HE-Tag: 1725706384-574290
X-HE-Meta: U2FsdGVkX1/PE69iYO7Hp2ebYr1TVllNJQ+fcrf1CU+2fB4PQ0FsTyJifx6RySv+WqW2zWdG03pQDpHUID8vsuHnDivW4VWeb2pw1fRTKpyQk1APx2PepzuqmP1WIXDH0BkasSyNKb9lPlTf+iiysVKA0Uwrmzof7R+4UEtiQWlK0tOB+5IEbpsPTzMV8yRIlmNoQf2g5w/K2A1oYOGULnU6Bd1oZbvGWGxfWGaFofcHoiPh3YbZfT9TkwjkXKLTIt8vimp0J+tJ6mJb2mW5FLjRayQ76mou7y8rxYKtqb8kWhM1c50jSzDC0muijQA+

On Fri, 2024-09-06 at 18:05 +0000, Patrick Miller wrote:
> Adds a check for documentation in rust file. Warns if certain known
> documentation headers are not plural. Even though some sections may
> be singular (i.e. only one example), the header should still be plural
> so that more examples can be added later without needing to change the
> header.
>=20
> Fixed the whitespace issue on my previous patch.

Well, one of them.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3900,6 +3900,13 @@ sub process {
>  			     "Avoid using '.L' prefixed local symbol names for denoting a ran=
ge of code via 'SYM_*_START/END' annotations; see Documentation/core-api/as=
m-annotations.rst\n" . $herecurr);
>  		}
> =20
> +# check that document section headers are plural in rust files
> +		if ($realfile =3D~ /\.rs$/
> +			&& $rawline =3D~ /^\+\s*\/\/\/\s+#+\s+(Example|Invariant|Guarantee|Pa=
nic)\s*$/) {
> +			WARN( "RUST_DOC_HEADER",
> +				"Rust doc headers should be plural\n" . $herecurr );

There is no autoformatter for checkpatch/perl/etc.

Continuation && on previous line
No space after open paren
Align to open paren
No space before close paren

I think this is an overly trivial addition.


