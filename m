Return-Path: <linux-kernel+bounces-283426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B726694F292
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673431F21945
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25B418786E;
	Mon, 12 Aug 2024 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUXUll5c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212D5186E3D;
	Mon, 12 Aug 2024 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723478863; cv=none; b=Sovscmb1MC4g5BnqX/Y2HaITy3lsL0l+tHx32M3F2R0Yoa9/1FS9fQabZyT/s0VEyuEQJL3LNYlsGjhIxQl+fbkidlvOuFxAVGkcaDsJGBNvCh2bc1fGStntDs8BumsmEzpYRPdOsS0IQabTrTqR7Ijy6C61OmgRLOlPb5Hxo3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723478863; c=relaxed/simple;
	bh=xtGm+PnqS9zMeh65xDDKfq7qKoHUSOzcfLhggZPCYKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpWI3JeVdWL5PugHPI+RuXCk3YcuqwV8jJipU+8TewXxXZ8YieB8fEq7/Mo3/R/nMzPmdF51H1eW9no4WQ4gq/w4Xb+8Ogqq/GSJYSiGeUTr1OXzXjTpzvMTj5DUBXpJrtWdsSWgMTSuTk44YWtAXtQ3UG2vFK39q8Btgv6ihpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUXUll5c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1471C32782;
	Mon, 12 Aug 2024 16:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723478862;
	bh=xtGm+PnqS9zMeh65xDDKfq7qKoHUSOzcfLhggZPCYKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NUXUll5c/CSjhblh1/IJtpDqNS+BdK0g6MDSMDmOZBfMT0u4Ff6Qjn+pSIYtSiaw1
	 Z686FVneDVc+oBB18x42O9O0GsjcsC1rZ2FEF+awWtzu0vcL8aA7RIdkN8Ob1/4X7f
	 fR/NBqM9NYh+v6tWGrTS91NvQSyceg7zsXHBtAJuc8vHyvfqH/lUk950AKQt7szFae
	 j+CR7Xy4RWKcxQg7Fch9CqEJibgeTbK9LtNhzmeatrggmID42rwIwMREKhDJNVNO7V
	 jXTItXbWpwVPVdAbtxySLNqevoLFZ4NHZD7kVrET1VbprDgK0NRW0DCqQNcsBKfTSS
	 hFdxEDGrt6pUQ==
Date: Mon, 12 Aug 2024 17:07:38 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: fsl: fsl,rcpm: fix unevaluated
 fsl,rcpm-wakeup property
Message-ID: <20240812-shrapnel-treason-03ed1d6b49c9@spud>
References: <20240811153507.126512-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qepN/n4K0ZLCBrZr"
Content-Disposition: inline
In-Reply-To: <20240811153507.126512-1-krzysztof.kozlowski@linaro.org>


--qepN/n4K0ZLCBrZr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 05:35:07PM +0200, Krzysztof Kozlowski wrote:
> Drop the RCPM consumer example from the binding (LPUART device node),
> because:
> 1. Using phandles is typical syntax, thus explaining it is not needed in
>    the provider binding,
> 2. It has 'fsl,rcpm-wakeup' property which is not allowed by LPUART
>    binding so it causes dt_binding_check warning:
>=20
>    fsl,rcpm.example.dtb: serial@2950000: Unevaluated properties are not a=
llowed ('fsl,rcpm-wakeup' was unexpected)
>      from schema $id: http://devicetree.org/schemas/serial/fsl-lpuart.yam=
l#
>=20
> Alternatively, this property could be added to LPUART binding
> (fsl-lpuart.yaml), but it looks like none of in-tree DTS use it.
>=20
> Fixes: ad21e3840a88 ("dt-bindings: soc: fsl: Convert rcpm to yaml format")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--qepN/n4K0ZLCBrZr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrozSgAKCRB4tDGHoIJi
0n99AP4k+jo0HIAm3yUe34ZbYrr+lBZIK5GnzwPCmxrJygD2CgEA/9T8i4JsN8yG
WAetWYv+5wxC3MTm8AeHkGrG3HeydAo=
=RSNA
-----END PGP SIGNATURE-----

--qepN/n4K0ZLCBrZr--

