Return-Path: <linux-kernel+bounces-449778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 087DB9F55F6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57F9A166583
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A67A1F893B;
	Tue, 17 Dec 2024 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8TKNLVu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B918F5A;
	Tue, 17 Dec 2024 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459656; cv=none; b=bgq5Wpg0UmonUZxv69hmt41DXWxPMfYuu0ntxGRqsvzaobAeTspmQShVhuwnwrnlEmZL/zHXXuAP3QdyLs0APZnSxg4Cik6hgkXsUWSwaKkEzXLIvM0Q28X78gTgEpepaeE2mev0GWSU3lrqz/VDK7xCdxhkYOO8I2SDDOuZf+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459656; c=relaxed/simple;
	bh=yildsclURKwBrFcuZYzExOtDLbmKY9IGWCKkE4r0JCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhTGC7f64FE01oFvjjKF27W2ejKmwzRK0EO+UbN1nC5641pd/cwNM6O8Udv7a7dOVN9wqJHIdwhTs+OkPl5jCpwumFhHO7BUKWKL/ETV96z8MTnK1MEawZg2f+4IMOF8iI6bOBYxlOfnLb0nZwndCbcHJUY/nNhtp5x6U5iR9sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8TKNLVu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E710C4CED3;
	Tue, 17 Dec 2024 18:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734459655;
	bh=yildsclURKwBrFcuZYzExOtDLbmKY9IGWCKkE4r0JCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s8TKNLVu7XA5lXmycWns29seqO2hyRgVnNOPtDYIK1ZvGtRRuq3/lni9a7rj6NRwA
	 7PpxpAOIusn9wTEce/uJMivoDJ+t8Cc3myGHyo5l6Cw8DZI1J1QJSMfrPz6N0ipLsA
	 ioIkdczq83kqYRtTaUBLRAzkiqu8O2gDl0OhAQhgA/vXU/gZvuKk1xeUXBTBOnOqq/
	 QCzvGg8isuiccF9y3WIVz1BJnMjH8FvJKEIeFD5hz9gmozKkDk/FVFtlOHVAH+rn3c
	 2XI0zdgvBVBIRFYcy/81QfCNBTGKJ9R6qw136CcVzdD2qopafyyEA3mMt0jWNldRH5
	 40N1rjSlTBjTw==
Date: Tue, 17 Dec 2024 18:20:51 +0000
From: Conor Dooley <conor@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: nvmem: imx-ocotp: Introduce
 #access-controller-cells
Message-ID: <20241217-compare-craftily-94425c53b4d8@spud>
References: <20241217-imx-ocotp-v2-0-3faa6cbff41b@nxp.com>
 <20241217-imx-ocotp-v2-1-3faa6cbff41b@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xHQ/yDLv8t1eplxP"
Content-Disposition: inline
In-Reply-To: <20241217-imx-ocotp-v2-1-3faa6cbff41b@nxp.com>


--xHQ/yDLv8t1eplxP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 04:43:36PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Introduce "#access-controller-cells" to make OCOTP be an accessing
> controller, because i.MX Family OCOTP supports a specific peripheral
> or function being fused which means being disabled.
>=20
> Add the i.MX[95,93] OCOTP gate index.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--xHQ/yDLv8t1eplxP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2HBAgAKCRB4tDGHoIJi
0mqiAQCvW9eoF6N7cbHaOx0lGoN8Anj0wtcz8D/mTXwQMot4WgD+NXPCSLjx/jyI
l1ucvLcVZh77ERggFbTtxPhpmvr9hA0=
=qNnf
-----END PGP SIGNATURE-----

--xHQ/yDLv8t1eplxP--

