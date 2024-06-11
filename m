Return-Path: <linux-kernel+bounces-209660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B0A903908
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFE7FB21085
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B396178CE4;
	Tue, 11 Jun 2024 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bf4D/jow"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D1814F13F;
	Tue, 11 Jun 2024 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718102238; cv=none; b=M92OsBg19ioyyQ/Byxnlm5WqSZF+OzRnUIsabZosqwWkxQYqoqV+DbsAj3Sb2GiIU5iFw6hvx7EubfS1xucEfFU48ZYxXBedaYIbj1ZP6apDNhdA028EHX+ATeN8zQOUsnB30XxV4uuReg5JMW1ofCd5Q7aS7I+UHn/d/yBTIww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718102238; c=relaxed/simple;
	bh=nds2TJge5Z4TpoZDLAtUnD28Qvbmk5QsBVyZINMe6lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUGMbfO7VupTKHScc82y8f1U/FhNy/mADemWEw+4y4zN9yjXEjBumAHreoSqgQRWcr6q1nZCpyReVYfrZN6gw3Z5ErwBSPHvWjjr0/KXFMl3rbjalyxJr0K7SdqInCEiQ5jPz4GOlwign+GQ3lk8jAEbZe2vBRFJ/P+nUupanGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bf4D/jow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E442C2BD10;
	Tue, 11 Jun 2024 10:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718102238;
	bh=nds2TJge5Z4TpoZDLAtUnD28Qvbmk5QsBVyZINMe6lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bf4D/jow1a8Ng/Hil+lAqb0dut/RYwZPvQ3FPZbbkJ7aCG3CveDoJ8iAXzFOI8uEE
	 9yDRNNq0FPsUcFhikkmpU/E5w5feE7DXdPkDNYG9myT/DRd/Z6y6hSguT5PToyK+P4
	 YsIIdY5FwPBIolZReklyVMjMCN/HQe/fKvVJxqsGGDNknEFWJJjyxvCBI+N+Hz4b6L
	 ejwQ53ezYu29at7MPLf3bzifn7TzIPlM2VP2jVzLwlOwrQJjfdnhIyJ+1XBCzpDGqb
	 Yo4pdYTi13dJlDfvejmLRB2pxjXOTtTR2aWrT0nfBqElFPYYSgETvleS1E7ztkPUUV
	 wvZ1spKxyGKaA==
Date: Tue, 11 Jun 2024 11:37:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Russell King <linux@armlinux.org.uk>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Arnd Bergmann <arnd@arndb.de>, Chancel Liu <chancel.liu@nxp.com>,
	Michael Ellerman <mpe@ellerman.id.au>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [Patch v2 2/2] ASoC: dt-bindings: lpc32xx: Add lpc32xx i2s DT
 binding
Message-ID: <Zmgo239qK_hi5Z8B@finisterre.sirena.org.uk>
References: <[PATCH]ASoC:fsl:Addi2sandpcmdriversforLPC32xxCPUs>
 <20240611094810.27475-1-piotr.wojtaszczyk@timesys.com>
 <20240611094810.27475-2-piotr.wojtaszczyk@timesys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pmKDFPdi4BGueWVw"
Content-Disposition: inline
In-Reply-To: <20240611094810.27475-2-piotr.wojtaszczyk@timesys.com>
X-Cookie: Your love life will be... interesting.


--pmKDFPdi4BGueWVw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 11, 2024 at 11:47:52AM +0200, Piotr Wojtaszczyk wrote:

> Changes for v2:
> - Added maintainers field
> - Dropped clock-names
> - Dropped unused unneded interrupts field


> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names

Some of the dropping of clock-names was missed.

--pmKDFPdi4BGueWVw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZoKNoACgkQJNaLcl1U
h9Bg/wf9FyJJF7rPVkdR+i37hUYzzoNUoE7vaCl2WvvG5hjhTL5MdU6XdKMBsAM1
pN4nQeJ7X+zozGaPqwucwfbyg0MN+0LVOvhugSIVGSCY2hDKEDlQoGaPvj5wZVOo
4baY5NtBKZX6UfdsEp/JhNf9sA7thdZKXKAqt0v78ncgpyF+0Xlbu5key3Z47c4W
fPQGPexS6kgG7+x3DPn6b3SKVBdeRDOajyFXzabE0Kg/0zEIo9ns5ycI4/lzby0A
IF+GEw4DfF8RyPnPrGjsxl2F3GS4+qJHRAwk5zFbIEPC9WILwwJ8TgkfxqmlU7bb
E1TX4jDGVqFB09TRVdAjbycxlkBL0A==
=UIHv
-----END PGP SIGNATURE-----

--pmKDFPdi4BGueWVw--

