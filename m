Return-Path: <linux-kernel+bounces-269315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E16A943167
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB667B2545D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D13C1B3746;
	Wed, 31 Jul 2024 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhXMBpD2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0531A7F7F;
	Wed, 31 Jul 2024 13:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722434013; cv=none; b=SYmwZRWV4hhKlVmG7mAzia8f1hhbGsepZLLGtLzkMeMNsbTaGNHao4k7PkXEDM26FfJZ0hTxLhRaDczVNP2M6u8BDpohlVNMxq8cr2uZf/ofvuQvVlDhuays1a2ziVPWfkbhzrZ5nWFPq4ggAJBUHcwnF36i+Vv/9uom0t8Zc3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722434013; c=relaxed/simple;
	bh=2MGuZRFEEO1kB1smAVjl0s8IfGp3OX6tTyo+GBf16NU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Cq7Pt9ol9ODQaWHHo6O4Oibtf2daFaBiAby0N8kWFc0TQO1VpKef/GHtfXrxANslcscYHD16zU11mzeRT/OK5f8WQGZrW7FYuhQ7ln+nBh90g4/ZSMy3J7gLWlKu7ODrEJv1ZOjQTx3zdj7ypP86XqjiEjZuSF0X6V+jNgfBL8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhXMBpD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AB9C116B1;
	Wed, 31 Jul 2024 13:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722434011;
	bh=2MGuZRFEEO1kB1smAVjl0s8IfGp3OX6tTyo+GBf16NU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZhXMBpD24kmFimLqzac/C2Qh7SIf/ozyB+RInbe8ZcyLRzxirnJ4bLlmC3wTFwceu
	 IlBFqIZmrai4jH5OxOMzoaIW9yMYUghWzG8iEid3B4opPuvztrl8plAEgUcExNuGsd
	 WyssPCFaTyCsGc+u0yyh06zj8X3E84/WmmxdoK6DlISSH1lzrY6azg2GieWCO0K547
	 ibsxXvsJB5tktzUjMoGSJX7fKBPhvYwZrw5BoMbPIWXNB3EiA9ClqjZ1k6NtH1O7Xu
	 KNWl/3bJtqyB5Jcr4zDvE7mDTHiBa4WnO1IGeU/jDVGCz3OWMoQOeAklxHWfGpV/01
	 nYzQGPhPQoyqw==
From: Mark Brown <broonie@kernel.org>
To: jonathan.downing@nautel.com, piotr.wojtaszczyk@timesys.com, 
 vz@mleia.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 Yue Haibing <yuehaibing@huawei.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240731022949.135016-1-yuehaibing@huawei.com>
References: <20240731022949.135016-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] ASoC: fsl: lpc3xxx-i2s: Remove set but not used
 variable 'savedbitclkrate'
Message-Id: <172243400901.75630.3817479503151078602.b4-ty@kernel.org>
Date: Wed, 31 Jul 2024 14:53:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-37811

On Wed, 31 Jul 2024 10:29:49 +0800, Yue Haibing wrote:
> The variable savedbitclkrate is assigned and never used, so can be removed.
> 
> sound/soc/fsl/lpc3xxx-i2s.c:42:13: warning: variable ‘savedbitclkrate’ set but not used [-Wunused-but-set-variable]
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: lpc3xxx-i2s: Remove set but not used variable 'savedbitclkrate'
      commit: d5742b5d4d7b99531e352ea814506641f9fc8981

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


