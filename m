Return-Path: <linux-kernel+bounces-514256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3591AA354B0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 03:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA6877A3F55
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 02:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9D1136326;
	Fri, 14 Feb 2025 02:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXYIY680"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AE42AF16;
	Fri, 14 Feb 2025 02:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739499907; cv=none; b=M6Ngd0rYSRQV+QMXMcE1BiKZsPZOIlWr5InQwh0YsTVCkQFQZecsKDtTmjcVcQBqh4CBUnu6j3vQR4LsANvATkes9I6i14GpXordTB22+6dLBj9aol9Bh/sGnfoH+2qcRFwQdc/hubFWo3tR6G5BaZCxo01xNbPGbK5cfCkQJIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739499907; c=relaxed/simple;
	bh=Z6DGSCB3WS833S/uhOUTmiOjUXJ0YGRt01DkitcHLwM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/bD/wHwctG9hQzSHdM0vtH9cW6+du1G/DA9kU8U9KISBiSMzPFHQ7gLRF3aE+y2VmVBJzB71ywHZ6vIGBrldB+3a/TFU/g0+TsUmHZd91NXKEt/NgeOt+8fFZa2iR/GCCwz4P2G0pf1JwCVu0sGGRhpWgtQBYyAuQBw2UGu0s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXYIY680; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9FDC4CED1;
	Fri, 14 Feb 2025 02:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739499906;
	bh=Z6DGSCB3WS833S/uhOUTmiOjUXJ0YGRt01DkitcHLwM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dXYIY680jj1PYNQ9zGGqc1G4ZxDUBjQnvqNidNfdCJ5sEA1zjaVwFZU1DMJeTTpWs
	 0Z6cATMzF9L8zFUdpwjT3mVi7N0Zq8DX6gia6+H+ETwQtuwKZEBiTTO2zWYj6pQNBo
	 HPTPufHKHlgIK7yPVXxNiNVZA0qLMphx6LcikiZ/q6egV0CwCibVpzzJcMkpAbZuif
	 +jNtcq6apOR9UgOn7QEfORebng8r5Y5SFcMF3fjwAob/9gox+g9VpcDFGUKp9GwUHf
	 XIwgoedwx+CuDvFMw1s16toDQgmPEqkbLOVr8k7X0zRMWsF+lOb+gRJpGujKQT95vl
	 hR8Bj7agXwxPA==
Date: Fri, 14 Feb 2025 03:24:57 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/kernel-doc: remove an obscure logic from
 kernel-doc
Message-ID: <20250214032457.6444ee93@foz.lan>
In-Reply-To: <87wmdt6bv5.fsf@trenco.lwn.net>
References: <fd3b28dec36ba1668325d6770d4c4754414337fc.1739340170.git.mchehab+huawei@kernel.org>
	<87wmdt6bv5.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Em Thu, 13 Feb 2025 09:35:58 -0700
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
>=20
> > Kernel-doc has an obscure logic that uses an external file
> > to map files via a .tmp_filelist.txt file stored at the current
> > directory. The rationale for such code predates git time,
> > as it was added on Kernel v2.4.5.5, with the following description:
> >
> > 	# 26/05/2001 -         Support for separate source and object trees.
> > 	#              Return error code.
> > 	#              Keith Owens <kaos@ocs.com.au>
> >
> > from commit 396a6123577d ("v2.4.5.4 -> v2.4.5.5") at the historic
> > tree:
> > 	https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/
> >
> > Support for separate source and object trees is now done on a different
> > way via make O=3D<object>.
> >
> > There's no logic to create such file, so it sounds to me that this is
> > just dead code.
> >
> > So, drop it.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  scripts/kernel-doc | 19 +------------------
> >  1 file changed, 1 insertion(+), 18 deletions(-) =20
>=20
> Weird ... I went and looked, and can't find anything that ever created
> that tmp_filelist.txt file; I wonder if this code ever did anything?

I wonder the same ;-) Anyway, better to remove this now, as, if people
complain, it would be easier to revert than after switching to the
Python version.

> Don't put that functionality into the Python version :)

