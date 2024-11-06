Return-Path: <linux-kernel+bounces-399045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3629BFA24
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 00:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12EFEB22A0C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB76020E329;
	Wed,  6 Nov 2024 23:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePV3VsEp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D19A20D50C;
	Wed,  6 Nov 2024 23:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730935935; cv=none; b=bf6UQSjBo4g7jdtMlaL4sW9DwmwBHfP0KA41oQN146U88PTWI6dOQql7RxOLGYSgMkU0X39ayJcj15Gjlx0+z7Rqj/KvrBSW50uiqidWYBDpgIUTGbqtCpOPfyR9HjyeJGIpderNEzMaA+YvF9PdyhIeGtraGYt2UJn0gDWn+gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730935935; c=relaxed/simple;
	bh=87Z6ChZTRDwcQKUGbg4OylOoY3jZ6CxKLD7unKaMEo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhPOyQikIjFPYufmMYdtqrHuhL3ZRADH89PGlmxJDQAKfz7/fVjDseybSWES6Xhbw6JGQlWrZZY8YfovYZ7tYqzFwAS3BW1OpjLyPT10+ijnV7UQhUV1mk4QSkVv0yt8WCBVAA9ICPZrcVjK/LsZ4z4DxDVC/Diwb7a1LyrkDUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePV3VsEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F8CC4CED0;
	Wed,  6 Nov 2024 23:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730935934;
	bh=87Z6ChZTRDwcQKUGbg4OylOoY3jZ6CxKLD7unKaMEo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ePV3VsEpc7HYjKBtU9kKj+FbpArK3+YDFH8Cb/YqSJln7HwBnSFIHKlYwz1rDmCl0
	 gjm1Vm3kI9bS+jXHm8Gl7H5oJ0Y14F3aBh/R0sg3T5Caj/kYambSfj/7/zlLa8vdgV
	 foyKSojlFuZMopnb0kcpy4EZKdlYqWVN484B4wxNwguEUoC9Rrzng7mNSQLYbZSspp
	 evQcF4nKtYPzoGtHpatd3YYPXPS85NE2XXtzwZX+dDayQUtezCxEbuhsSXX55KAh66
	 h2aYIw5L6iXo4nEZ5kv8eWuEOojEwRIcbqCVq91Fhmkau1HQhOLt3ZQf7dyb0qDMP8
	 EWuHTdPFBAZpw==
Date: Wed, 6 Nov 2024 23:32:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Ki-Seok Jo <kiseok.jo@irondevice.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND v4 1/2] ASoC: dt-bindings: irondevice,sma1307: Add
 initial DT
Message-ID: <921e46e0-1490-40f2-899a-f8562256d49d@sirena.org.uk>
References: <20241106005800.7520-1-kiseok.jo@irondevice.com>
 <20241106005800.7520-2-kiseok.jo@irondevice.com>
 <kspk7qajv7r5glbcawmecbup36cv4wi3hjrgyfyyejjectwwt5@u5nx5y5zirsa>
 <092cfb04-378f-4997-88e0-35c247b8c445@sirena.org.uk>
 <SL2P216MB2337334118683779C2FEABDB8C532@SL2P216MB2337.KORP216.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2kSW8dw7hKOyK1AY"
Content-Disposition: inline
In-Reply-To: <SL2P216MB2337334118683779C2FEABDB8C532@SL2P216MB2337.KORP216.PROD.OUTLOOK.COM>
X-Cookie: Include me out.


--2kSW8dw7hKOyK1AY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 06, 2024 at 11:28:45PM +0000, Ki-Seok Jo wrote:

> Oh, I'm sorry, that was my mistake.
> I realized the error and send it again using a script, but I accidentally left out the changelogs.
> I'll resend it with the changelogs added this time.
> Since there are no changes, I'll simply resend it without additional modifications.

It's OK, no need for any further resends just now - just try to consider
it in future.

--2kSW8dw7hKOyK1AY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcr/HgACgkQJNaLcl1U
h9BB/gf/YksRbOGZotMGDGEoCRc1ujhaZOmYBMw0k7mzc1O3IAyX7C7vtTCY4rhj
HHRqskm3vmGw0DE56lNOK9/oABkXkTnXGW6XX3lsHRcl2whBx3oW5cnPP1vOGqds
Uop28iRhBj6tcqolAWAmlTlNZOo/fkN4ai6qTVcodHlc1KjZGjE8MQxNO/6Dyr/Q
U7eh/ouyMpFjYUaK3PjXkfAe8VDhEaoRTKSKH04MfQA8e2PuPQc4Co1k7B2lbD/e
aWZBsRilxoXcAypGo9/JwGW/uPjFVALitFpAFzTaOzWYGe13Md/GsqFF9kBxBFXZ
uaaHZtI/dAeNct1iXOix2huMwogcSA==
=eONU
-----END PGP SIGNATURE-----

--2kSW8dw7hKOyK1AY--

