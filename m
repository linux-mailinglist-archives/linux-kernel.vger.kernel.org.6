Return-Path: <linux-kernel+bounces-180090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D978C69FA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28261F235A5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC5E156241;
	Wed, 15 May 2024 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTsLC8ka"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D096156222;
	Wed, 15 May 2024 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715788116; cv=none; b=JE69J6z24KDNajo+Q0pmbHrySLFgBmq4wyFi0QD87KfYfTerdDAQKpXZuD93mttwoskPbeOUwNCmkNSTtZO1GhhxCgv+UUAwvJPJkzFraPjreesgQ3VIov9rEjbrE/6edD58JDf6NZB96o+CcL6DVX1rIUfmhDJaHBDWf+w6wBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715788116; c=relaxed/simple;
	bh=OCBUT1Jcs2k9WvSRYjd+XNw0GqtEDdjfXX7VG6tH8do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSoDW0GjMKhQNrbvNs7StFGcwSYadDIge19T7fLU06ozZASVtJJVbGwxJ12G1agASWTC5pR+k29siys5G9gQRwbJfIFmfX/LnvLF9oIXT5MyrIjMZxTYjcE5GOnUrzIFQ9X+OSkMnL5jQN553ER5al/quenVG2Q3YtWqF+ZgPPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTsLC8ka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443B4C116B1;
	Wed, 15 May 2024 15:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715788116;
	bh=OCBUT1Jcs2k9WvSRYjd+XNw0GqtEDdjfXX7VG6tH8do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iTsLC8kalFElr7ib9J7KpeczH7H6X7GuALWbsfy10aE0nZO35/N6v9VRXb+oYDctn
	 wCN3JNekIynZIaen4jIYtj5Oi5y6RrnhCmbplkQxGBZqRJ+BN9mzX19XGKkKwr0YAA
	 48gAzL+J3LvhOM82FGrhihtvYf9UX3jzwlOp7d7Lu4Iv+rj9ubQy+YtwZwjdQqVi82
	 eBRoG+IzvpYhHN6r/tPj34koz6ppMId8DV1K/2ExaXuOGd6DuHvbvMZoC460SPaGMQ
	 tVkRTAld/JNny2e66XCnGYmqoYD2VGlGNyX7pigv5VuhgyziX2ULxhMyqAGCNSMaTS
	 AsXbftLRJ+UNg==
Date: Wed, 15 May 2024 16:48:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Alina Yu <alina_yu@richtek.com>, lgirdwood@gmail.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, johnny_lai@richtek.com,
	cy_huang@richtek.com
Subject: Re: [PATCH v3 6/6] regulator: dt-bindings: rtq2208: Add property to
 get ldo of RTQ2208 is adjustable or not
Message-ID: <20240515-rubdown-waffle-b0d59302d436@spud>
References: <cover.1715340537.git.alina_yu@richtek.com>
 <6a3a90d9aa2022dfb92e124e417f3e72c2f28b0b.1715340537.git.alina_yu@richtek.com>
 <20240513-tissue-repave-13d2e3bf88fd@spud>
 <d97752ed-4032-4681-b28f-17f149fdc3d4@sirena.org.uk>
 <20240514-plunging-chair-803d9e342e6f@spud>
 <90d5efcc-e85a-4daa-81cb-a877c4b8fff6@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vZAWaGjY/4yR8mA2"
Content-Disposition: inline
In-Reply-To: <90d5efcc-e85a-4daa-81cb-a877c4b8fff6@sirena.org.uk>


--vZAWaGjY/4yR8mA2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 01:10:31PM +0100, Mark Brown wrote:
> On Tue, May 14, 2024 at 07:01:21PM +0100, Conor Dooley wrote:
>=20
> > It also doesn't seem like this sort of behaviour would be limited to
> > Richtek either, should this actually be a common property in
> > regulator.yaml w/o the vendor prefix?
>=20
> It's a pretty weird thing for hardware to do - usually if the regulator
> is controllable it'll be qualified for use within whatever range it's
> variable over and not some other completely disjoint value.

Okay cool, just the commit message/description to be changed then.
Thanks for the info

--vZAWaGjY/4yR8mA2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkTZUAAKCRB4tDGHoIJi
0me0AQCObcUdcbElZj50IRONP1N/21RcBBlQsQmJBZAnm3RD2gEAg8EAf60FeGoJ
AdfPQjGb7MEf+a+azjjLG1IZWyHIZgg=
=ApU7
-----END PGP SIGNATURE-----

--vZAWaGjY/4yR8mA2--

