Return-Path: <linux-kernel+bounces-215000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C13908D23
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD7A1F24EDD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DD4BA41;
	Fri, 14 Jun 2024 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1I5oR7K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E73E572;
	Fri, 14 Jun 2024 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374586; cv=none; b=hxNlyp5uxODEXsQ46Q8NYzRFZfdjB+lW0E1CbAxDq7cJyUFUHJq5AUEL+1dL5XvTQIy+AypRzeAQXjgZGcHBXI3FANujhJBgndUHDiKbE7YwmpoIHKmB78wdmhqg2g0+ihjGOWDQnjgBqDaS6POXD35XS7j03qdigsX6Eq7K89o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374586; c=relaxed/simple;
	bh=6R9ZMbkYsJZ955kACqq1l0DH62D8qVmR/4/LNTbdJ4w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gIDW6ZaD7ZkRHH0Jc1G0PjbR40E5R9RW6U32m6sr8tWzMT7t25d3w6z1F+n2VrD4uiUE0NoTUuEV2sse6o7sVGXQp3Ej4vWqimdDU/mAmCaI/EAi/oBlqF6dIx69v3/m5dtcTL01SFcpcS9Su+J+/NLDLr/YcGM314YJUrIFATw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1I5oR7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806B9C2BD10;
	Fri, 14 Jun 2024 14:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718374586;
	bh=6R9ZMbkYsJZ955kACqq1l0DH62D8qVmR/4/LNTbdJ4w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=I1I5oR7KuqxJI2jT2XNyK8JdeRpcUougiJ8XG55kXxd+BGI91ngl2V6ZiJMxY1Y+c
	 PD9/l2+PbYkbMSnowZSjbrvLr8PgAC6clPokvoeZiVdEJzA9rCYU0XQg9zOhWyLx1N
	 jPHyFL+rhY82ntteNOR0lXoTgT4DCcjhkwZuOK7hZmh/1IYX+DeSBfKFnGKoXa1cPT
	 yi6rJLij6m8CODvk+qyk/oMYBiISdDdrsnOVNwM6mq8dXl13UYeihil2UzfnUs/YML
	 3YFZiNqCcxdphdIrVw8HHsck03uANenksXCd+XhaBJ5u6Y/h/qQO3tj3iavU+WPmpR
	 OvCrlaxCwRhNA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <20240612-md-sound-soc-amd-v1-1-ad1de0409c11@quicinc.com>
References: <20240612-md-sound-soc-amd-v1-1-ad1de0409c11@quicinc.com>
Subject: Re: [PATCH] ASoC: amd: add missing MODULE_DESCRIPTION() macros
Message-Id: <171837458415.276136.6658354106882020187.b4-ty@kernel.org>
Date: Fri, 14 Jun 2024 15:16:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-0bd45

On Wed, 12 Jun 2024 20:26:26 -0700, Jeff Johnson wrote:
> With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/amd/renoir/snd-acp3x-rn.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/amd/yc/snd-soc-acp6x-mach.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/amd/acp/snd-acp-i2s.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/amd/acp/snd-acp-pdm.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/amd/acp/snd-acp-legacy-common.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/amd/acp/snd-acp-pci.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/amd/ps/snd-soc-ps-mach.o
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: add missing MODULE_DESCRIPTION() macros
      commit: fe833e4397fbdc3ae13a60202dfc7c335b032499

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


