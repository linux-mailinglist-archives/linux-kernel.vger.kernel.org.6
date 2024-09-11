Return-Path: <linux-kernel+bounces-325524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A05B0975AC7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 21:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37D61C232A9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A055B1BA893;
	Wed, 11 Sep 2024 19:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaOyqbUt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E531BA26C;
	Wed, 11 Sep 2024 19:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726082229; cv=none; b=ow/nmnVtwWJn39KH1l3TdBJtGBFgNDNv8IULwKqyZo4cd5yjZKNSKgPNie+XEogz0oZSFwHPlZW+loyuI8qr3P7+QHhZE9LqAoFxfMvjp+obMZ0AYhHfXqUw2iwdHUJqmRmTc2f1MdV2QgPMXdDsV/2Lb+FfoTnAuVTGkfi414o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726082229; c=relaxed/simple;
	bh=3x34o9ccfmgr+Yc5/Xm+YmpddZXSeb8HJ9VjzD4S6cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlR0Yz6PopZHs8vqelKXbNGqiyR0J5VLBjc/O9GB87GKTGYz7aveUDqpvnu45Fsm5Y+4NUYUkL8J7Kw1CHjpb1OJT4dSoUlvtNw71WCCdgSZLV83uxlOZ5AT2FdWIernFYwxLzevnTIdG8HdsLNMj6Kja2rdUSQBPHPqIo0AjCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaOyqbUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C82CC4CEC0;
	Wed, 11 Sep 2024 19:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726082228;
	bh=3x34o9ccfmgr+Yc5/Xm+YmpddZXSeb8HJ9VjzD4S6cE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GaOyqbUtFT5BXaPw53avIWqv+U+o7o3dUt27/Pua04UYM0YZ1iJQ/WOVWiYt2rSaW
	 VA5wluQlEkAHAq6oY1mXmYtmqTOPFvWx9VfDZB9KRmyvMNoeCSb4ozXjT8SrMwVaX8
	 Ot1EmkJh9sHHeLi9kr4bxvCAyeUJg5JosKmD4LhGbVKxJDIqOQyYojrCrbI7m2qtot
	 CpisDR0f9567Q2CvRddlBnPCtu9klu49Kr6kFhqlLLJlBh815pIfOvonbECf891CaC
	 jiVhfAtG+v1WeZBW70gXqhsFgsbKjkrhiPQv3HVWkke944yZCyoB6rqCx6BhLZLAdk
	 kx6GwtLeN8kZg==
Date: Wed, 11 Sep 2024 20:17:04 +0100
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: clock: mediatek: Drop duplicate
 mediatek,mt6795-sys-clock.yaml
Message-ID: <20240911-train-carnage-f19405590f8d@spud>
References: <20240910234238.1028422-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Kx11F4IBYxbm4SiO"
Content-Disposition: inline
In-Reply-To: <20240910234238.1028422-1-robh@kernel.org>


--Kx11F4IBYxbm4SiO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 06:42:37PM -0500, Rob Herring (Arm) wrote:
> The compatible strings for mt6795 clocks are also documented in other
> schemas:
>=20
> "mediatek,mt6795-apmixedsys" in clock/mediatek,apmixedsys.yaml
> "mediatek,mt6795-topckgen" in clock/mediatek,topckgen.yaml
> "mediatek,mt6795-pericfg" in clock/mediatek,pericfg.yaml
> "mediatek,mt6795-infracfg" in clock/mediatek,infracfg.yaml
>=20
> The only difference is #reset-cells is not allowed in some of these,
> but that aligns with actual users in .dts files.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Kx11F4IBYxbm4SiO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuHssAAKCRB4tDGHoIJi
0uDqAQCgJaSn0aIreDVI8iXzweTSUXhnaVeVmWq1uBIOFi4VuQEAuIB5sxXIZXZR
4zajWaprYZit0ZrBumAPqpkI8wjf3wo=
=W+In
-----END PGP SIGNATURE-----

--Kx11F4IBYxbm4SiO--

