Return-Path: <linux-kernel+bounces-372166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B059A4531
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFEE61F22A86
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC28205ABF;
	Fri, 18 Oct 2024 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GK1rXkmK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43F72040B6;
	Fri, 18 Oct 2024 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273434; cv=none; b=hkryrhzFdxlKF3zN7qaFXkmyWrKD9p4B+AJDJN+M8miwKxJi0NY9Gn7ACepTTXxiT91WcLvzKxiSsGoqNFTg8AnA9t2jYCmj1RGp+DOeqIEKArhRjNA5nYBX5lHUdxDa6o8cMNqz/wHwe1KWnlTwXUx7caU8n04u7SMWf+66nZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273434; c=relaxed/simple;
	bh=N5Y6zp9ZHim+SaXxlERH1Ab7rY5gRykwohcCnbWSZmY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NJ6OZzK5fSsm2cdf7/5n6ogpWTCEhYIvosJxiXtccxzxrE8a+IwmZ1fJJu+oMctaxKU6R0lH/SxLyGUAkaYnz+g6nz82tLFD1z6ozz2miNdQPBzbIpgt85k8g+2ITHqR4rVRiZofVMV2mvvek2CIyn+M1gH0MyjbgF3PORwE9XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GK1rXkmK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58302C4CEC7;
	Fri, 18 Oct 2024 17:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729273433;
	bh=N5Y6zp9ZHim+SaXxlERH1Ab7rY5gRykwohcCnbWSZmY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GK1rXkmKOUORkl68lt1VQ6BEyTBV36VEdMAwATFX8VfHO9+Q+8+hVz2YohGtMABhh
	 yjqvH0GDJQcBHo/+w0/TCqPUyolK/aqG+ntfqq0+xQQeCGk7VbO2jAeu9bOufFva3J
	 YWv/ZMFeclzrSZ0UkNGxgHbAKzQq8o7BwDX/HiVJCARTf5vi38qOw74pCc3sjeAI4O
	 JQLNDWPmNif4mGdiGI4p2OQrkt9Sp+J7teV0AsIqHujmlSUHaOz3QZr6fjxy2KgzuS
	 17jFmi5iBmfXtpjkjU39EM01AII87LXJPLi46su1ekfKO3gJNzwEnBvvd1BoJrRaOn
	 2vxuWz3HLACQA==
From: Mark Brown <broonie@kernel.org>
To: perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com, 
 Yang Li <yang.lee@linux.alibaba.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20241017051909.4638-1-yang.lee@linux.alibaba.com>
References: <20241017051909.4638-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] ASoC: codecs: Remove unneeded semicolon
Message-Id: <172927343209.163659.598002433877630053.b4-ty@kernel.org>
Date: Fri, 18 Oct 2024 18:43:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 17 Oct 2024 13:19:09 +0800, Yang Li wrote:
> This patch removes an unneeded semicolon after a switch statement.
> 
> ./sound/soc/codecs/ntp8835.c:280:2-3: Unneeded semicolon
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: Remove unneeded semicolon
      commit: 7bc18a78157997575d8260bd922fff11fb5f21df

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


