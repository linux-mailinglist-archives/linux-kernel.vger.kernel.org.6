Return-Path: <linux-kernel+bounces-526628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F47BA40133
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0ABF19C2650
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019462045A1;
	Fri, 21 Feb 2025 20:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="RsWbBg4q"
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679501FC102;
	Fri, 21 Feb 2025 20:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740170400; cv=pass; b=DSLxXQWoIxPCyOdi24SFdF4+/shFBD9JaSVk1pRHBT/bC26gYrV1rSnzNwO4pOXO+NoD3y+ShWPan7XElrFHHUtiFyNLJRgGM64DzaQLaOzUG49GCRnoHNjoj6hFIvw/JIvCJNiZS+2LLo7fp1fIOSpQIeibp4ecFBKXmQDYD5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740170400; c=relaxed/simple;
	bh=g+zbCpZ+1FMbrKP6uJKG+9dae8cgqKA78FJKbCxMPF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T8kU2CvDWYSMh5t+CUM/W3+38LmYkB9gSdsvm3OLXmisrxxOxd7LFQzrHEHDH+N3lYUFwVzEtE44ipShqWXoYjef336+lEMiPAlcl+W5mrzfiFnYh35lqu/IXpLe52HnxWESREPOeGmvtxbDQU8PXn6O7KY1YQ9bZzu6ZgBAVIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=RsWbBg4q; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740170387; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XYp1ymi2/abVGMkwCN5ogf3ba4e8+qdOh0RBhUSSq7BuIQOzsYCpQrVgzKeiFPVQTOndlxswFlVw7Tw5oiXgTBFhYNg/HOuyCOCxymVXJR6cpYWbGPqXloU6Logi0SYtLs89AwaFIPrKoEHCK8m5mxrP+nNIMEB+MZmUcXCb8YY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740170387; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YPVDhutFqE0CHWS8gowpekGV6zc0YkLczaOqICj/amY=; 
	b=EGYR1e0iXaNZZevZNGaDG+vb+JL2jNovi48h4C78OrZLB5h5xPIncrFIEAqI+b9iwHJxGfsoy1PstloRYqtgmi0aUITPliiObNXYRgGjlpe0HZFcjzzIHKRMAggWmtuvWQJQH4tnLbn3AgpzYpOS6xx6KLYeSVBbjsDZkQAd4rM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740170387;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=YPVDhutFqE0CHWS8gowpekGV6zc0YkLczaOqICj/amY=;
	b=RsWbBg4qGq+F7+dT6+rWeR0W3Ose4pwp2+VPoA3KBSCEH4UvbhDlZasAoKQfqo3U
	T9FeOQpW13hMfeDj/PEcMvu5SYOodkvIghskwF/kqLHe/7JzMlitiTswgM241tCu+BM
	+6oljbhZqUsAZVsUc4HHWBlTM6QPfsC35XSPB1NA=
Received: by mx.zohomail.com with SMTPS id 174017038484339.05431959157954;
	Fri, 21 Feb 2025 12:39:44 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 21 Feb 2025 21:39:32 +0100
Subject: [PATCH] ASoC: dapm-graph: set fill colour of turned on nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-dapm-graph-node-colour-v1-1-514ed0aa7069@collabora.com>
X-B4-Tracking: v=1; b=H4sIAIPkuGcC/x3MQQqAIBBA0avErBtQyYiuEi0spxoolZEiiO6et
 HyL/x/IJEwZ+uoBoYszx1Cg6wrmzYWVkH0xGGWsMkajd+nAVVzaMERPOMc9noI0KaW1a2xnWyh
 xElr4/sfD+L4f+zVZW2gAAAA=
X-Change-ID: 20250221-dapm-graph-node-colour-eb0011a45856
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

Some tools like KGraphViewer interpret the "ON" nodes not having an
explicitly set fill colour as them being entirely black, which obscures
the text on them and looks funny. In fact, I thought they were off for
the longest time. Comparing to the output of the `dot` tool, I assume
they are supposed to be white.

Instead of speclawyering over who's in the wrong and must immediately
atone for their wickedness at the altar of RFC2119, just be explicit
about it, set the fillcolor to white, and nobody gets confused.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
This is somewhat "just thrown out there"; I noticed that not setting the
fill colour breaks KGraphViewer only *after* I thought this was just how
they were for several days. With this change, both dot and KGraphViewer
render it correctly, but I have no clue as to whether it's in the spirit
of the file format at all. I figure that if this saves some other poor
souls a bit of time and confusion, then it's worth it.
---
 tools/sound/dapm-graph | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sound/dapm-graph b/tools/sound/dapm-graph
index f14bdfedee8f11507a6b7b04f6dd1847513e6da8..b6196ee5065a4e72069df663775518352d75d410 100755
--- a/tools/sound/dapm-graph
+++ b/tools/sound/dapm-graph
@@ -10,7 +10,7 @@ set -eu
 
 STYLE_COMPONENT_ON="color=dodgerblue;style=bold"
 STYLE_COMPONENT_OFF="color=gray40;style=filled;fillcolor=gray90"
-STYLE_NODE_ON="shape=box,style=bold,color=green4"
+STYLE_NODE_ON="shape=box,style=bold,color=green4,fillcolor=white"
 STYLE_NODE_OFF="shape=box,style=filled,color=gray30,fillcolor=gray95"
 
 # Print usage and exit

---
base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
change-id: 20250221-dapm-graph-node-colour-eb0011a45856

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


