Return-Path: <linux-kernel+bounces-287187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23FC95246E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113AB1C21C56
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53051C7B95;
	Wed, 14 Aug 2024 21:05:33 +0000 (UTC)
Received: from gollum.nazgul.ch (gollum.nazgul.ch [81.221.21.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AFE1B0125;
	Wed, 14 Aug 2024 21:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.221.21.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723669533; cv=none; b=UhXXxG11lpI2/GtSltohHcdAPZI1JXcLRApIFPuBqdc1Uqifl0+2Axw6hyUeKZ1WD5QuObgfwRJIe1ZPOjDDXrFszFvVdJk7q5QRcDbxFeN4SQwSPJpe3Qn0Ugfz1MWywnA4LkZutI2RW0R7Qbh0lajKpxYL7XXV0FAu0/aPFDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723669533; c=relaxed/simple;
	bh=K3T72pgKPBxV99BAtdZHb5OXhMtbJhQV9EmaBVy+ifc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqEi1WD26R8eJHp/noNnv94Sf1IHHvMVuk2Jm494C1x66hxv5UgBkUQ4T3WSZGPkeQWlYIx7WueXOYQpcv0ZkFz2kdbpVPRgIsVdO2UqNCsytYp050b6UhhjhYdRrbHQOpy13INIWRSIuYU1M2UWKDM48QB9blpEEXShgM6C7ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nazgul.ch; spf=pass smtp.mailfrom=nazgul.ch; arc=none smtp.client-ip=81.221.21.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nazgul.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nazgul.ch
Received: from localhost (gollum.nazgul.ch [local])
	by gollum.nazgul.ch (OpenSMTPD) with ESMTPA id 3bb9556c;
	Wed, 14 Aug 2024 23:05:28 +0200 (CEST)
Date: Wed, 14 Aug 2024 23:05:28 +0200
From: Marcus Glocker <marcus@nazgul.ch>
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH v2 2/7] dt-bindings: phy: Add X1E80100 UFS
Message-ID: <isui6xo43vgpfy2kqlxoi5bfneenqllzw3fe2g7a2ccsgqlev7@ek4im7muo6rz>
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

Add the UFS PHY binding.

Signed-off-by: Marcus Glocker <marcus@nazgul.ch>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
index f9cfbd0b2de6..c8a61cddb311 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
@@ -35,6 +35,7 @@ properties:
       - qcom,sm8475-qmp-ufs-phy
       - qcom,sm8550-qmp-ufs-phy
       - qcom,sm8650-qmp-ufs-phy
+      - qcom,x1e80100-qmp-ufs-phy
 
   reg:
     maxItems: 1
@@ -102,6 +103,7 @@ allOf:
               - qcom,sm8475-qmp-ufs-phy
               - qcom,sm8550-qmp-ufs-phy
               - qcom,sm8650-qmp-ufs-phy
+              - qcom,x1e80100-qmp-ufs-phy
     then:
       properties:
         clocks:
-- 
2.39.2


