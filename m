Return-Path: <linux-kernel+bounces-378102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1FF9ACB63
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075981C20FC8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0771B4F1F;
	Wed, 23 Oct 2024 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hu94QG9G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C731AC8AE
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690708; cv=none; b=K7I+ILFUH3S94mBkz+HgLTay8tozb+VBbjui0ka/Sg7qReAUqEic7KRC5SJiac4/W12pzxE1xnsixU9KuT5H0bxk6vWQs2Omu+4iyYIW9tKchZbEO13wmVznDzESE3lDIS1M9uB4rakTiWM9N/Y5rXSIRERwyU+QfkW47fdy9Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690708; c=relaxed/simple;
	bh=AJLni67RgopUWpTMbrFdXOp9aUXXyMkiMHcVjsd28go=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cxJZi1ZDJIuk0ztzwpOJD14hamN3wHpjbpZcyprimyE62qsITvdU86Mkf3gBd05c8VQ2EwcvZqcQoasLnoAyhMhAtXaY2vHyd6VXNpKdYferrFAxd/9JuR3SAV7FftsmdkpbLxl33BukCJQgzdxPhRr7QHmkwdiVN+hBW8prApM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hu94QG9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB5AC4CEC6;
	Wed, 23 Oct 2024 13:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729690708;
	bh=AJLni67RgopUWpTMbrFdXOp9aUXXyMkiMHcVjsd28go=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hu94QG9GV+oEmiBjbORnIcUokgb4GUwKq2FayOrMVXQLC12NePvhkIJ+UaXeZ40h/
	 RiOEkE/HGV+g6XL2u8LXZmhIuPnTwvoc+ha+qSbSIPR4aENuSnsUvwq7BdkAPkoblB
	 KDjdd+B0BZu/1GjHwlFFZon0RenM4CFiTn8blUKOnmUYfKwsDMLnAJpCxLrRIQRznu
	 DVyfLtWGwKWB24z3KaOBNoCn2MsGkQiIU3xwIpBvI5CResOA3BDStqeUiZd9SYVGCX
	 gqjzexVDZg2kFBzuZ3RKcfKkXKqsVfPt5b5ax5BqnDNTyY4BtmrogsiZ7zk9/fZQi8
	 +OPxVBroKkFXA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Stephen Rothwell <sfr@canb.auug.org.au>, 
 Jerome Brunet <jbrunet@baylibre.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20241023-regulator-doc-fixup-v1-0-ec018742ad73@baylibre.com>
References: <20241023-regulator-doc-fixup-v1-0-ec018742ad73@baylibre.com>
Subject: Re: [PATCH 0/2] regulator: fix documentation warnings
Message-Id: <172969070684.51329.16819683295655789203.b4-ty@kernel.org>
Date: Wed, 23 Oct 2024 14:38:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 23 Oct 2024 10:35:42 +0200, Jerome Brunet wrote:
> This patchset fixes the documentation warning introduced with the following
> series:
> 
> https://lore.kernel.org/lkml/20241008-regulator-ignored-data-v2-0-d1251e0ee507@baylibre.com
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: doc: add missing documentation for init_cb
      commit: e55f45b0cda71ac2e9b4c6dee8852dc8d6f22ef0
[2/2] regulator: doc: remove documentation comment for regulator_init
      commit: d1bc2d5cca434e7c854fd16ef021c16d74293b60

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


