Return-Path: <linux-kernel+bounces-343848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF6C98A047
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2311C21870
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB6718FDC1;
	Mon, 30 Sep 2024 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="qIXLThFI"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE20A18E353;
	Mon, 30 Sep 2024 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695304; cv=none; b=EL8APjZquGcrb9wu9wSnp6htSCA8UWgBhbxpbPkegdYUkARo7U73C+zTDYVHx/wSSOwFzGl+cqApdIDRCAJtB2CXQTHOYS2nvzHhPo1sjdYVkmZLRFWWQUZaXjaJv7J2DcLQ9/r7t8fIE7C/c4Cs0aJk2JPL0pzZo8Wepm2d6Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695304; c=relaxed/simple;
	bh=ZKIdBvg0XfHQeeNADAjHuTf7ISp5KDJYmee75STkPA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kj8+HGkGMOsvfWMXLJp6mIR1BBopMtKObeHpn/+5qoqgjb4JJtPfDRc/QSs549K5Qnyy/EGqfhobUtAfBNlKOhJ5nAnlMMDy+wyZw6vJh9iGit7F44zKl+F0tMC42wBV+k92xzu/uw58lG0NCGvfJiLQkckjqVipX2ZhTWdPaOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=qIXLThFI; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2hxG1g3cOKJlN2RPAaXydYEmIYK9K+T9mzJp0NThAXY=;
  b=qIXLThFIqlZ/c8Mj3k4girkC1HmIgQ0ZCZRgEaOJGwUTbsWt7aQ/DRXj
   NGTXrBIKpbxV3sjax+V2s6XcqHMuUrKT9s2kzpwQwia4EWxJHHDmDX6/z
   gQ5Hj6n9joa3tnQ9v7ixKE9ReOksjgE0x4dxdlrB9QrpbsNvmcbGjkpZ7
   g=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,165,1725314400"; 
   d="scan'208";a="185956873"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:21:26 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Jaroslav Kysela <perex@perex.cz>
Cc: kernel-janitors@vger.kernel.org,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/35] ALSA: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 13:20:50 +0200
Message-Id: <20240930112121.95324-5-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize kerneldoc parameter names to match the parameter
order in the function header.

Problems identified using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 sound/pci/hda/hda_codec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 3dd1bda0c5c6..14763c0f31ad 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1734,9 +1734,9 @@ EXPORT_SYMBOL_GPL(snd_hda_ctl_add);
 /**
  * snd_hda_add_nid - Assign a NID to a control element
  * @codec: HD-audio codec
- * @nid: corresponding NID (optional)
  * @kctl: the control element to assign
  * @index: index to kctl
+ * @nid: corresponding NID (optional)
  *
  * Add the given control element to an array inside the codec instance.
  * This function is used when #snd_hda_ctl_add cannot be used for 1:1


