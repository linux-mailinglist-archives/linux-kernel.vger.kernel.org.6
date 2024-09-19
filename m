Return-Path: <linux-kernel+bounces-333178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FA497C4F3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 732A7B210CE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 07:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD9F194C69;
	Thu, 19 Sep 2024 07:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJwOu/NN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEC2166F31;
	Thu, 19 Sep 2024 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726731430; cv=none; b=JDV/6PtCx4MZc/zXuO3ihDpjn9NgmEje0pS/IZkKx1XNK8JCF9+a3V1PzsP/S+gZlGqFep4jj16nbujwzdCPnt3OT/k17I18eGhd3xzKGJGT8Gm2PMDShmWWo4hPBBDBBxdnmeNLwvjxqFBQ7EwormQ1sdqjAHVTqvELL8g0EFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726731430; c=relaxed/simple;
	bh=4QKy08zf+xeNkkt8xnmcf7Rr59CLcc5i1MsoEESsjfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tf54au436GD/KzrQzGqZ8eZAl4UkAn+NcTph0CeqUs5wh1tjeR7LOOd7ox5+M2Tg05vyjqFOkV6npZU+StNapjQZh5Upt5rfn9l/aFD1R9EwKwhWqj0EzPP3nWD/T3WYEPyVo7BfgULOt64B6drXTh6dttmnZmrHIhC9CuuDSEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJwOu/NN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CACC4CEC4;
	Thu, 19 Sep 2024 07:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726731429;
	bh=4QKy08zf+xeNkkt8xnmcf7Rr59CLcc5i1MsoEESsjfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JJwOu/NNV+jj/kFaAjAecE7f7Af4h8b6kFD5PXCfPSw4TZG8H4yTQhPuq+535I+pl
	 KK8lwRmMtSHTCUAAREfBdvJyiz+i110vkEbnOXVZAlsqLpwWEGlkLePhP2vM2JI32h
	 hooB/AF7GgaPQlneNAbnt0fGrs/XfOvl8ufQLoaJvYt8DNONHGcetnTndDAEUAY+ee
	 J5QQVBD2UiV7M+qc5aKdhhywqJHSaznV9G7TBnb7vjS5M8xcjPU7ak2dJ4Km6yiR2G
	 XlMThwttQvh91cpJUIPEmfYhbTMCqY5TnQfZTq12fItAqWJ4urg91h04qurVZTf2j/
	 Gd27Sfgn0NO+A==
Date: Thu, 19 Sep 2024 08:37:14 +0100
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] dt-bindings: writing-schema: Add details on YAML
 text blocks
Message-ID: <20240919-bluff-thievish-9be0cdb5df9d@squawk>
References: <20240918195130.2024205-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8Zr6vVtt2eO6A7V0"
Content-Disposition: inline
In-Reply-To: <20240918195130.2024205-2-robh@kernel.org>


--8Zr6vVtt2eO6A7V0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 02:51:30PM -0500, Rob Herring (Arm) wrote:
> The YAML format has a couple of different forms for multi-line text
> blocks which control allowed characters and handling of line-breaks.
> Getting this wrong is a common review issue. Either a literal block is
> used when there's no formatting needed or a folded/literal block is
> not used when there is formatting to maintain.
>=20
> Add some descriptions of the different forms to point folks to in
> reviews.

And mentioning the # stuff is good too, keep hitting that with the
commit descriptions in the riscv extension stuff. That said, not as if
people read documentation anyway...

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--8Zr6vVtt2eO6A7V0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuvUpwAKCRB4tDGHoIJi
0ntUAQCDZzwK2lG0pdPXA8YCmuYWlyrq6JUOSeL9PnkS8V/kSwEA98ho1MR4fTQh
Rv0Pl7HFk4tpugD78KhZT1cDdv/cPAI=
=BnXF
-----END PGP SIGNATURE-----

--8Zr6vVtt2eO6A7V0--

