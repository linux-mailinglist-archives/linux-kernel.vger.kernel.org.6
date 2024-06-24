Return-Path: <linux-kernel+bounces-227104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2E3914865
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBFCC1F23F74
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E91F13B29F;
	Mon, 24 Jun 2024 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJUCynfX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58D913A260;
	Mon, 24 Jun 2024 11:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719227996; cv=none; b=boVzWCPMQRN4ZlOwRqIrOof9dSOZJ1EC5ZYqYw8G+ley4qcCQNMIXnsGZG+NyxtTyF0HB8n0XAskxKWdJ3nvCeaO6os87sWTgUUDzN/C4K/WcXbVj2Ygkw0KW0TTHK5xYB7GAjqbEEgMCbkgXmNkaZqhr61P1SoVzmK13JlJ0M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719227996; c=relaxed/simple;
	bh=jwRuwDcYkx6HKhRYpj9ivnWyjbPJ2carDaco6Q3fl5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAzTVRdPCUZU1RAIfxiNpWBmUookvQSJWX5lkn4F34ZMVeUJZ3w7fOCoJZG2cdiUUI97n1bitpNKYxUT1N+lema3cCggedm6j/XJ3uTPptVNZd8ihIGnhmFC1HEJyI1qXv8HVeChtQMt63l182qzTit+IDZunKZtsYEiFFq1OBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJUCynfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205A5C32781;
	Mon, 24 Jun 2024 11:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719227996;
	bh=jwRuwDcYkx6HKhRYpj9ivnWyjbPJ2carDaco6Q3fl5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GJUCynfX/d55AUJywlTOmPPeEMHC2xfyNOTwW8d7xyIvfCEDRXl/UxyPqR5OlwycI
	 K/c5LDiWNY0tmenmxAdvzTpuzEV7eMxdERVdcVLkv0xx8WA/PEROQD7XGSPj+gp3/Z
	 20sACruQIHcT2ttGWZVpeR2DRhLaAAfXFh0OLgJB7xH+OJc3QvOZhmEQDlXH+JJ5rb
	 MZj0HHmJGycB/QDgTWXLsyzEeX/Nq3YTejZCs3rFzT472QP30bg7G3W8MgokKsi3hf
	 q1ZeojkU39GdnnAbN5FktmkRBW24CasiRZTdax0i/zqLr3+nDjoiB7S6+CURyGCurj
	 IDBnVoJ715oEQ==
Date: Mon, 24 Jun 2024 12:19:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: amlogic,gx-sound-card: drop minItems
 for audio-widgets
Message-ID: <2d33411e-b98c-4cd8-aca9-d65b55fe43bf@sirena.org.uk>
References: <20240605-topic-amlogic-upstream-bindings-fixes-audio-widgets-v1-1-65bd7cc2e09b@linaro.org>
 <5318f6e2-7bb2-4ed5-b0aa-585a6a2d8a5d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3UDGno+ZHVOYsb7K"
Content-Disposition: inline
In-Reply-To: <5318f6e2-7bb2-4ed5-b0aa-585a6a2d8a5d@linaro.org>
X-Cookie: Allow 6 to 8 weeks for delivery.


--3UDGno+ZHVOYsb7K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 11:13:44AM +0200, Neil Armstrong wrote:

> Gentle ping !

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--3UDGno+ZHVOYsb7K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ5VlYACgkQJNaLcl1U
h9D4twgAhu1ezJ/DoUKfgtWfZ0GmLxAwrgt6KsXsN4s3OGsbtIG3G0DKrCzFllHb
k0rMkM4WRBfFDXwg9LbgeXw/KNfBFzx3jHpw/x1xEoaZr/+o3UNMeVeQ36NaYEtC
IEKUb6secYEfRGfy56+J53ROIZEZIIFfaOx4lnKR+eC7WQPaAmWnRk7JKYkDnQso
NnN7JzRoemLk8w0egCPLcybDDsZzaed5ONX4Cu8L3lFpUi5+8cPLVCrEaV8RLatt
5736pIa94htZOdw8H7bA1LlHPtq+ZgUOA+FccPD/bbbDVTjes9hVJ8ymrYz6sS9O
2eXFwNHNDwHts7s5tPlx4Nm8C4+Nkg==
=i/+i
-----END PGP SIGNATURE-----

--3UDGno+ZHVOYsb7K--

