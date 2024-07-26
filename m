Return-Path: <linux-kernel+bounces-263627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B0F93D86B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964001C2353F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D813D69;
	Fri, 26 Jul 2024 18:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vi9Furx7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D513BBCB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722019110; cv=none; b=GEt5wNE0D17jXLiQLxZ+0t1aT2As1qF5GSeTy9nPgZqddRs2SxTPzmXv66yvCZ+L6dim+LclVa0d7KTtBON1mHbqP5UEOjy3k7/5Pa+kPiQOSrwXwV/JzX7DcPToO1wdyoYVD/nivCGrEgGGLqIGO0gGkHCN4jn4CcxcSoUi9+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722019110; c=relaxed/simple;
	bh=xT8o0jActOY7IiurUCAv9FxLZTNeJvdHnNoF8V2JCvk=;
	h=Message-ID:From:To:Cc:Subject:Date; b=bUk66Z+JQCVC/Shd5eJFSzaL41BhK+EKP4Si7piqX5ecjU/uSlTw9Rscex/tXfaxWP1Vk6gVDyYcLi2BncPtz8waTkOLFq+0EQ4aWWs0QXPSR/C0G5SIJSLkzsj7gXmSFVg9dtrcj8SYHYVnUgQVsJ9iEPcURaJUl0L1ndzaLp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vi9Furx7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C844C32782;
	Fri, 26 Jul 2024 18:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722019109;
	bh=xT8o0jActOY7IiurUCAv9FxLZTNeJvdHnNoF8V2JCvk=;
	h=From:To:Cc:Subject:Date:From;
	b=Vi9Furx72zjNGpq0zoPNeg3PxeotnWihip7F06vbPr8i/4f+mxw6LAgH/K0y5NknK
	 4+Blg2WBwdM4L2KSsFMh8/nxgHCQH+gEZmiWNgmxVNIW5a3O0n6EXFmsKgQ4Y8ai0o
	 lyooHqnGzNfciIZp9h6T9Pa56bPEbx3tlXE0ChdB4B59v4yApDQp9RdSkDLa55qXkS
	 /9HcU8e1aBVh7pmtkCGcaoosveWadWee1HeQLVE2cWdrIIEiFVsu3MNiqnOFnK7p92
	 eAWSHvnnrK0cS/0hYLgYFHAJ4qgMMcUSm4SdW0J0HMoDSlHbA1yDCyMIxZovPbs1PH
	 tAC3/nxUMqkcA==
Message-ID: <ba78d28fa3c92baae955e331c2f7a3f9.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap fixes for v6.11-merge-window
Date: Fri, 26 Jul 2024 19:38:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit c2bb8198fee88a428513f8d023c627ecd13aa694:

  regmap: kunit: Add test cases for regmap_multi_reg_(read,write}() (2024-07-11 12:45:55 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.11-merge-window

for you to fetch changes up to 542440fd7b30983cae23e32bd22f69a076ec7ef4:

  regmap: maple: work around gcc-14.1 false-positive warning (2024-07-22 13:04:04 +0100)

----------------------------------------------------------------
regmap: Fix for v6.11

Arnd sent a workaround for a false positive warning which was showing up
with GCC 14.1.

----------------------------------------------------------------
Arnd Bergmann (1):
      regmap: maple: work around gcc-14.1 false-positive warning

 drivers/base/regmap/regcache-maple.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

