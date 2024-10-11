Return-Path: <linux-kernel+bounces-361382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1348B99A770
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB862868A7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270DF194C78;
	Fri, 11 Oct 2024 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inwKbYms"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AE2194AEC;
	Fri, 11 Oct 2024 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660196; cv=none; b=VOcztYll3jOaFbLRGKWSYesCeQWanWLyVg0E1myQuw9tOzS1rJrXdZBnOxwVCQb9tR2kowuWZZ/3qNCY8+/DYXt9yXHfkLfBHR1uVuLx+0pbKXr+CKNb2iyp39z4BXiloa6SGeCaPWFAE3Z9rIR2SQf7O643uu17gMwUt/68/WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660196; c=relaxed/simple;
	bh=VxMYsiMGxFdOggv+A2yXHzsko1My1hLKFoG5O1Jw8Pw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bjhj0AbMNsu0zb2S+nIWv3Ap5Hby9w+flrHDvVZu1g0bteJt32eXJFnND3weELMNZ6i514slZvppKQnsy9Wi8G+BfPXFUGsZ6Izct2snciKFqsB02BKyX0uZqUZexT/XKSIjXTejb4Sy7ieSSejE9OkkqDV1IApVdiXok0O1IOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inwKbYms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D08C4CEC3;
	Fri, 11 Oct 2024 15:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728660196;
	bh=VxMYsiMGxFdOggv+A2yXHzsko1My1hLKFoG5O1Jw8Pw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=inwKbYmse/jNerPh8/BxmbXBw54gwkLiN0CX2N3bInMxFomMNQlAz/kcymjXilMgn
	 2kyXa6AbyvtEINqUV2L0FdRbJ/mLNLVoIsuaYaGrD+BxlDXYSZPH613MsFXpq6tWK1
	 um4w7+atyc2auMd1imP4yCzWYVhHIQu+VHV7AU6BBl3p53p3TN5/z3RZ1swfI1cCmV
	 IiCzFbhayPQCdJX79ItcbMXeR5lOkWR7ZnImJi568bfdquZJJepmNbGBy/tFvAf8xw
	 6ybUE/Diry/rJbWaGG2q5UR3nkdiv7Aqn50QfAF9sJY7FQ5t/mmac4rfT9qUF4Gti1
	 wBloIPz5T3O5g==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 Tang Bin <tangbin@cmss.chinamobile.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20241010073547.3720-1-tangbin@cmss.chinamobile.com>
References: <20241010073547.3720-1-tangbin@cmss.chinamobile.com>
Subject: Re: (subset) [PATCH 1/2] ASoC: mediatek: mt8188: Remove
 unnecessary variable assignments
Message-Id: <172866019355.3915434.3492314512247747487.b4-ty@kernel.org>
Date: Fri, 11 Oct 2024 16:23:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Thu, 10 Oct 2024 15:35:47 +0800, Tang Bin wrote:
> In the function mtk_dai_hdmitx_dptx_hw_params, the variable
> 'ret' is redundant, thus remove it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: mediatek: mt8188: Remove unnecessary variable assignments
      commit: f5a0ea8936a640d8229d5219515141fc496ec5d8

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


