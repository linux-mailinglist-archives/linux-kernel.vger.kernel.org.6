Return-Path: <linux-kernel+bounces-512100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB22A33402
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149063A59E2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3566C2D613;
	Thu, 13 Feb 2025 00:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="X3eHv0l+"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84980271823;
	Thu, 13 Feb 2025 00:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739406795; cv=none; b=TNU5NlJV0WwEr39V+5ld93uPotGMQgMdgpfouv9CmJ+XElpqQuJsUyMDPKUvPz/Xvv9LIBfYUuUkdvs7iqoIQGyrsHqK8JXhpMhc1q27I8y7Yau9JBK2sCe/x+3q3Bh+Gg+9zBQBu2n9qeKT7zOV4d5Ga/hnqBtHhFWqNa0JZfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739406795; c=relaxed/simple;
	bh=MK36XIGnJyPf3ZbpM6QOJ+5JLqK7b45u3BQX2LiHhGE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V1PbxwwiTLtrOff/BlIeIo+Q6p33G6yazUUS6t4AR0QZeooJPY/WzYXSEBqttW9aP2EfkXazyb1yHFJ9IheiucOiOnbhAwCG0Q/XjEy2PdPheiqLBSBXi/vMDM50huTrruYsnlNVKHH5/+k/VCiumriWA9GZNRTJUcBxt7r7fQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=X3eHv0l+; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1739406791;
	bh=MK36XIGnJyPf3ZbpM6QOJ+5JLqK7b45u3BQX2LiHhGE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X3eHv0l+lt4JR0lILwWPS8oeZleTTgKLAHdO2tMej1PDT+NUdmup0Pwe7aagUlaug
	 hTSmO8JAmzxnTiOM8uk8P23PWl72+Iw9lqC1C5s2jyJfZjky+p7GlYAebj077vIa/M
	 DMnXBJJDj/eLVlBslzUjkjFV9tSV6/AcUD6Z5cveqUd3itpWizKGqAaph2eAuvTIBp
	 /ma5hUuxV54fkeNsWO34mMDpv5WE+QN3Dp6dM3fZjWMgj6pZtOKrY16hLuSJHyZfqt
	 yd8LFb/1164Jgqx2Q+0eX/K075mOKjDw5t6k5A6p/5+6OEIzlaQ3ENTSbhpi2hTY+E
	 hQ4OuUUCX37Sg==
Received: from [192.168.68.112] (203-173-7-184.dyn.iinet.net.au [203.173.7.184])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 908847576E;
	Thu, 13 Feb 2025 08:33:10 +0800 (AWST)
Message-ID: <dfb902083154ef3f8c7fc3bf15852b7c372f8c60.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: ir38060: Move & update dt
 binding
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Conor Dooley <conor@kernel.org>
Cc: Naresh Solanki <naresh.solanki@9elements.com>, Guenter Roeck
 <linux@roeck-us.net>, broonie@kernel.org, Jean Delvare <jdelvare@suse.com>,
  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,  Liam Girdwood <lgirdwood@gmail.com>,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 13 Feb 2025 11:03:08 +1030
In-Reply-To: <20250212-estate-tapeless-08fcdf5b5ca5@spud>
References: <20250204180306.2755444-1-naresh.solanki@9elements.com>
	 <20250204-mulled-evaluate-8a690cdfbd4d@spud>
	 <CABqG17jHKfwJEfZxto_YA4opS8=QwqTqfNdkku8kcEv2_iW+XA@mail.gmail.com>
	 <20250205-purge-debating-21273d3b0f40@spud>
	 <CABqG17j4tKXnMZ5=vcjBvfe6JwCLQ6NbkQmJC9ySK_bmGEv=iQ@mail.gmail.com>
	 <20250206-camera-mashed-48cf0cf1715f@spud>
	 <4619661d7375c71710a22520f6ebbf353a5aff59.camel@codeconstruct.com.au>
	 <20250212-estate-tapeless-08fcdf5b5ca5@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-12 at 18:56 +0000, Conor Dooley wrote:
> On Wed, Feb 12, 2025 at 09:13:11PM +1030, Andrew Jeffery wrote:
> > On Thu, 2025-02-06 at 18:09 +0000, Conor Dooley wrote:
> > > On Thu, Feb 06, 2025 at 09:23:03PM +0530, Naresh Solanki wrote:
> > > > On Thu, 6 Feb 2025 at 01:43, Conor Dooley <conor@kernel.org> wrote:
> > > > > On Wed, Feb 05, 2025 at 03:51:25PM +0530, Naresh Solanki wrote:
> > > > > > On Wed, 5 Feb 2025 at 00:52, Conor Dooley <conor@kernel.org>
> > > > > > wrote:
> > > > > > > On Tue, Feb 04, 2025 at 11:33:03PM +0530, Naresh Solanki
> > > > > > > wrote:
> > > > > > > > +=C2=A0 regulators:
> > > > > > > > +=C2=A0=C2=A0=C2=A0 type: object
> > > > > > > > +=C2=A0=C2=A0=C2=A0 description:
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list of regulators provided=
 by this controller.
