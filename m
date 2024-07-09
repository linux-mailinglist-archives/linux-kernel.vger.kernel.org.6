Return-Path: <linux-kernel+bounces-246719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF8992C5B7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD9F4B21B81
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A514718784A;
	Tue,  9 Jul 2024 21:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMCZ40Cz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C3A185612;
	Tue,  9 Jul 2024 21:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720561834; cv=none; b=hVEhbg0lqheKDT/bbyln1rnr4vS3UVgNc5nUHcxczZZRTVBMgpzfNJ8K8WnUFgztwx2jtkeXU9SpbK5K+gfB7x66bPlPk+BN0pILmYwPDG/c3Lca2NLR6bWp4rfTR3B7YtIjoqzDw9ez1+dtp9fYVVAC6tpgaAtycb0MSGotc6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720561834; c=relaxed/simple;
	bh=ycuYAdGSjCFvzRGk5dVlud3+ZxsmqTsJTS56z2wlpNE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ENKl9R7JsZTs7QNtu02ZqF8FdzPnP+4eN4ZkhNR2KNPtT2m0mXwC7mljn99SfTAcRkMk43MPsWM2YYXP2rlgkQwzhW+fOjPNLd00vo3f6QPB/tnnvxV+rU1Re0cNsPR7k6r6jsspSXeDZt7ZdTQiL0kX3K5T0gee9TvIDaM/iso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMCZ40Cz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FE8C3277B;
	Tue,  9 Jul 2024 21:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720561833;
	bh=ycuYAdGSjCFvzRGk5dVlud3+ZxsmqTsJTS56z2wlpNE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CMCZ40CzlD+4NKx9k4FhLID0Of+9zz0UU2TdmtI7qQREArKeO3mVsol4NKUghPz3F
	 wdDEsYV+2efeDk/3lfWMVwMGuiHdd2ISkA1/vVCCn4HB7cvt3V4fME7fWVsP51Xt3k
	 v/nUEPywYrCHNhz/H58tgfg327cbRiUn6OgJ4/igrtoRDCU7LOG/99YCiG3FghwvTp
	 ZWmikeLwlqPqNRQS6iRLyJM6sZWiy5jLTs3usECPewFngH/a/RvfaS46nUfDEkO9QR
	 LedU0FwJY4HJx1PrcqjwVwY3QdfY2sKVf09ndjfAhFE6r31LrIr2RSdErt+8hWmQiJ
	 RWBYleZgE7PTA==
From: Mark Brown <broonie@kernel.org>
To: cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com, 
 liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com, 
 yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com, 
 kai.vehmanen@linux.intel.com, perex@perex.cz, tiwai@suse.com, 
 ckeepax@opensource.cirrus.com, Chen Ni <nichen@iscas.ac.cn>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240709030921.585740-1-nichen@iscas.ac.cn>
References: <20240709030921.585740-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: Intel: sof_sdw: Convert comma to semicolon
Message-Id: <172056183087.72205.7434504515517519216.b4-ty@kernel.org>
Date: Tue, 09 Jul 2024 22:50:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Tue, 09 Jul 2024 11:09:21 +0800, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: sof_sdw: Convert comma to semicolon
      commit: e52a73e694522c7c94369a7741717a9f50baca0b

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


