Return-Path: <linux-kernel+bounces-252688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C169316CF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794C41C21384
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AD118F2E4;
	Mon, 15 Jul 2024 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PImOXatr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF71318EA85;
	Mon, 15 Jul 2024 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053883; cv=none; b=vF4WB37O0CiBBmc4TU3KR57R5To2QJLSa5Y49g/3/c9E0RVG79yt6+uCblnJuWbtvLB19QTj3OKtQFPWCBu76U0+fxlSZjj5V3cKIO5M4VJb8fK1HKlybmNDhxoee1A22N7CQNPoOHH31ZZxVN+Jlbjq7JuY8XMsS7FHee5Q8v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053883; c=relaxed/simple;
	bh=11zvZR4eorSWA2S4sGXe06K5qrHou5RJw9h8ZIDvnt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7SuXJaf/PJcToEa43BisFagZuPrMa5UbO+u98jUBVKbBrJmO50AaGQra1fssDAwX3CPiXRRgjivgdJQFJVy7U3zlL5wju74ZX2ZRygqt1ZGUd6y6K7XGJsiAcRIDmGraFKqL/jIRBBxkXkPdehR2OFI8UEeHJh53Drn9WbOILs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PImOXatr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AC1C32782;
	Mon, 15 Jul 2024 14:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721053883;
	bh=11zvZR4eorSWA2S4sGXe06K5qrHou5RJw9h8ZIDvnt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PImOXatrwKBgthehOT9gAHPf9j0Ax1+ns4EqUztwLT4DimJaqsvHI+bpEfvGoxVj6
	 k6i42LEiDGx/wMRXMIWOFrCHpIXda9Qrn/Mm7Sn/EkNxxIytV9gOiqQAK/9oX5DBUK
	 vaL72EL4hxJB36kyDX5xUOkjret0ZwtEyAKp3eP2HucZ+VR5rccMB4AfEPNZAcGeOb
	 V6ilnFgZRZGxxGj1TSRtkKo8NqRY/YCiv3rBPAE2av4+0x8RLmO2FuNwG5GhrBfPO4
	 yi/pd9CmNVN0x9I6mYqOAZzWQw/+8pbpej9qRssmspzvD0vaozkze6U2btG1HI39x5
	 A6N/IgqQF15EQ==
Date: Mon, 15 Jul 2024 15:31:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Doug Anderson <dianders@google.com>
Cc: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>,
	dmitry.torokhov@gmail.com, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	jikos@kernel.org, benjamin.tissoires@redhat.co,
	linus.walleij@linaro.org, hsinyi@google.com,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: HID: i2c-hid: elan: Introduce Elan
 ekth6a12nay
Message-ID: <20240715-bunkhouse-freeness-c4367d3c298d@spud>
References: <20240715073159.25064-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240715073159.25064-2-lvzhaoxiong@huaqin.corp-partner.google.com>
 <CAD=FV=VHDksKiZXrauiipa3HjtK4sE5+dbmXmVfhFoM-RKQP6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="08zt4+beBDwHYsDl"
Content-Disposition: inline
In-Reply-To: <CAD=FV=VHDksKiZXrauiipa3HjtK4sE5+dbmXmVfhFoM-RKQP6A@mail.gmail.com>


--08zt4+beBDwHYsDl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 07:22:30AM -0700, Doug Anderson wrote:
> Hi,
>=20
> On Mon, Jul 15, 2024 at 12:32=E2=80=AFAM Zhaoxiong Lv
> <lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
> >
> > The Elan ekth6a12nay touch screen chip same as Elan eKTH6915 controller
> > has a reset gpio. The difference is that they have different
> > post_power_delay_ms.
> >
> > Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> FWIW things have changed enough between V1 and V2 that you probably
> should have removed Conor's "Acked-by" tag here and waited for him to
> re-add it.

Yeah, good spot. I wouldn't have acked this version would asking
questions - in v1 it made sense not to have a fallback when "they have a
different post power delay ms", but now there is a fallback. Is the
fallback actually suitable here, or might it be a naive rebase? Does the
ekth6a12nay work with the ekth6915's reset timing?

Thanks,
Conor.

>=20
> I'd also note that when posting a patch your Signed-off-by should
> always be at the bottom of any collected tags. For reference [1].
>=20
> [1] https://lore.kernel.org/tools/20221031165842.vxr4kp6h7qnkc53l@meerkat=
=2Elocal/
>=20
> That being said, the new binding seems OK to me.
>=20
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

--08zt4+beBDwHYsDl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpUytgAKCRB4tDGHoIJi
0muqAPwO+LmBqGC0F7cwqQrirPYzWXD7X1Z9XL51rsb8ll4Y5QEAh5NNAFUOafyJ
77wn9KdmuxUL0ecyzMeTAif3F69GjgU=
=m7q2
-----END PGP SIGNATURE-----

--08zt4+beBDwHYsDl--

