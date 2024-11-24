Return-Path: <linux-kernel+bounces-420153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDC09D77A1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 20:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C247AB2969A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 16:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9502918B484;
	Sun, 24 Nov 2024 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R43JSLkS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB79187355;
	Sun, 24 Nov 2024 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732465299; cv=none; b=SwNm7Sh+eSmPi82+MLMHX8frJTxoO32aCX3pbN8kZkNvZnQg0BsrA/cldUUwJJbsub6lqbdUBZNIt4K8B710+2h9yuoR3xpnJCnAq5JOqCkI0tEQmPG9REN5E+RfPXqvicwwKn/zO+aS/USrQzJSih8i4C4vFAiN2udW8RAru2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732465299; c=relaxed/simple;
	bh=Yocm4wNY5w0X7yhA2IIoySXsCfIgtREQWYoXWj8P7O4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lTgB0dCiPO1YuznUk5DZvfShdP7yBVX7ArEB4uIm+Ddeof4SIQcfL5qBECZExmwRDbvBgS1osiCijQLhU8HVD5/XydUaN6J+PjcId9wEnr+kZrxOJYxOQP4w2WEsfwgg4VBxmMAAmgdRCYMk9FoFu8hLDBIbqIaxb4cXGtns8co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R43JSLkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C81BC4CED1;
	Sun, 24 Nov 2024 16:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732465298;
	bh=Yocm4wNY5w0X7yhA2IIoySXsCfIgtREQWYoXWj8P7O4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=R43JSLkSUsnUt8dF9BjyQfYccoEMHeJRKAy63kIr5nITjxxyDvs1o9gog2QJCioDG
	 jZEDxiiKQDOmmUW+9jm7hD/vmPyhtq1X/olpKCa3XMzWHI1GPr+LuVIr81/6QvrPUj
	 mT7kp4SaIDWxDHpou4JRcejbIbl2oK+L9+WzeEe0hYXqwT9pSbTYGmRvmYkxEusLW7
	 lHUIkICcdshOHCH2AcYShnjxq0qf69TeAtgXB/XeXkhKmjv94vMMSXWm7lzvtyXmYV
	 pZ/gKYi5A5bX7b2RFkyU7SF2721Ob+Ctsl8cIYijRWq/BJvZORwY2z4crF3Dk4wboK
	 6USVM79HwK/FA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADDCE668BB;
	Sun, 24 Nov 2024 16:21:38 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Date: Sun, 24 Nov 2024 17:21:36 +0100
Subject: [PATCH v3 2/3] w1: ds2482: Fix datasheet URL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241124-ds2482-add-reg-v3-2-806df39c9454@gmail.com>
References: <20241124-ds2482-add-reg-v3-0-806df39c9454@gmail.com>
In-Reply-To: <20241124-ds2482-add-reg-v3-0-806df39c9454@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Stefan Wahren <stefan.wahren@chargebyte.com>
Cc: Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732465298; l=803;
 i=cleverline1mc@gmail.com; s=20241112; h=from:subject:message-id;
 bh=KgZawicUQ6ba1iLjAlE5ZV15q7h9O+Q2qa06o+itHSU=;
 b=sSTCVKcz+HPkfsDfkPtL1wfea+5GF16lRiRZASuC82+zIuFG5qwHfT7ceOSpcPzIO5S8qX9w/
 ylO11GL9XUMAkoE1i8XaYj4mnO1L9h7yeEuLXT2xQqd/BAW3iamnVi0
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=EJoEbw03UiRORQuCiEyNA8gH1Q6fIpEWnn/MyaWOWX0=
X-Endpoint-Received: by B4 Relay for cleverline1mc@gmail.com/20241112 with
 auth_id=275
X-Original-From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Reply-To: cleverline1mc@gmail.com

From: Kryštof Černý <cleverline1mc@gmail.com>

Current link does redirect to wrong place.

Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
---
 drivers/w1/masters/ds2482.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/masters/ds2482.c b/drivers/w1/masters/ds2482.c
index 4cb05d00cb6743abc5699583f591ef9b5339b44e..48b4eb7299cb9ba0fc7df6ee7908f1e1709cf303 100644
--- a/drivers/w1/masters/ds2482.c
+++ b/drivers/w1/masters/ds2482.c
@@ -7,7 +7,7 @@
  * It is a I2C to 1-wire bridge.
  * There are two variations: -100 and -800, which have 1 or 8 1-wire ports.
  * The complete datasheet can be obtained from MAXIM's website at:
- *   http://www.maxim-ic.com/quick_view2.cfm/qv_pk/4382
+ *   https://www.analog.com/en/products/ds2482-100.html
  */
 
 #include <linux/module.h>

-- 
2.39.5



