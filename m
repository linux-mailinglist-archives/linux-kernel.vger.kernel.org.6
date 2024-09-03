Return-Path: <linux-kernel+bounces-313655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9093096A83C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4791C1F2402A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 20:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063621D54E4;
	Tue,  3 Sep 2024 20:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECXHZ5Qp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ADE1CF7DD;
	Tue,  3 Sep 2024 20:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725395028; cv=none; b=FM9qEpAOLmfTevAbmiELg6veQygKjx+2Em+8JJiqYZNKVxZwSY+MdAfkcgrlEWkXPT4XUYGrrFoWeE5yArPqZAcA2VMQY7sSCPt4rrlT+r5rGYTfTJlG13HBKRn1guq57i7pd0cDKVPIDAq0ZA83o62s4D1KXcRSOCLgQbuEdZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725395028; c=relaxed/simple;
	bh=e5ejiGIYofHNqSl+e+vNbBGHtaCuNwxMAhisk8aWFV4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UZ3zlIqLkkffvTZmlwWfcwSGwKtIeB6iMu6F4vJLz1hSzZGT5pV9IWwpCPxOfVtrVcU4tJ7rcKbO/ecSJxG7tNaAiUtCFjLBkHOAXOFmODxSlboAbnk/18fEmfkCulOP9zVPHyrDP2y4ZHmKOa69hYgMm1f7erl75Or+sdXbPq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECXHZ5Qp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC2FC4CEC4;
	Tue,  3 Sep 2024 20:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725395028;
	bh=e5ejiGIYofHNqSl+e+vNbBGHtaCuNwxMAhisk8aWFV4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ECXHZ5Qp6oQU/6XNXBwtHazwmmp+qFFYAE/1Q/ch0vZj+s7V2b46aDGIf+16CiICB
	 zoi3xlYW7vy49+ZxPRqy2HxTq3gi9xAAUjxg6YoM7D3l4LzNXKhmXkPvpfNuCoJh8W
	 owiCdsp8UnwKwL30EubAbPTf1mT+baSdAsAupeaNo26ebcCABognTbuZNx6ftX1grz
	 DbCTJcDbR0SQPzaIbZSSnoh5AK9o4vQc+f0XeYjUKgiNtJZVpv7lNG9DKuoAVEdfks
	 b/TM5WYEfx6NQzohK7tJ+iincv8ArGUAo9mI/jArq68npXCkElG+rZYt0pIjIWDaUR
	 /QGTVwMZwiVbg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 tangbin <tangbin@cmss.chinamobile.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240903090301.6192-1-tangbin@cmss.chinamobile.com>
References: <20240903090301.6192-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: loongson: remove unnecessary assignment in
 i2s_resume()
Message-Id: <172539502650.127486.11689781276600056584.b4-ty@kernel.org>
Date: Tue, 03 Sep 2024 21:23:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Tue, 03 Sep 2024 17:03:01 +0800, tangbin wrote:
> In this function, the assignment ret is unnecessary,
> thus remove it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: loongson: remove unnecessary assignment in i2s_resume()
      commit: a14e9323267d8f20bdb5a1cebc4abc5abd80cfb2

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


