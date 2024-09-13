Return-Path: <linux-kernel+bounces-328786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC5F9788D6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 879071F284EC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5625146593;
	Fri, 13 Sep 2024 19:22:00 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4BD81ACA;
	Fri, 13 Sep 2024 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726255320; cv=none; b=gKLs4CZJ1gcS4WdPFFIlkA84QSvcTBgugct5CM2vDq1f8q/k4bFuRXs9VSAT+QtgqKIUeuVcngS0ec/NN1PAgwTp5L1vm63nvTbhUDcJz/Mm1InNTrJiNIakiXfpAa0U6Mx8D6NaOC8AB8C8ryTmP0/FWfkQy8xwp251v7YpC80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726255320; c=relaxed/simple;
	bh=ZQM8CD1kD99CvLK6K7g7ZMI2Hq16NJsjb7Dgc1IsfIE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tt449XrA/s+JgsFEHzwYq0JGXEnPoqlztJlkS8uO32Fo975otj9XohT7pn2k3x/t+gBD6A7ebdLZjmlpquo4HYBlJRf19sO/fMIksZyEjwcdP9wt/K+qNGg9Im5l5padOgojYsAEE135S7Ua7NzPXgnozJzYHcps2VgLp8gT64Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id A9807160572;
	Fri, 13 Sep 2024 19:21:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id A1EFB80015;
	Fri, 13 Sep 2024 19:21:42 +0000 (UTC)
Message-ID: <ab5a84a40a5bf73001cd35f6f9108830ff70c5ee.camel@perches.com>
Subject: Re: [PATCH v3 2/2] checkpatch: warn on known non-plural rust doc
 headers
From: Joe Perches <joe@perches.com>
To: Alice Ryhl <aliceryhl@google.com>, Patrick Miller <paddymills@proton.me>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, apw@canonical.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	dwaipayanray1@gmail.com, gary@garyguo.net, linux-kernel@vger.kernel.org, 
	lukas.bulwahn@gmail.com, ojeda@kernel.org, rust-for-linux@vger.kernel.org, 
	tmgross@umich.edu, wedsonaf@gmail.com
Date: Fri, 13 Sep 2024 12:21:41 -0700
In-Reply-To: <CAH5fLghxvLoQp+G1oaaVfBx6DOh-GO0Wc=jboiwz9ZCoEtHVpA@mail.gmail.com>
References: <20240912195649.227878-1-paddymills@proton.me>
	 <CAH5fLghxvLoQp+G1oaaVfBx6DOh-GO0Wc=jboiwz9ZCoEtHVpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: A1EFB80015
X-Stat-Signature: tz3qx8g7ouw6t7nkim19u4ckeoubazjp
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/aRxPMT+/CRXro5IBmWG7I/PzwEEtQu20=
X-HE-Tag: 1726255302-330878
X-HE-Meta: U2FsdGVkX18EQHP7P887iFhkJQlxBUfa0+kx6/Qfgins8f89ci0jvtF6gYBreY//mt2+vCBagf0p9zWz77ORsq6SMHcezADxVrALfXSP5gnUfwuVoxQeSL3vV3l4D1AUV/ONp4uEPrZFy5gc2l8fPEeuwFlkk9Zkd5h2ldRrlsKwyk5I/uStOrCKnhysZH1YfeOrTrJubtM3pib700tfi5IYuuIYqIEv7WyDJKDLlF1nTBeb12KBLxWnfSJYr16pDovb22gRnKVhuPq1AmKbzGeLNwgCZ2gRU3FQxpS6A4MsA3bggEXj+dV92IC0z2f5/BA+Ii6UwYROOSwnkwVugpPnM8KazhMNoXd5FiWAj9AWBM7vcIpSRw==

On Fri, 2024-09-13 at 09:33 +0200, Alice Ryhl wrote:
> On Thu, Sep 12, 2024 at 9:57=E2=80=AFPM Patrick Miller <paddymills@proton=
.me> wrote:
> >=20
> > Adds a check for documentation in rust file. Warns if certain known
> > documentation headers are not plural.
> >=20
> > The rust maintainers prefer document headers to be plural. This is to e=
nforce
> > consistency among the documentation as well as to protect against error=
s when
> > additions are made. For example, if the header said "Example" because t=
here was
> > only 1 example, if a second example was added, making the header plural=
 could
> > easily be missed and the maintainers prefer to not have to remind peopl=
e to fix
> > their documentation.
> >=20
> > Link: https://github.com/Rust-for-Linux/linux/issues/1110
> >=20
> > v1: https://lore.kernel.org/rust-for-linux/2024090628-bankable-refusal-=
5f20@gregkh/T/#t
> > v2: https://lore.kernel.org/rust-for-linux/92be0b48-cde9-4241-8ef9-7fe4=
d7c42466@proton.me/T/#t
> >   - fixed whitespace that was formatted due to editor settings
> > v3:
> >   - move && to previous line and remove whitespace in WARN per Joe Perc=
hes
> >   - reformat following C coding style
> > ---
> >  scripts/checkpatch.pl | 7 ++++
> > +++
> >  1 file changed, 7 insertions(+)
>=20
> This is missing your Signed-off-by and the changelog should be below
> the --- line so it doesn't get included in the changelog when applied.
[]
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> > @@ -3900,6 +3900,13 @@ sub process {
> >                              "Avoid using '.L' prefixed local symbol na=
mes for denoting a range of code via 'SYM_*_START/END' annotations; see Doc=
umentation/core-api/asm-annotations.rst\n" . $herecurr);
> >                 }
> >=20
> > +# check that document section headers are plural in rust files
> > +               if ($realfile =3D~ /\.rs$/ &&
> > +                   $rawline =3D~ /^\+\s*\/\/\/\s+#+\s+(Example|Invaria=
nt|Guarantee|Panic)\s*$/) {
> > +                       WARN("RUST_DOC_HEADER",
> > +                            "Rust doc headers should be plural\n" . $h=
erecurr);

While OK my suggestion would be to add a $fix option
and be case insensitive

		if ($realfile =3D~ /\.rs$/ &&
		    $rawline =3D~ /^\+\s*\/\/\/\s+#+\s+(Example|Invariant|Guarantee|Panic=
)\s*$/i) {
			if (WARN("RUST_DOC_HEADER",
	                       	 "Rust doc header '$1' should be plural\n" . $here=
curr) &&
			    $fix) {
				$fixed[$fixlinenr] =3D s/\b$1\b/ucfirst(lc($1))/e;
			}

And if there are going to be more rust specific tests,
there should be a rust specific block to avoid continual
tests of $realfile =3D~ /\.rs$/


