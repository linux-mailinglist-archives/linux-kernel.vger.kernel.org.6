Return-Path: <linux-kernel+bounces-372163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F689A452D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30AE9B21088
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C49F204F78;
	Fri, 18 Oct 2024 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIzd0MvG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C28D204F61;
	Fri, 18 Oct 2024 17:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273425; cv=none; b=K2/nOVVw0kTjxkMRBncuEdFGx5zX3fOQDSazvLbkJ5mAeBILwRt3WWpsE5JU8szlvBzV3KDVWYGrVTJYc+WC5rDJEMKV/g2LDVuCReDjC2E67gaux1iDQx2fu7uaFP1LRVYG5AHRlK1hQ5b9RQzmCqBgjhJVwZ9GjyktX733OsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273425; c=relaxed/simple;
	bh=XbeyX7FNDvoei3M13wTCf/2lpZ7+fW2VCTRPNVZNE+Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VqC6TuBcl29sEJd/uRWa17TWG8Zs26iWgcDCZEy/gtGGIw70HrII9oSl9ZIpwjGpVJ5Ru5E7Lr6yrEQOZYCY3AqtwP2jIteQcDoQSF3avkM6w0d0N2z6eXs3m8qggZerbRyQDsDmUZ6xh5LFZpkr2nj1CSbCjr+ZuKkztRdyo+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIzd0MvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19BDC4CEC5;
	Fri, 18 Oct 2024 17:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729273424;
	bh=XbeyX7FNDvoei3M13wTCf/2lpZ7+fW2VCTRPNVZNE+Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GIzd0MvGmMYK3Bfj9BzYhzagaM5G44stCvZx+ikR2dsO+1wyxiS7PV63zcuYistOP
	 a0etq+SfIZ78vO/8bCg+C4wnpir6EINk2DJ1HU3T0klqa54yIKMCdJTDOZy0NimNBC
	 333VhLoggzddiYxk6P8YLY8gBQCZPun6LxsnTkHG8qy5KvVLldZ8NGrlZ40lpI8y6n
	 5oD80cekAjJgfeAkUqyS/eNpNzCbkDhROEHd7ytPVWnQRA1z4i0a1tIFANGc7578FW
	 O6mN5TCSAP7/OO0FP03z18AdvnSmr3stbIW3FSA7e3cd5W3yukHR2ggl8X99peBxPm
	 SmhPeIb5gka2A==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 Tang Bin <tangbin@cmss.chinamobile.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20241016011851.2023-1-tangbin@cmss.chinamobile.com>
References: <20241016011851.2023-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8188: remove unnecessary variable
 assignment
Message-Id: <172927342272.163659.4351031993017950860.b4-ty@kernel.org>
Date: Fri, 18 Oct 2024 18:43:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 16 Oct 2024 09:18:51 +0800, Tang Bin wrote:
> In the function mt8188_adda_mtkaif_init, 'val' to 0 is repeated,
> thus delete one.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8188: remove unnecessary variable assignment
      commit: d3170359c96082302e7b6de624cb8592d8954e7d

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


