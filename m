Return-Path: <linux-kernel+bounces-173192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8FD8BFCC5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34ECCB20B82
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FDF839E1;
	Wed,  8 May 2024 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iu2fuU1D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FF2763EE;
	Wed,  8 May 2024 11:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715169580; cv=none; b=qD2zxUsav2AMTBoK16xMiBm08q0tJgJ9lSXdpD69Nty4nyqZ1E1e8BaTM1cs+RKtE9fEl2F8X7hWgAOR5wfbyso5EZAbahVAWcEo7U1I03uB6ri1u5dttvUAhlMw6goteQLJOdpBzinRrocXZkIgUgwmoSaRFJ7kMJblaPZuJJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715169580; c=relaxed/simple;
	bh=iPSLYdvpHZL8N99CSAPTgsQXdLDe9wyW44Dsp+ra6Dk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n/6hnw9+sc+FqI2eo+cM93YUuPsQeIDOuwzzH8kLXoGxa7rxBLSQlouGMAJimwXwluJHFtBFPLLepH8qd3vbKUaZTY+QFaY2xAHOqLv0pHqTGFIz4klu1YU+hV23NCLg72mBWIiX6vvrLz0XX1vR3urq3JhrcqZC8XNDNq1I6T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iu2fuU1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E02C113CC;
	Wed,  8 May 2024 11:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715169579;
	bh=iPSLYdvpHZL8N99CSAPTgsQXdLDe9wyW44Dsp+ra6Dk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iu2fuU1Dk8Mzv2pz0J2X/l580RyNBoBQ/xDmcl3K9BReNoWJH6oTUzEiFcWnvpKHK
	 WAtHBDgNjHnHfsmjDql5ZEiIGs1c8M+L6MDg9GvugUKu+1ciNS2aVmWg1yKzYusm3a
	 p2iSR7DI62fSJUNjSBeIBEs1QqkMHzdGlcLmdDD6FJGNqzVmgCqNLrTp8wQ9sUitmR
	 NTHxVez+gv8FAWQzCaDYMaFsY+weSkxSxnk9XXoHwtVvks0Ws03jJ6wLbLpfYKoepo
	 2SMfQToz7o1VRdveI7XAFGgZUGdwLDXJVvS4VvrUi5Nxfjz+v+Q1XYAELj98ipbRYl
	 LQJ+Q2ujO7vsA==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Peter Rosin <peda@axentia.se>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
In-Reply-To: <20240507205659.690270-1-andriy.shevchenko@linux.intel.com>
References: <20240507205659.690270-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] ASoC: atmel: tse850-pcm5142: Remove unused
 of_gpio.h
Message-Id: <171516957734.2010832.13216398163199457795.b4-ty@kernel.org>
Date: Wed, 08 May 2024 20:59:37 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 07 May 2024 23:56:59 +0300, Andy Shevchenko wrote:
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel: tse850-pcm5142: Remove unused of_gpio.h
      commit: d45ae45f328b6824966ab7dbf8b1c712f7d0e877

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


