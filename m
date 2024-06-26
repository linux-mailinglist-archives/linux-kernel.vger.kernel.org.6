Return-Path: <linux-kernel+bounces-230313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC64917B29
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659361F258F1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E5716849A;
	Wed, 26 Jun 2024 08:41:58 +0000 (UTC)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F88A161304
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391318; cv=none; b=VtxMRuv3Ol9dtAyWcBcxnsay/dw6CPJIm0zvXJZPrGT2zdSRb0LGi479JyNmJjuz2LHXA6OZHN5ZgDQFKJDirbtxrLt8gncdCH0xqfNCurWiJW7knobxoqmxVyPfH981zSHRwbjTujzT1rFPXiGNc/Y/bk+BFVDh0Uy98XAVa60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391318; c=relaxed/simple;
	bh=3nOK4BeLNH28VmMIO7giZ32TCzmZKakFp6UpEuQbkjk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UcHbOw58OVY7RX4LnCv+MOG/Fc4KMa7igpNgIv4S0dMchNgJPlY6E6a6Hu7uF6pdL8R6QXq1p9HNbnoSyHUgp8B6zPpriFOjlLCY0PBzBuJVnisdlsvNCj6Mykf907G+9kYCFLymFDppIA1RkRQnGIEFyUtGOhyP3dgrN89YBc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:1dff:b715:1a2c:c3f5])
	by andre.telenet-ops.be with bizsmtp
	id g8hm2C00N0lK4vA018hmZ4; Wed, 26 Jun 2024 10:41:47 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sMODm-000OVm-F6;
	Wed, 26 Jun 2024 10:41:46 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sMODq-00Aond-90;
	Wed, 26 Jun 2024 10:41:46 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jocelyn Falempe <jfalempe@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] drm/panic: Miscellaneous fixes
Date: Wed, 26 Jun 2024 10:41:43 +0200
Message-Id: <cover.1719391132.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

Here are two more fixes for the DRM panic code.

Thanks for your comments!

Geert Uytterhoeven (2):
  drm/panic: Do not select DRM_KMS_HELPER
  drm/panic: Restrict graphical logo handling to built-in

 drivers/gpu/drm/Kconfig     | 1 -
 drivers/gpu/drm/drm_panic.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

