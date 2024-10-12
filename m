Return-Path: <linux-kernel+bounces-362434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8E499B4F6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 14:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 598D9B216CA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 12:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE99018453C;
	Sat, 12 Oct 2024 12:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIptPkVk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394CC1F5FA;
	Sat, 12 Oct 2024 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728737445; cv=none; b=KhH4xaT50txis1GVSScijZYGKUga2XWK/61T4mprUVNljJxyXpxjxYZAhRoBHVlo/vTFh6BY2xnDvhzWyhFkg+f6mAP0fJIbP4t6hvZ+pFdgdv+Q/IIMZCxcZ/qCWFeBAHeO77jRSF2UqFdFJT/KjSIGf1Qed1zuInTBa14y9z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728737445; c=relaxed/simple;
	bh=v8NCU068r9dRn1DQIRAWChXlgs5/3w1Xkzg3alhshIk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MmqNUqIk4HFSSRTY6VbnR4p7QJdKd1Km08vK5dsY2TZokRmiEqoIPx19dBFplhiJjdqPhIXnlcKLGf91Mdlrwy2SZ+bWau7tDEkdkmSOHpRjIayXcaJhqpSQkjmPCSoKjHgLkRBbOO0zVZZSq5kbPUyK0psFVlHxdbd0Qxy8VDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIptPkVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E4AC4CEC6;
	Sat, 12 Oct 2024 12:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728737444;
	bh=v8NCU068r9dRn1DQIRAWChXlgs5/3w1Xkzg3alhshIk=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=EIptPkVkRSmm/GUI3d9hQ5wMrt2rbjdH63dw8268TGBhzLxitDTkOFy5aHDLDY5pk
	 Dn1ZOlGIRRf+S55RhnHmr9W+YDDuUmaiWnSOAnHp6NyYVAiCfk8jJ4UJTupIx08RKM
	 vbwiZolNs2DVrbm8UmElREWMuIH4quCjSEGpuGg62URhot6Sxp4iKMcMkvj6xHOUCR
	 5Nw3IrtffKh3gAm0/BtXW3Lz2rt01ZGBtJnjgGOKFWyrnXi9CCmdCgms9wFeUM4yac
	 RdBrjqb4sUcXSr4en4tI+OdMK+nLb3iB5YxnyGD9e8HWn3oOFMIIBQQBdUSQmh7nLO
	 TL5AxSfxFoW3Q==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 chancel.liu@nxp.com, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1728460004-364-1-git-send-email-shengjiu.wang@nxp.com>
References: <1728460004-364-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 0/2] ASoC: imx-card: add cs42888 codec support
Message-Id: <172873744192.3950734.11628347626617222095.b4-ty@kernel.org>
Date: Sat, 12 Oct 2024 13:50:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Wed, 09 Oct 2024 15:46:42 +0800, Shengjiu Wang wrote:
> add cs42888 codec support
> 
> Chancel Liu (2):
>   ASoC: imx-card: Set mclk for codec
>   ASoC: imx-card: Add CS42888 support
> 
> sound/soc/fsl/imx-card.c | 59 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 52 insertions(+), 7 deletions(-)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: imx-card: Set mclk for codec
      commit: 892373e4de626c61e91816e3d3970d82beb50c4b
[2/2] ASoC: imx-card: Add CS42888 support
      commit: b39eec95b84d5dc326c3d7c89e4e08b898dbc73c

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


