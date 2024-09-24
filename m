Return-Path: <linux-kernel+bounces-337146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0D89845F3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B5431C20AC6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B2A1A76AA;
	Tue, 24 Sep 2024 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1CgldgY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC132907;
	Tue, 24 Sep 2024 12:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727181106; cv=none; b=JY+au3adzKoadWOGq6yYolrKsX5ZRytivbDxyn28nPrGhI8TDrSpaM4qoinruslc3y8j0oaXD4Ej1ZSni1eZKUOG5rcX/GGmNi4S+MIvnMqT8fXpKxtgwP+SbtFLBpXh353vrnzL1mtBCVxNjDkrwxCkECnY0x/yGIOovxz1BIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727181106; c=relaxed/simple;
	bh=wAPJalb1CxIj0zrnuJAb6vZmNWd9wq376cbz8helbHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cO7JxyjIjEalC5WEhoE0yCp3yWid3Du+kUcaqr9V59i1fdADgv3ycRM0g3CDbBFHe0QA4cjl41OXz/qzO2aq+DOHAx+6A3Gu914216XhJTJ9YxBbdQkvSqDOSMIiKTPKqUvb3FFkGg4/LMkIPLrLJxdCtISjpPM+5tq4WMrTkic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1CgldgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDF3C4CEC4;
	Tue, 24 Sep 2024 12:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727181106;
	bh=wAPJalb1CxIj0zrnuJAb6vZmNWd9wq376cbz8helbHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L1CgldgYur7fTzW2ApviB3/19aQCRfr/EK+bSRGqTFTtm+c/V1jhSdHpQ/jwDRLtJ
	 HzYr24rf0XdHUsvpg3eHsjvmcayd73EmBc4P64rha6KMset0Heuj2lbPILBcBixQOg
	 5vTYvEFUbH81s1aJFJnagZVnAVzo0CDkkMBfOtWvtNqjn/kPcLaCSRWma5WRCoUEye
	 Fpk8NC2WROroX62qbyJqlKMdKY/Ci7ON35oC2Rdb/e9P+F7l0KBy+5FIcByTSBukIO
	 iGZWrAPJxTQMJTDlb2Ze3MwSA6JLtHdWZEySs+wB59lsXpZYsdgz32LGeUxmqBKQ02
	 kalzw18Ep3E6w==
Date: Tue, 24 Sep 2024 14:31:40 +0200
From: Mark Brown <broonie@kernel.org>
To: Igor Prusov <ivprusov@salutedevices.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@salutedevices.com, prusovigor@gmail.com
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: Add Everest ES7243E
Message-ID: <ZvKxLPQ1fcF8JBU4@finisterre.sirena.org.uk>
References: <20240920-es7243e-adc-v2-0-0be019735b81@salutedevices.com>
 <20240920-es7243e-adc-v2-1-0be019735b81@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qBHEOi3iw4H/lkvR"
Content-Disposition: inline
In-Reply-To: <20240920-es7243e-adc-v2-1-0be019735b81@salutedevices.com>
X-Cookie: Editing is a rewording activity.


--qBHEOi3iw4H/lkvR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 20, 2024 at 06:41:07PM +0300, Igor Prusov wrote:

> +  clocks:
> +    minItems: 2
> +    maxItems: 2

> +  clock-names:
> +    items:
> +      - const: sclk
> +      - const: lrclk

This is quite weird and doesn't seem to correspond to the chip datasheet
at:

    http://www.everest-semi.com/pdf/ES7243%20PB.pdf
    https://www.pawpaw.cn/media/documents/2022-04/ES7243E_DS_pawpaw%E6%9C%A8%E7%93%9C%E7%A7%91%E6%8A%80.pdf

The SCLK and LRCLK appear to be the bit and frame sync clocks which
would not normally be exposed directly via the clock API (so this is
probably not going to be joined up with whatever SoC it's connected to).
On the other hand there *is* a MCLK which would much more normally be
represented in the DT bindings and isn't represented here or managed by
the driver.

--qBHEOi3iw4H/lkvR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbysSwACgkQJNaLcl1U
h9C+6Qf/UHieit4KCo6Tk9QWnyPujqDhBtWIKt+0lTQG8HxlZH3iCRD9fW3jK4k+
vWY+2NwO5J6+zorSRYky9oDvjo4ylb+ontmcWeABOSV5AYqiYBZSX0mwdWsINFnT
cxIV8AT+VUZ0MAL2kx1g1wdPHvsYCTRYmhFnZ8yKqEd7rTplKt5Y/dndp4erk5AQ
SzW6gHw3j0ETmQWMmTXH1Ev3l00chNIQUrjY9RjY2ytfS0CWgsDNZDWWHMNOiP/e
t/8C6a5/qcrBElZryuW+gszSN8cOs78DQXmKS5QCl7Mekb/VbTNHm6MACBMFUzRO
fyodXO5a40kCRSOqUqW4PtymDDFedQ==
=SMLv
-----END PGP SIGNATURE-----

--qBHEOi3iw4H/lkvR--

