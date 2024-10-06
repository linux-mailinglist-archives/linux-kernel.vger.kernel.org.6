Return-Path: <linux-kernel+bounces-352598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2A6992141
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 22:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7E3281C48
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 20:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E42918A6AD;
	Sun,  6 Oct 2024 20:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="y97SzS0i"
Received: from st43p00im-zteg10063401.me.com (st43p00im-zteg10063401.me.com [17.58.63.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3521F1482E2
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 20:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.63.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728247400; cv=none; b=kz593ybTx0HcAbnmnJVu/pK6UH/fZwfkhLr4bpQ4EMuxPlvtYIWshAndJCd//MSgT2pHcWbjv/AWbJ4kXo64wyL+GnKH4Dw9IcB8D3So7MMUXZddc25Pt17baUslM76wGF0Nj26m6YQ1MB2s24Wwna3Hd78LqLho1EFkFyvkol0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728247400; c=relaxed/simple;
	bh=4uVnpohVRwJo+OO7Cd5kF0q/k4lXGmVtP26ItHvFWiE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eFjZc9nRQRI+XQS7LLUh/t0nfO+ecidkuE03i2MM3g1+atjRea1nVc9v8eR3aE7AWzWofIlViFSla7KukXmY7mdbYUiGFG6c31v1YzMonzAu2z1xzdKmdtg8q0em/sjIIeONufpk6VLrt4fK8UyWtcx86pLyvFcTJKPNiogmt54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=y97SzS0i; arc=none smtp.client-ip=17.58.63.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
	t=1728247398; bh=lLvj4KTKZ8sDf9++iN7YmwSkmBPSmS8JDWOEGVKITro=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To;
	b=y97SzS0igRMtyEMMl8pwAlPifEjBIb7HuBILYvquGbE+nMxSjVT+c84xXAViWEWfS
	 r4NZXLwL4TNNfZMLkxhTNia0PxGhELQV2401obcyRBkY/5ZqbOS+5RyyIGt+Dnh0/7
	 hbT9svpG2ha2a3ElMWGXoyqHtozMtt+dOf8tL5fWA0GRibC+wOob47tTF2Uo6gYgg1
	 WtBAPU/B7w5bUTV8Izm66EBxkES+2Q8PVqcpps0CMwX5VpL4MxA5AqGBtNIqNtJTy3
	 rWwwUEFktmjoaSJ4IY81VSQqkbWYoQtiRpgMMV+PVf7+eMuHFcU+SQOijWX6i9SRkW
	 0iPfN1Y3f9Cmg==
Received: from localhost (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-zteg10063401.me.com (Postfix) with ESMTPSA id 6D9D0A807B1;
	Sun,  6 Oct 2024 20:43:17 +0000 (UTC)
From: Alain Volmat <avolmat@me.com>
Subject: [PATCH v2 0/3] ARM: dts: st: add and enable MALI400 on
 stih410/stih410-b2260
Date: Sun, 06 Oct 2024 20:42:48 +0000
Message-Id: <20241006-sti-gpu-v2-0-c6bb408d6903@me.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEj2AmcC/2WMuw7CMAwAf6XyjJEdNbwm/gN1aFLTeuhDSYlAV
 f6d0JXxTqfbIEpQiXCrNgiSNOo8FTCHCvzQTr2gdoXBkKmZyGJcFfvlhRfLHbVnQ3LyUOolyFP
 f++nRFB40rnP47OPEP/v/SIyEV+eZi3a2dvdRjn4eock5fwH54c5YmwAAAA==
X-Change-ID: 20241005-sti-gpu-851d0a720e6c
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
X-Proofpoint-ORIG-GUID: aFPJO27W4_fSgQW8B2SRbN6nzzbCdVCN
X-Proofpoint-GUID: aFPJO27W4_fSgQW8B2SRbN6nzzbCdVCN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-06_19,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 suspectscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 mlxlogscore=613 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410060149
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This series adds necessary node within the stih410.dtsi for
the MALI400 GPU and enable the GPU on the stih410-b2260
board.
For that purpose and since the MALI400 GPU is available on
the STi platform (stih410 / stih418), a new st,sti-mali
compatible is also added within the mali bindings.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
Changes in v2:
- rename compatible from st,sti-mali to st,stih410-mali
- Link to v1: https://lore.kernel.org/r/20241005-sti-gpu-v1-0-9bc11100b54b@me.com

---
Alain Volmat (3):
      dt-bindings: gpu: mali-utgard: Add st,stih410-mali compatible
      ARM: dts: st: add node for the MALI gpu on stih410.dtsi
      ARM: dts: st: enable the MALI gpu on the stih410-b2260

 .../devicetree/bindings/gpu/arm,mali-utgard.yaml   |  1 +
 arch/arm/boot/dts/st/stih410-b2260.dts             |  4 +++
 arch/arm/boot/dts/st/stih410.dtsi                  | 34 ++++++++++++++++++++++
 3 files changed, 39 insertions(+)
---
base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
change-id: 20241005-sti-gpu-851d0a720e6c

Best regards,
-- 
Alain Volmat <avolmat@me.com>


