Return-Path: <linux-kernel+bounces-248468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F217B92DDAE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 03:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85981F21696
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDEE6FCB;
	Thu, 11 Jul 2024 01:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4Z10GMy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975C1383;
	Thu, 11 Jul 2024 01:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720660242; cv=none; b=EYZ2np2aForZ2tB4f1LzQDUEl0+ltUNqsVlDlfgnQxoc4j0dkGbWuVaAHgkFReLAkBYbk5jcH5tdkT5S78Sv6u+nj5Apc8cHtzVB32kVBYQJHbJXLnY7Q3FpUzKgwR8CWJxGlYFT8bbZT7JSgv/BNDnFdWPMEVAAYHjR9EQ/MeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720660242; c=relaxed/simple;
	bh=Z9aIB8pJH2qeFtWfaUtf4EZPQw2VoEaVqsMNNYoG7Mk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HxAyvAvaWryHSqi4wokIkJi1yXV/A+zlFn+FHinS2uo8yIM6SkS548IoqIdNp/WIqUIba3nzueb8sK43zxUCV4ob57Wq+46ShCbkUAKInqLMloSX7vTE01+enaOxgSAhDax3U+BGCXSlU6CuKdkK7Ij27dIcV5wwM/3YJRQ5GuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4Z10GMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F365FC32781;
	Thu, 11 Jul 2024 01:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720660242;
	bh=Z9aIB8pJH2qeFtWfaUtf4EZPQw2VoEaVqsMNNYoG7Mk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Z4Z10GMyYjQCy6mZcfRyAWLb6MFxNbfIP8BVr74nh37DVVgc7IxdwTxR3Z2XBMYTK
	 dif7lT800XF+c3EpL9cuCGOEQQOyc/QC1w0hgkYO6nyqDdOowCDeHyDZDajzlmKbE0
	 r+YUOmafSdXc2teSs033EoaYbyVCPaxsHNusX32TaijKS5ffCYpJrB65UfWTZ30Chh
	 JxB3q8M4HoyMNnpBR/DorQByL9L77aMTYwwGS21FNrZ4iVV8TnTTt/4uf/Ohn2Pe8u
	 +0rcnB8HgI0KIeMr9CUDLYLPwKJcGIQb0jDeROryxZF0dfrQRZv3LnfDmeTJ6QY2uf
	 W4aMQVZz3aWYg==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.cirrus.com, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
In-Reply-To: <20240710103640.78197-1-rf@opensource.cirrus.com>
References: <20240710103640.78197-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH v2 0/4] firmware: cs_dsp: Some small coding
 improvements
Message-Id: <172066024060.393700.15835907433889376478.b4-ty@kernel.org>
Date: Thu, 11 Jul 2024 02:10:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-0bd45

On Wed, 10 Jul 2024 11:36:36 +0100, Richard Fitzgerald wrote:
> Commit series that makes some small improvements to code and the
> kernel log messages.
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] firmware: cs_dsp: Don't allocate temporary buffer for info text
      commit: bff92858dfb9897e4c06c11aab0322e1aab822f7
[2/4] firmware: cs_dsp: Make wmfw and bin filename arguments const char *
      commit: 584e86e14c59d36688633002613792923620d8c0
[3/4] firmware: cs_dsp: Clarify wmfw format version log message
      commit: a4939119055d5c97aff2cea040f1af8c4606bfa1
[4/4] firmware: cs_dsp: Rename fw_ver to wmfw_ver
      commit: dc0e5ca8856dc6a97e3b117879dfb2b52bda06b6

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


