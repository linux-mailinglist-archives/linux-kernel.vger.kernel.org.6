Return-Path: <linux-kernel+bounces-266039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B8D93F9B2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF681C21894
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095DB15ECC0;
	Mon, 29 Jul 2024 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBBC86/Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5250015D5C4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267596; cv=none; b=n7X+s0To3484Vwb2NA3JFk/218P1LKL1oRg5VhtYAgXvPUt8WZGCgAIzFvEKVUQ87jS5TPtiDR8zH1RIxoVM6qeQiiRCp54Sv1k9KfqY7hwdzzuEp2Ys5G6kGnODHFCN8J2ckrcVhy6/BBgD7Wj/ehR+LDls5BGFTSRaiZURmsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267596; c=relaxed/simple;
	bh=sl3atLRkJUZ4C3sosC+tWoarzejvC/dcNj+92zTiJhw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pCRHYjxSmIE99GHuYuY9Z/rb9AOQa9Rq/OZN3MDRiZmjq+Ovw3ZPxvmw6zPVRUzVIe4jQQxe9a8YUnd6MNepP1K7F1SFxZ4CYEKJJWIVDbKiLM4YcZAchy0sPIUZZ4Rvb0r+2OvKwjB3dqMQWl9WIgJf/hJXEf99NjfICs80YRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBBC86/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EECC4AF09;
	Mon, 29 Jul 2024 15:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722267595;
	bh=sl3atLRkJUZ4C3sosC+tWoarzejvC/dcNj+92zTiJhw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BBBC86/Qd4QFFTZ8wpCxnPdiM9bxKdGtRq8tMebYZ8CJH/06BjbN8Uc9unm1xs0cu
	 Ly++3xb9bVnDWG3oEVAFa+x+SlHZDaXu6SfjUSEYYBUGxndfspVcS9WHNBeYrG90Qc
	 M8Kd6+IHvsllC7JB5cFontTn0D1cVKbaF4TlA6A8CtXUSd6VpnTfqsKHfRtl1mUeuy
	 WXrBDZX9FfEoS06QkVQ/7PNFGxQrpT2llE+cez9WAkwGUWWDyFuNtGYoZnULOabN/L
	 MwK7y8PyNb5PJGJ6KMWK5bUaQyE0iluvoSj28mNbJIiPAWYCgesOj7z2JMjfZIpnMV
	 pT6ZZbk2MBePQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, cy_huang@richtek.com, Chen Ni <nichen@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20240716084659.1252690-1-nichen@iscas.ac.cn>
References: <20240716084659.1252690-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] regulator: rt5120: Convert comma to semicolon
Message-Id: <172226759474.71083.16743722853568965866.b4-ty@kernel.org>
Date: Mon, 29 Jul 2024 16:39:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Tue, 16 Jul 2024 16:46:59 +0800, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rt5120: Convert comma to semicolon
      commit: 3078425f63c5f526c8d2cb0b7ef9e0a3f50c9c39

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


