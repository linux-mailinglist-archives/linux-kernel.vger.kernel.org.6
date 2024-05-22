Return-Path: <linux-kernel+bounces-186618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C86D78CC665
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 20:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6846A1F221CC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BE2145FF6;
	Wed, 22 May 2024 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i222VVEL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF3A1420D2;
	Wed, 22 May 2024 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716403018; cv=none; b=a/xmiSZ5BykzE8nXoa3GtQjkqQTQaeYq70X/0Wx15toYMJrht7APxcquNS6cgqZObAAiQT9eX0XXS3C8Ev8JPJIHy/PfBz0kR5NpHGkpxMwZf1tSBiWSikWVSmTH5Z02t+tp/Nr6quOAcpcBG2BP/9cnGHyJ2i0sslKSrE/2xyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716403018; c=relaxed/simple;
	bh=pm2LG6gbp5LE1G0v9capLG0PDlIdlD4dHLPWVqoM9FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAw2qE7YqxUCzEzKnr7asQ7GHmC1ZSLG4QFZZetb3BJqYOpbrhSY8qknzJgpGCiOtQrZmvjWMjVadCLl8lInIjkIxfEoDhybn/TeAHl6pIQ8dY4vKC7pIxOcY9gU0OY1E/aoDLMTb/5KXovpVb6cCbB+sERQ/fOa6Z5c4aRviPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i222VVEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79659C32781;
	Wed, 22 May 2024 18:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716403017;
	bh=pm2LG6gbp5LE1G0v9capLG0PDlIdlD4dHLPWVqoM9FQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i222VVELKO76b1cxP5EzXelJXJhsTmDw1T3QE/sKjy3vdB3BChX8VXvn6Z+HYPrkZ
	 3W8UF997qT9s+tuonalvNU64CFdwb/sMewdOtzR7Ecyj0hB2bLm9WMXnJQDu4mOCfB
	 8OtQ+Bkidkkegm/bNzNYzLW3vrKn3qgLkFHifRLSrNt5pgSP8bd0L3rnlmhzl31Ek9
	 TvIsB41yST5ADHdkoqD5pqGoS0f+WrxJF457pNmMR1XRBekwWh+vIcDlpBvvLlPxpD
	 xL0bKjEEnOlb+YmY2ggraUrG52p3EPKj7ilpZERyXm5UaUGBliPwRHFdk+UZeNXpeM
	 H8rCmvMR+ZcOg==
Date: Wed, 22 May 2024 19:36:53 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Julia Lawall <julia.lawall@inria.fr>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	=?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: DT schema bindings conversion mentorships (was Re: [PATCH v5]
 ASoC: dt-bindings: omap-mcpdm: Convert to DT schema)
Message-ID: <20240522-unpleased-morally-4dfdee2193af@spud>
References: <20240522075245.388-1-bavishimithil@gmail.com>
 <0594944d-c158-4840-8724-b3f2edaab1ca@gmail.com>
 <4f722e53-011f-4176-b6af-080522165007@kernel.org>
 <bb44d588-9316-4509-b545-9bbaa2d240cb@gmail.com>
 <3c6c5be1-fb8e-4bf0-9f58-cfb09672e8c1@kernel.org>
 <d999bc26-9bb1-44a8-92a3-bcbe14c5a1c3@gmail.com>
 <58ada5ce-5c02-4ff5-8bdd-d6556c9d141f@kernel.org>
 <60989c44-6d16-4698-bf3f-b3c5dcd7b3e0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jx+3ZNiSsvvmJVwf"
Content-Disposition: inline
In-Reply-To: <60989c44-6d16-4698-bf3f-b3c5dcd7b3e0@kernel.org>


--jx+3ZNiSsvvmJVwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 07:05:24PM +0200, Krzysztof Kozlowski wrote:

> Dear Daniel,
>=20
> I see some contributions regarding Devicetree bindings which look like
> efforts of some mentorship programs.

I noticed that the 2024 dt-bindings gsoc wiki suggests using the wrong
dual license for bindings:
https://wiki.linuxfoundation.org/gsoc/2024-gsoc-device-tree-bindings#propos=
al_1convert_device_tree_bindings_to_dt_schema

The correct dual license is "GPL-2.0-only OR BSD-2-Clause", not
BSD-3-Clause.

Thanks,
Conor.

--jx+3ZNiSsvvmJVwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZk47RQAKCRB4tDGHoIJi
0qOyAPwLqd/JJspMHeekSg1VxAHTewHeZ8YZLplMr9vs7N66xwD+KfNAXW9sKiaz
GPxTB47Xhsox5m0ATtFEIFYrvhrbhwI=
=51/Z
-----END PGP SIGNATURE-----

--jx+3ZNiSsvvmJVwf--

