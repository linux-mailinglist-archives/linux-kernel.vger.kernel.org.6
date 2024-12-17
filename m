Return-Path: <linux-kernel+bounces-449521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8075C9F503C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11ECC1890BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE661F893A;
	Tue, 17 Dec 2024 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSbHXWdx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0619E1F7096;
	Tue, 17 Dec 2024 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734450525; cv=none; b=GJBdUDKRN0MKBPToX5r9sSzHYLqXjYySHL0GTKZUCjupcWaTM9LqfKcPMAx5i2N/kP8aanhAK6DwzcTUzc6KblQG6lT/p5KMpyP6GkiGU8YGnJc8LHb8GSLxVrBin1rUEmsNjo7cNLwKNfEU7Y70P71AaMOH2uo48HccpYwZ6XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734450525; c=relaxed/simple;
	bh=PAibtwA3w7SzUhGczgC8VqNx09UQ/7+KOrpqOnDpMmI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VnLfUoPm1gycIAhERhvrZxeDfKU/ECbs0cTPc6a61jSIPZmENTrZbC6FbSD2wXUCdZs6d7AiZa+SqE/RTICmMGS1/p60xDFx+Wp1Zy9n5ozhcfu2P2w8B+idqOsigjqNLb9FwsD8lroRYczY8BtkPOFSm0Ay1u3A/Xgd2U4aqak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSbHXWdx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB14C4CED3;
	Tue, 17 Dec 2024 15:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734450524;
	bh=PAibtwA3w7SzUhGczgC8VqNx09UQ/7+KOrpqOnDpMmI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sSbHXWdxjMYbp1LzE9z07wUvX4eCT1MT8uOHJe++Mzh6cbCUM3JqJf3IfEDnNL2E5
	 i7950P/QjGz0gplOQBasVBIB+Fed9162SWI+Ka3/0fyaqD6xDUYiaFPgssww1INZqG
	 36Kwk/m4wUaOZmrb7ZW0muSN7WEJhRx0AHV7H/pXPKDLeMfJ0HZh7dUrEynBTaIngF
	 ANM0mLq6zaGFecMeLQ0T49vvbFaWnAqq8UEh1ODKSm+a2vTjHgt35uktv9r6/0Ne4y
	 U5DUeXYgNZZxJFMEzn86e9o+6uS6DEQel8dKJ82R5Mw1DP2F5xdR2e/zCmvspchgmh
	 gjhspVh+QjZJA==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20241217070545.2533-2-wsa+renesas@sang-engineering.com>
References: <20241217070545.2533-2-wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH] ASoC: cs42l43: don't include '<linux/find.h>' directly
Message-Id: <173445052264.96598.2296647542527379530.b4-ty@kernel.org>
Date: Tue, 17 Dec 2024 15:48:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 17 Dec 2024 08:05:45 +0100, Wolfram Sang wrote:
> The header clearly states that it does not want to be included directly,
> only via '<linux/bitmap.h>'. Replace the include accordingly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l43: don't include '<linux/find.h>' directly
      commit: db8b9b12892f0528c3a78715243c22398ab3cb5d

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


