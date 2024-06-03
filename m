Return-Path: <linux-kernel+bounces-198530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB848D79CC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 03:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8759A2830BF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 01:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E077F8BFD;
	Mon,  3 Jun 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEBAfjUt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E754C63;
	Mon,  3 Jun 2024 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717378230; cv=none; b=RITs+8foHbyRjrNAUT993WAz8yq2N5gv+C9FQPDp9+PutU9sVZZAl9ii4O6QxNRuVppkaR8JsZ6LT8Cx9vBp0FJBU9DARFklVRjGjfWTOtY3pDLaZrTByOnpY9qfY4a2WCv0VctAKlXGH+rTyhR0Vx+y4fFL5eeVVZg4AFKoEvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717378230; c=relaxed/simple;
	bh=iTVP8HFRpDspCzQtZtfOWLoHx1WUVU/xxp/iKDtWq/c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ITfO85vYEmTTzkjFklOxPwLHKfw6TutPsTDQxIf0aC36QQPsOVdX11yZiaVEHpINdCE7Jc8YuW9pkNBdd5AWnhXzvopKysCRe1xGxgUEkfazYk+o4QP0a2K9NEtW5bMeLASV0SZYJEe1RrNvQeyExf53rkGaGjkQD9Ot4Lpxs+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEBAfjUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EDCEC2BBFC;
	Mon,  3 Jun 2024 01:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717378229;
	bh=iTVP8HFRpDspCzQtZtfOWLoHx1WUVU/xxp/iKDtWq/c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tEBAfjUtaZCd7VJLIHmu9knMz8gDVzlWrXUIfF4tmgU6XV7vOuaAPoqVG9WonQVpZ
	 yE1ytMODwREqiuZYz6SiUKe4GrhtcRXO2MOo4xn8THO17PCWo3/kfs/ygNuPP0OxJx
	 El9h1dz0rsFvXIXdYI5ftjAtqenktY5h4rsy0D56HA3ZlVQXr2J2ykiruyzoZ5zok2
	 dYmY1rJWVmYE6FizqcTpyrLwDCxXZ9dFRjEebmPzOzMFKrQLW8V30ZPoyX5AC/zJRk
	 bBXempPbLSl6SzBPbplwqIi7i8Q7rXtxVVAkGMYE1Dv8r1z5ghPSHi5gHWbJMYUkDp
	 iHIBoBvtZK3rg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 940AAD6191F;
	Mon,  3 Jun 2024 01:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/3] ChromeOS Embedded controller hwmon driver
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171737822960.30104.5438801510343944646.git-patchwork-notify@kernel.org>
Date: Mon, 03 Jun 2024 01:30:29 +0000
References: <20240529-cros_ec-hwmon-v4-0-5cdf0c5db50a@weissschuh.net>
In-Reply-To: <20240529-cros_ec-hwmon-v4-0-5cdf0c5db50a@weissschuh.net>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Clinux=40weissschuh=2Enet=3E?=@codeaurora.org
Cc: jdelvare@suse.com, linux@roeck-us.net, bleung@chromium.org,
 lee@kernel.org, tzungbi@kernel.org, groeck@chromium.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 chrome-platform@lists.linux.dev, dustin@howett.net,
 mario.limonciello@amd.com, mdf@kernel.org, s.horvath@outlook.com.au,
 paranjperajas@gmail.com

Hello:

This series was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Wed, 29 May 2024 08:27:10 +0200 you wrote:
> Add a hwmon driver that reports fan and temperature readings from the
> ChromeOS Embedded controller.
> 
> There was an earlier effort in 2017 to add such a driver [0], but there
> was no followup after v1.
> The new driver is complete reimplementation based on newer APIs and with
> more features (temp sensor names).
> 
> [...]

Here is the summary with links:
  - [v4,1/3] platform/chrome: cros_ec_proto: Introduce cros_ec_cmd_readmem()
    https://git.kernel.org/chrome-platform/c/a14a569a9918
  - [v4,2/3] hwmon: add ChromeOS EC driver
    https://git.kernel.org/chrome-platform/c/e8665a172378
  - [v4,3/3] mfd: cros_ec: Register hardware monitoring subdevice
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



