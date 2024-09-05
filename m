Return-Path: <linux-kernel+bounces-317689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2276B96E230
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B73C21F261E7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F3E188A0B;
	Thu,  5 Sep 2024 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1Pa9zDm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E6D18786C;
	Thu,  5 Sep 2024 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725561752; cv=none; b=l5MOZUfdPDXfOm0S94maARRuzTolLBCA58Y5jD4ClaiRCV1yU2B+KA282dGqNF9+vyigSrUydqKOplZeo1B73V0uruoUCYltQGzrcK9Kj5WrcLKw8wxT9jo+KWLdtDsyuU5hd3HZc8tKPuY97v7EwqKkriJUq72PL1aaFaZF2V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725561752; c=relaxed/simple;
	bh=ji1FHOuv1gWMbUUUMoTG5T9yzz8pQdOdFwBYKB0829c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fBb54c+QrluhK4dW8qY4cflU/vqDA8JQPAFnLsImEw1JKFl2v5Dc8GgNtwqoBdPmmnoSlUVx+xGK0ufYks8E9OweM8U3AlQ54SveqW/MCwIoa/AebBvJfv9HPO2oKuwft4XOCvjI4DLr7S73FOEdhIsz3mmlapIqtmuD8q91dmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1Pa9zDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD86EC4CEC3;
	Thu,  5 Sep 2024 18:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725561751;
	bh=ji1FHOuv1gWMbUUUMoTG5T9yzz8pQdOdFwBYKB0829c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=X1Pa9zDm9SyKmtf1bsckcovtDaRvCwtS4JHLpLQEfy+4WXCb8Cy69u8Wi10wFT9/e
	 z2+Q0IhjfRStbFwT8Rtvdu42oTWYuW+5chgb7Ej/ZEm9otX42zkU7HRhl4ost+jwT3
	 5qpaefpFEzLzmdUMzZaEqKu8AHYkKMdRh2RLqxA4kFClPQXzp6JSpvcLq4Q+c7/Cmw
	 0hNGcsnCoGehmcMzT9Tpz9gh3nwW1r77roWCIok01jaJvXvMdR/YwbvI8MuRhEEuLb
	 YAjR3HMj1g5ezS1BB2O+GfIHp6Oq7GxWdKxP17a7Wv8hWEbJOItvzosjeDI5zsMTYA
	 BVCVsaqKXoqAg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 Chen Ni <nichen@iscas.ac.cn>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240905032148.1929393-1-nichen@iscas.ac.cn>
References: <20240905032148.1929393-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: topology-test: Convert comma to semicolon
Message-Id: <172556175044.65454.17792547904435729197.b4-ty@kernel.org>
Date: Thu, 05 Sep 2024 19:42:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Thu, 05 Sep 2024 11:21:48 +0800, Chen Ni wrote:
> Replace comma between expressions with semicolons.
> 
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
> 
> Found by inspection.
> No functional change intended.
> Compile tested only.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: topology-test: Convert comma to semicolon
      commit: 54694840eff5e95d1b0ec0c916db2d889529c5d7

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


