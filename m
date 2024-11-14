Return-Path: <linux-kernel+bounces-409708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 130A69C9054
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBED0281BB6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F4618C038;
	Thu, 14 Nov 2024 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuXCcqlT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDB418452C;
	Thu, 14 Nov 2024 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603489; cv=none; b=dYPZsgZobNGt0IT/jeXUT7zzr9Zqp+Hs+E8xmvLN5rOvN5aXa01V+0B/vGDTTz5G044a+RA4zX5mDokTVBhQ3glZO8AuCe5PDLlVrak0NjbdzOLCDFU/48/G3ldtD7fjrwo22oDdKAOuqpWpjF4XtOQedOMJf6XFJOqYqE1RLz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603489; c=relaxed/simple;
	bh=ohnmVR9ysF+4wUKfh7TejkUPhajwqhgwlqA+UcIUnJw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oqZjNXKYzsC/M71XE/aeNIeVKRQD89Fuj3BWdhnqsp8+XwOugN7CC83EuJT3IQ6qDfhNT6OdGtVk6/KhZ/KY1h0ig+XUGzT1knT3KgaT1N4rxm+SG5eK+sn///o4akeTt+1Rsz7mMAHEj3aNNBN5E2/TEO1jJoWUTov0DIDb+E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuXCcqlT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6815C4CECD;
	Thu, 14 Nov 2024 16:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731603488;
	bh=ohnmVR9ysF+4wUKfh7TejkUPhajwqhgwlqA+UcIUnJw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cuXCcqlTuhRVQ5bAa1Pd6hhp43jcN5YAobMlK08lRnRrGIaiuzIyETxDDX353KjnZ
	 ZJdW+13bERYkIysxPdxK9M1UH5gGWJf2kkTTiBfRYL5TGz/TWE9savyZQyeCgCVX4f
	 XrcjJ2sET+Qh/HR83QpNOj65byKyXz03FHMEJhlrIEhr0kaJ0oITP/QikWqYMH6ZV0
	 nt5ht2kt2mJhylnMQOe7d24ptWl/ykxhjS7OJuRKZ+w0M4/i9AEKZgNqSEkkBPND6u
	 JUwfFTiQJnL4AdaZA33gORXJoHJ9YLGQgE1bOT2OFpwF4tyDosi++COf+oQV3t9Idf
	 3V/e7HcLPfOKw==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev, 
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org, Basavaraj.Hiregoudar@amd.com, 
 Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com, 
 mario.limonciello@amd.com
In-Reply-To: <20241113115223.3274868-1-Vijendar.Mukunda@amd.com>
References: <20241113115223.3274868-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 0/6] Add generic AMD Soundwire machine driver for
 Legacy(No
Message-Id: <173160348532.529304.6640656409978970343.b4-ty@kernel.org>
Date: Thu, 14 Nov 2024 16:58:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-355e8

On Wed, 13 Nov 2024 17:22:17 +0530, Vijendar Mukunda wrote:
> This patch series add SoundWire machines for RT711, RT714, RT1316 and
> RT722 codecs for ACP 6.3 platform. Also, it adds a generic SoundWire
> machine driver code for legacy(No DSP) stack.
> 
> Vijendar Mukunda (6):
>   ASoC: amd: acp: add rt722 based soundwire machines
>   ASoC: amd: acp: add RT711, RT714 & RT1316 support for acp 6.3 platform
>   ASoC: amd: ps: add soundwire machines for acp6.3 platform
>   ASoC: amd: acp: move get_acp63_cpu_pin_id() to common file
>   ASoC: amd: acp: add soundwire machine driver for legacy stack
>   ASoC: amd: ps: fix the pcm device numbering for acp 6.3 platform
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: amd: acp: add rt722 based soundwire machines
      commit: 804aaa9df6c3bf9744205ae51cad084ee97567bc
[2/6] ASoC: amd: acp: add RT711, RT714 & RT1316 support for acp 6.3 platform
      commit: 7d3fe292efb637d1f748926390a3a4cc90c4c4e9
[3/6] ASoC: amd: ps: add soundwire machines for acp6.3 platform
      commit: 56d540befd5940dc34b4e22cc9b8ce9bb45946f7
[4/6] ASoC: amd: acp: move get_acp63_cpu_pin_id() to common file
      commit: 393347cc10ea24c9f93b45e8e2f90fcc48ab1d8e
[5/6] ASoC: amd: acp: add soundwire machine driver for legacy stack
      commit: 2981d9b0789c44b7375e7d599caf71bd843afc9e
[6/6] ASoC: amd: ps: fix the pcm device numbering for acp 6.3 platform
      commit: 76b5a3b2afdce1460dcd06221f7aa8eb2b807b1f

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


