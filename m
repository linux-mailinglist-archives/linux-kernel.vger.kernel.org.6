Return-Path: <linux-kernel+bounces-431597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 735CC9E3F45
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D5E282E2D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F7E20D4FA;
	Wed,  4 Dec 2024 16:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Px9j/j1R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486B320C00C;
	Wed,  4 Dec 2024 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733328394; cv=none; b=O4lBXMy5CbB2XwAZsC+5ppLGQrZriwlcEF9l/LX60VgSiJ2Ale//gGpxbvssIMHg/VEejWxLBkDIx6ewKwl+l/86gJH6i2Z/tJQtZvE/Y61215pXlcBPPuhIefbmvVio7+/kLJLPxYAB/na4xcxJEQjwbZbxXCsvfDCzV+Zs6VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733328394; c=relaxed/simple;
	bh=HNblYFGy1Ig37KXJlD6WXui3N0XjQbqGnX6arBwFr9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B6apyjMZPIccNh74GPHsIWdFUPNHOurJjiGAuDtMjQt6Z2WHuzfOJIgcZnn+JgSmtiWh/dCsAkdPJlM5QGRppBtuXUy3N+E9iVg8Ny/vzE/cE0kWK2xJFdCSbgsTATe/j4vog7rfvw7qCjkJ/OqUkKK/ycVJoTEKyE8gEFVBasY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Px9j/j1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC34FC4CEDF;
	Wed,  4 Dec 2024 16:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733328393;
	bh=HNblYFGy1Ig37KXJlD6WXui3N0XjQbqGnX6arBwFr9Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Px9j/j1RYWiymXMQuwRWRP1t0khCqGyFfnLMx98swNGzusdiUxG+KZjFMP173VjxM
	 6DEtbx7H45nkpLzaSDf/t+ilxtmUMeYSJ2mVvfEpOjFTYxuGzdExt5y0NOP3ExS/zD
	 ylRaiKa9/k9055RDcWvCPIT3N0mHcwpq3xOsQKaQEoRi76jvsawthlaOgKZaMpFIRb
	 MrABEiVVNfE2jMZ/B0/s9XjzPbS4hoevz3q0otO4IHA2Fh0uqTH1Pp5dgwbQT5nDFd
	 753501H+cxKBpXhZgU//4gvwXQBlV0UhZn/ywALiR8Wu4c8cKT11wTvXwZZVAUL3wn
	 jqLDQpEzJSFtg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B18E7716B;
	Wed,  4 Dec 2024 16:06:33 +0000 (UTC)
From: Nikolaos Pasaloukos via B4 Relay <devnull+nikolaos.pasaloukos.blaize.com@kernel.org>
Date: Wed, 04 Dec 2024 16:05:24 +0000
Subject: [PATCH v5 1/6] dt-bindings: Add Blaize vendor prefix
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-blaize-blzp1600_init_board_support-v5-1-b642bcc49307@blaize.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733328392; l=977;
 i=nikolaos.pasaloukos@blaize.com; s=20241111; h=from:subject:message-id;
 bh=1p4NJqsf17xN5CcZrMIAnl7jCYm1QXfL6oCC9V0Tk3w=;
 b=64y+oANFB0qQeuvkTUwTBMYbGMUUYnye9j461IexzjJ3LzVVGMKHRB8OKKbjV+SjZIL33zGBK
 ErfzePQmuiWCkbKLCNzjqpIJKUpD9tO7Fv5YXop3zeoCbjx20OilcNE
X-Developer-Key: i=nikolaos.pasaloukos@blaize.com; a=ed25519;
 pk=gGEjGCXdSuvCJPIiu0p0UeiPcW5LC710Z6KGN/dzo3g=
X-Endpoint-Received: by B4 Relay for
 nikolaos.pasaloukos@blaize.com/20241111 with auth_id=274
X-Original-From: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
Reply-To: nikolaos.pasaloukos@blaize.com

From: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>

Blaize, Inc. (www.blaize.com) is a SoC manufacturer with integrated
programmable Graph-Streaming-Processors for AI and ML.

Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b320a39de7fe40ce4d97ed3ea264a5971a3428dd..809086061a1992567ca6c5d404fbcee8a33ee300 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -216,6 +216,8 @@ patternProperties:
     description: Shenzhen BigTree Tech Co., LTD
   "^bitmain,.*":
     description: Bitmain Technologies
+  "^blaize,.*":
+    description: Blaize, Inc.
   "^blutek,.*":
     description: BluTek Power
   "^boe,.*":

-- 
2.43.0



