Return-Path: <linux-kernel+bounces-426915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B219DFA03
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 05:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2ED8163599
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF101D63FE;
	Mon,  2 Dec 2024 04:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="fN2mxUAh"
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795CA1D5CF9;
	Mon,  2 Dec 2024 04:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733114992; cv=none; b=Sgt1E1ENMOKMVV3CUEhAwKm1fOsbrh6CfgXteqmLEKOpBRWfiTGSdqpcLQsPG2CYY5gEJTYGJ652TDRNTCZd/UzAlFZ+9Dx82+MybG/p4Jn6PAvcwQaAZqszAgQKFm8YeGdFksqY9E3Zpf4l5jLY/zQP3g/nSHvn8GrU2m6DTyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733114992; c=relaxed/simple;
	bh=fUm+qqsoUhyhoDF7UbcYwPSaynQbVoMDU8DxEViQStw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZOoPEPYg5qSQgSiqM8TtwQpAu279+/FozFG0l3dh92vSL/MdcXRFdRVwkHcnOVZRVj0TIEFXAwsKcCK484ibg1Nq7J69uicwMNoNJFg5a7T4326YfFoU85xgoXWAxcNfC7+WGMVBh+8x+qw3QzA2Yxe9qn2N9oWfs+rKWfrp8Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=fN2mxUAh; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1733114627;
	bh=fUm+qqsoUhyhoDF7UbcYwPSaynQbVoMDU8DxEViQStw=;
	h=From:Subject:Date:To:Cc:From;
	b=fN2mxUAhLt1SoQCU84xHuJ01DSgbo0GssCksMuhBrUanU5LsrmyQlRU76FTmK0yyl
	 kuSPOaDOkvXCjfKgb9GbsG4ufhH3IrfVz3raBH8Ku8ucvXLSV/OjCETvWNiT0XntoF
	 Tb/NfaV/9xClQYg3F2qA4Pokz5WzxvA2VCVglLR0bVuSH74hj8GC++y8SzarYGTXC5
	 L9hUfDRH6TGp5Tp4p/PtYOMZ3Fw6TPLh/Ekj88H8REyAiZ0hpqb2frIIGuQjcadcsy
	 JYc4TlWAPoxYHZKpcMFpDKAqTueGL9iM+F6zY/OwfnG5P7Kcl4K+q9EYiOADTaTnWr
	 G2ayd31BQqZkA==
X-Virus-Scanned: by epochal.quest
From: Cody Eksal <masterr3c0rd@epochal.quest>
Subject: [PATCH 0/2] sunxi: Add A100 syscon nodes
Date: Mon, 02 Dec 2024 00:43:25 -0400
Message-Id: <20241202-a100-syscon-v1-0-86c6524f24d7@epochal.quest>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO46TWcC/x3MMQqAMAxA0atIZgtNLBW8ijhUjZqllQZEKd7d4
 viG/wsoZ2GFoSmQ+RKVFCuwbWA5QtzZyFoNZMkhkjcBrTX66JKi6Tv0MwdP7AhqcWbe5P5v4/S
 +H73Q4LVdAAAA
X-Change-ID: 20241126-a100-syscon-7316bea62e42
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Parthiban Nallathambi <parthiban@linumiz.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Cody Eksal <masterr3c0rd@epochal.quest>
X-Mailer: b4 0.14.2

Hello again! Happy December!

Here are some very small patches to add syscon nodes to the A100's
device tree. These had not been added yet, as they hadn't been needed up
to this point. However, Parthiban and I have been working on patch
series in parallel that require either the syscon or the SRAM nodes it
is responsible for; specifically my patches add support for the A100's
ethernet controller, while Parthiban has been working hard on bringing
up the Display Engine.

Thanks as always!
- Cody

Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
---
Cody Eksal (2):
      dt-bindings: sram: sunxi-sram: Add A100 compatible
      arm64: dts: allwinner: a100: Add syscon nodes

 .../sram/allwinner,sun4i-a10-system-control.yaml   |  4 ++-
 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi     | 31 ++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)
---
base-commit: e70140ba0d2b1a30467d4af6bcfe761327b9ec95
change-id: 20241126-a100-syscon-7316bea62e42

Best regards,
-- 
Cody Eksal <masterr3c0rd@epochal.quest>


