Return-Path: <linux-kernel+bounces-255480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A1493413A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 19:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7BDB1C20DDB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC021822DF;
	Wed, 17 Jul 2024 17:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjBmm/VI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AC97470;
	Wed, 17 Jul 2024 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721236351; cv=none; b=s+shbgSlJYuRu+4ljnPnBgjzJJNTQ7JnLdXmvM3jBpze9ZSkpt3gtQiYIRcf1t/Y6iQECNlQECO0pKcZVF59lNeswma3NObRBh134SP6Btr1SvxT66WCD6rdPzGa0hc4gITfOMbdhd9bWzC6T5XM9oORI6CCQgMkhJlcrYsdWa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721236351; c=relaxed/simple;
	bh=6oJ8M1vrPdRG3kOHgOQHSnbwDAXJpmALAEax66ou1oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVJHlwZAho7M3QNNGIs+m2PiNt742EK0EjEPpZFGWjHGRZAZZ4MOmPNzaKzTaVNg4joweouof6oXGoYILu4irhV+TR4VxjFTaKIa3mDJPx/AjiO6jEFOW55OyzyhrQwMV3YwNt5/V6VwLyMu0ZCvNXXOluNXDfrdsJ/LB/KqPYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjBmm/VI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA312C2BD10;
	Wed, 17 Jul 2024 17:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721236351;
	bh=6oJ8M1vrPdRG3kOHgOQHSnbwDAXJpmALAEax66ou1oA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QjBmm/VIWHe0C7PpHR3d0xvqkAlxrS0/zTVIoPL6I0BJlYsbzKRwv1LCWpswjZiia
	 MIKZIwenfzoUsa945uXX4ODBOKhaMYmj6sxxxPo7zsHKiPGaEcdaqeWtcylpoV6Jto
	 nwdvua/9cyZS06chD15CIDpIBMixLHdehVWWCwApdMZN/eEvW98DDAXlv/WlG9ZUlP
	 GnrtpvQYZhQyEBpLkluWoy8WhGwjUU+KwvmcWWHpzjUWvnePDnSWCL+kNkUKxmQ5X2
	 faD9u8YBYIwS7G5vp0fL1h+vh2KTvBArozwr2OW14nMcjeXMRY2U7Fj/mKSSdEE2Z9
	 BwrZA+g/4ZA4w==
Date: Wed, 17 Jul 2024 18:12:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Yuntao Dai <d1581209858@live.com>
Cc: Inochi Amaoto <inochiama@outlook.com>, jassisinghbrar@gmail.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	unicorn_wang@outlook.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: mailbox: add Sophgo cv18x SoCs
 mailbox
Message-ID: <20240717-flail-revisable-8f232da8f1c5@spud>
References: <SYBP282MB223825D5903777B937A8A377C4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
 <SYBP282MB22382E1C032FDE2D36E6B58DC4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
 <IA1PR20MB49537F9F04E601413EA1C86FBBA12@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240715-upriver-grumbly-e8f6172f6a72@spud>
 <SYBP282MB2238C5F2D4B10061FA241CCFC4A32@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ALmOSiU6N73KQalJ"
Content-Disposition: inline
In-Reply-To: <SYBP282MB2238C5F2D4B10061FA241CCFC4A32@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>


--ALmOSiU6N73KQalJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 01:06:46AM +0800, Yuntao Dai wrote:

> > >  > +examples:
> > >  > +  - |
> > >  > +    #include <dt-bindings/interrupt-controller/irq.h>
> > >  > +
> > >  > +    mailbox: mailbox@1900000 {
> >=20
> > And while you're fixing the things Inochi pointed out, drop the
> > "mailbox:" label, you've got no references to it.
> >=20
>=20
> Yes, in this patch there is no references to it, but mailbox client node
> will need it.
> I tested this patch using mailbox-test as the client, like:
> "
> mailbox-test {
> 	compatible =3D "mailbox-test";
> 	mbox-names =3D "rx", "tx";
> 	mboxes =3D <&mailbox 0 1 &mailbox 1 2>;
> };
> "
>=20
> If you think it is better to drop the label in this patch, I will drop it.

Just drop it from the example, you can keep it in the actual dts. We try
to keep these examples to a minimum.

--ALmOSiU6N73KQalJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpf7egAKCRB4tDGHoIJi
0r0OAP4hwn7NIolPccLar8BktnpwAvS8869Jr6xLgazY2aBeGAD/QQ1X61946YGW
Vc7h4srCoFWWRrrUZHX9RMBrvz3DqQo=
=dw44
-----END PGP SIGNATURE-----

--ALmOSiU6N73KQalJ--

