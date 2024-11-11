Return-Path: <linux-kernel+bounces-404201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB069C40C5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5461C217E0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3276319F46D;
	Mon, 11 Nov 2024 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AidX6Z/d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4B215A85A;
	Mon, 11 Nov 2024 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334896; cv=none; b=vDJFpCYe5xhVXpDRUNbTTXbocCQLhyn+Kijp2G0zSD+2IRo8CXHUA9aW+gH7zXP6YPT9pyffvC6aXK27IT1loBGFCvof7U2NDamyPEgIVrJnUBBe9rC5ol7GcNNEKIreiWPykFy/WwMJVP+kuBygOYYlLU2da01v/l3PdWdIT5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334896; c=relaxed/simple;
	bh=JDEiWcMieXWkcjS3hsM/fTAS0W5+cZvq5ni6QT7/Kmk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t8kooMAgCIP2AMBh5Jbctkf6ItzhDAFMsyX1l9zp/SuR/T3/+wAJbv+oKspDoCfGn6WqIR/gggz6XJlkrbzPLhSWhAgG8N7Ixj7Ly/w0xeqje5jJXy487/IjdZhgUIZGGNaE3WbiCIeA7B9MDv2pGPiijsG9RQC2lEfxMva8LPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AidX6Z/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397C6C4CECF;
	Mon, 11 Nov 2024 14:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731334895;
	bh=JDEiWcMieXWkcjS3hsM/fTAS0W5+cZvq5ni6QT7/Kmk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AidX6Z/dwj/8lfcJqiaZgFC2ERpSYdOvI4+o6Jkee+f0pjUdYqNk4razBahAC4+iT
	 vT1RzKOd4eYkKMAqYrtX9l03Bw4WDBAMNNdlJDwMDsx3ORG2bbAG3EMbb54vCYv5Ly
	 g+USBeK03NUIcgxXm4dXHT+7CG4fXyipWeqzuSj34S2SIIei0bEjXOButRmyuqIIoV
	 ptUXWCg7rfS4zAo/G/bTAq9c3N9cCFSL7iwDSSlCgS3LUlQUFXwbarYZmUc9Bzp8yA
	 F7HciGdFPkN+udeSpOTOREOJyn6A3lxe1LNRCCWvzWvSo8/dbpVGIh4jhLmsusyHv2
	 7iVm/hGpEHsuw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, corbet@lwn.net, 
 anish kumar <yesanishhere@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-sound@vger.kernel.org
In-Reply-To: <20241109192231.11623-1-yesanishhere@gmail.com>
References: <20241109192231.11623-1-yesanishhere@gmail.com>
Subject: Re: [PATCH V3] ALSA: machine: update documentation
Message-Id: <173133489297.303054.7610092091879051755.b4-ty@kernel.org>
Date: Mon, 11 Nov 2024 14:21:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-355e8

On Sat, 09 Nov 2024 11:22:31 -0800, anish kumar wrote:
> 1. Added clocking details.
> 2. Updated ways to register the dai's
> 3. Bit more detail about card registration details.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ALSA: machine: update documentation
      commit: e90dbd3839f554bef35786c4bec8276455691b20

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


