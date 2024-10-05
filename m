Return-Path: <linux-kernel+bounces-352030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 558DE991946
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0859A1F22510
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 18:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31337A31;
	Sat,  5 Oct 2024 18:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="Q9A7O2wp"
Received: from st43p00im-zteg10071901.me.com (st43p00im-zteg10071901.me.com [17.58.63.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485D7146592
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 18:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.63.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728151740; cv=none; b=JhpAcbecPC6LJ25RR3Wi8a+O5M7h3ics7KoC1HeM/shXpgchfgM/v9XVemwx4RrZZRV1Fs54DHD00BM4mrZyNYAaR/SgwbvXHaatLnykvE5XLnHUW0CsgDtUKNilFwlvcUYHwnPUNe6te6KrMI/TlWYUF94wR/rK+ydup3t/Uyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728151740; c=relaxed/simple;
	bh=17Q3zjDdWyM1ywBBAcTUWnVUPe4hTuuw7qYm+qPu/rg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kFvllzw+oe5Gug0kfucwjWCvyliBNHGvyZKneZb5Shc4ElPnqNAc7QQ4IPD2cYB0Vw9uieKAD1eScvYpQe5qPaYEsx+hZsV8qkKbLBVLfy1GVANVZWK2PxvctexEv3Q50JQ3ibmS9lFfojll3pPmArWg/Hg9bJ5aU7dYi6qW/bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=Q9A7O2wp; arc=none smtp.client-ip=17.58.63.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
	t=1728151738; bh=xqYBf6wNowtveZZFNLsiockAH4AhJmTzYl8y7DCbIRc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To;
	b=Q9A7O2wpAyEz88H7EX6VVy97IT/pBhkggW87O14Wr3Ss/as00GtQI6QTYlZl6dyMh
	 lyZc9e7xIwBtoMoK+3SKEc5I0sCHSQJj8VOFfl9QwbK4j1x3ThaxhoEagNLaRNAxju
	 oAD0LZjYuPlk1oMvPYdp3sXIKpd/MN2v9vccBLN1PHeUWLI1r1vJBk5FfQCpe7NdIn
	 0Its6YZryht3LLfybjBJszcR5Ox+j8O9cc4mPEVn3VGuuWR7aCJrC1qmTEoISs6eiW
	 q3I1qA1dQsKORB9dp59WrrmPJrxGZpBGBLj9XS4hVCfP/+HjmTC12iLkQbMo4W9SOm
	 A7fPYXpkK+Evw==
Received: from localhost (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-zteg10071901.me.com (Postfix) with ESMTPSA id 91C5BAA0191;
	Sat,  5 Oct 2024 18:08:56 +0000 (UTC)
From: Alain Volmat <avolmat@me.com>
Subject: [PATCH 0/3] ARM: dts: st: add and enable MALI400 on
 stih410/stih410-b2260
Date: Sat, 05 Oct 2024 18:07:58 +0000
Message-Id: <20241005-sti-gpu-v1-0-9bc11100b54b@me.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH6AAWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAwNT3eKSTN30glJdC1PDFINEcyODVLNkJaDqgqLUtMwKsEnRsbW1AOS
 jxHtZAAAA
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
X-Proofpoint-GUID: hfAvwcxJ44oahZHitI4RoDLJVxOl3d9x
X-Proofpoint-ORIG-GUID: hfAvwcxJ44oahZHitI4RoDLJVxOl3d9x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_17,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=558 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2410050133
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This series adds necessary node within the stih410.dtsi for
the MALI400 GPU and enable the GPU on the stih410-b2260
board.
For that purpose and since the MALI400 GPU is available on
the STi platform (stih410 / stih418), a new st,sti-mali
compatible is also added within the mali bindings.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
Alain Volmat (3):
      dt-bindings: gpu: mali-utgard: Add ST sti compatible
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


