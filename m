Return-Path: <linux-kernel+bounces-286168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01585951779
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AAEB1F22FD7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BD1144D1A;
	Wed, 14 Aug 2024 09:16:55 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C6E219EA;
	Wed, 14 Aug 2024 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723627015; cv=none; b=kvn/x+43xDqzj0ML4eTTxx1mzoDEnj0rw8KFetrqxpWz3KTM+ZClgb227D4vc4Z3wUfEYsyvFXlFniAgIz156MKQJKH7zeTFIkHjarvf70w+p6XzsWMhTaeLD7L7B63a9ijKNl20Ga93QuRZPoEA2BahSw/jzE6EIr1mXv3Pc54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723627015; c=relaxed/simple;
	bh=GryCT9PDaGe3jzxXN03gCokofl1hwkYP+m19U9WqKKs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=suP3yyc3BisyyR3ryVZEWbcu0e6Ak4RiRg97OW4Y/HjTGQExU7dl16g+ZR68PeXWgmcVUZBN0o7NbiDHjtJeYGTVT+W1XA+Of7cr5juZPaJVNhd14XHD0tqex3TdaKm1vxdeFgUdMYoRPOmc+BMmysx9uPe9Hqd7ev9kwyO0lgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz13t1723626988tn0oe9
X-QQ-Originating-IP: JIcAc/P0dd4NRhc4oQ5LqiVXdn9a//DyJ5pDmMRsLGk=
Received: from HX01040022.powercore.com.cn ( [221.224.30.42])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 14 Aug 2024 17:16:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12501851135810784720
From: Jialong Yang <jialong.yang@shingroup.cn>
To: Jonathan Corbet <corbet@lwn.net>
Cc: luming.yu@shingroup.cn,
	shenghui.qu@shingroup.cn,
	Jialong Yang <jialong.yang@shingroup.cn>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs/dyndbg: fix the example using dyndbg option in modprobe
Date: Wed, 14 Aug 2024 17:16:16 +0800
Message-Id: <20240814091616.814761-1-jialong.yang@shingroup.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz8a-0

The old 'dyndbg==pmf' is not a right way to add dyndbg when modprobe.
It should be 'dyndbg=pmf'.

Signed-off-by: Jialong Yang <jialong.yang@shingroup.cn>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 0e9b48daf690..e589a6eea9d3 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -273,7 +273,7 @@ in the following order:
 
 3. args to modprobe::
 
-	modprobe foo dyndbg==pmf # override previous settings
+	modprobe foo dyndbg=pmf # override previous settings
 
 These ``dyndbg`` queries are applied in order, with last having final say.
 This allows boot args to override or modify those from ``/etc/modprobe.d``
-- 
2.34.1


