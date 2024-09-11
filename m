Return-Path: <linux-kernel+bounces-325519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBEB975AB1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 21:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9161B1C221F5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12821B9B45;
	Wed, 11 Sep 2024 19:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kwcgpc0/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A3B1B1D53;
	Wed, 11 Sep 2024 19:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726081880; cv=none; b=VA/epHtS6A51pxW5REEFCZK42cK2pxiKmdhMqZbHyozt0lQ+74XUnPTrNQGtVruunb9HklUQfSFzVjYLgvqe5LDOA0Ze3KunRaPAufC+l27xprMKZXPrEr7/+VaeZWUvMMXcSMpKzPqRcXBXxzu9zmPVIFP9+KjFsEyD9Ptc6vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726081880; c=relaxed/simple;
	bh=diP0SXIxkHbJydqL49v6X2gZprT1jmoY++ECoNAZWlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIUPTX2tpLI40W+qkF1AwPtkDSJ364v5ERdkbmzOaDaUJqK0wOC/gvPMNCsrDMmlOjHxJxD8XbCZSSGeEfMoPGKFIPooXaqULZVquPH8IgDWChmPDJ20Qbcp6vwOxxol5SJmDEuv7r2Ymn9gH7muim4PCsp9x3lHy772+iAXYpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kwcgpc0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7BAC4CEC7;
	Wed, 11 Sep 2024 19:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726081879;
	bh=diP0SXIxkHbJydqL49v6X2gZprT1jmoY++ECoNAZWlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kwcgpc0/qVgRRBE0PDMC/mlecA+6Xpy+Z1z/GMj3zWR3csjY/LVSE1suhLCSR1zTN
	 GNkSYvlPcXAZKaEcPepVmNVUDeCmglmOt4R+jSER55GRvuJ8q8Rh+FR5qGzMys/D5R
	 YbQvSlnrVrCAHMUVXakxn0hB4B8m9ysc+VPvORX04lxfZ0hZJTKLYTCqUZfgf5jbrB
	 I0fdCSQUIKavfN79+QPPEQmYM0E6OEkSNi2N2Ix/IRns55+iHll7Ns9qSlaHXpHBbQ
	 QAiEkTZLDgip7u+M46vKirAh1zeD8OnVLElP0zgYv+ZecgaSV72ijYPXDxVinkUmDr
	 LKaV8ykBIeKyw==
Date: Wed, 11 Sep 2024 20:11:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	Haylen Chu <heylenay@outlook.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] riscv: sophgo: Add pinctrl support for CV1800
 series SoC
Message-ID: <20240911-perfectly-buddhist-0c79aed7bb98@spud>
References: <IA1PR20MB495374DB8C4208575AAC9675BB972@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240909-prowler-renewal-0592d820ccca@spud>
 <IA1PR20MB4953A0D6A2B73D03BF162671BB992@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240910-bust-mulled-e45f6f6ef29d@spud>
 <IA1PR20MB495316205F5AC588867FA8E1BB9A2@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ffr1Bt9qHGZE+eZ/"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB495316205F5AC588867FA8E1BB9A2@IA1PR20MB4953.namprd20.prod.outlook.com>


--ffr1Bt9qHGZE+eZ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 06:25:49AM +0800, Inochi Amaoto wrote:
> On Tue, Sep 10, 2024 at 05:13:43PM GMT, Conor Dooley wrote:
> > On Tue, Sep 10, 2024 at 06:24:34AM +0800, Inochi Amaoto wrote:
> > > On Mon, Sep 09, 2024 at 03:41:10PM GMT, Conor Dooley wrote:
> > > > On Sat, Aug 31, 2024 at 06:38:40AM +0800, Inochi Amaoto wrote:
> > > > > Add basic pinctrl driver for Sophgo CV1800 series SoCs.
> > > > > This patch series aims to replace the previous patch from Jisheng=
 [1].
> > > > > Since the pinctrl of cv1800 has nested mux and its pin defininati=
on
> > > > > is discrete, it is not suitable to use "pinctrl-single" to cover =
the
> > > > > pinctrl device.
> > > > >=20
> > > > > This patch require another patch [2] that provides standard attri=
bute
> > > > > "input-schmitt-microvolt"
> > > > >=20
> > > > > The v4 version is from [3]
> > > >=20
> > > > Which version of this ended up in linux-next? I see a link to v4 in
> > > > what's been applied, but this v5 was sent before that code was
> > > > committed.
> > > >=20
> > > > Either way, what's been applied and what's here produce warnings:
> > > > cv1812h.dtsi:19.28-24.5: Warning (simple_bus_reg): /soc/pinctrl@300=
8000: simple-bus unit address format error, expected "3001000"
> > > > cv1800b.dtsi:18.28-23.5: Warning (simple_bus_reg): /soc/pinctrl@300=
8000: simple-bus unit address format error, expected "3001000"
> > > >=20
> > > > It's just a copy-paste error I would imagine, but please send a fix.
> > >=20
> > > Yes, it is like some copy-paste error, I will fix it.
> >=20
> > I'd rather you had sent some follow-up patches, than rebase your tree at
> > this point in the cycle. I assume you hadn't yet sent that stuff in a PR
> > to Arnd?
> >=20
> Yes, the pinctrl dts needs binding header, which is taken by Linus.
> So we hadn't sent them. This is why I sent a new version to fix this.

Oh, I'm surprised that you didn't get a shared branch from him for that
to be honest.

--ffr1Bt9qHGZE+eZ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuHrUgAKCRB4tDGHoIJi
0s3xAP9ysBxOhYOGk3X0TcHnR9KorTtMFJdJOSbJAt+T6+oguwEArUUlgwxXzKR4
+g2VB215ZOfEiVyNDrbLaj9srEI0AAo=
=yRNe
-----END PGP SIGNATURE-----

--ffr1Bt9qHGZE+eZ/--

