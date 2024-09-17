Return-Path: <linux-kernel+bounces-331984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C2197B3A5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 19:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC0728440F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD995185B64;
	Tue, 17 Sep 2024 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="iGJSKSPX"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0811F182
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 17:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726594632; cv=none; b=T5IKwn9UXKFBJenTmBZrlSqrDv3/jsJqKrd6/CYjk1geTQUMMk2U9elf+dWMQ+CtiCQe+LpbpamEKm+DK6J4Ex63FGT7qPWC9Z4ciAzULP11yu8iE86YY0fK8mFku9QfJV5JzWKPiJINy0A5dWo4+wSG4YcFTigxAdZ22+X4Y0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726594632; c=relaxed/simple;
	bh=CcE6ytWykVFlelDDJs+4IUfXbkU187jFA9t0u0RfIj0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iMSCuGbFPwjytgS/Vap2x8vsvwtIAimnon8scalLe8T6Zfx+NHEigoXXkb1lxmSv1X4SY8DhGNimyoggrEDyxUwI8x+LYd0djkWyWQW/bgIX7IHbZEMj6W8/BBWCoUbKrHjoYuqiDCHAs7Zs5ZdKcYsW2nQnat5m/N7nU0ZZTxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=iGJSKSPX; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726594604; x=1727199404; i=markus.elfring@web.de;
	bh=bWD4f7dfwXe5y0GSYL8/IHvYiyGgzS9bmzMjIkp1VS8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iGJSKSPXpn/91agvrzEwwyzNTBNQy2JRfBNN7q60pNOGfQ4p7CkCR/miQ1DEvFQn
	 C/YFxm8khH06N9LLqQYkNqPFF3AAm9SfTwvMqW4QF1W4PRG0Kv76hoKs5zNod7uwi
	 6q32LWWJAZAB0D9u8rs4WOS00JO+qI/DuZlPZAyW4Cp10HBtJGAwtQkrtap9J5C3Z
	 umppao+AHbKQXBzlhowA0xjiqBiMKPmEyJOXKou/4CTiZJuBTTPLHH1zMIte+xXGq
	 R0dH6sbEfPq39v23d74Tg8YDH3U8r1AsoiyJcH75DUjgob84JII2JSTacYhsaRkkh
	 RkhbGgdEwhUqwa0uNA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9cLR-1rw7UP3IeL-00u3wf; Tue, 17
 Sep 2024 19:36:44 +0200
Message-ID: <02507a9b-87e2-45a6-9410-d4dfb0e4b1a2@web.de>
Date: Tue, 17 Sep 2024 19:36:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] drm/mediatek: Avoid duplicate sg_free_table(sgt) call in
 mtk_gem_prime_vmap()
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, Alexandre Mergnat <amergnat@baylibre.com>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 David Airlie <airlied@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Simona Vetter <simona@ffwll.ch>,
 Sui Jingfeng <suijingfeng@loongson.cn>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <254d16d9-d56a-4f26-9914-db75e7aa4287@web.de>
Content-Language: en-GB
In-Reply-To: <254d16d9-d56a-4f26-9914-db75e7aa4287@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s2zlqnaimkLloyDBZKpVNVmP31XuxmPGr/MvuG2wfUihOUwc+w8
 F9XqNIY3gPN2nnjG0HoiVtYgevNcH6/7iBXfnKOYNUeJXuAj8qYZe6op+d0OxCKYrRFhbeE
 b+lWmg9kgZqf7w6aEnSSWdhh6YvXWnRLiZjwiWR63fRCMX2Jh53tu95xFTrVcJ7od9bRrv0
 ewQAAHMFY30mVcn8/WRDQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rsij0WevMas=;HYt8wbxNbi49h3gl7Fe/5B5Mdzj
 PNY2ivtAG9TG0kY/lOPjlxRsHuhoI0RbnegQ5CsDaylNuqiEKFziXB+qOF8M2TFEiKAu/W96C
 CgB4Shoi3PJ9em0Aq0dg5eRIZ2Y+VLlShmHJBoSKLjB6RND3P77sqYxPZLOpDFv8XbOGhmng1
 EOOa9xsZ+kc8lZoe4Ck+IoxdA0Dz+vnIYe7h/07ygtoaBz0eT8IlP0zavMNoZz4fO8yUOH0sU
 eEfKoASyxzXPG7f/mUgT1G9im3t+mIfLqSyqDQEtlMuUs27hnFxOr8q3iKEC7HIovPkj4eS+b
 9JYV/JR0hP5uYq7uKez3DHU47Oo3GbRTUWTb3wWvdZJMlFJV/fEh1iviHNdbZr8SvAo7KmC+L
 u5SRuZEq8rQPEV/5SE4ZC7pZ+Q+Qb2NITeIW/REuUhH58CXbhJTTW5cQ293wfzbdulbXUxpT6
 X0Z41tG5MT3PW0RjhE0qYJSb2z/VzfxfZ8SXQ6ydDDaefrgM371PukKwo+5vIgJjKKA2dWhaU
 H99HeFoS7E8hZmKVl5Xz0iOAODCG0WOUzmDJbU9SWoecJvMNQkcjSCBn0T35VIAGXnb5h4mBV
 gK7chp54V/CTB2riOF8gGSknJHRmgnThNMFAz6okAvjuh/CzwYF/C/NpnDeXVVWeOjAo/DSzw
 seOCf3oypk/aV2HBjMD2afoxF+ydU5asGz4zg/bGGYst43YZ/3FzqQonzJf+vKagC3xRQAKaa
 tJwkE/P4KtbikEuiXNTM5bakWN1A22wSiX/WG2smQjMkbUAxmmA13lWH6j2kAsV2IgQinbDt0
 yEk/GQodAcw2GxQoavgwgcnQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 17 Sep 2024 18:50:37 +0200

A sg_free_table(sgt) call was immediately used after a null pointer check
for the data structure member =E2=80=9Ckvaddr=E2=80=9D in this function im=
plementation.
Thus use such a function call only once instead directly before the check.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/mediatek/mtk_gem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_gem.c b/drivers/gpu/drm/mediatek=
/mtk_gem.c
index a172456d1d7b..9c7b7d0a3ffc 100644
=2D-- a/drivers/gpu/drm/mediatek/mtk_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_gem.c
@@ -259,13 +259,13 @@ int mtk_gem_prime_vmap(struct drm_gem_object *obj, s=
truct iosys_map *map)

 	mtk_gem->kvaddr =3D vmap(mtk_gem->pages, npages, VM_MAP,
 			       pgprot_writecombine(PAGE_KERNEL));
+	sg_free_table(sgt);
 	if (!mtk_gem->kvaddr) {
-		sg_free_table(sgt);
 		kfree(sgt);
 		kfree(mtk_gem->pages);
 		return -ENOMEM;
 	}
-	sg_free_table(sgt);
+
 	kfree(sgt);

 out:
=2D-
2.46.0


