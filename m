Return-Path: <linux-kernel+bounces-261052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5115993B233
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A441C2301B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6522156F2D;
	Wed, 24 Jul 2024 14:02:43 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD848613D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721829763; cv=none; b=Yt1SuBJGcwF28wxYdtNCJZ3W9LvTsKp9ohT+kAnBmk1ouZOjo8JfZFx1X8W5Bc6KrNwvpkXpnMA53RmgFsE9l+R9EeavuW7LdxbgRT5P7PmY/B2cESDqjF+SrjFd+ojkOR1uOVsKco/JGSUHWekeHbc7EjpsdRrtm3D0fLnLTa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721829763; c=relaxed/simple;
	bh=tsMhgZSuQDlz9vLOkDptUWQD/wemDXsgusjND8tmH98=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PdRBzXnQwA2qixiPq17qkUIwuOcjP75HXvb8wUxshacjYYGFd4dhFG11044d050QaNHc6Lo5d/NByRFKOVSZuHJB+4HYWLQnoOUfl2adlRLf+Ru+UvwtRvA87fqZxtDRWNFyAt3/O3bsPaXtR8UhZFXCz08GJ2/QxKg00My1tMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 2B00CA405F;
	Wed, 24 Jul 2024 14:02:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id B2F572000E;
	Wed, 24 Jul 2024 14:02:36 +0000 (UTC)
Message-ID: <45c339ffdf90019ce97a260d8126e3e3a1b3c1ae.camel@perches.com>
Subject: Re: get_maintainer.pl finds old email address not in MAINTAINERS
From: Joe Perches <joe@perches.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>
Date: Wed, 24 Jul 2024 07:02:35 -0700
In-Reply-To: <8021ff18-b277-4e6a-9a15-5e107ae5809e@molgen.mpg.de>
References: <20240724111524.25441-1-pmenzel@molgen.mpg.de>
	 <8021ff18-b277-4e6a-9a15-5e107ae5809e@molgen.mpg.de>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: B2F572000E
X-Rspamd-Server: rspamout01
X-Stat-Signature: mjfdg3o8ozeiys59wcud1oexmeg1m7ux
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18O9k05JGS5Lvj9etPRXc1ZFwZgf8KG48w=
X-HE-Tag: 1721829756-648651
X-HE-Meta: U2FsdGVkX1+CQBsjBbxGk+vX2Wzmn3WVKV6fq1JKBLv+ae4b1AjH4Iwq2iipXOXZYnw+J6o/6O0cHOahD78KhQVgO6RRufAbs8RwJ+PAS9gJC771vQbzODh6PKbfxShQYjvJsx0czthg+mmIfLYY1ERHTUjD4NxRi6piQtsPRLSEFRwua+nH9z2BpzBpF/ZQvSr3r8YA52nc8Bk9b7KA+E4jxbGp/aar0QSvnrD+lYkHw7tQ4B1gssCpQiY4J6cDQu2CutzYjYMmir0+2MByHcagxcs6IT0X+KHV6FYBUzKh5yE6TDJLFS/iwdqrxUb5vpuYOtEaouk7+EO7KAUKqH4K18YC3f2PywlwPjimcttb4+8a5t5MR6RLH8SBCWC1qiTfMgz/Vx1hPz1BSIzZqpOlJpN2G1mDSeZXrMWbQTEwE9l/uFeSy2OJB7cdHc13Fh0W343ldnkGLKBh0lyZ6D4LK5U33J8TK4wwShosGHMcsJzlBambQeSPysXfKGM5XACvmFjgVskR/jZvfa7672gkU4wFlVc7eo4LtVZdceSbYFBrYhCl0Ok/OYMnCP7XiE2JyvwzyClNJSJKyOpcY7Nsns2GaUYkn0LbDFUixJSrq2+e/HtBhqukH1Y4jXU4dS8n2zMYM02DqjuvaZfegSS+WPqkid0VOtdVIytL9CGJYb7tvduObx+EjMopIvsoQ3aOJZUczVpOdsVbfvmBizpWYgOgQ0fhJ5A5HxbZ9zA93TQqP125nXxVVZw86KTOYi8ycDaTeAWykagW19ImMw==

On Wed, 2024-07-24 at 15:25 +0200, Paul Menzel wrote:
> Dear Linux folks,
>=20
>=20
> I sent a patch [1] using
>=20
>      git send-email --identity=3Dlinux=20
> 0001-USB-core-hub_port_reset-Remove-extra-40-ms-reset-rec.patch
>=20
> with the git configuration below.
>=20
>      [sendemail.linux]
>      	tocmd =3D"`pwd`/scripts/get_maintainer.pl --nogit --nogit-fallback=
=20
> --norolestats --nol"
>       	cccmd =3D"`pwd`/scripts/get_maintainer.pl --nogit --nogit-fallback=
=20
> --norolestats --nom"
>=20
> That resulted in Gregs old SUSE address getting added:
>=20
>      $ git describe origin
>      v6.10-12246-g786c8248dbd3
>      $ scripts/get_maintainer.pl --nogit --nogit-fallback --norolestats=
=20
> --nom 0001-USB-core-hub_port_reset-Remove-extra-40-ms-reset-rec.patch
>      Greg Kroah-Hartman <gregkh@suse.de>
>      David Brownell <david-b@pacbell.net>
>      linux-usb@vger.kernel.org
>      linux-kernel@vger.kernel.org
>=20
> I am wondering where that address is coming from, and if I should change=
=20
> my git configuration?

It's coming from the commit of the Fixes: line

Fixes: b789696af8b4 ("[PATCH] USB: relax usbcore reset timings")

And that commit has those email addresses.

I suppose it could be argued that the existing .mailmap entry
should somehow fix this but without changing .mailmap entries
with just a single email address like this:

diff --git a/.mailmap b/.mailmap
index 8284692f9610..1d2062d479b9 100644
--- a/.mailmap
+++ b/.mailmap
@@ -204,7 +204,7 @@ Gerald Schaefer <gerald.schaefer@linux.ibm.com> <gerald=
sc@de.ibm.com>
 Gerald Schaefer <gerald.schaefer@linux.ibm.com> <gerald.schaefer@de.ibm.co=
m>
 Gerald Schaefer <gerald.schaefer@linux.ibm.com> <geraldsc@linux.vnet.ibm.c=
om>
 Greg Kroah-Hartman <greg@echidna.(none)>
-Greg Kroah-Hartman <gregkh@suse.de>
+Greg Kroah-Hartman <gregkh@linuxfoundation.org> <gregkh@suse.de>
 Greg Kroah-Hartman <greg@kroah.com>
 Greg Kurz <groug@kaod.org> <gkurz@linux.vnet.ibm.com>
 Gregory CLEMENT <gregory.clement@bootlin.com> <gregory.clement@free-electr=
ons.com>

There's no trivial way to do that.

If these single line entries in .mailmap are modified,
get_maintainer works fine.

Here's the Fixes: commit:

---
commit b789696af8b4102b7cc26dec30c2c51ce51ee18b
Author: David Brownell <david-b@pacbell.net>
Date:   Wed Aug 31 10:41:44 2005 -0700

    [PATCH] USB: relax usbcore reset timings
   =20
    This appears to help some folk, please merge.
    This patch relaxes reset timings.  There are some reports that it
    helps make enumeration work better on some high speed devices.
   =20
    Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


