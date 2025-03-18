Return-Path: <linux-kernel+bounces-566439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DCBA67806
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB37B19C0789
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C2A20E339;
	Tue, 18 Mar 2025 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFaIqcqW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314BD20B1E1;
	Tue, 18 Mar 2025 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312057; cv=none; b=UpoGCi9G9/JGTknl81G5FT4hvB+kLmvC9osi6IDogDxeXLgIJZAm2RvC7FkPb92jVvMB03ul5azenH8CfOG701khADkNy6kFOpB7PgbBQ75rQVmFJXFjYIoNI1fNEn6E1oIKFsocRAEpTj1aNCBwxZ45cJ0WF3ulK7+wARDvarI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312057; c=relaxed/simple;
	bh=fu21imNYc8W+I9VWuFRVGgik9ETmjd7qRpq7poWLyao=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iFjlIszrIhrkAcq1U7FSCSFaNzy6J5HKSoZ9Bxg5XaA9jfUZo8Wkxu7dqezQjRr7ia+rVfJd/eDeNPk2DMNuzX/MonAHZRL3ndkxA6EKVqMgxt6VfsdIEjJbrv0JmnKgQyNwb5Y0oOBgzygEikDYlCWwZLqOUnoJ9cojj6k5nLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFaIqcqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381F8C4CEDD;
	Tue, 18 Mar 2025 15:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742312055;
	bh=fu21imNYc8W+I9VWuFRVGgik9ETmjd7qRpq7poWLyao=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lFaIqcqWfxCdaL2d2RthvSDFgBg13vTDSzEBdkqCq39/DwzfUgLoV04qZHAuYYuP2
	 1ZiWEjtmNTrShXTG1D7UMPwK275QdzlyOXgTvZ1EBdmfpclO0+KiqnTgW/ljuqj85i
	 Q2lul/f2auC5YbIG8s6RrOV007ThlrYxyX42qF20Sfx9c98xJv8RN3MyXesJ5ryw+k
	 6Y4LYRH5mjcw/Mn04eyfiLs2qNzHOVT2fxbkiJIRqdCHC2lFL6ocXLVYqjJEh0uG5u
	 qVqAGKXoqLJ/TZ/r62mCRVYeUyqoUJDV2zMfLtD2GkRsdmiqNHigkXrVj1kOLYr+vV
	 Fg+vY7zaTvBsg==
From: Mark Brown <broonie@kernel.org>
To: peter.ujfalusi@gmail.com, lgirdwood@gmail.com, 
 linux-kernel@vger.kernel.org, Jayesh Choudhary <j-choudhary@ti.com>
Cc: perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org
In-Reply-To: <20250318104715.43267-1-j-choudhary@ti.com>
References: <20250318104715.43267-1-j-choudhary@ti.com>
Subject: Re: [PATCH] ASoC: ti: j721e-evm: Reduce log level for EPROBE_DEFER
Message-Id: <174231205391.165223.230616849294611314.b4-ty@kernel.org>
Date: Tue, 18 Mar 2025 15:34:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Tue, 18 Mar 2025 16:17:15 +0530, Jayesh Choudhary wrote:
> Drop the log level for deferral probe to avoid flooding in kernel logs.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ti: j721e-evm: Reduce log level for EPROBE_DEFER
      commit: 340abded86def0ab8ad8ef9ba73d8ac2fb6fe991

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


