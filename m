Return-Path: <linux-kernel+bounces-334393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB25B97D6AC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914C428398E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 14:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796E817AE1C;
	Fri, 20 Sep 2024 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="oI1Pvyli"
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FF11E87B
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726841412; cv=none; b=aS5ZkpWMwmvcSG4sDtEpxngIDLeZKecr3HO+POaHc3OB6CZMCnpNAV4O3pBmZVI8USbNeiQSvBTwxpW+3wxh9Qo4p9AUMQhk9e8HtRxR7L1W5X4H+G4+rIT+4/SEw6Bi0mr1xh8OIRM5wPBD4G/aDKjkguaOh/VEQPCNKQy2jGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726841412; c=relaxed/simple;
	bh=IdmXoxNltkMdpHhqBAL8zqqUudWs2jRMTHTk+sUJ2nU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gY3WxqBmlNJKD310nyMeDXBBqLVBwwU/EdU5HGenTTIU96+v93lwyOiAoVaZCbLMZTMBEB1VYObx+Vv0+gkcZca0Y6P8JVzCVulAHm/KYnxRZf0awMqcK11sj7+8xUgZqq56yvTiBhgFYLLJiAzShLWdheljl9iuM2R9taFu0bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=oI1Pvyli; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726841355;
	bh=qzK8uIu022S8YjEa/Tyb5StH737XeLegD3fd8ko9znw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=oI1PvyliK3wD//C1vtzfn2nckF4p1UHFkx+QOj9O0CGl73BHfIxFNurJlHm8EuMe5
	 UcwY4688zEMdmCL6w9WTSWxoljqgBsZtuzyAbQ7vDwe7QlPql2hNB5kvdon71yXXNj
	 Q4bucgo5XhJG0vv0nQe1ZlCoChOmdoV5yKJbZM1U=
X-QQ-mid: bizesmtp83t1726841347tq9g9b0e
X-QQ-Originating-IP: z2dDgX9RMywJrmIRkRgM03hLshS/FS+mA7aLqgEV498=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 20 Sep 2024 22:09:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12140439654053645746
From: WangYuli <wangyuli@uniontech.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tzimmermann@suse.de,
	lee.jones@linaro.org,
	lee@kernel.org,
	guanwentao@uniontech.com,
	zhanjun@uniontech.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH v2] platform/x86/intel/pmt: Correct the typo 'ACCCESS_LOCAL'
Date: Fri, 20 Sep 2024 22:09:01 +0800
Message-ID: <CE6FFCA273A3A016+20240920140901.30524-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

There is a spelling mistake of 'ACCCESS_LOCAL' which should be
'ACCESS_LOCAL'.

Cc: Thomas Zimmermann <tzimmermann@suse.de>
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/all/26b8f38f-ff32-81fb-bbe5-aa141239427e@linux.intel.com/
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/platform/x86/intel/pmt/class.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
index c04bb7f97a4d..7680474c4f96 100644
--- a/drivers/platform/x86/intel/pmt/class.c
+++ b/drivers/platform/x86/intel/pmt/class.c
@@ -207,7 +207,7 @@ static int intel_pmt_populate_entry(struct intel_pmt_entry *entry,
 		/*
 		 * Some hardware use a different calculation for the base address
 		 * when access_type == ACCESS_LOCAL. On the these systems
-		 * ACCCESS_LOCAL refers to an address in the same BAR as the
+		 * ACCESS_LOCAL refers to an address in the same BAR as the
 		 * header but at a fixed offset. But as the header address was
 		 * supplied to the driver, we don't know which BAR it was in.
 		 * So search for the bar whose range includes the header address.
-- 
2.45.2


