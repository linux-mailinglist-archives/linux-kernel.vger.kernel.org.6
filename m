Return-Path: <linux-kernel+bounces-359361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97CD998AA4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8C661C2421A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10321F131B;
	Thu, 10 Oct 2024 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tg/06Pjp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257B31CC8B4;
	Thu, 10 Oct 2024 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728571790; cv=none; b=O/neakc3GZbhaqj0+13+1Y8NDtbzLyGFNSKCm2G1cuB1zgDJhy3ZIzOC1qZAZsqJB57+6mcJrzEqX9CFJBDxeBaNdxW/qPBvYg4qKd40Ye9fVz1XQK0fg4qH/4q+ZRld7qz6gugnbtsoCn6dfZRbVD+o5yh8N2cCGNDc4iWD7Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728571790; c=relaxed/simple;
	bh=vxa/iaPnUNV3SQDhvW1TtUQ8TeFwm0dxgxALRzqpxBA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TmOp1VEhdmYsSNFLihZRxdQ5O0aBDLGqDF8b77OU5iH67e/KxxJEnvgcJYqlUgjW+iddoQ5fP27lHa+vl7pAgcdkTEJsnFo0ApRobVzWVHtGf7PtZ8Jn332qulvjrTpN1wH5D+snxbcSZDdx0sK3vPnzMGQrZmBU5hR8KxCrou4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tg/06Pjp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93103C4CECE;
	Thu, 10 Oct 2024 14:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728571789;
	bh=vxa/iaPnUNV3SQDhvW1TtUQ8TeFwm0dxgxALRzqpxBA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tg/06PjpKAL2H2K43vd/X0swxc+7RLPVNaFA1YJxeH+6s6Ssw/6fzUeXGGSqjFfX+
	 K3d6B26ajbRLc5WwtUPVSlkkSejK35FQ1SZs6N920GOgnLYagNyQAiE3D26XT5L712
	 9PkAyFsWzJlB1+JM5qeCIE7euiMccjkMydWQIAZtCHtemDKKJC/5clB5Z9nw3227L7
	 wyUhf1OR1BJkR3bj8/HLGmSuT2rLBXDbTJoI8ndhVWF0jXYfX1xpSpEe2AUctGYGGM
	 xnaw+JLCbHGMRT9X0HNEUBWF21OqKHoOXKWcXzSYbl6UYWkrZQtDm/u6NUCIbVkIxu
	 aAYnF5ihGBDzg==
From: Mark Brown <broonie@kernel.org>
To: oder_chiou@realtek.com, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, "Everest K.C." <everestkc@everestkc.com.np>
Cc: skhan@linuxfoundation.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20241008234422.5274-1-everestkc@everestkc.com.np>
References: <20241008234422.5274-1-everestkc@everestkc.com.np>
Subject: Re: [PATCH-next V2] ASoC: rt721-sdca: Clean logically deadcode in
 rt721-sdca.c
Message-Id: <172857178724.3727572.2360367979029234231.b4-ty@kernel.org>
Date: Thu, 10 Oct 2024 15:49:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Tue, 08 Oct 2024 17:44:20 -0600, Everest K.C. wrote:
> As the same condition was checked in inner and outer if
> statements. The code never reaches the inner else statement.
> 
> This issue was reported by Coverity Scan with CID = 1600271.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt721-sdca: Clean logically deadcode in rt721-sdca.c
      commit: 8658c4eb9d6b76311322c1b74b3d4e0dec3599d8

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


