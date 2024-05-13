Return-Path: <linux-kernel+bounces-177778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 148E38C4488
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68A2A1F22898
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AC6154443;
	Mon, 13 May 2024 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIJo+wxD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F76153BF5;
	Mon, 13 May 2024 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715615319; cv=none; b=Fxyjwk/gTiPOFilbfUhXjlbDAgQ5kJTRcmShIX9rJuClW/9EJOxLaSgA5xPj6LbQqOcbWfqgp8yNw+Wd9akl/jZrXdHq3ypVFpRzmWNTiGt40JeXstrcsZ3n8mVdQ45mKFxvV5ZCyvSJAYe77iZAyq5RxbGbTz8hv7ibsCOPORo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715615319; c=relaxed/simple;
	bh=cy/xHMkRc7jqrmPrSj9BRAllfeNdujydY/6qQIY7t2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XP3MHqnc+u3oqA1AGfH0DSR8n7HCYU821PgMNaKqv/3X6GLZq2yAMfDqUcTuNt2AFetzSEi/UuUnij/cnnTVw11odFK9JEvPoLbAv/q+JuVXDxTCZsA0OPqT4yfGxuX4uUDhZbqvZslC5qfqHzzvqrHI9byZNZPttWKkMAEwvXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIJo+wxD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD10C113CC;
	Mon, 13 May 2024 15:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715615319;
	bh=cy/xHMkRc7jqrmPrSj9BRAllfeNdujydY/6qQIY7t2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kIJo+wxDpj/KwHwzW0KlhbvGQOwnBWFNBlGH0EAR4HUb4LJQJCBOPR18slWzk4AHA
	 HxJcM6sBnSmyu6I+kwEwW1Ssd09PBbazILJvRDaPXAHqPH8YlQ043C4A6VVf0FZ0JO
	 Y5r4eHTCRxlfdBdVM90Vjz0qhZZHfo9CuopdzQbwtd+pgLbPSh9WsjfQm9LOrmjWs/
	 9b8NNpzdEhYXqL/jYUn++kEQtVieM/3ouYe5mrDx3eE2z9kcKsFckdbnvHVFUzRfn8
	 VXps67ZiPsxtjhDVzvCDyr93gEBRJRm0avxEk7QHG+MWs3fBr5Txi3ToRjso/4nkIj
	 tQsvxBl0EXx4w==
Date: Mon, 13 May 2024 16:48:33 +0100
From: Conor Dooley <conor@kernel.org>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: neil.armstrong@linaro.org, jbrunet@baylibre.com,
	mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
	martin.blumenstingl@googlemail.com, jian.hu@amlogic.com,
	kernel@sberdevices.ru, rockosov@gmail.com,
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/7] dt-bindings: clock: meson: a1: pll: introduce new
 syspll bindings
Message-ID: <20240513-epic-magnifier-8dd83db81c4c@spud>
References: <20240510090933.19464-1-ddrokosov@salutedevices.com>
 <20240510090933.19464-3-ddrokosov@salutedevices.com>
 <20240511-secret-barcode-e25c722ddf1d@spud>
 <20240513091735.l3uewwzfrdd6qwbl@CAB-WSD-L081021>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lAeSj6B3cXSZn8Gg"
Content-Disposition: inline
In-Reply-To: <20240513091735.l3uewwzfrdd6qwbl@CAB-WSD-L081021>


--lAeSj6B3cXSZn8Gg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 12:18:02PM +0300, Dmitry Rokosov wrote:
> Hello Conor,
>=20
> Thank you for quick review!
>=20
> On Sat, May 11, 2024 at 02:08:03PM +0100, Conor Dooley wrote:
> > On Fri, May 10, 2024 at 12:08:54PM +0300, Dmitry Rokosov wrote:
> > > The 'syspll' PLL is a general-purpose PLL designed specifically for t=
he
> > > CPU clock. It is capable of producing output frequencies within the
> > > range of 768MHz to 1536MHz.
> > >=20
> > > The clock source sys_pll_div16, being one of the GEN clock parents,
> > > plays a crucial role and cannot be tagged as "optional". Unfortunatel=
y,
> > > it was not implemented earlier due to the cpu clock ctrl driver's
> > > pending status on the TODO list.
> >=20
> > It's fine to not mark it optional in the binding, but it should be
> > optional in the driver as otherwise backwards compatibility will be
> > broken. Given this is an integral clock driver, sounds like it would
> > quite likely break booting on these devices if the driver doesn't treat
> > syspll_in as optional.
> > A lesson perhaps in describing the hardware entirely, even if the
> > drivers don't make use of all the information yet?
>=20
> Yes, it's definitely the right lesson for me. However, without syspll or
> syspll_in, we cannot utilize CPU power management at all.

That's the status-quo, right? The incorrect dts would continue to not
support CPU power management and the new one with the correct description
would?

--lAeSj6B3cXSZn8Gg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkI2UQAKCRB4tDGHoIJi
0tl8AP99J+IYSbMrqEfdb2ZfyxV07AxuPzRV6G7nL6Scs3gOZAD+NXFURLw56u7y
ypHqhNg+eH/FeNmtrCAHj0jZEzJfbgI=
=oOXC
-----END PGP SIGNATURE-----

--lAeSj6B3cXSZn8Gg--

