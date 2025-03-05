Return-Path: <linux-kernel+bounces-546283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D657DA4F8B9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FDFF18925AD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40E31FC10D;
	Wed,  5 Mar 2025 08:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="OxY4WVQB"
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482A91EF0BC
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.177.23.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741163089; cv=none; b=PD2aklHc1LHq87uDYMF7MrkgUP79U7HKrwsxPqu8JkGn6hCPnBiKHuO1GaRItxJYjDlYQs/YK+svfJvh6KeYIFxrVSgCh8SYrLxuFNZzS2MJ890EMC5w69BDkjg+o5uBwWezyAQwX4QaEmHnpZoQhwx3lkRPlFSR9+o86tezW/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741163089; c=relaxed/simple;
	bh=SUlXVlYIW5qTTMDOoeZryT71CD0diYOGFhDZkXZgYEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SYvQ7MCjyzJzjZuptlQ9f5DM3Biv4Hjb5qIDaJ7CDQ8zMePiTRfWxKfyzn4jBCMyAQfDi5gGSVUcHlczyuYcuIwO2pVryUtXCIbwU8LvSCsRpnL2/rmAV1AT06C9Jr7H3qT4olc3wCM1bmy8SOwPRZEngRYPBhymXSHMiXifW18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=OxY4WVQB; arc=none smtp.client-ip=89.177.23.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Received: from localhost.localdomain (office.icewarp.com [82.113.48.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 0412E1665C2;
	Wed,  5 Mar 2025 09:24:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1741163079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vLo8gFl/MA2O78aDwF72s8ar+yjNlqf/DNiF5u0a+jg=;
	b=OxY4WVQBz9BhBOOd/sCRYTTvcJqkLFQCiwRnwWLqg7mfSzC1VbGG5K3Zg9bwu9uBhGmDPx
	REBOHMESZllrlU/NfsbCFDotwLEC0Fs0RtAWApboRZVNXMD3TiP9g1g9AsVQ3M2Ezjf5pF
	ntoML2azYpOTFo+hrkwgXo/VRWbJyrE=
From: David Heidelberg <david@ixit.cz>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	David Heidelberg <david@ixit.cz>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] media: MAINTAINERS: correct docs filepath ov7670 after rename
Date: Wed,  5 Mar 2025 09:24:27 +0100
Message-ID: <20250305082432.54573-1-david@ixit.cz>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

File was renamed.

Fixes: bcf999e34bc7 ("media: dt-bindings: media: i2c: align filenames format with standard")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503050359.6DYrXi6o-lkp@intel.com/
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git ./MAINTAINERS ./MAINTAINERS
index 06152b9425b5a..71f1ba8c87fd3 100644
--- ./MAINTAINERS
+++ ./MAINTAINERS
@@ -17506,7 +17506,7 @@ OMNIVISION OV7670 SENSOR DRIVER
 L:	linux-media@vger.kernel.org
 S:	Orphan
 T:	git git://linuxtv.org/media.git
-F:	Documentation/devicetree/bindings/media/i2c/ov7670.txt
+F:	Documentation/devicetree/bindings/media/i2c/ovti,ov7670.txt
 F:	drivers/media/i2c/ov7670.c
 
 OMNIVISION OV772x SENSOR DRIVER
-- 
2.47.2


