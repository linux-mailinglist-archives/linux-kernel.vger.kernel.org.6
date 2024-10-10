Return-Path: <linux-kernel+bounces-359527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E01998CAC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C281C20A19
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F871CEAAE;
	Thu, 10 Oct 2024 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dw6XpKsV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746476FE16
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576174; cv=none; b=PsyTZsK4Zh6BcONzJVwrjmU6MxehQdFhMKhRFbIj6rTb6ftFNt65V8rui5wdIzn0ABo8ZRBGjJTBGcXvTsZGOKLmI6uh4iF+W6ZwFaK9YuqS/mg9Egyg+9RG7YXvPObxteUrmsP1F1++RQ8Yc+9u9QTnkdFl5HPBY6Y5zutOQm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576174; c=relaxed/simple;
	bh=pG+lcfIjfYuCA2JDXFlcBo6avhFuLK4Eua+03Gs1E40=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MnKkhG674LIunw59fhWF7Ow9ppiY5UpeI+JnRUZTwVyHa4xDK2XXuIY2BU0kAFrSSNhXzHurlP+NwlOZYaBuaQE4biDD8gbzmTjTf0bglwgH3x0r7CRHbu0ABzoG2H+0+CpjUw4uAtr2MR1gpARwACSlCEE3DFc0FjZH08Vu1pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dw6XpKsV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F2DC4CEC5;
	Thu, 10 Oct 2024 16:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728576174;
	bh=pG+lcfIjfYuCA2JDXFlcBo6avhFuLK4Eua+03Gs1E40=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Dw6XpKsVtgbBH7uheRKCCbJk4Vz5GEIFJMLDn6as2atK79Epi5WjowPEp+NfAhQo6
	 8k5J8SQzW6qZKoi04VF85bOt4GlLOBfbZUKTW40HcSRiT43gpjGLPh2OkMc0+MYdhm
	 gR+l5e+FVSOdseOMndqDYgOaiAjxqVz0oAY+q/St1mQj9MPIvP778mOIMVHmfNXce0
	 3QB9w/G4kF3h6KmautHn6nUxPH6ddo710P6Csn8enAglGnBosI5LGFwm/O3zyh70zk
	 vFiJXqfkJoAc+ANxinM2MNFs0bC0YcJFjuS2xPTIpP77rtkSvD1eFQM2FpMs1PT3t1
	 MDJufe1oeaYfw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20241002125500.78278-1-patrick.rudolph@9elements.com>
References: <20241002125500.78278-1-patrick.rudolph@9elements.com>
Subject: Re: [PATCH] regulator: max5970: Drop unused structs
Message-Id: <172857617143.3841243.16253760264635368127.b4-ty@kernel.org>
Date: Thu, 10 Oct 2024 17:02:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Wed, 02 Oct 2024 14:54:58 +0200, Patrick Rudolph wrote:
> After splitting the max5970 into a MFD device clean the remaining
> code and drop unused structs.
> 
> The struct max5970_data and enum max5970_chip_type aren't used.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: max5970: Drop unused structs
      commit: fceffbfe57af7d9941d08e1a995cccf558d08451

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


