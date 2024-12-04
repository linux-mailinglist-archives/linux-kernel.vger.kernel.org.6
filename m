Return-Path: <linux-kernel+bounces-431602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE66F9E3F53
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9481682F2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6512144B8;
	Wed,  4 Dec 2024 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMlGYcgT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8850620C489;
	Wed,  4 Dec 2024 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733328394; cv=none; b=Z7sfFMJ8cFQTuigo9liZ8gF38UnbidhnGdMWXvjsWpnmT4zEPefnvE8hIgSVsS1tFZ+G0OcWLMNGWnPZNYDhkHhCMRMemrKczCHncpIzcu0LgOa5S2jeL/WJF5y4q3iJ61HfQOUuu5VrCU5SeZEo7+Box20VKqLjUcjxbP6rUok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733328394; c=relaxed/simple;
	bh=caG52ZRp1/jQY4rcSWmiiteqmXt1GTPM57aTXkjfahw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=etc6xBXS9Zt4duJeAurs7OhP+7ZLIWDJZSJ8s5QRYz1dR5LbxtfE5WJM96i/VGjoCsGdSnJJtOML/gkYvFbeMyYzShQIIAFzuxrq0wErhR8w2KmgGGwZ4eLm3rjO9R2s/uqNtGizHAjfdmwrYvv5veXf1gCNJxfmjPOcvfru8WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMlGYcgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E693C4CEEC;
	Wed,  4 Dec 2024 16:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733328394;
	bh=caG52ZRp1/jQY4rcSWmiiteqmXt1GTPM57aTXkjfahw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SMlGYcgT6LjEvSQyZZAmmpLbdC+E5SFhP9pH/8xD3QzyjK2uTP2Jt48fchgvESj/n
	 JSnZraps5oI92bXzCVY8JGAkne2U81os6p1iTDJ9hTt9RLhGPPEfPz03puCkHF900G
	 BKHnKnBxPWfmvXzuIZ5zJAhpFU94FdZ+kEgp/eh/grD36r2X7ZVcAeGQsS+ikBHKX4
	 PfS8VucLsx0jwzsG9AuDofAP+JYN7hOVz+njS7ZZEP94iZoMlb19Zad8vdV5YMC80a
	 12JyoEX/UivDB9RsT/eRVB65Cg3oQovlynY+dviNBkmPazoO4r9LNuHiRoUPaKNWBE
	 a/uIArj/l0ZXQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21599E77174;
	Wed,  4 Dec 2024 16:06:34 +0000 (UTC)
From: Nikolaos Pasaloukos via B4 Relay <devnull+nikolaos.pasaloukos.blaize.com@kernel.org>
Date: Wed, 04 Dec 2024 16:05:29 +0000
Subject: [PATCH v5 6/6] MAINTAINER: Add entry for Blaize SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-blaize-blzp1600_init_board_support-v5-6-b642bcc49307@blaize.com>
References: <20241204-blaize-blzp1600_init_board_support-v5-0-b642bcc49307@blaize.com>
In-Reply-To: <20241204-blaize-blzp1600_init_board_support-v5-0-b642bcc49307@blaize.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 James Cowgill <james.cowgill@blaize.com>, 
 Matt Redfearn <matt.redfearn@blaize.com>, 
 Neil Jones <neil.jones@blaize.com>, 
 Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733328392; l=1011;
 i=nikolaos.pasaloukos@blaize.com; s=20241111; h=from:subject:message-id;
 bh=B8JPdEWFjlJ8iEOYfys3/T/ybAOs8kuytmN42/vy2FE=;
 b=69fm4FjATA2NwB5OGt8iyDk9vJ/CiyV9KeDh/wGTGXFqK24nbZoonpWBIw7h7n36QG+NsR/eT
 ZUX5cmE+gCtCDWs7fkmPLb33xMqw5aS1cLuJ9T70M1GH4NASTaqSw+Y
X-Developer-Key: i=nikolaos.pasaloukos@blaize.com; a=ed25519;
 pk=gGEjGCXdSuvCJPIiu0p0UeiPcW5LC710Z6KGN/dzo3g=
X-Endpoint-Received: by B4 Relay for
 nikolaos.pasaloukos@blaize.com/20241111 with auth_id=274
X-Original-From: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
Reply-To: nikolaos.pasaloukos@blaize.com

From: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>

Add MAINTAINERS entry for Blaize SoC platform with a list of
maintainers.

Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 273a84483b74543b510de7b08804bbd1f6514358..43846a23f9d990ae9fe066e65ed2bdd36376e327 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2238,6 +2238,15 @@ F:	arch/arm64/boot/dts/bitmain/
 F:	drivers/clk/clk-bm1880.c
 F:	drivers/pinctrl/pinctrl-bm1880.c
 
+ARM/BLAIZE ARCHITECTURE
+M:	James Cowgill <james.cowgill@blaize.com>
+M:	Matt Redfearn <matt.redfearn@blaize.com>
+M:	Neil Jones <neil.jones@blaize.com>
+M:	Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/blaize.yaml
+F:	arch/arm64/boot/dts/blaize/
+
 ARM/CALXEDA HIGHBANK ARCHITECTURE
 M:	Andre Przywara <andre.przywara@arm.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)

-- 
2.43.0



