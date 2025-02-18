Return-Path: <linux-kernel+bounces-520516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED903A3AAE5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AECAE7A391D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490971D7E5F;
	Tue, 18 Feb 2025 21:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aY8BBoxF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5081D6DBC;
	Tue, 18 Feb 2025 21:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739914223; cv=none; b=FTwyMModYY7L1jnXoVD+xJEOU9PeEw8MvcurPrp+dPSFQWC9HYKx3NCoKkAQEuy5DIkgLM4wiPLsCp6d8vdPw8g7T5sXRyeHW5vduoLJzE21eIf0RW7zi6Qay7o+N5YonQ5tZ71c+41pbsdXk9EzvS80mDKYgqz/yc0LnrbfZ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739914223; c=relaxed/simple;
	bh=lGPPM6C6CRkwda2Xb7fQg2RPI4I2QryenHs0aVrHk8c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gB4BawVGGQl5sYJdQVsjF491IHuFLEPSWKy9aM6lTx65SCgosmWD2jE6swi6bEZGhqaHnOHXx0xEqdoi5j3crm/VFiRdwPEXfj5WMMqXM2nSVwWrMHXKyhkkFfA1kOnXhYhbY1R/+OAJxE9c7Tc7GbbKUUl1XnnaR97iZHVIonA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aY8BBoxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6F2C4CEE8;
	Tue, 18 Feb 2025 21:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739914222;
	bh=lGPPM6C6CRkwda2Xb7fQg2RPI4I2QryenHs0aVrHk8c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aY8BBoxFJY5XB2Hismdx3QK4JXY+0Y62ulymjjlojuEzn9pnI7BCWzcJ5Q47zMUvS
	 6DI/LVF/WbwEuKP4f8s3FdqjAhdUwDWMXsc3+g/unXXgBTzwwo8qr3MNN0JZ1FjTfA
	 5z9q00h1CdztuJJIDxpHzfOolVj8xrg1jK7v1ZjgCJLz5kCKOCxMWdk1W4zskMMUIa
	 Dq1mjL78GRJ/q0Mnbz9NS+8V1EmvlU8ufGHZzTUP/jGF66aPQIIbVzZRcmehzY3Rxl
	 +AnJzFT+SB96OamKntguwx+kBypEn1e0UPxytVAJxfauJCABk90/3m5t2TiNsPybgE
	 otChFDbI3Nh8w==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com, 
 venkataprasad.potturu@amd.com, Mario.Limonciello@amd.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
In-Reply-To: <20250218051000.254265-1-Vijendar.Mukunda@amd.com>
References: <20250218051000.254265-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: ps: fix inconsistent indenting warning in
 check_and_handle_sdw_dma_irq()
Message-Id: <173991421905.1713371.4910441830117855699.b4-ty@kernel.org>
Date: Tue, 18 Feb 2025 21:30:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-42535

On Tue, 18 Feb 2025 10:40:00 +0530, Vijendar Mukunda wrote:
> Fix below inconsistent indenting smatch warning.
> smatch warnings:
> sound/soc/amd/ps/pci-ps.c:68 check_and_handle_sdw_dma_irq() warn: inconsistent indenting
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: ps: fix inconsistent indenting warning in check_and_handle_sdw_dma_irq()
      commit: 5d9fca12f54d3e25e02521aa8f3ec5d53759b334

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


