Return-Path: <linux-kernel+bounces-208506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 166279025F9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B042C1F233EA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A77D84D13;
	Mon, 10 Jun 2024 15:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPXxitam"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CF912F5B3
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718034446; cv=none; b=D24BdDzfz000R9+OEdfNfWPJP6kKIeFDmLysn3TUhDYAsuS+oGTYAxlvzkgC9To7S824+b/ZDHfGRTXYyKII8c02o6bsdiTVnK+erZop+Z0rrtBI7izq4AgpE+AjJXgOdYqXM0peBj9SeOGLi/iyLfnZl+EvlTvYNJFA44edEqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718034446; c=relaxed/simple;
	bh=38t/JExcQpwmA9V33/BHVXcGuwHyn8JHlJSnIUEBdLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrxILJp3oLQoS4tihp1gleCHoJ6+g6EN2INju3yMLKSDjwlclz0H9aL6rDDKVhvN+YLQcfrQyLE4Axd/x7Ot3upQwqVIueNWCqyg98tPH8770fqSrvihRLVso8BrEFC/14xq6C3m4z6thumRxCgYSNTfeN55/77EO9NuxZprPhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPXxitam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694B3C2BBFC;
	Mon, 10 Jun 2024 15:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718034446;
	bh=38t/JExcQpwmA9V33/BHVXcGuwHyn8JHlJSnIUEBdLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RPXxitam7LTKlI1ll/Q9BA9FjLPW0XLN9HIsnJ9yF6BOxmLMWgGp9e3C2QwBaQmEF
	 NKLcO1C+/A1U8zP1P32m3ENNpB6dXWBUloo0THF525QA+F8zDIm3NtT0hVtGLTQvYE
	 7m/8uXRLqnpZ/deX1CLRjGsyh44S/VopN2Upff7xenLiqXoFWgUQX97IXmwdNA+0YT
	 YlEswTMihS3/eIbbkum7MKBA9Ot7DnvBExmA6JE1coCogt/X91YylOUzgTL7F9nNnk
	 JQFZt99WL+G25fQE0qp82giA5jB7yvOHeK2iDBd+/yu5n6277cqnFXqX1AhOjSrny4
	 Cj6ooLJZ5w7TQ==
Date: Mon, 10 Jun 2024 16:47:22 +0100
From: Mark Brown <broonie@kernel.org>
To: George Stark <gnstark@salutedevices.com>
Cc: lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel@salutedevices.com
Subject: Re: [PATCH 1/1] regulator: core: add warning for not-recoverable
 state
Message-ID: <ZmcgCmqDXAMtz6MI@finisterre.sirena.org.uk>
References: <20240610120025.405062-1-gnstark@salutedevices.com>
 <20240610120025.405062-2-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iidhu6ORF0fIzF/J"
Content-Disposition: inline
In-Reply-To: <20240610120025.405062-2-gnstark@salutedevices.com>
X-Cookie: Your love life will be... interesting.


--iidhu6ORF0fIzF/J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 10, 2024 at 03:00:25PM +0300, George Stark wrote:
> If regulator is always-on or boot-on then it's expected to be on while
> being probed so add warning if such a regulator is in not-recoverable
> state during initialization.

I don't see that these regulators are especially magical, and IIRC we
have several cases where we simply lack the ability to read back the
configuration at any time so expect to write out what we need during
normal operation.

--iidhu6ORF0fIzF/J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZnIAkACgkQJNaLcl1U
h9AIDQf7BA+yQBOoO5J91E4VKrU3HYSmE3MJrth7vuSVUXHjbG2HLRNt0aTzvjUV
dBAMAabfB3DG6ELBbduuA5hmfrOHCdI1/bbao7pAxXn1SxKVmGr+FVsUKrx0ZSAX
CwNwyJiqUuV9kMb0JYgmyh8q9okQBH06BQZwqNc6/FGmLyhqoEz9cU0s4qeMGXrC
J3IFHucGOPYWVw3aez5Lai1ZlogJp8aHW7p5DnQloEYyoUQ/2mxNxn54tna3fGqK
rG10J+gD8LxEWF0fb/NehMCLSQzz3nMS3tIFbt+2oGJZ7BLDqByjBlXxaT6u0Ptm
DWVxDI+ATGfoOOekkBSYniiQEI8Bjg==
=PCcP
-----END PGP SIGNATURE-----

--iidhu6ORF0fIzF/J--

