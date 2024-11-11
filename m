Return-Path: <linux-kernel+bounces-404665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D60DC9C466A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECC70B28121
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7941A1AFB35;
	Mon, 11 Nov 2024 20:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ah/soMNt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4342156C72;
	Mon, 11 Nov 2024 20:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731355697; cv=none; b=isf9OZVZfh3SohT0XDHzA6bAlT1CyDtncnhtzqU+ThOMHQgJoWhRQLwCjpNN4ESgEol0zYUUh0ypB+Jm3lvFT/q9zKDH6FwA/Zbafhp2JyZgAhi5Mz0lwdacgeoa9f060+2bNDG8dc3waFK9auxJYMwgpE15kUtagxyxiSwDNGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731355697; c=relaxed/simple;
	bh=61kwqHZ5giGM6fbTTOhDbyTciMJG2l8PaHviQJUSpbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hH8IJeuaqrDO2JpGJdHiNB2r7bt8DoHUW0FlWdbOXmMc2QLN9teWGL9sYVrgR56JyXew0jwUSxVQACicmoIOC8bEmvcT223N2LpjD68ThNqviDFuaMRluqCTzBHAOAz5Mzx2x3Rm16/fupS4ZQl0i+IxSfhm9y81HxRFvDH4snI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ah/soMNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DADC4CECF;
	Mon, 11 Nov 2024 20:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731355697;
	bh=61kwqHZ5giGM6fbTTOhDbyTciMJG2l8PaHviQJUSpbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ah/soMNtSgrAoqwIkB3DDjjq5OGpxVMxK6Xkf1I1bXnkRtDi0AAEq5NTdfRvm1lwY
	 p9g3P5dHY94x3JeJKr34mQEmlPNvPOx1EKUHfjHltK9Fxxia3NmzPfi4wb6aJSMry8
	 a4IwL3e8n+sQJOycb9NHvbDmhoTcsovWXyzBSn4r7GafmyEqvsvEe2ZejcwurMXUYs
	 RJsncCtf+XJD1jDcXR4OWu+8bd4tCKl40NU93+I6NvTlIpMzZAGPb0poV3JRMteGpE
	 fhX1tpOQRz9hNz1iPxL7g5iwCujkOv4YDpUQtRxBG0CYI+TDRB4wV+G9jLUetMtxRu
	 vhy/+3DnfxA7g==
Date: Mon, 11 Nov 2024 20:08:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, mazziesaccount@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	sre@kernel.org
Subject: Re: [PATCH v2] dt-bindings: mfd: bd71828: Use charger resistor in
 mOhm instead of MOhm
Message-ID: <20241111-staging-rising-99b616f920ae@spud>
References: <20241111102701.358133-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f9csixedK73f7aPC"
Content-Disposition: inline
In-Reply-To: <20241111102701.358133-1-andreas@kemnade.info>


--f9csixedK73f7aPC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 11:27:01AM +0100, Andreas Kemnade wrote:
> Apparently there was some confusion regarding milliohm vs. megaohm.
> (m/M). Use microohms to be able to properly specify the charger
> resistor like other drivers do. This is not used yet by mainline code
> yet. Specify a current sense resistor in milliohms range rather then
> megaohms range in the examples.
>=20
> CC: sre@kernel.org
> Reported-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Closes: https://lore.kernel.org/imx/6dcd724a-a55c-4cba-a45b-21e76b1973b0@=
gmail.com/T/#mf590875a9f4d3955cd1041d7196ff0c65c0a7e9d
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--f9csixedK73f7aPC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzJkLQAKCRB4tDGHoIJi
0r5bAQC8XQx+LGEBKlOnVQcw6lzjxleafBLRPW4QhL9dCqC9mgD/e3MFFQoTSK9i
q1qdqdNt1xez6xFIUHh12cSfPGM0UQ8=
=SWn4
-----END PGP SIGNATURE-----

--f9csixedK73f7aPC--

