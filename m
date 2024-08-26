Return-Path: <linux-kernel+bounces-301928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B1F95F77E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2611C21B35
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F4F198E96;
	Mon, 26 Aug 2024 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CivOqKT0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55061198E78;
	Mon, 26 Aug 2024 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692291; cv=none; b=mKjfj3PwaYauU7v72SMXyOCXWpY5ZJlosf4h0RjlliIPjGnaprPw/yqa5AWLH2IF/pwmOrT02X2tPUn3u0tI/DHnlH6oLCNzdqVIBO8bYCS3nMObgXFbTYoOAHxhRFbkfTX4Iu3D0qNnEgOhonGDSKBpI1m87aJOqqWAGHL89K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692291; c=relaxed/simple;
	bh=y/4dPSEOyJ4WNl4lVqE+yypC8OvAjsRRR2pzaixlZ0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRwk4dd+RRyAVyaw4VePCG8MHOvWqmVuNLGyWLdjCA1jtBM5j2Xo4M5sfJRUHumaOeQ1KPDIT1Ds8vTOpdNxzO5D8z9M329seelQ0B/dHT7KDTd2JffoxZpNLtklHLopoPA801hZJJdH4WwmJtBftv2pgWDDQuIw8PPvWY8WQKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CivOqKT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FCCC58302;
	Mon, 26 Aug 2024 17:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724692291;
	bh=y/4dPSEOyJ4WNl4lVqE+yypC8OvAjsRRR2pzaixlZ0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CivOqKT0lPqAmn7Jnv5SP6Ip2c3XsT0rVZzfHEFqEcz85oT0iQoB65byDEDFn/ZMK
	 oweCOJ0aqsKJsNQmcks6U0ve3s8LRjhBvEXm6i4frpYm5qwhP5LWr2ZxyWyDvurgPx
	 h9KjutZ00kEVwVCpxVy15mP1WHRUlIWQcaRU+yF9QAE92kUPyHJl7xuciRec4Twfcp
	 zW6om0rog3grPK69veYLFT77PfvUQUtcBxQNHVvOAvqHwVLpECw7WbkWuxCBCqvqnL
	 +Nrw+R8Zs+NtuHWvRtM6ZMIXCXkOwqeYmgAZeJOC/azso0wrZDPxW+vkVU9SmLGmVq
	 ijiCX2KoeTANw==
Date: Mon, 26 Aug 2024 18:11:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Johan Jonker <jbx6244@gmail.com>
Cc: heiko@sntech.de, robh@kernel.org, conor+dt@kernel.org,
	krzk+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v1 9/9] dt-bindings: clock: rockchip: remove CLK_NR_CLKS
 and CLKPMU_NR_CLKS
Message-ID: <20240826-sworn-harvest-2f2b69d7e581@spud>
References: <416cdaf2-fef2-471d-a03a-837775d6e7dc@gmail.com>
 <a3292ed0-3489-4887-8567-40ea4983c592@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="asO5tklLM9gWvLJU"
Content-Disposition: inline
In-Reply-To: <a3292ed0-3489-4887-8567-40ea4983c592@gmail.com>


--asO5tklLM9gWvLJU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 06:39:46PM +0200, Johan Jonker wrote:
> CLK_NR_CLKS and CLKPMU_NR_CLKS should not be part of the binding.
> Remove since the kernel code no longer uses it.
>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--asO5tklLM9gWvLJU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsy3PgAKCRB4tDGHoIJi
0hEBAQCX/kAPZMuJaVhh13WZOsk8nCv7mOhsArnX8yi/BboXvwEAgPYP8fFH6XG5
EFKs1Y/jp+bcyJ68F83OE/srankNcA0=
=VkUa
-----END PGP SIGNATURE-----

--asO5tklLM9gWvLJU--

