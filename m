Return-Path: <linux-kernel+bounces-421703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E85C9D8EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 23:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8621677A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 22:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7579C1CDA2E;
	Mon, 25 Nov 2024 22:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+faHWM/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD741BBBD4;
	Mon, 25 Nov 2024 22:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732574913; cv=none; b=kviQhR7MtqdxnrbgGfFlWyIBEoYGUa/0jmFbLt6/ziF+/3svntzNSKa3di8w/1Ll0IgEY9h18byf6ZNT9vJB1EKCgPFu2sYi+fQkowM4c2eH78vfhhY0hty/1v1/qXaGXa7NgNtHMPfL+iaFljaUSN2XTrhzIliSaepcFnIeoCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732574913; c=relaxed/simple;
	bh=gtIsN5q1iJLyClB2EiS8qVMSi0Ss3Ong+GdKLPobwMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P/dWYzxup/IpeLzyve6Ui67pxJtmfZgKj3V7WwFBOUytoky+3hfuuByTmEyFysZWHDWl3aJPXoZHeAkJjwQbuHPZEWNeIhSAVkv+GE+jA99HvVvO/bzz3PGLOPw6SKsA6O8qdcrcZ03tddHr9WQ3GH/ZJNWPhPXvi2iTJXsDDSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+faHWM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 888AAC4CED3;
	Mon, 25 Nov 2024 22:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732574913;
	bh=gtIsN5q1iJLyClB2EiS8qVMSi0Ss3Ong+GdKLPobwMg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=E+faHWM/2qDZoA2FznIKRGquKP0uGeygeh8ImtxtvbMey5InTMOdS1stRVqnrdrBk
	 7jCll8UmD5X4S3hBYnJ+OMycyOFe82kq/eoI9aWRlj3O8hrhdgXzuCKEUIDnI7VVP/
	 hFC0oWROmxxdfQGrfD1VWH83XFgYJ2e7U9u82yxLyYOKEvnApI2BJIz7edsEexcNks
	 kOm9oZdrZvV0VYUwVRcOx+w4IP9muXzD6lDymyPTvHeGCWRDwQ2ptPPuL6A7uAXums
	 KZHBoXXsVwnwa5s0nJyye3NIR5n+Qh6LjgayCbP+Rwdcq6WisLJ+hn5zme4mPmrSjS
	 R8mr/UZDrlYog==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BF9D59D64;
	Mon, 25 Nov 2024 22:48:33 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Date: Mon, 25 Nov 2024 23:47:20 +0100
Subject: [PATCH v4 3/3] w1: ds2482: Fix datasheet URL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241125-ds2482-add-reg-v4-3-475a7a08df96@gmail.com>
References: <20241125-ds2482-add-reg-v4-0-475a7a08df96@gmail.com>
In-Reply-To: <20241125-ds2482-add-reg-v4-0-475a7a08df96@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Stefan Wahren <stefan.wahren@chargebyte.com>, 
 Stefan Wahren <wahrenst@gmx.net>
Cc: Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732574911; l=803;
 i=cleverline1mc@gmail.com; s=20241112; h=from:subject:message-id;
 bh=FRBH+G2mXI2rE0kQh36Kp8xbBiKgF4uhZuIapE+7aVw=;
 b=pHddJWKdxcbkzzfsTtlcLQ4B/Pugg0H/05LLaxmFzFxeNs0vQxfx7EjAzt69zBoea4zO+KMym
 n7Vt8uLNi8RDQHgCj0C3L4snnv3rnBDImcYUhNBohiHINpTn+r8iP1X
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
index 2e5bbe11d8a0cdabd12e89e22537423749e7f9ff..52a437aa8be062def827aae012ace6b8cef58b3e 100644
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



