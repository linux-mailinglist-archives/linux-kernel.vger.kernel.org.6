Return-Path: <linux-kernel+bounces-576997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFEBA71723
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 393963B0ADD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527EA1E5B85;
	Wed, 26 Mar 2025 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfYNuGLs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD161E51FB;
	Wed, 26 Mar 2025 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742994693; cv=none; b=L5e1i3n0GRjbh/gGvR4jl+mutGZ3Px73wcUlV37uk2r/5m5TI3uRbDwEP3z7FtX3K9dyaUGZeNFyFsrD21vN+B3curRKGgU6vGFkRYOJUAa7cUkViT2FpYsGXYGYapHGbu/8CSrGIG/IOKBc5At4ckmyMMvMFYZe8CD/kGrQKcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742994693; c=relaxed/simple;
	bh=LaAgaMOsAeeVuqB0y9G6CYTUHhwWs+IqOrVA91D4VkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQXdwnIPPfo9FMz6/IkZAv2FvFJ/b/oSwLcTfBGz21oVpj2N6mChlIIiXHyhpfOKv6kvt+V0+QNWwrO5HH7FFvfH9/6OABDL/q0ZThLlTGnKfNR6EXgRPBcyNDMR8UfR364QIKlmRhQjcRDqb7/dVnKpOw5mPLsd6JpI6KL/UxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfYNuGLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB0BC4CEE2;
	Wed, 26 Mar 2025 13:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742994693;
	bh=LaAgaMOsAeeVuqB0y9G6CYTUHhwWs+IqOrVA91D4VkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lfYNuGLsuLpSAnPBEMBR4QhYedf+FUaNiQWUpF+pMbS0AnjtYIX7h15kH+nf1aBUn
	 M6Q/F/qCdjDVjqa/4+c4E+dK8/zQnZP374gJ4Dp8wiA3Z+E47U9r3wYUrLOBaRvyQy
	 G2x2SdxIZRqBYQAYytFZWIGSTIQCI9IQoNj5Xx4SmxcgiXDQMP+sZvz8RHx00dOEJQ
	 9TSbnlTLTxjQXMXPlm3B1Wl+FOLJe1yyWcdmSJFojdi1e4RWXrGNYqlAhgFkUpbtmq
	 JSQArcBWBClrO0Dn8D+CVjctrWVpRO02C1TQGHC0nejvm08xFwOuWdyunGgLmYbbNI
	 B14Xx1luJuJmA==
Date: Wed, 26 Mar 2025 13:11:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, robh@kernel.org,
	kernel@pengutronix.de, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: soc-core: fix bitclock-master and frame-master
 present check
Message-ID: <7d202e65-0d02-4600-b832-595a759577c8@sirena.org.uk>
References: <20250325213455.3952361-1-m.felsch@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KvSty6ch2A3NXkJ5"
Content-Disposition: inline
In-Reply-To: <20250325213455.3952361-1-m.felsch@pengutronix.de>
X-Cookie: Ahead warp factor one, Mr. Sulu.


--KvSty6ch2A3NXkJ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 25, 2025 at 10:34:53PM +0100, Marco Felsch wrote:
> To check for a none boolean property of_property_present() should be
> used instead of of_property_read_bool(). The later returns a warning
> since commit c141ecc3cecd ("of: Warn when of_property_read_bool() is used
> on non-boolean properties").

This doesn't apply against current code, please check and resend.

--KvSty6ch2A3NXkJ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfj/QAACgkQJNaLcl1U
h9Akfwf+L2yY7mY1SBq2et9KKho0KpgDLN0StH763+JPT9QmXVlutE4v/xwmoE8Y
mNJd6b4yd6hhd7E9/xUPrm1u1w3lSOiGS2UycFPF0xVNExMK/YZqpciY6DNS8PWa
v89Bfv3rSICKy0e2GCfCIcHQZ42XZ7T1LWji2gU6sY2c+/Y2WC2G16A8fOMClcUl
ZkD2GS9nz4ia67XBc0Z9oavoxxpa+IuDXHTnrMDSEuFoMspqnljANel6meIL1SK0
a9wtzslZENXnJVdaOEEC3oF/VGOuFPvVmn/kV6lHdTGJbUzdzGElWCSkGZorsynq
HXId1OcgrfWxHygnHLWYjBR+fGT0EQ==
=55Sf
-----END PGP SIGNATURE-----

--KvSty6ch2A3NXkJ5--

