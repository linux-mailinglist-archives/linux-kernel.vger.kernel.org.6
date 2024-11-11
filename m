Return-Path: <linux-kernel+bounces-404707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320279C470A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB99B28146D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DC81B6541;
	Mon, 11 Nov 2024 20:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gwvs+SPU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069A01AFB35;
	Mon, 11 Nov 2024 20:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731357574; cv=none; b=ul5cDSSCnulYO/8ruIW0OyKW1ZrCLCJuv6j5qbfrMwR8fP9UCWqhMUlV+pv2PEPONJQp+KOK6Xk0NJ3E+RyxFvweT4WYcorZFtMj6QBlA8m55EoOL3cRB0WSffwH27C98kifmCgOf4tSVFeW6L1FkrEFYkkulKwP60/W9OSrqRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731357574; c=relaxed/simple;
	bh=03zyUPxMborpGlQtL1eawvT1ZJZeuenQ9E9nO9+dfCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCuI0YN0rvbiEKCWDP0okyuipjWWMK6sR+3Co6IvJ5RsdaJZXiZ0LRgZqwcJONAxjnu8kiixKXVkYbYbqnbHNX5LmV5nrOYCSHhXHD9jNYcph5grdrOe1YR84A6Tcx26dLoJWBFJr19woErNTvDxIbSPOP3Y0KWeXAB/lLGjfA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gwvs+SPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966D6C4CECF;
	Mon, 11 Nov 2024 20:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731357573;
	bh=03zyUPxMborpGlQtL1eawvT1ZJZeuenQ9E9nO9+dfCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gwvs+SPUcRquo+j/QMt3OMFSurofedHdAK0AA5ZW6nl+e7hh+4G+30fsGSPLKO0rG
	 OugN2iJdtC3Mp5DHlDawherM/1uZqMtqSfNz4WWkGC4zCg+VUwB92N3WgWAW8VQr0Z
	 57KEuagul09XSkBQNovwe2rNt6RlrFOTS7PDF0L6eLgItWYx3xq+CHDJfNCXs+AcrA
	 6v7dGDqaamzhRbTyKGVjD+rWHeqalGhHTgL5Ze8V5vQvBjNoWehrk1LiTuzTfgfXYe
	 zDmHm/NYFIxXSZXDCIz+szHTePaBMj1VmyjXGjVj8on3JHo0VMcmn2XdXuoZV14IG6
	 5VtxCVcM+ePNA==
Date: Mon, 11 Nov 2024 20:39:29 +0000
From: Conor Dooley <conor@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/14] dt-bindings: vendor-prefixes: Add YuzukiHD name
Message-ID: <20241111-mystified-salami-5ce813076da0@spud>
References: <20241111013033.22793-1-andre.przywara@arm.com>
 <20241111013033.22793-13-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8AhoWu5KXTV+96/t"
Content-Disposition: inline
In-Reply-To: <20241111013033.22793-13-andre.przywara@arm.com>


--8AhoWu5KXTV+96/t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 01:30:31AM +0000, Andre Przywara wrote:
> YuzukiHD provides Open Source Hardware designs, and also offers
> ready-made builds of them: https://github.com/YuzukiHD
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--8AhoWu5KXTV+96/t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzJrgQAKCRB4tDGHoIJi
0oj2AQCQatM9URF8kIUa0t5BcOVADZNN0C9gGdPZkAar7KpvtgEA7nNIlUfxXv6n
uITe2G0vFrjDoeDAx1H7kp43kxvBqwM=
=zFr0
-----END PGP SIGNATURE-----

--8AhoWu5KXTV+96/t--

