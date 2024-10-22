Return-Path: <linux-kernel+bounces-376194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB41C9AA161
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73831283B32
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D1B19CC11;
	Tue, 22 Oct 2024 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZWs795M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D091945026;
	Tue, 22 Oct 2024 11:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729597856; cv=none; b=QRRudxyUJ6UA2R6177b/sTjHRg1ulYfTUEthbQTrhGXkfPtw8gN7CcnbdCTVKUQfHLMnthtVfVy9BKP1ORtSBw62D5HgenbmJHyC2ChMf54CcEUDvNl9hrDmoIBeVjd89lX6/VPGoeCuZDuxKiFDIXSpmCiaH4bzGBLzp6BFdIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729597856; c=relaxed/simple;
	bh=Sb8lVQfAJSsNdgUk7lhkAOkHqbSB9Nk8K7CiMvOOKpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOw4t2W9Fs3AjB5ALeau5dOKwDSxJ7KTIgUA2zMGzfEt88SF7HouA4NP7I/5+XzQn4DwOG4Y/Q/5TV+DIz/9r54EDGi5YHEMlqwtS/gyEMlsWlnrZndUVcoUvQSkXZmIz+6sEDUAPJCEoDagrOmX32bYBhH1hdw4Tf67vt69LVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZWs795M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D763DC4CEC3;
	Tue, 22 Oct 2024 11:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729597856;
	bh=Sb8lVQfAJSsNdgUk7lhkAOkHqbSB9Nk8K7CiMvOOKpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oZWs795MQT1w0DT6/2vpliOff8Mzn1UvpJfZNWo1wirdA7QuMtPxFoW/di5iYIB1w
	 f/ibxuxchsGamv/70mBuIwEsleYrzQ8hwzpmCsKxJT1y3BLZ7ZgobfVGlRtQdoPt/e
	 iufrbyO4FFHPDT+Y33rzp+qpsX++g0+87sLRoxgBADABHYJyjdvOb/FQbWt8pLK9Ho
	 EunGArZFf85N4RH8mAiCwlB02gCR1oTNpfKYBr9muo4inIXVH6jpvdhGmEOwdqUva+
	 N+4OHGe+a7udkNqK8XOKasDM6vOG50pmYwaHZClJXW8Wo8opqDIQc9fDkiGH7K7420
	 LhQOQTeRUOo+Q==
Date: Tue, 22 Oct 2024 12:50:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>,
	torvalds@linux-foundation.org, ksummit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <1e89542d-6f9e-4e85-8292-ebb49091433a@sirena.org.uk>
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
 <ZxeEA6i_xfBMxJm4@sashalap>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tW+KPPurF5xfWQtX"
Content-Disposition: inline
In-Reply-To: <ZxeEA6i_xfBMxJm4@sashalap>
X-Cookie: Surprise due today.  Also the rent.


--tW+KPPurF5xfWQtX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 22, 2024 at 06:52:51AM -0400, Sasha Levin wrote:
> On Mon, Oct 21, 2024 at 11:48:34PM -0700, Christoph Hellwig wrote:

> The script tripped on the very first PR it looked at:
> https://lore.kernel.org/all/20241021171728.274997-1-pbonzini@redhat.com/

> And in particular, this commit: afa9b48f327c ("KVM: arm64: Shave a few
> bytes from the EL2 idmap code")

> (sorry, not trying to pick on anyone/anything, just an example...)

> The commit can't be found on lore.kernel.org, it was never in -next, and
> yet Linus pulled it promptly without questioning anything.

That was on the list at least, but buried in the replies to a thread
rather than posted separately:

  https://lore.kernel.org/86msjc56mi.wl-maz@kernel.org

--tW+KPPurF5xfWQtX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcXkZkACgkQJNaLcl1U
h9CjvAf+P1Mz5Z5SXtPL7pLvag2JEpEI4h5VZsmFHbx28rkfdwor/Ra2oz9Uw2Kf
HaU4zJpMSMw/1SxmmQTfdmblIr7qabYuhORM4Bn9EsqaT+FI+Xo5A1zBpFiNBHyY
51OOMuRu24FX+xoDVB+3o9wbyk/iMWeiSOOXBLyIDRESiqtWJf8N7rKEC2gqe8N4
G1NGRDnAT31A2WAN5ULycBL2ZWk+qlMsoARp82M7PQ8mpJqlRfkxHu5/Gmonc+Fj
0CZknwg19H71EVGRoVjVWQQ1+gfK5EAaWL2vGwcSbFReA6DAv0BN9+DHpNIZxSOW
cAl3qvMNHp6rZk0G2wBSvtUucG6h3g==
=KI/T
-----END PGP SIGNATURE-----

--tW+KPPurF5xfWQtX--

