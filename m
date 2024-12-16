Return-Path: <linux-kernel+bounces-447934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD7A9F38E3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFF0D1894D9B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87194207658;
	Mon, 16 Dec 2024 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTTGvBOL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFBC206F2B;
	Mon, 16 Dec 2024 18:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734373544; cv=none; b=ZojVfdM0IHejBj7XAMeWHWh6XuKXyp69wlt8q6NpDOZZDLnWEqGIHHMkn1Xu0MZo5nwS1nhILQOvTJVGbuyHI2/Duob3gmkfB3/zNyN8lGqRjo+mmZ+12OeUV0p+dhj250yznCbZBnmP0K1WXDZnJZQu4RzEyFZY847btg0AtFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734373544; c=relaxed/simple;
	bh=/2v9/T4ndK3MUE94EmauvESCExwyZebpPrRhoptAt8s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DrWB3Z0e+AaqN784Nm/c5Rty03nRyQnaLugkuhu2DthNaqpstw7Ic52beyQlFdvOGFKJXBqoz+uL7s5KQ5y3f1ZSFiBexI8CMl1i1PkYXH0eCwbhhUtniwWMFNH5HstakDcQyoR0NU1PFuGI4eD2nmiKKeJBWJEVR+WE5chnAhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTTGvBOL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B3AC4CEDE;
	Mon, 16 Dec 2024 18:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734373543;
	bh=/2v9/T4ndK3MUE94EmauvESCExwyZebpPrRhoptAt8s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oTTGvBOLbmZkpV0Iv1vZUUngNEmyKZN2zuLZUAXdTvwkHJfj4fAyvzx2oGp5U887Y
	 MyqhfpptyektCeWTFJh/Ng5xrOdZqANl4yF9j0MK6gJ0J5a83kbGPyg1fjsQNzE+Kn
	 zzRvvHQexByQf8goYGi3wBNbBW6eWBxFtFa8reoGcD8MuvCbAaXyN6LoebK3FsOQP9
	 ucowHOZuRys1ZxfqMR0Aax3DL85aAcamSxvT/gCh09wm9tgxnqX61eUCYte7MoQUH/
	 wmkhwpl8I25IpaRO0Si6WBD6KpWGG1Q9lAffKwRaIFAmBRoxpLB7jZvaYGzF3FCAHY
	 be9UG62jW+oCw==
From: Mark Brown <broonie@kernel.org>
To: oder_chiou@realtek.com, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, linux@treblig.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241216135110.53426-1-linux@treblig.org>
References: <20241216135110.53426-1-linux@treblig.org>
Subject: Re: [PATCH] ASoC: rt715: Remove unused hda_to_sdw
Message-Id: <173437354180.179097.7907664727883461744.b4-ty@kernel.org>
Date: Mon, 16 Dec 2024 18:25:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Mon, 16 Dec 2024 13:51:10 +0000, linux@treblig.org wrote:
> hda_to_sdw() has been unused since it was added in 2020 as part of the
> commit d1ede0641b05 ("ASoC: rt715: add RT715 codec driver")
> 
> Remove it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt715: Remove unused hda_to_sdw
      commit: 37c42bde28f580ac5de4de838afd5eea72e40262

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


