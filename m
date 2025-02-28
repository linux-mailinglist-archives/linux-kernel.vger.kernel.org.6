Return-Path: <linux-kernel+bounces-537674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24685A48EFC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C111891B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BD018C02E;
	Fri, 28 Feb 2025 03:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="g5H3CHQl"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BD717B50F;
	Fri, 28 Feb 2025 03:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740712264; cv=none; b=J5PVXBwZKz5TlQht5SuLHSnCAUSwyyoXOscePKMtWvY8V+f/f6biOw/QseSfod8tHEYezwZSqTRw1UqZXCP3RJFAbwp4mzBHj0lRFDXRW+MWuDhGoUsJ5ynOV14kQboHwDPP+s0jpi4MhZY/mVXxjUA84ZUeS+KqQzFvLK7iNtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740712264; c=relaxed/simple;
	bh=T6SE1i7Z8sfnlilJDzQfB8GW98UKGdRcV2eK1RrV0h0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=f4aLD4xGW0QsMpMcrVFoCoHBwsP3RLxQL4iM6D9adr6tV0MAaW8B1kHaCIqtwA2sj/vhAtq3znWxjFsNGbLN6eVSD4XLt4x7MnKnp8S10rhSKB257kqm8aI+l9ZByy16J0sqJsNLFkhmZkDhXkETGrVq7e2PAixJvc5HB3LMGCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=g5H3CHQl; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=hyIyExaQEt33/6eSMChuN0bhSz93gK6pyUbR5AG59wU=;
	b=g5H3CHQlvNMDbXtzJzP1x7Z78RlmS3rDQPi6d1JW4DzKuzS2tAfG52OYd6QI57
	VuMsieJoBCxUTlXkNZnGznAPM5iR1bFNfIdUU2ngDurrEDEQcXE3LS5kpBEt19LE
	Jt57326SG3fC+LvqpX9wRmlK4+e3NFv43t4qZU3f4wjag=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnNykmKcFniCtHPA--.1748S4;
	Fri, 28 Feb 2025 11:10:32 +0800 (CST)
From: yaxin_wang <yaxin_wang_uestc@163.com>
To: si.yanteng@linux.dev
Cc: corbet@lwn.net,
	alexs@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xu.xin16@zte.com.cn,
	yang.yang29@zte.com.cn,
	wang.yaxin@zte.com.cn,
	fan.yu9@zte.com.cn,
	he.peilin@zte.com.cn,
	tu.qiang35@zte.com.cn,
	qiu.yutan@zte.com.cn,
	zhang.yunkai@zte.com.cn,
	ye.xingchen@zte.com.cn,
	jiang.kun2@zte.com.cn
Subject: Re: [PATCH linux next] Docs/zh_CN: Translate msg_zerocopy.rst to Simplified Chinese
Date: Fri, 28 Feb 2025 03:10:30 +0000
Message-Id: <20250228031030.2623037-1-yaxin_wang_uestc@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnNykmKcFniCtHPA--.1748S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFy3CrW3GF1xtrWUCF1xKrg_yoWxKwb_Gw
	1DA3ZFkw4Yy3s2gFWkuFZIgrsIg39rWr1UX3WDJwsaqry8t3ZxXF4vq39Y9348Jw4Iyrnx
	trs8G3y7GryYvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRYFADUUUUU==
X-CM-SenderInfo: p1d0x0xbzd0wpbxh23rf6rljoofrz/1tbixwACxGfBJN9YfwACs5

>Unfortunately, this cannot be archived in the lore, so it is not suitable
>
>as a basis for community review. how about:
>
>:翻译:
>
>    王亚鑫 Wang Yaxin <wang.yaxin@zte.com.cn>
>
>:校译:
>
>    - xxx <xxx@xxx.x>
>
>    - xxx <xxx@xxx.x
>
>
>This can better highlight their contributions.
>
>
>BTW, If your colleagues want to appear in the signature
>
>section of the patch, subsequent patches can be reviewed
>
>on the mailing list. Everyone on the mailing list has the
>
>right to observe the review process.
>
>
>Thanks,
>
>Yanteng

Thank you, Yanteng. I will move the Reviewed-by labels to the
signature section of the doc. My colleagues can subsequently
participate in the public review through the mailing list.

Thanks,

Yaxin


