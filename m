Return-Path: <linux-kernel+bounces-439573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EF19EB13D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F33E1886089
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D621A7AF7;
	Tue, 10 Dec 2024 12:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upUUZI/h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6C21A08A8;
	Tue, 10 Dec 2024 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835083; cv=none; b=ATc6LgIySC28UTq0soJ2LJgZYyB9vnXcnm++1okXO3mmKejffXGd0m/DfLFgUyS+DgZ+9o7d9vBjQV4O6VNt9q1Xu2w2iOpKqNb784o3jNRxlhmot1QDxDJqYB3jTTXb9XUm8g5egHruablsrttjBTb7NiAG2RHA/q4aJV9a0C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835083; c=relaxed/simple;
	bh=3Rsh6xFVdXHonSSiiPX02wsrJdpKnfeJXXUWbBhqxXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbvSwrT5rQZy9R83totkpAnibKVJ2wwVdO7yqz24pes15d0mALMPO6WhZFQn9bveEDryxLT/GA6lq/MLBtf1PLBx3Zr6SrzFby0OGfDlnErRDQr8aljKcpjTCxpXxp9sUtC1Sri1DsRyCggVlRkJkX7R0d0bQ8ttV5+sOTMdapk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upUUZI/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F230C4CED6;
	Tue, 10 Dec 2024 12:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733835082;
	bh=3Rsh6xFVdXHonSSiiPX02wsrJdpKnfeJXXUWbBhqxXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=upUUZI/hYB+bTZo33EpXNJMM36yaJDkwlw9b/AT9iHEM1xEU/97+oIbhm5a+oH6N0
	 GTY5tzVu/nO9w49rle21UOjWFfpBJmV4f4yrq6QN98PJUuEBw2DkPJelxUDHND8xet
	 kknHFro8mMVPaMc9EgIQTJW5rNkF3rklCpl9U0R8ljcArwsfiOozjA+r3Ouxwehvtm
	 eLYyFWdN5/91sZgcwoKpnteZ7W3bbSNqxotiCDxtGN0TtDvnMsgbavK1ejwkQk+unH
	 2Nie1Xhsux+FjBzOqCKANWGrQhZyLtbu/PsEmEdtCOqoiybLymUzZPlFE7wKr9Dl4Q
	 R/uvJ3q4CGA3Q==
Date: Tue, 10 Dec 2024 12:51:13 +0000
From: Mark Brown <broonie@kernel.org>
To: wangweidong.a@awinic.com
Cc: lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
	rf@opensource.cirrus.com, jack.yu@realtek.com,
	neil.armstrong@linaro.org, ivprusov@salutedevices.com,
	zhoubinbin@loongson.cn, quic_pkumpatl@quicinc.com,
	herve.codina@bootlin.com, masahiroy@kernel.org, nuno.sa@analog.com,
	yesanishhere@gmail.com, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	yijiangtao@awinic.com
Subject: Re: [PATCH V1 2/2] ASoC: codecs: Add aw88083 amplifier driver
Message-ID: <152595a2-2216-4c6c-935d-9c58939bffe0@sirena.org.uk>
References: <20241210091054.88779-1-wangweidong.a@awinic.com>
 <20241210091054.88779-3-wangweidong.a@awinic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q36hzlD+9c1+gXCv"
Content-Disposition: inline
In-Reply-To: <20241210091054.88779-3-wangweidong.a@awinic.com>
X-Cookie: Leave no stone unturned.


--Q36hzlD+9c1+gXCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 10, 2024 at 05:10:54PM +0800, wangweidong.a@awinic.com wrote:

> -	aw88081_dev_clear_int_status(aw_dev);
> +	if (aw88081->devtype == AW88081)
> +		/* clear inturrupt */
> +		aw88081_dev_clear_int_status(aw_dev);
> +

These if (devtype) statements will get hard to maintain as more device
types are added (and the diff here is already pretty confusing).  It's
better to use a switch statement with cases for the devices that need
specific handling, that way more devices can easily slot in.

--Q36hzlD+9c1+gXCv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdYOUAACgkQJNaLcl1U
h9BiCwf/cRLfKoyKaljJFQk61yjyXDCGGbPIeoRxi2FAt9wvPmapd4upREiw8tkU
R9BedelQEcGzYxTvWmwPV1PjavIfx6/B7UexJoVJhOg39/OpoXok76ZnvtXeOmdi
9PXzOnAhNwn3vFvwRS0FKHwzYjJPXrU3fKydYY5o7hYdXGY60NoDU+EktVFv9SQ6
8Mt8NMNgWCeRmifrrRJ8VwbZ2MmtesmrkdLCFZbufLRVT5LNbDAPZeQkIhpaKwM1
lVfzsAlW23jq/EhlMhRHbDqTeJBiie2aDP9xE1KxXtKtOl8Rf7qQL38CZOD3Etxk
Bx6EfpfNv01+FpB1kJxjnSAq2oL4FQ==
=TcvG
-----END PGP SIGNATURE-----

--Q36hzlD+9c1+gXCv--

