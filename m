Return-Path: <linux-kernel+bounces-566385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABAAA67719
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3AFE7AC05D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880AB20E034;
	Tue, 18 Mar 2025 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kb+qXblZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FDE191F92;
	Tue, 18 Mar 2025 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310037; cv=none; b=dhLAVSS2/YsqUGrEiEwClLuzJ2Jsi7zY/mB5tiBkmSgQxZkjt8Tjg3RpXCi5oe+aYQPqGqyXiex1Jr8bM3FtDpKJMX213wDbmTc0/bwWxvtYeZgcNyrzH/3IZsMsLURPhE9ksTbKz3Li4kMqIitVgTNbopet8z4Q/sZ0je8KELM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310037; c=relaxed/simple;
	bh=47vnSQ0ucUw6EdgK/Uz1l6l93sOBKFDw+OkXQpAZ63w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oswFtRdsGBJ0iGW9JLGXebL4W1V6vcxK/WkR6xchiAEkHUFJpXz/3BsLbJze2woiRrLC+ZMzRZOHz/lHr482if3TglfYyzyNkWpdeQbYPBTN/8R2XJ5SREGR3lVt01Kp55zqM2ilgiIw0USscxOfTnAjJXys+0eOvmYkIasqHsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kb+qXblZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403F4C4CEE3;
	Tue, 18 Mar 2025 15:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742310036;
	bh=47vnSQ0ucUw6EdgK/Uz1l6l93sOBKFDw+OkXQpAZ63w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Kb+qXblZZAQqKa9H1k+5Ww7a9LtJxtsZ289yf48mpJFL8FhsCgl0J86SUia5fCJ7y
	 vH4NG2xcPB0ixQOfB9incK3qVD9T4M9s04ubxrOk5bHWqCJv40E866BwfiWAw7tD+B
	 D2YRQMmBJ1W5uQZCfMrUYJGQxtlDGSAXoOrnfVXlfaNzQf4tbor8IHv5S3YAj7jPdY
	 /BkC8jf8m7/+L7QyjmbO2UImdj53M4wA/m+iPP4XtmiEa7tctWjXzDOyRxNd5VpLhn
	 kvfnJXTD/35IQ4v3pjrYQJmpx6i+fStsOy9ACEVkLc4kkGlkhmI4zoeCPKcZyOPuc7
	 WMOvFuQB48Tig==
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cy_huang@richtek.com
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
In-Reply-To: <cover.1742295647.git.cy_huang@richtek.com>
References: <cover.1742295647.git.cy_huang@richtek.com>
Subject: Re: [PATCH v3 0/2] regulator: rtq2208: Fix incorrect code section
Message-Id: <174231003498.125964.14980151487641276196.b4-ty@kernel.org>
Date: Tue, 18 Mar 2025 15:00:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Tue, 18 Mar 2025 19:07:03 +0800, cy_huang@richtek.com wrote:
> The old v1 series are here for the reference
> https://lore.kernel.org/lkml/cover.1742204502.git.cy_huang@richtek.com/
> 
> Since the subset of v1 patch series are accepted, there's only one
> document change are left and still need to be reviewed.
> 
> ChiYuan Huang (2):
>   regulator: dt-bindings: rtq2208: Mark fixed LDO VOUT property as
>     deprecated
>   regulator: dt-bindings: rtq2208: Cleanup whitespace
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: dt-bindings: rtq2208: Mark fixed LDO VOUT property as deprecated
      commit: 64b3fb38b45f7f36954801c45d9b7c19d82d6f83
[2/2] regulator: dt-bindings: rtq2208: Cleanup whitespace
      commit: 5e9491370a58bee1784999aa42f48f1f7289f641

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


