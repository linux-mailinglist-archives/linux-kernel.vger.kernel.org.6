Return-Path: <linux-kernel+bounces-558835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D58A5EBE0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A69C53A8917
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 06:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72E31FBE8C;
	Thu, 13 Mar 2025 06:44:48 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10E41FBCAE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 06:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741848288; cv=none; b=i/097TuqVixA0j8sYKbfRBZyx04X+9uB49/kumR9NSxd54hdoxUQ3IEQTTpuyJqafjEQ1ZK8uUTLNqPBJC0jpN79WRCUa9UsHVHNao46iWtWSism0+dm/mpMKwBbqiNJxl15FloUVZsid4O+pTIJYSagbLZyQTFdN31sm+Zn384=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741848288; c=relaxed/simple;
	bh=LgcwkCtuF2Bj7bpRCoqVugs+6167YT67viU1v7T1oS4=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=DKt+MwB8RgIfRki1UMh9uwvkF7ASQfMwbwLpNDKTUh/440lJnLBeHztAXvQD2TgCrp1shF7r3O3DqWRDCZI93e4gE35SxlLtgbD4hIutx3+SsXGoEf6QDyqZxwV2VYA/tQxNmnsHhIgbiyFMVouzEqv/XLDA/gU8idHNGTCv9HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZCyfG3x6cz50FXY;
	Thu, 13 Mar 2025 14:44:38 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 52D6iSAg031760;
	Thu, 13 Mar 2025 14:44:28 +0800 (+08)
	(envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid31;
	Thu, 13 Mar 2025 14:44:30 +0800 (CST)
Date: Thu, 13 Mar 2025 14:44:30 +0800 (CST)
X-Zmail-TransId: 2afa67d27ece066-86a30
X-Mailer: Zmail v1.0
Message-ID: <20250313144430115dzzemB3yO4jZvI29ZZebY@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <ye.xingchen@zte.com.cn>
To: <tglx@linutronix.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBGaXggaW5jb25zaXN0ZW50IHBhcmFtZXRlciB0eXBlIGluIGRlY2xhcmF0aW9uIGFuZCBkZWZpbml0aW9u?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 52D6iSAg031760
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D27ED6.000/4ZCyfG3x6cz50FXY

From: YeXingchen <ye.xingchen@zte.com.cn>

The declaration of irq_set_irqchip_state in the header file uses
bool state as the parameter type, while the definition uses bool val.

This patch aligns the parameter name in the definition with the
declaration,changing val to state to ensure consistency.

Signed-off-by: YeXingchen <ye.xingchen@zte.com.cn>
---
 kernel/irq/manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index f300bb6be3bd..fc44c2df8d01 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2860,7 +2860,7 @@ EXPORT_SYMBOL_GPL(irq_get_irqchip_state);
  *	interrupt controller has per-cpu registers.
  */
 int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
-			  bool val)
+			  bool state)
 {
 	struct irq_desc *desc;
 	struct irq_data *data;
-- 
2.25.1

