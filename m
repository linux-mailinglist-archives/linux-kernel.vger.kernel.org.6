Return-Path: <linux-kernel+bounces-257395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF64D937968
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C02E280F8C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7871448EE;
	Fri, 19 Jul 2024 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0jemaZP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173CE63D5;
	Fri, 19 Jul 2024 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721400984; cv=none; b=UXBE6ctvQWpG2y1zi+/c7/0FEP1B6dZypZh6a4A5GEdtJ6B3KsVINOdZcKEdN+G1jiSru1abk8f2EF02/Znbz/TTUUUgjIivHbyC5v+nJMtq5e2liEe5DM6NRwNbkaIerZfuJC1F94WjGQc6xMFuueG19/zTIInhikAi9FR9wAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721400984; c=relaxed/simple;
	bh=O4VyP2W3zOx8GnJ6GGdeDrEQ0pQ9+VnTxkj3ZXK45K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fo4dBJ26jXZ2ySB2+B30cN8Il7/VG+MQrOwzJyqlLluHLDg6AfP4HogIAk+73vMq9gQv567YKDaLfG2iuqEe69zMafFoB9YxQ1KRBtgGJE1Sh8D2ocszoYtuGPrFD9dvmDW0xFFBQc9Nqo6aJLvhRjhfXO/03iU03s7h1KVyt3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0jemaZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C00C32782;
	Fri, 19 Jul 2024 14:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721400983;
	bh=O4VyP2W3zOx8GnJ6GGdeDrEQ0pQ9+VnTxkj3ZXK45K4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k0jemaZP5wjp3mEEiFLCCM/9U+enircAvC6L6HVtSrOSoCYvQ7i1QDvnv54UiqHVj
	 0uxEoXD0X+wYz7X5xkspXENPNSS6C3c3yVnQ8e2i9I02dFsrEa1y9WuvhhecbWTHuA
	 hdC8geb0kUyiPaBTTa5BCLwr0uwBWvmUZ+F+7LvZN86X2l5r2KmNRzKx2P5fggiHbU
	 Fz7f2Q6NJLuRM4aZ3IfqNfvxhSGOeJHX/hv/Je0smz8xbuhcCFRqGq6dWBYEc3Z2/N
	 0HKQgPPOOOOFcJwNYvCa0c3qn3jqwQyEs9qdKorRzvJxY1F2WyuyTyc9Vc9vL3Ta4Q
	 7S5hGiyasdHiQ==
Date: Fri, 19 Jul 2024 15:56:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: clock: axg-audio: add earcrx clock ids
Message-ID: <20240719-whenever-wanting-bf631afa4663@spud>
References: <20240719093934.3985139-1-jbrunet@baylibre.com>
 <20240719093934.3985139-2-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tN+3GRhTz2+PxInK"
Content-Disposition: inline
In-Reply-To: <20240719093934.3985139-2-jbrunet@baylibre.com>


--tN+3GRhTz2+PxInK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 11:39:30AM +0200, Jerome Brunet wrote:
> Add clock IDs for the eARC Rx device found on sm1 SoCs
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--tN+3GRhTz2+PxInK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpp+kwAKCRB4tDGHoIJi
0j8WAPwOPdUj59+e34f5LjrClNS9PlsaIwClbL5o8IH1WiCsmgEA6vxkUeYWF2D5
7qSl94g+GTRwcPCJr3bhHsSBE0J5zwY=
=lfNB
-----END PGP SIGNATURE-----

--tN+3GRhTz2+PxInK--

