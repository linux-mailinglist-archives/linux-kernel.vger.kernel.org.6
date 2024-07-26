Return-Path: <linux-kernel+bounces-263234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0013793D309
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ADF3B21F5E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08AC17B42B;
	Fri, 26 Jul 2024 12:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="qHCk5Uk5"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF4D225D4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721997218; cv=none; b=YS3dYNOXXQGgXiZ2LqLwkSau1KBp7dlHFl2yvwiD0Q02z6q+4fvJ3yf7o0RRWjRYSxE78MF4EH7vIirzy9RSVjW+LqikHUVJjecew/PEs12eQsDrl45F41jzir7kYI21Xr4p0IcypvRCify4wKcBJemycWGNVRbnRqAIyD9+R3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721997218; c=relaxed/simple;
	bh=9AwvxDKcxMSyY6vyhYxfUTxHc6ihUCr5th64Ld2iVAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VhZ2mpqf4V97Yz1sI03nYXt/3mrA07KNy1ZHqphdTbFGOCBlYnf8/09cEPv1XwWVoS4EcwreaGAbQAxn7VbByAfjf0ELfsLdqI9Gm/sfsdNxONs6dRA51g9DVm+G7IYd3GfqxSsIFfarJRGtxIqK5Jpmy5xQgC6K1ZznSx27YuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=qHCk5Uk5; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1721997212;
	bh=oXZ8hTiXrr2J08JXPlzoc5NFFxRHlOc2DDFImDTZtXo=;
	h=From:To:Cc:Subject:Date:From;
	b=qHCk5Uk5s5D3p2MqHEuKDOqds6crPQNDeur4bA0eM72cW8ZI8uUNNMLpvnrYfpaKz
	 zZJpd0vmJFpehLiBeNwaWfkSEZJOt3rj98YcozrNq+OpHySIYGAPPVSircuyrfFo+L
	 d5dBieIUr7SnNZ0zRmiWhfgAhEmghKWoYrR7agOEsfbBXRaAVKdDJXWP9XKPcVgDWv
	 RtnHurGvUKvxODqr3ftY/E0Mv3jHwl6tIF3o+bQYu5t14UFbbiJQmQAhu2q9Lfcn+a
	 OWZprCEdr40iF/yY5qjK/uqcgr73AuccfLNNBDdbUVlJrDcvFL1w94ZP6iCYXWW0Q1
	 T65J960IbVVSA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WVnH044yKz4wb2;
	Fri, 26 Jul 2024 22:33:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <jk@ozlabs.org>,
	<arnd@arndb.de>,
	<geoff@infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] MAINTAINERS: Mark powerpc Cell as orphaned
Date: Fri, 26 Jul 2024 22:33:21 +1000
Message-ID: <20240726123322.1165562-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arnd is no longer actively maintaining Cell, mark it as orphan.

Also drop the dead developerworks link.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 CREDITS     | 3 +++
 MAINTAINERS | 4 +---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/CREDITS b/CREDITS
index 053e5a5003eb..65165dc80f04 100644
--- a/CREDITS
+++ b/CREDITS
@@ -378,6 +378,9 @@ S: 1549 Hiironen Rd.
 S: Brimson, MN  55602
 S: USA
 
+N: Arnd Bergmann
+D: Maintainer of Cell Broadband Engine Architecture
+
 N: Hennus Bergman
 P: 1024/77D50909 76 99 FD 31 91 E1 96 1C  90 BB 22 80 62 F6 BD 63
 D: Author and maintainer of the QIC-02 tape driver
diff --git a/MAINTAINERS b/MAINTAINERS
index 07f753f039d2..ffcac216b57d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5087,10 +5087,8 @@ F:	Documentation/devicetree/bindings/media/cec/cec-gpio.yaml
 F:	drivers/media/cec/platform/cec-gpio/
 
 CELL BROADBAND ENGINE ARCHITECTURE
-M:	Arnd Bergmann <arnd@arndb.de>
 L:	linuxppc-dev@lists.ozlabs.org
-S:	Supported
-W:	http://www.ibm.com/developerworks/power/cell/
+S:	Orphan
 F:	arch/powerpc/include/asm/cell*.h
 F:	arch/powerpc/include/asm/spu*.h
 F:	arch/powerpc/include/uapi/asm/spu*.h
-- 
2.45.2


