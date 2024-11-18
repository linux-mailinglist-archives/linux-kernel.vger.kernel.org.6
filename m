Return-Path: <linux-kernel+bounces-412414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0EC9D08CA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F8B281CCB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD9D13D61B;
	Mon, 18 Nov 2024 05:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A+o/nVSK"
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C91213C69E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 05:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731907347; cv=none; b=fBj4ejYMBp/1INAl7kcRzgv1TB9yBtzjY8tK8/kAFHvBIpQ6H8ViOn/WPGF7L2ACn7qt2NbMIEqOiU4HQxzuX0yzfzvMLOrsw4cT+rPNkzu6CJgmR3XQ8Qh66jLI8aZcm0Q9lsF4pYZmik/aP4mtjArynfumvxGI8T6nywSwfr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731907347; c=relaxed/simple;
	bh=KelfrUEDKn1STr/uyl6Wn/gXFShtj7LS2NXx40teaXU=;
	h=Date:Message-ID:From:To:Cc:Subject; b=FhQTD2MrdA8Zrg/KsSwnQnevtzKQpgaAVUPqMsYQx/kA/mytrxgBuquQqUMChirHCtZLN7gMdPkOah3hZq07ni1YEMMi9zZWkX//TmmD/SBjiM6dXbQTlF6CQZyBBTb4w7AoczJJpXM5NvilIm9Dv4D5YaweqHROgfLrFNsqTG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A+o/nVSK; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 41E36114011A;
	Mon, 18 Nov 2024 00:22:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 18 Nov 2024 00:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1731907344; x=1731993744; bh=2pmDU7e3MlYtu8haZn4roILPX83I
	3ITd6BRmfCF1ljE=; b=A+o/nVSKft+oQl4p8ZmqM2nqTN6LmPGK1W38jyBqf4Lb
	nrZwrPmZijynn6bxGXUx4ydfauROzXY3Dyc/yC94qc/mdwaM/n4bvfClc3mFShlW
	YA46HfnKqk/8h8mU+fzzcbdZ1EOFrIx/+jUx0RqErRVGujLrwiDrRn1NiUJhqFOm
	/NjD4q8FE/CxH5udU2nYOavPbtukSwrF6TSdIr5JDm0DVMr5d0j+4AMRaUXofAEY
	0e66ckHdJNfKwFNkgPYf9Of0Q93mvSVnPwCyW9ECcRa46Uf9w+1jMZwMF3NoFKlm
	2RbXEsp3bugGwLuGjdg3Ja0ZFACFlDyp9RibDCKgDQ==
X-ME-Sender: <xms:D886Z1LXpOVMGCcmXJXVI2uUI-Z61LWuhId_IsOnYMPErhkDb7YS0g>
    <xme:D886ZxJ2McTo7OHsXhExheATiNmO0IzMn-BhyqwXXa7-_nc7w-IdVUcYk7gDdSQWH
    usPaUjzUOLhy64m-tE>
X-ME-Received: <xmr:D886Z9vJG2W5El1aAWU1QBG2HgKHdOZ5TfI2wwCeb5cd5tatwUeZGccc1x_TBcH2qvkpY8gsu-3oXoh60FG5hb7eN6qJ_GwpjQk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffkffhvfevufestddtjhdttddttdenucfhrhhomhep
    hfhinhhnucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqne
    cuggftrfgrthhtvghrnhepiedugfduhffgheekjeekffduueejudevffehiedtledttdek
    veekuefhvdfftedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhu
    gidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehsthgrsghlvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghgv
    vghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtoheplhhirghmrdhhohiflh
    gvthhtsehorhgrtghlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhmieekkheslhhi
    shhtshdrlhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrh
    hnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:D886Z2Yg90hQI7A72eYRWUlkShFX116TTvbvDdOM452QJKZlbRzxaQ>
    <xmx:D886Z8YzoKa5Q81hXu7kc_mSRe-ouQcuIg023A0kVt_Z9bveshIJQA>
    <xmx:D886Z6CLKNDdhkh7zy9lfqzzJCBWxAc4BGvpxDFExGqEa_jAipfDLg>
    <xmx:D886Z6bE0vhPKgaKjUiitkIkIw487FdWm1mQlgycmjImaTyYj3c7eA>
    <xmx:EM86ZzUCPtYL1OaWOA1mXZegawyEglrA_twogqISp6i-Be3E1QQ4FeWS>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 00:22:20 -0500 (EST)
Date: Mon, 18 Nov 2024 16:22:48 +1100
Message-ID: <e8cb101ae6428a7af540d571bbb76804@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
To: stable@kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Liam Howlett <liam.howlett@oracle.com>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4.19.y] m68k: Add missing mmap_read_lock() to sys_cacheflush()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Liam Howlett <liam.howlett@oracle.com>

[ Upstream commit f829b4b212a315b912cb23fd10aaf30534bb5ce9 ]

When the superuser flushes the entire cache, the mmap_read_lock() is not
taken, but mmap_read_unlock() is called.  Add the missing
mmap_read_lock() call.

Fixes: cd2567b6850b1648 ("m68k: call find_vma with the mmap_sem held in sys_cacheflush()")
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Link: https://lore.kernel.org/r/20210407200032.764445-1-Liam.Howlett@Oracle.com
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
[ mmap_read_lock() open-coded using down_read() as was done prior to v5.8 ]
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 arch/m68k/kernel/sys_m68k.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/m68k/kernel/sys_m68k.c b/arch/m68k/kernel/sys_m68k.c
index 6363ec83a290..38dcc1a2097d 100644
--- a/arch/m68k/kernel/sys_m68k.c
+++ b/arch/m68k/kernel/sys_m68k.c
@@ -388,6 +388,8 @@ sys_cacheflush (unsigned long addr, int scope, int cache, unsigned long len)
 		ret = -EPERM;
 		if (!capable(CAP_SYS_ADMIN))
 			goto out;
+
+		down_read(&current->mm->mmap_sem);
 	} else {
 		struct vm_area_struct *vma;
 

