Return-Path: <linux-kernel+bounces-221581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C5490F5B2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 20:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 980762832BF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDC2156F40;
	Wed, 19 Jun 2024 18:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQLD/k3/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD4182495;
	Wed, 19 Jun 2024 18:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718820425; cv=none; b=D9oPQ8Ge4wwF54v6YNaL2bKWzSwa0EKzs6N7ZmiWpI3tjQq/5hrDDE/lreNGytwMl8sRV12tm8Zoe+mCPCT6hT05oktIlX9SrltZhCNlBI6+ST/C2ePYPdg3WjqX95jTa2ykv8dhqWXpKCRUW91lL7bsotH+RbTwhLNAzMa5fJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718820425; c=relaxed/simple;
	bh=UFW6zeOPxiNDg/D1GSApJuoIj9DdToxKPpFEQSUZJWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtW62bsSbVXShqucbRK7JIj/ZrMXvR4ubHaF/JKQVe7N1m/zOZbUGbaZqRbo7eJ20GpKdzirrWjadRXef5eDYCzaw7FB5o/vrKJHRas9hfohEqeemS8Xxp6lSLjHVO55XZ/eE+TaEEy22qEcFt2P4BNISdv/GzdGB6q3nBEkVjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQLD/k3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4638DC4AF07;
	Wed, 19 Jun 2024 18:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718820424;
	bh=UFW6zeOPxiNDg/D1GSApJuoIj9DdToxKPpFEQSUZJWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qQLD/k3/f2EZHAgNcXY9J4b5dl2Yvam1LmZg1U5Fyh8qT4pZq8+Yl9dPVt41zFRoP
	 WQMijBZkVOVAr/AKTJVXuWANXSt3EhdLexAlInc+ifJLGKonXeV7s8Hm0Y+cM8aeD5
	 wC82uj5U3/Dd1FfBsCagss9LE4Pa5A/mnvDgyj/KmwnrdgVXGSDOI8SgZvNj2OX33N
	 k3bjNHxLLP3G++mZpyv5Brxv9S86xO4dRQ5j1urqzk7eh3nGyDz23w2WLdu4pxLhsg
	 sR1Hld/b3BssX933656HNVOiX7+vZViIrAv8a1vlnYbFIzMXOSxsknOfCo6+XNZilW
	 PdHBACrTgNh6Q==
Date: Wed, 19 Jun 2024 19:07:00 +0100
From: Conor Dooley <conor@kernel.org>
To: =?utf-8?B?6Z+15rabIOS7ow==?= <d1581209858@live.com>
Cc: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 1/3] dt-bindings: mailbox: add Sophgo cv18x SoCs mailbox
Message-ID: <20240619-underfed-rare-1364da741106@spud>
References: <SYBP282MB2238DE0DA19C6EF411B2356CC4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
 <SYBP282MB22389FD1E07BBDC6FE1D90A0C4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
 <20240618-monastery-manger-1a7d9a272f11@spud>
 <SYBP282MB2238E28A6EA276C7201CA621C4CF2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GeIuuNYVaYRqtrPD"
Content-Disposition: inline
In-Reply-To: <SYBP282MB2238E28A6EA276C7201CA621C4CF2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>


--GeIuuNYVaYRqtrPD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 02:33:46PM +0000, =E9=9F=B5=E6=B6=9B =E4=BB=A3 wrot=
e:
> Hi Conor,

Something has gone fairly badly wrong with your mail client FYI:

>=20
> > From:=C2=A0Conor Dooley
> > Sent:=C2=A0Tuesday, June 18, 2024 23:38
> > To:=C2=A0Yuntao Dai
> > Cc:=C2=A0jassisinghbrar@gmail.com; robh@kernel.org; krzk+dt@kernel.org;=
 conor+dt@kernel.org; unicorn_wang@outlook.com; inochiama@outlook.com; paul=
