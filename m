Return-Path: <linux-kernel+bounces-231077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6B09185D4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CA101C226AA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C2918A95A;
	Wed, 26 Jun 2024 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqOqXDJh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C7E18C354;
	Wed, 26 Jun 2024 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415779; cv=none; b=pPFDO1r0lat9Odt7MDVYLgi6XrnWty6Sq8Ao22gFVSaGFXwP6wMZutI0c9u+8MoLVP9J450nY2HFx5V3NlWganMZXupcL++zKeCXXsnVnAoBf8EAYi2r7Y6Ds2Hxigw/z8UYoHi2RiklQQ12abpMRh45cFOUIvk+czjfAL5xTVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415779; c=relaxed/simple;
	bh=KYmFufaZOq+tPce2dbRFyvr/jertkuSk6czkmOSH2yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLo4OpF5TsnaCrVpOFinQ3tYR3+tg8/CHanGXb1TMiQJGy3sq0a7tJD51rxWskt5zAMCwMRbfYvxVupyk+kGjm035DsGYZ9ronPkHlTg/8/167suOdhi7wGRWTBacPAUKnj7kFKfbpOkFzQl2mYjIwf59OnTi0yFVzrvsvK7Mf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqOqXDJh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC82C116B1;
	Wed, 26 Jun 2024 15:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719415779;
	bh=KYmFufaZOq+tPce2dbRFyvr/jertkuSk6czkmOSH2yY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HqOqXDJhMESXTHTIVuG4rMwahchgQPfA/xPdyLszHIa74qc7c+/tqnBMjIkEpaJlz
	 B4t7LlD9dTHcQpG+AZmED327hygu+2cztsoYcMfmB2tTOOO60+irXO/HpMVJWCtXYj
	 E5gfnfZyW5cGDAv2gDEX6BwyGlrOwrPBklrpg7AGk9J7KOn/2+HFy9rioPsspQtxSp
	 RGdCLhJqNrdTq0J46AgY7fMT9+lV4Bb/6qaAnMgC4MECKP0MouMGeT5KE5xJsSvtO6
	 h73VhOu+hIP9C6AWwkYIG9xkzaxDJA7rxS4tCphCXQoXlOXeoyJNLQAPCTnd/PQgdc
	 +qkjL6JM848hQ==
Date: Wed, 26 Jun 2024 16:29:33 +0100
From: Conor Dooley <conor@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: panel-simple-dsi: add lincoln LCD197
 panel bindings
Message-ID: <20240626-chowtime-coveted-93da3bf31bb7@spud>
References: <20240626142212.1341556-1-jbrunet@baylibre.com>
 <20240626142212.1341556-2-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="phGq938lt5gtN+KA"
Content-Disposition: inline
In-Reply-To: <20240626142212.1341556-2-jbrunet@baylibre.com>


--phGq938lt5gtN+KA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 04:22:07PM +0200, Jerome Brunet wrote:
> This adds the bindings for the 1080x1920 Lincoln LCD197 DSI panel to
> panel-simple-dsi.
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--phGq938lt5gtN+KA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnwz3QAKCRB4tDGHoIJi
0jOaAQDx/3F2dkEEHhkpmmB5G7WSj/Ti3O7ogsCSBE/sPvDpmgEAq09d+xd7eY9+
Qar6TEY8dfFapHFrGfP+PxVrfmLNWwk=
=hC5p
-----END PGP SIGNATURE-----

--phGq938lt5gtN+KA--

