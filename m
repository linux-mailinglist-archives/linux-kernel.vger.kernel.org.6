Return-Path: <linux-kernel+bounces-352031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3A5991948
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 185731C2115E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 18:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BB515AAB6;
	Sat,  5 Oct 2024 18:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="UVzUTy9J"
Received: from st43p00im-ztfb10073301.me.com (st43p00im-ztfb10073301.me.com [17.58.63.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CDB146592
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.63.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728151746; cv=none; b=dwsxYiCVzh54zC9wC3ITxwyGP6ULLLCN2auQrL1j5jepE3U+kOvFLNerqvMSPODFgO8Y+pA6e//KJvOSSpmTL4sTGFOJGjvDI6SteZ6Agz0GcOtrM876yuu5hGDteNlhcH9q67ybW/6DkjC5hXkz2Bh2sGZCPl0fGmR7Y2+RauM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728151746; c=relaxed/simple;
	bh=N2pYXR+knlcJPpetAkI+NQV3wdPyAgupkfzyx1tJfwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZVWRFCIr+xPoRVmgLetbmmAPNH0//dbSVwXddCFz6ZkRYMpzrM25Wmvbhqf0Hs591QTfs18Cq0tcitzeaJLEj5LPJRQJu1w/CVhuKu6Ei76ZxKIxXwn4ib4NhaH70CSPmfO6dnWKbm5dTvXm6SLTPETCjgAMVCKxEJK38+q51Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=UVzUTy9J; arc=none smtp.client-ip=17.58.63.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
	t=1728151743; bh=ZhPhTWXU0skZ/HI5SHs4S26BqfVlCdZwrR6/Jdzn/1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=UVzUTy9J125gWcUUi36KbsFcgE0jnAAuaMXuR6pQwANwxQIP+huBV4igvtfIOR6Jw
	 ZuEsjx3yU4KL40ivjJV6ydON5CRJrGnq+/Y3H/GapenBTbLKD+jG+uTB1tdhxGsJbi
	 sTETT1ZwXxEyydOxOdRMDdbcSi9gzEy0V60kT0RfReLLQfZsnbSPiWMoqU8frYCCC7
	 sOEF4/jYM/4pF4ZU4IVrB2vV343n7IQLbrbh9/jrEFRpviiJkMxFLMgFC+sSoU3ICL
	 Ui9+QcONknIcbuRZXksNX3StH0YaoXtlu516iD0UbbgRwceLFLZSoMwPskmn9ro2FH
	 bMGlFRveg4H1A==
Received: from localhost (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-ztfb10073301.me.com (Postfix) with ESMTPSA id 414A88001DC;
	Sat,  5 Oct 2024 18:09:01 +0000 (UTC)
From: Alain Volmat <avolmat@me.com>
Date: Sat, 05 Oct 2024 18:07:59 +0000
Subject: [PATCH 1/3] dt-bindings: gpu: mali-utgard: Add ST sti compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241005-sti-gpu-v1-1-9bc11100b54b@me.com>
References: <20241005-sti-gpu-v1-0-9bc11100b54b@me.com>
In-Reply-To: <20241005-sti-gpu-v1-0-9bc11100b54b@me.com>
To: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Alain Volmat <avolmat@me.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: lJDHjayoU8Hude1I6tz2rld_PMnry1X6
X-Proofpoint-GUID: lJDHjayoU8Hude1I6tz2rld_PMnry1X6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_17,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 suspectscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 mlxlogscore=726 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410050133
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

ST STi SoC family (stih410, stih418) has a Mali400.
Add a compatible for it.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
index abd4aa335fbcebafc9164bd4963f9db60f0450c4..97a7ef0fea1a10df0ff485b9eb4468f44c92da39 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
@@ -33,6 +33,7 @@ properties:
               - rockchip,rk3188-mali
               - rockchip,rk3228-mali
               - samsung,exynos4210-mali
+              - st,sti-mali
               - stericsson,db8500-mali
               - xlnx,zynqmp-mali
           - const: arm,mali-400

-- 
2.43.0


