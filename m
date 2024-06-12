Return-Path: <linux-kernel+bounces-211580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5449053F8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18A51C21B56
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F5E17C221;
	Wed, 12 Jun 2024 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="9lVaHZr1"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022241E504;
	Wed, 12 Jun 2024 13:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718199667; cv=none; b=Yop105R492LmzR9MgzpHuNzSm/x0jxOZO2n34GlwFJX/fvqlXAMyrrdKRpoPr1n3NajJKIw88onS4dvHj5/1ecDmgByB1S2mqkLm0anCV0My48MOw2m8eIievR6UZ4yThyUd/e89Mp+ISi2UnfrugwlM8xCLrjANwI24N9S1P2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718199667; c=relaxed/simple;
	bh=rGWf+w+rturQX2oah7uG1AEKjnikf8FueP/zGF71AWg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ll8zh9v7Qh7C+RJww+UCUha4EuJHZuzMLFI5K8NoSkL/vUhhTwWJ6w+QT4UUxiRxyJbWbVTYEjatJCDGwKu8P0NGIaE1fFSeDFBrMw6SNdG9/oHfsV3pfV08daBjN2hZqjbShS7F8rvTrKWJ70zdPc/giPCEIndZsUnjGWATN64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=9lVaHZr1; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sHODh-000AQN-0F;
	Wed, 12 Jun 2024 15:40:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jL3wOsioD05vDk+rRBWPQoWDH3FkAa9RJ8Mq+o8sLvY=; b=9lVaHZr16t0OuVvSiFYndqFjTS
	YSPsFVQm6gwXQJyjLGW14jxQM/dOGGWaJGsgsZVmiKo4mf1Rb02SjhOu3++iUIww4WAWJHjQKY0wf
	RNQgMA9JS6Tud74zjHNyhc2YbHaW6P5PDSDJsJ4LzNAUrPspLTgC0SW4NdNVY3FKPM3ITZKHjUN2H
	qhloAgKVOlL82L/rrqQ3uHbxSsQ1PxXaY2HyW0tk6N4cPqcW+oLfHvpcReQwEzWerFUV3G9q2Ftox
	8y/sGylwev4lnWXU51T2/d+iFsE/+L87prRszX2dYVEB6hVw++W3U6W0Ijoh2UapGlyC6CrHX2XY6
	hZBTiU8g==;
Received: from p200300c20737c2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:c2:737:c200:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sHODd-00347C-1C;
	Wed, 12 Jun 2024 15:40:54 +0200
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sHODd-004ZWG-1f;
	Wed, 12 Jun 2024 15:40:53 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: lee@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andreas@kemnade.info,
	broonie@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH -next] dt-bindings: mfd: twl: Fix example
Date: Wed, 12 Jun 2024 15:40:39 +0200
Message-Id: <20240612134039.1089839-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix example to also conform to rules specified in the separate
not-included gpadc binding.

Fixes: 62e4f3396197 ("dt-bindings: regulator: twl-regulator: convert to yaml")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 Documentation/devicetree/bindings/mfd/ti,twl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
index 2cbdd238f48f..e94b0fd7af0f 100644
--- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
@@ -225,6 +225,7 @@ examples:
         gpadc {
           compatible = "ti,twl6030-gpadc";
           interrupts = <6>;
+          #io-channel-cells = <1>;
         };
 
         rtc {
-- 
2.39.2


