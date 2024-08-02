Return-Path: <linux-kernel+bounces-272132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 033E09457A3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39678285A5B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 05:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B97C3D97F;
	Fri,  2 Aug 2024 05:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="LhaHG7pg"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F001EB4AE;
	Fri,  2 Aug 2024 05:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722577011; cv=none; b=qF3j4YCqLQExxzQQaV/A4lmdq+zxfaVl5Bay2i/J+7GTG+rgODXf5KRr1vHngQrD1zrk2jaXFJLUDm4bTekf0Ey66ISKWZFUeLZfYslk4wbk28TZvQHA4B9uh27f/LYlKrIjg8BBFEsaVr+prX3kJNNjQEU3zJE1YNRV01LIFYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722577011; c=relaxed/simple;
	bh=fctzEsVVZTuybuCnk9TUPhrRHTzee7hdRm4iRJeYDb0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=M1Q/IwfWgNcmiKfrl1Poh9A1ty+C2YBQEsvg/aaTcOznSni6jd9z1/zpq9Pa1VskSGDQCNf6Od4LpxsqmbUc5V3fwyanC5aoWPlAfQpAEVjPGvgIv5CboCE+5NpvBOYWjcMQ0DSC6HLA+KZuNvr3Jd8hcrMwgGSIeOjt3QF/ako=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=LhaHG7pg; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1722577008;
	bh=Q47qJS2a9PBUFubzmNdKq1lpyf6zLMrCpRsxzpxyTKY=;
	h=From:Subject:Date:To:Cc;
	b=LhaHG7pgSk/HxGfyOUGpotSifTFcQtq68W50Yaw+fj1enh2H6g0mlzc1CyxBClzZq
	 Rtem8xpEUwiXywFpyfZpToreNoj/CV9HKdEN2UrWBqlON20gK+ScEwIB+ATsznk/EI
	 Lzzxu3haF58t2RhyJ0FW3UOVzwRQzBEmo+9c4sPHpNWOE05eH/KAgRUpVELnW4KaZP
	 zVGtOwD8Gd6ttucjMRxfIHQ+Sk6rJtJ+EdPLvDorbMuMVZ6dBzV8vAAcenTKp3/z0X
	 fgA7ZAuoaU+X6791VuAxDiWx+6YaI7APDWYpdHY3RVwuDUXcVLMvqdlIwNeUhOxYqX
	 kx/eIF0nzs/JQ==
Received: from [127.0.1.1] (ppp118-210-29-70.adl-adc-lon-bras31.tpg.internode.on.net [118.210.29.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 30DBE65665;
	Fri,  2 Aug 2024 13:36:46 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PATCH 0/2] dt-bindings: interrupt-controller: Convert Aspeed
 (C)VIC to DT schema
Date: Fri, 02 Aug 2024 15:06:29 +0930
Message-Id: <20240802-dt-warnings-irq-aspeed-dt-schema-v1-0-8cd4266d2094@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF1wrGYC/x2NQQqDQAwAvyI5N7BuXSh+pXgIJqs5dLWJtAXx7
 109zhxmdnAxFYe+2cHko65LqdDeGhhnKpOgcmWIIXbhESLyhl+yomVyVHsj+SrCp/Zxlhdhykk
 yJ+7uLUHNrCZZf9fiORzHH8rbwqhyAAAA
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
X-Mailer: b4 0.14.1

Hello,

This short series converts the Aspeed VIC and CVIC bindings over to DT
schema. The CVIC has historically been documented under "misc" as it's
the interrupt controller for the Coldfire co-processor embedded in the
SoCs, and not for the main ARM core. Regardless, I've updated both in
this series.

I tried to document the historical oddities and conversion quirks in the
commit messages where appropriate.

Please review!

Andrew

---
Andrew Jeffery (2):
      dt-bindings: interrupt-controller: aspeed,ast2400-vic: Convert to DT schema
      dt-bindings: misc: aspeed,ast2400-cvic: Convert to DT schema

 .../interrupt-controller/aspeed,ast2400-vic.txt    | 23 --------
 .../interrupt-controller/aspeed,ast2400-vic.yaml   | 63 ++++++++++++++++++++++
 .../bindings/misc/aspeed,ast2400-cvic.yaml         | 60 +++++++++++++++++++++
 .../devicetree/bindings/misc/aspeed,cvic.txt       | 35 ------------
 4 files changed, 123 insertions(+), 58 deletions(-)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240802-dt-warnings-irq-aspeed-dt-schema-5f5efd5d431a

Best regards,
-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


