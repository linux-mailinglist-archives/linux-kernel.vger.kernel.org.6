Return-Path: <linux-kernel+bounces-196034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0638D564D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B179128668A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1791761BD;
	Thu, 30 May 2024 23:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="esUb50Bs"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B78482D7
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717112083; cv=none; b=uE0mKevlifyjMEMq/g9HL3TLzicax+e4s6ZXCrSIUix+3eMmj9wPohCWKIDxJXKzD2kgdo21qo4y7kEWKTsxSX0sMPoZy4iNwN5SlJCTjzNtoYbQQmwO99glj+lw/Vtor/0sNw1pVf/HSxOmEXs/5Ivy9HN6Si1XPgota0wpw4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717112083; c=relaxed/simple;
	bh=Ofp/kAf6H3cCSHeeDszGKCxLsP0u8/7a/2csMxuity8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d/cRvo39v87B4Atf66X5xxgaC1DQtJHyqgIxWQ37DS1mFveTKkinBCIcDUF9+0y26KAnZjGX6yKNasarZ9nSetuXD6XqzYRYhZaH95QM97VeeJINntnPPcccFR7im19HjIystHcXsNRDtorCd5mknj9Eqa/jWrqcuY8SaDv5sG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=esUb50Bs; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=43Y5SDVjosLLX/1DA4WmaYI8KLnW+maYA9TjmHM2Xr0=; b=esUb50BsXuX3kbQe
	Y/CuQTUNjCKz0giZJW23mmVlXp+r5VU7eq8yNSyzRoKKXKBbetjxfMUR2Opq3zAN3Z8W0lMrG0yp7
	QLNYRd3ll503CZRdAXKgUNASPNFnM8fxJ/sbCIftV2eIfZ6HAGn+WBJNK8D0AKEOrAfs4yT2gIx2z
	hheSLfmDt2xvQwnkdYuCff14oO6RNtL2oDuOVShib2AqtOqxSpIvrvehFHF68axHEAc+GIMUZgoAr
	0EBjIito5zoRukZNp4jlfiG/3B5s2aQ9JIjnMVx6rDoG8k4SoMvR1e3c1AhcKRQa1R6s0YLss8h+f
	StnLmSWKEcl2qLcklA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sCpI5-003SqY-16;
	Thu, 30 May 2024 23:34:37 +0000
From: linux@treblig.org
To: nipun.gupta@amd.com,
	nikhil.agarwal@amd.com
Cc: abhijit.gangurde@amd.com,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] cdx: remove unused struct 'cdx_mcdi_copy_buffer'
Date: Fri, 31 May 2024 00:34:36 +0100
Message-ID: <20240530233436.224461-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'cdx_mcdi_copy_buffer' has been unused since the original
commit eb96b740192b ("cdx: add MCDI protocol interface for firmware
interaction").

Looking at lkml,  it was used in the V1 posting but was removed
somewhere before V6.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/cdx/controller/mcdi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cdx/controller/mcdi.c b/drivers/cdx/controller/mcdi.c
index 1eedc5eeb315..e760f8d347cc 100644
--- a/drivers/cdx/controller/mcdi.c
+++ b/drivers/cdx/controller/mcdi.c
@@ -27,10 +27,6 @@
 #include "bitfield.h"
 #include "mcdi.h"
 
-struct cdx_mcdi_copy_buffer {
-	struct cdx_dword buffer[DIV_ROUND_UP(MCDI_CTL_SDU_LEN_MAX, 4)];
-};
-
 static void cdx_mcdi_cancel_cmd(struct cdx_mcdi *cdx, struct cdx_mcdi_cmd *cmd);
 static void cdx_mcdi_wait_for_cleanup(struct cdx_mcdi *cdx);
 static int cdx_mcdi_rpc_async_internal(struct cdx_mcdi *cdx,
-- 
2.45.1


