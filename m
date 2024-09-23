Return-Path: <linux-kernel+bounces-336095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DD397EF0F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2770F282AE7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E90E19E99E;
	Mon, 23 Sep 2024 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibjpnFLq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A45C7DA81;
	Mon, 23 Sep 2024 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108360; cv=none; b=tw0XvDPKjchFU3wpWccuVYX8kfFPkN8MKR0hL75u5c/IAR9c/oAnwGD+me8VwULS9igLFx0TQg00jJOlhPuEsExSMiE15g9GLyX4hlZpQ3Pri71TbsEBivN3TIYcOlHwSQWLEyXuIvNYMnLURC8pH/Dr9vfizv9Pu9OD5phH18U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108360; c=relaxed/simple;
	bh=L+HrpQOt/sp64V+/b1XLHvuUE4MhTMOvK2G33tvFkgQ=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=LDp4JBxwbhv9mCwXZimdrXRZsSbsPbsgRcfXQK4xxSz9s9uTaEUGHuTCqn3fm2FJavwuixSKq0KSey2NJdawju+bYI3N0ZEkJYp5qCiIKnK2fSdgBqDwa4sNGPthnjgJOlFXcqh/HWnIrpgxqNjiwqaZWnVB6K9eOl+OgpwN4oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibjpnFLq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F9AC4CEC4;
	Mon, 23 Sep 2024 16:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727108360;
	bh=L+HrpQOt/sp64V+/b1XLHvuUE4MhTMOvK2G33tvFkgQ=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=ibjpnFLqSxjsJEfMV8/u0ampncfU0/VrFCP41L/7DNMy2V0cRhN0TlZEcK1nK9MF2
	 ROM3BOT3dVht5+0VXDDELDl5Xq9Q6q+qv9UYbwNZLV9hk+A/lIp3Yp5jnhoy7HXR3y
	 9pvNor7I4t/1wPXJerCOFK4zBC6F0xUxgdrtlG0PUvK5D5734TdvwdLvKVSJXE2RKE
	 /m1CbkzWwugm8zmH+9wlBZ4upmvv59moz6WfwO/eHJQuwMHFYEAokArzrgaXHS3Eo2
	 wAimx41GvvI4SAPN3A/7UGhhteJst5BSQ6k8k5d3R7HbN6xAAu0rgYrFC6y/nS5lYI
	 v7WJZVg7Nnf9w==
Content-Type: multipart/signed;
 boundary=4435393838c56d35a9520abeca3bdfccaaf3b3c8ee281df4639bc47aa985;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 23 Sep 2024 18:19:15 +0200
Message-Id: <D4DSTDA3HE2B.20ACE70SQAL7A@kernel.org>
Subject: Re: [PATCH v5 1/5] mtd: spi-nor: core: add manufacturer flags
Cc: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Erez Geva"
 <erezgeva@nwtime.org>, <linux-mtd@lists.infradead.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, <linux-kernel@vger.kernel.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, <devicetree@vger.kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Esben Haabendal" <esben@geanix.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Erez" <erezgeva2@gmail.com>
X-Mailer: aerc 0.16.0
References: <20240920181231.20542-1-erezgeva@nwtime.org>
 <20240920181231.20542-2-erezgeva@nwtime.org>
 <4e0cf43c-4843-451c-ac6f-86775dbccb2b@linaro.org>
 <CANeKEMOmhAPM1j1_ihzcC2wL6jKsWXPCGfZs+euS8mRvtqgE5A@mail.gmail.com>
 <D4DLQGLJSKPB.3OOW4RU9Q3K5O@kernel.org>
 <CANeKEMPSoUu7GW5bL8nuyC5xCKG7Tt0=SvWTL_CcX5oebqN_YA@mail.gmail.com>
In-Reply-To: <CANeKEMPSoUu7GW5bL8nuyC5xCKG7Tt0=SvWTL_CcX5oebqN_YA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--4435393838c56d35a9520abeca3bdfccaaf3b3c8ee281df4639bc47aa985
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> > > I would gladly remove the obsolete mx25l12805d.
> > Why? I don't see any need for that.
> Maybe because we do not want compatibility table?

I don't get this? Anyway, we do not remove support for older
flashes for no reason.

> No, reading the SFDP is great.
> Except for OTP parameters/configuration.
> As there is not way to find OTP parameters using JEDEC ID/SFDP
> So as I understand there are only 2 ways to set the OTP parameters:
> * Use a compatibility.
> * Use dynamic OTP configuration, through DT, sysfs,

* Use the in-kernel database to look up the parameters as it is done
  with any other flash device. If the id is reused, look for
  differences in the SFDP to figure out the correct flash device,
  then add some .fixups to manually add the OTP flags and
  parameters.

-michael

--4435393838c56d35a9520abeca3bdfccaaf3b3c8ee281df4639bc47aa985
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZvGVBBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gUEQF/VOQpFkq0WrVXag0EPbAEIxTgFyKdouQs
QrlWS9ikmx+/jabf2o19//lXIc66quhYAX9FYSiGNxXObzE3jBp5TU7NFXWyMxfV
Btc6eXuS1c4Pa2RxPYz0IyLkJVdBDcdhrnM=
=XAMQ
-----END PGP SIGNATURE-----

--4435393838c56d35a9520abeca3bdfccaaf3b3c8ee281df4639bc47aa985--

