Return-Path: <linux-kernel+bounces-208933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0F0902AC2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC24C284EC1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A66142E62;
	Mon, 10 Jun 2024 21:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSGYEQp3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215A25588B;
	Mon, 10 Jun 2024 21:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718055879; cv=none; b=r0n8BnmMaDHNyksQnvQA/Yz00P36fuw0MouT80p7g7HgmwN44BdqKIx19OEzRxZpYSKNKbfJ/cC48EgYMBkDmh6F508xEQTZs1nm9QAU8CPXpVrLmN21VmrAg6ZiwiwfxDFGxsiH7jRTfSqy8+ZanG8NaYi2W4CSjtUd9bKns0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718055879; c=relaxed/simple;
	bh=3BXOX0ljI6tNSqx92AFSk3H/yMBw5v/Qa/zHQ9YUkFA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AhJLt/1qwWB1/VG7xLbHOzBwpwrIZRC0+i+kmtman7av8uOGmo2eisoJPJ7+TTAcdpX1hl4NjseHPDxq0fg6zTs6cACNjaCTVDvslHf/Hhx6H8a/EEcZLbJWFGTrVBkZr0CFWhzpYsm2P/zZ7wIWfCqMocxNjzrUH/cmpf9JrsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSGYEQp3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D158C2BBFC;
	Mon, 10 Jun 2024 21:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718055878;
	bh=3BXOX0ljI6tNSqx92AFSk3H/yMBw5v/Qa/zHQ9YUkFA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XSGYEQp3r1jJLpJfLHQslf+NUVz5XxFW2PajcFIwslRtHEVMsMIYpRqu9ClqPyQs8
	 eR8nvxO8kcguTXrJi/j5zpLMZNDc9rgdykVlZAiYBqNhXLDGMej/um58msjlbkwh6U
	 gJIjQQZKhyu3Ozrr9pwdIeeYyrzfIyTnS/fjtQpURlwKGtjQZnCCQkzGOrjWn/sUQc
	 ROfBZCR5kD7f7sGjNPQr+N63mmpHFv6MtcZfXqqLoB2QkEsSglsSy5ob+xVMhjKSCO
	 Frexzip9MxpdEOvNXS+zf1SdXNpwMD30BWolc2THJL5ioiblGEhr6+hYM/dNkECnBm
	 a/N0tvxh9TrRQ==
From: Mark Brown <broonie@kernel.org>
To: Support Opensource <support.opensource@diasemi.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20240608-md-drivers-regulator-v1-1-da338665db7a@quicinc.com>
References: <20240608-md-drivers-regulator-v1-1-da338665db7a@quicinc.com>
Subject: Re: [PATCH] regulator: add missing MODULE_DESCRIPTION() macro
Message-Id: <171805587223.166318.11260864139732628777.b4-ty@kernel.org>
Date: Mon, 10 Jun 2024 22:44:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-4c370

On Sat, 08 Jun 2024 21:53:29 -0700, Jeff Johnson wrote:
> On x86, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/da9121-regulator.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/max20411-regulator.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/rt4831-regulator.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/tps6286x-regulator.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro to all files
> which have a MODULE_LICENSE(). This includes mtk-dvfsrc-regulator.c, which
> did not produce a warning with the x86 allmodconfig, since it may cause
> this warning with other configurations.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: add missing MODULE_DESCRIPTION() macro
      commit: 8a2744f2955a584188a82d631937aa365d4ea966

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


