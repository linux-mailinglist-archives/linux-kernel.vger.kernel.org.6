Return-Path: <linux-kernel+bounces-417967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE3E9D5B51
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9987282BDD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708F11CB53D;
	Fri, 22 Nov 2024 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5w0ycjr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0971BD4FB;
	Fri, 22 Nov 2024 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732265685; cv=none; b=AFEKm163OetrvYGAz7wKcXWtsGM3ieZbLVbp2lySSdC2wERrY8uHPB0URhYP5T1QfWhnn1dilUN5Xj9RR3evxjX7u0/oOBjBpjogb+FUdhCPnnjZOd02Gora5VAFxAxnn6qy3lbB0dBANfwOr8UqA/+zYvsrY6+xR0+Q41peN04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732265685; c=relaxed/simple;
	bh=kdlOqMd4IaNjJZxka4mv61XTpwsJoXe92l1sEXq/sYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fQ/Dvb7Sa6bf4bF7PyhLKAZaFhL0HUzyZXJANW5RJKq/X+RM1fvS5aPfKK/l0Q3m0Zrbkr431JRYbialSqW7QPrKG9uCGR8O7lJyFdc3ukeGk7DRycI18/sYnEqXBbwsMBC2JiuUxbZWHh3dd76DHFradvBzA6lb+Q+2Yl4Houk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5w0ycjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FF49C4CED8;
	Fri, 22 Nov 2024 08:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732265685;
	bh=kdlOqMd4IaNjJZxka4mv61XTpwsJoXe92l1sEXq/sYU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=a5w0ycjr+ZUFX5/Zt0bDMFh/NUjxzMV/7C3WxslnBQuQ9VfFz2RhqCPZcjUCH/GRq
	 ihuXh0B/7qAdPKWukUWOMhk0g33cl1CIvb/1IxFkWGz79DxmNNpKaa6qRwACznWcm0
	 0EOY4tUfrW0sF8E7kB7ykzy8+YwgsSG4IAy1KpvX2UrgbUKu3xWD1gJ0iQMABtk6pU
	 vZ1zEhQ7lKYMeSVVUdAGhJi2THRgC9Hz0G+Dk3y4/oAoewbl0gUrEXdzlndlM4LNlS
	 QUlX8sgoU7w6fQ1qe+npYUtSTreFcGugygke+4mh4KEZekxctUF4U9VGLt4u9Ma+7X
	 J9kyqufjjqn7w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDB7E65D35;
	Fri, 22 Nov 2024 08:54:45 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Date: Fri, 22 Nov 2024 09:53:58 +0100
Subject: [PATCH v2 2/3] w1: ds2482: Fix datasheet URL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241122-ds2482-add-reg-v2-2-a5a03ee74da7@gmail.com>
References: <20241122-ds2482-add-reg-v2-0-a5a03ee74da7@gmail.com>
In-Reply-To: <20241122-ds2482-add-reg-v2-0-a5a03ee74da7@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Stefan Wahren <stefan.wahren@chargebyte.com>
Cc: Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732265684; l=803;
 i=cleverline1mc@gmail.com; s=20241112; h=from:subject:message-id;
 bh=UBgH8nzxFBZsf9S6o5ykAjALagVAONUY98VsF7uGHps=;
 b=OhYzHbJDU8j0/SJRpQ65gCOz7Bf/c2ZRYxJFLQXaSBPLvqtPoUFDQmHbGZObc2QLsGv4hMagW
 1MdtDbHvPXuCnH7+CCiUsg85WgiFDu3clVqOOQrFWfw72hVdlR+wja+
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
index 3fb35e92fc1587dc4e609c0061fa5057e0027a80..ba86b5953b8d3ed1fe40d40a1a2b018c57fb91b8 100644
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



