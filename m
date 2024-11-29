Return-Path: <linux-kernel+bounces-425706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F869DE963
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6875B2177E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 15:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1032114658F;
	Fri, 29 Nov 2024 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ii6Z6PWp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FD11448E0;
	Fri, 29 Nov 2024 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732894167; cv=none; b=cF1Wt2YlHuOuaER0lTGtRemiGTaWmuzXDaBqQH3cA8JtopcJr1sp8iB5ABmZ48ilBUPx9wo8ihCFTFR/kyWkQtX7VUoPliEDATKrdvoiJ9G6M+eqpAFyqcpUK5MLljS9u1KB05/U3DomU5vOVgsTsR8H8BMmu7Iivt2pHDDmCyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732894167; c=relaxed/simple;
	bh=gemHqc6nEYZsaj76pOy9Uu8PHBgdPrXwJF9PuGadYLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWcQhgt7oLlsfnKiYiVASjnurq4zt9Q3LS6l4FE82lawCvZwOPXQ2ykVtOehCGLEx07aT0G1k9ZfS0qfQwatW+zTwLWmv2V1i37t35rR6K5zYodeLQ0a0mTTIpneBynqQSQtRkTIogVxn8qCeFxLdV5vnp31rM9bsDQo0/bdeY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ii6Z6PWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E92EC4CECF;
	Fri, 29 Nov 2024 15:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732894165;
	bh=gemHqc6nEYZsaj76pOy9Uu8PHBgdPrXwJF9PuGadYLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ii6Z6PWpgFnotEpHtJDL+pwmTDbL8kG6Vyjs8ff1Io8gJUYr11m50GX14dafdhVBk
	 vSVjruUg1qpkHrXp0zkn82lGWi21eVQvOtCkYQakPQs8f1QrlPdj7JStfIf6FZnd5T
	 BTPRsKHYARF0GK2pP4c6z/gc3QGrLtPBQ6vV5/r4MzDUZRP5lUV/9JN6ZER1XB2GDw
	 q+6FbT/ylU1XuDFVtTk/WuFSBh+dHtKW4mT9wqDWxmW449Pkq4zON1flhTKWxkNxoi
	 UHXM9IEfBppoi0KtevLTGmtwBTx2t2138lEM5rJRfRgUj5mZ7aVOBFw3u80nK3iQMJ
	 jjpeq6+SowPgw==
Date: Fri, 29 Nov 2024 15:29:21 +0000
From: Conor Dooley <conor@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Denis Ciocca <denis.ciocca@st.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: st-sensors: Re-add IIS2MDC magnetometer
Message-ID: <20241129-dictation-outplayed-0a6a0844158f@spud>
References: <20241129-stmagdt-v1-1-963f0347fb0a@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8x+8u9VoME862kbh"
Content-Disposition: inline
In-Reply-To: <20241129-stmagdt-v1-1-963f0347fb0a@geanix.com>


--8x+8u9VoME862kbh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 03:54:42PM +0100, Sean Nyekjaer wrote:
> "iio: st-sensors: Update ST Sensor bindings" accidentially dropped
> the compatible for the IIS2MDC magnetometer.
>=20
> Fixes: 0cd71145803d ("iio: st-sensors: Update ST Sensor bindings")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--8x+8u9VoME862kbh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0nd0QAKCRB4tDGHoIJi
0hSoAP99z6GkLqzidtt9MsGPQTs9Zyme4cGF5rWnbcoZ/87wYwD/Y/suo5mGJVhY
3us36uOcTA98y73GMUKuAQ1DahbWbQM=
=hAhQ
-----END PGP SIGNATURE-----

--8x+8u9VoME862kbh--