=2Ewalmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; linux-ke=
rnel@vger.kernel.org; devicetree@vger.kernel.org; linux-riscv@lists.infrade=
ad.org
> > Subject:=C2=A0Re: [PATCH 1/3] dt-bindings: mailbox: add Sophgo cv18x So=
Cs mailbox
> >=20
> >=20
> > On Tue, Jun 18, 2024 at 11:12:33PM +0800, Yuntao Dai wrote:
> >=20
> > > Add devicetree bindings documentation for Sophgo cv18x SoCs mailbox
> >=20
> > >
> >=20
> > > Signed-off-by: Yuntao Dai <d1581209858@live.com>
> >=20
> > > ---
> >=20
> > >=C2=A0 .../mailbox/sophgo,cv1800b-mailbox.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 75 +++++++++++++++++++
> >=20
> > >=C2=A0 1 file changed, 75 insertions(+)
> >=20
> > >=C2=A0 create mode 100644 Documentation/devicetree/bindings/mailbox/so=
phgo,cv1800b-mailbox.yaml
> >=20
> > >
> >=20
> > > diff --git a/Documentation/devicetree/bindings/mailbox/sophgo,cv1800b=
-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/sophgo,cv1800b-ma=
ilbox.yaml
> >=20
> > > new file mode 100644
> >=20
> > > index 000000000..e1868aaf2
> >=20
> > > --- /dev/null
> >=20
> > > +++ b/Documentation/devicetree/bindings/mailbox/sophgo,cv1800b-mailbo=
x.yaml
> >=20
> > > @@ -0,0 +1,75 @@
> >=20
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >=20
> > > +%YAML 1.2
> >=20
> > > +---
> >=20
> > > +$id: http://devicetree.org/schemas/mailbox/sophgo,cv1800b-mailbox.ya=
ml#
> >=20
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >=20
> > > +
> >=20
> > > +title: Sophgo cv1800b mailbox controller
> >=20
> > > +
> >=20
> > > +maintainers:
> >=20
> > > +=C2=A0 - Yuntao Dai <d1581209858@live.com>
> >=20
> > > +
> >=20
> > > +description:
> >=20
> > > +=C2=A0 The Sophgo cv18x SoCs mailbox has 8 channels and 8 bytes per =
channel for
> >=20
> > > +=C2=A0 different processors. Any processer can write data in a chann=
el, and
> >=20
> > > +=C2=A0 set co-responding register to raise interrupt to notice anoth=
er processor,
> >=20
> > > +=C2=A0 and it is allowed to send data to itself.
> >=20
> > > +=C2=A0 Sophgo cv18x SoCs has 3 processors and numbered as
> >=20
> > > +=C2=A0 <1> C906L
> >=20
> > > +=C2=A0 <2> C906B
> >=20
> > > +=C2=A0 <3> 8051
> >=20
> > > +
> >=20
> > > +properties:
> >=20
> > > +=C2=A0 compatible:
> >=20
> > > +=C2=A0=C2=A0=C2=A0 enum:
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - sophgo,cv1800b-mailbox
> >=20
> > > +
> >=20
> > > +=C2=A0 reg:
> >=20
> > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> >=20
> > > +
> >=20
> > > +=C2=A0 interrupts:
> >=20
> > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> >=20
> > > +
> >=20
> > > +=C2=A0 interrupt-names:
> >=20
> > > +=C2=A0=C2=A0=C2=A0 const: mailbox
> >=20
> > > +
> >=20
> > > +=C2=A0 recvid:
> >=20
> > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> >=20
> > > +=C2=A0=C2=A0=C2=A0 description:
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This cell indicates the mailbox contr=
oller is running on which processor
> >=20
> >=20
> >=20
> > You can just look up your hartid at runtime, wouldn't that be
> >=20
> > sufficient?
> >=20
>=20
> thanks your addvice, I will fix it

This advice may or may not be correct, that's why I put a ? at the end.
If the hart id of both the C906L and C906B are identical, looking the
hart up at runtime isn't going to help you. If they're different,
cpuid_to_hartid_map(0) will give you the info I believe.

--GeIuuNYVaYRqtrPD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnMeRAAKCRB4tDGHoIJi
0je4AQD33qB0N1Tgk6IfpBaqzSlTz2TBLyx38JV4tYUOly2CjAD8Cu0wPhCkK0Uf
qpZD8TOtF1StAUHs930KDyRXCYuBegM=
=Y8Q6
-----END PGP SIGNATURE-----

--GeIuuNYVaYRqtrPD--

