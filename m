Return-Path: <linux-kernel+bounces-179830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C608C661D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3344D1C21AC1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 12:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71F274407;
	Wed, 15 May 2024 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTj5JXde"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03341219E8;
	Wed, 15 May 2024 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715775037; cv=none; b=jGfRLtSOQId2zwVDvmIEWrWvH+8zbRGQakPZuMBCnw6ffMqWElZucGnJO0y/WfBBafuqgtaJaq2MLm4et/uspQkEkX3ttAwQ1ImmpLShLfIVTeU8hZ6hGhW6tsbLYPjK2oWhtQlENr1l+YQnNpzo95DW3IhHIacyxnbLruHmbvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715775037; c=relaxed/simple;
	bh=qQxML4MZnARv3Z2b6FuMOQyd3ZUvitO3Ah4OB5i1l7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWNMcP4CQf6dUyqHh+McgKm83d+DPDsr2qoOXG4cEjnSD2GPCL7PsTCXxBHpIb5HwC8NrzUka6qmYS/8QHJOGmue65orw/ZM2S+uhkOBijPIP9Gqq+7LKLv94F+xIVJGGyMv7Hm6qp/7IDq++wf2UjtUpWTx1KYqj8mQVGbGBKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTj5JXde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EC9C32786;
	Wed, 15 May 2024 12:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715775036;
	bh=qQxML4MZnARv3Z2b6FuMOQyd3ZUvitO3Ah4OB5i1l7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jTj5JXdexmn/0ahw3hCXJNgvnXtr4Daq0xkuiSbTdhtIBacxfCc70qmkOQ8F997rt
	 LoA1OMQy028S/6Wyuyvae2Go6mTLz/jduzaWHSDWUFQya6Ie/FLZc9tVqmDjVKHSaj
	 M39lkgwE08CmZ9D7YOmbDImx/+bKltLX0KNKMzUYTiHaxaiDWXBHSL/RGPflr+J9BR
	 6GXsrw9B/+5v3sry6qQm4jK+xgwlr1RIwHE5PvBLwezfVDcd3VjZGZPW+qs3L5fau1
	 0wErANretlJxfrtHGt0/IsMJZO2f3tG2Hh5qz4Jdvk0IQMcPKClDOodqvtJLKH/vHt
	 epG1qQblSbHsQ==
Date: Wed, 15 May 2024 13:10:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Alina Yu <alina_yu@richtek.com>, lgirdwood@gmail.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, johnny_lai@richtek.com,
	cy_huang@richtek.com
Subject: Re: [PATCH v3 6/6] regulator: dt-bindings: rtq2208: Add property to
 get ldo of RTQ2208 is adjustable or not
Message-ID: <90d5efcc-e85a-4daa-81cb-a877c4b8fff6@sirena.org.uk>
References: <cover.1715340537.git.alina_yu@richtek.com>
 <6a3a90d9aa2022dfb92e124e417f3e72c2f28b0b.1715340537.git.alina_yu@richtek.com>
 <20240513-tissue-repave-13d2e3bf88fd@spud>
 <d97752ed-4032-4681-b28f-17f149fdc3d4@sirena.org.uk>
 <20240514-plunging-chair-803d9e342e6f@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QIiOGJPNoadFqFau"
Content-Disposition: inline
In-Reply-To: <20240514-plunging-chair-803d9e342e6f@spud>
X-Cookie: Oh Dad!  We're ALL Devo!


--QIiOGJPNoadFqFau
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 14, 2024 at 07:01:21PM +0100, Conor Dooley wrote:

> It also doesn't seem like this sort of behaviour would be limited to
> Richtek either, should this actually be a common property in
> regulator.yaml w/o the vendor prefix?

It's a pretty weird thing for hardware to do - usually if the regulator
is controllable it'll be qualified for use within whatever range it's
variable over and not some other completely disjoint value.

--QIiOGJPNoadFqFau
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZEpjYACgkQJNaLcl1U
h9AQaQf9FRIL97KP2WvU1BzIYHUi/ili3Tpv3U/mZScKR47EXY/gLSLeXyaPCI/u
/NzQV7TeJZZ6UpLzBY23ynA0xGZXSBmTmIaGNCmlJf9nnZ0UAH7bLquHCJPB0NDd
EsGzJTgNX5dOvZeFJ5eT9XIdabDxsWWsvotYIwW3TJmApBctw58wKRAfbwPs9Qms
ra0bjrqcx5TXOYldAZw3Avaew6eJ6pHpL5zYGXFtUlMOO9BvpmjLoI4Y77pykYz1
jlYBwmBEmAH4zTMSlOm9XqQcwCxEd+b9TAB1bxP9ZA1HsEq9PKffMQnMftxMtHjl
R1NcFJ9kVFWWzMx/Ui8UCB6WaV9Pww==
=4cJk
-----END PGP SIGNATURE-----

--QIiOGJPNoadFqFau--

