Return-Path: <linux-kernel+bounces-297873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF5595BEC0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E70821C20DE2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F222101C8;
	Thu, 22 Aug 2024 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWMnpVo/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6649B3A8D8;
	Thu, 22 Aug 2024 19:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354252; cv=none; b=h+e9MFKFG67spoz68WNWrcBqk1tMVBSCerOVeWKmqGIvfkhRHXUE8I0b0lV0SSIe4wp0ZLcWsQyagkaj8biBBUqrIzM9kVcnU7wznW1cLrpX3T+OaJkJKcjbcl7Her0uF8l6w65fG+i6BtYHSlCGQkocPLHh5dXWEfouJ3+m/Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354252; c=relaxed/simple;
	bh=t9RM++6pKjyJHdpxIBuKlfPuK8QLEqIkvIlaw5yY5aY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ch7bKaEj/KUwjFK0lXR3N1/p8ZdBqOnTWu7ns94QyMcRja/q4IVzHKxL/Mrp+g5UMFDL+h8dO2v72E195oxnKowinlTmNdxLU6+2HZcKLuHG0OZbS/3Y0lCYr8QbG6IeI1+ALoHkz7bvUitBGz+ZiKpiDMGj75y2kMk0KcKBEUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWMnpVo/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C35DC32782;
	Thu, 22 Aug 2024 19:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724354252;
	bh=t9RM++6pKjyJHdpxIBuKlfPuK8QLEqIkvIlaw5yY5aY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mWMnpVo/ZkWSGmbk3M7oFl9zu34MOdfhpfCBCzmnbscjljpXOa6LHV8VuNkdQpOpF
	 pciMsZs2Emhodsf//5OBMku+s8O5BTlIkmXrzhz3FIaB+unxinXKYrRiPa3YX8/qga
	 c7VZwrZgwdcFvtA/l/L7BxrsVYNif00pZvJJlWcha9rXcDT4TvqH/Rnflg7aC+3loS
	 LRZ4aQ+4TPeo8E5nBmmdf0l8miSaZdYeVQ1gtGjB3rMvzjIshI8nSCI6SAxaTP8VJd
	 qTsc1L63kW05PG5yh+DmIwRG1VAcq2U3pxep4YTygkFr2kzlXen2z9VmCLpsIGTSt2
	 czqeZegEwgwYg==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20240822145535.336407-1-rf@opensource.cirrus.com>
References: <20240822145535.336407-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l56: Make struct regmap_config const
Message-Id: <172435425081.748295.8354801922951491088.b4-ty@kernel.org>
Date: Thu, 22 Aug 2024 20:17:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Thu, 22 Aug 2024 15:55:35 +0100, Richard Fitzgerald wrote:
> It's now possible to declare instances of struct regmap_config as
> const data.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l56: Make struct regmap_config const
      commit: 90dc34da02aca2fe529ae1ed1822e8fc2a0d9ebc

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


