Return-Path: <linux-kernel+bounces-410849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C23EB9CE647
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C6928318B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56FD1D514C;
	Fri, 15 Nov 2024 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzWVDSuh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9C91BF7FC;
	Fri, 15 Nov 2024 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682737; cv=none; b=Y+Gjg64p0k7ItW7M0rAp/x7FFvYPYRlbZr+twKCWsyminV5z2hYKiCbF61BDhGDmheOzJlraSbKGLz7Au56eL73Md7TAJxZCtQ6cAAB3j6a/Pxjbcjmsupjlgw2gNeOy8QVlXPo0prQxOnZbumVD43R5Sh4UFkHOkq22f+IikdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682737; c=relaxed/simple;
	bh=kdlOqMd4IaNjJZxka4mv61XTpwsJoXe92l1sEXq/sYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bQnhvyv8Lnum+so1LJUk08zuqPhd7xxC53Ciks/TrwLS8NFQrdkJL5UfcvcR/I1E8sL4zGmgx40LvYjqhQNBFwikduMb1zydjuCIEdds2ARolSHuRHepOPkYrO3sFifJT26PJ8OMHJK5rrNTz7iUeZqbErclsRuMHuMUKUUFpQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzWVDSuh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D93FC4CED5;
	Fri, 15 Nov 2024 14:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731682736;
	bh=kdlOqMd4IaNjJZxka4mv61XTpwsJoXe92l1sEXq/sYU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XzWVDSuhAVR9kwP71gBuAn+315yvfBC4I7mhPSoijFxCUUOFbDvGSLxf0HFmUnUQv
	 Ab14rCQ6uH3gOXxTm5Mb44fTGuciGtjXw7Vkapm1nplbRt03YHa8oNDOlebSLLgcFD
	 Bs+guhgX8dfXi+IfmfJJlQasePAh8mTUjZ+4y9YgYv35jmiEGKWHEYviD2HLjmjiop
	 AlEWCuoMzCFTEPNckr0DqukZdujqFBNFX7xW3Mi0k2XaYaxnJeGS1DydB4MVQZGI4q
	 XQ3/D740fM9/W7y8Nu+y140ZGYwkgnHrvJ5PGHmj/6yitxmaaOY1xHDQwy/60jweqo
	 k/Te98DVZ4EiA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCFAD68BC3;
	Fri, 15 Nov 2024 14:58:56 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Date: Fri, 15 Nov 2024 15:58:05 +0100
Subject: [PATCH 2/3] w1: ds2482: Fix datasheet URL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241115-ds2482-add-reg-v1-2-cc84b9aba126@gmail.com>
References: <20241115-ds2482-add-reg-v1-0-cc84b9aba126@gmail.com>
In-Reply-To: <20241115-ds2482-add-reg-v1-0-cc84b9aba126@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Stefan Wahren <stefan.wahren@chargebyte.com>
Cc: Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731682735; l=803;
 i=cleverline1mc@gmail.com; s=20241112; h=from:subject:message-id;
 bh=UBgH8nzxFBZsf9S6o5ykAjALagVAONUY98VsF7uGHps=;
 b=sTMk5PlH+nZLJyIJDx7waGCt3zg4eC0dpAhiRuKCuPsW0LoLQSZHzM8//6aMRD800Nyu9OKNS
 rQ9Z5JfHdFkDNqwaUQNpGqiNohSVWcHkAjMS5REYlEfDnryjm5vzXDw
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



