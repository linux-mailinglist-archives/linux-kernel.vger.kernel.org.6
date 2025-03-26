Return-Path: <linux-kernel+bounces-577082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5982A7181D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9AFF7A4151
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A18C1F153C;
	Wed, 26 Mar 2025 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="GUcuf7q/"
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304EE1E1DEE;
	Wed, 26 Mar 2025 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742998196; cv=none; b=S5JPTD/R6uncc3nd2K/ZPUwVLUtoaxX4RKFE0c/WuWfGD823IGIJKjnWYhkgVGffCp35jczGM5PQx2KhNfC3eB0Pa/OiUtEhxOiRIwIP/xLErj1tAiaDHWWxS2A2WK9Odaom7Y3y9K/ftYvwMmcKDkNvJ84ksZtsG5Toyieh/v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742998196; c=relaxed/simple;
	bh=x0BhWl/XGa0eCjf2xd9Q9Sf3A7THwh85OBqQMQrv1KU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BMMovM8lV93igpC2IKvJ8NIuECWOl0eSm96XDDwwSlr/tSGTyZEGRqLaBEbjlKMoP7IgIJIafYJbXKaq25sAI700/6Eli4YVyKhFIJZCs95Sk2JBkgqOnU0rxhqoy8PxoiwvQqCS1904XkaSoDC6CGaCcuJRf/p6jIYENmAG6GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=GUcuf7q/; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B1FBB10246DA9;
	Wed, 26 Mar 2025 15:09:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742998192; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=wNc55uWXBq2CDe26PN6TZH3LTiWbpWVuLcLwZfaCHlQ=;
	b=GUcuf7q/DQr3fKy6ZSqb6Qq9kMsqAdxwVuafqpVDGArdGaUtqyB8/D8gkGnc5d0I5Tw+/A
	zzuLKmkyx4fjS39HtcQmwI5L4ve+NHgKHE9wt72eVcsTltuDvxrpIn9sSQdvC/LDF13YYE
	0FKJgb9ITZDc/82G8tSN4/Uq8+R+8Sfv1JKHiOlvCjIo3Gnt5Vdurr4XuqjraT4HenptW6
	4iEeLzF/YxHz8cEOQkDs8YoFEiAip6aAdLV6xpN/+yWR0F4QpsWW7NDOsE4E/9W2mw12pG
	GE9upDIw/klBrGc/PI5yA0SdXaqpMPyughrSade+BLlv6Wqow4ZYgQ8rRat5sg==
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Noah Wang <noahwang.wang@outlook.com>,
	Michal Simek <michal.simek@amd.com>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH RESEND] dt-bindings: trivial-devices: Document SPI measurement on LWE boards
Date: Wed, 26 Mar 2025 15:09:30 +0100
Message-Id: <20250326140930.2587775-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The measurement device on Liebherr's (LWE) boards is used to monitor
the overall state of the device. It does have SPI interface to
communicate with Linux host via spidev driver. Document the SPI DT
binding as trivial SPI device.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index fadbd3c041c8..5d736a9792c2 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -161,6 +161,8 @@ properties:
           - jedec,spd5118
             # Linear Technology LTC2488
           - lineartechnology,ltc2488
+            # Liebherr on-board measurement SPI device
+          - lwe,btt
             # 5 Bit Programmable, Pulse-Width Modulator
           - maxim,ds1050
             # 10 kOhm digital potentiometer with I2C interface
-- 
2.39.5


