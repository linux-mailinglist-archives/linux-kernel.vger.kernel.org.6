Return-Path: <linux-kernel+bounces-328543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7BD978580
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946FE1F24392
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370B975804;
	Fri, 13 Sep 2024 16:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tq9tG5HP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A21174070
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726243916; cv=none; b=m9fU/eQa76+5PfJIi6CWGTzJbvIATyQUvPJXYjGCI5gq9et0mO1BA+UtvJxJjFqMj7Klj2Bm5JXN418wt/Bbx+nRXOCtub72Z7KenZzmaTErfBLsWxBkEndf7AdjVoEFkPFXuUSg2c8aC4Rt6l1T9U1nr8N478eKl9Msp9GWKqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726243916; c=relaxed/simple;
	bh=jdzxRMKd10hz0CycLMLXK8JpPArhP0NbkFeexl+6qUQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AkBkCBBQ6NIfUgcu/5rW+YY5us+B5C/T2E/Edu2vDhufOIfP7tSluQz+wZ1Ye2pBWk3aVbiAF9750pIu4W0qx2hcuO3tBYVXI9zYImyguUomHOaMZVczacT5A9uO0y9FuSfhURdziP79XA87gOb3EKutKQ42d/8Cdl4jABbDMO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tq9tG5HP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF506C4CEC5;
	Fri, 13 Sep 2024 16:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726243916;
	bh=jdzxRMKd10hz0CycLMLXK8JpPArhP0NbkFeexl+6qUQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Tq9tG5HPoD4FMiTGhwiRgWdiqHJhFr1TzGcKQxuVTnECCnxdkeEHTVk5yqPe1GUvY
	 FD8MjZmeBDwPuYP4l12NwyBd9HPWO78n3tn/pVF2tk3qdd91uLCBwmuNBE7/4rDrdB
	 874Fo5WFHF70886PXH9rqJ6EkkEvGc+XF4YhojdouO31IplQABkuJCutd7kLDu94oI
	 iOGUAYuQMK2sV+c4mdRcXNf9EsO8cvSFpRkFoh5YQWpPsxkaeAzxDABK/p9RaDIPsH
	 dG/JJRGPy94SpNGxDnro4tkmE+QXCwenMchIi8gXje86J+eXsfe3BipJ/knXoUEv+m
	 ozAxbmBOZJBkw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20240913-regulator-typos-v1-1-92781c93f638@linaro.org>
References: <20240913-regulator-typos-v1-1-92781c93f638@linaro.org>
Subject: Re: [PATCH] regulator: update some comments ([gs]et_voltage_vsel
 vs [gs]et_voltage_sel)
Message-Id: <172624391451.49323.15305955333400059916.b4-ty@kernel.org>
Date: Fri, 13 Sep 2024 17:11:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-99b12

On Fri, 13 Sep 2024 12:43:58 +0100, André Draszik wrote:
> Some comments here are referring to a non-existent
> regulator_ops::get_voltage_vsel() where ::get_voltage_sel() is meant,
> and similar for ::set_voltage_vsel() / ::set_voltage_sel().
> 
> Update the comments.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: update some comments ([gs]et_voltage_vsel vs [gs]et_voltage_sel)
      commit: fb9ce84a01582c9d67dc51d5330136ea684172ef

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


