Return-Path: <linux-kernel+bounces-425600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4790D9DE78A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 14:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AAD4281365
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 13:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503ED1A00F2;
	Fri, 29 Nov 2024 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8vyQpNL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98E419F104;
	Fri, 29 Nov 2024 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886923; cv=none; b=otQC+HOrq00pczw0e38NpnTfOAibAsBwl2pWNm8ZJXfnEp5afbaRXytzk4zlNjmQQK9AbErNTxJHDL/dCMUCOFuxWcK41XpmXkEMbvbdfd50V+qIzCLGc/KOOJGZjqrRwlpVPkt38DQpySHGU3ezDN+iqDPnKw+lAs4l0Q7ir0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886923; c=relaxed/simple;
	bh=0GT0S6B59Sh7YHKRKqs1R3em47LYzIxB5c5OcdUOSBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J74lTn1aTBTR3RMTjou6wl9H0z4UpVz3CXFGtaUvkycbz3uXcSvRYq+HprpcYdZxE16Ho53/kW/uNsrRaiSEl4hMNkIjz5xse/saRPfcLlyhFVdAkVZ6FAkxjQpJFPO7/hWhpKQInhAfnInFByea8OyE4et+AbP/OgjoLD/VmiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8vyQpNL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 346A7C4CEDD;
	Fri, 29 Nov 2024 13:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732886923;
	bh=0GT0S6B59Sh7YHKRKqs1R3em47LYzIxB5c5OcdUOSBs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=r8vyQpNLf3UbhLCNc5OwSjUhm12oUs4ByFMJtKzYUpfzHgme3JMmS8nT6m/M/befM
	 UtQ4KOETEyQh9RaUPNFu89NjXzv1hYtb6EcRtBZQL6lbScsBXRCaKjGlch3PrhRqgG
	 zQ75mBxufmh4cNp7uiHYywNFsKNXVTVYUFGozK3CSCvNPB/QRPr2tNFapEUWIqmsoB
	 lbOlopA5OxmoMdmqZBb31Qcr5uAwr7Pfi6n4Uw18dc69DmwcMp6oGv8XAymaWs3gQ8
	 I4RFMmav2Hc53nyXgBY0W5W7krIlaSh6Jm1IYItGfLTmGBDqZhcTS1djBJzjhEtjtk
	 4k5Ydttts8lRQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B14D6EC0E;
	Fri, 29 Nov 2024 13:28:43 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Date: Fri, 29 Nov 2024 14:25:56 +0100
Subject: [PATCH v6 4/4] w1: ds2482: Fix datasheet URL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241129-ds2482-add-reg-v6-4-bd95ad171e19@gmail.com>
References: <20241129-ds2482-add-reg-v6-0-bd95ad171e19@gmail.com>
In-Reply-To: <20241129-ds2482-add-reg-v6-0-bd95ad171e19@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Stefan Wahren <stefan.wahren@chargebyte.com>, 
 Stefan Wahren <wahrenst@gmx.net>
Cc: Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732886921; l=803;
 i=cleverline1mc@gmail.com; s=20241112; h=from:subject:message-id;
 bh=EVaEWv3bg2CKdeK1wOkMyq+7EzE+bpOJT7BBQM8wUdo=;
 b=eZ/N+WH/9ZigC7/s5Y4inebd6DqLKx8Fe7UGOTMXLfMjXvejiYi2/LSpdNdCXIVGBeck8jetz
 w3j9fKxILxsAyqfuLVdtTWgw3pUGogy+/BB8g/c5w3RLcp2I/Mts8RJ
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
index f8095264d82f0e0135492ed65e71df74c71bcd65..e2a568c9a43aac548056c490ce72c464adca7cb3 100644
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



