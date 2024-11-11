Return-Path: <linux-kernel+bounces-404666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F3F9C4663
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC4E284A15
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683C01AD5DE;
	Mon, 11 Nov 2024 20:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHz/9ehY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC23F1EB36;
	Mon, 11 Nov 2024 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731355733; cv=none; b=Q9H/u2336yyieIXCvKAYddEqfSAyudynreYa0O3XqkWAWyzS/i+gLQhnbKyIOykdMjw0Z7mGsD5lTYS610fr9q5Dzc8Elkz7mggqz+387ZaS95U8w34c/h1yumC+AvQy6uvNZUUX5WMJOo6jAb71NX7BrrY8Ns6Ntp2YNr9kUac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731355733; c=relaxed/simple;
	bh=yvcGZ7wvpSriLuQnGAH2LPV+5WMP19XcyE6Jnj9x2e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2chLMGpxSmzkTYWjt5MVkQKFYNmDwnFzMuQlM0LQhnGc0MbYiIwOsBIc40EAVQFN2w4CAYj/AgePFybe8vFDtSGW5+u3nIdh3sAh1dybHb21ccIVkbmBWQ1AOF+zaQTWPaKL4kYoUCyQpnaLdeDQsqfOmxAONQcOHXOeQvdjZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHz/9ehY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3046CC4CECF;
	Mon, 11 Nov 2024 20:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731355733;
	bh=yvcGZ7wvpSriLuQnGAH2LPV+5WMP19XcyE6Jnj9x2e8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qHz/9ehYaII/R/J6Z5dOLSi7Mqks01kmg6y8kKQEf+3uPJ8G/O0BsB0OePh37Q7aG
	 Z2NteCTb4dSh1UJRkYtcxEuySL1etRwqhxGWuSOkhlF+HSukymwaerPF/+6xC1gEW/
	 J+QsI7R20t/E5Sbk/Q+C0OkXGbtLr2d/+cgBY/k8XH+skU7doKrKHN38eAvn9F6e1n
	 2E1jcJhrUKG7182Ezz22slS59BUrPUAomTCzQX9hA71b40IoRcHdbZzc2fWpzFKtmJ
	 qzTG790g7VQd57xmxO8vcYc9owwbaE9fpJJYb5ODcMJxnB9hnA3QNuHxPd11RpN6D/
	 /C4ufbMvaYnLA==
Date: Mon, 11 Nov 2024 20:08:49 +0000
From: Conor Dooley <conor@kernel.org>
To: Sung-Chi <lschyi@chromium.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@weissschuh.net>,
	Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: mfd: Add properties for thermal
 sensor cells
Message-ID: <20241111-scorecard-poster-006eadc757d2@spud>
References: <20241111074904.1059268-1-lschyi@chromium.org>
 <20241111095045.1218986-1-lschyi@chromium.org>
 <20241111095045.1218986-2-lschyi@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ksCYOGiCtSKkK1An"
Content-Disposition: inline
In-Reply-To: <20241111095045.1218986-2-lschyi@chromium.org>


--ksCYOGiCtSKkK1An
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 05:50:31PM +0800, Sung-Chi wrote:
> The cros_ec supports reading thermal values from thermal sensors
> connect to it. Add the property '#thermal-sensor-cells' bindings, such
> that thermal framework can recognize cros_ec as a valid thermal device.
>=20
> Change-Id: I95a22c0f1a69de547fede5f0f9c43cbd60820789
  ^^^^^^^^^
With this removed,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--ksCYOGiCtSKkK1An
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzJkUQAKCRB4tDGHoIJi
0l7LAQDf5vC4rmjOVHJdnl1yRGQfIecXi0NHoVDdBdBlXIkBbAD/cYiFRUPm6skp
Me3zWO/oSTkJfYZs1uWQpoZPfNuOcw8=
=ocft
-----END PGP SIGNATURE-----

--ksCYOGiCtSKkK1An--

