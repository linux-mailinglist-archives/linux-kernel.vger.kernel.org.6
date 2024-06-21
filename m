Return-Path: <linux-kernel+bounces-224464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD479122C0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2515F289936
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E76172799;
	Fri, 21 Jun 2024 10:45:29 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416CE172784
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 10:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966729; cv=none; b=HZkCvrV8hq+f4kpHCzFCCyhnJZ6Nuc5azgIampzp9ZyqMaN/t5X7KOkaTWBUTSbS52EqrvaNQ/JAk+ltQHAVt7KYoPpGawYYLZoSVrZMNq0/Vve0BrB9h6gh5oAgjymt0iXnbmVoj32Uqy4kMYfk2OjTH+Bg9AiTU3GWBnfQx2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966729; c=relaxed/simple;
	bh=1XwFKly4cs7PcvOcUHmUCRlNu+w/zdo+sADEBfK9PwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jU3h4ZuPHxCiC/UpEFVstB6Ka9P3Lpxh2igHxY2dFv/r/UZHr1o/e6yyHe4Elw0FR2pupHQl+bu5Ej6cuEoT5N1HTg3nD2uyhiScQZHlzJslWVpfTvBv7GBKsTq1v2PNXw+tmyXa7EoVtzptqcCaPcOYkPMQ0mWMpZyU1kMTiP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a6d9ded42fba11ef9305a59a3cc225df-20240621
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:ec2780ce-2419-4e24-9dfe-935dc1c31ce5,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:6
X-CID-INFO: VERSION:1.1.38,REQID:ec2780ce-2419-4e24-9dfe-935dc1c31ce5,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:6
X-CID-META: VersionHash:82c5f88,CLOUDID:80c16f1438ba1a9cbeb3f8174ba81c85,BulkI
	D:240620143416P0737R0Q,BulkQuantity:2,Recheck:0,SF:43|74|64|66|24|17|19|81
	7|102,TC:nil,Content:0|-5,EDM:-3,IP:-2,URL:1,File:nil,RT:nil,Bulk:40,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULS
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI, GTI_FG_IT, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
	ABX_MISS_RDNS
X-UUID: a6d9ded42fba11ef9305a59a3cc225df-20240621
X-User: lihongfu@kylinos.cn
Received: from localhost.localdomain [(223.70.159.255)] by mailgw.kylinos.cn
	(envelope-from <lihongfu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1636551456; Fri, 21 Jun 2024 18:40:18 +0800
From: Hongfu Li <lihongfu@kylinos.cn>
To: markus.elfring@web.de
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev,
	julia.lawall@inria.fr,
	lihongfu@kylinos.cn,
	linux-kernel@vger.kernel.org,
	teigland@redhat.com
Subject: Re: dlm: use KMEM_CACHE() in dlm_memory_init() 
Date: Fri, 21 Jun 2024 18:39:59 +0800
Message-Id: <20240621103959.131413-1-lihongfu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <5094e8bf-6eb6-43e4-80de-052e9c0c67c0@web.de>
References: <5094e8bf-6eb6-43e4-80de-052e9c0c67c0@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

>> My initial purpose is to replace kmem_cache_create() with KMEM_CACHE().
>
>Do you take any help from advanced analysis tools into account
>for such transformation attempts?
>
>Example for the semantic patch language (Coccinelle software):
>[PATCH v2] Coccinelle: api: Add SmPL script “use_KMEM_CACHE.cocci”
>https://lore.kernel.org/cocci/b08603d6-cac1-4876-a56c-30c680d5dc52@web.de/
>https://sympa.inria.fr/sympa/arc/cocci/2024-02/msg00000.html
>
>
>> In my view，there is no problem in unifying passed name strings and
>> structure identifiers.
>> Maybe that's wrong，
>
>I suggest to take another look also at feedback which other contributors
>(from your Linux software distribution) got for similar change suggestions.
>
>
>> I will resubmit a patch that does not change "dlm_cb" to "dlm_callback".
>
>Do you see further opportunities to improve the change description accordingly?
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc4#n94

So grateful for you suggestion and I will definitely consider it.

thanks,
Hongfu Li

