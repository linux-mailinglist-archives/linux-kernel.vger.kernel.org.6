Return-Path: <linux-kernel+bounces-394031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B0F9BA94E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 23:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C701284700
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 22:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE4E1925BC;
	Sun,  3 Nov 2024 22:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQObOFZD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D6A18E362;
	Sun,  3 Nov 2024 22:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730673576; cv=none; b=awBQKhJp0QeM7hWFUzHsdT5v5ZaUMMdXQR1ApYTDTH7G8GjYE7yXUkB/0t4nwzwZHRaVywfmSoh7JYbFFMkcQsiyzhqITv6RCNQEoWe5NsM+sRIPff8pY0IvhvuseTCY1/FJ4jX9BmOxInTe/qREf9AANo6FAlo5bs63VyNkluI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730673576; c=relaxed/simple;
	bh=+qhLc1G4rNUi4bFLbKvd5gDlE9sbzH/J3t70HMKGgCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbM2MRLKsj3OWouWPCuSCPScYZaoPTz4xaB1EiVc0VMI19uIX3SuB1dDDfivDYDvYM9qM6Ot+ibXqiyGYDxLbjDc+p7AXwOQJlTUI+mrqtIu+7Cy/egLBoo2LKKRK01HGVQ5GnYVVT6zeb6IDNW0GG3dLSpLmeMJPerjaG0rRL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQObOFZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7519FC4CECD;
	Sun,  3 Nov 2024 22:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730673575;
	bh=+qhLc1G4rNUi4bFLbKvd5gDlE9sbzH/J3t70HMKGgCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jQObOFZDB24shsOSulmZNUVSDuOIzo3QPiv26V7GzTiT9FpWnlHBMvfkSakK5Lncp
	 uMLJ3fObqHZkzDzDPhgCX2qOY52PoeDM15Kn26mwaThipiUFh1TqDE2/dgDx/JPkku
	 SDyJbCP7IQ33ySlS8o2gfxUbX2yzwN+3+xYZ6RBjOF5LKNF9GvKg90DFUm/pv8A6nO
	 dEh/4FzOtI7RF/oJTM/7zulRY43SRfNTbXhk1GI8yAXeHDL0kQLyz/mugvYypZDg6a
	 rU4de6x/ATrJgw+iVy+UPMUkLdDWqLAR3AfjZV48eYT/Y7/FuECx3JFs5D9GrT0gks
	 bMt8BxNG5ycrA==
Date: Sun, 3 Nov 2024 22:39:31 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Wenliang <wenliang202407@163.com>, linux@roeck-us.net,
	book <book@100ask.localdomain>, jdelvare@suse.com,
	linux-hwmon@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH linux dev-6.11 v3 2/2] dt-bindings: Add SY24655 to ina2xx
 devicetree bindings
Message-ID: <20241103-saloon-footsie-42dea85a903b@spud>
References: <706d4821-2637-4aac-869b-822f69aebbfa@roeck-us.net>
 <20241103163908.11890-1-wenliang202407@163.com>
 <20241103163908.11890-2-wenliang202407@163.com>
 <f5188173-21c4-4921-b7c8-5685c661a157@kernel.org>
 <b2d1e4cf-b068-4bab-9735-d9d4ff449a09@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b6k0oz1SEsaxnq7+"
Content-Disposition: inline
In-Reply-To: <b2d1e4cf-b068-4bab-9735-d9d4ff449a09@kernel.org>


--b6k0oz1SEsaxnq7+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 03, 2024 at 05:52:59PM +0100, Krzysztof Kozlowski wrote:
> On 03/11/2024 17:46, Krzysztof Kozlowski wrote:
> > On 03/11/2024 17:39, Wenliang wrote:
> >> From: book <book@100ask.localdomain>
> >>
> >> SY24655 is similar to INA226. Its supply voltage and pin definitions
> >> are therefore the same. Compared to INA226, SY24655 has two additional
> >> registers for configuring and calculating average power.
> >>
> >> Signed-off-by: book <book@100ask.localdomain>
> >> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > NAK, this never happened. If you think otherwise: provide proof, please.
>=20
> Hm, now I found previous v3, so ack happened, but patch still has
> incorrect author.

I didn't ack it with this weird authorship, so that needs to be fixed
before the ack can be applied.

>=20
> Please really carefully read submitting patches document, especially
> parts about sending new versions, changelogs, subjects.
>=20
>=20
> >=20
> > Nothing improved in this binding, actually it got even worse with fake
> > email and probably name as well.
>=20
>=20
> Best regards,
> Krzysztof
>=20

--b6k0oz1SEsaxnq7+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZyf7owAKCRB4tDGHoIJi
0mfZAPoCVDytX32TrpA+lgJRh6wruOU5EfeYW7ZXLqDql6wtnAEApJ2bJWQgQQ4p
Wz5J9KFfLM7geFQ0rEXLOeIgmgWlYww=
=Qtw8
-----END PGP SIGNATURE-----

--b6k0oz1SEsaxnq7+--

