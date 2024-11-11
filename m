Return-Path: <linux-kernel+bounces-404708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B30BF9C470D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6411A1F25098
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C191BB6BE;
	Mon, 11 Nov 2024 20:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QN881zKS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4D51AFB35;
	Mon, 11 Nov 2024 20:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731357589; cv=none; b=kkC7GCql7zMF7CVqZ16yBhbS+AWo7rf37g43jBGeZ0tJPjqdYO3+O5FwKfWtwa9NJY9B2M4AnUlW6DDHuys6ZjaajMFPYog7Qn3tq4HIG3poSI0CqoIprJuC1WuIiyxwrSigYornCph2Nb081Hd4SADpJuSCZfgFU9BitfmXy6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731357589; c=relaxed/simple;
	bh=ftDw5gj4OX0ZX2AWggS6ZGbu3W01ORpuvQpfE7Hwv6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RacExYVAC4zKqDLRdNIkb5BIlEEZd8m9JMeAnVLxsX48Onx4BpeDcEMw1Ck2fPyF9ReVY0+Hv6KJvYP3mAeGA4txoN2lUtO4wOOS5UsL5dOUelRuWlQFxHtVJNXyh8dIPYje3qo1v9x/W0RdVMRM39SQH211l0rdzacEaz+lsKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QN881zKS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9668C4CECF;
	Mon, 11 Nov 2024 20:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731357589;
	bh=ftDw5gj4OX0ZX2AWggS6ZGbu3W01ORpuvQpfE7Hwv6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QN881zKSy8AnevXU94HIdRkWlYDZ1ubm2eedwnzzcUzinFFF/CFsd7RiA5RUeVnjV
	 FGYB/eAc1wY8LIXwsO4h84ITzTbJS8dfAa+3ksQgjWZyTtgUMlw0EEHx9ofUqU8ruv
	 PK9kBZGae5+ufWhNGEPcSLJ28sVurdhz8nTw9F/FsGJrp2JFEEAeoRja0eRBH29KHV
	 pect20WQttAh0pJ9yE7clknWmGIIvSz7oB2m7QLf0uk7ODSNcudxD4htyWbIOnCb8U
	 J+/8wY1+NZXEuC62Agn6VtoDH9E75a24OPrAk4htmZfRQGsD79Xx9gNEoHUaDSvAYv
	 bnpRqKAJxq/Ww==
Date: Mon, 11 Nov 2024 20:39:44 +0000
From: Conor Dooley <conor@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/14] dt-bindings: arm: sunxi: Add Avaota A1 board
Message-ID: <20241111-unflawed-nativity-f5c25cb3889b@spud>
References: <20241111013033.22793-1-andre.przywara@arm.com>
 <20241111013033.22793-14-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FQrGi8tboct4VcBk"
Content-Disposition: inline
In-Reply-To: <20241111013033.22793-14-andre.przywara@arm.com>


--FQrGi8tboct4VcBk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 01:30:32AM +0000, Andre Przywara wrote:
> The Avaota A1 is an Open Source hardware router board using the
> Allwinner T527 SoC.
>=20
> Add its compatible name to the list.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--FQrGi8tboct4VcBk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzJrkAAKCRB4tDGHoIJi
0gs0AQDcHH0lqvHvvyzDj2HN8e60RgpmVUImioduTNl3J/oMNwD9GfcJxYVrSAz0
k05tYZzb0T1k0tRsTAVWuIroTF3IbgU=
=DZjw
-----END PGP SIGNATURE-----

--FQrGi8tboct4VcBk--

