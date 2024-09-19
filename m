Return-Path: <linux-kernel+bounces-333179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7327097C4F5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3461E282A16
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 07:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C066E194C6A;
	Thu, 19 Sep 2024 07:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rzqo9i4H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C117166F31;
	Thu, 19 Sep 2024 07:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726731490; cv=none; b=IOuLkjXYX22d7XVV/uQPABJwBIVTeuIifw+UGjF/w/4mXBI1d5GBS5bkdNaoC94U+tUc/VPzE75MIVwlVTEF+hZOf4jc4XQ/VkzBdO63/h84XBChnZp3aaSQn0FwP5Ltob8Q4Z/td8wIj2LFw0OPZ0bGo/YJITAX+90p1h5BX4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726731490; c=relaxed/simple;
	bh=b/TvnlGUozolDpF9ubAiqQ9D9AtRZIsO8cTp8d7NLAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UipaCEYYnAk3Z5ogzOcU0JsW6tY9L2+1mWpUs8KS7xsEZCc+/iDw/kb2dXnNYNbQD/HvMaNXNbfv+eH/dw/c0LbQpzoO6ZxilWteYsDnbqQJNxE2OTasJOypHft4SmUacd7qC/qtiIaFIAzBQNC4buVDgpnZbawTwbLD/Ft3riw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rzqo9i4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7240BC4CEC4;
	Thu, 19 Sep 2024 07:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726731489;
	bh=b/TvnlGUozolDpF9ubAiqQ9D9AtRZIsO8cTp8d7NLAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rzqo9i4HBub0UQQHqadkJlXlK0XP9ECaGqwUY0yaN8d8LOwnmKpkYdangf7hN1xu+
	 QRzVbLI/4PEi3VNE5sE1YBs6p7Jm4P8F58Rq9EHGU7AkQoduyi0iArzmi7Hnjq3XiK
	 hFCkBrWgzmMYgDq9bzpssEf/lm9OPeKfaiscMYEq+VXawTAJALx5kbRPXQoufEcRNn
	 JMUTYET0JEzX2h5z0Mnm/IF3UQajTGGrIx7qALDmQsmmgw/KadWfD+x4OFOu7/uLp6
	 8at4eriadMSHwrv91mXIR2sIFvRYddM6afiH6RjZrt2MWBPO3DACngcxT4UCUcJ+vN
	 Uw4SWerwhDi1A==
Date: Thu, 19 Sep 2024 08:38:14 +0100
From: Conor Dooley <conor@kernel.org>
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: linux-rockchip@lists.infradead.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: arm: rockchip: Add ArmSoM LM7 SoM
Message-ID: <20240919-wikipedia-hamster-22ae9f9d8dd0@squawk>
References: <20240918165008.169917-1-liujianfeng1994@gmail.com>
 <20240918165008.169917-2-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YWWdApAqxAOp6MrL"
Content-Disposition: inline
In-Reply-To: <20240918165008.169917-2-liujianfeng1994@gmail.com>


--YWWdApAqxAOp6MrL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 12:50:06AM +0800, Jianfeng Liu wrote:
> LM7 is an System on Module made by ArmSoM based on Rockchip RK3588.
> This SoM is used by W3 Board.
>=20
> LM7 features:
> - Rockchip RK3588
> - LPDDR4x 4/8/16/32 GB
> - eMMC 16/32/64/128 GB
>=20
> Add devicetree binding for ArmSoM LM7 SoM.
>=20
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--YWWdApAqxAOp6MrL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuvU4wAKCRB4tDGHoIJi
0qzVAP4u/Ml6aPzDt2IXu/YTG+KwhPAvvDW9jFJWvja8pA8ndwEA8hdLvljuYsLA
qjo8XeWEgIIm0GDO4q2SQ6yd1MGSZQQ=
=4dhv
-----END PGP SIGNATURE-----

--YWWdApAqxAOp6MrL--

