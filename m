Return-Path: <linux-kernel+bounces-236550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8952891E3DE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C1391C215F4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CE116D9A5;
	Mon,  1 Jul 2024 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/bhFd5x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0D816C871;
	Mon,  1 Jul 2024 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846888; cv=none; b=Mv4bJnl/Kd8ELeRlatYjDVnkmLYmCx/KqUahID/WNvM9RA9ryPYpQQuibwYW6MUXJ6UhJat1UhMBXbquDR/mzh8yjwgFB8IjmSLdny1RzDs5i7R5z4IHewH8AKFAa4s2brY9Lpq044AToiglhYitOrctk6zRRa+cgtO4Vv+BRvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846888; c=relaxed/simple;
	bh=D+dqZWEYQrj6N5dhh+KIXd+1VWrn8ph2xtTWAgXfdLc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Fs9BihUyKOhocVRTkeRJ717TS6QAOmGaVcMSXhT3l+y2HOSLQa3N3TuFSW8wTAt1+MRYCeb01xfiolvPVB52Pbp7VYlTBYCACksyS8u7qiLaBgj80KWEhmbR2oUKRlXVfT5vJvzPKTLVZQFGfxyjf33PSf0agS3s8MDHgORvtgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/bhFd5x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F46C32781;
	Mon,  1 Jul 2024 15:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719846887;
	bh=D+dqZWEYQrj6N5dhh+KIXd+1VWrn8ph2xtTWAgXfdLc=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=M/bhFd5xZ5iddEfYtFWXKCJHnYnW7vRiv1kIhHLhM8S2P1F2ALEZp3TK71Zx8eQsr
	 WCWLE2IT1rjREDCaT/b1TNMTMU5nJP7yzvcHVFnitjXVdvBvPKx75yA4Kfh0veEoeO
	 tX9Vru9TZU0n8lw36uI5wtCXLn7qC2oVRffPCDFEOJrGW91egpXUT6eIMSMYxQwIei
	 F4haOj2bPDs3FkW5pe1VsNA3jI/DkUqVATz+lGOVcLURgR2yO91W4jUMLfhyRvWV7k
	 Ge2SlJvy4AHT0ABeM1fN6PKVC91IOkaPfSj9EsM/bO4BE6myEHI0joz2G/K5WpaA3b
	 NNOZz8SlYEh1g==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 devicetree@vger.kernel.org, Chancel Liu <chancel.liu@nxp.com>
In-Reply-To: <20240626071202.7149-1-chancel.liu@nxp.com>
References: <20240626071202.7149-1-chancel.liu@nxp.com>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: fsl_rpmsg: Add compatible
 string for i.MX95
Message-Id: <171984688438.72817.17478121699254917987.b4-ty@kernel.org>
Date: Mon, 01 Jul 2024 16:14:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Wed, 26 Jun 2024 16:12:01 +0900, Chancel Liu wrote:
> Add compatible string for i.MX95 platform which supports audio
> function through rpmsg channel between Cortex-A and Cortex-M core.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: fsl_rpmsg: Add compatible string for i.MX95
      commit: 8e5c11963c5ca4af90b36147cabb4835e59990aa
[2/2] ASoC: fsl_rpmsg: Add support for i.MX95 platform
      commit: 19dec6650e3fd02de8752c4e0ab1c4894ce7fcb7

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


