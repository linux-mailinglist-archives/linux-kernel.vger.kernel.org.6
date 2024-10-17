Return-Path: <linux-kernel+bounces-369724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4636F9A21CF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11C151C21C66
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 12:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F911DCB31;
	Thu, 17 Oct 2024 12:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuyoByFO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AB41D5153;
	Thu, 17 Oct 2024 12:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729166642; cv=none; b=Km1I5j36b0Y0SyRVwazP8fhdLILUj9Ok8uapN3tiko44kyZVGaEhrlKmMK41tAMjso9kENV9fTrS2Q5e0XybtUR6dUBOF2nFcSSRsqeyen9u7RxnVNqZSMEAcadIJ9G6VwSQqRRYApCU3+wLQm+iVftZRQr0dljuxdNt2XKZZVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729166642; c=relaxed/simple;
	bh=LRePmjBW7AMTlSmSdoE2S0WpYePO6F1mEEBAftMfHuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIKd2d/pIQhAsADinQNZRdli9Bq1QUqNcYaHtgiM4D/HJAC4vXq5zYeCq7KaTrQrASnXL9aT4F5t7I5QNUYocIJouHjfyTO4IbpMfqqzCj2FQI+GlSiGxwVgmjxrTAcSlP8zUP5CiSMFv0S9Jf10W0VXsL+V3Lcnvrjtfs5n0tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuyoByFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5C6C4CEC3;
	Thu, 17 Oct 2024 12:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729166641;
	bh=LRePmjBW7AMTlSmSdoE2S0WpYePO6F1mEEBAftMfHuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MuyoByFODIHmByXMJBPpn09SL+lkAj4CAphzOeJZ8cjUzn83gjqXG2UlZTdffF7EZ
	 kK0xVTK35eyqaMzuad7d1ARWHmviGFdK47vmRSqbMt1W085A9gaAfyynmlHFiMO2wp
	 tSVV3HFb7a0CzXozox0+vsk/8HQ2J5zYytViCoKDqVy44WsVscZ9lluU6He0J/r3eU
	 c0AG2OQM5ZLhmQ7C5umG7kbq4ptn/s+RhYUk/EXZnZZMzJvpiqAQhUwtAljs8UfU0k
	 wqv2V9jKGFInq5wKDJZSMDGhszWd5kqn45njh/6KmXSSBuJxCIkdkVbj8xTd6WwwyK
	 TMBAvP1ANjUsw==
Date: Thu, 17 Oct 2024 13:03:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Liu Jing <liujing@cmss.chinamobile.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fix code redundancy in sound/soc/soc-core.c
Message-ID: <8de362f9-1218-400f-b93f-b11f0c04711c@sirena.org.uk>
References: <20241015031742.5144-1-liujing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R8kUD17H1wV51pBK"
Content-Disposition: inline
In-Reply-To: <20241015031742.5144-1-liujing@cmss.chinamobile.com>
X-Cookie: One picture is worth 128K words.


--R8kUD17H1wV51pBK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 15, 2024 at 11:17:42AM +0800, Liu Jing wrote:
> In the snd_soc_register_dai function, the logic for assigning the value of dai->id can be simplified
> using the conditional operator (also known as the ternary operator).

The ternery operator is rarely a legibility improvement when used
standalone, this seems to just make thing harder to follow.

--R8kUD17H1wV51pBK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcQ/SwACgkQJNaLcl1U
h9AH/gf+L0KpQ/l6CyxOjxEv9Zue/N8JA7ytOcdMHiOSe1VC3AGXosxvbOZkLgTh
xW+NmZ78Sv2Cfa7gDGaukPcLq3o6vGtJUQ+Uo25KCgTY9Rkli1QUuuVkVRxsn/Ov
dNXK4mfRCR/2k1DzWDva3tRWGn9/hazIYTJvSuMOf8dh/GDNgyRVnQjQQPUWA9X9
K0p0TBRCPqa6nBMpQ+pHvLw4tep7qUq4hujbuxqvd4dkNKYF/RJqhhTWFEux8gfG
LRNCsZ8kpzDzGhXYtZseB455j+K8ZKOsYxRPmkRoGvwWxataTxVRcUIfyzr7daOi
9HDTb+v4E6+V5az3enL9YDE4Tq9x8w==
=Wx2q
-----END PGP SIGNATURE-----

--R8kUD17H1wV51pBK--

