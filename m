Return-Path: <linux-kernel+bounces-560952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 246ACA60B6D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2B319C54EA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4177C1A3174;
	Fri, 14 Mar 2025 08:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkQGGy26"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919F11ACEA5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940872; cv=none; b=fOcGbfQrpopEWuTUtLgjZMsBPBMuSRMzEgCZfMG5C4F0qByGaUMYT0IY54Yxgbc5A+Guy43fXYoIUSJnjwgeEGQpKIo54V/738ih1OdLngP8HDvaBdWhi4G62dwSiZenNc/FHshd5YmvLfnfhKZCLhrwQWjwKdCpmxc+cCBMfNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940872; c=relaxed/simple;
	bh=ST0ZYCW8jN149A5ml72oZoOSSrjurqVZ9DLP9wFKBGY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dd2D5MHqWhGkYGdqbuD/dk2Vol1CrRhPEonSpoxKBwH2mYf+p1gun2e8jk6BKFyjPH9Op8NgFpGy/M5fFqWbLLQHdXmLVultHQ2+rUiN60QYvBetdf2KkWp+RPOZ3rpIpja1mC+AVfvI+cZRgMhQ7igzwJeo+kHzAfeBzucr1Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkQGGy26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A938C4AF0D;
	Fri, 14 Mar 2025 08:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741940872;
	bh=ST0ZYCW8jN149A5ml72oZoOSSrjurqVZ9DLP9wFKBGY=;
	h=Date:From:To:Cc:Subject:From;
	b=rkQGGy26LO8E2oSDX6DI2l0yMInAdP9mkVisFXYzkT3iwbDL7UGWxCqUkPJGeUIGg
	 dbMSp98tdj2HxmGH++We58vRJLCtzEBsGNd8LaRMCZsFPkbTtDHRzk2z6XVjWnGmJv
	 p6WwzCegWG/nPl0EPEpykZaLAGQ0sCo5wvykco5PVw7sb0dbUynr0AWYaVTn0uP8lc
	 SR8gbCyekuTr32yhhGKD2Ng20zr/fACj6Az2E9+pBxYXKP0A4W9cM/Nnwq7bO6XUIi
	 YLDdS/MYZyZw3OPxXWTExPa8f0YQLrvK2Ed5BzJrY8aC8Tffm1xThllHf7SVaR8zx5
	 sX1+iYgWYWTQA==
Date: Fri, 14 Mar 2025 08:27:48 +0000
From: Lee Jones <lee@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pavel Machek <pavel@ucw.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] LEDs fixes for v6.14
Message-ID: <20250314082748.GI3645863@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Good morning Linus,

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/leds.git tags/leds-fixes-6.14

for you to fetch changes up to c72e455b89f216b43cd0dbb518036ec4c98f5c46:

  leds: leds-st1202: Fix NULL pointer access on race condition (2025-02-28 09:18:37 +0000)

----------------------------------------------------------------
- Fix NULL pointer in STMicroelectronics LED1202 LED support

----------------------------------------------------------------
Manuel Fombuena (1):
      leds: leds-st1202: Fix NULL pointer access on race condition

 drivers/leds/leds-st1202.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

-- 
Lee Jones [李琼斯]

