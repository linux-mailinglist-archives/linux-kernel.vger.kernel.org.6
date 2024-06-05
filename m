Return-Path: <linux-kernel+bounces-203311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F1B8FD93B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 214A01F23769
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EE6161325;
	Wed,  5 Jun 2024 21:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLThFzzW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84338160883;
	Wed,  5 Jun 2024 21:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623499; cv=none; b=kYSZd3dXpHzCiFcqJ7zU/IWD1lfBzBmqzxFIqxlXEhb3xmi6HgfVICeo1Yna70EQSNoo7SPx0GGM7cVE0xpbi4POK1QWrdddqVaklXx6Dp9r20IXgzMMrIIGgMLnAowkI25T0XK9prinwfxl/ho0I/kf4us9AMNUb+KL7O0fpTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623499; c=relaxed/simple;
	bh=6EtJlD2KFxTZ/ahx6VRWByT+skUN2MITzRKsNiXaj6A=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E0i/t0lN8i1JQyHV+/uYZscmBr83XHufM4VcKDQ8Kpp+bkD/ekQmvOj8E0QIOBKnTXBkDqrGEM6i7hWiX8sDZlQxPmxPBC5hQ6W20hLM9kztBzvu2Eth4+nQOx1sTP6Y82vpyRCCjQ2/6ban4aZ6QBtKd6rz5yXKeD8vZE4ItOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLThFzzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3641CC4AF09;
	Wed,  5 Jun 2024 21:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717623499;
	bh=6EtJlD2KFxTZ/ahx6VRWByT+skUN2MITzRKsNiXaj6A=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=JLThFzzWyq8t43bRPKGaLQs+0ueojh4Semt2G+SqOWmD4DwPlwGgLJo9t3uceWEj/
	 WjhApBLH7xmqg7eThPt8JjD1ZGN3OdksC7w8uZ1W/iTXFfZ+kJcQczlylid+blib8N
	 W32rQkwUMZeu3EZWz4SFJtn4MakKW3bGV6Jq4TPCdSJmsfyWe2ZkHYVvtR2GBs5qRX
	 3jLlZJSVQ4tK1N1asAWL7P2MFGDt5UWz0tQi2O0Zn1ol/4f0ZSf3bVOInX1PBSfLms
	 hf6lorM/RFApS8/zmKSykdyxdGxk898nsm9D37SiZw99wpvQhjiHQrGNjOZf7sxfGw
	 /4juYCTVEaNZQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240523125049.43713-1-krzysztof.kozlowski@linaro.org>
References: <20240523125049.43713-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: codecs: wcd939x: Unify define used for MIC bias
 VOUT registers
Message-Id: <171762349795.565712.10860965207499324247.b4-ty@kernel.org>
Date: Wed, 05 Jun 2024 22:38:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 23 May 2024 14:50:49 +0200, Krzysztof Kozlowski wrote:
> All four microphone bias registers have similar layout: VOUT control
> mask is exactly the same.  Use one define, just like older driver
> wcd938x is doing, to make the code a bit simpler.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd939x: Unify define used for MIC bias VOUT registers
      commit: fe243a546bcbc405abb7cc5cf26852609cf4e2cc

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


