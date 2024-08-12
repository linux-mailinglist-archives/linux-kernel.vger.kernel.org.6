Return-Path: <linux-kernel+bounces-283427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEAA94F29C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C832EB21E5E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570FF18733F;
	Mon, 12 Aug 2024 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGYwTBQ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E911EA8D;
	Mon, 12 Aug 2024 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723478889; cv=none; b=Ez6AkWs2W3rZdghgzYC5gIawMm7kQEMfbWWtgr2D/tzoxXwRfmE/aqIv0xde033hpTI+k16Crui7duZ60iQfJXnSRtKDj/CHETPMXvyymzO7kfLGIoRjutb4bTFVZwZCk0+nG5T0A2dtuvorTDH8uhHvSKLV2TfCUnkhJONZZck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723478889; c=relaxed/simple;
	bh=L0E1tT7pY2TMGLKXQCLiFYuVphFXk3nMv1X21i+KGQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWDKRYRvV7nIlOMPoqQzkedwOL34xxk+m33ebAW5qP9t27BHQj2Prfb/FqNfR+OTMc+dfEoVmH3U8wPd73aKVGIjy9+aCglayac51xkkzFUyHXe0rDllIDysrxvSNZNYCqBgv/Jdwmd0P/+VWqRqUExXRBH8CVDuVsMC0XsjUlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGYwTBQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA121C32782;
	Mon, 12 Aug 2024 16:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723478889;
	bh=L0E1tT7pY2TMGLKXQCLiFYuVphFXk3nMv1X21i+KGQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aGYwTBQ6mh6DphbQRwh7glFEYWj1jJe1gmYCGwI/V1ISjE6gPgfdI2hOuqYopcnM4
	 zf5/CljKxwCr5onJJ8lYs7VeupOOg/lPEhLjgOFW1rm3vhF37TpYaiMlxglI61bcU0
	 Nj36AnA1LBfdSuvraySA6zOWuQ9SvbVGbYWweMqDKs03G0CaQUfiIIvJeYRw3Brw6R
	 eimEZqpYzL/bKOKLQSWC4kMZi6XHqmLhbSoIxzMddOruvkN9qoPNkw8EFLU+qnaKL6
	 V++tUWdbmjRSEZOhPVZsBZPphmbdYJ2v58wPlInGlm702PmwagJtddzxIXUZ04cMtV
	 Y0G1Tt7lIEJ5g==
Date: Mon, 12 Aug 2024 17:08:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: nvmem: st,stm32-romem: add missing
 "unevaluatedProperties" on child nodes
Message-ID: <20240812-rewind-detail-d1d2b43af88d@spud>
References: <20240811151737.106194-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uAHQ9qS2Rkzz9BdF"
Content-Disposition: inline
In-Reply-To: <20240811151737.106194-1-krzysztof.kozlowski@linaro.org>


--uAHQ9qS2Rkzz9BdF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 05:17:37PM +0200, Krzysztof Kozlowski wrote:
> All nodes need an explicit additionalProperties or unevaluatedProperties
> unless a $ref has one that's false.  Fixing this for STM32
> Factory-programmed data binding needs referencing fixed layout schema
> for children.  Add reference to the NVMEM deprecated cells for the
> schema to be complete.
>=20
> This fixes dt_binding_check warning:
>=20
>   st,stm32-romem.yaml: ^.*@[0-9a-f]+$: Missing additionalProperties/uneva=
luatedProperties constraint
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--uAHQ9qS2Rkzz9BdF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrozZAAKCRB4tDGHoIJi
0hmFAP9TybaQLB2/f/La+yrAEyFvjA+jQs7Nk2vduhmPvyo0FAEA10QHCY6cQRke
hOa6D+LkOwmIC5z75nvcr0wMopQG8QQ=
=urD/
-----END PGP SIGNATURE-----

--uAHQ9qS2Rkzz9BdF--

