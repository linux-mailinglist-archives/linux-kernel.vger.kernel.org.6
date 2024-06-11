Return-Path: <linux-kernel+bounces-209199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 931CE902E9A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35DBDB218BF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35EE16F8F9;
	Tue, 11 Jun 2024 02:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLoSsgdU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AEBA2A;
	Tue, 11 Jun 2024 02:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718074357; cv=none; b=evy8FXjqZd7EQTQ7QIKe/ZZFBCH1tuxvCa2L/VHOV+hXgBGAfvtBFUOb9Co4Lr0jQLY5hI70GeNrcJhifCHxEPwwCBqDZxJwG/nHy5JW1zdUgWUzkRH8Bzvyz0ibad7/8Vx3TFhMh+y+GbhnglZrc5j6ebYIWD2TjhT46/vJ7Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718074357; c=relaxed/simple;
	bh=Lw6UaTIaPX0ZJ+bHeOIKAfy56qXGaJ9yxxI09PHjR+E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HxkOAfSLlNRNwG1+l3p+cMBLA0mFM1UoUxsHslsGhPF4l7tooxMbbn52D26/t54M5Qq0ZqZvlZMMYNfnycniSqfDK6MU3eLxI3jXAHjJtzX5EcocCTnHWjV068BNKpeiFa6cpk+sLLXoti7qIAKw+Ls73Qc5xDEQhOtm4FHWKLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLoSsgdU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69F54C4AF1A;
	Tue, 11 Jun 2024 02:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718074356;
	bh=Lw6UaTIaPX0ZJ+bHeOIKAfy56qXGaJ9yxxI09PHjR+E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fLoSsgdUq6pLJERsof8jOvbi7VMKSR/nbQpXHd+299yWPwqi9Ie7CyuWmFJHtRWKS
	 2t0vpOSihwi1TKsaTHzg2PL+C2X8iAjfWHjitIMrOoqkhN0wyuyQKGX7/QR6X/WrzE
	 79DJTZlRdEaUX03qNTAfWvZVJYVZR1nrrP/Na/bsYCrK6tWP4n3RzZIqbZJzX3twLX
	 zqgVaHtyQQ0NQcunezYY+mxXFPwucv3nt3HVVzm1rWm4xELi3GUmZbjSaHRE/pmb9a
	 Fzx0e2UFQjbQ8q5A/NcXaj4v+OInfBSJqueTl7b+hl/7VqoCVQQD5TVGgPX5zOugZj
	 yr7/mVyfLi9kw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55002E7C76F;
	Tue, 11 Jun 2024 02:52:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] platform/chrome: cros_ec_proto: add missing
 MODULE_DESCRIPTION() macro
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171807435634.18125.2033985053874197153.git-patchwork-notify@kernel.org>
Date: Tue, 11 Jun 2024 02:52:36 +0000
References: <20240610-md-drivers-platform-chrome-v1-1-f9c75adcc1ca@quicinc.com>
In-Reply-To: <20240610-md-drivers-platform-chrome-v1-1-f9c75adcc1ca@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: bleung@chromium.org, tzungbi@kernel.org, groeck@chromium.org,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Mon, 10 Jun 2024 14:50:37 -0700 you wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/chrome/cros_kunit_proto_test.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> [...]

Here is the summary with links:
  - platform/chrome: cros_ec_proto: add missing MODULE_DESCRIPTION() macro
    https://git.kernel.org/chrome-platform/c/d11c00292a31

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



