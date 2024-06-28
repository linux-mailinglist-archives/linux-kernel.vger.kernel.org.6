Return-Path: <linux-kernel+bounces-233880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF18B91BEA1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF2F2830D3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0115D1586D3;
	Fri, 28 Jun 2024 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNPKf4A3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440632E64A;
	Fri, 28 Jun 2024 12:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577953; cv=none; b=NHB0hVTaUKZjwTI4GgIvnE+WjgCaVY1wVUX3FJXFZ2Zrapqf18cJvM0OqzNdoA7a5y7sU1+UGfkHBsrd93FTE9tyjNduYmFe6xG7ISC+BXpEogUjPJajXKuL8qBfmDUmFqHZEdIern454yJbmpcOOcydBb17Rmnn4+fVKZ845hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577953; c=relaxed/simple;
	bh=Ha43aO+O5jHdoZI+1kv9nzT9FAFVWm3/7jHE5V8OCXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlXI17UZFot7pjHrdqwMm/8kGgeQfKxYpGHRcW+hwFQkShMXsPybQfBJcd9zu8e6h3GGiDP7hazgXcI2XRLZ5pDBzGr4Sg5m2J676VDwELBRnFGj5x2I2x8o1XCgvJ/bzGn2vPrgtrSDLrjFfoMaFdmaEKALZeNbpEXeqq274oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNPKf4A3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECABCC116B1;
	Fri, 28 Jun 2024 12:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719577952;
	bh=Ha43aO+O5jHdoZI+1kv9nzT9FAFVWm3/7jHE5V8OCXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PNPKf4A3iaA4hrrfixyi1OWjwPgHYUaY1LFb8Pm4Sg0TYfYKhzBCnz9+hQ7RJoUXc
	 QDrZythMOX33/6XE5rYDTKnOkXE6pp1/xNjJbYOzAM7KncKCnCI3OChJofq2PZDIre
	 SN7Ut8akfoc/TvlECnDXTmf3QLQSSPtBEcYcZ0l8+KmUTXZFp7c2YUwWPjqWlsfZVJ
	 lCxixFKZBfRKja+UI2zZS0brv0cM7pZQtpWvFi3znwFk8SSCUbpzx0JfplhbYBTUMv
	 THtRwfklkivGpVtAWdhTTIxVSlKPefFDv8IMIAvVas0E5rBYkHdlbPV59HLZySU4X5
	 IJSElGLWfQs/Q==
Date: Fri, 28 Jun 2024 13:32:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Pascal Paillet <p.paillet@foss.st.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Etienne Carriere <etienne.carriere@foss.st.com>
Subject: Re: [PATCH v2 1/4] regulators: dt-bindings: add STM32MP25 regulator
 bindings
Message-ID: <e0e23cac-504b-4e93-bcdc-5c7b3c81ab6f@sirena.org.uk>
References: <20240628085814.1586186-1-p.paillet@foss.st.com>
 <20240628085814.1586186-2-p.paillet@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eoY9nVURtqN3+AEo"
Content-Disposition: inline
In-Reply-To: <20240628085814.1586186-2-p.paillet@foss.st.com>
X-Cookie: divorce, n:


--eoY9nVURtqN3+AEo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 28, 2024 at 10:58:11AM +0200, Pascal Paillet wrote:
> These bindings will be used for the SCMI voltage domain.

Acked-by: Mark Brown <broonie@kernel.org>

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--eoY9nVURtqN3+AEo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ+rVoACgkQJNaLcl1U
h9BpGQf/fa9sDNcNB2MjTj0pf6Qf86Jsu58QRpw3XnmGOn1DGmAXoyo4L23ZaY8G
Y67ci3z3Sm25LXxrd5sILbJYtnuFjTYfrMeakvn6/Xf3c8OQCidTNHCi4OxOKILk
9punv8ZLiOVe7RSxLQtITSp8xhaRlCdITuHOhEvEdfdX6Z5V5YJzcRNclyRSs25U
lenNDd0LfCP3k8rYo5i1MqAzCwfOXD/sjPmsFYW7YvZ6aSSIy2kmcQKY5aJpKtzM
fe5R4XBE3bmW91/csh40cnIehZvFChKPBi95E5F38Q6YbWW+uJevWd3/CR9NyPtj
JaQ+yNriTki2RyRC1bS43VbslCM9vg==
=mBUI
-----END PGP SIGNATURE-----

--eoY9nVURtqN3+AEo--

