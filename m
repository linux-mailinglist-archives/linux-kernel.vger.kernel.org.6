Return-Path: <linux-kernel+bounces-401672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C619C1DC3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7915EB21D32
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E075B1EB9F4;
	Fri,  8 Nov 2024 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2IyH1Qt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428BEC8CE;
	Fri,  8 Nov 2024 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731071848; cv=none; b=inQ0PBqhTXuqohKptMcwKV+CUmZaOZREf3fGk9ue9Dbj2dLGTnpdIVCIsLR9rqU5I31ixSYpVf/uJPUYW1LcPqaH1KuHk/xjyL9HuFByLfGCYgMyp32RSkQnarC2mNbS7gGIkK9qwZKa7FpeD1jK6Jdq1L6u9Is2628G6vzxEDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731071848; c=relaxed/simple;
	bh=vC0TAyJlOXn6cFQ015D58M/bwqDZZ4kC3wImliNAJM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cv7D93vKuyJpyduowtfP5hhfniyuQ4TYoCKtLQCu4r+M8EZ/CrAzPXbhsXFG1grZNn68g0R8WHjR7B6Q1QbRb3HqnIva/XO/jzLGVHdh7815/v5HIf8Gs+qg+UMS5ZMF31qHlyzmFrIeBnGl6Nl5+TrMOtnp297W4qrpzLvqR04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2IyH1Qt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC700C4CECD;
	Fri,  8 Nov 2024 13:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731071847;
	bh=vC0TAyJlOXn6cFQ015D58M/bwqDZZ4kC3wImliNAJM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b2IyH1QtfCpIF7YBbcZHB+eqjNq6isAv4c6thOxq1wEshvigBorfQ4vM200F3JPmO
	 a8nbcWFsnon8/DDq/oibJFIQxamATpm/Sj+OHVaZ5VD4ErVfpappC+uE3MnbaE5EOU
	 PsV9zCf1q3iDXxgP2zQ1RdaFooE88+fN2pVVZf2FzmNd/1g1OeG1tr9gjgMLBbnGeo
	 5CvRwLNclo4ahroEwbw6AYpVh0lq/qsYNRgXJlNJpPZxRbs7p0F+EBjYKeZxil/ShL
	 vqe8MtjlP2K3T5DOFezlz80OK7R5cWgr8FjpaOqEqrwe6ju/iZxhNmePDuZwypUWGl
	 5kdXf2aenw5Fg==
Date: Fri, 8 Nov 2024 13:17:23 +0000
From: Mark Brown <broonie@kernel.org>
To: anish kumar <yesanishhere@gmail.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, lgirdwood@gmail.com,
	perex@perex.cz, tiwai@suse.com, corbet@lwn.net,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] ALSA: machine: update documentation
Message-ID: <ef6719af-1b89-416c-8d5d-1c4a70a0a34e@sirena.org.uk>
References: <20241102073718.64040-1-yesanishhere@gmail.com>
 <Zyb8U3lSvYP0UeuN@archie.me>
 <CABCoZhAV0+MK6FEDRpojHoW4opfqNaYCtTrBTjA8O8+yurLr2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NBcjcDtZsYbRL3y4"
Content-Disposition: inline
In-Reply-To: <CABCoZhAV0+MK6FEDRpojHoW4opfqNaYCtTrBTjA8O8+yurLr2A@mail.gmail.com>
X-Cookie: Do not overtax your powers.


--NBcjcDtZsYbRL3y4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 06, 2024 at 08:31:14PM -0800, anish kumar wrote:

> Do you have any comments, or should I
> go ahead and respin the patch to address
> the review comments?

Please take the review comments into account.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--NBcjcDtZsYbRL3y4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcuD2IACgkQJNaLcl1U
h9DKZQf/ZQ88weCXu6eWl7CZxjbeFl1euriUAnSTdrRGPROmDfZWo4L0LqpXJp3d
ZO+kNFdaEkepJvmLhfXd0h597uPhNYalO7p6T1WPctnWjrhkMP5dSx6RqFPlrLbD
htdzbah1IrVD+uBg9IaMrMN0PgSZ8+4AhxPMnHozpX/1I8cBmgGyDDE6y+6S/VDq
Ja1XUordPZkmuUUDtzLGoX+72ZDof+ddVLiJLVyTZqIGDETJd/NfFjdanb7n/iJs
yBUAlS990FnuyOpS7KL+RkC9cKZmqSRo36KtiiTIwDFFlx4xpgDx3rAZt7rXaEJC
dtyHa+c1R72N72wpQ8k15p5UcfpcYw==
=NclN
-----END PGP SIGNATURE-----

--NBcjcDtZsYbRL3y4--

