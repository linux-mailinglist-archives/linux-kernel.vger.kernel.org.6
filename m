Return-Path: <linux-kernel+bounces-570535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABD6A6B1C4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A6B8A5E98
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72867215770;
	Thu, 20 Mar 2025 23:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="OgqwvgLb"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8FB22B8AA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514217; cv=none; b=cThDvRx6tdvJ0uRRxXZjAhpG5aZJzcJxB1wXWDXeD+hG/de13LGnoe2dZS3hMl/wYMRJOzptXLsRInQd5vd+WZv1UkZjCUVosHivfjNAXKv2JPtxNV5H05khboPU7+vE2XKTzs12gl7kwMdI6Mc7M3H10WBhSrR/WG3NRt+wqAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514217; c=relaxed/simple;
	bh=bG38vjuJeJGG5BVMan3jDy0awoyH6Nd/7C/+ngA3QO8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pfatj/kPlRaflRDgeBXzFgLxc55xyhSiXJ0pOeuJ4nVh7/rMhGj9n3FSofJz8yvsXKwDtgHUegUu8Ol0YqHnwrPW28olF4dIWOsiHuYAkXxdh3+ibETExIvNR5pSKC6S5NcLp/5ifiqOnaYfK0ZUcJy0XLWsUg7du0WipHL962U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=OgqwvgLb; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742514183; x=1743118983; i=spasswolf@web.de;
	bh=H2sN7m/Wdif8cWuHLe6L4aA+ynY3kIFzVcj6ozTBAZ0=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OgqwvgLboajHYAQYCVVU+r2+hV2R8KY7zOot6AqL27vQUOF3cebLrGpW0S75Jcjs
	 NAKskphXUl61NQWYvoElw9GgfDKxC78NCWoTmaCRjIJuWi/QSTj/6WWaIVwjqeMLl
	 /ZiPzFFEx0u2G4Mvo2xcE6F7Z9+oI0HrrbX5QrzvqhSkbKikh2TG5Bu3VYxGE2Mok
	 ak+Mc/KJfSAvELTtxLZotdjMxj/x19sEbnB933aMVYJY2dbMzM/RL9GKMdpIiQZ+c
	 6oEmjio+5D61j6n4CQj0ufmDrPM3sNeRmD3K0elEnbfUcKy0ratAbEJnlOuKHkju3
	 uAlfMXmCC3fJim7JwQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MTOhc-1tjLHG48h2-00QZiL; Fri, 21
 Mar 2025 00:43:03 +0100
Message-ID: <841287f296579671dcd91329a49feed97186bcd3.camel@web.de>
Subject: Re: commit 7ffb791423c7 breaks steam game
From: Bert Karwatzki <spasswolf@web.de>
To: Balbir Singh <balbirs@nvidia.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, Bjorn
 Helgaas	 <bhelgaas@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, spasswolf@web.de
