Return-Path: <linux-kernel+bounces-203312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5AC8FD93C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A335286A16
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2B3161B6B;
	Wed,  5 Jun 2024 21:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+7S62m6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD3615FA73;
	Wed,  5 Jun 2024 21:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623504; cv=none; b=lKfZel16scWN4wdQD7VLXA69HIQWzNHEi/gI9AsshQxa830qVVIFNCVHLEeaCAhpSrIga2t3tPlNfC+wFytZmou8Tx6KVWXOVIJ9PzIz2pLVqOf+kDT4uxMJjhPR4Y57yS5JEnzdhkxYvFbx+cN+Z4qOmn4ofmppdbDIS/XD48c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623504; c=relaxed/simple;
	bh=3MQrdpD7iV1KDjW3kAGXieRxnfAenZ67QSUIaKCrQHg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ECrFRnF6iyWw4QuNgVgF1sApdmaCdXv5fj0bNggxRHIhGIuAWaGL2tfJlpW+kAGyBO2KE0pfdPUcmSSUuzsMFCKkzkQSYt8TXCduHM6OqTIp7I5OT8FpMERe0tjl5tdDW0XWrj80XIqzxfmUq66y4aaRw/H6VnNHktRyrhRfSDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+7S62m6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DC8C32786;
	Wed,  5 Jun 2024 21:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717623503;
	bh=3MQrdpD7iV1KDjW3kAGXieRxnfAenZ67QSUIaKCrQHg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=E+7S62m6lA8IdAbQgaEptCdtxVdC1fz9DQH2aTPGIFeEJTbQx/pNcxI5iqcoLw1El
	 YEFDW1VXwUvj+dVKegDaRqjkYtKhtbftfgO3dfS4G9rDsFP7llqWjwGFXqcVIUFiRC
	 gWq44QH6CvrGkCwbsmWPu8ZMHhR2BMNIZtwINpfyuOM9vUZ1i0YQGuet6KSlB7mWdc
	 kciNgB6nSVZUdQtn2MS8cWJT5mw77HRG9j7zvK+rxF9if7WWjORnQb3r9nazZSOG95
	 0Yu7R1Khusw3p/6QP+iXQxNT95xbn5yWGXnwDeO4HFPAepVGoUYTwac0arLL5vkdq5
	 4mWb551VaDEtQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 srinivas.kandagatla@linaro.org, linux@treblig.org
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240601225446.183505-1-linux@treblig.org>
References: <20240601225446.183505-1-linux@treblig.org>
Subject: Re: [PATCH 0/3] Dead structs in sound/soc/codecs
Message-Id: <171762350145.565712.5432496930272405498.b4-ty@kernel.org>
Date: Wed, 05 Jun 2024 22:38:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Sat, 01 Jun 2024 23:54:43 +0100, linux@treblig.org wrote:
> Clean out a bunch of old structs in sound/soc/codecs.
> Build tested only.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> 
> Dr. David Alan Gilbert (3):
>   ASoC: codecs: lpass-rx-macro: remove unused struct
>     'rx_macro_reg_mask_val'
>   ASoC: codecs: wm0010: remove unused struct 'wm0010_spi_msg'
>   ASoC: codecs: cx2072x: remove unused struct 'cx2072x_eq_ctrl'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: codecs: lpass-rx-macro: remove unused struct 'rx_macro_reg_mask_val'
      commit: 44e55f9de9950dba091401898a931fc1a3a99146
[2/3] ASoC: codecs: wm0010: remove unused struct 'wm0010_spi_msg'
      commit: 62ccbe8cbe2a1b6911ec47bea8b1510dc1f82dd5
[3/3] ASoC: codecs: cx2072x: remove unused struct 'cx2072x_eq_ctrl'
      commit: 8080dde80a2d3657529c2172471c06cfcd9a228e

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


