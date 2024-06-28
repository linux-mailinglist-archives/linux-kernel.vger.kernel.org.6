Return-Path: <linux-kernel+bounces-234164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15CC91C306
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E5C1C22853
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC9A1C8FA0;
	Fri, 28 Jun 2024 15:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ts4ibjZh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0B61DDCE;
	Fri, 28 Jun 2024 15:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719590236; cv=none; b=po6oya15Wy00Zyrk7vSHGFZXTImPx/9gpAlHjnn5g8DWcrvwsIllOj9zozLglEvuWOdhe6qgeHcZfhGLxTeIJmBPqxNzQnH6pq1LwMJDgumUXuEZrajeE/JR7OBwxDxkajknVihUMb1RBksDlYKT5LdSBy1QtGSO7OZD4oA/C1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719590236; c=relaxed/simple;
	bh=Fwcx8N2twodbUgIyfQuM7OlPy3OCdPpkHIpMOid9mkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVGCME6RlUN3CmQxycMlw0FTa7m+xQjbpNe1aI93AZUgRfPhcgAbvLjqEX2HKnQ+vdLGu4iNkezC70yVBwj2BeDamkNLptLyLI5Fbj+T9uKBF8Pzk0wqP0ozukGxgwKisHXOp8tU//YV+qdUUcEA1TDQdDUZrSat26qnlxCC2/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ts4ibjZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA2BC116B1;
	Fri, 28 Jun 2024 15:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719590236;
	bh=Fwcx8N2twodbUgIyfQuM7OlPy3OCdPpkHIpMOid9mkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ts4ibjZhSPLnzk+UVMaAyTjVwkPqYx9r8myrs9O+26A2uMSTyhS9u30KLYtCGVHbG
	 91//uyYCyTdNh5ftgka+2lmYGSLjhzHipP4l3fzpo4rXL2jqzSwMMv4DS3b8h23f5N
	 yJAVxkXOaGR3gi0E2MZPMNVAS7T0oqYQOGvS+ArHHSwy1znsRWoCCVBopqXJ+Er0Y8
	 5qeHi90V4SwTnyd3/eFMHHiNuKZ66LSLBWnsJ4UZq8fiJ5R2d8oeHdswx7RTIq2dAf
	 qtmsukba2SkO1jM4O+l/s1s/OnV8RmC2BtnCdPRTKy8QMmA/mTjIZ6pFxjnJMcA2N5
	 p3921p0g+VBCA==
Date: Fri, 28 Jun 2024 16:57:11 +0100
From: Conor Dooley <conor@kernel.org>
To: Erez Geva <erezgeva@nwtime.org>
Cc: linux-mtd@lists.infradead.org, Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>, linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Erez Geva <ErezGeva2@gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: mtd: macronix,mx25l12833f: add SPI-NOR
 chip
Message-ID: <20240628-refuse-actress-b76985aa020c@spud>
References: <20240628140328.279792-1-erezgeva@nwtime.org>
 <20240628140328.279792-4-erezgeva@nwtime.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5LTHOB9fioTcbYBQ"
Content-Disposition: inline
In-Reply-To: <20240628140328.279792-4-erezgeva@nwtime.org>


--5LTHOB9fioTcbYBQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 04:03:27PM +0200, Erez Geva wrote:
> From: Erez Geva <ErezGeva2@gmail.com>
>=20
> Add Macronix SPI-NOR mx25l12833f.
>=20
> Signed-off-by: Erez Geva <ErezGeva2@gmail.com>

Should the email in here and in the From: field be your nwtime one?
Otherwise
Acked-by: Conor Dooley <conor.dooley@microchip.com>


--5LTHOB9fioTcbYBQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZn7dVwAKCRB4tDGHoIJi
0sedAP9JZrmerATwFRELEAhhUdHLl4Rfe8TYzKPkiD4ynhuIzAD/ST3zt9wyrtPf
Dxbdg7MhOD6RltHzbstZSXDo4oHqegc=
=f7xJ
-----END PGP SIGNATURE-----

--5LTHOB9fioTcbYBQ--

