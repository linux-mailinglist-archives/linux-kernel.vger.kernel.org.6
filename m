Return-Path: <linux-kernel+bounces-577113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D99C1A7187E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D57CF189577C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F001DB933;
	Wed, 26 Mar 2025 14:26:27 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B565C1E1020
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742999187; cv=none; b=FkPzVZcRRt1meHXqxOOjZW72Am2If3JVCa9lbXLdB6i2gAAJ3WDGIzquycQ3D4FSancH3z2YoecAX6rbqzMhjIpPqFyfv5lvxi1prNIMsr+V3Rxs9dW2XiJnroDn7lZyZDDQHc4DXgF6qXPz1QZc37dAj33ltXDxXgjMzMbA5Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742999187; c=relaxed/simple;
	bh=hs05pmtQd5aEmiRJmZQDXIlqVZNO91bDmbLI79UOEn4=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=Th0vzC/Evml1F99gFmuh5k5SNzvoYwCX3IRTFr8SVw57BNUjPY+Cq6iQSBNpAmggTwu01pcU1+UQe8iVvvPYYN6ZcmmVcAhcFixeD7kpXfoml45KY4JQ7KMup6bfDZ5B2WVgIusS/SKxLvw4Jep4y0euRS71FR9xem+/4/rpEYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZN8Gx1wr2z5B1KS;
	Wed, 26 Mar 2025 22:26:17 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 52QEQ9cM053840;
	Wed, 26 Mar 2025 22:26:10 +0800 (+08)
	(envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid31;
	Wed, 26 Mar 2025 22:26:13 +0800 (CST)
Date: Wed, 26 Mar 2025 22:26:13 +0800 (CST)
X-Zmail-TransId: 2af967e40e851a7-e39d9
X-Mailer: Zmail v1.0
Message-ID: <20250326222613416aY2Zx__NRIpM47WVTujMF@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <ye.xingchen@zte.com.cn>
To: <linux@armlinux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBkcm06IGJyaWRnZTogdGRhOTk4eF9kcnY6IE1ha2UgdXNlIG9mIGlycV9nZXRfdHJpZ2dlcl90eXBlKCk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 52QEQ9cM053840
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67E40E89.000/4ZN8Gx1wr2z5B1KS

From: Feng Wei <feng.wei8@zte.com.cn>

Convert irqd_get_trigger_type(irq_get_irq_data(irq)) cases to the more
simple irq_get_trigger_type(irq).

Signed-off-by: Feng Wei <feng.wei8@zte.com.cn>
Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 drivers/gpu/drm/bridge/tda998x_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tda998x_drv.c b/drivers/gpu/drm/bridge/tda998x_drv.c
index ebc758c72891..73aefbaaf27c 100644
--- a/drivers/gpu/drm/bridge/tda998x_drv.c
+++ b/drivers/gpu/drm/bridge/tda998x_drv.c
@@ -1875,7 +1875,7 @@ static int tda998x_create(struct device *dev)
 		init_waitqueue_head(&priv->wq_edid);

 		irq_flags =
-			irqd_get_trigger_type(irq_get_irq_data(client->irq));
+			irq_get_trigger_type(client->irq);

 		priv->cec_glue.irq_flags = irq_flags;

-- 
2.25.1

