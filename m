Return-Path: <linux-kernel+bounces-213075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 370C5906AC1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF351C22902
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828D7142E84;
	Thu, 13 Jun 2024 11:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="kUH58Svf"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6AB13F44A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718276970; cv=none; b=fKGt2PEkFXMb520gTK8VF7cnZaFM6XPrbcvkFc52hLSmSkpfTtuF7umUEo+T+zygQr/MnmTxe1neqLHVoDpkBgcDpE3LMKvbFNYPoEOd73DQ7pUJ45nygIyK03UEF3ziSUGhJ0rusurTcBfdg1Rtbnjhsn10AI3L9Ym0mBf2s+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718276970; c=relaxed/simple;
	bh=/PwzYX+uk2Nedr1YIpzY/gURwWc4Gy3T1zJsTwNg4Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OG5up7Ju3f7b10X5hlZ3ehesbVfApK8r6W1eiBp3hQhMexR6vtuYE68CWxDmMlYs//EAAM8gRPm7DKc0TWmc3bKZVRoQEVC/SCdsvwnExYEtH7trtjSKQWrgjXMod3yG7eCIWPYq68kbhRKGKEarIrZx0dID6gghx4mPM/7b+ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=kUH58Svf; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D224C1C0082; Thu, 13 Jun 2024 13:09:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1718276966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MMBoc650EfPUZlWI2B7dwWY/pFS1sUXi2F5Pa+I/glc=;
	b=kUH58SvfvV0SrS8SJJxc+YpCD9Pp3HGc/VKJPR9tBlQUN77maLsMDfcruVbx/mz6z2TgUc
	VtosaKOu2o8hYOOyroI6rbN6AKptMKqUZXw5VNeAcJCs9y+5NJk8cZ5hWwLehQ08re8fTF
	8uwBirw5o1sPHmS9vjTUMLSJUrJVeqY=
Date: Thu, 13 Jun 2024 13:09:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.10-rc1
Message-ID: <ZmrTZozoi0t/tuva@duo.ucw.cz>
References: <CAHk-=wjQv_CSPzhjOMoOjGO3FmuHe5hzm6Ds69zZSFPa4PeuCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SfBYjrROnx1aIQcB"
Content-Disposition: inline
In-Reply-To: <CAHk-=wjQv_CSPzhjOMoOjGO3FmuHe5hzm6Ds69zZSFPa4PeuCA@mail.gmail.com>


--SfBYjrROnx1aIQcB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Ok, the merge window is over, and 6.10-rc1 is tagged and pushed out.
>=20
> This seems to be a regular-sized release, maybe even slightly on the
> smaller side. All the stats look fairly normal, but "normal" obviously
> means "much too big to post the shortlog", so below is - as always -
> just my "merge log" that gives an overview of who I've merged from
> with just the barest of descriptions.
>=20
> We don't have any new filesystems, and the xfs online repair work
> means that the bcachefs fixes aren't even the biggest filesystem
> change any more. But all of that is dwarfed by all the usual driver
> updates (and, as is tradition, GPU drivers are in a massive lead, with
> networking a distant second and everything else is relatively small).
>=20
> But we do have all the usual architecture updates, core cleanups and
> fixes, tooling and documentation updates.
>=20
> Please - let the testing commence,

I tried ~6.10-rc1 for a week or so, and it something was very wrong with
the performance, likely to do with graphics. Thinkpad X220.

It looked like GPU is working way harder than usual, leading to
machine overheating and thermal throttling, making machine _really_
unusable.

I went back to 6.9, and things seem better. At least "have to buy new
machine" feeling is gone.

Unfortunately, these GPU perfromance issues are not exactly to
confirm/debug. Hints would be welcome.

Best								Pvel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--SfBYjrROnx1aIQcB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZmrTZgAKCRAw5/Bqldv6
8v6fAJ4hWPvVitw11YE7vnK2jz8J4NGQfQCgqcBOPW7/dVGbX8fKGHdQ2Q03FqQ=
=Wm0q
-----END PGP SIGNATURE-----

--SfBYjrROnx1aIQcB--

