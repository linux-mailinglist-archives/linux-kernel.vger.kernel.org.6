Return-Path: <linux-kernel+bounces-169019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CECEC8BC175
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 16:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 806C61F21468
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 14:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D23A28DD1;
	Sun,  5 May 2024 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ME86TJqO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9F41DA3D;
	Sun,  5 May 2024 14:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714919864; cv=none; b=oSxofkor/9+ipoVfuDlNrZhB0XBTaOxOaHKyaCGbMyGDwaWX9401yHETnwGezS/h+BJD290xDebSTktpD8FXpLVonlNL70fr+z9H0UNpQaTI3RLSc4x+Z+mxeX/CBt3CgbfrRzCnZBqb8yACR+Cgcw7O/UWwdW/+1q0pRCpTe9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714919864; c=relaxed/simple;
	bh=rIPum/FL5LeMcCcKG4Ukuj0FvMTsFLCFQUeQWnP4g/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+ecAg+F7UBfLiUY4aG9hNatUAtTvCqzWrIgFgGscElW6eTt6xX4dNlRsCd/VCa647M3TlUyNP48gmzJ/xCVPKevBK1AVkkNLctZHEiPJyqVfC7mFjadUIUHSSA6b6PkXetsVXtLnibfWdMeu36GZTSN8mEKeXv6hKZogDhKnCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ME86TJqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52354C113CC;
	Sun,  5 May 2024 14:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714919864;
	bh=rIPum/FL5LeMcCcKG4Ukuj0FvMTsFLCFQUeQWnP4g/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ME86TJqO6LIWxxFZtpCONGaZ04hcxEZnyGCFlNWhTwMaxtAK56mCU/Tiy2M/0VNFL
	 i738/LJLn/GYdNuZJXap5kG0YuK8Zme7Hm+ECwn9uHipeZplljBckgekjMQPag5lzs
	 Qc7dR+Q/yYrQfKE6ooPmuLECGNJqy8hZ7WUyjq++qVIpW0SY83yqf4KmWWdP8hZP/C
	 Ua2gdNRTsWwP0/xPEDvPPjwwVYuNxBFO5/kRnoOyBrIQ+KfhVoxdIVnxdKNZF4Uug6
	 Oc4zwnHHcPLusjs1Tb9OATHp2M7DH9h/I4/N+ON2oIxXXKhyU/REY9dRy4z4bl7ECm
	 qHvIjrLVTVDRg==
Date: Sun, 5 May 2024 23:37:41 +0900
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	"end.to.start" <end.to.start@mail.ru>, lgirdwood@gmail.com,
	tiwai@suse.com
Subject: Re: [PATCH 1/1] sound: Support microphone from device Acer 315-24p
Message-ID: <ZjeZtXgs84Y6ukW0@finisterre.sirena.org.uk>
References: <20240408152454.45532-1-end.to.start@mail.ru>
 <171268609844.62778.6340689132993321193.b4-ty@kernel.org>
 <9a683d7f-8bde-47f4-9f63-97b65744711b@perex.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qN3lN1697Vc+bRLk"
Content-Disposition: inline
In-Reply-To: <9a683d7f-8bde-47f4-9f63-97b65744711b@perex.cz>
X-Cookie: lisp, v.:


--qN3lN1697Vc+bRLk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 03, 2024 at 01:23:28PM +0200, Jaroslav Kysela wrote:
> On 09. 04. 24 20:08, Mark Brown wrote:
> > On Mon, 08 Apr 2024 18:24:54 +0300, end.to.start wrote:

> > [1/1] sound: Support microphone from device Acer 315-24p
> >        commit: 4b9a474c7c820391c0913d64431ae9e1f52a5143

> Shall we really accept those anonymous contributions?

I was on the edge here, what pushed me towards accepting it was that the
change was just a data based quirk addition which is almost if not quite
a trivial change.

--qN3lN1697Vc+bRLk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmY3mbIACgkQJNaLcl1U
h9D2QAf+OiMn33FIcy3GPYrEa5D9jknEuuokne8mUn80hPwRpNOvHA6Tx0xRj20u
fNPeECswt2yZNoI/wgito13RlG0ODbltycO82Ps4C/S5PxP951IWU6O88/VbIcq9
Ng15mK3V+PaSusUUWnj5TM75lPmESeee/2Z1KyiJYgnA9/K/neK1xcKcX8cuAcc+
y1EWCQnpFWdxqytJcloN5l6JLtxyOJPtUTW++5OdFLfMBwezXg3DchVWz1el4efv
UMKb//k8X4gDrbLA4ctBI7jTmhOyF7eq0lPaIBLWq1kEIZj7XxsWM54M8g0Oqdq2
BxEJxWMgdJdbL63Eaf5G6PghFperCw==
=0K7l
-----END PGP SIGNATURE-----

--qN3lN1697Vc+bRLk--

