Return-Path: <linux-kernel+bounces-524812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D656A3E76E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A502019C32CC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDF2265610;
	Thu, 20 Feb 2025 22:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzdMpnjg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A94264F9D;
	Thu, 20 Feb 2025 22:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740090071; cv=none; b=Dfgy/AbokAZ4JvjkGorwhYrPk36XhAROA0FNBjl77RVkFEQyNDB7Le42R3HneWRvdHql4gJ9BHr4xgyZ4Ttut2H/grHiqXE2ch/q/1YF57OIWF53LF48Y/it0oa8p8T51lvhUApgi0vEH/6F+/5hyo4m/hffuE8c7R+JQcqmV/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740090071; c=relaxed/simple;
	bh=xdByUxBFQMRecAxfFpKFiT/Wl2s1mHfXGDQtiVjb3iY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jc27J9R7YX2IfxJND8vUPdiwuzk2gr+c472irpOQF6i6N0swQNyuy7U0+3B5f7M3BccU99jSxFck1u9hT/w+aEgMjpPghYvGWPiJqWm4XbQICyPyzYT9jtDBTqq74x/rN5qpr74ZGg/1Jtpp/wxefdItpQ4DmKmcgGHSK1EpE6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzdMpnjg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FF6C4CED1;
	Thu, 20 Feb 2025 22:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740090071;
	bh=xdByUxBFQMRecAxfFpKFiT/Wl2s1mHfXGDQtiVjb3iY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mzdMpnjgtjSPRvk099z2JsG7dViWop3nCZF801xf1x0ol5koTJCX7ooDE4T4jWF9W
	 Rf+aB5dZu22Jrtd7NQyotUAmTlyBAEh/1YPpf80hC3qXAOWYq505tMgFFWuE572MEI
	 Z4ciyQffsYlFFBk6LpuWYLp41rqJYVo2lrRs+iYeDFEZe8al2sAx7xBJxuG8Y4NVU/
	 LVvHOt63P7Ck/+TEjUMM8L9Bw9y8k+jxzevl3Q0D7daIFLWEJoffAYWROOokVaNCzw
	 bffwMKtdwHh3vaUheJTFQCLxTSc3p9uKiNe3uKCh+UVs6JQC3u+6CIzWnDjEkKzDm2
	 y4bfr67SKXHSw==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org
In-Reply-To: <20250219152132.1285941-1-rf@opensource.cirrus.com>
References: <20250219152132.1285941-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] firmware: cs_dsp: test_bin_error: Use same test cases
 for adsp2 and Halo Core
Message-Id: <174009007007.2293478.14977304010488785265.b4-ty@kernel.org>
Date: Thu, 20 Feb 2025 22:21:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-42535

On Wed, 19 Feb 2025 15:21:32 +0000, Richard Fitzgerald wrote:
> Re-use the adsp2 test cases for the Halo Core test run. Before this the
> Halo Core kunit_case array was an empty placeholder.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] firmware: cs_dsp: test_bin_error: Use same test cases for adsp2 and Halo Core
      commit: 2e2f89b184644f0e29f1ec0b4dcfd0361d2635cb

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


