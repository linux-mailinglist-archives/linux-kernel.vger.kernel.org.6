Return-Path: <linux-kernel+bounces-302390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBA595FDAF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 01:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489181F2522B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 23:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B73A19D89C;
	Mon, 26 Aug 2024 23:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b="eDwUlTGy"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060661991D0;
	Mon, 26 Aug 2024 23:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724713666; cv=pass; b=ou0APTzryCDHIoWRpB4Pk+g29HnizxMS4AjZbXmNPKoT0dM/bDASsKiyPU6g5zvkN2fezlrjG7x0LFk1NUFppkG+KHYr6v66/6QG4e3ZcZE27vkFIPYBCf2USo9hbZh2TEXL4eVqTGq4i4CzPo3PjAzAnPHfU2Pa03MXblByAHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724713666; c=relaxed/simple;
	bh=K4fWzeJ/rkIwh9F8V4CmjnuC49aODBjbOhUXF5Jv5b8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UcvHwxCEB87SjwQFtlAGaCoDdlWISgyML9wvX63uZ1FMT9A3HA+ciR0LLNruM4F2e0ddRsSIqeIgwMsXTL+YfGRVXeJg+axiBNXJGQyAapArwrwRMcQh3UBq0MC49CSwAeCOYIGTHR0bO5FQIrgEYQfzjDy77eGja44DB8Ebwa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b=eDwUlTGy; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724713652; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=n30YeZKpctL7lgeuk13iZuXGky6lQYaFw2xu5qLcanLDQavRHZSWWawuFaac7mfJwTjNDoh0Z5JldjHzWYa4uj7u8hLPPVt+D2XrARyjQsPBW/r7co5Nv8xIq0cChBY1tSNA4gRSm4u6oL06gKC802xtzo4NS4iAny5MquTIdo4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724713652; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Z+jAzzzokKHCe3H8TXOmojTHnCSogBwzWxfbfhEDvF0=; 
	b=LOhCs6hHAucsr9CR+MypUz1P8/pXP/ZCw0VoL33T9niOuJBDfCL4VhF6uZ/TJf/gkn4ZvXDht9a9/B7fO3PhYs+aBZIreW3Sqjt7u3qpT0eXAZeJImUlxjJyx5x9m7t6xJ1yieWpX4JWfS2+Zt6ksoDU20PCKqld0G9BDhScPQo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=cristian.ciocaltea@collabora.com;
	dmarc=pass header.from=<cristian.ciocaltea@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724713652;
	s=zohomail; d=collabora.com; i=cristian.ciocaltea@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=Z+jAzzzokKHCe3H8TXOmojTHnCSogBwzWxfbfhEDvF0=;
	b=eDwUlTGyWvOJzKPBvCqVS+oeVzABeGwp4/T1ZpEiygNeDAvvYtGKJ999y1gFIA4y
	CYF09afxAP+NWGud+766H5CiucKdWGFZnzOEkvUbitiKlHdEqGJs30nSwtsNj77n00F
	n/36wRR30Hym/HlogxmN2PApktKi+H8Gc66j7HUE=
Received: by mx.zohomail.com with SMTPS id 1724713650530383.7164698004325;
	Mon, 26 Aug 2024 16:07:30 -0700 (PDT)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 27 Aug 2024 02:06:50 +0300
Subject: [PATCH 1/2] dt-bindings: soc: rockchip: Fix compatibles for RK3588
 VO{0,1}_GRF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-rk3588-vo-grf-compat-v1-1-d4a18acf951a@collabora.com>
References: <20240827-rk3588-vo-grf-compat-v1-0-d4a18acf951a@collabora.com>
In-Reply-To: <20240827-rk3588-vo-grf-compat-v1-0-d4a18acf951a@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>
X-Mailer: b4 0.14.1
X-ZohoMailClient: External

According to RK3588 TRM, VO0_GRF and VO1_GRF have a similar layout, but
definitely not an identical one, therefore sharing the compatible is not
really justified.

Since currently there is no user of this, hence no ABI break, let's fix
it by providing dedicated strings.

Reported-by: Conor Dooley <conor@kernel.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 78c6d5b64138..8fd539125f4a 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -31,7 +31,8 @@ properties:
               - rockchip,rk3588-pcie3-pipe-grf
               - rockchip,rk3588-usb-grf
               - rockchip,rk3588-usbdpphy-grf
-              - rockchip,rk3588-vo-grf
+              - rockchip,rk3588-vo0-grf
+              - rockchip,rk3588-vo1-grf
               - rockchip,rk3588-vop-grf
               - rockchip,rv1108-usbgrf
           - const: syscon
@@ -261,7 +262,8 @@ allOf:
         compatible:
           contains:
             enum:
-              - rockchip,rk3588-vo-grf
+              - rockchip,rk3588-vo0-grf
+              - rockchip,rk3588-vo1-grf
 
     then:
       required:

-- 
2.46.0


