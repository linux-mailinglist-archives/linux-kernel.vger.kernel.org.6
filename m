Return-Path: <linux-kernel+bounces-393333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB089B9F59
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 12:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74343B21DBB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 11:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F41189BA4;
	Sat,  2 Nov 2024 11:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqcn2SvE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB241714A8;
	Sat,  2 Nov 2024 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730547264; cv=none; b=tHb3a1Wj57dIQ3FefA/PTKDHAcBb4tmpU/Jc4S5Rnhd5IvhqobfGxMwUce9gkR16X4dwwE93X3D2dGAKbrWhRhV8hp478Kxt+s2lG4nxa+a4Jns60HIsk/20BwFjmY7MXB+saySwNKCylZv6e0KHI1RTTR66UpHWNJdp3JVjcF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730547264; c=relaxed/simple;
	bh=AlyikN0YqHFLUKRJr7wvyyU0Pc9nGL/KGQvMwi2DpR8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RcG7Cn3si4MRexyhkBGkz/yO548Rr8/Uj5w8zdM7Mqgmkdsf9vB2evdj4swft55bkIMrvC0/CKIOLrgmdyk54wPtZV2bbYbTkiYH1RMA2WXcwt4UtbrNBcoNWouTrdmJO/cNaM8h/rZ9hVO0qt6xE6CQ4p7lvaNXe3hNLwgNxPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqcn2SvE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78259C4CEC3;
	Sat,  2 Nov 2024 11:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730547263;
	bh=AlyikN0YqHFLUKRJr7wvyyU0Pc9nGL/KGQvMwi2DpR8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=aqcn2SvEOY8pjHxeJQvbs0T0x9E4CZ5aOvixMOvSwO6OF0V9x6NJRIFkO8TeoYw+T
	 TeOQSO2Bcu9cGPM8N24HXyS58gqXN9LneA5Kj7TJWtA5BADi+Du3M58J0SDoji8nmf
	 2GHwSc0mwZiAUdMKVxn9AC3nG3YJgRPNa82dg1e7yg6LZHzzzLwIkXxqtIrYJPMhmx
	 y/KIlo7nCJMfy5KcdOlMBHBjEbONP+2Vp9r6xXgqL3tx1ai2lWxifGyW7cK91BIRE1
	 aVah0cFrAZMRr5maXf714GB6YhPCUlxkLK80yWfPOLMbi9JAOjuiByOFUMdSSkKl9T
	 3n/wuRjdPQKtA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EAFE677FA;
	Sat,  2 Nov 2024 11:34:23 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Subject: [PATCH 0/5] Add Apple SPI controller and spi-nor dt nodes
Date: Sat, 02 Nov 2024 12:34:19 +0100
Message-Id: <20241102-asahi-spi-dt-v1-0-7ac44c0a88f9@jannau.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADsOJmcC/x3MMQqAMAxA0atIZgOmtiBeRRxaGzWLlkZEkN7d4
 viG/19QzsIKY/NC5ltUzqOC2gaW3R8bo8RqMJ2xRB2hV78LahKMF7rBWBcCRd8z1CRlXuX5d9N
 cygfIQSgXXgAAAA==
X-Change-ID: 20241101-asahi-spi-dt-58245bb1da3e
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2640; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=AlyikN0YqHFLUKRJr7wvyyU0Pc9nGL/KGQvMwi2DpR8=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnQ1PluWEzef/NdxaGN8YLhjclhqcPQNK0uhqR81g4/Ot
 PBl3qjbUcrCIMbFICumyJKk/bKDYXWNYkztgzCYOaxMIEMYuDgFYCIbjjAyvHscZHtPhnfvJbvG
 153Wme9P3Evgl1y/YuuXwOp5rBpxcxn+B7XsFrA5OfWveJ32XBGGqNbL0ZXzl05hkLLV/p3GeS+
 EEQA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/yk2024 with auth_id=264
X-Original-From: Janne Grunau <j@jannau.net>
Reply-To: j@jannau.net

This series adds SPI controller and SPI NOR flash device nodes to the
man Apple silicon SoC dts files. Only the subset of used SPI controllers
is added. Five SPI controllers exists according to pmgr ADT data but the
commits only add controllers found in use on any of the devices. The
parameters for the missing nodes are guessable but there's no point in
adding them since no further M1 or M2 devices are expected.
Together with controller nodes the first SPI device is added. All Apple
silicon devices connect a SPI NOR flash to spi1. This holds Apple's 1st
stage bootloader, firmwares, platform and machine specific config data
and a writeable key-value store (nvram). Expose only the nvram as mtd
partition since it has use beyond exploring the content. Tools from
asahi-nvram [1] can modify the (default) boot configuration
(asahi-bless), read Bluetooth sync keys (asahi-btsync) and read and
write arbitrary keys (asahi-nvram).

Devicetree bindings are included in the driver series. Last version at
https://lore.kernel.org/linux-devicetree/20241101-asahi-spi-v3-0-3b411c5fb8e5@jannau.net/

This series passes `make CHECK_DTBS=1 dtbs` with the spi bindings except
for "local-mac-address" for the Bluetooth device (I need get back to
this).

[1] https://github.com/WhatAmISupposedToPutHere/asahi-nvram/

Signed-off-by: Janne Grunau <j@jannau.net>
---
Hector Martin (1):
      arm64: dts: apple: t8103: Fix spi4 power domain sort order

Janne Grunau (4):
      arm64: dts: apple: t8103: Add spi controller nodes
      arm64: dts: apple: t8112: Add spi controller nodes
      arm64: dts: apple: t600x: Add spi controller nodes
      arm64: dts: apple: Add SPI NOR nvram partition to all devices

 arch/arm64/boot/dts/apple/spi1-nvram.dtsi      | 39 +++++++++++++++
 arch/arm64/boot/dts/apple/t600x-common.dtsi    |  7 +++
 arch/arm64/boot/dts/apple/t600x-die0.dtsi      | 28 +++++++++++
 arch/arm64/boot/dts/apple/t600x-gpio-pins.dtsi | 14 ++++++
 arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi |  2 +
 arch/arm64/boot/dts/apple/t600x-j375.dtsi      |  2 +
 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi      |  2 +
 arch/arm64/boot/dts/apple/t8103-pmgr.dtsi      | 18 +++----
 arch/arm64/boot/dts/apple/t8103.dtsi           | 68 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8112-jxxx.dtsi      |  2 +
 arch/arm64/boot/dts/apple/t8112.dtsi           | 44 ++++++++++++++++-
 11 files changed, 216 insertions(+), 10 deletions(-)
---
base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
change-id: 20241101-asahi-spi-dt-58245bb1da3e

Best regards,
-- 
Janne Grunau <j@jannau.net>



