Return-Path: <linux-kernel+bounces-344866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A59298AF10
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A2E2820EC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAB51AED2F;
	Mon, 30 Sep 2024 21:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmgzTmzo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945931AD5D9;
	Mon, 30 Sep 2024 21:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727731606; cv=none; b=ohf2d4PqxDc0+gKxyGxBS/8RBU1eRgMJDqySKSJsVE++cUlp8GGmgiON/hmVjmxiO0R0zcl9itfboaD/iy9PFzs7npiOnny4rhgxn73t7H/izc3ONkD8FYMFii3tK6+UEeRpOFdcLVmzn38I2Q3JhSoJrWGTXe2+wyawQOQopdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727731606; c=relaxed/simple;
	bh=Mhh2JhtIRUpRVo7VhczWzI/IIMAHmtYptJ/xY/asBZk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rY0UKAekgFuCGdmrcFzve5lnQtzB1csn4sPTUCkUDcvM4SkcV+uSwHFlvpvTEBa43F32saupZE5UNXkFP0jFYnGDJo9LGizrSs01wRNUXSr9SCbLbeEjtAmrqvZTFBpDKDcGSFgU/xHngcRfCeUESfnHePDVSx8/AWZ0a6XLtUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmgzTmzo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF26C4CECD;
	Mon, 30 Sep 2024 21:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727731606;
	bh=Mhh2JhtIRUpRVo7VhczWzI/IIMAHmtYptJ/xY/asBZk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DmgzTmzoi8dmT2F5a/fBxSp+WhJ96umXRxP1rwXUqUVnEFun8sKqY1FDpy2iB2BFz
	 KWZHS5bikiSafZkW91LC25fzGokL7dSSHji4Mpje1Jh+SOZWMf0e52bED2o2Iw6MSD
	 YOhrUJLhuyi7JAhPXgPiupooszZ/RXZ+8U05VxQaczz6xkT6hIrOr6wgqDC7vP5jMi
	 frdVUe6mhkxWvGwisGx8Dgh7emidtO94RM+1m0zNu4X3VmWcIqaXL0q6dsXrMtFlx3
	 Ve3JD7GUbhYblYxrNQGP4a4eP06rzMEWj//OuDF+qVD3IAHpwAlGWUwDfe/KGOJcJn
	 VK8YGkfr/1DCg==
From: Mark Brown <broonie@kernel.org>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, 
 peter.ujfalusi@linux.intel.com, ranjani.sridharan@linux.intel.com
In-Reply-To: <20240926090252.106040-1-daniel.baluta@nxp.com>
References: <20240926090252.106040-1-daniel.baluta@nxp.com>
Subject: Re: [PATCH] ASoC: SOF: ipc3: Use standard dev_dbg API
Message-Id: <172773160470.2197048.10941311432201519926.b4-ty@kernel.org>
Date: Mon, 30 Sep 2024 22:26:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Thu, 26 Sep 2024 12:02:52 +0300, Daniel Baluta wrote:
> Use standard dev_dbg API because it gives better debugging
> information and allows dynamic control of prints.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc3: Use standard dev_dbg API
      commit: 55c39835ee0ef94593a78f6ea808138d476f3b81

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


