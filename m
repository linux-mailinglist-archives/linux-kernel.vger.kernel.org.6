Return-Path: <linux-kernel+bounces-307282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5F0964B49
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90EF4B26968
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268FC1B5309;
	Thu, 29 Aug 2024 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umeJptoh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C2D1B4C2B;
	Thu, 29 Aug 2024 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948099; cv=none; b=GRPRZP6PIk0yoI1zkAVVxEM7mgKaftZ7ZcwjTr+ZLNb6V6JjYali2PqpCjntDmdVfrOy4J/ytSVP8L5elKjsQMhdeXeVEb0TEbhXE4QvbYHmkOsW6Z020Pg+TyPlCp29Gzh1mYJi//jIVJzalRkVnaNimk9op/uO9N4coGTYlqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948099; c=relaxed/simple;
	bh=Mf0zirgRUd5Tt6mF+dKXvbGoO+NMUyTVlyvxmQigBE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=En9fwif10/1Yr1pLISxmHyYKWpDbGxb9iC247U4tVWIxSjk3YTJCsnJSOCZ5ww3DM87JlusLkbTmdm71SZTrmMsg+ZqrBB1/TZsIIAHOomjBhEynR5QeQ0biEBqlDmaWyys9wSHhtnRgr3DswJ9UzzSMHcKQDuW8zwQB/CeLS3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umeJptoh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C83EC4CEC1;
	Thu, 29 Aug 2024 16:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724948098;
	bh=Mf0zirgRUd5Tt6mF+dKXvbGoO+NMUyTVlyvxmQigBE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=umeJptohfaVQAFXe+iYXNhUsMsszKFXOxsJGECEqx6kz9E7QObuG6DHaKIA43eP5C
	 HCui93WF52zT+CDSxJYLT9G+8qxFQG+NScSs4TOp+uIJhLCBiM/DhznDpSn3J+dVyU
	 1jTKdIe0RqTOOiyVm9gI2iDnAAg93jTveyaJhSNyIZdvIDaWRR294E4aOmY2iw8NQS
	 Q29Yf6HuJlSEl6rL8iEQgwrh2jujmj3hBP82pymrJnIqv4RzYa3rBigf+Vu8GCY9Zi
	 wP9xikAcdM0XE2E3cCiyWI4vaWqKcTykoETDNgobGgLNIGYiS2o5WPY6thl4hBS/3p
	 bm/py7SBeB7cQ==
Date: Thu, 29 Aug 2024 17:14:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: clock: Add SAMA7D65 PMC compatible string
Message-ID: <20240829-difficult-zeppelin-9f121fa63369@spud>
References: <20240829-sama7d65-next-v1-1-53d4e50b550d@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yropm2zuTxmL/jR0"
Content-Disposition: inline
In-Reply-To: <20240829-sama7d65-next-v1-1-53d4e50b550d@microchip.com>


--yropm2zuTxmL/jR0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 03:08:45PM +0530, Dharma Balasubiramani wrote:
> Add the `microchip,sama7d65-pmc` compatible string to the existing bindin=
g,
> since the SAMA7D65 PMC shares the same properties and clock requirements
> as the SAMA7G5.
>=20
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--yropm2zuTxmL/jR0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZtCefgAKCRB4tDGHoIJi
0g82AP9NFNG9mUS9GTsKnLvy5OayV2KaIQfbLpFnYpuwH59cIwEA5HTh+7GfMujl
X8tOotN+PC3xF9h0AkaW4MluRjbwJw4=
=4JUZ
-----END PGP SIGNATURE-----

--yropm2zuTxmL/jR0--

