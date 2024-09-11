Return-Path: <linux-kernel+bounces-325703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C65AC975D64
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793951F23520
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9549D1ABEA0;
	Wed, 11 Sep 2024 22:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wg82qdu1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED75015442D;
	Wed, 11 Sep 2024 22:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726095102; cv=none; b=LAsDy96j8J/T5aMrG3XZ4JKUpXRr78Ht38U55sC+TdhmD3DhsWR1N0dD49GFxAV74molBlPJIx6b13qSCZtPEgon1sqhjJgZ91uK3dkgRoN7xv14/0+NEporgLkqXfTCqhL4htP/hFM1Mit560mlLKcLZLTVcWQsKvsdCjopYGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726095102; c=relaxed/simple;
	bh=HfUUqX6K3r+8VuUvm7rHqhhuSxEAqolXoqoXtRDEsxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McACRQz6k/Fx8tc58QUR0spfstSJd9s6xRLl2F6KChNUJKkE2eSOzzOr/NdcmSApJ6001SOeFTPCCr5wzyeeru18YLhWAmigEZDjFejPGNyVWlSgz/wM2ei1Z5diqcTsZ8Lx2SAXzD0JqFJo+apN5nrZEgCPOfnAWsr/3NVaSaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wg82qdu1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D179DC4CEC0;
	Wed, 11 Sep 2024 22:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726095101;
	bh=HfUUqX6K3r+8VuUvm7rHqhhuSxEAqolXoqoXtRDEsxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wg82qdu163JRMoLt1yRO20gTZmg1rLm/Cl+XJC161ygHfxGVkJvinNredb7L7gwRz
	 qKsHOtLJOD6d8NE6uJGhV4jvo2bSS/p1Syj5RrzyYWGV/dC0EvzzHu+4Dmxwi20lI2
	 CwmEl3Ui/7/r0WZtSuyphNld1izlzmT4UBfEp7KIxeReUey1BA5pvxjNg/CrkwRA0e
	 /ZUHkUDllzMbkt9wgn9hNOw2KiaHxyCO+8PHdsSsstHCGmo6+JMM/ex51SxENqi6m0
	 olbmQfbvGOkguP1uO4WMxRHVr2UVo8jwmVlFr7MVqk7TE5a/pp5o41SPJDRXzCmC51
	 vLEc0xWfKCdLg==
Date: Wed, 11 Sep 2024 23:51:36 +0100
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
Message-ID: <20240911-amniotic-reluctant-81eae9e66138@spud>
References: <IA1PR20MB495374DB8C4208575AAC9675BB972@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240909-prowler-renewal-0592d820ccca@spud>
 <IA1PR20MB4953A0D6A2B73D03BF162671BB992@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240910-bust-mulled-e45f6f6ef29d@spud>
 <IA1PR20MB495316205F5AC588867FA8E1BB9A2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240911-perfectly-buddhist-0c79aed7bb98@spud>
 <IA1PR20MB49538A046810421A8F24E346BB9B2@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qgvyslhUt5KCrDse"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49538A046810421A8F24E346BB9B2@IA1PR20MB4953.namprd20.prod.outlook.com>


--qgvyslhUt5KCrDse
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 06:43:31AM +0800, Inochi Amaoto wrote:
> On Wed, Sep 11, 2024 at 08:11:15PM GMT, Conor Dooley wrote:
> > On Wed, Sep 11, 2024 at 06:25:49AM +0800, Inochi Amaoto wrote:
> > > On Tue, Sep 10, 2024 at 05:13:43PM GMT, Conor Dooley wrote:
> > > > On Tue, Sep 10, 2024 at 06:24:34AM +0800, Inochi Amaoto wrote:
> > > > > On Mon, Sep 09, 2024 at 03:41:10PM GMT, Conor Dooley wrote:
> > > > > > On Sat, Aug 31, 2024 at 06:38:40AM +0800, Inochi Amaoto wrote:
> > > > > > > Add basic pinctrl driver for Sophgo CV1800 series SoCs.
> > > > > > > This patch series aims to replace the previous patch from Jis=
heng [1].
> > > > > > > Since the pinctrl of cv1800 has nested mux and its pin defini=
nation
> > > > > > > is discrete, it is not suitable to use "pinctrl-single" to co=
ver the
> > > > > > > pinctrl device.
> > > > > > >=20
> > > > > > > This patch require another patch [2] that provides standard a=
ttribute
> > > > > > > "input-schmitt-microvolt"
> > > > > > >=20
> > > > > > > The v4 version is from [3]
> > > > > >=20
> > > > > > Which version of this ended up in linux-next? I see a link to v=
4 in
> > > > > > what's been applied, but this v5 was sent before that code was
> > > > > > committed.
> > > > > >=20
> > > > > > Either way, what's been applied and what's here produce warning=
s:
> > > > > > cv1812h.dtsi:19.28-24.5: Warning (simple_bus_reg): /soc/pinctrl=
@3008000: simple-bus unit address format error, expected "3001000"
> > > > > > cv1800b.dtsi:18.28-23.5: Warning (simple_bus_reg): /soc/pinctrl=
@3008000: simple-bus unit address format error, expected "3001000"
> > > > > >=20
> > > > > > It's just a copy-paste error I would imagine, but please send a=
 fix.
> > > > >=20
> > > > > Yes, it is like some copy-paste error, I will fix it.
> > > >=20
> > > > I'd rather you had sent some follow-up patches, than rebase your tr=
ee at
> > > > this point in the cycle. I assume you hadn't yet sent that stuff in=
 a PR
> > > > to Arnd?
> > > >=20
> > > Yes, the pinctrl dts needs binding header, which is taken by Linus.
> > > So we hadn't sent them. This is why I sent a new version to fix this.
> >=20
> > Oh, I'm surprised that you didn't get a shared branch from him for that
> > to be honest.
>=20
> He did provide a shared branch, but I am not sure the right way to use=20
> it. He said it is used for SoC tree to pull it. So I think it is just=20
> used as dependency. Is it OK to just mention it in the PR and add the=20
> pinctrl dts? Or need some other git tags to tell the dependency?

It's a bit late now to be adding stuff for 6.12, but for next time what
you do is git pull the tag he gave you here
https://lore.kernel.org/all/CACRpkdZ5zAgQyo9y_nO8M0Z6b8zqbkg5H_3ceEJN6z6mHL=
4TOQ@mail.gmail.com/
into your for-next branch and then apply the dts patches to your tree
after that.

And then you make sure to write a commit message for the resulting
merge commit that explains why it was pulled.



--qgvyslhUt5KCrDse
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuIe+AAKCRB4tDGHoIJi
0sWQAP9zJHUNnQx6XAhTUPqtYR8QkVnQXE1ZUWadj7m+bMedeQEAnt4gabRrmwBq
5NL00G/BsHrvbhY6qYKpkCEeOsp5yAE=
=8N+1
-----END PGP SIGNATURE-----

--qgvyslhUt5KCrDse--

