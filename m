Return-Path: <linux-kernel+bounces-531557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B31E2A441E8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35B66188D04D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18836269D16;
	Tue, 25 Feb 2025 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTDUof/c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C2426869E;
	Tue, 25 Feb 2025 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492448; cv=none; b=dWN5qdz5ToOhC2FcsMnEMH48TAmAhfj21r2JVejEx/+hZmHCHqEG/UKTMDBop4x3iWICXXS3fK2T4ZepTST2FHqoMlF9uCXaFq67B91RWkQ6USQ+9AmN0z/aQRKtSGEWns/XRdslodNdugDD2VTwnsgVtUFtr5Qx1DxG8KAZ2EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492448; c=relaxed/simple;
	bh=ylog7V7NQEcge7nITuORIXXaH0MR5zF/yHX1ZMVs1U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jj7MWGiVUxoDxN7bUlw899RmDi0av+IFA73QI5WCGwxQag93PNUj0LSC4I+42SWr6kLjBTOOFvPsI26LK7cJ55aioW7ddpUO8GI8o/TMnMguMYzn5fHd5HxOS+3gX0iBjGL+NdO/53pKoqW+KtFy+CpeKf+eLmHypFndGdDg2tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTDUof/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E7FC4CEDD;
	Tue, 25 Feb 2025 14:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740492447;
	bh=ylog7V7NQEcge7nITuORIXXaH0MR5zF/yHX1ZMVs1U8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GTDUof/cZ6v9RgXqZgG6IiDyxfLNwL6zoUwmXt8LeRKlTyScKbrtN1+J/ECTOG3zw
	 bSnP5iHVnptR4I3QV7uCIX6A1Rq6rQMn9oGi1OeA6hQKTtFxq2prI9Tf/mQmS2eMGF
	 4+W2PgXJFuyaIDTUiB3e/wZtX5C7m1DpoWu+X4VGU7LszJO1F/NADWGbjvvgH4Xtgw
	 5ljlQ5QZ0/4eIgXTjtlA2FMlAYNr9V5Cp6F2GhOa/EXADl8pxXlraGspFDFC3owjiX
	 aLcVEr8L7SLGokBUJ9A7VSPK9BLuibt9BHp/++mQg4kMLCO23Br82nwrdeyLdcVNd+
	 cmfSCgdKvqr9Q==
Date: Tue, 25 Feb 2025 14:07:23 +0000
From: Mark Brown <broonie@kernel.org>
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] regulator: adp5055: Add driver for adp5055
Message-ID: <3905cff4-4e4f-4301-8aaf-70bd50126448@sirena.org.uk>
References: <20250225-upstream-adp5055-v1-0-a5a7f8e46986@analog.com>
 <20250225-upstream-adp5055-v1-2-a5a7f8e46986@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jTB3LrYJ9ENBnqsY"
Content-Disposition: inline
In-Reply-To: <20250225-upstream-adp5055-v1-2-a5a7f8e46986@analog.com>
X-Cookie: I'm not available for comment..


--jTB3LrYJ9ENBnqsY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 25, 2025 at 05:08:34PM +0800, Alexis Czezar Torreno wrote:

> +	device_for_each_child_node_scoped(dev, child) {
> +		ret = fwnode_property_read_u32(child, "reg", &i);
> +		if (ret)

Use of_parse_cb() to parse per-regulator properties.

--jTB3LrYJ9ENBnqsY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme9zpoACgkQJNaLcl1U
h9BU8gf/YjvkmrzPVLgHtogI4EMUneSBFqOsHcweayHTVmnvSguz5ATiriXqiQq1
m95UyDAmvmjQ7VpmfGQDZwKbbrPU7Iws8RKAYHvQIK4X0okreDE+ubT4cmeY0TJ8
4IaO1RLfcGFaStOvVy5T6lWrXWvo2vgBNooQ9dy346Ed9ZmBcj+lpuXGji7anlc3
fpAl+INzTI/Ig8oE3Ab7wBTIt2wBLm6KmnuOqA2GgM8RjIt2Nk0mt0RyOXPCE/Lz
wKjRlPR9MDX7rv2Etj0GPHOtbAU+6pd3ged1aY2WPTAUo3e0cYuW3zvOKTBMMlBj
DyK1hRPA1swPYRORoV60UPnEPZEFIg==
=mFoQ
-----END PGP SIGNATURE-----

--jTB3LrYJ9ENBnqsY--

