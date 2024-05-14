Return-Path: <linux-kernel+bounces-178559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B738C500A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4E81F2148E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA4C135A69;
	Tue, 14 May 2024 10:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvOp/pFy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB26134CFE;
	Tue, 14 May 2024 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715682874; cv=none; b=jGzkzXjxHj65fMezAg713gZAOr2KvBqA3I5k5AoSElv7/xNPighj9m6E+6vNNqlbpR2RDVQG82+LNySNCgr2sfT7W1TAhD+d1fKPF+i2g794vq7ODx0QpGJaT/5YMh6i54hFr1w+yeG3hH1merjWeorUm7WhaTcbyx6ho2WDGBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715682874; c=relaxed/simple;
	bh=2lrkl1lFNHIBsDSw+p2YgF029NTbqBJ5zGIBe+tbmH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mycr0C6oSTHKMnSAWQuVn3OStHe89NX8hLkXWuq1XJrqEYh3rDR6Zs/yrr30WVnIiuGeCE0I3W4sbjEqHOcfTOWZu9KJ5fY4vbOFDpzuKV3sQm+AiPEqfPjx1Dk9zxU1zqgowmQBgI8piezdGo1LNszfOoLQtKSaxXhPKvGCJps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvOp/pFy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BBFC2BD10;
	Tue, 14 May 2024 10:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715682874;
	bh=2lrkl1lFNHIBsDSw+p2YgF029NTbqBJ5zGIBe+tbmH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jvOp/pFyUAfAccjJJypQ5iFW4gg63KXnS5UdHRn9osCZeG8LNCcfvvHxVBMP/Jinz
	 hmAKkH9TAXuLLGWsBgLFo6/eGC9LsFS2xWCdo5X3vHdtNOMdP+CHJ73ez8uS1mA5+l
	 2gl19pYZpoJgzmUMZzXEf2y0eJRzQrLVo+ni9h4xP7RetnAfD30Gvbs0hhUYLyY7lc
	 PEUdOaHkgvdD/7oL/KkgM8iQt9ntyBU4cXsUIGAwYa+nlwE8/y3fxJDf6hYJLwJnbo
	 J6/QHXPRtJFqv15nPCpBpy0ho5JjVrX5Id9vlIqvEdj7x6XXS36DLI24u5EaKWGzm7
	 5w9nhoWlB2e4w==
Date: Tue, 14 May 2024 11:34:29 +0100
From: Mark Brown <broonie@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Alina Yu <alina_yu@richtek.com>, lgirdwood@gmail.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, johnny_lai@richtek.com,
	cy_huang@richtek.com
Subject: Re: [PATCH v3 6/6] regulator: dt-bindings: rtq2208: Add property to
 get ldo of RTQ2208 is adjustable or not
Message-ID: <d97752ed-4032-4681-b28f-17f149fdc3d4@sirena.org.uk>
References: <cover.1715340537.git.alina_yu@richtek.com>
 <6a3a90d9aa2022dfb92e124e417f3e72c2f28b0b.1715340537.git.alina_yu@richtek.com>
 <20240513-tissue-repave-13d2e3bf88fd@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2yJ6nVJZYiZJOPrs"
Content-Disposition: inline
In-Reply-To: <20240513-tissue-repave-13d2e3bf88fd@spud>
X-Cookie: In the war of wits, he's unarmed.


--2yJ6nVJZYiZJOPrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 13, 2024 at 05:22:54PM +0100, Conor Dooley wrote:
> On Fri, May 10, 2024 at 08:06:25PM +0800, Alina Yu wrote:

> > +            richtek,fixed-microvolt = <1200000>;
> >              regulator-min-microvolt = <1200000>;
> >              regulator-max-microvolt = <1200000>;

> I'm dumb and this example seemed odd to me. Can you explain to me why
> it is not sufficient to set min-microvolt == max-microvolt to achieve
> the same thing?

This is for a special mode where the voltage being configured is out of
the range usually supported by the regulator, requiring a hardware
design change to achieve.  The separate property is because otherwise we
can't distinguish the case where the mode is in use from the case where
the constraints are nonsense, and we need to handle setting a fixed
voltage on a configurable regulator differently to there being a
hardware fixed voltage on a normally configurable regulator.

--2yJ6nVJZYiZJOPrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZDPjQACgkQJNaLcl1U
h9A6rgf+IUYfQW5892x2qJJ3Racl8hbGhtW1RaVRQl36Zs1rAHvq24wQQlhnHMA/
XuN5J4H03dIl3ENmjY/jXMXxxAUjtScr+rIbGzlQDBjYwu5/fSlouEud8vs+lMcd
+j3lF0PYPCsehqOirejb19Z1uecY9JUlfvdD/exQahL5UNY4koOBNhsi9TTgrIg/
skOUh03sqrz6yfysvT+zqNb0+FYz6XiQY8tuGk37Nxmul9kt01ZiR5O021B4PGSH
s9FTFlIgikPJbYbq89trox6dH07Jxa/rW45iH8HLCUXMLyLdP+7WQRpKvoqqGqCS
KPuoi272ta1W2GQTDdZiKlc6QHdowQ==
=i+rQ
-----END PGP SIGNATURE-----

--2yJ6nVJZYiZJOPrs--

