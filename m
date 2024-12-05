Return-Path: <linux-kernel+bounces-433768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F409E5CC8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644DD2865CA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C7C226EDC;
	Thu,  5 Dec 2024 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFMM5tRh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FF9224AF3;
	Thu,  5 Dec 2024 17:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418893; cv=none; b=gIWO18KNNZ+1Qr3XUiw8FGwu33Z6tcvxho/TSJSk5+YrgJ2mncDQFDXJM9eQ/h21PVcWZIopDsCzpnqOdi/uRJASGJmug1XwnkUE5o77xTgGquLHCMAcQbE04KbKykD/i7/ThYVj0zHv3Urp+WBrW4792wSwazGrvyGS+nzkblM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418893; c=relaxed/simple;
	bh=g7+SDGELbAyJq1LZCuLfvUnhbJvW59fo46nN0aJT224=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yh1u+J7n6SMyPmrFWEsLsgfpjEaqK9wbW9Op1nuLf++YiaSyXS76lHqEA3256g6t037YUrRw8jJn/EY8poK7zMJXUB02Ct9Qq2/lq2F6eLMtkZYny0yPydQtpzm8YydLEK/0+MpppFra4n259ZxlMaWjjQ9HlkI6lQjZQ0lBrb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFMM5tRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CC9C4CED1;
	Thu,  5 Dec 2024 17:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733418893;
	bh=g7+SDGELbAyJq1LZCuLfvUnhbJvW59fo46nN0aJT224=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oFMM5tRhbGnzovi/e8YXVlVcPDjANcJGVSm62j9E6Gj0vVBliR/ga5hhj1AvCLGyu
	 YQub5g7U3pBlh0xanTfRSsJGLHClq75InhM3MaAjUQGH478lpajGT+8fURg92oHyfL
	 Le/WruIBgMcWmrfOCcJmBOPNhIQq/JEfcRux5c1izPJO1TV0Osklt+Ic0gbvZmxI92
	 JfVZ/OPMyEG6gm4G9jCXAcvoX/+mjS+3IEhgueYUJSOMq0tJ3bCka8a3FNoHJO0ahY
	 dKI6Y3qt9KGWHL29KF8gOzcAZXtjap/anVuDdsA+gqEybkSECbyEj9lh5DN1keYgyZ
	 qxkCjFUo561sw==
Date: Thu, 5 Dec 2024 17:14:48 +0000
From: Conor Dooley <conor@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org,
	Andy Yan <andyshrk@163.com>, Chris Morgan <macromorgan@hotmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Tim Lunn <tim@feathertop.org>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] dt-bindings: arm: rockchip: Add rk3576 evb1 board
Message-ID: <20241205-judicial-drainpipe-645f3abe07fd@spud>
References: <20241205103623.878181-1-kever.yang@rock-chips.com>
 <20241205103623.878181-6-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="89wR+2nktXHU//fa"
Content-Disposition: inline
In-Reply-To: <20241205103623.878181-6-kever.yang@rock-chips.com>


--89wR+2nktXHU//fa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2024 at 06:36:22PM +0800, Kever Yang wrote:
> Add device tree documentation for rk3576-evb1-v10.
>=20
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--89wR+2nktXHU//fa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ1HfiAAKCRB4tDGHoIJi
0shFAP9NJhNby/omP3OSVIPt7iBoPmiCeczc02OwtSuAdnOpTQD/TO4/+CmmangR
TKe77msc4wb+4Bz0oxPAjaXMaHiiZAE=
=Xfhu
-----END PGP SIGNATURE-----

--89wR+2nktXHU//fa--

