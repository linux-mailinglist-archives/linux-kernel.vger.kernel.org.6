Return-Path: <linux-kernel+bounces-429552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 889509E1DA8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48E8E281476
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8DA1EF0AA;
	Tue,  3 Dec 2024 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sx6zWmOX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28709192D98;
	Tue,  3 Dec 2024 13:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733232945; cv=none; b=SBDXMi7EY2TFLfTBbQWnBeZ7S2cDYhQPOWZ/y56GVbOTM52zDM+xhrk1yTrrZeznXoAREEPOtKhbx0Ge4CrpSqjs8I33BZ3fz/TJsuc6g13/n+st30Z0Q/kL632uPRf7M13sD24fE1cmCFlJSInj9jUUy1VCV+3FZRDjeAP/yF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733232945; c=relaxed/simple;
	bh=dXDrDtN5XaSL7lVIDYJ3Rm5FRszCej7xDYfP7QV04Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWpyOU0qB2oqJOZ/j+v20fWpryWt0nuf16K69F/MRQ65AmJwCJMMaupbeynn+bMT3bWuVak7+Sp8wntEkm0G4dbkhCaOmfm2Q/0JZE5lHs746K/6sqreOJhoSFXzsaZ1RjhWmznAOA73uw4c+X3+9varnw0N1O0w4KoJQrOYM9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sx6zWmOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01ACC4CED6;
	Tue,  3 Dec 2024 13:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733232944;
	bh=dXDrDtN5XaSL7lVIDYJ3Rm5FRszCej7xDYfP7QV04Kk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sx6zWmOXljO2J9kWAcinw+IGcbZxfufoFfJTCWxkOFBTR6zoKNakrtAEn1gUWoAY6
	 eGNh/pfgYqPnAg1VQB06Fez4JQRSVS/l2yktXAm2HQxXRLrCiq2GJPDKRdNPhHIURf
	 /8Tt6zmdvMt/UkMF05P/hZcjhoHvYqse2UYZoITIC/qck7QLnvqlhm3y3yf011e2Fm
	 4fnt0aDjOuNh+xxQEAYG21guoBtOzxzANrIa6gFjVIkkwx/ZOXjTTF6fwPfQ5pGj7+
	 CGh7IovTGTFkG1riVvgXngh1NBWrDeNq678k7CiKymIC9qdQ+sFDdPRZFQZbzHp7Ud
	 33mEQz+gM97HQ==
Date: Tue, 3 Dec 2024 13:35:40 +0000
From: Mark Brown <broonie@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Nov 28
Message-ID: <ad4c0bbb-51df-4a5d-8c7a-e5dceb290bf9@sirena.org.uk>
References: <20241128133214.6a39d091@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c7fF2wfXWEDgUDBF"
Content-Disposition: inline
In-Reply-To: <20241128133214.6a39d091@canb.auug.org.au>
X-Cookie: Alimony is the high cost of leaving.


--c7fF2wfXWEDgUDBF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 01:32:14PM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> News: There will be no linux-next releases tomorrow or next week.

I didn't notice this until this morning.  I've got a build running for
today, if there isn't a -next today there should hopefully be ones for
the rest of the week.

--c7fF2wfXWEDgUDBF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdPCSwACgkQJNaLcl1U
h9D/Rwf+JBR2g1t7r1z/EZK6AWJJRVYZuYXlwqOpSfV8q/G1Kl6YFnMTrJxDVg0a
YzvZ7TnBS+HL8g07HnXCCicFdWWoCLf4o7GpKCtxG4G5n4QEzz6QyJxFcsSiLGX8
oiq4KYpKdRL5IvrZ3v5xB/WVeBH/6FlbVbKFvoV5BZV5Ip1M6F6aQd/GZPXFZ7LG
EkWIPoRIhYceEJtXNiSb9brJ9DCUhf7mKEotU7I2L8CDteqwGhXYaLWWKrERWlMg
y2GgPcZ9ege+Reuisax1bdKpk729LOZ5WLhhjb4rdHdHN05NPuXaxaiRXPlSlmIs
KECVwqXMW0eGJ1Vg7DgqYetQ0iZpUg==
=vP70
-----END PGP SIGNATURE-----

--c7fF2wfXWEDgUDBF--

