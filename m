Return-Path: <linux-kernel+bounces-200910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D35A48FB672
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FDEF1C22422
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D75143C57;
	Tue,  4 Jun 2024 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FO5candx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DEC8BF7;
	Tue,  4 Jun 2024 15:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513258; cv=none; b=nT84frlu0ftb6pJFafdAOOHvh/DCuUw8GaNh10lNfTc6FtoZ7W+m9SPzB8JXnRrI4hVH4oUt1FnYZloN5JmP5LNzucvL+brRjGsHmD+tPq8giufD/sUmwJ4JjJ5tJi0Z+0fcEt/gQVSFjUo5gS99hQrkAp5GlyAwBNKbhfN7H5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513258; c=relaxed/simple;
	bh=GlEUR22ZhAnZ0czhVF3LVHsj/uX/hRrel5FcmB2yiZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYpIJasXrSPHzkrL9uZIgE0cL41BvwpprFAVVkRYtoo02g4h7VGEOLP4ZhUG22VBMKkfRWE3VQw9wi/Ee28f21WjVl7NiN57q9egiUPhFYQT4Ql456mIZ9KiXEmX+PIvbA7V9nSIgZNNVJ6A92C/5sLZNOiGk/nNutykSgb53/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FO5candx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4328C2BBFC;
	Tue,  4 Jun 2024 15:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717513257;
	bh=GlEUR22ZhAnZ0czhVF3LVHsj/uX/hRrel5FcmB2yiZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FO5candxFF+rT/EM4wzRldxm9ScSz8CgV47O38RUXqJLMJzutBYLcl+/JxigqC1aM
	 bU0J4c9iiXxpC9AKmhkaIh0IUhJ8ZvoOdwdQm0PllzmuSxxK6nLXuWvA7Xdz8YMkgE
	 NHe1SIzxyGd9grO01+XPWod7zLGOYivGcimb4akviHahUEU8LZmg01wKGJRPRHzA/4
	 2sAS91L3EQLV2lzkYfuQI6Q9+GPt6xPJyJT6MNKQCsutBojEgKSsh3ep0ojtFnH2YS
	 VcLfSa4gw28Wf53x6DQa7lkf9S6BTzs0jLaHF8PqzPPABPyOC7qtTR9gxY9qJcl8So
	 CkJNWxksUtslQ==
Date: Tue, 4 Jun 2024 16:00:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	kernel@quicinc.com
Subject: Re: [PATCH] ASoC: qcom: add missing MODULE_DESCRIPTION() macro
Message-ID: <9a6636af-26f4-49b3-bd4c-91f9ccc29322@sirena.org.uk>
References: <20240603-md-snd-soc-qcom-sdw-v1-1-101ea8bcdd38@quicinc.com>
 <0bd0a518-4d85-4251-9bf9-d056dc3d7b08@sirena.org.uk>
 <7a0cde5c-db6f-4de1-9dc2-aa2c21fd0210@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4FjINuUocUrb0j8X"
Content-Disposition: inline
In-Reply-To: <7a0cde5c-db6f-4de1-9dc2-aa2c21fd0210@moroto.mountain>
X-Cookie: Is it clean in other dimensions?


--4FjINuUocUrb0j8X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 04, 2024 at 05:46:14PM +0300, Dan Carpenter wrote:
> On Tue, Jun 04, 2024 at 12:56:09PM +0100, Mark Brown wrote:

> > Is anyone getting any value from these MODULE_DESCRIPTION()s?  This all
> > just seems like a huge amount of noise and I'm having trouble thinking
> > of a use case.

> The missing MODULE_DESCRIPTION() warnings are very annoying.  We
> recently missed a link error issue because the warning was drowned out
> in MODULE_DESCRIPTION() warnings.
> https://lore.kernel.org/all/202405182038.ncf1mL7Z-lkp@intel.com/

Yeah, adding the warning seems premature without having first added the
descriptions and I'm not clear in what situation anyone would actually
care given how rare it is for someone to manually interact with module
loading.  The number of cases where anyone would not just look at the
source seems vanishingly small.

--4FjINuUocUrb0j8X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZfLCMACgkQJNaLcl1U
h9C22QgAhndQ9RATpqJtQSgVZgFEEyID4beRXIYAjMsdhg6/YZUD9FP7c37lw64x
g6ooe2ddBuxvD0qwNV29KW/rPzAJglDv0RXd8JCbC0h753RyR3d7eGDhDYlkqAMc
hHZP0vuZT9bKnbflS7/W333OhG1H9Aj5stiNu60supirROlX4HgjjOCPCg2990Qa
yqZqCJdYywC8i1ZRBYTpAfcuIUX0jGuHas680Do9VR5BTyWyyI/LMaWS/xVJka92
1mQDlsXc6mSEgzrqOC+Zi+Is9lne1DMz5Xrud/srQweNCsoLnOwI5DOwbQ3SVUe+
YDtmyebX2W/Na9jAm7JCAlDcoEOAFg==
=E42r
-----END PGP SIGNATURE-----

--4FjINuUocUrb0j8X--

