Return-Path: <linux-kernel+bounces-252606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6689315DF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D945282243
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD0F18E75C;
	Mon, 15 Jul 2024 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="MPXWouqe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vo7dvMe5"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0E218D4DE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721050547; cv=none; b=WkB63LE2V5XkKmkud+RkGbUtdIj1i5ZQo+o57I8RHvnd7k9MKaNjQUB56IWb2xFdGztTaiObdNNuqhNkd4lBwGMnM8zI6yjy6YBGiKBriQ+GXTES9KMEBQaBGTQRp2SKFoi3Z1g2nwNpEa1ZDCxDsQQK1KvJK8D5kayOkQL4VDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721050547; c=relaxed/simple;
	bh=g8d7dxT/BVtAO8vYQcer1eyeppeyi/gG6japCtttGUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ipR3ncYYjQiDsN/vOZ3qqTTNjAFvld7WAKefape/gVNt6s0ss2FjOZP1XFs6OEeJt9WPAe27KtejX7ezwzcbdbcfyeHdb3YJxxZNV8hULEJC5Tg8xGMSSR7CD0T9v62ZCVEbs9CMAfm/veUGeeGt6I1K8FgeWHQVoduioduX/W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=MPXWouqe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vo7dvMe5; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6D37F1147F7F;
	Mon, 15 Jul 2024 09:35:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 15 Jul 2024 09:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1721050545;
	 x=1721136945; bh=QekSCibAz4MOBP65R5aP4L/Ddp8Wwagai8dXxftEX8s=; b=
	MPXWouqeRroTA+VOVr/PQfC/Xzt5lQpo4h34BbqZ8iyFec9hltJh2xM/guXsu/60
	/0Kgbx3wH6jT2nJ3cEHUn5YZe2peguWNmLd+Bgq7QkvLiSgVWQ9mzLRgueOcLfk6
	bgv/LOpPddmrFbvg48M6HMegebD2C+tt/v0QZW8O0ZaF27EVOlYihN8tVqX4Clvb
	iRXztO4ZXmRsTSRbk4TEqb9HrPAQqmUGYj8afbChft7Fm8i5Kz6aMpSpw5gEOPcg
	253LyxoGJavKWYRrXB7XvarY1Os3UR0O4zxxesbLhtrbAz+X/d0GLMiOHAFN8V7Y
	7BC2Ts5OOYYYB/cXM/P93w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721050545; x=
	1721136945; bh=QekSCibAz4MOBP65R5aP4L/Ddp8Wwagai8dXxftEX8s=; b=v
	o7dvMe57IlZmJR94lhTHOKfUxonymMUfywrxbfGmIAshAD2L8kvE1+GwU9canjKa
	rBbsi+x6xa8jZBfTH+cbgCtb6xWXzvMUZlKOKj05WKtglW4zkOvnsI9c1/6JiHtg
	5TxVYtKEXRdh1kaEFRApfX2p3wQ9dGXMFx1fo4zQc6s5756E+hJ8iK4y2m0Ly//h
	7UGFztV4K16y71JXdqpoAsday9hQPIIjJ/0znh2QZnbJx+eP2ZiwDWTq9Hisi5Sx
	4M8jyL8N4lN0fbothVeR8ET7JscqqZ+j/Vhe7u3ZCJGIn7saLdVjOuDjgMOI8TRm
	VBtjHYstOPQ0YtcGxFQYg==
X-ME-Sender: <xms:sCWVZm7FNnm_UjrgYovo7vXLJHORwC-VN4mTz4Sq5bIYDZvcRV7lHA>
    <xme:sCWVZv7_EH-Cx82RZLfUmHc_GnIbUDrVQ9ymuWImfB5-pSRyN5tDCKkLBt2XpdiSt
    YVajHrHTtfJ45XKB0c>
X-ME-Received: <xmr:sCWVZleLw5mY9gtSiUhJAEExkXcWMyVaQyMlc4v1GiiEOASvlPcH1SM1DQ4F4CLeP82H>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgedvgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefhueev
    geffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:sCWVZjLqiVJwJFrwLpW0hKJUTQPodHEQgxj48FbzN5Gjn3dZ1mL63A>
    <xmx:sCWVZqJnfYuKdgjj_OHmjvaorqK6ptasFwQ9Bpe6SVtXyZGOYxf9TQ>
    <xmx:sCWVZkxIv5Uhb9M6-hIc97TrlWsOewCvIjEUveyQ3EJCoWO_bZaNEA>
    <xmx:sCWVZuKhE555cRNWpPgWxCHwb6oBucHIDVhiRAgfr-Rd7kkqzsHHqQ>
    <xmx:sSWVZrqF0pZ5YOb7KzvltnInOjm9w5dc8ZTNDXlMQJ2B7ZnQPv5hwvK7>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jul 2024 09:35:41 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 15 Jul 2024 21:35:28 +0800
Subject: [PATCH v2 1/3] cpu/hotplug: Make HOTPLUG_PARALLEL independent of
 HOTPLUG_SMT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-loongarch-hotplug-v2-1-7d18b3d46b11@flygoat.com>
References: <20240715-loongarch-hotplug-v2-0-7d18b3d46b11@flygoat.com>
In-Reply-To: <20240715-loongarch-hotplug-v2-0-7d18b3d46b11@flygoat.com>
To: Thomas Gleixner <tglx@linutronix.de>, 
 Peter Zijlstra <peterz@infradead.org>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>
Cc: linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1109;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=g8d7dxT/BVtAO8vYQcer1eyeppeyi/gG6japCtttGUs=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSpqise38g5q6zytv3+c8X/FsvWJ7BqbvjVxNnvGaNVz
 Od8mOFrRykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAExkAwMjwyS/oDlcoQbX957b
 8fhtuftOOf6HU/ROfnz34bnh+/BJnGsZGTq9Mz7yuR0Q2p5wf5HnszubPlR9cK5RvXD8jtYxzzd
 HXZkA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Provide stub function for smt related parallel bring up functions
so that HOTPLUG_PARALLEL can work without HOTPLUG_PARALLEL.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v2: Use stub function (tglx)
---
 kernel/cpu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 1209ddaec026..c89e0e91379a 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1808,6 +1808,7 @@ static int __init parallel_bringup_parse_param(char *arg)
 }
 early_param("cpuhp.parallel", parallel_bringup_parse_param);
 
+#ifdef CONFIG_HOTPLUG_SMT
 static inline bool cpuhp_smt_aware(void)
 {
 	return cpu_smt_max_threads > 1;
@@ -1817,6 +1818,16 @@ static inline const struct cpumask *cpuhp_get_primary_thread_mask(void)
 {
 	return cpu_primary_thread_mask;
 }
+#else
+static inline bool cpuhp_smt_aware(void)
+{
+	return false;
+}
+static inline const struct cpumask *cpuhp_get_primary_thread_mask(void)
+{
+	return cpu_none_mask;
+}
+#endif
 
 /*
  * On architectures which have enabled parallel bringup this invokes all BP

-- 
2.45.2


