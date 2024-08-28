Return-Path: <linux-kernel+bounces-305336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CC6962D20
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F87B284481
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B32D1A4AA4;
	Wed, 28 Aug 2024 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iE6l7z/Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5A834CC4;
	Wed, 28 Aug 2024 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724860840; cv=none; b=oi19ZK9sOF9xEH/e453sG6N9+CuaB+CgEuW7DvBDArovlEJ8Gkv2yLyo/KNA3ezhjiMC9uu5UvO2BSW9nR7U5sLjGIed03PAB2XLsCghTxEPXXeA4Ou01q2p+VsFXlPrgbwun8eEOS2j9sJwPHGKMwvBkqEGeA1b4Fh2yQaFKFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724860840; c=relaxed/simple;
	bh=gpthfaPiNOiFnAxDD96UbfcYTq4HbUN6qQAbihWPC/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/1SJHk4HbPQ4sOSOBNy8ST5HBG88UeInaN4tvl3d4Jqrz0vgV4CecqKbpQJ4Z6gqu1eGQn8HvVGKuiw/SRxrstn/b/927rWuCHONm+vuOtukO5Hc+c7hBIq9V14O4ks1qL4oYV3lnfKbm/66H6lfaS5brjts38HOfUvaAULLvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iE6l7z/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C71C4CEC6;
	Wed, 28 Aug 2024 16:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724860840;
	bh=gpthfaPiNOiFnAxDD96UbfcYTq4HbUN6qQAbihWPC/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iE6l7z/QRfxocESGvhxDjTc/ZHq9wUy98SZTFOeiiuNRrMVicHbTwj22YexzFyoiD
	 YAqncJVrypKbdLQf9yrMGkCLyuPkZvdfLswgXgtH6TJQwxkmXiEZWTE9eIawnFKUTH
	 2xSv2FZiuz4zwfM793WILf9+3J6gy+O58ifCiJ5Cd9obVTxbjf9XO0AMmGkkaJN7z0
	 MdOD6FAVnZcHnkyoxkDSxFxW73/JB+CoVq2degoNVXF1LXRRQVA6RCJMmRqrifnx/I
	 S8WXJ/1yvraqS4guEhVdev3cGvI4bV24035zJprybMCvpXjq7Vol/OKP84jVvgLPzX
	 fAeb0QHB9Sv8A==
Date: Wed, 28 Aug 2024 17:00:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: psci: change labels to lower-case in
 example
Message-ID: <20240828-unbraided-runaround-70a98ff29f24@spud>
References: <20240828064919.79625-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="P/XHFMBwvHP/5q8q"
Content-Disposition: inline
In-Reply-To: <20240828064919.79625-1-krzysztof.kozlowski@linaro.org>


--P/XHFMBwvHP/5q8q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 08:49:19AM +0200, Krzysztof Kozlowski wrote:
> DTS coding style expects labels to be lowercase, so adjust the example
> code.  No functional impact.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--P/XHFMBwvHP/5q8q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZs9JpAAKCRB4tDGHoIJi
0qSjAP40tld6jLrgDMfdyMGa6e9rLchinFN2k8fcYYiCQM2i3gEA8PJMNK3Gcbmg
Vw76rc+EAsMpghDiEKmQxBVjEM6/Gwo=
=S2N3
-----END PGP SIGNATURE-----

--P/XHFMBwvHP/5q8q--

