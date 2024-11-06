Return-Path: <linux-kernel+bounces-398949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FE29BF85E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C33381F23727
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BF820CCD6;
	Wed,  6 Nov 2024 21:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FL4mZL1L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74139209668;
	Wed,  6 Nov 2024 21:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730927660; cv=none; b=BQP9cdkrj9aIov9V39ArOYtl2RvJeAItA68I8symx3/xf1ckCzBUwj/ngqG6ydk3lZLqrmOCr5uJ64sfSxU+9cajGP7xaw3dfReU3FVOzaqAujaoQgjQvb98H9PgQTC+4F0KSc4byzkpKit96W3VgREp7n+aB9mtgL4hFmwRjSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730927660; c=relaxed/simple;
	bh=7/BdvkRmiyyxC0XnyH5pvkrr+j4iCL5yDpito59jKc8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GrDdeXRzCNO3EdPJIpo+q7mPBaEMT//OQ8yqr8b7eAhIBD9M1nnXifogVGWHZlv3XOXfTlr8umyduhDaNdanc+emlFWb2z8RtpS7Oa9MWD4LwSw41BgbBBHTqcHfVO3xpdzinvlkqxj5xlGpu9+cWX3k7Soi1+tVl2pH6gjLi1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FL4mZL1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C49CC4CEC6;
	Wed,  6 Nov 2024 21:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730927659;
	bh=7/BdvkRmiyyxC0XnyH5pvkrr+j4iCL5yDpito59jKc8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FL4mZL1LEP/eoXCMb2ABDyBKV3jMPIEb4b2ONddyE0DiGDwGC12Zt6PDSoXOmLOal
	 4Sq6sG7lTddHoYBA08gaCc6TtdQTAFfEUUYvtrFLYIo3a92Q5OzQ7WOLzgBgUOFEdp
	 P15Uqj6IT5RZDnmrWqwyzsAra1fCMbKTpfnbeSPJ/5y82JQvnhcgknY77MlzQpkAdw
	 vBGMZKTZxRAg3Tp1Kq7noXX1TaNJRDO5pCYLKk85OL6pHPptvwB6A2yOYKfUPZpuI6
	 hwuGI8Z/vtwGSMz8mDtyn8DxHpQ+kPO3DIj9N0JmQiPzUCaQPGVR4SRuIBgcdRN30R
	 f+W5WzcuxP8jA==
From: Mark Brown <broonie@kernel.org>
To: Fei Shao <fshao@chromium.org>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org
In-Reply-To: <20241105091513.3963102-1-fshao@chromium.org>
References: <20241105091513.3963102-1-fshao@chromium.org>
Subject: Re: [PATCH v2] ASoC: dt-bindings: maxim,max98390: Reference common
 DAI properties
Message-Id: <173092765728.208420.14697399337630001578.b4-ty@kernel.org>
Date: Wed, 06 Nov 2024 21:14:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 05 Nov 2024 17:14:31 +0800, Fei Shao wrote:
> MAX98390 is a smart amplifier and exposes one DAI, so '#sound-dai-cells'
> property is needed for describing the DAI links.
> 
> Reference the dai-common.yaml schema to allow '#sound-dai-cells' to be
> used.
> 
> This fixes dtbs_check error:
>   '#sound-dai-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: maxim,max98390: Reference common DAI properties
      commit: 9b915776e0e6a2d185498077e0ebdb154a2751ac

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


