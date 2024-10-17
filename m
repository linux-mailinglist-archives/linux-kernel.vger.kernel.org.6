Return-Path: <linux-kernel+bounces-370433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE02C9A2C59
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649DC1F22268
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAB320101B;
	Thu, 17 Oct 2024 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0idI10Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B731FDF9A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729190425; cv=none; b=gV0fsXrtEqrOfkHeReTAeNc73UBqN9hzw7ZPwFi/3iQvCTBmcYjEZT+QHwA6pTOovRBdT3ys6gVc12LYR/GUhhd/DBx1GtsYxh9KFZmMfwEF8LNuRg3+szHg3x70djHiS2nv9t65PkUbc1rauzM6iDlLQs89FvCAOxA6o9JquF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729190425; c=relaxed/simple;
	bh=qvjSVmXApt+OQE+H6lxGBFGUUTSaK6dn4kka0YcowlY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U/CzTlV4sjOcq4Xs4IjHwV4FtkAL4XTG2ICNyJpXb0iCtmsg/VPhRZpeUzIcCQfkId+YgmFit8ibcks94/24UwHFEzN5noYEJggOKLtPtWvhiUYNLw/BqYHJ41LPNX1XA0VFg73yw8nD1Q0T+9+O4VHjH0o+mf+EMSgL4rWoF+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0idI10Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E4EC4CEC3;
	Thu, 17 Oct 2024 18:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729190425;
	bh=qvjSVmXApt+OQE+H6lxGBFGUUTSaK6dn4kka0YcowlY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o0idI10Y6PzhF/59mHZK4P3tIy3NWvTXiPz07YYePq5m2LxamnIhYdD/fusCC1faH
	 t+NFk5tGOaExoXhrmt2yMx9gBMnpdbEMOGqntReTaUHH4OaI6XpvFVDcZKAhanGPQe
	 CdyzBqsh9uMwSf9097SutPMl9M+4sS7o4IYiQVOO8DdFtr+NDlucWLR8i18t/WHzpD
	 fnvzjisoNpNbwoW1/EdzWi5bnUXy3inv4svdui8Hh8edE2BpUk9dEuMS6k5swXhjOs
	 nGfHJ6Q0blhBqsQgCuq4f+NorFtV243Qk0pOsXmnCAZ+pyWOIDmFFYIL+1XB+RxrGy
	 WUiAzV48vYlBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCB43809A8A;
	Thu, 17 Oct 2024 18:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: defconfig: enable gpio support for TH1520
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172919043053.2569783.17192374033073504253.git-patchwork-notify@kernel.org>
Date: Thu, 17 Oct 2024 18:40:30 +0000
References: <20241014205315.1349391-1-drew@pdp7.com>
In-Reply-To: <20241014205315.1349391-1-drew@pdp7.com>
To: Drew Fustini <drew@pdp7.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, conor.dooley@microchip.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com, inochiama@outlook.com,
 heikki.krogerus@linux.intel.com, apatel@ventanamicro.com,
 hal.feng@starfivetech.com, geert+renesas@glider.be,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 14 Oct 2024 13:53:15 -0700 you wrote:
> Enable gpio-dwapb driver which is used by TH1520-based boards like the
> BeagleV Ahead and the Sipeed LicheePi 4A.
> 
> Signed-off-by: Drew Fustini <drew@pdp7.com>
> ---
>  arch/riscv/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - riscv: defconfig: enable gpio support for TH1520
    https://git.kernel.org/riscv/c/5fb0ecf73e7a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



