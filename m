Return-Path: <linux-kernel+bounces-293987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84413958740
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 131E6B21A4C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2265719004E;
	Tue, 20 Aug 2024 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7Qj03Na"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DC418FDC4;
	Tue, 20 Aug 2024 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724157854; cv=none; b=FaIkvUPO1fhfx8JEciIYbXE1RPj25nOFaJfTSRYbvh6NjfdcFqfxfezZPF+C+Z4meJDfF9NPkH46Thz3S3DUV30WALFsXh9H86fXlhPT5ed2qTrfV416jfqrmEqUCJMnfry2JNTLdt0XDh75NtmgwXpIYFuJqsXIz9m0RzltB50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724157854; c=relaxed/simple;
	bh=7ps/BUMDikTMh+Z7kKWuV9WchewWaMrcGKoqEcQhIjc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q7N5/UjFM/2llcFjvQt6T/lLE2CS+N8H+RpChzVudx64bya96jKq6jVPhZIweZ3qRBgh8iQGhSCv/nD3x9cG3aOZQoAHC8zgdmhmqEbckcOiWXra7XcHnFmyl4s1zAZV1fGCel17O8Puxlao4OkWMmSLs4n1tdtrwymf0qJpS74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7Qj03Na; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F87C4AF0F;
	Tue, 20 Aug 2024 12:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724157854;
	bh=7ps/BUMDikTMh+Z7kKWuV9WchewWaMrcGKoqEcQhIjc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=j7Qj03NaZ78EvTHSHL6Vq5lR/WdAr1K/QorAI7+E0LTxr15cL5QiUJuD4JI5AP1E4
	 trxHIQ5ENHUprvufVEikhACHIS/bqsQwmYeNkdiwAsWAmKTa/qtakB+reiPFXbfb2k
	 YY1bI/Q1WxrUpI1UHPG8mGokJgf6nnRMRgUcho264HdXLRyuaN/JqNL8GwtorYgvYI
	 o+K65LeaLLDYaUEyNpVphOa1E0JPQL0kH6USaaf4W0m/lSyrfFOmLDVd5MHJ+iZRJz
	 He89D1aYVyGvp2C7SVhECk9Y7W7fHhzTamQ3F7h/Ul4u2Q7g+DSfmOR8CUwAts1p7B
	 7nL6Xtge74W/w==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, vkoul@kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de, 
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
In-Reply-To: <20240819005548.5867-1-yung-chuan.liao@linux.intel.com>
References: <20240819005548.5867-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH v2 0/3] ALSA/ASoC/SoundWire: Intel: update maximum
 number of links
Message-Id: <172415785240.39606.6131661518510605412.b4-ty@kernel.org>
Date: Tue, 20 Aug 2024 13:44:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Mon, 19 Aug 2024 08:55:45 +0800, Bard Liao wrote:
> Intel new platforms can have up to 5 SoundWire links.
> This series does not apply to SoundWire tree due to recent changes in
> machine driver. Can we go via ASoC tree with Vinod's Acked-by tag?
> 
> v2:
>  - Change the patch order as per Vinod's suggestion
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ALSA/ASoC/SoundWire: Intel: use single definition for SDW_INTEL_MAX_LINKS
      commit: b27404b2bbf951a11500525dea15681cc970226c
[2/3] soundwire: intel: add probe-time check on link id
      commit: d2234596be2192d9c1ae34f8c7534531191bc433
[3/3] soundwire: intel: increase maximum number of links
      commit: 1f3662838a05f1ab6af89a417f6f252d91d0806b

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


