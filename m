Return-Path: <linux-kernel+bounces-202936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B334D8FD346
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B18B285323
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A744218FC6D;
	Wed,  5 Jun 2024 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkD/rJZ1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07771CD25;
	Wed,  5 Jun 2024 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717606617; cv=none; b=gT2P1aS6I7KVqCwZXFiF368+e8kiahHFoM1Eq77eLG2po5MMwAxEBsJSOe+ZGO1NQT8Ok8fzkHQlJWyKcDmlkQV9BwtkRCWIGIktvdbcEV+Uki7nnWG2+oYqkOJKA9kpjLSX1Hksr/3wFPQ0VpOBJHCkR43eoEC44Bgt3+b/8x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717606617; c=relaxed/simple;
	bh=pfI35ozd31OmX9/buzkdSci9env3fD1wc7ou55XdvNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUFPp2taj5bHoB/2aTOL4mEiTxJo9a5x9P/EdZweDPC3S3L9SdVr3RAHIgh792dDUOytnU5aD8mDoM5mfXdh7kfjdFFLu5KFWabQA41tRsYucj+lzAPwVoW/U2k5LgTbsQG7RkG3mgZr6Mm7RzTiyKFxOUNv/s1bWdU7/ApNW70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkD/rJZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B03C2BD11;
	Wed,  5 Jun 2024 16:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717606616;
	bh=pfI35ozd31OmX9/buzkdSci9env3fD1wc7ou55XdvNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dkD/rJZ1r2NSj0HqtJDUzVvwrKiMLXW1x2aFiHk5bFJKQUgowYJcz1pm2VCYpOlWV
	 NRB3l4/+K30HUfYZhf2OMIPH3x5yOzMb+sbhSv8GF00qfhpK9urSDe0XlqvbSH+8bP
	 CRRcf8RqFH2TpKq/mvZ0KZNYAKqQTsYOwprw9H/tHVG9aSxZf9wyzO472reIyda4+9
	 ePEfsboVO3NqGBgzBYJmlSWBhWY2A9Ak0fm/QVAUsekctM0aTLFbKnv4NS6xLo+jYU
	 w34BQVBa3GdxvwMy/Q6YxB8bM5XSoqyJd+EBN6E1V0sSD0a8cFDQOSt8ltgUFUiFZq
	 3E5HbNkQ5UN7A==
Date: Wed, 5 Jun 2024 17:56:51 +0100
From: Conor Dooley <conor@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: add i.MX93 9x9 QSB board
Message-ID: <20240605-envious-herbal-55c8279c675e@spud>
References: <20240605094812.1074027-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jbtzMG4BItgVRYPO"
Content-Disposition: inline
In-Reply-To: <20240605094812.1074027-1-peng.fan@oss.nxp.com>


--jbtzMG4BItgVRYPO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 05:48:11PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add compatible string for i.MX93 9x9 Quick Start Board.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--jbtzMG4BItgVRYPO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmCY0wAKCRB4tDGHoIJi
0sO9AQCNYcHSKIguSI5llLEoRsll74SaFTE12Ue0XRqS+AXc6QEA+NiFXcOHNhvQ
jzkxE4kLsiXYGzWgjG4oWgRcz3vYqwM=
=e5Ny
-----END PGP SIGNATURE-----

--jbtzMG4BItgVRYPO--

