Return-Path: <linux-kernel+bounces-321616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F70971CEE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19CAA1F23A3A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052DC1BAEE5;
	Mon,  9 Sep 2024 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNGJOFTM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BB31BAEC5;
	Mon,  9 Sep 2024 14:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725892875; cv=none; b=lw5NvZl7O8ax5dPheEErqOAa11Whoii2ubOG57PGo/NSJT0rsTYaXKb95AzR7p0LyO0VbJe1qTN8SfrVQTWPV0zrzImB7uKhqG1Uobn3aGhRRjhp4jSipkIE1hz0TVI1Q1R9Pegv4Qw7XP67eVoivj22hLPoPxGQ1waoN7cM4qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725892875; c=relaxed/simple;
	bh=1y8PCM0+xf2FYmGsqFR3yxA7UdaRT4ZnVX9hoTW957Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGKF9NORX8i7vXzFPR6EY0yV52pZyGSFnuMaXITlgrg+QK2pJcAXf4lyr48DvgzLmHvlSlNahnKf+nWTcNaqJBj6JdfdbFjcAtylW0QGeHTA7NrU/Uc544+NjFIb+MLhEKz4OaGiCfcM/suNtsRgjjAHbyYSSqHSNtvNk/aG8v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNGJOFTM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89E2C4CEC5;
	Mon,  9 Sep 2024 14:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725892875;
	bh=1y8PCM0+xf2FYmGsqFR3yxA7UdaRT4ZnVX9hoTW957Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nNGJOFTMog24mI5/ZWN5C41cBnMQW58iRJPehgBbxbiVE8FR6Oks/4O3pVDaSH+nQ
	 NPurmwGtKY+nIWDFKRUkA28wXGAN3zLNUkHu9Wvoae16GLz7FomdAg23RyUlHUPZYg
	 ScFeACzjitysaWeurr9h+MVS3NRvyQMcdIZcp8euluUu3R1aFuuv8rEPDKXQZeTmhJ
	 U1mLZjwhyB4O/nyqsu71Gbd70JFvk8DcE2uM26AjpJOxJhYEW/4VhP6LF8CXcEYVv1
	 l6WJnPoCqGP/f2TsDjaWJxqEt+fcYCG7HIwh4yy8+nxWKIegXSxslYIiKFN9LeKh7N
	 j3rKNdOCQYk5Q==
Date: Mon, 9 Sep 2024 15:41:10 +0100
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	Haylen Chu <heylenay@outlook.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] riscv: sophgo: Add pinctrl support for CV1800
 series SoC
Message-ID: <20240909-prowler-renewal-0592d820ccca@spud>
References: <IA1PR20MB495374DB8C4208575AAC9675BB972@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PqXotlc/4udQtDqN"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB495374DB8C4208575AAC9675BB972@IA1PR20MB4953.namprd20.prod.outlook.com>


--PqXotlc/4udQtDqN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 06:38:40AM +0800, Inochi Amaoto wrote:
> Add basic pinctrl driver for Sophgo CV1800 series SoCs.
> This patch series aims to replace the previous patch from Jisheng [1].
> Since the pinctrl of cv1800 has nested mux and its pin definination
> is discrete, it is not suitable to use "pinctrl-single" to cover the
> pinctrl device.
>=20
> This patch require another patch [2] that provides standard attribute
> "input-schmitt-microvolt"
>=20
> The v4 version is from [3]

Which version of this ended up in linux-next? I see a link to v4 in
what's been applied, but this v5 was sent before that code was
committed.

Either way, what's been applied and what's here produce warnings:
cv1812h.dtsi:19.28-24.5: Warning (simple_bus_reg): /soc/pinctrl@3008000: si=
mple-bus unit address format error, expected "3001000"
cv1800b.dtsi:18.28-23.5: Warning (simple_bus_reg): /soc/pinctrl@3008000: si=
mple-bus unit address format error, expected "3001000"

It's just a copy-paste error I would imagine, but please send a fix.

Thanks,
Conor.

--PqXotlc/4udQtDqN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZt8JBgAKCRB4tDGHoIJi
0itfAQD50oTyzE/z528aScYrZw8gsOkRqQOpJWt0O2z2mrgT3AD9Gu9csCU5kBqQ
/HIkdqjVENjC4ads15qgWwinG8EbIgc=
=YoNT
-----END PGP SIGNATURE-----

--PqXotlc/4udQtDqN--

