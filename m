Return-Path: <linux-kernel+bounces-443224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ECA9EE903
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83BF518824A2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE9E2153DC;
	Thu, 12 Dec 2024 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2I9jocp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5A92135B0
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 14:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014195; cv=none; b=rmFebTl28K+SxzWapnL7Obyoer3h8TEUxljtdnnHCouv0383ltZ5YkOQeTR+Xdua6OUbOKIbSRBR+8u6D4WBjPBwpnyCTrTW5aLZx/9iDsKXWh2ISZ8Gd0UUUPWWKUzWoKn1lqnuMNQd7NWLaKmoQ4iOLKfdfdV3O5ASGZ5Dqpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014195; c=relaxed/simple;
	bh=lPZsd2+fzAxChrISsnJUd2UyGwc2PqpGPHIgQYSNfrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGFF98CaPzMSVtDEp1ISsHjnZmrdP9TOU+P4I4ZAa3AufuSSKI8atNP4KBV0ZS+MFMgo1tRIK/ufLgKaMVYGapaSp1jsmAhtcz55ZRpugoIIqQ9gCXxyU64CpOqs2yjZUfNutzbjKeGW1DZJf91eDg9sYJmyfzIo7wkRRvDQNlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2I9jocp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F452C4CECE;
	Thu, 12 Dec 2024 14:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734014195;
	bh=lPZsd2+fzAxChrISsnJUd2UyGwc2PqpGPHIgQYSNfrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a2I9jocp3qCvfgOTyx39d9kkJFJsQ6KbnZmbBUb+P1M/jhhlvlXMsD5BjWc1SzClt
	 GEHllj/mg0JvS09JiWaB/H71B9dy6KiG+jtMUyckY1M17ma20Z1ke9fnTvxQ8das4S
	 Ykjiwu2ZZojsW9nhMDDQQYxPLobBRiuTX8yBjeDVg610O4uJjcoVLF/4i8+jEE55Lj
	 DUqxUyq/OpmU/kSesfeuAVDdVSawavr9uivGkyxwFk8MZph4mPUP0CganNB/ECM/TT
	 MDtil2PkhVQ/3iO72fwp7PLzzQ2FTOYSPg53UTkxg1cH5+sdYJ15SY/Piy9HW4iKFZ
	 bLgWgCce7kQxw==
Date: Thu, 12 Dec 2024 14:36:31 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/1] regmap: Synchronize cache for the page selector
Message-ID: <e63e5f55-576b-4371-982d-d835f301312d@sirena.org.uk>
References: <20241122140357.1337686-1-andriy.shevchenko@linux.intel.com>
 <Z1rzHvJDgPdlfEBK@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BwwMIjKvPpp80Wzx"
Content-Disposition: inline
In-Reply-To: <Z1rzHvJDgPdlfEBK@smile.fi.intel.com>
X-Cookie: All is fear in love and war.


--BwwMIjKvPpp80Wzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 04:28:46PM +0200, Andy Shevchenko wrote:

> Anything should I do to move this fix forward?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--BwwMIjKvPpp80Wzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmda9O4ACgkQJNaLcl1U
h9BtQAf/aHgJv22u108+DQHuxFcgB2OB/cUjJnuT5k1yGWpFOWa9FDFZUqGyMRrw
eGsj3by1r4pon28NRi0KAUNd4JsstuUjH2gs0txcXu68ZixnkpIN/wbz1l8JP+b2
GsUSd0voI8rWFmbcdRViJ7VeY0VscFL9omSC3oxWoBjZgs1eQtcnibNltDUcs4Ry
TXboijHXxmqmHQMJOPIQtF6lzJ3l2fSe+OoCjG7Wxq8OyQwYHLk1mJzlrtxtf3PD
DjL3OmOF4gicfbViC13aJHeBo028fkLrm/BcWcmPTk5YI0jTcXspgqTIp6JVaJ9n
vIP1oW8hjyzRjGs5mc9QnaETwcppGw==
=ZUKh
-----END PGP SIGNATURE-----

--BwwMIjKvPpp80Wzx--

