Return-Path: <linux-kernel+bounces-189036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E858CEA26
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 21:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CFF1F2148F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 19:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A6942ABD;
	Fri, 24 May 2024 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CELcBtIk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651612C6B6;
	Fri, 24 May 2024 19:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716577311; cv=none; b=ttgKqmkDINwOzT+DmI7pviva2Y0Jh96vuDDknTH4yq+Uuq4ztQXcI9F0O85Ghn+H/b0Lx71ZCQJBf0ORRWDeAZjYE7XkD2gQmJuTJNLp7oXTcGp9V50JzMjatCC6WxS18lVvLT4/OycSPecA+oMIdP8jh2ToEc4ISmXwzzjGTZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716577311; c=relaxed/simple;
	bh=8AHQ9p6PvVe4520jRRGX5kkQufDnzP7izZGOrirOQ0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewSEnqBpgtN93fVdoWPdrVZs+0iIRDHssHlLcDMP/cKfYlPq1BoOnwZ/GVqjEXudEWjjmjKPyFjjMAw2KdEWVnwpmBxxAjuL9THvEoon6cm2442W1TAWbz0922/ZE5yp0MpRqqrA2Lt/l3BGZ4dhBjEnYRtR2n2RUNLEiMAVVXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CELcBtIk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E120C2BBFC;
	Fri, 24 May 2024 19:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716577310;
	bh=8AHQ9p6PvVe4520jRRGX5kkQufDnzP7izZGOrirOQ0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CELcBtIkpB5jCodnFjjOjwruw3QCwbpf5Exmq6tZ2onRAlbnRDZ30PRAZ37lmgUtY
	 5VbfwfQqh/wfjjdIcJfw9ZLkEL+OM5U0Oomww17SMMy09v8IwIbQbNs16pIiHmZSuR
	 QLVKRKL8XJyk7WsaYTTHHOuWjNd85QLJYEZxbb6/e0cWSIQXdI1GoahikipROjZgeZ
	 DraqkBAIgdkVi++1bJaTTjkXYewx/YYQ74+kAK9fJBkFEtjGvXFjMLmQ89qcEqGa8J
	 EH0Hg8SOGAdb6vt8bT3gKayProiTLRmITRitNxr+DhRYwM4p2DbFH/yE1nngFP4u89
	 Z6IXXgqxK6P4Q==
Date: Fri, 24 May 2024 20:01:46 +0100
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Fabien Dessenne <fabien.dessenne@foss.st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: stm32: st,mlahb: Drop spurious "reg"
 property from example
Message-ID: <20240524-selection-little-f8adfa0a32b4@spud>
References: <20240523154208.2457864-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BHX4szPWPsM2i9bl"
Content-Disposition: inline
In-Reply-To: <20240523154208.2457864-1-robh@kernel.org>


--BHX4szPWPsM2i9bl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 10:42:07AM -0500, Rob Herring (Arm) wrote:
> "reg" is not documented nor used for st,mlahb, so drop it from the
> example to fix the warning:
>=20
> Documentation/devicetree/bindings/arm/stm32/st,mlahb.example.dtb: ahb@380=
00000: Unevaluated properties are not allowed ('reg' was unexpected)
>         from schema $id: http://devicetree.org/schemas/arm/stm32/st,mlahb=
=2Eyaml#
>=20
> Since "reg" is dropped, the unit-address must be as well.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--BHX4szPWPsM2i9bl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlDkGgAKCRB4tDGHoIJi
0uCiAQDbjFKnua6YZv9wGHzySJp/xAnFvNaIBNwON9KN0AwFaAEAvtpXl04h0qr4
OTc619LWMWvQYdnJxGl2CUuMgzl8WAA=
=7zD8
-----END PGP SIGNATURE-----

--BHX4szPWPsM2i9bl--