Yeah, I started implementing it, but it sounded a waste of time, so
I dropped it from the RFC versions. It sounded too complex for people
to maintain a separate tmp file when make O=3Ddir would do it on a much
better and automated way.

-

With regards to the Python transition, since our Makefile allows
switching to a different script since ever[1], I'm playing with=20
the idea of sending a patch series with:

Patch 1:=20
  - drops Sphinx version check from both kerneldoc=20
    (-sphinx-version parameter) and the corresponding Sphinx extension;

patch 2:=20
  - renames kerneldoc to kerneldoc.pl
  - creates a symlink:
	kerneldoc.pl -> kerneldoc

patch 3:
  - adds kerneldoc.py:

patch 4:
  - add info messages on both versions related to the transition,
    and instructions about using KERNELDOC=3D<script> makefile and ask
    people to report eventual regressions with new script.

patch 5:
  - change kerneldoc symlink to point to kerneldoc.py

We can then keep both for maybe one Kernel cycle and see how it goes,
stop accepting patches to the Perl version, in favor of doing the needed
changes at the Python one.

If everything goes well, we can remove the venerable Perl version on the=20
upcoming merge window, and change the Sphinx extension to use the Python
classes directly instead of running an external executable code.

What do you think?

-

I'm in doubt if I should split the Kernel classes for the Python version
into a scripts/lib/kdoc directory on this series or doing such change
only after we drop the Perl version.

Keeping it on a single file helps to do more complex code adjustments=20
on a single place, specially if we end renaming/shifting stuff[2].

[1] I didn't remember about that - it is a very welcomed feature,
    probably thanks to Markus.

[2] the currently global const regex macros is something that I want
    to rename and place them inside a class (or on multiple classes).
    Also, Python coding style is to use uppercase for const. There is
    currently a Pylint disabled warning about that. So, I do plan to
    do such changes in the future to make it more compatible with
    Python coding style.

-

On a separate but related issue, perhaps we should start talking about
coding style. We don't have anything defined at the Kernel, and
different scripts follow different conventions (or most likely
don't follow any convention at all). We should probably think having=20
something defined in the future.

=46rom my side, I like Pylint warnings, except for the (IMHO) useless "Rxxx"
warnings that complains about too many/too few things. They have
been useful to detect hidden bugs at scripts, and it allows inlined
exceptions to the coding style.

autopep8 autoformatter is also nice (and, up to some point, black),
as it auto-corrects whitespace issues, but there's two things I don't=20
like on them:

1. its coding style on lines, creating function calls with open=20
   parenthesis:

	-    parser.add_argument("-n", "-nosymbol", "--nosymbol", action=3D'append=
',
	-                         help=3DNOSYMBOL_DESC)
	+    parser.add_argument(
	+        "-n", "-nosymbol", "--nosymbol", action=3D"append", help=3DNOSYMB=
OL_DESC
	+    )

2. whitespace removal on aligned consts:

	-    STATE_INLINE_NA     =3D 0 # not applicable ($state !=3D STATE_INLINE)
	-    STATE_INLINE_NAME   =3D 1 # looking for member name (@foo:)
	-    STATE_INLINE_TEXT   =3D 2 # looking for member documentation
	-    STATE_INLINE_END    =3D 3 # done
	-    STATE_INLINE_ERROR  =3D 4 # error - Comment without header was found.
	-                            # Spit a warning as it's not
	-                            # proper kernel-doc and ignore the rest.
	+    STATE_INLINE_NA =3D 0  # not applicable ($state !=3D STATE_INLINE)
	+    STATE_INLINE_NAME =3D 1  # looking for member name (@foo:)
	+    STATE_INLINE_TEXT =3D 2  # looking for member documentation=09
	+    STATE_INLINE_END =3D 3  # done
	+    STATE_INLINE_ERROR =3D 4  # error - Comment without header was found.

What I do here is from time to time manually run them and cherry-pick
only changes that sounds good to my personal taste.

It is probably a good idea to define a coding style and perhaps add
some config files (like a .pep8 file) to have a single coding style for
future code, letting scripts/checkpatch.pl to run pylint and/or some
other coding style tool(s).

Thanks,
Mauro

