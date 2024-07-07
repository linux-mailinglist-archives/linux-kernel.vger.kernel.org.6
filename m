Return-Path: <linux-kernel+bounces-243649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0DC9298C7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 18:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2C1282496
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 16:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340E118E28;
	Sun,  7 Jul 2024 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uuQa9TWX"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77451BDDB
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720368936; cv=none; b=G5wBJPjh/m5cJJ8yDvANM9DrfLLFYRWeXz31pvSYdzfyq4Ba+yB3BpC0PO5dVNiLPlYT3KdmFdZ/vmG3ETkY9IBKTNuXGzvNVj++yXfjvP0Uubkt+QlKkA1ZFuTkGxMLhKYOObZgqEyqAM/9wEa7RV+kcafaST6hmbzlIbSfcD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720368936; c=relaxed/simple;
	bh=CcbO9mal7o4Z7kla4wUPITnR5YQHnXSLPu+2L8jeCdg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=J8ADh3XaxlGqF5xE9IQm8CSV6c+92KkOobfPUp8gcZOucTCJEryzaNme6EgLDGwJsVXfWAioXT4qeaNkpxR1ur5xRtcU5z3BdbwsvM5hZLZl4jayxYQ8svghT2hHEYVfPtRs7eW/OBftuGXZ6Y3hbXBlBsMattT0u6M7qq0gZx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uuQa9TWX; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-doc@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720368931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oAnCpXFlsaLK2Hpd3SeRhOA5IpW0O6zNcEfcdZMEQSk=;
	b=uuQa9TWXoIs9yAe7ahCoMSjVY4saRRbwkkGbrc6H/NNFhNzjCr3xSmsvnI2cxG49eLiI5U
	WkJSK4pmkd/m3EcL1AZLsD+vpEkrcYSRJED01oVRu8utaSWwQajeYYdmILCpSpidgcae/g
	WVo8QRMcKLaasoM5bukSQBej0IyMDpM=
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: alexs@kernel.org
X-Envelope-To: siyanteng@loongson.cn
X-Envelope-To: corbet@lwn.net
X-Envelope-To: zenghui.yu@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alexs@kernel.org,
	siyanteng@loongson.cn,
	corbet@lwn.net,
	Zenghui Yu <zenghui.yu@linux.dev>
Subject: [PATCH] docs/zh_CN/virt: Update the translation of guest-halt-polling.rst
Date: Mon,  8 Jul 2024 00:14:44 +0800
Message-Id: <20240707161444.98715-1-zenghui.yu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Update to commit 1954d51592b5 ("Documentation: virt: correct location of
haltpoll module params") to fix the obvious mistake.

Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
---
 Documentation/translations/zh_CN/virt/guest-halt-polling.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/virt/guest-halt-polling.rst b/Documentation/translations/zh_CN/virt/guest-halt-polling.rst
index b798d1cf0b48..463d1d829062 100644
--- a/Documentation/translations/zh_CN/virt/guest-halt-polling.rst
+++ b/Documentation/translations/zh_CN/virt/guest-halt-polling.rst
@@ -76,7 +76,7 @@ guest_halt_poll_ns将保持高位）。
 
 默认值: Y
 
-模块参数可以从Debugfs文件中设置，在::
+模块参数可以从sysfs文件中设置，在::
 
 	/sys/module/haltpoll/parameters/
 
-- 
2.34.1


