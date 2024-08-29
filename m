Return-Path: <linux-kernel+bounces-307268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F135A964B16
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5697289039
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9745C1B4C25;
	Thu, 29 Aug 2024 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gALXjmpo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4121B4C33
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947639; cv=none; b=d6ak4bHCv00Bqyub/UPlhRBA9i+PMHmwqhJpZzcCL+OpH7/aQp3G7FiX2E7anPRx5Tp6o8HJxVejj4Nl/K7t8U7/BtgqYMeXhr3mSPklLOf0z8+KeaPSOgj1Wga4DA6ahoknCZli6+SoL+4OwU/gd9MTEISAehfFQBTbDxanBCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947639; c=relaxed/simple;
	bh=tiSDv54r6xRfPHPVcCdUbhrVn59srC4NmTFyCoETiZ4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F/ezYGnmSCe2ePoA4SbXQsJ+QLBKvkVn2/AZMHlm4EGNhMLOtSXakCIhGWyGxyMBNLbbsjFUuFEhAipEsZImpAH8gOMUSaeTRNtmrJBuPPk44Ot4Wg7q4n7tiW7dvS8WZTHXGpTxbhWlfB6MJdvX2bk7vlNurd30d2iTGDsQw2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gALXjmpo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A682FC4CEC1;
	Thu, 29 Aug 2024 16:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724947639;
	bh=tiSDv54r6xRfPHPVcCdUbhrVn59srC4NmTFyCoETiZ4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gALXjmpouAUvaENckl6j61Q2qhjNWVEaThb32jEGHgbBjkxG3PxrRRn+6/XUCR3dX
	 X0TKJFCfoN3RU65fPLPluScG3zqH/PKS/7cfI31U9WgZxY0JwUN14DlzIs4o9NFhKo
	 AmkDrlmExSbX3nATjFjjSAbt3zzYMVa0KLq5EgUTD808GeUkJaWvkmFXp6J6Q/1iv4
	 AFKUT2PR5/zGytlt3AGz/PX8t1BZQHi3e4Rre3+QzFU3ha0vVTOiihJ4tNABo+x47B
	 lljnLorn6v/weVHEH8PWJfvQh99/L1Mkss4xgLRc7pRfdXWvqzAXXV68x48apCo0qS
	 5FBit1IY42VLw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240829085131.1361701-1-wenst@chromium.org>
References: <20240829085131.1361701-1-wenst@chromium.org>
Subject: Re: [PATCH v2 00/10] regulator: kerneldoc section fixes
Message-Id: <172494763840.573976.2710672378367527854.b4-ty@kernel.org>
Date: Thu, 29 Aug 2024 17:07:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Thu, 29 Aug 2024 16:51:20 +0800, Chen-Yu Tsai wrote:
> This is v2 of my regulator kerneldoc fixes series. The series sort of
> came as a request from Andy to not move code that already had warnings
> without fixing said warnings. So here I'm fixing them first.
> 
> Changes since v1:
> - Replaced "true, false" with "valid return values" in commit message of
>   "Fix regulator_is_supported_voltage() kerneldoc return value".
> - Added articles ("the", "a") to the description based on surrounding
>   and function implementation context.
>   - The indefinite article ("a", "an") is used when the return value can
>     vary in the case of negative error numbers or when the returned
>     pointer points to a newly allocated memory object.
>   - The definite article ("the") is used when a specific return value is
>     mentioned, or when the returned pointer points to some existing object.
> - Capitalized first word of first sentence in "Return" section.
> - Indented "Return" section for regulator_is_enabled().
> - s/alloc/allocation/
> - s/error code/error number/
> - For patch 'regulator: irq_helpers: Add missing "Return" kerneldoc section':
>   - Changed subject to "Fix regulator_irq_map_event_simple() kerneldoc".
>   - Described output fields in @rid clearly.
> - Added patch to fix of_regulator_bulk_get_all() kerneldoc.
> - Added patch to align "negative error number" terminology.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[01/10] regulator: core: Fix short description for _regulator_check_status_enabled()
        commit: caa08dd8cdb8e58bf810e986cd6f9081ad056018
[02/10] regulator: core: Fix regulator_is_supported_voltage() kerneldoc return value
        commit: 753b9d86adb9d2c5882ac8ee0c3816aa48697eaa
[03/10] regulator: core: Fix incorrectly formatted kerneldoc "Return" sections
        commit: f746af13dd115ae3e0ec9d762baa170184401d41
[04/10] regulator: core: Add missing kerneldoc "Return" sections
        commit: 4ac204ff2d4ec360d9d2e39840ad286ddb78439f
[05/10] regulator: of: Fix incorrectly formatted kerneldoc "Return" sections
        commit: dac41d59f2de25b8d3f5350c8cbfe39187d214da
[06/10] regulator: fixed: Fix incorrectly formatted kerneldoc "Return" section
        commit: 5f93c59e607e6f28eef2ed7ddd5a2f89abc943a5
[07/10] regulator: fixed-helper: Add missing "Return" kerneldoc section
        commit: 4ddb16cf5390fc8546409aab3c69ffe6651b3c6b
[08/10] regulator: irq_helpers: Fix regulator_irq_map_event_simple() kerneldoc
        commit: 77904c81703b7a4a929abafb837d06b49de087e6
[09/10] regulator: of: Fix kerneldoc format for of_regulator_bulk_get_all()
        commit: 6eace77a6048c9b0b50950e88ef987d4519a53c1
[10/10] regulator: Unify "negative error number" terminology in comments
        commit: 98ce82a52886edd5197e903cb2b56f21bf3b0781

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


