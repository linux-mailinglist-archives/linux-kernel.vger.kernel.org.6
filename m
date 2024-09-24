Return-Path: <linux-kernel+bounces-336475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DB7983B4A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 04:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CE731F235A2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 02:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCDDEAD7;
	Tue, 24 Sep 2024 02:45:48 +0000 (UTC)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F3CC133;
	Tue, 24 Sep 2024 02:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727145948; cv=none; b=q4K0SF5oJi09T/5Qj2PNU4ArP7YJQ+UewKyWRxkixiGfA4AZ2GwFGPZx5dpnb6hpR/Tt/X5+BpuC93wvwAVS+W7MWHo3m4BFE44/USXu9soz7HADpTektMfTd48K5A42d2g7I12+lCxfiXqUbFwwhHQPNrXUOa4m1HqWopkCmH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727145948; c=relaxed/simple;
	bh=zLObBDzylKWSNZ6CMbWnuhKeN3LdJU8mNABA2JobP/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PEL6xcYCruEYt9CHOtuuomWSLr1kB1gy4XgzMkSaBp/iESf0hXiQ2Gs/Hdh161gmNHOt3ncvdyoyq7DLgXWJ0xXaL8vlTaY7jbYuQDtPC4Xg2YL7UotG0iRSq44p19df/Nui5oCxAkRMGitphWDDD0As66AtOvFDvAtaTvbrg9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cdjrlc.com; spf=pass smtp.mailfrom=cdjrlc.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cdjrlc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdjrlc.com
X-QQ-mid: bizesmtp84t1727145925t9as3lz0
X-QQ-Originating-IP: 0OoMMaGNrfWw5XRlrUKUEIEAsvQv8NhpXr+cy1pAm00=
Received: from localhost.localdomain ( [182.148.12.188])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 24 Sep 2024 10:45:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12762500620221567328
From: xujianghui <xujianghui@cdjrlc.com>
To: guoren@kernel.org,
	linux-csky@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: xujianghui <xujianghui@cdjrlc.com>
Subject: [PATCH] csky: Fix the following errors reported by checkpatch:
Date: Tue, 24 Sep 2024 10:44:35 +0800
Message-ID: <2595426A1FD05BD9+20240924024437.63062-1-xujianghui@cdjrlc.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvrsz:qybglogicsvrsz4a-0

ERROR: spaces required around that ':' (ctx:VxE)

Signed-off-by: xujianghui <xujianghui@cdjrlc.com>
---
 arch/csky/abiv2/inc/abi/entry.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/abiv2/inc/abi/entry.h b/arch/csky/abiv2/inc/abi/entry.h
index cca63e699b58..6085fbff2900 100644
--- a/arch/csky/abiv2/inc/abi/entry.h
+++ b/arch/csky/abiv2/inc/abi/entry.h
@@ -39,9 +39,9 @@
 	bf      1f
 	addi    lr, sp, 152
 	br	2f
-1:
+1 :
 	mfcr	lr, usp
-2:
+2 :
 	stw	lr, (sp, 16)
 
 	stw     a0, (sp, 20)
-- 
2.46.0


