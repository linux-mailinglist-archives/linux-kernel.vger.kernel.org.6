Return-Path: <linux-kernel+bounces-322135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B084972493
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 23:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7031F249F1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 21:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28B618C915;
	Mon,  9 Sep 2024 21:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHsX7qdU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACC918951A;
	Mon,  9 Sep 2024 21:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725917730; cv=none; b=fwiEn5/YDcz/lXN2bz7jnoEulTGMrUvF7F9ttPrpWFRXvZMmPRPtSK8B8YKELtHo/zg4JpdR9y4txaoVsCF0BPl07xVM6LHuIbX6rhibkof8lda0hS3+VJ4Xsd+Kn9IKcNc43hzq9FT7RwfaRenyeG89lZl1jzKOQGkqh67Posw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725917730; c=relaxed/simple;
	bh=67Wl61W7prEC4aHcO2AHbGlPF3SeL1G0pJmsaKDtL0M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mC1++pSKzDVd9Ymah+isbTmddCV9JcqWaTPMRY2XOy2s1eMM8k5+0BugM+UmwXpZ5cRrh35VunWbwt1aHqVo8tPd6Jf0tjYBhAQ2X/LuV1IcjWKcXNkw9aPTUIRDYNnkhyTJkDneEZ/9XfPJu7P9azEgfQxFOds6KmfUw1OlQ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHsX7qdU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C578FC4CECA;
	Mon,  9 Sep 2024 21:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725917729;
	bh=67Wl61W7prEC4aHcO2AHbGlPF3SeL1G0pJmsaKDtL0M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HHsX7qdU7WZr4d7tIlu2RiSH1yogzdQIVgtOMDRTTZRuMGzVzgtGq54LdPBv6Ukl0
	 KFCEn27xygPbzOtMsTn/HwVdALTEsQXU5wZGDo+hmP8rQhxH6wg+MoIL26jtX2bnTr
	 sPB2D5NKVN5ZZqIOc8e18nciMYT4Dh3RvAx1NVDfDjafzjRuH6bfUyHctd4MXByxO+
	 t8rrRvKjUxCbJdxlVAZecZzDvE4JCvcSp1eifnaOd/EqQ1MHKYi3lpWWrFCoih9Wtc
	 RkMNv0QTpfidkZilj+y8sp51jGbUoUfpAe+OgquLKQclN6khVkM0ormNI14p9JduDY
	 /2f2D/mffS5zw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <fde33ecfd9bbdbdc1da1620c9f3b1b7a72f9d805.1725906876.git.christophe.jaillet@wanadoo.fr>
References: <fde33ecfd9bbdbdc1da1620c9f3b1b7a72f9d805.1725906876.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] regulator: wm8400: Constify struct regulator_desc
Message-Id: <172591772852.144124.10966520564484131490.b4-ty@kernel.org>
Date: Mon, 09 Sep 2024 22:35:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Mon, 09 Sep 2024 20:35:08 +0200, Christophe JAILLET wrote:
> 'struct regulator_desc' is not modified in this driver.
> 
> Constifying this structure moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>    4419	   2512	      0	   6931	   1b13	drivers/regulator/wm8400-regulator.o
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: wm8400: Constify struct regulator_desc
      commit: 48cc042bd68e0225f1e6b137452e3d867e7c0942

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


