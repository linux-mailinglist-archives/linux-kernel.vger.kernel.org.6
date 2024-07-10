Return-Path: <linux-kernel+bounces-248057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA58B92D7D1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4381C21343
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759E01957ED;
	Wed, 10 Jul 2024 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="XxZjmqz/"
Received: from smtp120.iad3b.emailsrvr.com (smtp120.iad3b.emailsrvr.com [146.20.161.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD17E848E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720634225; cv=none; b=QR9SyKcVdizDgKGKbdi3EaOnRiqOCl9S/2voxBpwJiQSlCAvKW2hvXj1sflmfVUd6u8WHZrbJV3R3zwReLFUYzUi8nCx7YAOV6vRAiU15OMEFvvsvGN5WzGHASaoCjXKebIWLXC1XeVFthuWDRAhTMiTFXliLNbk7TqdKXBAIcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720634225; c=relaxed/simple;
	bh=+rdEet2a03M3feNf2DDNH4FKyG5Yx6JcUFaF8Zfe/R0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YEPIp08QwevYEnlnXg6PhKmNCsuDitqhPv3Mqe7sBy7ulziezN7xZe/veOiJrJUfWgYYMUgr17zXwy/JDx+3RipLtcAffpMrRZmWx9iIlfIBqFrNoW5Mu1JiwlwZmNcIllJCHJrJUd39ZEF5sPUFiK/BxcXe2dBVUk++PYtCG+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=XxZjmqz/; arc=none smtp.client-ip=146.20.161.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1720633049;
	bh=+rdEet2a03M3feNf2DDNH4FKyG5Yx6JcUFaF8Zfe/R0=;
	h=From:To:Subject:Date:From;
	b=XxZjmqz/1ZqmGQbYAVaSH4sxNTDmUeZhFMD9l7v1RqfGU/Vk10LqFEErBV3NC+9gs
	 1QH/FJ5iUn6TQRXjQk+i6lLpWVEIzIf76BAKsw3V9hXoqVE/0x32d07+PrlwOhiZv8
	 F7L0wAz+l4Z23mRnpnHM6FM/0X+Tpx2x0iM9C/kI=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp16.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id DC399C019C;
	Wed, 10 Jul 2024 13:37:28 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Mirsad Todorovac <mtodorovac69@gmail.com>
Subject: [PATCH] staging: comedi: ni_*: do not declare unused variable range_ni_E_ao_ext
Date: Wed, 10 Jul 2024 18:37:19 +0100
Message-ID: <20240710173719.3559437-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 3d444693-b8ce-4e33-8baf-6beb2feabbf9-1-1

Mirsad Todorovac reported a compiler warning in "ni_stc.h" due to the
variable `range_ni_E_ao_ext` being defined but unused when building the
"ni_routes_test" module.

The `range_ni_E_ao_ext` variable is tentatively defined in "ni_stc.h"
(with internal linkage) and fully defined in "ni_mio_common.c".
"ni_stc.h" and/or "ni_mio_common.c" are included by the "ni_atmio",
"ni_pcimio", "ni_mio_cs", and "ni_routes_test" modules, which will each
get their own local `range_ni_E_ao_ext` variable defined.  However, it
is not used by the "ni_mio_cs" or "ni_routes_test" modules.  They should
get optimized out, but there are compiler warnings about the unused
variable when built with the `W=1` option.

Move the full definition of the variable from "ni_mio_common.c" into the
places where it is used, namely "ni_atmio.c" and "ni_pcimio.c", and
remove the tentative definition of the variable from "ni_stc.h".  This
fixes the compiler warnings.

Reported-by: Mirsad Todorovac <mtodorovac69@gmail.com>
Link: https://lore.kernel.org/lkml/3bab8580-c01a-4183-94af-ba3193c94c0e@gmail.com/
Cc: Mirsad Todorovac <mtodorovac69@gmail.com>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
Note: The linked report also covers similar warnings elsewhere in the
kernel, so is not closed by this patch.
---
 drivers/comedi/drivers/ni_atmio.c      | 9 +++++++++
 drivers/comedi/drivers/ni_mio_common.c | 9 ---------
 drivers/comedi/drivers/ni_pcimio.c     | 9 +++++++++
 drivers/comedi/drivers/ni_stc.h        | 2 --
 4 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/comedi/drivers/ni_atmio.c b/drivers/comedi/drivers/ni_atmio.c
index 8876a1d24c56..330ae1c58800 100644
--- a/drivers/comedi/drivers/ni_atmio.c
+++ b/drivers/comedi/drivers/ni_atmio.c
@@ -79,6 +79,15 @@
 
 #include "ni_stc.h"
 
+static const struct comedi_lrange range_ni_E_ao_ext = {
+	4, {
+		BIP_RANGE(10),
+		UNI_RANGE(10),
+		RANGE_ext(-1, 1),
+		RANGE_ext(0, 1)
+	}
+};
+
 /* AT specific setup */
 static const struct ni_board_struct ni_boards[] = {
 	{
diff --git a/drivers/comedi/drivers/ni_mio_common.c b/drivers/comedi/drivers/ni_mio_common.c
index 980f309d6de7..3acb449d293c 100644
--- a/drivers/comedi/drivers/ni_mio_common.c
+++ b/drivers/comedi/drivers/ni_mio_common.c
@@ -166,15 +166,6 @@ static const struct comedi_lrange range_ni_M_ai_628x = {
 	}
 };
 
-static const struct comedi_lrange range_ni_E_ao_ext = {
-	4, {
-		BIP_RANGE(10),
-		UNI_RANGE(10),
-		RANGE_ext(-1, 1),
-		RANGE_ext(0, 1)
-	}
-};
-
 static const struct comedi_lrange *const ni_range_lkup[] = {
 	[ai_gain_16] = &range_ni_E_ai,
 	[ai_gain_8] = &range_ni_E_ai_limited,
diff --git a/drivers/comedi/drivers/ni_pcimio.c b/drivers/comedi/drivers/ni_pcimio.c
index 0b055321023d..f63c390314e1 100644
--- a/drivers/comedi/drivers/ni_pcimio.c
+++ b/drivers/comedi/drivers/ni_pcimio.c
@@ -102,6 +102,15 @@
 
 #define PCIDMA
 
+static const struct comedi_lrange range_ni_E_ao_ext = {
+	4, {
+		BIP_RANGE(10),
+		UNI_RANGE(10),
+		RANGE_ext(-1, 1),
+		RANGE_ext(0, 1)
+	}
+};
+
 /*
  * These are not all the possible ao ranges for 628x boards.
  * They can do OFFSET +- REFERENCE where OFFSET can be
diff --git a/drivers/comedi/drivers/ni_stc.h b/drivers/comedi/drivers/ni_stc.h
index fbc0b753a0f5..7837e4683c6d 100644
--- a/drivers/comedi/drivers/ni_stc.h
+++ b/drivers/comedi/drivers/ni_stc.h
@@ -1137,6 +1137,4 @@ struct ni_private {
 	u8 rgout0_usage;
 };
 
-static const struct comedi_lrange range_ni_E_ao_ext;
-
 #endif /* _COMEDI_NI_STC_H */
-- 
2.43.0


