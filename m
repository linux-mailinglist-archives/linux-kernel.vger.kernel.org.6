Return-Path: <linux-kernel+bounces-200792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD90F8FB4FA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CE7B1F272AC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4899E12D215;
	Tue,  4 Jun 2024 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVvN9rbf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8547E39851;
	Tue,  4 Jun 2024 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510454; cv=none; b=sU4HG7oNtotpqNFXoCEPfC05jzXYAwKrUsRESuwX6XBSG6NsDrK7gRdZd7cQ4osEeWqBctuFFSPDTJGNAFJZAzgSF8Nd0ak0QaE/55OXZ5jcxVQkFCaGPaKyswF2Bod4QSSAIJBXPMue7Z5KmxHV/GxTZ16jdY2EwIzVWH0vHx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510454; c=relaxed/simple;
	bh=iVOugYKn7JrUfO3QEOy+kzL6OYvpAfOwiffJa4uP3LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZarZgbDbFYfne/03z/uNVO10IaO5o7HwIBJLJTf1yTcSNYouyrbmZW6MfUuARfZ7uhHvO8jZmiIKs/F9EVUUJpu3/Y7MPVaOm+ugat4tl6J3OWXtZz4xMZpuGb0Kt2AOI+jJOFfKIqiyrZgzh31pWOv9/4sqqZgwrKvmqZQRC40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVvN9rbf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF87C2BBFC;
	Tue,  4 Jun 2024 14:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717510454;
	bh=iVOugYKn7JrUfO3QEOy+kzL6OYvpAfOwiffJa4uP3LU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LVvN9rbfPBO/0wuL1Gxzvlr218zVOgeXZIwwXFH5yarRgJhJ0wiV3JZ9MRDJua+30
	 w5Zb0f+obcHyjt48riQOs59snxIDB7f6zRo4F0UXyVAXZlcrhp//BW/TiwU1DvN7pY
	 4dvTioW0KgviHa0GFQxUdaUNMwGYH9lEsqFYrkR2kH5NJnfh+TzRVCKRWngmYZrw3y
	 +oWWyBVhL2x4dICw4p+L5gBevRXC/ghdaRAIs2gFD3LoYL0tfjnVQj2x6DhyTEbqdH
	 ZTxgtzdYofQP2n2snyobO0SklJdqEc0sszRPeuOrPsa+dMNaSCt9BE7uh+vUHmnM8V
	 1p7oBqC5YJGvA==
Date: Tue, 4 Jun 2024 15:14:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	kernel@quicinc.com
Subject: Re: [PATCH] ASoC: qcom: add missing MODULE_DESCRIPTION() macro
Message-ID: <1acb74e5-e768-40f0-9eff-06b37c0d79ee@sirena.org.uk>
References: <20240603-md-snd-soc-qcom-sdw-v1-1-101ea8bcdd38@quicinc.com>
 <0bd0a518-4d85-4251-9bf9-d056dc3d7b08@sirena.org.uk>
 <be0ee1bc-336f-4960-a54c-8bb71449fd1c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E1LT8wVf0uletdZD"
Content-Disposition: inline
In-Reply-To: <be0ee1bc-336f-4960-a54c-8bb71449fd1c@quicinc.com>
X-Cookie: Is it clean in other dimensions?


--E1LT8wVf0uletdZD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 04, 2024 at 06:59:31AM -0700, Jeff Johnson wrote:
> On 6/4/2024 4:56 AM, Mark Brown wrote:

> > Is anyone getting any value from these MODULE_DESCRIPTION()s?  This all
> > just seems like a huge amount of noise and I'm having trouble thinking
> > of a use case.

> https://bugzilla.kernel.org/show_bug.cgi?id=10770

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

and I'm not seeing anything in the above link that articulates an actual
use case.

--E1LT8wVf0uletdZD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZfITAACgkQJNaLcl1U
h9BjoAf+Pt5R2AGb3L49fmvqs4QBC7DTDl0IfBvfjbP60Ie+ncNVy1kZeGH4J61H
UnjJKq+c4rqo5OJ6/KXpHBACnpIb/Vbh4KrHPny3//T/mFaSmkAIYWLu1jH/p16V
n+LcWdJDLOGUZKptOyNVilyFnrQdrhIa1lDnlHRTK6HSMTHggcqzILghk8hHV9sC
ttLpxQ2yENnuXiyRe/UXq74Sl24O9J3pxWuFzZ5gV65Cjdr56kPTvtrWOj4pybi6
px66fMIjkGxun3KVxeimDxFY1aNRoJ1VEmz2oZMVtXfBkUndEewCNAcTQVWCFmNd
b8dWF7/eccrOklt47h6sXrkCFiV/CQ==
=XAOE
-----END PGP SIGNATURE-----

--E1LT8wVf0uletdZD--

