Return-Path: <linux-kernel+bounces-337332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0FF9848C6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232311F22F5C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E390C1AB6C0;
	Tue, 24 Sep 2024 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSd95SoQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C70B12B169;
	Tue, 24 Sep 2024 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727192113; cv=none; b=q2GRgKEOegzoTEWpgrQomCXfKrsypuE7Y+rglSZaCircWTS0jBAnEY5MekCdwI7jYZzXBFSYsuTxf/SixCe+QkK/B4WZh6ayAefFJ2K2gRd7TbiDmLaInHHwF6F6qen37xf8qDWSRMulUgsFUoc8UnyXDQKN8yft2vSHy8V++h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727192113; c=relaxed/simple;
	bh=5k39+FThTFcXlfqgvI9m5uU50Jo/Y418Qxwfb1boWYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBc/Xn2Iw7XPU6AOIgEZLd5X4dmAk9jxuWiirSQIexzgBwkh3RFbTuf7M3JMQ2wbD98tVdguUX/G1obKG3Z7ztDZVLuFd0xnP2PUlRLN/qFSGE/PvD/FZDx7wMOPX9fztoX7ImsR+SPUHM5Rm/R/dhGodPMNOdGznJ7z/Kera7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSd95SoQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA32CC4CEC4;
	Tue, 24 Sep 2024 15:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727192112;
	bh=5k39+FThTFcXlfqgvI9m5uU50Jo/Y418Qxwfb1boWYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jSd95SoQ7nVrO0YUwPYegoDg+9urgE21qGdDs1kJeK5iLp20wjITnEQu9mYar+F7B
	 yxak2syVdQp+bUWxBHFjuWMrbJNIq9DUNn9t8wPs8Z1jviC0aA1eApm3OFA9bU8tDi
	 iiTX9BQ72MU0oLY/EMbFVNI6mmKn/9myzC/bOpJnQ6MHM5Wb7PPjmwBivwG2Oy0Ec1
	 d8zhe62SkWl6YfAK7vquuDberzsHgP0WVtkcqfDQCnFXn963RMyT1C3pXr0eu5HMkv
	 tknIpWSRKA/EoYE8SgljtAYYmmjuDsaxGs8qEWJgdi3TEfIVMjwM2Eqzjrm8HcqLEK
	 5d4HH/9hQUqzQ==
Date: Tue, 24 Sep 2024 16:35:08 +0100
From: Conor Dooley <conor@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: arm: freescale: Add verdin imx8mm
 ivy board
Message-ID: <20240924-viewable-wistful-d49860a66b58@spud>
References: <20240924113048.125761-1-francesco@dolcini.it>
 <20240924113048.125761-2-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d86xeVDz0CBvu9uE"
Content-Disposition: inline
In-Reply-To: <20240924113048.125761-2-francesco@dolcini.it>


--d86xeVDz0CBvu9uE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 01:30:46PM +0200, Francesco Dolcini wrote:
> From: Jo=E3o Paulo Gon=E7alves <joao.goncalves@toradex.com>
>=20
> Add Toradex Verdin Ivy carrier board support.
>=20
> https://www.toradex.com/products/carrier-board/ivy-carrier-board
>=20
> Signed-off-by: Jo=E3o Paulo Gon=E7alves <joao.goncalves@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Into triple take territory...
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--d86xeVDz0CBvu9uE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvLcLAAKCRB4tDGHoIJi
0pt8AP4yA898CQ56dYACP+4st+9YZk4Y0Sqwm6DHcqNcxScjCwD/e1PLqoYV4dps
RiJF7LrFDu9OIQW18Wqp5SBd5Zwhyw8=
=3d9x
-----END PGP SIGNATURE-----

--d86xeVDz0CBvu9uE--

