Return-Path: <linux-kernel+bounces-550815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF32A56476
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD061897227
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B4C20C48C;
	Fri,  7 Mar 2025 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSfOBFKl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0FA20C47E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341552; cv=none; b=migQLOpyETM6f0zLTXeuYlyRakxcw3Bl3N/X27kTkv0f/DYWng7Na5BNCU5pPKmBDxslTGWnTXHbgathXXGc4ZpMg2DKuqi0fqCyppemZhxFQi2L1B+cZNDNI8YP0yGabYo3n07qHZxar3yJwN6849ccyHvzbcXKSeMV6h2MG9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341552; c=relaxed/simple;
	bh=EkRBKBECXHAhX3EBNWnlfL6BlhPB8bTEBVpL3643OmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFGMPqnE5JwIhlwtKjG/UIapz4hXJWEYo57c4dzOs0srY73eZ+tPUt8UZ+qv3hRL30UBwEzXMKdOML5t3QX9YdHgSuW+U7GN7n9K3znJ2E+BscPiZuMAzKGVKBzEhsPBWcI/yfe1jyneuahxZpn7a9DHva09MewZ1h5VwVZPS4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSfOBFKl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568E9C4CED1;
	Fri,  7 Mar 2025 09:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741341551;
	bh=EkRBKBECXHAhX3EBNWnlfL6BlhPB8bTEBVpL3643OmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PSfOBFKlybeJAIMXUXMaGIaLOIZMp6R2VxP335RmZYRwv2T85l98foYuf99qJk+VT
	 oXPs0mJdiQYUqR62/1dWriXdrgWShcWBVbO8YIafBUnMaZsnOpsGoc4vEMFaLZayYu
	 c/+4fyiI4dEA0hOfHITIbFetgqrFHQiht7X+ECbIrPoeSmjdeRUJTvZlEPfh6nKNbb
	 lC93HGW1JhhtyBrM6KYQ9ec5NIsZyA9XHj4oqx2xinJe7ObAstBQbBGryyIlf1gfwc
	 a/rcJhhB4olOuXVrx97y2vasZ9smp/ossWPK6YDzYWs9fThayCypjI3ToEFOCUZO/e
	 Cvie2EWCRVYDw==
Date: Fri, 7 Mar 2025 10:59:08 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>, 
	hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/14] drm/vkms: Allow to configure device
Message-ID: <20250307-cyber-rooster-of-democracy-4f072c@houat>
References: <20250218101214.5790-1-jose.exposito89@gmail.com>
 <36c37aae-244f-48f8-8f88-c46b58a9e8b1@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yh2yaizjyak5cyxz"
Content-Disposition: inline
In-Reply-To: <36c37aae-244f-48f8-8f88-c46b58a9e8b1@bootlin.com>


--yh2yaizjyak5cyxz
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 00/14] drm/vkms: Allow to configure device
MIME-Version: 1.0

On Tue, Mar 04, 2025 at 10:43:12AM +0100, Louis Chauvet wrote:
>=20
>=20
> Le 18/02/2025 =E0 11:12, Jos=E9 Exp=F3sito a =E9crit=A0:
> > Hi everyone,
> >=20
> > In preparation for ConfigFS support, a flexible way to configure VKMS d=
evice(s)
> > is required.
> > This series adds the required APIs to create a configuration, the code =
changes
> > required to apply it and KUnit test validating the changes.
> >=20
> > Louis Chauvet and I are working on ConfigFS support. In this series I t=
ried to
> > merge his changes [1] with mine [2].
> > I kept his Signed-off-by to reflect that, even if I show up as the auth=
or of
> > some/most of the patches, this was a joint effort.
> >=20
> > I'll send the ConfigFS code [3] and its IGT tests [4] code this week.
> > Meanwhile, the IGT tests also exercise this series and can be used for
> > additional test coverage.
> >=20
> > Best wishes,
> > Jos=E9 Exp=F3sito
>=20
> Hi all,
>=20
> I am trying to apply this series but I am encountering some issues. Most =
of
> the patches have the following trailers:
>=20
> Co-developed-by: Louis Chauvet
> Signed-off-by: Louis Chauvet
> Signed-off-by: Jos=E9 Exposito
>=20
> When I use dim b4-shazam, the result is:
>=20
> Co-developed-by: Louis Chauvet
> Signed-off-by: Jos=E9 Exposito
> Signed-off-by: Louis Chauvet
>=20
> However, checkpatch is not happy with this because it removes my
> Signed-off-by line immediately after Co-developed-by.
>=20
> I then tried to add it myself:
>=20
> Co-developed-by: Louis Chauvet
> Signed-off-by: Louis Chauvet
> Signed-off-by: Jos=E9 Exposito
> Signed-off-by: Louis Chauvet
>=20
> But this time, checkpatch complains that I have my Signed-off-by line twi=
ce.
>=20
> And if I don't add the last Signed-off-by, checkpatch is indeed not happy
> too:
>=20
> Co-developed-by: Louis Chauvet
> Signed-off-by: Louis Chauvet
> Signed-off-by: Jos=E9 Exposito
>=20
> How should I proceed in this situation? Should I ignore some warnings? If
> so, what are the expected trailers?

I assume Jose is the author and you're the committer? If so, I guess I'd
expect the second to be the most relevant, but it's going to suck
anyway.

I kind of side-stepped the problem and applied the series

Maxime

--yh2yaizjyak5cyxz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZ8rDbAAKCRDj7w1vZxhR
xRZ4AP4ge2eRLQPRRsVuW27iWtiZJmRFuccllGYc6hclk0qJMAEArkiqKbv0LXNh
pQ58jzkqXxd6orr5kUflvYQyRv+uogc=
=GH1m
-----END PGP SIGNATURE-----

--yh2yaizjyak5cyxz--

