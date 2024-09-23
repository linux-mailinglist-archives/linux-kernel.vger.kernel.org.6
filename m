Return-Path: <linux-kernel+bounces-336066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 215D197EEB9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAE571F21B66
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C9D19E965;
	Mon, 23 Sep 2024 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsYoKEYE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81A0199EB4
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107192; cv=none; b=RnE5AP+O7mt27gOk+HTFRAV1oM/sJVYhzNof0kcrIXeZ52AielyjlM2nG4ZsrR6O7AF4X2/4Qwp7KbKrrm3hIfRuVRbfLm2CWDVMdu4bX/tYHOWmScYhHU+njkMiHmNDN5O49BayklZ/8QfCqk4fAlwSd0lZ6MP7WiGiEz9ARtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107192; c=relaxed/simple;
	bh=QuNvh5dZ+LMUahp/0Zyu3Kd4jjQY+UeL2VW7P5123Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uas4eh+FXHA5FeBSMjT95ifN0NlX/n5tG6MbmAXqi+Q9hSy3piamuOLueIi4QbH+99F+hQddrcvuoobWSmpsIgGepaVLDW5Yi4VCejzP/neTv8Z4Y9u1G/l1YFhdgEXZCDcSCQ07UPLqPNf90jP7UtT8IWTvBy9R59jYSgFV+QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsYoKEYE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DF4C4CEC4;
	Mon, 23 Sep 2024 15:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727107192;
	bh=QuNvh5dZ+LMUahp/0Zyu3Kd4jjQY+UeL2VW7P5123Yc=;
	h=Date:From:To:Cc:Subject:From;
	b=PsYoKEYExNRdrz7VSsmxxFUMIatGf4uiZus4p9xyYlgFKgKo1h8/w0zGWPBo7XsC8
	 3Ag7CRh4cCfyM9ab+dNrKpzoalu0y0UA3AlyMqb3Zbn6EW7Oqmux59DJpS3wwRwbxP
	 eBxGVlhmDIQJjpx5iBeviUJrCiwC0Z9UD+4josURItlLrZH61B8XreCNh49ZhzC+Zg
	 HbiDoNKSfLl8XGic1W3iz4SOaHdEVWKutU1SILw8oy0vQjL1bbONYAot0OvyN7cH7k
	 IVMUc4AEzUldeu2cwm0AO2bV1Oe/edAdQnOBitdevVmszszkZS+Ouvii70xbgyx/Jp
	 QK/pC9mHqSeng==
Date: Mon, 23 Sep 2024 16:59:48 +0100
From: Lee Jones <lee@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>
Subject: [GIT PULL] Backlight for v6.12
Message-ID: <20240923155948.GC7545@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Good afternoon Linus,

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-6.12

for you to fetch changes up to fea88a13a5d14b9f56fa338b47f2044806b3e64d:

  backlight: l4f00242t03: Add check for spi_setup (2024-08-01 13:40:14 +0100)

----------------------------------------------------------------
- Added a check for the return value of spi_setup() in the l4f00242t03 driver to catch errors.

----------------------------------------------------------------
Chen Ni (1):
      backlight: l4f00242t03: Add check for spi_setup

 drivers/video/backlight/l4f00242t03.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
Lee Jones [李琼斯]

