Return-Path: <linux-kernel+bounces-271618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9299450D1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64AB61F292A8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB591BF317;
	Thu,  1 Aug 2024 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ozkel2S6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117AA1BB68E
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722530003; cv=none; b=XLV521HToeNhM4nz1tl7NS1y5PvlgneUV4U190h1Zhdbrq0CN+d7SuwoMygfN18sh4ivPTGBUSKH/WlA7pnu3CJ3mGMUEQiz+Z3HvnAwY5NsdH4nCFvfosc5YUYbdhhcLXnNA3jc+8zx6pcv8wVNq6fh/3cShQ0qxS3p0jZelDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722530003; c=relaxed/simple;
	bh=pFyWkElnb5VKupDVDS7I/n9Dbtq1YkeyTlFJiJRjpvM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UwRRpgadd4Znz+0PJ4ou5ELC6bMPaUdVE2eLUYpJumkmKpOm02eNDcyVbrPC0EBQpvNntw1HeW5mHTkdEjrc5lmt4QCRz8sYiUu2635XCS50fFVl4swfMy5Je5nzlyUEWis3OEHLAQd5OOMbKfCKEkVomFHG8lmVbfQnJlzj8iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ozkel2S6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3E9C4AF0B;
	Thu,  1 Aug 2024 16:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722530002;
	bh=pFyWkElnb5VKupDVDS7I/n9Dbtq1YkeyTlFJiJRjpvM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ozkel2S6hJb4Kbn2yycAb0oRASHjkXODZN6WuGqjIyWbIdlv5gVJyVGPYpCOw1xUo
	 kGmgUSbH/lJTxwemcY7mIoe5FtUQWK8gW+n//B/y+LksYEeVarfPwOJgmpOfjTqeEI
	 gy9jeb5fLL/gE9sR8DaUs9kkr4cd9sfNhWf6ZtRfH1cIE7NW6EaTCK1MOLUqlqqU8p
	 P5Cqv3c+deRP3yOh4opdre6tiFbMj1e0zXtmbv8+Cg5ho8ZsjmHBePQTa8P7+5PPl9
	 fMupAkgrf3AOhPshRCO8rSvoqwnvf0ab4r0Og9GrQALipZQyaYEvR3ejCFejuKHh1M
	 721mgkrs7CCLA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Yue Haibing <yuehaibing@huawei.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20240801114536.472796-1-yuehaibing@huawei.com>
References: <20240801114536.472796-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] regulator: max77857: Make max77857_id static
Message-Id: <172253000169.113778.18182813662701868220.b4-ty@kernel.org>
Date: Thu, 01 Aug 2024 17:33:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Thu, 01 Aug 2024 19:45:36 +0800, Yue Haibing wrote:
> Fix sparse warning:
> drivers/regulator/max77857-regulator.c:430:28: warning: symbol 'max77857_id' was not declared. Should it be static?
> 
> max77857_id is not used outside the source file. Make it static.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: max77857: Make max77857_id static
      commit: cd7d47c5762997a2b1de57a47cd48a1cdad38d96

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


