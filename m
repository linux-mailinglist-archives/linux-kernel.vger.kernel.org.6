Return-Path: <linux-kernel+bounces-191305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EC28D0999
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 19:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9722F1C21669
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B76815F3E3;
	Mon, 27 May 2024 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHPiEbVt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1F2155C8D;
	Mon, 27 May 2024 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716832617; cv=none; b=rteh8R59XV0QJWv7F8YrNdxjeDG2+BUFJY+KuNCrXYas/og4a3MHeErLUnQK/8s3emDBRG23BO6KSgrDZ61+o42YItZEmZHkypNqax/D6ZRmGIlW0OeHLeX/w0PQ67Zp15MEDWErwkRDMjq4fQW1ST6ULt0Xtk8iyLTa/ZNE/0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716832617; c=relaxed/simple;
	bh=xJfRQZyOb9ZjlBIvuRLICUQph7EB4GQE2wQqkDfH07o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhqR4uwgLbXTXdDWyqiNdteOpFH87oeQrXEiiwOkDESzywnmrjixynx0NX58vwUjLM52rQHv2yQoQW+6OVc3A25n4+BXf4YRNjIEewQSeHBTpkpqToiU/0lk1JAKE05LPdGMdI+zJu1oITzyOXy2bhYWhbClxfN/bUzYyghe/a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHPiEbVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DD3C2BBFC;
	Mon, 27 May 2024 17:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716832617;
	bh=xJfRQZyOb9ZjlBIvuRLICUQph7EB4GQE2wQqkDfH07o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rHPiEbVtgUkPWQrMOiEJ3tCoHPdiYgS46nBpgyHJQmLh1Gw/QSKGr+jpNZr6hsDqI
	 FpsMqZjsRTk8nSMWvL2YCdZgY+xC4LTD1kz+eOBj53LPKCESo7DNM7Kq8tFaf/TAGY
	 XSdyViSacRu5vhL2yC9CAd+mUFPSLYjl9dmCNIWVrXxR9UB5F/odW6iIhn1uwqIHd4
	 Rq6W9E8B5KD2ZhKvBULliWHsjdP5TuwyUxe/Eidf9mlfjPFF5D14+Amed3xs8GiaQh
	 28aE8sSiXNnyJnzdCf8Wvswawl0h13TSroxbzCK3ghw39KoiLBmZswmsV5EYCbcF2X
	 yjuNCmPDefWlg==
Date: Mon, 27 May 2024 18:56:52 +0100
From: Conor Dooley <conor@kernel.org>
To: Henry Bell <dmoo_dv@protonmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Michael Zhu <michael.zhu@starfivetech.com>,
	Drew Fustini <drew@beagleboard.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2 v2] RISC-V: add Star64 board devicetree
Message-ID: <20240527-guru-gratify-2626be43b1c0@spud>
References: <sQqtfYJc5p5nCV1CUpJC_eti56gLvmhqfMv4DY-aojB0sCARXzXRBveErmAN0spUDzvux3m5LdcmU-i4BfNDCCckVQfHLpH1QakaXdpnXuo=@protonmail.com>
 <20240524-omen-smell-6c9349065883@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1Sn0De3yrAQc1jyn"
Content-Disposition: inline
In-Reply-To: <20240524-omen-smell-6c9349065883@spud>


--1Sn0De3yrAQc1jyn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 07:48:50PM +0100, Conor Dooley wrote:
> On Thu, May 23, 2024 at 09:55:37PM +0000, Henry Bell wrote:
> > Add star64,pine64 to JH7110 compatability
> >=20
> > Signed-off-by: Henry Bell <dmoo_dv@protonmail.com>
>=20
> $subject here is wrong, it should match other commits to
> Documentation/devicetree/bindings/riscv/starfive.yaml.
> If there's nothing else to fix with the patchset, I'll fix it up on
> application.

Applied with a fixed up commit message.

--1Sn0De3yrAQc1jyn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlTJZAAKCRB4tDGHoIJi
0i0tAP4rO0rk9qWCg5RqkVH89K6dpbJwGc3uAUE/M1qDrOTz2wEAkLR9kZAg2zhU
dJa4MsowTMZTXTSs3wRMoA8iGGXyBQo=
=q1M3
-----END PGP SIGNATURE-----

--1Sn0De3yrAQc1jyn--

