Return-Path: <linux-kernel+bounces-577463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C6CA71D63
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E55E3A905E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207F222257C;
	Wed, 26 Mar 2025 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Fjg2c3FG"
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90DC1FF1A9;
	Wed, 26 Mar 2025 17:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010713; cv=none; b=SO0vYHO9i0yFOdCyzp5Xz9QTYzhueq4TsgGjWVkUfDzCUr0IymC/ilHjjlbyjpFvqgFdEgYTbCPxQap2DQ64BtuZjRt6A9XbIAEMjpg/ePBcpA0rg000oVwLDkZ3N/ELR100TUGCy2ldQ+zKtjDyuc+u9oa5xK6L68pwP4GT9Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010713; c=relaxed/simple;
	bh=5uC3QToOtJ1sSauMKZMPg3z+sj4uE4qug4sPcoE2ST0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxfPfZykJ+rnQlRMN+6svBvTt+0G06+rNHR4uW/0R7w1xToTFHnN9edd0slCn00cjwVmQK9G3Rb3NOsl6+JrqY1Te6yESV2KWvjXDgC5BWC3CX9gZmLxbZHTDX0qxPasbwn4ZtUrvSVCnlgZ34uTF1waiVEoM4RmTqhnYz0DVag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Fjg2c3FG; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EC519101CA7F1;
	Wed, 26 Mar 2025 18:38:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743010709; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=827GHqqjuuDptAW70N3mhQuQwD+S2NmizCkL0BB6Eh4=;
	b=Fjg2c3FGbzX+OztoPrbctfMqER1z/XUBM91l7fNpUblLBjjhzjx54KqpJtH+7zfyYpSCkR
	2oP9jhypy3M/fFtMSKqT1c6hIG07/WgXachRaSjTKs2J4TsFNJKMZuS1bqAEOD7nqBS6Z9
	xFTPCXtd9tvT8/F8KRk4yMrrrvvjK0aUYJBKrYFmxoXMSff/8Y999KbFTFPH4XLDb65bkt
	7TzhNWxVkDLZv8863HqMeLevJnnJXWOS+e5luIUZh7VQMR/ZW8YZBj+dKdC2YZwOJaWdSn
	hkIySyxj5LBcQpAWZtcNi2k+KiMZ63GzJanuxbn5qfKWmqYX7exmS8YT/wEJ1A==
Date: Wed, 26 Mar 2025 18:38:26 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 Noah Wang <noahwang.wang@outlook.com>, Michal Simek <michal.simek@amd.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Naresh Solanki
 <naresh.solanki@9elements.com>
Subject: Re: [PATCH v2] dt-bindings: trivial-devices: Document SPI
 measurement on LWE boards
Message-ID: <20250326183826.5e3d5340@wsk>
In-Reply-To: <CAOMZO5BTEPL8qP7wP_AopYttWSFtu0Mw17zO1HaXv3abUZZeHw@mail.gmail.com>
References: <20250326140930.2587775-1-lukma@denx.de>
	<20250326171838.2689448-1-lukma@denx.de>
	<CAOMZO5BTEPL8qP7wP_AopYttWSFtu0Mw17zO1HaXv3abUZZeHw@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iO6zdRmP7H8N47/2ZqM7ryN";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/iO6zdRmP7H8N47/2ZqM7ryN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> Hi  Lukasz,
>=20
> On Wed, Mar 26, 2025 at 2:19=E2=80=AFPM Lukasz Majewski <lukma@denx.de> w=
rote:
> >
> > The measurement device on Liebherr's (LWE) boards is used to monitor
> > the overall state of the device. It does have SPI interface to
> > communicate with Linux host via spidev driver. Document the SPI DT
> > binding as trivial SPI device. =20
>=20
> Can't you use lwn,bk4-spi instead?

Conceptually, those are two different devices.

>=20
> Please check:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Documentation/devicetree/bindings/misc/lwn,bk4-spi.yaml?h=3Dv6.14




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/iO6zdRmP7H8N47/2ZqM7ryN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfkO5IACgkQAR8vZIA0
zr0GNggAgtKkrfz1MeHfpsXhOyLJLSOyBgBui5Os4gOR7x4F/KxJsfl1IROlR8Zl
sg8iBely5gwSK81dAr24Ky3tF0SlX+cpzgyyOPoHfEYfOaHbBTHW3d9nKG7vCytT
JYgsmw1uHqtaD2prFvAedccRZbPCy4aVHLc2dpu4dUXHhW1p0bDKBz331WxWv72N
BHfNOsUQMQPEDFIzu8oAgQm9Hr85VQpWHEkwxmyJc9zhi4n3O7L1doVnGtsO3lqV
LFQ9tPxBYIOXBXV/Vr6SlFyCNofSXzJeAdyZZO8pcTQmVI70+08/jS88+kEpX6Vn
I3nFb4QWDyjtn80f25EtcUNLLk8pwg==
=53+8
-----END PGP SIGNATURE-----

--Sig_/iO6zdRmP7H8N47/2ZqM7ryN--

