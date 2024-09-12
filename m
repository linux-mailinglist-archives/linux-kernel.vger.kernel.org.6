Return-Path: <linux-kernel+bounces-327096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B42239770F9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65C51C23056
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5881BFDEC;
	Thu, 12 Sep 2024 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+8NQEfJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BFF13DBBE;
	Thu, 12 Sep 2024 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726167579; cv=none; b=H63guKdeABH3gscRCKL2CKcEFSgkDU4EvQCA/w3KVNOYM16pZn0lGp6GYeDfj/kLIKL9euwizc9q3oW2uDd9o24PeD9QTMErMaxHMKvgenOqxhb0BiwqbJM//F3MK4s6tdazGKwhLCOiPqSQ2uwCFjgwoabyJ/sNLQTEJmNc8Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726167579; c=relaxed/simple;
	bh=KD8sqECrwoDM4LaxhflSqmK1RgaQnuagu+p694T6Azw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dAdrkSDR8Ce7ERMrnBYpUMdbiotDTERsUjwG7uGF1xlZh0TAN5Ex86CkdkrN8p44Of8sXK5PKMJeFQKCJSMyqN9XbRPdAKhbzfnjKd9+Ur3abSgPI4P/e8VaTdcWzJapQ6vlneQ3boh7Mizyywg92uC+/aFxN0mSY+GadnAzjmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+8NQEfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67133C4CEC3;
	Thu, 12 Sep 2024 18:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726167579;
	bh=KD8sqECrwoDM4LaxhflSqmK1RgaQnuagu+p694T6Azw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=h+8NQEfJp5eI6VYnVV+LZocFyCT/54Znb1rldlxfYy0YQHRCziVGfxN5uVHStD2Ay
	 4y+3uN6WQVliYRZYtlcO/OJOHOFcLpu0DaYpGW2CGYz7t5Q0p+ItzswlPGvZeYKUzT
	 D8NH9L3LOPrhT7UZZ5WFsPVjUrJntdvU1iQ9MmLPWw7EFzjl0KW0dpU8wn2C+0WcSd
	 +zLxgUriGr/uA0BcSV2/oLoVKPsiXFtXa2p2KTZA6tsMCF+jFFr4otYbw8jWG5/DtN
	 X5WxpR3VacOdnVaUoXezxPZxsC2lwWxziauuZB18dwUtXRA235BmyjkRC6d2Ms0aEx
	 dQzMvAdWkZVUw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 Tang Bin <tangbin@cmss.chinamobile.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20240912084110.1854-1-tangbin@cmss.chinamobile.com>
References: <20240912084110.1854-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH v2] ASoC: mediatek: mt7986-afe-pcm: Remove redundant
 error message
Message-Id: <172616757716.88520.13515459901367957704.b4-ty@kernel.org>
Date: Thu, 12 Sep 2024 19:59:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Thu, 12 Sep 2024 16:41:10 +0800, Tang Bin wrote:
> In the function mt7986_afe_pcm_dev_probe, when get irq
> failed, the function platform_get_irq() logs an error
> message, so remove redundant one here.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt7986-afe-pcm: Remove redundant error message
      commit: f6e2e7397d00192bda11166d5fb3e2e67a8cf92e

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


