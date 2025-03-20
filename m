Return-Path: <linux-kernel+bounces-570499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A492A6B174
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD24F18901CA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF968222582;
	Thu, 20 Mar 2025 23:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WibhYVkq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397EC1F7076
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742512131; cv=none; b=IHAu5Pdg9eSv4l4nRc2TJZ24BrbqQX034YLDDnsj96OvfBjVE3Li/XtgpfYJZLNez37j92d1FM5exFPWF1taVmry71Pl1wg3aehHxeyK4Z6bJcotSiawptOyKcZpdlQSwP457fzHdfIsCxpfcOPdgkV+6RcyX1ixbzPAHmxUZhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742512131; c=relaxed/simple;
	bh=/w4MuZeKY3YawOtCYUQ+i9sM8C3q6kH8PXwDxXLpi6g=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNr0IpiCMyf9vvrVKgn75ww4Upi2xvk+fvQoCXZXbKpqiEYFQBNBacQMxWqwUx/l25UBYm87HwQc99y4JDoZWHyqUBxc3bvqruDv2DYAmNQYQYXf/OBtQ3Qe2OtpHr1XFRdEIR13ZR418AwdqOgnJsuvzrvhuNyeUcjKaSZ/syY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WibhYVkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D519BC4CEDD;
	Thu, 20 Mar 2025 23:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742512130;
	bh=/w4MuZeKY3YawOtCYUQ+i9sM8C3q6kH8PXwDxXLpi6g=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=WibhYVkqibZQm7ar2t8DBKK9XNaRqBkRT9T4MmXDG1M7anAjaumCt872NZPIjX3Go
	 XSBDgtp0+JHz6hwFz7LoGQ/7jBL1WDFkFXoqmQUiXZZaDfs5ebzQ26dCmdQNgWZoaB
	 6PNAqEcUiQ1hztjRSJ6MoiXAzKRMoCNzQEjQcFHMYVCWVp2pNNkyHR1Fbo4T0/5Rro
	 ptYBJUifAFh84ZTq8hj7oj8TbhChSKXlgYwYlqMXzjAzi/gynIkC7g+9BVJ8cC9ZvA
	 wTvShZWTPQHe3YhvuXQBzqihI8+/0fV2/xSByMPXZLG6rgWq71uhs6Fo5Ab4mIqZh/
	 d/UwkGQwah8sQ==
Date: Thu, 20 Mar 2025 23:08:47 +0000
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Petr Tesarik <ptesarik@suse.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: spi: Don't use spi_write_then_read()
Message-ID: <b32120b4-3805-43f0-956d-3c28810fc8b9@sirena.org.uk>
References: <20250320-regmap-spi-write-read-v1-1-31666bc6ebe8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aP3G4+KNZ2CUlWVo"
Content-Disposition: inline
In-Reply-To: <20250320-regmap-spi-write-read-v1-1-31666bc6ebe8@kernel.org>
X-Cookie: Do not fold, spindle or mutilate.


--aP3G4+KNZ2CUlWVo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 20, 2025 at 11:00:34PM +0000, Mark Brown wrote:
> Currently SPI reads are implemented using spi_write_then_read(). This is a
> convenience API which as well as constructing a SPI message from parameters
> basically the same as for a bytestream read operation also bounces things
> into a memory buffer to allow callers to use stack or other non-DMAable
> memory. Since regmap should already be ensuring that everything can be
> DMAed further up the stack this copy is redundant so switch to using the
> underlying spi_sync() API with the buffers provided by the core directly.

I think this actually needs to be part of a wider series, but pushing it
out there just now since there's the other regmap paths which also use
spi_sync() and will need any adjustments anyway.

--aP3G4+KNZ2CUlWVo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfcn/4ACgkQJNaLcl1U
h9DaoQf/e9tJaxxzAO1zGqZYwyNzU+aKZ2bNbfchmPFLkrf6dwoxGNS2t9YRyMS/
6UrGBLYO3uapm7TvMHv/M6Hg8gZVSYFpoGh3dClbFRIESF/5LHJXF8cMwroKJqws
dF70FjJo9nVoVDhwpHBNyBSLbCfhFP16JUcZ6yMM10rPlmU4Xe9XBl12WDkoWh+T
CTyF0UYyvWB7BLto84jSIV3mawjBGKtzcehdVe3to9/iSkiZ6UZjUInOwayA2lUz
vNkBvAlhXcjkswOjdv/H3XORzvaAGkjBxAO6HxBoAvU+D8joSrRBbqHkdkwwU29N
1H3iaR2nzskO0/YB+Q4rByxrbxKjOg==
=4Jmu
-----END PGP SIGNATURE-----

--aP3G4+KNZ2CUlWVo--

