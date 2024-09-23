Return-Path: <linux-kernel+bounces-335659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8040B97E8B0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47AFC280A7C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87FD194A7C;
	Mon, 23 Sep 2024 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWfz35v3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EB91946D0;
	Mon, 23 Sep 2024 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727083764; cv=none; b=rk4imL6z/G1UT6tiVsPaqIysi1lWGw5WKyLP7KZye2thDDjPSt0ibbmTaT20RgSRX0PHuo9mEbUpoHoNkQ78+dgjPWRpuDeblXa00t61nRrdr16sJxpv0Q/IWS6gSuwoKnxXqzyGyAg2j594BBuKM1BwHLX/iFr/mpRrCfGvvDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727083764; c=relaxed/simple;
	bh=iwf1nkRj/tOTwl15MaRvvnK43xbPIYpcWqkXy1mwUMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKvZ7eQ2ooE7CSVX9BzSUc/My3fZnbajGzhOV//meFGpRk8nPwJnuYnNTyx4n2J9NWb2CjE1Sjc/3OAsm6Uf08L/XdSi38zf6TCsiyJdIU1AtrjjozH8KCxmtfu/YdCBNZ0umTLxIFiXYBPg4ELC8RDrL+2amqL7jtatPFY4FQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWfz35v3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD4CC4CEC4;
	Mon, 23 Sep 2024 09:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727083763;
	bh=iwf1nkRj/tOTwl15MaRvvnK43xbPIYpcWqkXy1mwUMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GWfz35v3AxaywbR0LxXA6c1JHSE4Uyf5NxIiXSvNfZcJ6UpUlqjoQaDYcnDsawxSR
	 Y1q9kodzPthObVi3mMkAz7G9co4vG+0QlfMfJtujo+1wyMHxcMOxnTDPpSmRA7fAg7
	 n7bzpvm4kT3EzceGJgYH3AiI0e1ULIHUe3zw7R++PI1HQEXMFwOZ1p8o2bYTwtgGst
	 rkPXTBojo/oSkc393DGQYRqnBesZNfJeE3GCEanboIlAMuEtnXHRxORO91OLEIbDrY
	 VMwU7d+krfgN61iCkq1IoTyxl9/M6Pv14f8xtnBUn5UhiD9dpQLXbNAmZSHqplACaH
	 U85P1DQB1xEZQ==
Date: Mon, 23 Sep 2024 10:29:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Sandie Cao <sandie.cao@deepcomputing.io>
Cc: Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] riscv:configs:starfive:add framework config
Message-ID: <20240923-bacteria-ending-8bd9dd9efcfd@spud>
References: <20240923053806.1586080-1-sandie.cao@deepcomputing.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jSqPFTddLCwzgxa7"
Content-Disposition: inline
In-Reply-To: <20240923053806.1586080-1-sandie.cao@deepcomputing.io>


--jSqPFTddLCwzgxa7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 01:38:06PM +0800, Sandie Cao wrote:
> Add config to support RISC-V Framework Laptop 13 Mainboard.=20
>=20
> Signed-off-by: Sandie Cao <sandie.cao@deepcomputing.io>

This shouldn't be required, if there are some config options this board
needs to be usable, they can be added to defconfig.

--jSqPFTddLCwzgxa7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvE07wAKCRB4tDGHoIJi
0ncGAPsHek8Al7wfJS16NfYR18Bffi2ULmNJqQCTD1U3Z3PeGQEA67v2+b7qOUHk
7jCExZIEY3Oeit8hRbhXaexM09lsyAA=
=a9yk
-----END PGP SIGNATURE-----

--jSqPFTddLCwzgxa7--

