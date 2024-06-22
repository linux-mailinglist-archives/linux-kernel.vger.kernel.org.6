Return-Path: <linux-kernel+bounces-225683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45A49133AE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 14:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1DBD281974
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 12:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BD5155CA0;
	Sat, 22 Jun 2024 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtkZiq7A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4BE5A788;
	Sat, 22 Jun 2024 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719057915; cv=none; b=SmW9LBmKvfjelfCD+KlkoB5PSgRImk/wetybMZVNmlZ6J4yZsFZDXmoEP6erER/R+0aklSLJLu+pqexaiNrsqmjRlZoQjQaxfK1b6CRYmL4flgaolhEILq2ls59s23dIRwjxrizAyP/JAoTw59SfyYoNluN/ZwpO6yxUkNhrKFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719057915; c=relaxed/simple;
	bh=s45ENKzaHyMCE/Qn0FDrQXYTpuJWRYXMtgn25rFVBFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gkqik88xH6kCKWHmGK+cXg0GHqDyffaDLhQFD7uW/Te4LSH/r+nCcuuNLogg0fbElfwNLRBNq0ftyaP+tnVfMR0hRgXfE/764UKiZ2cCLYCS4esKZRkSsJpoWXkrICEN3psyGeEJsOR1TX8dbaKgS5xkGPkd7RkPsFdhePS1YnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtkZiq7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912E3C3277B;
	Sat, 22 Jun 2024 12:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719057914;
	bh=s45ENKzaHyMCE/Qn0FDrQXYTpuJWRYXMtgn25rFVBFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XtkZiq7A+ppSheI0nZChWJUuD2vIRauKfbC33hKDpITUmuRkN/nprkgzxd2x9zVcB
	 RWiiN/FYPHEa7zxUkS9LpiM2VoLJxy/eJPOFIL5sG4Ji5P35rH5FPgqTReLRRJwHsY
	 aBJpJY5cG+O/DqmPFN+tubmit6azH0R5/CAWPzfOudQw4ZXhynHg1+VFV/+ZhNpdK2
	 N+Au2JiIKOJpz32bExn0Uu1p+F7ZXUq0/WdWhSh2nn+Qd3J6YNmDiJVvIB9qgdPb6u
	 BK7F7Ot3QZ34GxWGYO31E8gsp+Go1EnS7wY+D5OX4ljy3ubB1OIs2yzv7Ke1OG8Z6+
	 Jiq2aEVNlu3WA==
Date: Sat, 22 Jun 2024 13:05:10 +0100
From: Conor Dooley <conor@kernel.org>
To: Alex Bee <knaerzche@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: arm: rockchip: Add Neardi LBA3368
Message-ID: <20240622-pork-capillary-9e2a1519c894@spud>
References: <20240621134030.243646-1-knaerzche@gmail.com>
 <20240621134030.243646-3-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BnhfDMugezzlo1P5"
Content-Disposition: inline
In-Reply-To: <20240621134030.243646-3-knaerzche@gmail.com>


--BnhfDMugezzlo1P5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 03:40:28PM +0200, Alex Bee wrote:
> Add Neardi LBA3368, a RK3368 based industrial board.
>=20
> Signed-off-by: Alex Bee <knaerzche@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--BnhfDMugezzlo1P5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZna99gAKCRB4tDGHoIJi
0mR8APwPPO+Xf7XVCqr4mj8pE/RGPYk1dMMNcWRN4s4XM9fvogEA/8hqyhFSEuPZ
hoLA5Y7nIRENOHzt6PhPIx85SIZMvAE=
=UENt
-----END PGP SIGNATURE-----

--BnhfDMugezzlo1P5--

