Return-Path: <linux-kernel+bounces-361015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E3299A266
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B0F2B25713
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8B021643E;
	Fri, 11 Oct 2024 11:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmrGb5mb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDBA215F50;
	Fri, 11 Oct 2024 11:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644807; cv=none; b=Dt8ydOrxtU6rgXEOZbFrHbZXO7ve33cjVE3+Vh4TlxGzPq1YdPA+bHATnDvXzPfyCsTlX5B/GhPc5bOuZsrSPjvpQNyXu48jWdvow1qEKppUUItqYYuAdE85O3yGAuEdKZGkUn22TeXLLjFqys9+lgeaN91IuO9TW4G1hP9Lkdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644807; c=relaxed/simple;
	bh=OoZeLIah3I01QLkusQPlIZ7O+7pRRC5P3mA7NRcwM+c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fzfuq8ymzaq3QsUrehlK4iLB/grFRbMyksDjJa/qA1Pux3TBwgJGrj4+grx8q5jB9O9OpH6z5hbt3FMdxDpK/3mK6BUmRT29sRG3rPUU6QoHM4a2LHuyBhLgFzRcQM7geJ3XGbyReTlMmycUwzQhCqaz9egDMA1ln0kFqGLVuYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmrGb5mb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BB0C4CECC;
	Fri, 11 Oct 2024 11:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728644805;
	bh=OoZeLIah3I01QLkusQPlIZ7O+7pRRC5P3mA7NRcwM+c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UmrGb5mbPwmt2uFQWta7DbRxN4gV6UvL0HQQXI6fPMFP+RlCTOlDSDYhU+weKIXtz
	 SvrybybvohJ95KPRoMiRYfyG6VD+YVNPisGiNakF1WmcQjwSDtfdvkTnVXo7SvN/41
	 p/ve2rfPenx5cPoZ3h/RO/GA8sUvsjWixlSR5V5ZdNdwKnrkDwMR5r9NbjCkHgpYOl
	 SC7xS1IKQsaV1fPJr6Tu+YlhRpizf1wTpU4TLDQ7TSoRSrmT6WElVSHtyqgoBZJz1f
	 XHRB8njMKJR8eOQWeoeDCbjHWUNveke60eQFYzQx0IaBtkUZQ6tnqHBFC2IeR/hF+M
	 PFGOR2UYA9dFg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Christian Heusel <christian@heusel.eu>
Cc: Thorsten Leemhuis <linux@leemhuis.info>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20241010-bugzilla-219345-asus-vivobook-v1-1-3bb24834e2c3@heusel.eu>
References: <20241010-bugzilla-219345-asus-vivobook-v1-1-3bb24834e2c3@heusel.eu>
Subject: Re: [PATCH] ASoC: amd: yc: Add quirk for ASUS Vivobook S15 M3502RA
Message-Id: <172864480352.3868579.17081032898194754716.b4-ty@kernel.org>
Date: Fri, 11 Oct 2024 12:06:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Thu, 10 Oct 2024 15:32:11 +0200, Christian Heusel wrote:
> As reported the builtin microphone doesn't work on the ASUS Vivobook
> model S15 OLED M3502RA. Therefore add a quirk for it to make it work.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Add quirk for ASUS Vivobook S15 M3502RA
      commit: 182fff3a2aafe4e7f3717a0be9df2fe2ed1a77de

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


