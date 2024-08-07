Return-Path: <linux-kernel+bounces-278305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF59F94AE89
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 539B3B24277
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AD913CA9C;
	Wed,  7 Aug 2024 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f35MBkpF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F241213C669;
	Wed,  7 Aug 2024 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723049948; cv=none; b=P97lOoGaUB3EAC6waCVwQJRfHo0cORpweHGUafnYS1JGMITUzMq5m3tvTaTAgCQT8pU7yHJSh/Pz+aGvz2j7QfNnRnBxnVqTnBbiMG1eB3wRUiF5XLosy6mLb7sr13rdp6Ha46RuKyirDGhDV3dRN2WhMYCD4nFFzzeMMcua1gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723049948; c=relaxed/simple;
	bh=UaXsUImr4cKQLdcaF51ndcRhHmrNsgo83nIbIG1E5Ig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hIXx/q2ywcKbqmlFzqp2yamQqQOAVtcRZ6VXIGWv36UjCuck89L4yqsnNdmGSxTtskTxgdmhaTznO5bmfAdG1AqvWJZUh6ckeoxtl83BDQPLPr7ACYlYCl92lv53tSupyZ2hq4lSdgwzn4llF1W5+CYIInGMELEOGkVSr71PR/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f35MBkpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0FDC4AF14;
	Wed,  7 Aug 2024 16:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723049947;
	bh=UaXsUImr4cKQLdcaF51ndcRhHmrNsgo83nIbIG1E5Ig=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f35MBkpFG927SCO+m+m07w+y/dAnVYMbbqE+rpwkgutGoyWHqJefehCHaZgA6NiTM
	 OyGQp3qbjLEq3MBE1E7mEWJS0vtGTdzei9dnDybUB7imgenusB/AWpHoqV215qLRFE
	 Q3VJgRKRk3vbvl2dag2NAC9gbhIhDGyqkaAEePG3QlRQCDc7/6BjYpnW4EjV6AqYvO
	 kUCwqf7nba468TMpEyElqMO1Xf/r89YLcuARm6TrkdTwV6mzG33DDL/a6zOQT1cZG0
	 kZpWBieQs9SFn9/pbeD9enjFP//dIU/nwKro+9xfdXHpaWl4ZT2IGf96MASyL1V87h
	 10EgUhONazO+w==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Wed, 07 Aug 2024 10:58:53 -0600
Subject: [PATCH 1/3] dt-bindings: clock: mediatek,apmixedsys: Fix
 "mediatek,mt6779-apmixed" compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-dt-mediatek-clk-v1-1-e8d568abfd48@kernel.org>
References: <20240807-dt-mediatek-clk-v1-0-e8d568abfd48@kernel.org>
In-Reply-To: <20240807-dt-mediatek-clk-v1-0-e8d568abfd48@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chun-Jie Chen <chun-jie.chen@mediatek.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.15-dev

"mediatek,mt6779-apmixed" is the compatible string in use already, not
"mediatek,mt6779-apmixedsys".

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml b/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
index 685535846cbb..db5f48e4dd15 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
@@ -35,7 +35,7 @@ properties:
               - mediatek,mt2701-apmixedsys
               - mediatek,mt2712-apmixedsys
               - mediatek,mt6765-apmixedsys
-              - mediatek,mt6779-apmixedsys
+              - mediatek,mt6779-apmixed
               - mediatek,mt6795-apmixedsys
               - mediatek,mt7629-apmixedsys
               - mediatek,mt8167-apmixedsys

-- 
2.43.0


