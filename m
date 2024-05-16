Return-Path: <linux-kernel+bounces-181283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64AB8C79E9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC19280CBD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7930014D6E0;
	Thu, 16 May 2024 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="he4pjcID"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB9914D431
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715875089; cv=none; b=beJJQP33XydhXfjjFLa99GM6n1WNcGAhe2ySjmDn00PXza2ehU54IswgHlqWbwQEjWLehLOPHtqOxf7fERNuXXxf7Vs3c+x+PVd/yVwufTOs15J/wXR5Yq4KNOLO2J0GqYnGeUteaNuGBsKvVNHORjVx457hWGQdEFtNcGdT0CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715875089; c=relaxed/simple;
	bh=OAUCW4BIhk2b3lKjcBQqRchiUKDpImkI0iZhfVpediE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kLPNgJZ8QMtf7vMRVhagE277dYgfFaM2NAg/Dudp4vyZ6Gf8KVmjZlY9FDH3wMDmow+ha23BAXdIxz3XUSsSEnAYmBBoGM6sDdkYWX6tiW8loFE1S1coeETbpB0t82gdIhG8MyA+7ZJ8+L6AhcthcSYw6X0epr753XIG2vfCbeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=he4pjcID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7395C113CC;
	Thu, 16 May 2024 15:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715875089;
	bh=OAUCW4BIhk2b3lKjcBQqRchiUKDpImkI0iZhfVpediE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=he4pjcIDJc6fILhgt/4hdd0cVV/s2UO4ivIGZIPP9eLILvW6kZ4H9zj1VgXc/6fDJ
	 mkTI2wDc9nWo+4lzAPJK+hwVNgFlW+hDMk9/ZmQENQ6byV0giqK5vLIdgJO8Jjphqp
	 9md6cq39hHDEeTdsnY/nFeD7a9Dxwe2ZlSI7DGcFN8Wy07P9Vkie6C7FGTL5a5/M7x
	 fyJOvtyQk98tqrlL8bz+UPeMYZtHjoz0oAfzLmN4Du08ggCNqLND6JECvRK/xskHWp
	 bIGNBE6WQNMMRztI/0my+m3tbIqZt3+VVn590CAdLNw11LmjxbvmHRKiBca1t4awpH
	 Uh8JBsuWUnBew==
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1715848512.git.mazziesaccount@gmail.com>
References: <cover.1715848512.git.mazziesaccount@gmail.com>
Subject: Re: [PATCH 0/3] regulator: misc fixes
Message-Id: <171587508866.156897.11252945159976734613.b4-ty@kernel.org>
Date: Thu, 16 May 2024 16:58:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-f3d47

On Thu, 16 May 2024 11:52:44 +0300, Matti Vaittinen wrote:
> This series adds couple of a bit unrelated fixes/improvements which I
> implemented while working to support yet another ROHM PMIC.
> 
> Patch1 addresses a potential problem where the voltage selector for
> pickable-ranges is used in same fashion as a 'apply-bit'. Eg, when a
> regulator voltage is changed so that also the range changes, the effect
> of the range and voltage selector change is not taken into account until
> the voltage selector is written to hardware. In such case caching the
> voltage-selector value will cause the voltage range change to not change
> the actual output voltage.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: don't cache vsel to ensure voltage setting
      (no commit info)
[2/3] regulator: bd71828: Don't overwrite runtime voltages
      commit: 0f9f7c63c415e287cd57b5c98be61eb320dedcfc
[3/3] regulator: rohm-regulator: warn if unsupported voltage is set
      commit: cb3a0f84ae0caa5eabf40457485473edc1e2d3f0

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