Date: Fri, 21 Mar 2025 00:43:01 +0100
In-Reply-To: <b5d80ef2-fd5a-41cc-9184-6c82226c330a@nvidia.com>
References: <20250310112206.4168-1-spasswolf@web.de>
	 <9a5df5627d3d72b2a97f501dfb7d944cc1e9920f.camel@web.de>
	 <fdea59fe-f570-489f-bf88-1ffd47119cac@nvidia.com>
	 <414f4deb8c7670a159854006b0c410ce05a6049e.camel@web.de>
	 <12d950ee-4152-4ad6-b93e-7c5b75804b1a@nvidia.com>
	 <705e95cec3dc5181ca2aa73722e6b84f63f3e91d.camel@web.de>
	 <20b5823e-247a-456a-bb55-d50f212a9f5a@nvidia.com>
	 <a34a1ae0b1d226b1bac7d73daa24da8e5899cb3e.camel@web.de>
	 <c7bb0bd1-529d-466d-9cce-abbac4b480ab@nvidia.com>
	 <146277bb0ecbb392d490683c424b8ae0dfa82838.camel@web.de>
	 <b63b1de8-7eec-4235-b61e-e654e78543ba@nvidia.com>
	 <fa8d5e76694918bdaae9faee9648776f298f78ca.camel@web.de>
	 <7866593f-0322-4fb3-9729-82366940fc85@nvidia.com>
	 <a168e78b-ae27-4675-8821-0b1a2499b2b2@nvidia.com>
	 <5d34bfc5109b8d104fd4f8550dd17945344f9d07.camel@web.de>
	 <551b9797-20d6-4bfe-b54c-84dd7aae7794@nvidia.com>
	 <CADnq5_Pvmxa10dJWYjajwxG-0Y_oxhL6wS6NsG2F0dmcJS6o8A@mail.gmail.com>
	 <9be36dfab79b17e108f71d51a6ebf39073e110c6.camel@web.de>
	 <b5d80ef2-fd5a-41cc-9184-6c82226c330a@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kKM3j/JQ/1It3V3Cl0uqnEO9ygQB20vF4/KiBoh/vSg0It10LrD
 vkYfiGMWu8FJT7UML8UKa4Dl6+ovsUW/tcdsuZv6v7Vp2OqhtuiK/govSUF1NoXBOBTYloE
 Tj9K23DjJEhwr31sSDEl4bLIO1ytso4ah2HwugXO2lvFWW3XOkWV7XJWm1TZIHvR70WGA3V
 FXQ7cQWzMJZsGNRV8Z6eg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9WAJTNw7qTU=;DACQbxd1AvQ81CLU2AiEJtAahNt
 KZqHruOnLjn30e1SzCmwFzmRYnPGPoOywXuhKD1G+E3e/taaw8qZK7R9ov4aq1nZed+FtDAcn
 KPl6b/d2bOeYQ0E+5zVBV9rQfFEHi+TWrGi5znNMuA05dFfJ6Ms9Y7sEqH5z56s39c2lTOuB9
 19SdS7T5LgLSNDWOTiNL/JZEcQ0ROkxjQ+BrFTndfTm7WrzqYCKVOZ2gnSPD+WDbbwQ/INzXh
 hwzK4KcZoSFiiofW70ZHGbqBnbZKKZOLUReiRNDiGbdkZPssr91ScjvRKvKlpgjycBzRghW57
 a/B1g/XL71Fq2+T5kdv8XuprrXFVtFheKuN8qtfT/QFYqHvCUlhUaA3ItF5cvTm2t412FZQX9
 RFzB2Ggn7jGjL+DevW63jV3Owmxx1ayzP7BiTKNtGw6cCzw1gq1+v4gKg+M28usMfS9vHGpMI
 OeZxQ7DSlWZ9kI2XHGZWfKrAjokqXnK6lAduXzKLC8qLh2S7qWPPsioNYjPNEO/v5p51zUf9u
 Z/KdIBA2axc8uvYNpgr6r/BNd4thO41MwaEJ9rYA5ugrUWhXIuGXt1W8zmi96b2KQsqiEEG4e
 rlAgcJWsaj+HHd9WQKdcYV3LJbVdK7t3l6GZfSEBOcJhWMyW197u7UNcyRESCl67YfTXBYRoX
 d2bNHayX62alRL2C+eBqdPGmw3SA0QOqTYVtwFyPg4wM1XohL+A0WXYb+O7eVvdRHaiAJgW7A
 umzQlfHEJcy4UYlZoO7upWOJgyW8ufUQFyb1xaHPC7DptjxtK9mt5sXwDpGwVYtI9cS0bjqnK
 evD3vaAt7rkR+xw7ia0zrPXMp+ZwLMmjgZd46JSJ1h/volCnkQvzzl6Vg65ucbn4fj/DT7BDn
 XZCw6TxB5/nGo+CoxOsYY/yW3Wvs/jNLIdhucq56kW/vqrkZd/fMY9G9WCmnxRu3SeDDhgdUy
 GBV86ZSigEtV6Ncd23PYS+2dCVM9dG8x1KWogzzjD6bI2rOd1rTsB7R/mcBrElgvEmsIRmKZD
 pAEoLR8mXA4kQMNetAK+XU4LuVAJSRdfFOyj1C30O7kFxYuFvDhbbNz910LMIhsxbctGAJLyM
 VeaTiq2ZxMDwjNs0g42PLDGK5SXrEMkRSaRkKP0AXB09Pw/B8UV5cjyLWF+lKKIOaon+AwDFK
 0PjPf4+mJNwh9IZSi736AOyktdtz0Zr5kxvNvl9zMb3UFDvL/v0QNP9A5W9L+ozieKEdnAkfk
 oXMF7YlQZ8TN95XkE/ETag+7GnBfCFeknLkycfD2+4LJxM9N5ZxxyJIh97EqXdJd5y8gKfmBV
 OwF+cLOmb6Qc9qB0PEY8+tcbcZ2QcllP0baeBoDRPl2s2V6rkZkvHvsWhKzp0l0JaNKosurAE
 Cnt2XNtcn0czKGpi7+4NdanQtVL9SE2L8mVdSTnnFrO2k77mNSKS/8jbu8HRIgyEPHWpALoeL
 yO6MQRQ==