> > > > > > >=20
> > > > > > > Can you explain why this change is justified? Your commit
> > > > > > > message is
> > > > > > > explaining what you're doing but not why it's okay to do.
> > > > >=20
> > > > > > This is based on other similar dt-bindings under hwmon/pmbus.
> > > > >=20
> > > > > Okay, but what I am looking for is an explanation of why it is
> > > > > okay to
> > > > > change the node from
> > > > >=20
> > > > > > regulator@34 {
> > > > > > =C2=A0 compatible =3D "infineon,ir38060";
> > > > > > =C2=A0 reg =3D <0x34>;
> > > > > >=20
> > > > > > =C2=A0 regulator-min-microvolt =3D <437500>;
> > > > > > =C2=A0 regulator-max-microvolt =3D <1387500>;
> > > > > > };
> > > > As I have understood the driver, this isn't supported.
> > > > >=20
> > > > > to
> > > > >=20
> > > > > > regulator@34 {
> > > > > > =C2=A0=C2=A0=C2=A0 compatible =3D "infineon,ir38060";
> > > > > > =C2=A0=C2=A0=C2=A0 reg =3D <0x34>;
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0 regulators {
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vout {
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 regulator-name =3D "p5v_aux";
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 regulator-min-microvolt =3D <437500>;
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 regulator-max-microvolt =3D <1387500>;
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > > > > =C2=A0=C2=A0=C2=A0 };
> > > > Above is the typical approach in other pmbus dt bindings.
> > > > Even pmbus driver expects this approach.
> > > > >=20
> > > > > ?
> > > > >=20
> > > > > Will the driver handle both of these identically? Is backwards
> > > > > compatibility with the old format maintained? Was the original
> > > > > format
> > > > > wrong and does not work? Why is a list of regulators needed when
> > > > > the
> > > > > device only provides one?
> > > > Driver doesn't support both.
> > > > Based on the pmbus driver original format was wrong.
> > > > pmbus driver looks for a regulator node to start with.
> > > >=20
> > > > Reference:
> > > > https://github.com/torvalds/linux/blob/master/drivers/hwmon/pmbus/p=
mbus.h#L515
> > >=20
> > > Then all of the in-tree users are all just broken? They're in aspeed
> > > bmcs, so I would not be surprised at all if that were the case.
> >=20
> > Can you unpack the intent of this remark for me a little?
> >=20
> > The history of the problem from what I can see looks like:
> >=20
> > =C2=A0=C2=A0 1. pmbus regulator support exploiting "regulators" as an O=
F child
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node was merged for 3.19[1]
> > =C2=A0=C2=A0 2. The infineon driver support was merged with trivial bin=
dings[2]
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and released in v5.17
> > =C2=A0=C2=A0 3. A patch was proposed that extracted the Infineon regula=
tor
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatibles and provided a dedicated bin=
ding[3], however it
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lacked the "regulators" object property=
=20
> > =C2=A0=C2=A0 4. The patch in 3 was merged as [4] with relevant tags, an=
d was
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 released in v6.9
> > =C2=A0=C2=A0 5. The system1 devicetree was merged and released in v6.10=
, and sbp1
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is merged in v6.14-rc1 for release in v6=
.14. Both devicetrees, as
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 far as I'm aware, conform to the binding=
 as written.
> >=20
> > In addition to keeping an eye out for Rob's bot, I check all Aspeed-
> > related devicetree patches against the bindings using the usual tooling
> > while applying them. I would like to avoid diving into driver
> > implementations as a blocker to applying devicetree patches where
> > possible - the formalised bindings and tooling should exist to separate
> > us from having to do that.
> >=20
> > If the complaint is that people submitting Aspeed devicetree patches
> > are regularly not testing them to make sure they behave correctly on
> > hardware, then sure, that's something to complain about. Otherwise, I'm
> > well aware of the (Aspeed) bindings and warnings situation; we've
> > spoken about it previously. If there's something I should change in my
> > process (beyond eventually addressing all the warnings) please let me
> > know, but I don't see that there is in this specific instance.
>=20
> Ye, it's not a jab at aspeed maintainership, it's about the bmc stuff in
> particular. I saw far too many warnings from Rob's bot on series with a
> version number where the submitter should know better, so the idea that
> it had not been tested in other ways wasn't exactly a stretch.

Thanks for elaborating :)

>=20
> I made a mistake how I pulled these devices out of trivial-devices.yaml,
> given the existing driver didn't work with that binding, but I don't
> really see why there's a requirement for a regulator child here in the
> first place. I get it for something like the lm25066 that is a monitor
> IC that you connect a regulator to, as the regulator is a distinct
> device - but the ir38060 is a regulator that has a pmbus interface so
> both describe the same device.

Makes sense. Maybe it's best to support the existing description in
pmbus core as Rob's already suggested in another part of the thread.

Andrew

