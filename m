Return-Path: <linux-kernel+bounces-429066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E52A9E16E9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4781626D1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2906B1DE3C9;
	Tue,  3 Dec 2024 09:12:55 +0000 (UTC)
Received: from algol.kleine-koenig.org (algol.kleine-koenig.org [162.55.41.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA841D6182
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.41.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217174; cv=none; b=U/nvYsP5G70WMCARtujoD8BaJ2osDgK/xp1cRA5p4lr39jfJvScx+W65SVk/gjfTurVK8MkloiWhzjYQw1tUeVaCIH6LrOYurmfj+yd5pf+UITNqR5Hf/qAAFzeOv50V0xZwWNIlDCCQ0J6oqEaf5xO/CXsqjyrLzWJxn/qD6Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217174; c=relaxed/simple;
	bh=BV+DQ/pQGTWOZispPAmcPMhvRmv2qR2EzOAmYvw4kpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jc1WjME5RkTMl6lyt32BnM17P9PQj2QnE8xv6rysYNP0JTRXMQDRj0oNi7E0Ysk4XMs/VxVIsSzJ6EkxT4LC5TSxRBRkNS+tbCJsOy7q4tg05SRMDk/Z2uF0yP9pILLPeY0Qwxh5oErmD33MHCg0pdJsbBzP6g/1GPohslFS0W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=kleine-koenig.org; arc=none smtp.client-ip=162.55.41.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kleine-koenig.org
Received: by algol.kleine-koenig.org (Postfix, from userid 1000)
	id EE75EF459C3; Tue,  3 Dec 2024 10:06:52 +0100 (CET)
Date: Tue, 3 Dec 2024 10:06:52 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: Rodolfo Giometti <giometti@enneenne.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Ma Ke <make24@iscas.ac.cn>, 
	Andrew Morton <akpm@linux-foundation.org>, George Spelvin <linux@horizon.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] pps: use scoped_guard for pps_idr_lock
Message-ID: <g7ki6aitsqk4x3o4r7ghodtdxp3kn54vbtvzpmuuk7snshtapj@vlnc57arefyn>
References: <20241202163451.1442566-1-mschmidt@redhat.com>
 <20241202163451.1442566-4-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="scaijus7axwnx4tu"
Content-Disposition: inline
In-Reply-To: <20241202163451.1442566-4-mschmidt@redhat.com>


--scaijus7axwnx4tu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/6] pps: use scoped_guard for pps_idr_lock
MIME-Version: 1.0

Hello,

On Mon, Dec 02, 2024 at 05:34:48PM +0100, Michal Schmidt wrote:
> Use the scoped_guard syntax to be more brief.
>=20
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>

This patch undoes most of patch 2. I'd squash these together.

Best regards
Uwe

--scaijus7axwnx4tu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdOyioACgkQj4D7WH0S
/k6ITQf9F7NYO2IAp/lsrWdtva7+cqVUTN8XOi8ttpOptsSq6L0msSkk3RINHWYu
hHrbn+SZ/Za6P/oBpNknx7RYpveXVanJa2QZVYO1GSTNcMn1nViSXyqly4gcMNJ/
FdBD7mTC6ychzf5hW2qaddq2j5ZgFC9J7Uy19MuveJEA9ygzwvkfa6tVami5KlaD
n+7k4dbce2Vg82kDcgOHp2EftLI99POfArDliEkBqc4F9Qj6eA7YSpUym1l9u+ZA
LXA0SuM7mYzR43A8WA/m9OJE7yP8dinxWB1QjUDnvyIJGMGShVVg/Rx0q/+XdQF4
qBlB8g6gnVU2P+iJBzCjzegzRrOpoA==
=TkEO
-----END PGP SIGNATURE-----

--scaijus7axwnx4tu--

