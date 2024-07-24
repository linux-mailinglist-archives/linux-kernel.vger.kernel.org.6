Return-Path: <linux-kernel+bounces-260793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E1593AE4B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 11:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241931F24409
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBECE13F01A;
	Wed, 24 Jul 2024 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVY/hTrG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAF214C58A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 09:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721812117; cv=none; b=Jsei0U8fy26TJSrvDvgIm5BzFNmmupjBUlvqnP0vLeUth+Jb+5SYrU0K7W6JxcWrLBPJhMbc8q0JxzL3az8Il3WEetv0FgT2Zr9RzW7I/lRRfP5lxYxQBnH23byoPl9e5+Vg43VaSj9dnzW+ziaJFpE8oJlWCTbfHgdW47dcWgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721812117; c=relaxed/simple;
	bh=tXADsbqP+GX9WbYS60bhZVA5ZZZ6duTf+CbQcMcBcFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIhDHzzZXgHs9xSL4ZkO+LNOd9atcFKegBJv4Xe3ZtNDefWG8n7q+CDEKL11eQ+sdFAuSgk665pozcmT5K7hWzPiwnsw29QKBrgbMLWqrCwEgajYzpqtlt1cMlw8tJc7V3EbntSFWwLo3Kz4n9ywfW/WT1hFqGaCsjOp3ZDZbTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVY/hTrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24620C32782;
	Wed, 24 Jul 2024 09:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721812116;
	bh=tXADsbqP+GX9WbYS60bhZVA5ZZZ6duTf+CbQcMcBcFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lVY/hTrGCssOLtbafZdS91kP7E+QilT/safXFRqMmf4ta0ywePrKg03RN94F9T2GQ
	 /Iok19jBegidJZd9H8OtigTOeRTyP9OlalRgiN56Xc7rwE7Dye6iGpIf55mBh/g3RP
	 nVufbnEo9KNR6FpP06JpQCFFP9wF3bMJGyHFDPgISEJPKTW+IPN8cAseUpeZ7jCw1A
	 M++VWN5WRKkB5qI2DD9GMr+HrZw4bKbZJq23G1OZvaVNVzrpRkHCicDgwm5yQ+8rbG
	 GyEzGVbwG9KRnGd13+sZU4VlnvhDY0ymA7UjoWz+4730r64h5+XGo7jbMzE45gjfUk
	 qH8jUZp3SS9+Q==
Date: Wed, 24 Jul 2024 14:38:32 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL]: Generic phy updates for v6.11
Message-ID: <ZqDEkJNq30u3jOAB@matsya>
References: <ZqCxra3XNXK7WbOb@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2EdhKq06JG1F5bQ/"
Content-Disposition: inline
In-Reply-To: <ZqCxra3XNXK7WbOb@matsya>


--2EdhKq06JG1F5bQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24-07-24, 13:18, Vinod Koul wrote:
> Hello again,
>=20
> Second request for generic phy subsystem feature bunch of new driver and
> device support and updates to few of the drivers
>=20
> The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfab=
d0:
>=20
>   Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/ph=
y-for-6.11

And I missed to update that please expect conflict with MAINTAINERS and
exynos-regs-pmu.h, I think both of these are trivial one for you. The
resolution is in -next tree as well

Thanks
--=20
~Vinod

--2EdhKq06JG1F5bQ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmagxI8ACgkQfBQHDyUj
g0cr/A//V4Auho1li0wm4Gx4i+iCPmtxTGcbKvhCcp9vjrz6DKBiRzl16fZPWlwz
nCA2PlADczhZ4oU3wS7cevv6Vq9YVzu741GQCNW+tUxbepqtIFKAj9tTfbnOxreV
UI/ntN9F0YE7kvaIc0PmxjVE7swBLbGNn1W26Nsm5L9vtREdfpXrFUphU4f40JgI
RKs96hXgeSoT3oKPGFWdsCLkPUh+imBw2FoZqID4TzPOpaWm7pWdIqR8KJ8zHZLX
dX62zrrrKDkTzx+1gaT3dXJ4uLhN3JWDu9j+9RT0PQ7UrRUQs9nLQjVNYPbthrf4
Zg5I6lGUCSzNjEh6uYcHU1phtxeIJ426d9K6bPMU5goydwo+LrzUBBE3rmhtPzst
rzmVFFWyVdQGonrkUU6VDCsTswPe2pDXrR6tGMysdFjVk5/j4SwODxnjJHYLG1wt
X966cBO25QdJSemmx4Ciny5uFgYdcOBHZgbArSxKTvb/P8JtWBALQGkLf4abI8Sx
2ZNPy4IQU22O5cA1l2OVpJM0jzUnbSHQeseAgLNWsp/Wv/5+DSJJA9TP0mS3yG9N
a1e76blniSCfee8BeqXEHUGfiaB60OZhZvxmQ7pFWNC5k4meEC0MPJEmpqU0u5D5
G7zXabvz/P0KqQANOeqOJzgEgEhjGD9ZTeUWtPYeSqxm1m48HLs=
=uaY+
-----END PGP SIGNATURE-----

--2EdhKq06JG1F5bQ/--

