Return-Path: <linux-kernel+bounces-358304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BB7997CE7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265951F21B3B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3324E1A0AF5;
	Thu, 10 Oct 2024 06:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="FBLJx+90"
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492F91A08D7
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728540898; cv=none; b=CpsUuzi3o/ZA6sOT0Fj3i4zYzCv9RYTM0nRMiARWevUjXYVpktMte7w7TskI44nACp9lkiKT4D3mZh7I873qtSCZ9bLt8rc+SrYMCkX+4ADNwndY89/Iz+YPAkutSBtbwT7EbgV3XtTS4FtfQe6rrufiotwjhLBtgBwYJ+QVMeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728540898; c=relaxed/simple;
	bh=GIiLQpkrk3XbyXxRJJXWPSMENYra2FRF/6UBONzETLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dg4ZPufeX9uHy49isoVd2WCcPQ3REPfa+ygjgTqo8yCCOaGr6f8J8dlGrcUjTzUeWlM7ysy6X5OV0BJ3Njdp61HDVQ/U3XMLpoBhbQC6bdblRkEl9d4jVNI1Sji6F2eg6alOg8kiXBKQSzxpKiMcKfHOWwyk6LGDjnECzyLXKNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=FBLJx+90; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id yAads5hWqumtXymRssqLTH; Thu, 10 Oct 2024 06:14:56 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id ymRnsRfIfWvXpymRospIx6; Thu, 10 Oct 2024 06:14:53 +0000
X-Authority-Analysis: v=2.4 cv=LtdZyWdc c=1 sm=1 tr=0 ts=670770dd
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=DAUX931o1VcA:10 a=-pn6D5nKLtMA:10 a=XYAwZIGsAAAA:8 a=vU9dKmh3AAAA:8
 a=nPfK9_phII_aSBalXXwA:9 a=E8ToXWR_bxluHZ7gmE-Z:22 a=rsP06fVo5MYu2ilr0aT5:22
 a=ZCPYImcxYIQFgLOT52_G:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=hu8xWMKzlaXjBDCvE/mGkbI3wbW/ZR2+HRUEztqxcvI=; b=FBLJx+90JqcxYGs3/tN9lCExm0
	h+I2C+4E0rFWBpS3u+2jEHsvJyn+kmAH46MGJmBiolBj+WJE3xA8lAttZvHjWK5fgpBmFkDH3Ob6y
	b968gI3YX8vHlQUxorMjhpESSWOO4f56sCKuB1ITwmWX4W5c/uXU9bK2AiVKnM5kd0i67aiEx1Y8A
	/Q0DgibLzDJUEqOoBajxiZWkFjauRKaxSiVTPnm3Us3fLgvhSydScQtI0ysHuRs4fs3c0LqCOIDU7
	EjT+2HVyaCdY16rqny24lLhRgyYmTRG8Ui0EE5tWJBji94sduArYMZFadznj/GZF0i7TkNSaP9/jE
	EUUIr4Jg==;
Received: from [122.165.245.213] (port=36152 helo=localhost.localdomain)
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <karthikeyan@linumiz.com>)
	id 1symRl-001l4I-2G;
	Thu, 10 Oct 2024 11:44:49 +0530
From: Karthikeyan Krishnasamy <karthikeyan@linumiz.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Karthikeyan Krishnasamy <karthikeyan@linumiz.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH 1/1] dt-bindings: watchdog: rockchip: Add rockchip,rv1126-wdt string
Date: Thu, 10 Oct 2024 11:44:08 +0530
Message-Id: <20241010061408.1351865-2-karthikeyan@linumiz.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241010061408.1351865-1-karthikeyan@linumiz.com>
References: <20241010061408.1351865-1-karthikeyan@linumiz.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 122.165.245.213
X-Source-L: No
X-Exim-ID: 1symRl-001l4I-2G
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [122.165.245.213]:36152
X-Source-Auth: karthikeyan@linumiz.com
X-Email-Count: 12
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKaqFQrtSRH4WP4+7MKrHoU4iDMdVkk2PXoE3BWG0h7ytOLmB3+7IIrkHmYPSlfroyAPlo4q8rzomBTQgOQYwWNcIf/ID1VDwqDuEo/12FYNWuSgPnaU
 s4yUF8zvVQZIZ88CnY0r81YEuMAcy4adYLv8NnF+b+3ij2lZKM1NmEmfDwpRyqMnKqhTnyZF9u8C4oVIwHm3tgCuiWEm8Uec1ivzgUsrgttRvhkUI4A4F7Gf

Add rockchip,rv1126-wdt compatible string.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Karthikeyan Krishnasamy <karthikeyan@linumiz.com>
---
 Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml b/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
index b5a3dc377070..1efefd741c06 100644
--- a/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
@@ -32,6 +32,7 @@ properties:
               - rockchip,rk3576-wdt
               - rockchip,rk3588-wdt
               - rockchip,rv1108-wdt
+              - rockchip,rv1126-wdt
           - const: snps,dw-wdt
 
   reg:
-- 
2.39.2


