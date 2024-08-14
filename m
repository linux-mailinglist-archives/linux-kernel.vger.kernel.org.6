Return-Path: <linux-kernel+bounces-287190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06094952477
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C661F22347
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4117F1C8222;
	Wed, 14 Aug 2024 21:07:34 +0000 (UTC)
Received: from gollum.nazgul.ch (gollum.nazgul.ch [81.221.21.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9C044C93;
	Wed, 14 Aug 2024 21:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.221.21.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723669653; cv=none; b=slAp1JI9+9UArOuV7GYz7alddou8DD8DYwAdHeIoNDcsGXmC/L57c0y2SD1N7ecYiD3tS6wq/d9kru8wEgSy5NckY3Cc/GPAeXP74poP/N3tbQWRUNBx2mUdmNfieLzZzLIXJv0mrpMDDIfFuXpkk6ucpC8stzcawUZxBSUo95s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723669653; c=relaxed/simple;
	bh=DRCh9Hn/zBfgF1mCF83AaVJu3s25m6zEa/bsiaWDkG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCZPD6Sf+vbJbLYh+UcrzlUTBvFyaC/l7Wxgo6jB30284N8KtYwGwM10GmUGzSYzX4j1boKReUnFwgCTokuezjyevK7nDEz3mu3WX9nDRXbQGufZsNga1+ssjV1c882TzvTZYckprL2K6oxdGhX1Yh7hORU2XuIDEoFbIKM/LG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nazgul.ch; spf=pass smtp.mailfrom=nazgul.ch; arc=none smtp.client-ip=81.221.21.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nazgul.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nazgul.ch
Received: from localhost (gollum.nazgul.ch [local])
	by gollum.nazgul.ch (OpenSMTPD) with ESMTPA id e8d2b82f;
	Wed, 14 Aug 2024 23:07:27 +0200 (CEST)
Date: Wed, 14 Aug 2024 23:07:27 +0200
From: Marcus Glocker <marcus@nazgul.ch>
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH v2 3/7] dt-bindings: ufs: Add X1E80100 UFS
Message-ID: <ibcigppkrnjwieuvcptyirr4vm5gh344arvbeayj6u5u5szww4@r4dozcooazm4>
References: <qv5pz4gnmy5xbxxjoqqyyvn4gep5xn3jafcof5merqxxllczwy@oaw3recv3tp5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qv5pz4gnmy5xbxxjoqqyyvn4gep5xn3jafcof5merqxxllczwy@oaw3recv3tp5>

Add the UFS Host Controller binding.

Signed-off-by: Marcus Glocker <marcus@nazgul.ch>
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index 25a5edeea164..4cb3fea53651 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -41,6 +41,7 @@ properties:
           - qcom,sm8450-ufshc
           - qcom,sm8550-ufshc
           - qcom,sm8650-ufshc
+          - qcom,x1e80100-ufshc
       - const: qcom,ufshc
       - const: jedec,ufs-2.0
 
@@ -121,6 +122,7 @@ allOf:
           contains:
             enum:
               - qcom,sc7180-ufshc
+              - qcom,x1e80100-ufshc
     then:
       properties:
         clocks:
-- 
2.39.2


