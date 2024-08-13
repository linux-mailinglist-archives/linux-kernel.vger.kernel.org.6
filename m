Return-Path: <linux-kernel+bounces-284523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0741D9501E6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A519C1F2133A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD3413BADF;
	Tue, 13 Aug 2024 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2z4qhjK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C225D187341
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543384; cv=none; b=UWaZcFiuJqoZufE/RZ6OYtylFM/YURaaiECGv97ye7TSg5QYVNFh0Ksat1RucRnAmc1qNO3QwwIuhmBddEcD7xkcblj4CR9N2v004z0tASFR1qlXOksR0eK+b/HRxkzQH8bqfVoj2boqqqHEYAx5sVnvng4XTHgNRrjvHMjIWRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543384; c=relaxed/simple;
	bh=HwzAsU7YO/FWigdWTPeyxgXbNZygjqtSIuJaEPoKu7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boNDNTxaFtmxZEVUIhIpKo3K6qBK7d4lQOw/3e7MNjNAdJUdTXrv5Tk4EKPNpJvySTEGRpw/RfIFOfR6UuA51A5XqSThb5AoDcxreI1YWwMD+OiktFTHc0kdiqANSYPfg8clahjRXF2wdfOXlROHcmupXn1qKp5M2k1Hlc1tFtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2z4qhjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCACEC4AF0B;
	Tue, 13 Aug 2024 10:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723543384;
	bh=HwzAsU7YO/FWigdWTPeyxgXbNZygjqtSIuJaEPoKu7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E2z4qhjKAdEPbPph4udmyesMApDWzaxyOzUdtlB7Okz3u1NOVzqGctwK5jeX9iRBl
	 vQIxJsXpfwIOO2otko+jYqRi8dgxyifdn6+qD63MtolvWgzGiYc6i4CM0Eh4mqx+ul
	 SLi0DKxjZSaJxD7wsOH9rJ7qWMI71B6yuz4/qpmyRP0/KjEyKsj2130lG/7DLekuoN
	 7nky+cUJkl5VHB5v81z9Ho2Wxhg4CrwpsTEy75Uy8yIVYMP0JW7f31iTaAQjZVrMuk
	 EK/l6VCGl/2ekD67EoJv3JyMuhcxPmFQImzsj/n5pMfKBo2JdFsJo9CiyLh7vGMqti
	 qZD1ufqf6vTdg==
Date: Tue, 13 Aug 2024 11:03:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] arm64/sve: Remove unused declaration
 read_smcr_features()
Message-ID: <73535167-e87f-433a-9483-7465d6dbe59b@sirena.org.uk>
References: <20240810093944.2587809-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="voBxZRVb485rVedi"
Content-Disposition: inline
In-Reply-To: <20240810093944.2587809-1-yuehaibing@huawei.com>
X-Cookie: Say no, then negotiate.


--voBxZRVb485rVedi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 10, 2024 at 05:39:44PM +0800, Yue Haibing wrote:
> Commit 391208485c3a ("arm64/sve: Remove SMCR pseudo register from cpufeature code")
> removed the implementation but leave declaration.

Reviewed-by: Mark Brown <broonie@kernel.org>

--voBxZRVb485rVedi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma7L1MACgkQJNaLcl1U
h9C8qwf/VPNbMoUQ4rFKQ6N2nhS6BSJLgUSWw49FnAG6FwEfzVAsMxAWaBAMbmKW
MSLoF2a3lUXZ5E7kIA7Zkxd3pe7xAm9XfBjesV1d30b8VKp3lwn4c7s/WnYlQuaT
ndIgUlz6Z4s0+DVZA9yePb9kBntkkH4TG0HtkBQaYI9Gyr+nr+f0skx5qApwm26k
yC1ELy+bTOS0t7L+RGWCTC1fEUrSEXKKSwzyaZAGQQCYw5ypw3aqk6nYaU0bMYyb
Xph1o2v1czz87PwIDaZe15W/uYoKuIoPjeezck/wVkdp2VheyWEjfzqIMa4W4sc/
1NnAy8n6oCHy5K27OapaBIPOoUW3Hw==
=Nbc1
-----END PGP SIGNATURE-----

--voBxZRVb485rVedi--

