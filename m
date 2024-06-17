Return-Path: <linux-kernel+bounces-217799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3B590B46A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A841F29097
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D8813C69A;
	Mon, 17 Jun 2024 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6hU000T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C27913C679
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636893; cv=none; b=iCcLjgDETJORfGOR2D97XKJml17B0HJXOxrVjx5jzGIMSNxN4N4U80z1D9mEzL6udL2wdHneY17jwQPh2mjtjREHQrCrarkdpJIecLzulj0egcQAvlnsrJx9IjurOMedhjd1kwg8YewM9VM3RpLiybORJT8o195wP93YWACxw7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636893; c=relaxed/simple;
	bh=uZ0Y5CfkMVLI9t0WDwSp5VGGHCC6RUjQyCl6rthM0cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdzRKFLdQgjd6Z7tLP7qS4rLpuNGsgFGLygwIVDS0Bv9ZfL1VUfwTRBrUQ17ILDrKd3z7+MDTFaG1iv6m+B4WBgx6YI0Ytxrq+0GAjml+R7JbEiecvbBM1iZXr+pYT3/5kyBynLEMp79RXo7t6upIbnki6w7qftkc/ofxhg0RFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6hU000T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADF9C4AF1D;
	Mon, 17 Jun 2024 15:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718636892;
	bh=uZ0Y5CfkMVLI9t0WDwSp5VGGHCC6RUjQyCl6rthM0cA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e6hU000TOl7sKiyICLFwDEk9Yb5ucSig39iidpWaHzBQZD35OSLrKp3S0GXkjdP75
	 3BwwRZS730BZLxUq1JvzalhetFBmJhyDfuHZA06T5nxccB6xVTIXZyhpSs93xjtwzT
	 n9p3ueLndCvuhY9QARLaUZsaPOuakCZf6qhEqn7aFWSYZwCo2/DuTl11qB6r74qlHK
	 y6taVyimix/emOcViro7J44ziTxd+FGtEp4gneima6rpi9wGmKAbFP4TnZ14l4vNvg
	 2W5sv6gSJldiOllSdukNH2irqyIQFMI3qN67IdPya4pxxdk61b03F5aeK1bp0/+FZ0
	 wk8PK9In603rg==
Date: Mon, 17 Jun 2024 16:08:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>
Subject: Re: Page select register restrictions in regmap core
Message-ID: <4b22e04f-3142-4a5a-a8d1-366c4b8bbb73@sirena.org.uk>
References: <e3e11724-794d-423e-9326-ffe8eed5119c@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PqO790nS3XJckojN"
Content-Disposition: inline
In-Reply-To: <e3e11724-794d-423e-9326-ffe8eed5119c@roeck-us.net>
X-Cookie: Life is the urge to ecstasy.


--PqO790nS3XJckojN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 17, 2024 at 07:20:28AM -0700, Guenter Roeck wrote:

>         .window_start     = 0,
>         .window_len       = SPD5118_PAGE_SIZE,			// 128
>         .range_min        = 0,
>         .range_max        = SPD5118_PAGE_SIZE - 1,		// 127


>         .window_start     = SPD5118_PAGE_SIZE,			// 128
>         .window_len       = SPD5118_PAGE_SIZE,			// 128
>         .range_min        = SPD5118_PAGE_SIZE,			// 128
>         .range_max        = 9 * SPD5118_PAGE_SIZE - 1,		// 0x47f

You appear to be trying to define ranges that overlap with the windows
that you're trying to expose.  I can't understand what that's trying to
represent or how that would work.  The window is the physical registers
that the host can actually see, the range is the virtual addresses which
users of the region should use to access registers behind the window.
This should be a range of register values which don't physically exist
on the device.  I really can't understand what a sensible handling of an
overlap would be, any attempt to access the window should recursively
trigger selection of the range so no actual register should work.  I
can't tell what it's trying to model.

This configuration would also be rejected by the next test which
verifies that the window does not overlap with the range.

> This works just fine if I comment out the select register validation in
> the regmap core (the one which generates the error). Is there a reason
> for having this restriction, or would it be possible to drop it ?

I'm very surprised this does anything useful TBH, possibly that's a bug
of some kind.  A configuration with the selector within the range is
nonsensical as far as I can see since the range can't be accessed
without programming the selector, the range should be purely virtual
registers and the selector must be a physical register.

> If dropping it is not possible, could we possibly add some flag to the
> configuration data, indicating that this "violation" is on purpose ?
> Alternatively, do you see some other means to describe the ranges which
> would not violate the restrictions ?

Like I say I can't tell what this is trying to describe or how it could
possibly work.  The range should be completely distinct from the window.

--PqO790nS3XJckojN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZwUVcACgkQJNaLcl1U
h9C57Qf/anLM6fkR7V3ipGaIA6IZ9KvtW2aPjW+S/gxRFwgStn0J9UioJk30jcC8
xjvCevCOqrWecc1aW6NyxzB0mh2iFztPmd1R3stwH/vcS0+XvwNeEsF3GMaNPuyT
sO4AsJgISQMcLOXaHjCwjfLfgkkRU9HurEmfseeYNL4jjTcDLQua1f1RFoHBqON+
rw6qtxQ+zdpuiXBF7arCGlplg7K4Zl/0GvtBTv7/UR8s+G7e2EsxINdgItRYTzvt
/TgJFnrwtbkJjWP8lrpnKBO6PiAutQ21AePTrTj8XqHQpxQPNlpaW2DaFJMKQ53U
+sKfYdAIhNVQWpGoGhgPR84hf662YA==
=z+Fw
-----END PGP SIGNATURE-----

--PqO790nS3XJckojN--

