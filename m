Return-Path: <linux-kernel+bounces-366174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5DD99F1A1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7D21C21AD8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A3D1F76DD;
	Tue, 15 Oct 2024 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+X7X8UH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E05D1DD0F8;
	Tue, 15 Oct 2024 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006893; cv=none; b=Ia7XWlqCE3UAHdjxg480wmnfwXUnaIYnA6Ff7rM+duiSgTxIhan71dRX2FL9MRKN5nP4NvpYFeM5W9QoojbmgXam1dGRhDNDSUWk4/SsJ3iCptODm94B5clwpuak5YnxPWTSWMyH0u6UwYZxk1Ik+DRo7zx2R7huU69Pr00zmkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006893; c=relaxed/simple;
	bh=jLKAQ9uXagsJyhH6n6MG/G9/BrDcU+zfGa0vOh67cIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGFCIOudip9dX9d2oljFus5P3ZtYPiPUBwtUH5QiUet/3tDA/ypNzO3/Y4tTGCTPXpMAhOSAB5re8c8cYpuMg445qiLDtUfXOqmwkXVo25ON3h0O91KMt/1OgDbZnvdm3+l0SptrhV52NzPgbE/2PC1JBEztR1sMA3maw378d+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+X7X8UH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80581C4CECF;
	Tue, 15 Oct 2024 15:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729006893;
	bh=jLKAQ9uXagsJyhH6n6MG/G9/BrDcU+zfGa0vOh67cIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u+X7X8UHEd3gozYGyuMwL/tAC/R4zlxoKUwcxrbwDS2Z3cF+8s/7h6AHH6w2JR1oX
	 1Nh1D+L4buWKaMaT3ZhLrFVjk4ZcQ1yqbIoAVngBeohUwI0u3/XGcpyJ0cTJrgWk7I
	 IK15mSYsmmG2AaSbnQ5zcmezmsvE7wF+b7kgoEX/Xarb23ECkneLt15BHX5epzyaQr
	 HJI0pfqjyrztp1TBo0iwtvI8v49YnpufpzLJUvIevYLkK+65R1Jn8/1d0UQa6fLc+T
	 xsT8XYWHT3KJBi2g6GYZkMX1LuUu2V8xuPm78+EC6UoQf0V+pdauARp3HL53AuwORa
	 xykZ7Nfzz8XWQ==
Date: Tue, 15 Oct 2024 16:41:29 +0100
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?B?0JjQu9GM0Y8g0K/QutC+0LLQu9C10LI=?= <ilyadud25@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: amd: yc: Fix non-functional mic on ASUS E1404FA
Message-ID: <4ab081bb-682a-486a-96fe-99fa65642f06@sirena.org.uk>
References: <CAPsZJ9WXAeEW=oPKn2F9zC8GHwoiQ8Ly93480c0oxjY9xOCsUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fbymosMKjkYgxEwX"
Content-Disposition: inline
In-Reply-To: <CAPsZJ9WXAeEW=oPKn2F9zC8GHwoiQ8Ly93480c0oxjY9xOCsUg@mail.gmail.com>
X-Cookie: New customers only.


--fbymosMKjkYgxEwX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 09:01:39PM +0700, =D0=98=D0=BB=D1=8C=D1=8F =D0=AF=
=D0=BA=D0=BE=D0=B2=D0=BB=D0=B5=D0=B2 wrote:
> ASUS VivoBook E1404FA needs a quirks-table entry for the internal
> microphone to function properly.

> diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
> index ace6328..d06c162 100644

You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

--fbymosMKjkYgxEwX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcOjSgACgkQJNaLcl1U
h9APRwf9FydkQxwYuJDT0VWBk6snQI3/YH7Px2YYfc/4cpiIkJtckv0TMEc6Z1pZ
6blTtj9k7wrVc3/MpQUr+eoG+XVjMbz9NTt9D6WtlKkIxa2Jmps6ZI2ih2fKZgXu
S35YH2JscfdR+KaNejocgCe4DQ2mDSeg3rcChpmaYwzPfZL1BWMCzwyuodmO4IoW
aKfmjIaziFqGSDbX3x+gA9KrL2sNW50yHhJ+e2bYRNm+fxKgBxQ/Oo0pjcNU48i0
Sc931/va5WKcdRMF5hKquv5TDzkRvWCofXFXob3zAtBFuDksIP7cmBm+VLv1eRw7
2KtojEhmz61wISh+r5KMXOrVF7O4Tw==
=PiWx
-----END PGP SIGNATURE-----

--fbymosMKjkYgxEwX--

