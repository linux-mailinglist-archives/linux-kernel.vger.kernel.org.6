Return-Path: <linux-kernel+bounces-429897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE929E2855
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1869169808
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79FF1FA178;
	Tue,  3 Dec 2024 16:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sl4nkRz1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F27B1F76CF;
	Tue,  3 Dec 2024 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733245002; cv=none; b=abginoK5osj5dy/hVXKF/e9Z/ALqENQkJFMaSYhIuhRn7KicpCOe7RpVUiKmu9r4DYXkKbKOjEXLB1rqFaRCrN6o5ANGeuPNbr7S1loep1gz7SZiwnRtYrf1EqBRo1wzM7s5FIGW8NrEw6vDc1cb8fLfYsrHxAkwGwpMX5sPwSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733245002; c=relaxed/simple;
	bh=5qlOCX3NRndsJ1AfUpcbpR7q1IvZ0cncYwXCKI1Y+ds=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jUZK+PheOE/JVBiCbtHm5ldQy3j069fmyFIaagksn9f4PW7zVoEKQp323ETXu4qbW4nhQTfRJYX2UGEumUnRG79l+vyyC1tqYa5OLqtqWev3SRzPasJd3kncHZAOeojupfLYhvHol7nc8grKEMUZMG57sETj0oSHLzSQ+w4FegA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sl4nkRz1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457DCC4CED6;
	Tue,  3 Dec 2024 16:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733245000;
	bh=5qlOCX3NRndsJ1AfUpcbpR7q1IvZ0cncYwXCKI1Y+ds=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sl4nkRz1sJq33HeOKbgQcqbU1atoBz5tpEW3RG3gjdzceDRNlqhNsXnRD3o3zxVDr
	 zdoed0PqeAHejH3Nbyan5qRlf3OMvUnvdIJZhun46CRwF1cDg0XQnWfEb1amLV+p99
	 4MDLf3rQHNq0qS7A99L8xCeR0KVca7x860lN+KBOuSp5JbdqmvTJLDkthmyeg7jHr8
	 EB3QpJqMR1c9VU67c4EtFDirv1tmmFjG3p8uFS2gCaZ1iR58W7VXJKfcCUpgKOzXB+
	 q3hfaIEUuJZGa/P0qIbL8R39SgLDrk2o39FmHU/J4nHR2ukw+pJAqzLROPVPWk7R9R
	 KNIrSirfITqHA==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com, 
 venkataprasad.potturu@amd.com, Mario.Limonciello@amd.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241203081940.3390281-1-Vijendar.Mukunda@amd.com>
References: <20241203081940.3390281-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 1/2] ASoC: amd: ps: update mach params subsystem_rev
 variable
Message-Id: <173324499801.445589.12273018696416224205.b4-ty@kernel.org>
Date: Tue, 03 Dec 2024 16:56:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 03 Dec 2024 13:49:39 +0530, Vijendar Mukunda wrote:
> Update mach_params subsystem_rev with acp_rev variable for ACP6.3
> platform.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: amd: ps: update mach params subsystem_rev variable
      commit: bcbf421d2190bc4f7d3fd2cc61caf748779ee69e
[2/2] ASoC: amd: ps: add ZSC control register programming sequence
      commit: 25cd677636d316669871947639430615ff564890

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


