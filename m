Return-Path: <linux-kernel+bounces-297628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5F095BB99
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79102283C1D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFDD1CCEF3;
	Thu, 22 Aug 2024 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBM6qf7m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02E213C9CB;
	Thu, 22 Aug 2024 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343467; cv=none; b=YqUvlQX0Lc4IpTGTbHzMMlUiEYCcQ3aiizOqUrT14SEhU6WfxfrQNlN4W2BkNm1ELzS2Mqxd1rpwRqU7jThpFrPf5wEZIuiPWzvSZc82z3fk+FXlGvZQEL+wlWhDJJJROm9v/AEFXts9pvr0cA8PdXohYwGD+JZuM0+fxIsQP78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343467; c=relaxed/simple;
	bh=qumv4U2b5dH4YKyVH0OOu9O2sg175DZ6ReMMbqGYrUo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A4TgEnfXaTJVWpln8Ksp1rHaJUVJ5QJJA9spuSExxXrkwKn7q/55EVPTSIDdWvxS3kZBdkbduIIhiCOKBF/GgbWN1MQEAcS5s4/Swu2OCZ0VYp6CAg1aWc0zL4NQXJOGqlxcbBWsEPR+tOesNZhivP+zx8wN6U6NZ/9xznvNjuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBM6qf7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5844FC32782;
	Thu, 22 Aug 2024 16:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724343466;
	bh=qumv4U2b5dH4YKyVH0OOu9O2sg175DZ6ReMMbqGYrUo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aBM6qf7m+yVvMG+M4Dr6A68nHJapDxSq6BkRhpOEToSJeFrrrRwSn8tLexKgEOtvP
	 XCi6geHlkwa2hdPuyXP3FBwtfVW/qTgtphFBCyqS8IxSP5f80uCTRpNSUZyIt3ZG1k
	 Jn5J8uS5zoQbiANZwvSe3RmJ8CAU7FnNtYKvzQRDsaIz+AQ74nb4pa1aAl4LIq7SZT
	 tSkLJHNIP8rVAXLsgYT7Y6OudMckwKxLuf0tQsW7bKHn5fAaC7xDB6HTyi7lByTCey
	 iYhxEM5EJKZ+LvST9EjgNKz7oBwxOM9CZSe/9QpnNTGkQAimWTFIMDBkj8D9UAORuj
	 s6s4kLgcus2/A==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20240822115725.259568-1-rf@opensource.cirrus.com>
References: <20240822115725.259568-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs-amp-lib-test: Force test calibration blob
 entries to be valid
Message-Id: <172434346501.724373.2209819895123532015.b4-ty@kernel.org>
Date: Thu, 22 Aug 2024 17:17:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Thu, 22 Aug 2024 12:57:25 +0100, Richard Fitzgerald wrote:
> For a normal calibration blob the calTarget values must be non-zero and
> unique, and the calTime values must be non-zero. Don't rely on
> get_random_bytes() to be random enough to guarantee this. Force the
> calTarget and calTime values to be valid while retaining randomness
> in the values.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs-amp-lib-test: Force test calibration blob entries to be valid
      commit: bff980d8d9ca537fd5f3c0e9a99876c1e3713e81

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