I did some monitoring using this patch (on top of 6.12.18):

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 0760e70402ec..ccd0c9058cee 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -121,6 +121,8 @@ static int amdgpu_gtt_mgr_new(struct ttm_resource_mana=
ger
*man,
 	int r;

 	node =3D kzalloc(struct_size(node, mm_nodes, 1), GFP_KERNEL);
+	if (!strcmp(get_current()->comm, "stellaris"))
+		printk(KERN_INFO "%s: node =3D %px\n", __func__, node);
 	if (!node)
 		return -ENOMEM;

@@ -142,10 +144,16 @@ static int amdgpu_gtt_mgr_new(struct ttm_resource_ma=
nager
*man,
 			goto err_free;

 		node->base.start =3D node->mm_nodes[0].start;
+		if (!strcmp(get_current()->comm, "stellaris"))
+			printk(KERN_INFO "%s %d: node->base.start =3D 0x%lx node-
>base.size =3D 0x%lx\n",
+				__func__, __LINE__, node->base.start, node-
>base.size);
 	} else {
 		node->mm_nodes[0].start =3D 0;
 		node->mm_nodes[0].size =3D PFN_UP(node->base.size);
 		node->base.start =3D AMDGPU_BO_INVALID_OFFSET;
+		if (!strcmp(get_current()->comm, "stellaris"))
+			printk(KERN_INFO "%s %d: node->base.start =3D 0x%lx node-
>base.size =3D 0x%lx\n",
+				__func__, __LINE__, node->base.start, node-
>base.size);
 	}

 	*res =3D &node->base;
@@ -170,6 +178,8 @@ static void amdgpu_gtt_mgr_del(struct ttm_resource_man=
ager
*man,
 {
 	struct ttm_range_mgr_node *node =3D to_ttm_range_mgr_node(res);
 	struct amdgpu_gtt_mgr *mgr =3D to_gtt_mgr(man);
+	if (!strcmp(get_current()->comm, "stellaris"))
+		printk(KERN_INFO "%s: node =3D %px\n", __func__, node);

 	spin_lock(&mgr->lock);
 	if (drm_mm_node_allocated(&node->mm_nodes[0]))
@@ -217,7 +227,11 @@ static bool amdgpu_gtt_mgr_intersects(struct
ttm_resource_manager *man,
 				      const struct ttm_place *place,
 				      size_t size)
 {
-	return !place->lpfn || amdgpu_gtt_mgr_has_gart_addr(res);
+	bool ret;
+	ret =3D !place->lpfn || amdgpu_gtt_mgr_has_gart_addr(res);
+	if (!strcmp(get_current()->comm, "stellaris"))
+		printk(KERN_INFO, "%s: returning ret =3D %d", __func__, ret);
+	return ret;
 }

 /**
@@ -235,7 +249,11 @@ static bool amdgpu_gtt_mgr_compatible(struct
ttm_resource_manager *man,
 				      const struct ttm_place *place,
 				      size_t size)
 {
-	return !place->lpfn || amdgpu_gtt_mgr_has_gart_addr(res);
+	bool ret;
+	ret =3D !place->lpfn || amdgpu_gtt_mgr_has_gart_addr(res);
+	if (!strcmp(get_current()->comm, "stellaris"))
+		printk(KERN_INFO, "%s: returning ret =3D %d", __func__, ret);
+	return ret;
 }

 /**
@@ -288,6 +306,8 @@ int amdgpu_gtt_mgr_init(struct amdgpu_device *adev, ui=
nt64_t
gtt_size)
 	drm_mm_init(&mgr->mm, start, size);
 	spin_lock_init(&mgr->lock);

+	dev_info(adev->dev, "%s: start =3D 0x%llx size =3D 0x%llx\n", __func__,
start, size);
+
 	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_TT, &mgr->manager);
 	ttm_resource_manager_set_used(man, true);
 	return 0;
diff --git a/drivers/gpu/drm/drm_mm.c b/drivers/gpu/drm/drm_mm.c
index 1ed68d3cd80b..e525a1276304 100644
=2D-- a/drivers/gpu/drm/drm_mm.c
+++ b/drivers/gpu/drm/drm_mm.c
@@ -223,6 +223,13 @@ static void insert_hole_size(struct rb_root_cached *r=
oot,
 	struct rb_node **link =3D &root->rb_root.rb_node, *rb =3D NULL;
 	u64 x =3D node->hole_size;
 	bool first =3D true;
+	int count =3D 0;
+
+	if (!strcmp(get_current()->comm, "stellaris")) {
+		for(struct rb_node *first =3D rb_first_cached(root); first; first
=3D rb_next(first))
+			count++;
+		printk(KERN_INFO "%s: RB count =3D %d\n", __func__, count);
+	}

 	while (*link) {
 		rb =3D *link;
@@ -247,6 +254,13 @@ static void insert_hole_addr(struct rb_root *root, st=
ruct
drm_mm_node *node)
 	struct rb_node **link =3D &root->rb_node, *rb_parent =3D NULL;
 	u64 start =3D HOLE_ADDR(node), subtree_max_hole =3D node->subtree_max_ho=
le;
 	struct drm_mm_node *parent;
+	int count =3D 0;
+
+	if (!strcmp(get_current()->comm, "stellaris")) {
+		for(struct rb_node *first =3D rb_first(root); first; first =3D
rb_next(first))
+			count++;
+		printk(KERN_INFO "%s: RB count =3D %d\n", __func__, count);
+	}

 	while (*link) {
 		rb_parent =3D *link;


With this I ran stellaris (just opening the game the closing it again from=
 the
game menu)

The findings are:
(a) The size of the RB tree is the same in the working and non-working cas=
e (50-
60)
(b) The number of calls to amdgpu_gtt_mgr_new() is ~2000 in both cases
(c) In the non-working case amdgpu_gtt_mgr_del() is called far more often =
then
in the working case:
Non-working case (cmdline: nokaslr) 834 calls to amdgpu_gtt_mgt_del()
Working case (cmdline: nokaslr amdgpu.vramlimit=3D512) 51 calls to
amdgpu_gtt_mgr_del()
Working case (cmdline: no additional arguments) 44 calls to amdgpu_gtt_mgr=
_del()


Bert Karwatzki

