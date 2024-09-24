Return-Path: <linux-kernel+bounces-336862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEE99841D9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 341801F21995
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EAB155743;
	Tue, 24 Sep 2024 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iV8d04Di"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B351552ED;
	Tue, 24 Sep 2024 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169435; cv=none; b=Rgwg9pmvbh1m8xLBeOljvICZNR+j6lDnAbf4c9L9h/8wy8pVqu1ZgePqOZtwpTH9MI4sYJiDcdv6ewMU9W2W0gMUfhlqqoQ1HFu+T2D2mwrWXvCc1iv00PyXbwnrht4d7SxbRMJcJLRMfM9n5TTVwfM1OfpN4loK0S64LUfFTH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169435; c=relaxed/simple;
	bh=B5zSRQNFNomZZShsW2jsE1RB5SBo1V3wEcvrvwTUZYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7WvxLrfRaOsPG0eOzVcgxEHyDGbnYAiQzB6LZi/acvU4yjSHPfAmkHOcGvRnwaaXnoILnW2eP82BlcGg7aj8mNwwkADXb9hDYr9vnuJDhc3UvvmAn/kTztJCNtfzrML3cby7rRuMf/0FfXNXDayR7J5QzEl8qeTh3weeN/4bVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iV8d04Di; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D78C4CEC4;
	Tue, 24 Sep 2024 09:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727169435;
	bh=B5zSRQNFNomZZShsW2jsE1RB5SBo1V3wEcvrvwTUZYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iV8d04DipCfbGJqS89wNvqisKOXUAYPIx02qQtrAMs7uQKplA8uBJ2eRsw1jEu0iC
	 0+YOKcUzI6qy6oj0KMh1vfyQlCG3Mh/CuMuYrSWjksMhr8VcZn0dvVU3HjCzYRFMNI
	 90TtbhGhr9o8+inGGGINaS2deZmC8zia2cMuiTCZ/gAag3o0mnTeL15iXqUDS1G96M
	 oqfx6e+7YGoZLZxyxsPrx3LRbx5lL6g9qSouwjzYjsWWrdDTqC2asXVjr//yAE9BNh
	 J583te1M4zF/WKRMcKfsqCUBKHGfZ4j1SXTsBiK8zEKyDSj3xLe7MdxhGgpSSbOHaa
	 E6LAlGvDIzv/A==
Date: Tue, 24 Sep 2024 11:17:09 +0200
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: vkoul@kernel.org, alsa-devel@alsa-project.org,
	pierre-louis.bossart@linux.dev, yung-chuan.liao@linux.intel.com,
	lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
	venkataprasad.potturu@amd.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ASoC: amd: ps: pass acp pci revision id as soundwire
 resource data
Message-ID: <ZvKDlYwZRikFwbB6@finisterre.sirena.org.uk>
References: <20240924081846.1834612-1-Vijendar.Mukunda@amd.com>
 <20240924081846.1834612-5-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HGCXSJI3QLy/wo0L"
Content-Disposition: inline
In-Reply-To: <20240924081846.1834612-5-Vijendar.Mukunda@amd.com>
X-Cookie: Editing is a rewording activity.


--HGCXSJI3QLy/wo0L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 24, 2024 at 01:48:46PM +0530, Vijendar Mukunda wrote:
> Add acp_rev as structure member in acp pci driver private data structure
> to store acp pci revision id and assign this variable to SoundWire resource
> data acp_rev variable.

Acked-by: Mark Brown <broonie@kernel.org>

--HGCXSJI3QLy/wo0L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbyg5QACgkQJNaLcl1U
h9CZkgf7BQHJTT8YqbIGugXWAF7sjxgyA+AsPM+rJqOLjVx+34K3IWQV4VwWhltW
mmGSGmSieEjlvNMdEP6qvfF/s+gLhUHL+6ay9GxetFlF6YImtyb5g112qhJmhQkg
0Wei209F1bxar6FLzcGBRMC0qtsNyWwo88CdX4oh47aIiywtY77RCknwO7/VxGKm
5fNXXLvfpKIcDHt7xmU6PGisgoOO8rY3dze+GznqUyLCWaNtcVUhbFJJ+CZQ1ui6
NNt/QQ4ciEdxYo1lpVz6Z3G8OGp29+N12uoPDsmUFkOASOxYMRcDwBDeb6DQ63wM
FzUsOdZ+FzTjoGIduV7zM09Ckx/zyg==
=iFEZ
-----END PGP SIGNATURE-----

--HGCXSJI3QLy/wo0L--

