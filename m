Return-Path: <linux-kernel+bounces-278867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA10594B5D1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 06:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F20031C21B01
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 04:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E40E84D34;
	Thu,  8 Aug 2024 04:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="AR/nq4T3"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6567F484;
	Thu,  8 Aug 2024 04:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723090489; cv=none; b=HpFqpWa9+aRGylQEUclrDYx0ZqoG61vKAmyZxHB1Mz/I4ActyShpGO7dnnM1C+O77HyenSNWoO3y496fUg9aytems/Tdwv7Oa0TZU/QY60tMQqwt+D44HhY+msSl8JuLp+EpkHDd5i2raEEIk7e45lgu3NOvjZ5BmnZASP0BuAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723090489; c=relaxed/simple;
	bh=gHPoEeufEVkudtSEDULOZsQrvCv8dq1jgF9iCMZPcjE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fIHtY6lFDn8LXuspvOkDTa+zEdzCJ/Rq/y3p70S5SOahuuEg+g5MjlkDD4tfyLst5Cj7xI/tz325dQLjYNgNgT4mtt+hAftJZcNGyofeSiabO6qCZ57bP5pzP1M10oBTZKhkDTEciaxpdrjH1t0ad1zD+BIxMq7hVRm8VRwNKOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=AR/nq4T3; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1723090486;
	bh=n3sZ4FsOpgBw2cpkxzXazcULuROCyRckfFE8WrKc23c=;
	h=From:Subject:Date:To:Cc;
	b=AR/nq4T3O36j2aPSH1YxOzliZ0Qdgq9WcseuCgPmIupAGuOvs7srJsccs9k33u6Ie
	 5vbN65GDaqWjfSoiCeNBdmbcRAT0wgJvHfYqonn6Dz1BPTsww7BuvDFEpMnwTmsth0
	 od7cGfbOdG8EHRvatmlXdLtHFGHeAVERDJKHkVLti1A4oxCT29tNeBM0WfWJfUhX5L
	 OPpJSqWN+dtEn15bpHag+HNMPW4rOkHyl9Y7SK2buA9CFAMyKJ7yyCCBXyEgFSr5Ih
	 STAx3nryVgYzW2dnKMcCMNY72yisErw2BO/70gFlE63UU4PviL87REmXQjcKULHbg6
	 VfcUOQdxSUKqQ==
Received: from [127.0.1.1] (203-57-213-111.dyn.iinet.net.au [203.57.213.111])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 65FFE654E9;
	Thu,  8 Aug 2024 12:14:45 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PATCH v2 0/2] dt-bindings: interrupt-controller: Convert Aspeed
 (C)VIC to DT schema
Date: Thu, 08 Aug 2024 13:44:23 +0930
Message-Id: <20240808-dt-warnings-irq-aspeed-dt-schema-v2-0-c2531e02633d@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB9GtGYC/5WNQQ6DIBAAv2I4dw1SNLan/qPxQNhV9yBYQNvG+
 PeiP+hx5jCziUiBKYp7sYlAK0f2LoO6FMKOxg0EjJmFkkrLVirABG8THLshAocXmDgT4aGjHWk
 yUPc19VijvlZG5MwcqOfPuXh2mUeOyYfveVyrw/4RXyuQ0FrUqmlQyZt+WI9kvYspLDaV1k+lW
 US37/sPWyakwtsAAAA=
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
Changes in v2:
- Address feedback from Krzysztof
  - https://lore.kernel.org/r/c51fb027-f8bd-4b10-b9c0-dbbe8e8cf4c1@kernel.org/
  - https://lore.kernel.org/r/ec19fe07-84bd-4c32-a886-e6126af52f4c@kernel.org/
- Address feedback from Rob
  - https://lore.kernel.org/r/20240806172917.GA1836473-robh@kernel.org/
- Link to v1: https://lore.kernel.org/r/20240802-dt-warnings-irq-aspeed-dt-schema-v1-0-8cd4266d2094@codeconstruct.com.au

---
Andrew Jeffery (2):
      dt-bindings: interrupt-controller: aspeed,ast2400-vic: Convert to DT schema
      dt-bindings: misc: aspeed,ast2400-cvic: Convert to DT schema

 .../interrupt-controller/aspeed,ast2400-vic.txt    | 23 --------
 .../interrupt-controller/aspeed,ast2400-vic.yaml   | 62 ++++++++++++++++++++++
 .../bindings/misc/aspeed,ast2400-cvic.yaml         | 60 +++++++++++++++++++++
 .../devicetree/bindings/misc/aspeed,cvic.txt       | 35 ------------
 4 files changed, 122 insertions(+), 58 deletions(-)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240802-dt-warnings-irq-aspeed-dt-schema-5f5efd5d431a

Best regards,
-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


