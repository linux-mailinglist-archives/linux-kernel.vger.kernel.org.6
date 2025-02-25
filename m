Return-Path: <linux-kernel+bounces-531555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE2DA441C7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8AF16C817
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C14269CEC;
	Tue, 25 Feb 2025 14:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awUFXT9N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851961FC7D5;
	Tue, 25 Feb 2025 14:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492396; cv=none; b=sCZ9NfF7rfU8IsYDvfL8WSblkjtsd+1ileKEFUaL3huGK7LCr5z3vCH8XlogBtuaT7FUEDt2+PGh1lrp39V/lR/Uv9Q3IAPdc+GavLF54pd4R4a0zTnxiPIa17JQt/vSJd1h70TAnMG5/ZKshVWMuup8kyZEzq9zMysMOliGBzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492396; c=relaxed/simple;
	bh=5p8g0jn/H6LJ5TXlZMtN4+RQEgxn/quDJzMY5IiihGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iB9skkrpPkMWrlH3XcnO9Nir2lt4IlI5Eo/X2HjNAurVK2FF+2IfW4VvP6oUpZq+KW7Dn4nII0uN0IMCChvvhBvo9Ja2YmJgnUESGiLJu+Sn6IPsYqvf5w5NX2UqEpfImEtyM7nq+hEf0ZFgwk8lC4EtOeKGHHYVNs6gFtlXONI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awUFXT9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FBDC4CEDD;
	Tue, 25 Feb 2025 14:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740492396;
	bh=5p8g0jn/H6LJ5TXlZMtN4+RQEgxn/quDJzMY5IiihGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=awUFXT9NLboiavoY9ijieTyGuvgKAA3TiyEDv8/DfJhkyznEwsPUCpb1DL/F56zOo
	 O6yDJLgaaqF3WEYlBl8qvZud7rSBZ+e2UBUJFW5beaCemISY+WywEFNysjc15mfP2+
	 Jvk7SAiUF/lYQLdyy7QjqzcQlm8xNhVGBas+h+/qmHQHOJ1+Sp8/G08tojI+VjnFCX
	 3HwkD1Ez/c9Om7DFpAzDHHwU30fxH8sWN2McP8SifDRUTtma2NruqhEjaNK8bQ5+G9
	 lWlIkWUIGK/tk6LuG+WovMUSKjDQNVSA7lgWsPafoMmUif6hP/alF8cKBltvSiIlEy
	 FCHG5FYxZ9mbQ==
Date: Tue, 25 Feb 2025 14:06:31 +0000
From: Mark Brown <broonie@kernel.org>
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: regulator: add adi,adp5055-regulator
Message-ID: <cf90cf64-202b-456c-9a9a-ba33d0e68961@sirena.org.uk>
References: <20250225-upstream-adp5055-v1-0-a5a7f8e46986@analog.com>
 <20250225-upstream-adp5055-v1-1-a5a7f8e46986@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cwPN3DqgCIzTZZ2R"
Content-Disposition: inline
In-Reply-To: <20250225-upstream-adp5055-v1-1-a5a7f8e46986@analog.com>
X-Cookie: I'm not available for comment..


--cwPN3DqgCIzTZZ2R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 25, 2025 at 05:08:33PM +0800, Alexis Czezar Torreno wrote:

> +      adi,power-saving-mode:
> +        description:
> +          If present, enables power saving mode for
> +          individual channels.
> +        type: boolean

We have standard mode operations, please implement those.

> +      adi,output-discharge-function:
> +        description:
> +          If present, enable output discharge functionality
> +          for individual channels.
> +        type: boolean

set_active_discharge()

> +      adi,disable-delay-us:
> +        description:
> +          Configures the disable delay for each channel. Dependent on Tset.
> +        enum: [0, 5200, 10400, 15600, 20800, 26000, 31200, 36400]
> +        default: 0
> +
> +      adi,enable-delay-us:
> +        description:
> +          Configures the disable delay for each channel. Dependent on Tset.
> +        enum: [0, 2600, 5200, 7800, 10400, 13000, 15600, 18200]
> +        default: 0

This looks a lot like the driver should implemnt the enable_time()
and/or set_ramp_delay() operations and use the constraints to configure
this.

--cwPN3DqgCIzTZZ2R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme9zmYACgkQJNaLcl1U
h9Barwf/fTcd5fyS9EAHbBYRAXg0QdNpGeZxnN+qwMc7wLEUl1KielZIfwTi1OuK
SoxCfX1FwRRhWSXpCGcBqQd+fwKbYSY0Xqn2sYPqUr8NhPMxg5kpkD/dTSJ8biQY
Mm1fv/5xZhdmwyJkFqWzVIUJpSsg6+9DZ9ctpIUfU1Z3EqrQIYFUQVlbzHFXQPi2
lEADEeMYrgCLr0p2hV2lWLHu+6s6dfGSRhXOzKytEMjGpvW1vxBbTGKX9vyuLxgi
IU/MGCXJZu+TfARUvnkq89cJZj+HkBy5t1LEnRJwCl1j1djpP8xtTzLVaFm80Trm
MQIPbKOCgUOXWl7K+oPY25InBr2R3Q==
=Awj7
-----END PGP SIGNATURE-----

--cwPN3DqgCIzTZZ2R--

