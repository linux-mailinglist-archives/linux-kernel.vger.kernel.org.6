Return-Path: <linux-kernel+bounces-315884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D8A96C81C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99FEE1C21568
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8540D1E7642;
	Wed,  4 Sep 2024 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzWDwDl2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAADC13A276;
	Wed,  4 Sep 2024 20:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725480180; cv=none; b=GMpmGom7Gn80doZ0Ft6J/uVNY+ZRz2GVMXB5fK7wMQocoIf/mYww47QEFjG1l6fC2mDXx9q9/5dGmBciAbkieyhgREC5ywx4P3PiOI7t/Opkh9Wgd1EGQ8tZSKz9YM6zBF47/f3OqevkZBzrs5JTZiZPpo6H1LOrA4JXfAxwpsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725480180; c=relaxed/simple;
	bh=fYVQ/zRfKE+0rCdvMJekDiqUL1tFTV5VdRnogTlWfYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k3KsuYT/fD9LfHn5wALqBn75a0Ace3AB/FnivwMCFm1ZvYqloHUlPcWBp4WjGtD4Rijk8I4o4g81zK38STmI5parp/7JQqNZCNlYSjjoBVPqCRpJFsEBbI8122+EC27L8g6YSvBVTkE0i6u2izBLd4N8FKt+8b0WfJ/rng+hnCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzWDwDl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44708C4CEC2;
	Wed,  4 Sep 2024 20:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725480179;
	bh=fYVQ/zRfKE+0rCdvMJekDiqUL1tFTV5VdRnogTlWfYc=;
	h=From:To:Cc:Subject:Date:From;
	b=GzWDwDl2f/K6etW4fb/vidLs6wq+W0xt5goPiwhHpnUhMSCiFEFK99Zl2iCEPC09B
	 Fj43wdHBz2MEc44ZX9xFEecvQsQUuPc2dQwJWBxhNY/bAphBzjOBCip57Hpm0jYvTR
	 gX39QyFsLUANdXaNk5m2Y2rxImqXZ9JMICiInTNP8zTxCMKNA3uGhj+m4i270sPXCX
	 o/ghooMijNynTasTlfutuW4q5FbCRU7pOvr2d5FWF7rzmGbfTvF7rs19qFiqrxJj6/
	 LXpHl8WSiFRkKo069V4oA2c1BryCdITlUeGY0+ghEvSc2NzN+7XTZhhoa9Ky0TZFGS
	 5cDQIHrZ0QNig==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: incomplete-devices: And another batch of compatibles
Date: Wed,  4 Sep 2024 15:02:52 -0500
Message-ID: <20240904200253.3112699-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Another batch of compatibles unlikely to ever be documented. It's
mostly old PowerMAC stuff found in DT compatible API calls.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/incomplete-devices.yaml          | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/Documentation/devicetree/bindings/incomplete-devices.yaml b/Documentation/devicetree/bindings/incomplete-devices.yaml
index cfc1d39441b1..289f7c3b91c3 100644
--- a/Documentation/devicetree/bindings/incomplete-devices.yaml
+++ b/Documentation/devicetree/bindings/incomplete-devices.yaml
@@ -35,22 +35,116 @@ properties:
 
       - description: Legacy compatibles used on Macintosh devices
         enum:
+          - AAPL,3500
+          - AAPL,7500
+          - AAPL,8500
+          - AAPL,9500
+          - AAPL,accelerometer_1
+          - AAPL,e411
+          - AAPL,Gossamer
+          - AAPL,PowerBook1998
+          - AAPL,ShinerESB
           - adm1030
           - bmac+
+          - burgundy
+          - cy28508
+          - daca
+          - fcu
+          - gatwick
+          - gmac
+          - heathrow
+          - heathrow-ata
           - heathrow-media-bay
+          - i2sbus
+          - i2s-modem
+          - iMac
+          - K2-GMAC
+          - k2-i2c
+          - K2-Keylargo
+          - K2-UATA
+          - kauai-ata
+          - Keylargo
+          - keylargo-ata
           - keylargo-media-bay
           - lm87cimt
           - MAC,adm1030
           - MAC,ds1775
+          - MacRISC
+          - MacRISC2
+          - MacRISC3
+          - MacRISC4
           - max6690
+          - ohare
           - ohare-media-bay
           - ohare-swim3
+          - PowerBook1,1
+          - PowerBook2,1
+          - PowerBook2,2
+          - PowerBook3,1
+          - PowerBook3,2
+          - PowerBook3,3
+          - PowerBook3,4
+          - PowerBook3,5
+          - PowerBook4,1
+          - PowerBook4,2
+          - PowerBook4,3
+          - PowerBook5,1
+          - PowerBook5,2
+          - PowerBook5,3
+          - PowerBook5,4
+          - PowerBook5,5
+          - PowerBook5,6
+          - PowerBook5,7
+          - PowerBook5,8
+          - PowerBook5,9
+          - PowerBook6,3
+          - PowerBook6,5
+          - PowerBook6,7
+          - PowerMac10,1
+          - PowerMac10,2
+          - PowerMac1,1
+          - PowerMac11,2
+          - PowerMac12,1
+          - PowerMac2,1
+          - PowerMac2,2
+          - PowerMac3,1
+          - PowerMac3,4
+          - PowerMac3,5
+          - PowerMac3,6
+          - PowerMac4,1
+          - PowerMac4,2
+          - PowerMac4,4
+          - PowerMac4,5
+          - PowerMac7,2
+          - PowerMac7,3
+          - PowerMac8,1
+          - PowerMac8,2
+          - PowerMac9,1
+          - paddington
+          - RackMac1,1
+          - RackMac1,2
+          - RackMac3,1
+          - screamer
+          - shasta-ata
+          - sms
+          - smu-rpm-fans
           - smu-sat
+          - smu-sensors
+          - snapper
           - swim3
+          - u3-agp
+          - u3-dart
+          - u3-ht
+          - u4-dart
+          - u4-pcie
+          - U4-pcie
 
       - description: Legacy compatibles used on other PowerPC devices
         enum:
           - 1682m-rng
+          - direct-mapped
+          - display
+          - hawk-pci
           - IBM,lhca
           - IBM,lhea
           - IBM,lhea-ethernet
@@ -60,6 +154,7 @@ properties:
           - ohci-be
           - ohci-bigendian
           - ohci-le
+          - soc
 
       - description: Legacy compatibles used on SPARC devices
         enum:
@@ -68,7 +163,10 @@ properties:
           - isa-m5819p
           - isa-m5823p
           - m5819
+          - qcn
           - sab82532
+          - su
+          - sun4v
           - SUNW,bbc-beep
           - SUNW,bbc-i2c
           - SUNW,CS4231
@@ -96,9 +194,12 @@ properties:
           - compat1
           - compat2
           - compat3
+          - gpio-mockup
+          - gpio-simulator
           - linux,spi-loopback-test
           - mailbox-test
           - regulator-virtual-consumer
+          - test-device
 
       - description:
           Devices on MIPS platform, without any DTS users.  These are
-- 
2.45.2


