Return-Path: <linux-kernel+bounces-280156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B81094C66E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 23:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07DFEB22577
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DA415DBA5;
	Thu,  8 Aug 2024 21:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZ9cjZe0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308F515CD55;
	Thu,  8 Aug 2024 21:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723153611; cv=none; b=DQKhj2s6IzXTa0WYWYXDrJfHruEWFQsY67THp22/9SGb2Du2ReXH9TQjX2YW/1VlnlhY++pFnVIgm+3z+WmTwYrIVciaVhxJPSlroVdsAm99ZliPNzuWJTiX8z/qjTH+1fgiOj1WdMwUi+3UZBnI3Du0sCb4PFnQfbj4Si/eibo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723153611; c=relaxed/simple;
	bh=SrCA00LIf/8WOXQ3qcmUmKiAAagWu7ZJgow5VDaam+c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=p6an+DjkSLcyF6FnR5rOO9yvgidmejg+7fdELpHS4Y/Ss7gtEprjX25VfGzX+DYx55QZDJMihk+JYPkxsXioyjgHdWsSkotpuRjBM+eP2PwRHAX2L5Gw2e4fJotNuvz/EV1WIzfCAenE8VcNCEUmJy9owmr4WuySdSKWi3JY25s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZ9cjZe0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E72C4AF09;
	Thu,  8 Aug 2024 21:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723153611;
	bh=SrCA00LIf/8WOXQ3qcmUmKiAAagWu7ZJgow5VDaam+c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bZ9cjZe0POp4JGOuDLjdD6aQkYB+P7985cL9FZtK88aqOJBK768izyFn6wcwfL5W+
	 XcP0+JAdA8Z+wPTtJjE0mvOQl1w4ZduBXONflK1+08LBQXMDxOzmdqIC01Qc50uacl
	 lr1ORJYjMFgcDuUnw81+w1o2qpPb9PoqlTh5c/dlhppguJbk6e2axJvPwVcG9tC6mW
	 U+2HvWvvIv+Sm7tQytU3ev+8tic3NCGltcOArLUIjhSW+iUVqX+peYhsndOOPXCZhx
	 BQuJlAfsj/ZgK0y/2iqPv/HJRBfXhOytWI4w4Nk10ue+DBjDJ/RZ9wMUmKCoTOj9wp
	 vO/9KY2+tFXZg==
From: Mark Brown <broonie@kernel.org>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240807142648.46932-1-simont@opensource.cirrus.com>
References: <20240807142648.46932-1-simont@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l56: Patch CS35L56_IRQ1_MASK_18 to the
 default value
Message-Id: <172315360941.480667.13660715615333697845.b4-ty@kernel.org>
Date: Thu, 08 Aug 2024 22:46:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Wed, 07 Aug 2024 14:26:48 +0000, Simon Trimmer wrote:
> Device tuning files made with early revision tooling may contain
> configuration that can unmask IRQ signals that are owned by the host.
> 
> Adding a safe default to the regmap patch ensures that the hardware
> matches the driver expectations.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l56: Patch CS35L56_IRQ1_MASK_18 to the default value
      commit: 72776774b55bb59b7b1b09117e915a5030110304

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


