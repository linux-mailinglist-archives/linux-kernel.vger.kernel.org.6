Return-Path: <linux-kernel+bounces-258196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD04F9384DD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 15:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F6228196D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 13:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DA616849A;
	Sun, 21 Jul 2024 13:44:05 +0000 (UTC)
Received: from mailscanner01.zoner.fi (mailscanner01.zoner.fi [84.34.166.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AFA1662FE
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 13:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.34.166.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721569444; cv=none; b=rGKHrFpIww0s/WnYRThrF7l5EYu7nE0mwGHqHtKWUk9X/MZNKN0X7fPoZDikfZjgauFCwhucweD3JyeP5x8nw/GTIEGDQgDB6JXYI2a/DXU0LgewfACue6c8k9y2gKs2a8F3jU54A/IwrtIqknsdT8vESvqX6Rpbt2r69RL3tjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721569444; c=relaxed/simple;
	bh=ndvdOLq0DktuSQoFvn56HwbkcSjTS8oZucP7FTz+fLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTCjOgOcUs7mBZBe8JmfaODFy9NpjOj7mjO32YGSZTP4r8vzhuEvAq1gXPmaGwHuPLiGLfBWFBXLVpsCsz6YMUsVgesECjaLvpcSyRNPPnEvWHEtSp3lYX12ZO5mu17denIEhqROchryFSLS35xYHZFv9tRoZiTwseX3WwGfLT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org; spf=pass smtp.mailfrom=tukaani.org; arc=none smtp.client-ip=84.34.166.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tukaani.org
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
	by mailscanner01.zoner.fi (Postfix) with ESMTPS id CAC6D42A05;
	Sun, 21 Jul 2024 16:37:03 +0300 (EEST)
Received: from mail.zoner.fi ([84.34.147.244])
	by www25.zoner.fi with esmtp (Exim 4.97.1)
	(envelope-from <lasse.collin@tukaani.org>)
	id 1sVWkG-00000001SjJ-1mTp;
	Sun, 21 Jul 2024 16:37:03 +0300
From: Lasse Collin <lasse.collin@tukaani.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lasse Collin <lasse.collin@tukaani.org>,
	Sam James <sam@gentoo.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/16] MAINTAINERS: Add XZ Embedded maintainer
Date: Sun, 21 Jul 2024 16:36:16 +0300
Message-ID: <20240721133633.47721-2-lasse.collin@tukaani.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240721133633.47721-1-lasse.collin@tukaani.org>
References: <20240721133633.47721-1-lasse.collin@tukaani.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have been the maintainer of the upstream project since I submitted
the code to Linux in 2010 but I forgot to add myself to MAINTAINERS.

Reviewed-by: Sam James <sam@gentoo.org>
Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ce06ad40768..1bf4fc70580e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25146,6 +25146,19 @@ S:	Maintained
 F:	drivers/spi/spi-xtensa-xtfpga.c
 F:	sound/soc/xtensa/xtfpga-i2s.c
 
+XZ EMBEDDED
+M:	Lasse Collin <lasse.collin@tukaani.org>
+S:	Maintained
+W:	https://tukaani.org/xz/embedded.html
+B:	https://github.com/tukaani-project/xz-embedded/issues
+C:	irc://irc.libera.chat/tukaani
+F:	Documentation/staging/xz.rst
+F:	include/linux/decompress/unxz.h
+F:	include/linux/xz.h
+F:	lib/decompress_unxz.c
+F:	lib/xz/
+F:	scripts/xz_wrap.sh
+
 YAM DRIVER FOR AX.25
 M:	Jean-Paul Roubelat <jpr@f6fbb.org>
 L:	linux-hams@vger.kernel.org
-- 
2.45.2


