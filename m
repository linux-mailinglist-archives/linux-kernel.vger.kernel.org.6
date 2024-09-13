Return-Path: <linux-kernel+bounces-328804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E40978913
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5900028539B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324FF1474D9;
	Fri, 13 Sep 2024 19:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khE1yw+3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9121C1C2BF;
	Fri, 13 Sep 2024 19:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726256633; cv=none; b=rAhcLRbLACt4e7P2WaLCURt4b0mNNwQTRkObktJQqWvNHVwLXekTuhYKNTQwA5vIQJsUnxZTN4NwaK2ziTKLjm4XhkHnkdW7YxWWeCEYoPn9JYA33jOg+IeE+xfRAQEP2OCx8r6IKgVWNUR1JO76DgUqEkYkrghSWcCRDAvVXBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726256633; c=relaxed/simple;
	bh=jpwz5agnsjXEH5QEUiOdi7lBl/sCefc1GJWZXXqfxRM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tH/Gza3JzRC1SZKcHrZ/mxEjDXGxwAynAJHrB1qWj2ZjO3Vs6f21kQ70+LLyPt/REXY/wtL2ogkoSKRQ1zsrL3rC3H84dT4+l3QEwdvQhRaHWcV30RltzDuFhLQoNDJgCR3XeZPhatHmhvo0ZgVzsmxTop8BGXNHdanTkDwyRik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khE1yw+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B82EC4CEC0;
	Fri, 13 Sep 2024 19:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726256633;
	bh=jpwz5agnsjXEH5QEUiOdi7lBl/sCefc1GJWZXXqfxRM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=khE1yw+3ghJ98kTlPZS1sT/M70pIUAa8T4mpTkVrDD4RtruYMDKgGHblL6FE3FL2G
	 PxPJsOhqGwj70K9XVJ7mCWApHe0XooqIX/+riqoa1Xpjcv+vqGh4kO8aBsn0IwNoXs
	 e82N7xme3OC3W3d17VyMw62s7j4ZPDdWUIIvk7woqdO9wcgVQUzX80GXW3fc0ctAdg
	 DUELDac6+MGvxG0ECRfPbsBU1NmkHkTNrM3jon4UgV3/rWD+CD8g9ZpepuqaxMifVC
	 OHoAXw+2QJstwzFTWNgzzfP/lZ8qM6CN0uTSqUaQaPcUkIesq4Li+hzft9SLAgA9iB
	 +Osz1ALP4EQCw==
From: Mark Brown <broonie@kernel.org>
To: markuss.broks@gmail.com, Liam Girdwood <lgirdwood@gmail.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <0f5da91a05e7343d290c88e3c583b674cf6219ac.1725910247.git.christophe.jaillet@wanadoo.fr>
References: <0f5da91a05e7343d290c88e3c583b674cf6219ac.1725910247.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] regulator: sm5703: Remove because it is unused and
 fails to build
Message-Id: <172625663174.87505.7759301350549819413.b4-ty@kernel.org>
Date: Fri, 13 Sep 2024 20:43:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Mon, 09 Sep 2024 21:30:51 +0200, Christophe JAILLET wrote:
> This file does not compile because <linux/mfd/sm5703.h> is missing.
> In KConfig, it depends on MFD_SM5703.
> 
> Both MFD_SM5703 and the missing include rely on another patch that never
> got merged. The last iteration related to this patch is [1].
> 
> So remove this dead-code and undo commit e8858ba89ca3 ("regulator:
> sm5703-regulator: Add regulators support for SM5703 MFD")
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: sm5703: Remove because it is unused and fails to build
      commit: 4591a2271f2e4c320eaa63c348169e4e6e6f2852

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


