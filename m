Return-Path: <linux-kernel+bounces-295776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F3895A15B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49EE41F237CF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845291531DE;
	Wed, 21 Aug 2024 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8zD01d1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B02152E17;
	Wed, 21 Aug 2024 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724253893; cv=none; b=exVZHm9r4PPIx6RUdP5Ffg8GWXWgZ2rcEGsT8lQh1FurmTIogCKC49FMn/a2vyQObpA2XE3R5c9cIqhsRlGqy3Ogya9liplYj62Nr8CimHYwXvcMJKgjrGFZjLi5sTdeYgNNuhbCLTIShTj/P3Tenpablc8p0hmfeXmWWbgySp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724253893; c=relaxed/simple;
	bh=KtFrt9WfErChRtcLn7HkhtzBOi0BwJCKu2TQs5yEJko=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aKvzm6Kx6ox/jLsxZYbzDwCxiPpaY8GF75E+VkvPEDw3adAmfq8nhonAt4xI0SD8/yMYJJGE6j8ujLgL18thbXKOOsZsh7Wc0V+KOVXpETzXk42++37U47EZzNzYAX4voiYdncngLSjjJVKw0ZYKZX8GqSWaWKSiDHKUep4Ogdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8zD01d1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE18C32786;
	Wed, 21 Aug 2024 15:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724253893;
	bh=KtFrt9WfErChRtcLn7HkhtzBOi0BwJCKu2TQs5yEJko=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=t8zD01d1WE1dJSFTPtWnx3Sh5orii5BzZcFXYPPXB5EtmUSilq7J5IxQIygEq/Che
	 FI9mU+4bqHUmrW+mXUxOBYPoLmOGN62Ggtfyg9gQUoADX4c5Ft2lK6mIOZ/NHhsowJ
	 FG6/DEFJGmue9CUI3qBpKsVqXel35YVN2kbq5vPDHJaG+J7qqrZg6rAJ6kDrXtJTrF
	 EXI+yxclGVLxt7enY2/caw1wCCWMH9YPCzaOp6+MV4IAzufZjtZx6puv6BJBYqw3I7
	 qP5r+g6eKE1Zwoy14LE3tpNmhi6sY4yJ2gQTEf5XRQ9eJwb8RxHD7vYcObJCqiqrQW
	 9EJgUvNiL5Ldg==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com, 
 yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com, 
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com, 
 venkataprasad.potturu@amd.com, cristian.ciocaltea@collabora.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240821064650.2850310-1-Vijendar.Mukunda@amd.com>
References: <20240821064650.2850310-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: SOF: amd: remove unused variable from
 sof_amd_acp_desc structure
Message-Id: <172425389056.1704682.17614913530491434962.b4-ty@kernel.org>
Date: Wed, 21 Aug 2024 16:24:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Wed, 21 Aug 2024 12:16:50 +0530, Vijendar Mukunda wrote:
> Remove unused structure member 'rev' from sof_amd_acp_desc structure.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: amd: remove unused variable from sof_amd_acp_desc structure
      commit: 61c80c77b4f35e229347551d13e265752f067151

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


