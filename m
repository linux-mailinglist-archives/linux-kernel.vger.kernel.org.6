Return-Path: <linux-kernel+bounces-353715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DBE993199
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FD9AB21995
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB711D9321;
	Mon,  7 Oct 2024 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="q5Sq3COy"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FA21D798C
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315683; cv=none; b=Bgh+SxdUL1y6YC4UCZzuW2PJnDBFcTqHGYscQ/dRWWgSEffu2PBoJsNAJR6p4kSbuzpGU6heoXkv/GEjtoxKHq8K24MmkpfkHw08IXNDSUyTgwjG5OaOgOASif7EV/McuTWaKWqNvQmJtoPD+roOvDrs8DKPLKArqh2DuVp+zZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315683; c=relaxed/simple;
	bh=eMkdRF2GWq2ym+ujGGpDuqub7FR27QK9UNxMXxewTRM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=s4PbungWf/Qfrou+PhrISQPexoOZ9PqtrXLlRmCjdsgdMlUSAIZTerOnt4z9Tk+gzsacI921Bk8GgLXWfKuglaG9xkJ2m9PXVESGPIa+ZObI6YWt2oKyb3jFnpDGN1PF3fx+zn01YUUZeVaBfETZCn1RfP9ggWLHTeKw07xErYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=q5Sq3COy; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728315653; x=1728920453; i=markus.elfring@web.de;
	bh=tde9+HTtwvSdjyegqAc2pBuj8Xp3aZ588ljCLxtJGic=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=q5Sq3COyuSf/1JH97wnrgaIuQ3reunJaZXWZmgVqH3S4bc1gzfXC1bXmCX0lRPZK
	 MohSHiT6Bdr9qEsk2PM6O1gZqD9rnqd+e//uYO9xZ4GmLXXcR6gWl8OwqWdvAoY3+
	 8TG7qKE/wkuby1eu63mCXt7MDg+vGZ4FCXadUmF/uCBxSdiKGblgH4Hxdh4KJHhUH
	 cxY5LdaysWk0KuX2IZ4m/HzB83zjBAAwZiZVeR+5dUomrUUly3khG1gzv8aBq1CQb
	 Rie09a8IG5pQL2HPE/H9GYTFc/Zm7IWgjB648sn8Uyn0AQmNlrn0o0I92Jep9ct4Y
	 EvUZpid7Dbs0snx9sg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mc1VF-1tZ6sc2ymF-00aZDj; Mon, 07
 Oct 2024 17:40:53 +0200
Message-ID: <caab097f-2522-4c07-9d05-ffa2acd4f157@web.de>
Date: Mon, 7 Oct 2024 17:40:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, Adam Thiede <me@adamthiede.com>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Yassine Oudjana <yassine.oudjana@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
 Nancy Lin <nancy.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>
References: <20241007070101.23263-5-jason-jh.lin@mediatek.com>
Subject: Re: [PATCH v9 4/5] drm/mediatek: ovl: Add blend_modes to driver data
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241007070101.23263-5-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xhaVx5v7PosVmZn5lfsVejKxm77d78UE8Dwj1ZHJMNzfubbc9hc
 nOMDtulMu4vq4tw/LAOTukfsSPVPLLOLPZqM3P3udTJIHJdl6aiEcZsvibqdJvqpg3WvuXl
 U2xDR+GtEQa8tpUhbvJQj4ppHPNP8+4o/NQZa4kSx24ZpA0n8V/I5nDPj/8Y4iFGXiN9W+i
 YSKD4lwcvpemBctWU0tYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i6vWuXQBUIU=;8wJPZmm+YsQAcUeXc+eYb4/8UrW
 mdoNJ5PMI8upFkOyQItiezXpSAGoHVOlOK3MpX3eXIulgTlc4zuur4F/alJYjKtk0tSE611Rg
 9KNU8T4MiErNjW3/3ag5oyul0u3C81SR6mP362eQzIKP7Xj8h5kah2GdQFTr5w9KayiWWhISa
 y9A8Y/q/2eMvwvVSGP3OzAKsddqrDlN4KCdfXiyWYXrkFplAwan6Cwwo0VdqxZ483Z1ODfrmN
 3JPLgGJOG/pOM73xm6LOFQpdLGfGSBo/eNCWxibra6/MH24Xhuvwns8pKr6r0QI0627A+J+3Y
 tnd9g2cp3BmXu9fJtdAKC9fTBE8hg2cXKhmhDKgGgl91ekjhu5o5r1ptUkFUdeiSTgteMRFXu
 C0qHtZ6mKeqi5/OFmckJGmP3+aam/ANOkAdcMwoCWswpeSxxq2OlIi4gxrjWdD96ATmrH9kgr
 2GYutXrcTPSoA2BSQLIBxVqhQGI4e45BXBsnngBJ86PKgAEcxWzJb1RXB8QvgDDGPittqaaEi
 qyDnIASjLIwfM8oNbaHFbYQ/myCerrwXaaoCkajWhA1rjJfpOO4NeA/lTLPPRRo/X3vGUMWFg
 Ft9xNG56sIgu0EVgTu0/71JNH8kG4/AJ6L3SbLXpGX15DZJ6vkU3XQ+XS5wfKS8eWpoXK9KRz
 J6K6rwUkUu11sbVfDkQMoi0R1Z3ddpzqgjWO6sOiZJdid57AGnADfkmeHikXvJwN24LygyIU6
 iWSM+bV7Lkm335H5XDKxh0WUCPkD+uwWW5KTguhdx3WFVF5a+jC5wM9iz1E2inrPADQxjFh4x
 rzqZi8jx1Pzox33zD5aIqA9Q==

=E2=80=A6
> premultiplied supported in current platform.
=E2=80=A6

                format would be?


Regards,
Markus

