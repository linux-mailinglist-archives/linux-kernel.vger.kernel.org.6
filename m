Return-Path: <linux-kernel+bounces-302202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9282795FB16
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2C0285FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C931F19AD6A;
	Mon, 26 Aug 2024 20:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="NFBnTEFW"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [164.92.70.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9040F19AA68
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 20:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=164.92.70.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705769; cv=none; b=jbHIehWC3Tpr/pJfhs/48kpZveUDQ+BaNV7Pq/o1WQlWAUwxB1fQUUO5YYdHldaaJrGMvxmn25+Xj4XI0LPEv3eM7NOPM1N6UzgNls6Q9I3z8jLdCUUO6vV+2P/+Iix7UYkuoz+ZbQ/ybR8lCuUlDKgZhPsZG02UyiTOgUyMO6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705769; c=relaxed/simple;
	bh=K0YfMliLQQYFYwlNtUdx3HzfYviemDJqmCnRhDcOKB0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Ppvrau9aVAolgnRE/lD/Hs7epn2pjCO3NO+qQDwoOFUmlfyAEMia6iKqwHlcWtE+9d8/ERcmoblHqKCCqcwR1ANNfgzHt9zkmfzBkIZ+fk8uLEmuR3pz1zk5doAINFbO+gVBksQk8hk6k18fh9rQYYl1fkLatTboLAtuFDDSYqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=NFBnTEFW; arc=none smtp.client-ip=164.92.70.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To: Date:
 Subject: Cc: To: From: Message-ID; q=dns/txt; s=fe-e1b5cab7be;
 t=1724705752; bh=QE6Aq8bnHBC1OjVxEErZVqRlh4BvsLQkZl5goBAhUms=;
 b=NFBnTEFWH44WPUZGPMqlWqAG0Rgt0cISadJsdH93Qxc8vvvidHFQDAHFT50gKEtYn5F22B0ys
 Wl6jgnwDUNe+lrrzo+NmmlX002yrCd0T6CwvLfru2S+KMzJEWsLVrcSlLEHTq6rFZQ3Mn2Z9B09
 CBIO2Q6j/RX1ztZQmwiqoa/WpHHAU6Ui6WUnLLbeiIn1GAPixPgn8NO33OCkdXLJz0CTZQ61Hvq
 KV7fUnRouLeClrELLOCFDl4x3VtX6FfikdstJM5hH2F5lW0GA9mCLLi6iQJoMVqbIt1CKwZO/Vv
 JWEUWPBkrIrOpgmCl9OVNdPYDak9oKcn1GCtziVliPOg==
Message-ID: 20240826205538.1066103-2-jonas@kwiboo.se
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aurelien Jarno <aurelien@aurel32.net>,
	Dongjin Kim <tobetter@gmail.com>
Cc: linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4] dt-bindings: arm: rockchip: Correct vendor for Hardkernel ODROID-M1
Date: Mon, 26 Aug 2024 20:55:28 +0000
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240826205538.1066103-1-jonas@kwiboo.se>
References: <20240826205538.1066103-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 164.92.70.200
X-ForwardEmail-ID: 66ccebd8e59276ede820347c

The vendor prefix for Hardkernel ODROID-M1 is incorrectly listed as
rockchip. Use the proper hardkernel vendor prefix for this board.

Fixes: 19cc53eb2ce6 ("dt-bindings: rockchip: Add Hardkernel ODROID-M1 board")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 1f23b8b05a8f..f08e9f2f5dfc 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -595,7 +595,7 @@ properties:
 
       - description: Hardkernel Odroid M1
         items:
-          - const: rockchip,rk3568-odroid-m1
+          - const: hardkernel,rk3568-odroid-m1
           - const: rockchip,rk3568
 
       - description: Hugsun X99 TV Box
-- 
2.45.2


