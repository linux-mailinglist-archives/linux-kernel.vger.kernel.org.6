Return-Path: <linux-kernel+bounces-231074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 645EA9185CB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170AA1F26F55
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A692118F2F8;
	Wed, 26 Jun 2024 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0G6ftgT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FD318F2EE;
	Wed, 26 Jun 2024 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415695; cv=none; b=oG2Ialg1SSl4XoZzxrP/oj68ZL+VV8wJ9yvgtaIvnXl4hadBM7cnTJkU9FS8o9TNhe8YMC4UVWDj1BJ2UgiuZIQACRyXdFMTcitROrsWD+8p/413O1E3ERjZntOaXfORTAAeseOsbM3f27BHnZ8BADfcYjWK14LgPONIKJbVPRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415695; c=relaxed/simple;
	bh=tFhf50VxgCVDRMaLLZ7bIRAbv+PYecT8vC7dzG/iSmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQEIO4BNA4ZWyRSpIkoj2XfvpC8Osm9GNFASPJpMwdwUT61h2ygZFtwG/2d1d3Vcw9DmJY2Dgt2rBgWNeQfIeJrC8/pGdSn3yoJ5Lg0ZT9rdzfHWigOfMc42GEQdaxkRjcdNe2UTs66DCHCm6M92/0iBhqJ/nNnRmpa0UOMZmFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0G6ftgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0FBC32782;
	Wed, 26 Jun 2024 15:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719415694;
	bh=tFhf50VxgCVDRMaLLZ7bIRAbv+PYecT8vC7dzG/iSmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q0G6ftgTuTPQqoEuVcoCvm920j7zLNyTQC8JVpkH/ImDnIvXzYKt/Y9nRTHZpaG5X
	 LtdZisRgt8DcsKabOWn7WLEDL302SH2YPt2oLRJzj2CgElllX8AuiL2+ZhR2snNE7U
	 1Waa3zQuHUoAgwhs20d23TbvuSD8N/qBYEXtpft1wEoQq+F6vuqWrr/kW1Dmj32EoL
	 heXvcXAABFM5UN7KDExCLwrhYSsEVatxkTd8kljusdvU9ZPTzkbdAK79TprcDuwXB6
	 ke7yztkXBdWHMYcqr4wSyYCtAoJkskTazgOnsbHCxUc+zVJ2k4ofgSKwfcHpQw8enh
	 bhb+VdB4MAXOQ==
Date: Wed, 26 Jun 2024 16:28:10 +0100
From: Conor Dooley <conor@kernel.org>
To: Alex Vdovydchenko <keromvp@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alex Vdovydchenko <xzeol@yahoo.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Add MPS mp5920
Message-ID: <20240626-fox-turbofan-2043195a11f5@spud>
References: <20240626142439.1407175-1-xzeol@yahoo.com>
 <20240626142439.1407175-2-xzeol@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ziKWwK8V1pwVfHbP"
Content-Disposition: inline
In-Reply-To: <20240626142439.1407175-2-xzeol@yahoo.com>


--ziKWwK8V1pwVfHbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 05:24:33PM +0300, Alex Vdovydchenko wrote:
> Add support for MPS mp5920 controller
>=20
> Signed-off-by: Alex Vdovydchenko <xzeol@yahoo.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--ziKWwK8V1pwVfHbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnwzigAKCRB4tDGHoIJi
0gPrAP4iXQJRtv9v0s2wMtpjVIcMPJdlLGSlQXH8nD7fj0YTtgEAxDK9HUJhqu0m
tAYNYPucDMSaWwbgwI4LGf5noOIWoQQ=
=Dnxc
-----END PGP SIGNATURE-----

--ziKWwK8V1pwVfHbP--

