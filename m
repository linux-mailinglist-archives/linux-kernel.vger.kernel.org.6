Return-Path: <linux-kernel+bounces-317688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AE396E22F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B71286678
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D9E18786A;
	Thu,  5 Sep 2024 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPHiGNUV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EBE187870;
	Thu,  5 Sep 2024 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725561752; cv=none; b=oJQ6zhE/3jDn3b8v6zFDgTZiig1J8XyM8e5jphFhKau713xDjc3gJQMRiSv88P9NFYjJ2m9nVjJ8iS7AJVWvxL7ACuW250UkpkvdMn6tWE6T+IM3VHD6KiI+MxgokUHy/DzQjUtD+5WloCPMpv6sdVJtQqwy19Ay5u3deklBojM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725561752; c=relaxed/simple;
	bh=rhLETavs68nGr7DS1KdS0ob2HrU49NpqTqneiCZMjeY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FKdUkR/Dwmf7Xv0oQg2XPHObh4fHwTUt/MSzUb4PyNWBrr+AnvMgaWQUcfVQTyF3W1jSY/ZVlGsPzx759ygkGsWo4S3dI3AdWsl0QxYX/Ru6zDiCiBz/0qt1QkU94VeuAk5lRDQSSopN8yaByv2/3lgp7QjORoemWhi1wOZjA2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPHiGNUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B29C4CEC6;
	Thu,  5 Sep 2024 18:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725561750;
	bh=rhLETavs68nGr7DS1KdS0ob2HrU49NpqTqneiCZMjeY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CPHiGNUVos7zRIzXMZegnHHn8Zqg5wxbD4ahHAyvJi3GZV/1cjWYe/5lF7orR4hE6
	 9hiTPcdq3Nd6nHAtEqvam8TKEnwfORxqhmPp9cVsKUC/TAc/jgvxFO67uO+LFd0r6N
	 o+5NTbmNslEqiaj84SQ+2SMgGDbXNaNZoIEixgkv1YX+kic8JRDKLwmm5NELcQzBBx
	 1Ud9kwEIZufEtiTuIyfEcXUihnhGiVYiRC2aytuORl9flnV7ap9h0rMb5diCcEoVj6
	 60Bt0fK6FPPruH2bUnUlJlwQdyNy4NTuB9onIL4mJ5+DoGRxROBEXmEIytg5i4cssQ
	 ucagn5YQK+JiQ==
From: Mark Brown <broonie@kernel.org>
To: cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com, 
 liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com, 
 yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com, 
 kai.vehmanen@linux.intel.com, perex@perex.cz, tiwai@suse.com, 
 brent.lu@intel.com, kuninori.morimoto.gx@renesas.com, 
 Chen Ni <nichen@iscas.ac.cn>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240905022017.1642550-1-nichen@iscas.ac.cn>
References: <20240905022017.1642550-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: Intel: skl_hda_dsp_generic: convert comma to
 semicolon
Message-Id: <172556174721.65454.13363391345780291618.b4-ty@kernel.org>
Date: Thu, 05 Sep 2024 19:42:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Thu, 05 Sep 2024 10:20:17 +0800, Chen Ni wrote:
> Replace comma between expressions with semicolons.
> 
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
> 
> Found by inspection.
> No functional change intended.
> Compile tested only.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: skl_hda_dsp_generic: convert comma to semicolon
      commit: 813751eaec93bfeb6236aaed99607a44c01b3110

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


