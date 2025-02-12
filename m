Return-Path: <linux-kernel+bounces-510822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7635DA3228D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D9D3A8FBD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1431C207DF8;
	Wed, 12 Feb 2025 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="okQKh0iU"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B72207A20;
	Wed, 12 Feb 2025 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739353013; cv=none; b=YdXmR9Dnib2WtiJA8dc+SLrdViItCEuyO7I0Wn2kiecINiezabB8ye4G2rlu9Yrq177m//IVsmGUkAp+b9ecxr1G5kVSuxOhR7R8OeFz8PSpokgMSlPK7henBmYe6Nt1fd9BDfdKQVDLYllG8TEfNWFSiWOSOWjTcdx5KZJ18H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739353013; c=relaxed/simple;
	bh=djWsWjg0S9oMhoI7aouvBl77d3FEFDIiyx3E6y9FBcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRabZSK5Xja6MrZPaAG72Fy8DF5+m0qta4h+wAiSOUc7DC+5vdT7/xonSLrQt38xiegIbRs0FHHItj6Gjc8iJcfDYDZuTesjkAaTWgGqwTdAb5GjWxnGqflLjnbS/RKc6cYQvU4pomRU4NYL+Wr54spqHqZYkjw26CMf12wuJBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=okQKh0iU; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=x5wpq
	KJUmSg4bQV96jwM4c9cPSXvq7N01GUYeXUKlfk=; b=okQKh0iUdQ64yIaPM7a99
	ar3uuLYT3C/HzkwQg6KkU2k8fCAs6ZdJaVh0VU7ua7cQ5XwN6Ja/bxUTJSGyIQNN
	zm30Rq9gxGIU6p5kURX/GPghC5NO5Nxha0P/0RvORO0HPPqjAVF43d8NZqOmNu2Y
	xLB0t8dgwxlGX/3sSMFT04=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBn8FORa6xniPPgLA--.46093S2;
	Wed, 12 Feb 2025 17:36:20 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	derek.foreman@collabora.com,
	detlev.casanova@collabora.com,
	daniel@fooishbar.org,
	robh@kernel.org,
	sebastian.reichel@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v14 11/13] dt-bindings: display: vop2: Add missing rockchip,grf property for rk3566/8
Date: Wed, 12 Feb 2025 17:36:13 +0800
Message-ID: <20250212093615.53023-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212093530.52961-1-andyshrk@163.com>
References: <20250212093530.52961-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBn8FORa6xniPPgLA--.46093S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF4fZw43KFWxury3JF43KFg_yoW8Gr43pa
	93CFWDWay0gr12qw1DtFn5Cr4v9F97Ca1UJFs3G3WIywnIgFn8Ka4agrn8XF4UGF4xZFWf
	ua1Ygry5trs2vr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnhL8UUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqRrxXmesZ5VM2gAAsz

From: Andy Yan <andy.yan@rock-chips.com>

The clock polarity of RGB signal output is controlled by GRF, this
property is already being used in the current device tree, but
forgot to describe it as a required property in the binding file.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

(no changes since v13)

Changes in v13:
- typo fix
- Explain the function of this property.

Changes in v12:
- Split from patch 10/13

 .../devicetree/bindings/display/rockchip/rockchip-vop2.yaml   | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
index a5771edd83b5..083eadcf0588 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
@@ -146,6 +146,9 @@ allOf:
         rockchip,vop-grf: false
         rockchip,pmu: false
 
+      required:
+        - rockchip,grf
+
   - if:
       properties:
         compatible:
@@ -200,6 +203,7 @@ examples:
                               "dclk_vp1",
                               "dclk_vp2";
                 power-domains = <&power RK3568_PD_VO>;
+                rockchip,grf = <&grf>;
                 iommus = <&vop_mmu>;
                 vop_out: ports {
                     #address-cells = <1>;
-- 
2.34.1


