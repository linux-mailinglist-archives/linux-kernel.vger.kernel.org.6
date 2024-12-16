Return-Path: <linux-kernel+bounces-447550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 658909F3413
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5018167498
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D22146000;
	Mon, 16 Dec 2024 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfS4F8tV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2EF137775;
	Mon, 16 Dec 2024 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734361740; cv=none; b=cGSGyrbxsUnib652pHa/rZ1xS7sr1bxfJmG3ADyVqHXC9vzBXljft6m4HcodUjlRlsMVpnoxgubk6OGL2S4aak2Hfjzb9wN0ZjkapHBZqOijDIlwxWWVKBxr/OLWmrtcS91zH+vOXjJbsCCP9WKkupPvb8TE+hrbU1qRsKM/05g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734361740; c=relaxed/simple;
	bh=X6zUya9s+jpslx9GY5F9E0ZO6Cz3S1RvPAQFQrp7068=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJSrHmj1fWDUY5gcpJf3YK+j0U+PuilS210pz3BycZX/olMee0sIt2exfxkG10vUSqA+f7mNaUIoJXQbASNzYNEduzh6EPTKWrKZ99BbmYnGFAqdLnDvn9r/Z+olst3hnzSUp8BuEqpOXS9o8qJ0qfzgodzONo2K1+tF+sCTLaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfS4F8tV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174E1C4CED0;
	Mon, 16 Dec 2024 15:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734361740;
	bh=X6zUya9s+jpslx9GY5F9E0ZO6Cz3S1RvPAQFQrp7068=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NfS4F8tVEJm5MYu2FxSi/SCFs1BhbsRJGqendjItcvBSuUUR9j0i72eVtQ/0zmx3M
	 TANcgSOTpmJy4LyMuxAKwauxmFdr6dYCGcxT9mZYEjcmDBQcM5B9leso7OrM6CV/di
	 YKHvyP8yyUU/F34M3rbuKorepSVIsfRm0gC3mVyyk2AhW8Tm1iSzkM2BC/B4rIRQkN
	 O45Yh59D0AjBJC0AdUjLQir7W8QsDmGxO4NB+7qpNRrNEx1oSSHtjpUKEVpsAJOcid
	 lerPCJUg1WI+hHHBODG7N3wxVTFOWDt1z8DcaQzVa87lH476sKXDtgD7UXIcoNNstL
	 t5aBYzIeEWRlA==
Date: Mon, 16 Dec 2024 15:08:55 +0000
From: Mark Brown <broonie@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, maz@kernel.org,
	ryan.roberts@arm.com, Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH V2 03/46] arm64/sysreg: Update register fields for
 ID_AA64PFR0_EL1
Message-ID: <b5d96df1-3c02-40a7-833b-6a42183ec972@sirena.org.uk>
References: <20241210055311.780688-1-anshuman.khandual@arm.com>
 <20241210055311.780688-4-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8v5qYuuiozRiGBYl"
Content-Disposition: inline
In-Reply-To: <20241210055311.780688-4-anshuman.khandual@arm.com>
X-Cookie: Be different: conform.


--8v5qYuuiozRiGBYl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 10, 2024 at 11:22:28AM +0530, Anshuman Khandual wrote:
> This updates ID_AA64PFR0_EL1.RAS and ID_AA64PFR0_EL1.RME register fields as
> per the definitions based on DDI0601 2024-09.

Reviewed-by: Mark Brown <broonie@kernel.org>

--8v5qYuuiozRiGBYl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdgQoYACgkQJNaLcl1U
h9DaIQf/XyfoZhpxuUw+kmbgwoAn0Y0Y7YbIWmIoN7+40pdMnDJLoBqtPp8wkjxe
ZxPYVrTbIfJNQqSj+sKpLAi0VWREbvEZgCP9tbTT5kNHJVF9naZ1PrBUsUgrHA5M
vSn0GblRNv5Xu+m0yZc2Pvjup0m5BkF/Oz2EdNbUA+yfWKgPZNEmkR9ZmcJh/eB0
QPmm4qgs8Khabo1QmeBOXegB6uAwp72aC0OBxngrk4ozRcWOw9aU6xWoKwHPIvwL
GVPo0ybKZnJ3sy/Jz1tCwLJnrm3sBGzU0f+CyfJuOdca9LnutLA2X7p0RQJ32PQY
EOlghR1VJAgePl1/tagqqf6JvR25xQ==
=2hzw
-----END PGP SIGNATURE-----

--8v5qYuuiozRiGBYl--

