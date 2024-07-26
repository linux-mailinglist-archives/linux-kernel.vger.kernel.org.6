Return-Path: <linux-kernel+bounces-263235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C49B293D30A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C54A1F23052
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16A717B4F6;
	Fri, 26 Jul 2024 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="DaysyD4/"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C98F23775
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721997219; cv=none; b=KFjYBTlyuMIGvlIa1SoURZE/5pCbzAQOtHHpU+T4Jjtocq5gaVz3+zOlOFMPUeOdH8NeJ6SgzSDlKPQGdgy7Jy4OVr8Lig+zYVNuJ6shFZ9lOpqkZ8tlZiUknvNlgF7gwwex3tYy+TVgXjK8Dtf1y5P3BHaRaGyOttYgj1FDsG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721997219; c=relaxed/simple;
	bh=x2h+hV1i4vVwoVIPl828iHn2aaF/Y+V3DN3SUdgt03E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMrVu/udCwrYtV7uXHVpPgkugh+U0uve6QKpR9nvzk8+wNdjq2m3ZL3nUhfCnPJfaiaEMlbOwyRRYMph+z5zAvsNZTowWwFEinO41BqM2wUDZOTYSONHz2XSA8tFnVJ8XpQWbmwX27TZPvEiPdrVTumHGtXTckKUwRaicaBflD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=DaysyD4/; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1721997213;
	bh=0CQYTuAbtXWJMzojrrhLbDCjVXotwua4dV/X1XlkldI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DaysyD4/eDD2tnYTIcv/S+7wzGsYAp+/wUltbSpNoP75xznUqHrB8ed3+ze5jVDAl
	 eDSm02p7BKKw5rsV8HzKzM69QoFXBsRrVK9qdKci7yG2357rElxGWuveVvw45WcgGN
	 t1EpydXTuR/TMR6KSpK4XReI5Ex8Eyap4aL8iFfPloDvzkOvMpwW3vND4W6WMeTYhw
	 QntK1GWNI+W7g0BVzCafwHL/jYDrTc5HqPhZIDCox6Aiu1INQjrZsh8qXfzzx2WZrs
	 IZi2I0KwhegeAr0gBMZjSS1YdxlI3Nz3Dx5fRWNN3mP43I0OPq2NLl9gIGMYIF5aFt
	 CgyNKgorJhqFQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WVnH10hkrz4wbv;
	Fri, 26 Jul 2024 22:33:33 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <jk@ozlabs.org>,
	<arnd@arndb.de>,
	<geoff@infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] MAINTAINERS: Mark powerpc spufs as orphaned
Date: Fri, 26 Jul 2024 22:33:22 +1000
Message-ID: <20240726123322.1165562-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726123322.1165562-1-mpe@ellerman.id.au>
References: <20240726123322.1165562-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jeremy is no longer actively maintaining spufs, mark it as orphan.

Also drop the dead developerworks link.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Jeremy Kerr <jk@ozlabs.org>
---
 CREDITS     | 3 +++
 MAINTAINERS | 4 +---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/CREDITS b/CREDITS
index 65165dc80f04..d439f5a1bc00 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1872,6 +1872,9 @@ S: K osmidomkum 723
 S: 160 00 Praha 6
 S: Czech Republic
 
+N: Jeremy Kerr
+D: Maintainer of SPU File System
+
 N: Michael Kerrisk
 E: mtk.manpages@gmail.com
 W: https://man7.org/
diff --git a/MAINTAINERS b/MAINTAINERS
index ffcac216b57d..87a6fc8ccdba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21466,10 +21466,8 @@ F:	include/linux/spmi.h
 F:	include/trace/events/spmi.h
 
 SPU FILE SYSTEM
-M:	Jeremy Kerr <jk@ozlabs.org>
 L:	linuxppc-dev@lists.ozlabs.org
-S:	Supported
-W:	http://www.ibm.com/developerworks/power/cell/
+S:	Orphan
 F:	Documentation/filesystems/spufs/spufs.rst
 F:	arch/powerpc/platforms/cell/spufs/
 
-- 
2.45.2


