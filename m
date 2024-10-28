Return-Path: <linux-kernel+bounces-385152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 258BA9B3332
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576201C216D3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200AF1DDC34;
	Mon, 28 Oct 2024 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRN8MyON"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5E31DDA39;
	Mon, 28 Oct 2024 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125137; cv=none; b=Rfv14YRw66VI4YCGqWx/pvZ/aC1vpSHN8ZGhv8iBjBGMQAfWp3pxUxVSZSOnoAGsb8BuaNlbpEZUjcsTvhV8JoPG4TMUhxRi9YY+Vse8BOf6GBY2C5iVRRMDpUqagrSpmcwK28fpBsv0g7AQJfj55q/zdlg8TMNvnBzLHRkMpMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125137; c=relaxed/simple;
	bh=JIKKL1cLSsz4MNWiUhvmNoS623Vj9EiVYOebMzOBo/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plU7OtLPWEqPpXtb1BqYsrfiZecsq/qiVe6iETSQSR943QNvIcIhHhxSLktnv6nD9GdofVseQFX0B9dZIjZ+SJ+V3kYzYQ+dn9WRUdvvLGs6kv5zhRGlNpgpepfGUrOsPwqmfwFZwycC2rfH5VhYGHzloOl7009m2qnyasmdPxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRN8MyON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B54CC4CECD;
	Mon, 28 Oct 2024 14:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730125137;
	bh=JIKKL1cLSsz4MNWiUhvmNoS623Vj9EiVYOebMzOBo/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TRN8MyONnS0XuYTn1dgwMW8M6WTBY98WIjUD2WQ5bRRvYZrI/u8pxq16RY+jizYJ/
	 9OcmjJIs8KXt2wUUusL2mLwmGFLd5K24dlmcujIo+IHckoVQ/5fXbFY8W1sOqAKYwM
	 fFYFa1oA8rpAPsTTnvZV1UcARTA/dqbnkjnK+PU6zaY2jGO3LBEZhDxtNpcDAmixbF
	 z2MUVlgDCv9oxYUaulEHK3fwu1ZYddB4O44HsRruNh9lwWXPrPLIDjYzFV+eu8htSP
	 syS5RFbjrOwUzfndwS+L/eDOGxdngAngBCBzryEiFkPt1PwW5qWES2RIKRoiO7TdL/
	 mcmw5EXAJIapQ==
Date: Mon, 28 Oct 2024 14:18:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/137] 6.1.115-rc1 review
Message-ID: <94541de1-ec63-4c85-9d64-c516832e9f99@sirena.org.uk>
References: <20241028062258.708872330@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C3G6PrXajPXaYJTQ"
Content-Disposition: inline
In-Reply-To: <20241028062258.708872330@linuxfoundation.org>
X-Cookie: Remember the... the... uhh.....


--C3G6PrXajPXaYJTQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 28, 2024 at 07:23:57AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.115 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--C3G6PrXajPXaYJTQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcfnUoACgkQJNaLcl1U
h9D3CAf+NjoXTiG+A4WCUjWojuDPM6CV4uQzOSe8jK+4TuXitq/FWMA6YBngya5V
2EKsiY/B45ph+rcg9EE3YKLn9YUEDQcHe1Hc4Zjlnzz+5AAwNMe5GBnY3iA/Tn9k
eZk5kjc+pu35Qj6OjfvR+YcqxzQ+2QXcFTMefklKMDUGHR5KKYm20k7Z4YaAGoFT
uGnz4qQZP6udE2Q936pxv6L3DMmDg4P3YnqYOiueqJeOzGrqQIXQLj/393h+pEo5
5yCtTw99GjJmQHUe6/fc88XL3iyef/jGQXbRXMQqYnguq+oX4bMXbawmi9u64Q/y
n6frVX79TosOJ65LdPpQvPvnCxa9Ug==
=4Srd
-----END PGP SIGNATURE-----

--C3G6PrXajPXaYJTQ--

