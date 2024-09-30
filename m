Return-Path: <linux-kernel+bounces-344862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E12798AF0B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378EF1F23AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE261A727C;
	Mon, 30 Sep 2024 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OezYqOeF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B113D1A4E75;
	Mon, 30 Sep 2024 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727731600; cv=none; b=ltCYYHmDhYvtv2GUOmuygphDQ+mh5VZIzuHg4iXM/oWChxlaF/bJIYoCUNxDpqlyIvv/WzhRxeiKmTRkMTga3rOVxzBhllVgFS00J1sZJERsHjsaqCGGVS0lQdVPaC8DoLn5jKHDYh5PD+KErsgzI/kWeYcI+Iv6Lq6pCnYc3+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727731600; c=relaxed/simple;
	bh=+J2ZnHcs3Cs8ztAKzUzW1hwhinQ3m/1kYKCglsL7ZxA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SXywQQsHKNr0nRK0bzREMcAj45qBQ0WqhId6GVr5R6ZRLNaEplOYYYDzNWIMTtk4QNjzHwJKn5ME2q9/bOxAC9Owm3GYFGdAzEyPG/aj4mZ81K07zuL+F5L1s7EgMEe7ExshKrjYKPbrBca1Eadw3Z1u35Vd+Xbq2MS5Nnjeu8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OezYqOeF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29DEC4CED2;
	Mon, 30 Sep 2024 21:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727731600;
	bh=+J2ZnHcs3Cs8ztAKzUzW1hwhinQ3m/1kYKCglsL7ZxA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OezYqOeFwb8ogJNGTd+hxDLXurgL7AbtqSItFI9cyN7CJ4c3KEXR6EKMkamDQPMwA
	 P5yH6ySLU8049sa87b2oTG+oJ3LrIJT4/B77qSEEt6WyELSKLltXrTgqecZjm5JXf8
	 Bgjdfue3vbq7XQYYCYGB384XNjtSci0UeMVv/+tOdmdH0G78yKKklaUQL5KgBY2H9C
	 mt5T8AUTHsLvpKcMOFqcqGL6xmQX7r5OYvBkdQzIqBju+tTLGEbCochSdJXc1Ra9Ek
	 tD4GvB0yKVrE0M8yIKw0+RyJS9baZKbZca+zdfObrzqk2EkirMsZRJoAwRixckleuj
	 nTOPn+E6mOGTg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Weidong Wang <wangweidong.a@awinic.com>, 
 linux-sound@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240923120723.837196-1-colin.i.king@gmail.com>
References: <20240923120723.837196-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] ASoC: codecs: aw88395: Fix spelling mistake
 "unsupport" -> "unsupported"
Message-Id: <172773159871.2197048.2067245466980325945.b4-ty@kernel.org>
Date: Mon, 30 Sep 2024 22:26:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Mon, 23 Sep 2024 13:07:23 +0100, Colin Ian King wrote:
> There is a spelling mistake in a dev_err message. Fix it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: aw88395: Fix spelling mistake "unsupport" -> "unsupported"
      commit: 87ad2133b805a6c18f159016a4282311a37c6bcb

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


