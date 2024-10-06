Return-Path: <linux-kernel+bounces-352601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA46992149
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 22:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E978281BBE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 20:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725CF18BB8C;
	Sun,  6 Oct 2024 20:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="RxIU+WQj"
Received: from st43p00im-ztdg10063201.me.com (st43p00im-ztdg10063201.me.com [17.58.63.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA67B16E863
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 20:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.63.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728247422; cv=none; b=A5GwZQONCDm58iJB8765kQ164XPdNJguELwQfNlFDdvq2YLwxzz1U3rb8TV/AhyEoi7nglHIpwUMdNwsD5bAoen+Woc/dIldEUlo+3cOb4yHA30fy63Q6MUplni25Qp2Z2WZVH3PTW3L2zNNnlU5WIK3PRs0C+F32LQTG2eXhiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728247422; c=relaxed/simple;
	bh=50LarcWmAb+JKDLihirqMHb9zi+4z+9gIWtZYON+/1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z2wBuLr89LTRN/hlVTM+76NBl3ivQM5NfnUCnCRR87ly2lFrjOO30SlVOTFnGsEKcaXG6twY9sYwbgPNbgsTvIPOC08Kmzt6harpdyGhFyKpSzv2G4YIRWvuYrIgKvDP+zENcfZ/XswlIH1ogYpRpI1QG6EZ/ybuzmpqTOifcBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=RxIU+WQj; arc=none smtp.client-ip=17.58.63.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
	t=1728247419; bh=Rb4uSMd3WuIyW+3aNpC7juKYGvVxUYO7LHjTErftlXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=RxIU+WQj+kb7PoLYFhpjaoiWCFXY+FgvYHfJYwjKbThv4SzKNvqax31uAvxulFl7L
	 G3E+cA0M5rRIB97Vww+84GE2hnJm5BUqVfBhb/+OOnAbNTsUJPKuaBxuIqcMyNEZpR
	 frtl5wC7hO0WpEaffXf6J94l0Z3saVHgTxsPjSHvMMSmB8jwCJtOy9X1HDxYYThyTM
	 G8zjrLqY1qPwHr1VsW5vBWD6BiM/i8kS3QT2csrx5SukifC3E+0ZCVUPR59GIlhe0j
	 iRIFODcKbfgKo0VAQakbI+3qxmTHFsqqHATjrhIHG78WR16Y13MOs2LdsAbAnzPet9
	 qGXTyHX61BCeQ==
Received: from localhost (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-ztdg10063201.me.com (Postfix) with ESMTPSA id DFCD29803C1;
	Sun,  6 Oct 2024 20:43:36 +0000 (UTC)
From: Alain Volmat <avolmat@me.com>
Date: Sun, 06 Oct 2024 20:42:51 +0000
Subject: [PATCH v2 3/3] ARM: dts: st: enable the MALI gpu on the
 stih410-b2260
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241006-sti-gpu-v2-3-c6bb408d6903@me.com>
References: <20241006-sti-gpu-v2-0-c6bb408d6903@me.com>
In-Reply-To: <20241006-sti-gpu-v2-0-c6bb408d6903@me.com>
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
X-Proofpoint-ORIG-GUID: i_TaJ1qM4CeIyoTXli7CsWKMXexD7nFQ
X-Proofpoint-GUID: i_TaJ1qM4CeIyoTXli7CsWKMXexD7nFQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-06_19,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 mlxlogscore=438
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410060148
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

Enable the GPU on the stih410-b2260 board.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/st/stih410-b2260.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/st/stih410-b2260.dts b/arch/arm/boot/dts/st/stih410-b2260.dts
index 240b62040000b8c0357d39504d3475186958bf31..736b1e059b0a8f122d1b824e1f4e5db0a668ec2c 100644
--- a/arch/arm/boot/dts/st/stih410-b2260.dts
+++ b/arch/arm/boot/dts/st/stih410-b2260.dts
@@ -206,5 +206,9 @@ hdmiddc: i2c@9541000 {
 		sata1: sata@9b28000 {
 			status = "okay";
 		};
+
+		gpu: gpu@9f00000 {
+			status = "okay";
+		};
 	};
 };

-- 
2.43.0


