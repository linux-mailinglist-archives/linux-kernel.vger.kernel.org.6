Return-Path: <linux-kernel+bounces-232554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9F991AAE6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818401C20F6C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BAC199222;
	Thu, 27 Jun 2024 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujNF5EcT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEBA198A27;
	Thu, 27 Jun 2024 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501311; cv=none; b=ggMY+v6J0dt/IwkO6o1QDELM3LHNFUglWMnHqh2ETgvNc+BY/iU4XiAkyK5Ti8iSNJuchmEA0k71Ymi/Xt9jh59qZzlMAkyVwKPVKFStSZQJX1NMZlPPtYE9RYlohESD5KSE8qjdmLfn69pWvYCjxjmt/XSYfDFXQ+HgC4ATC2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501311; c=relaxed/simple;
	bh=T6OmF/ctekeGX1Zyt8oH+D/SesyRhu4JpmwzDB/BBaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFTpd2gNDVzy544rLwPyhobSNzIQgddQ0LLvJ8BAOMG0khMc0xlPHe7UrsrGFhx/9lpkuaPVEbiBct2snSWj9bSuNweP6bWaa9lvwlQcqEC9J5mB5b2VCQBEJhy19aIyXsMQhiz3Nz6oI3cmYNRxx3eOEB5KxYZNPEZmtufuO3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujNF5EcT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297EBC2BBFC;
	Thu, 27 Jun 2024 15:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719501311;
	bh=T6OmF/ctekeGX1Zyt8oH+D/SesyRhu4JpmwzDB/BBaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ujNF5EcTLkpuGhwln+D9eR9CwNbDWZ362RckP5So+6S8xhkveTo04eEQdsAIXsqxN
	 +gSXyjsFeoF2K2UgkdB3t33SUJFLhtYNmIcrL9s7iLj2g8s1+mQksOVKMdX/aJp7/t
	 wuyOZO5LPTvT70vmTAmo6uErzQiU4rbjwhubeuedBCGZ/VVBVAj74SI7zAIn8t9l5U
	 2DAYeW1wQ3k7Oq1DY/O5Iru1PTiUq8yma0pNdl7qeP2PcPk9TQts4DZg39hq6GXttl
	 rxNjWRWrWFHJdeN12uyKSJ5GasXWpme0ckb1qiejDOlj7giodka4kdN8gUAsS8K/Si
	 eTKs/t2s3clrw==
Date: Thu, 27 Jun 2024 16:15:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Pengfei Li <pengfei.li_1@nxp.com>
Cc: krzk+dt@kernel.org, robh@kernel.org, abelvesa@kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, ping.bai@nxp.com,
	ye.li@nxp.com, peng.fan@nxp.com, aisheng.dong@nxp.com,
	frank.li@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: clock: imx93: Drop IMX93_CLK_END
 macro definition
Message-ID: <20240627-circus-tricolor-e53d077981bc@spud>
References: <20240627082426.394937-1-pengfei.li_1@nxp.com>
 <20240627082426.394937-3-pengfei.li_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u5klgZjrvwX9aHyj"
Content-Disposition: inline
In-Reply-To: <20240627082426.394937-3-pengfei.li_1@nxp.com>


--u5klgZjrvwX9aHyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 04:24:26PM +0800, Pengfei Li wrote:
> IMX93_CLK_END should be dropped as it is not part of the ABI.
>=20
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--u5klgZjrvwX9aHyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZn2B+AAKCRB4tDGHoIJi
0mGeAQC500wqIOhI+jGHCLMnTXxAQyLeHsQUPCCXK4oumFncWwEAgio1+M+wJgzY
1J1uWvaOISRjnyYvS/xA14tuJxE22go=
=QaIO
-----END PGP SIGNATURE-----

--u5klgZjrvwX9aHyj--

