Return-Path: <linux-kernel+bounces-439569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE38B9EB131
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B038516AD75
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CC61A3BDE;
	Tue, 10 Dec 2024 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnWDBIqr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9A41CA9C;
	Tue, 10 Dec 2024 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733834989; cv=none; b=n8Jpgx+X5RbLY+54Fczz7kXHJd9+OMZCE8evjrNTu0SALhgaeMkU8zWuFSBvKkED/6xeKt4930/1TtYfo/Oi2Q/syAidjB3eFKcs2IOaEZw8/9Dqtkoev58eF4KhjuyL7UroiGDWYVbRAVMXyKztDcvWziXHB2ZxXOAXJ7CR0iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733834989; c=relaxed/simple;
	bh=6DRVWx/oTZ/HSXX8/r6zYQ4afAvdDrFtVo99mHGCx9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5Fuy98qjEVm1CCKgKo7KoIzg8VZRUVFAzFCw8YIzVjzvMIhBMrLn6bWYodJWKOX+E8RG+/P/PRmYq6ACce8mGB9XBsAvqiQ5J7c0A6BlX2rYnPc6Xl/+dAK9d17AWIks/roiLFJ3Lj9XLx5aeWZ4AGRs99CHZw+MN8wQ6Axnsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnWDBIqr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29DDC4CED6;
	Tue, 10 Dec 2024 12:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733834988;
	bh=6DRVWx/oTZ/HSXX8/r6zYQ4afAvdDrFtVo99mHGCx9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HnWDBIqrXNhCFCDIW4Hc+bIlLae0i1m+THLpHfJ9AZPlIiHMhFWE44I1wc9DoOj1p
	 FTxYasyeP0FcCbHT4XAgC+7KU2OWFW5vUqfIqTpSzdyRTQaTafOFR6RbsEQnVW+4H+
	 tMVaBGqa+aer2k8wNRJH8yK8GaXN4lshQrP12wLHRVoCpA8Zh6/sWojBfpboSKXCOn
	 d9Bw2VZSRIVdIOrsK1ohrUyvebWQQuPAWESxUnDw5JXhVaQcxx3hVujaGAtRnUZCDB
	 8quh5AqYVJnufMMnD2CF6mkqS0kXsyMM6SJg0pS3m3LN0qjjTxxdL+P13W5cPJWjHS
	 KJLnwBCoF8OdQ==
Date: Tue, 10 Dec 2024 12:49:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Subject: Re: arch/arm64/kernel/signal.c:1046:36: sparse: sparse: cast removes
 address space '__user' of expression
Message-ID: <826bb270-1024-4ada-b914-46b21f2b0e66@sirena.org.uk>
References: <202412082005.OBJ0BbWs-lkp@intel.com>
 <Z1cOs2sGff1_TtQZ@arm.com>
 <c8379d04-420b-4039-99ce-5a462d820685@sirena.org.uk>
 <Z1gh809HUGRZI258@arm.com>
 <4fb5acc6-350e-4f7b-8512-4e1799cb2a37@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l7czBKVomfbf+tij"
Content-Disposition: inline
In-Reply-To: <4fb5acc6-350e-4f7b-8512-4e1799cb2a37@sirena.org.uk>
X-Cookie: (null cookie


--l7czBKVomfbf+tij
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 10, 2024 at 12:33:42PM +0000, Mark Brown wrote:

> Apparently the rune for this with sparse is to cast the value to an
> unsigned long (type safety for the win!).  I wrote a patch last night,
> should be done testing by now.  Given sparse we should probably have
> that cast in write_sysreg_s() be to unsigned long.

Actually the patch was sent last night - it was another patch I was
waiting for:

   https://lore.kernel.org/r/20241210-arm64-gcs-signal-sparse-v1-1-26888bcd6f89@kernel.org

--l7czBKVomfbf+tij
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdYOOcACgkQJNaLcl1U
h9BN9Qf/Xw+C3LWpD9ki6EOYm/dp3O/JcC7EqmViUCHUZImP07xE/lsSfXfl0G0A
BdbgW00rE4FoN/AB17gvjOkunUNAjclFzEm7SUnaKdQcjXZ7JIzhF4N8J+QEuemW
ZVpxuVNKd+Dmxk5Q6Z9nlmrnb3f3WjlShbIvw5t7cRpsPa4B22He0jFqoL8fEh1u
Ucs1hcj1ckPmLQb94DJGoWON4/LRW6ZVs4s1uJw0/G4Q16AVlK7XAL4aPw97EUp7
FTA8KuA7/zmcmfRmPMo8CYih3rJQ9WKqcBqU7hzOSHi0rcMMHxpXSYbMd/sIxaeH
xbYEKcWCDXvH0jsK5aRyNwlGOPC9kQ==
=gLg7
-----END PGP SIGNATURE-----

--l7czBKVomfbf+tij--

