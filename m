Return-Path: <linux-kernel+bounces-447556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028B89F3425
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5431678FB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979F7148FF2;
	Mon, 16 Dec 2024 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXTfuO69"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B09137775;
	Mon, 16 Dec 2024 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734361952; cv=none; b=r/IxLg6UgsS7lIFiGvpXT8hlsMffJbJ6L5EgWw23RLxgQjGxkn7IKAEuHq0qE53B264HaDI9kC4saBRcG3PakU4tLu4hveiPYC2NTo70F6PdJQsm1TTDnIiI49HKveh5ZoyBU006FYv3VT+j9mBM5+wcHW98L9og2ZyslQZQMio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734361952; c=relaxed/simple;
	bh=SuOsN5d4VA5s7yLrkJKW+dEyOaU5PlfUkBWrFpSUnl0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dzfFyhpD5Y0j8rcwrzgrEu8rhyw2EJyl7Fiyll3JwtFbQF58lIOXMK6NvWMlTikyagWpPqWkVN/x2MSfz5Vi8c3RdQqPhQ3xHEgk+wwVUzhlwJZamFcVOGqT7l0pLbueGMfsgF4B+AuRodiSTlIqkDqu9zcaila3NBa4uof4KY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXTfuO69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73637C4CED0;
	Mon, 16 Dec 2024 15:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734361951;
	bh=SuOsN5d4VA5s7yLrkJKW+dEyOaU5PlfUkBWrFpSUnl0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nXTfuO69PPsaQUNxx4oEeOpMwTmid4vaPT69DszRHGACRRKzeO8APTFyPLPnhvZXW
	 w5cyaGHnGb5LTApw5BNrNW/Iczw2+/PQCe0ee5fgqk0znlBX5uG23T7cg2WGB/XhNI
	 CS8Xh7zlhQu5xqqF5wYu0ry+tkuDPkOTIbX2podwXQh52d8SHuW0t3yMxQh15Hvp5T
	 KnrEa+e2rCWruStjAEAKWZ969i3lEowXGf1S1K5+OhIOWPK4RSwABfbVcD0iRxZVDb
	 IW06oSZ4ipoNgWMxyUQxJ4WUYzx/w4JqKEmJbS2pqkLrHUL34V7kckzAn5lnwgq8iA
	 VrENSKM8HExmQ==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org, kernel test robot <lkp@intel.com>
In-Reply-To: <20241216105520.22135-1-rf@opensource.cirrus.com>
References: <20241216105520.22135-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] firmware: cs_dsp: Fix kerneldoc typos in
 cs_dsp_mock_bin.c
Message-Id: <173436195019.77772.5543212109898121281.b4-ty@kernel.org>
Date: Mon, 16 Dec 2024 15:12:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Mon, 16 Dec 2024 10:55:20 +0000, Richard Fitzgerald wrote:
> Fix two places in kerneldoc where alg_id had been mistyped as alg_ig.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] firmware: cs_dsp: Fix kerneldoc typos in cs_dsp_mock_bin.c
      commit: 539a3f0c99cf62c61edc37a8f88e3073119ae852

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


