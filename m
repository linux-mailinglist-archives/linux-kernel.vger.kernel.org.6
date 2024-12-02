Return-Path: <linux-kernel+bounces-427586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 875A29E031D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5A2288C0A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8B51FF7A2;
	Mon,  2 Dec 2024 13:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnxCSKis"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEE01FE469
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 13:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733145405; cv=none; b=a2ImbZU0TISBGf+MsHBxKoB5gDhMSzfbN0XAxhA8CckbtVOXBKFCcfkeiMdmQL3GNm44nwHYbvbfqirXQAojF/5AtFFbGV1UqvAmPRDHl5ENjUX0nj7hoBu5JSVDHAaNy73AUfJfkmUYsvrDwqG3KG4qOiE3xfaYnlyOd6pBMIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733145405; c=relaxed/simple;
	bh=XV0a+VBht+qC20K/Mo99JjOsyArsLSLWWPEdZ3JXT4g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZJnKMDvIsj3W6Zkldd6rsj0d6dn8wdgqUls2kQpbCrpwD2tXiUTN7BlUhvACVyRrmfWOC3UFm8b3OOmVLJc5dVW9U9L6MecCvcxrErGf2yfy9SUYr9SEEhyjDTT8fCO1aPqpcCYrMFuuA9IjN/6iB4VQietK7YKtFOE6X06d630=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnxCSKis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9515C4CED1;
	Mon,  2 Dec 2024 13:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733145404;
	bh=XV0a+VBht+qC20K/Mo99JjOsyArsLSLWWPEdZ3JXT4g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dnxCSKisp3TPecTN/FiRc0K5gD8f/3h3X0IhkozaCBjaDlsXb2jRyjzS1FsspKC7k
	 FIu3D8djzQ/P2x/IzrOHURax3skAWGmp48zGvcpwYIB1gJ0fXiS11e3iUn4dqTfDvm
	 8ULdofpvlSfRiK9wifOndBr9mjYTQUB9aFzs2v0UV4Aj1E3fkRLFKKeyNxBfedCiJI
	 PfFYCVX2+XOVhYPHBIqfC9JpBW+XLZPAYaQ6bgmbNIPgHVs3hDMUjOC9pYV1ADyxan
	 4bgtaMm4Yo0l/R/dhEwvgzo88EncfQdiERMH9yuFZ7cBalYwSbLZmJU7kA8omB7aQV
	 cAdUTU/U69jwA==
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <ZzWkny4lKpY09SX5@mva-rohm>
References: <ZzWkny4lKpY09SX5@mva-rohm>
Subject: Re: [PATCH RESEND] regulator: bd96801: Add ERRB IRQ
Message-Id: <173314540342.45537.922708057754057095.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 13:16:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 14 Nov 2024 09:19:59 +0200, Matti Vaittinen wrote:
> The ROHM BD96801 "scalable PMIC" provides two physical IRQs. The ERRB
> handling can in many cases be omitted because it is used to inform fatal
> IRQs, which usually kill the power from the SOC.
> 
> There may however be use-cases where the SOC has a 'back-up' emergency
> power source which allows some very short time of operation to try to
> gracefully shut down sensitive hardware. Furthermore, it is possible the
> processor controlling the PMIC is not powered by the PMIC. In such cases
> handling the ERRB IRQs may be beneficial.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: bd96801: Add ERRB IRQ
      commit: a8d77166fcfe1cd4be70c21d65ff2b27b4f54a26

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


