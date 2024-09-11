Return-Path: <linux-kernel+bounces-324948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5291997530F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA01282B9C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E4019C54E;
	Wed, 11 Sep 2024 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHsEyEmp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B3F18F2DF;
	Wed, 11 Sep 2024 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726059558; cv=none; b=jKCm5E4SBUkbf7dwcJTzNWB4IggU1L4PJYhF2OylgnGR+7EAkxfnoHw2YPw/OTNap5t/1HKcv0zCUVDEdSel/t7gwDcd0wzR4yTjlt5ByKTM7M8mS9rrLF3nAgeJ6ZgXeFi48O7rqBTIksCkZBEosqV9fH1ve83tFKVMRROoiZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726059558; c=relaxed/simple;
	bh=8agYiCTVQpE8G2w0lJqMut2X09xN00wnGksfG2F1d4c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Qepd2NQr1pLyTbvY97TjACsgt/WzwPMnIiKw4TC6zFDDPGKX5PqVYmN2XcWMwPfTUIYrVeub4y1qG0DCTvJofUqisYDHDNL0pwp9Zn1A16R4uGWDxB5xlXXqpq7TEHE3yxS8KBIDCLodCIBT7LxL2hAOi00tI/is+rKRuzxw/CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHsEyEmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34004C4CEC6;
	Wed, 11 Sep 2024 12:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726059557;
	bh=8agYiCTVQpE8G2w0lJqMut2X09xN00wnGksfG2F1d4c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fHsEyEmpYEKOdHNCIiYXtk6L/dWrBOyXAVzVTycQdaJSjxU2xvvMRgTcDM6t3qZn0
	 OgM3LCIBnjVQNGNxeruc5fA3Vtoq5fuLacPnDQq7ZvLpZcYA+iygsbPpIYvAncl/iF
	 9ECBeseGR+z1o0boswggHuXuyeSc9/ulWOCqLWK0bYGNQyHTm9ZU2jorupbzbvjM7M
	 symiPWLVItoQ3zXHfughfpGYlpO5baQ71WkpjQDMaSBS59o2zzcopOJbB2YR5NjtGT
	 bSTelR4gTefm1OVNtVmmu66UgQUzSFpGOjzT3Pqy7lbIRonB5HL4FK6BViNp9MSqzp
	 AHkmodUGC+1XA==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com, 
 venkataprasad.potturu@amd.com, cristian.ciocaltea@collabora.com, 
 Syed.SabaKareem@amd.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240911093554.2076872-1-Vijendar.Mukunda@amd.com>
References: <20240911093554.2076872-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 1/2] ASoC: amd: acp: remove MODULE_ALIAS for legacy
 machine driver
Message-Id: <172605955493.57388.7500481938110885017.b4-ty@kernel.org>
Date: Wed, 11 Sep 2024 13:59:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Wed, 11 Sep 2024 15:05:53 +0530, Vijendar Mukunda wrote:
> As module device table added for AMD legacy machine driver, MODULE_ALIAS
> is not required. Remove MODULE_ALIAS for AMD legacy machine driver.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: amd: acp: remove MODULE_ALIAS for legacy machine driver
      commit: bacae49eccb9a3acaf74fc275893abc26c0420b5
[2/2] ASoC: amd: acp: remove MODULE_ALIAS for sof based generic machine driver
      commit: 0b0aa67baa8904e3c1e13be48a2ca125f59ead3d

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


