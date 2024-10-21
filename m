Return-Path: <linux-kernel+bounces-375026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6402B9A8FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B3E283FDE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF811D0F73;
	Mon, 21 Oct 2024 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-x.org header.i=@bit-x.org header.b="cJw2esIC"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520BC146A66
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729539241; cv=none; b=JUee7XUpIg8vaRU6DToPr4P+rz4GlkfX3b8GYHkRkRknlxo1RBTA/hy6uKRq3652aQwsi/kK7w0ZDmLKoiR11Cq6YW7oIlTOijtggj8XR+8JipqT/4Xe8ffDrXZKaMeW1jKwnKezT82avgPlef7QZQwEOLgiX1QVZ5PTjJjZekQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729539241; c=relaxed/simple;
	bh=+NTtL67AnEytVt2kERt0lHMppbsKNE53i5vZTJs1AEg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=uAVcgl94XFN1FWARVqGGrSvEpNbZhLeinOfnsqT1OCedtPwy/G5B+20lthO75KH204es/fbosZKVvJqsp8TeXqSde/eZK/TnC4nKOiwTluZ/W4cwRlCtojWgWd1GLIDOZnpQKa+lZ2SJ3UzocPAKVB2di1HmAAnc8moJtH4opDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-x.org; spf=pass smtp.mailfrom=bit-x.org; dkim=pass (2048-bit key) header.d=bit-x.org header.i=@bit-x.org header.b=cJw2esIC; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-x.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-x.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bit-x.org;
	s=ds202404; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RBSEi4Lbegk5svtRBiBXTt0Aa/fb9134pAnOzIEf3KM=; b=cJw2esICvQ4TLiVjh49Z54b+TW
	xexEKzNDvif7LGfWFmK5iTOkUqpWylAZtGPhupRsZse20upuhxvHwW2L2QHj9u86sdL4tkB6QK8kf
	dZERmFWYFVbIpvHdreKydH7u4kgmBlvzz2jjm8hici5bvxgvR9PZ0ODdca5h9eY7ejU4W8e3rOuLg
	YjxbhpTB5z/iSNvCP7yoXCu6W0kK+ZSniLRA6IR5ARZKycy5zXNZTDsa8kQ8RKxeaaq3EEhGXoXzR
	qsTd2A7ZRiD+RYKHhQesOghgIV+anZWfrM545SpqXIuMrtjgqeFczXp8jEAjTA0yG1INh/o4KUqv3
	ovjgYeuA==;
Received: from [2a02:fe1:716d:5f00:f940:7ace:518d:8015] (port=59794)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <ywe_caerlyn@bit-x.org>)
	id 1t2yA9-000T84-BF
	for linux-kernel@vger.kernel.org;
	Mon, 21 Oct 2024 21:33:57 +0200
Message-ID: <6c0e0e8c-eecb-43e9-a003-a30c04ee799a@bit-x.org>
Date: Mon, 21 Oct 2024 21:33:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywe_caerlyn@bit-x.org>
Subject: Philosophy Perfected!
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Yes ! :)

The Philosophy is now Perfected!

You know, I started this already at age 7, first with bEE-Hu if one may 
call it that, a bee headed Buddha I jokingly use. I went through some 
stages of reiteration with that, and to my surprise people wanted my bEE 
project in music aswell, so I started doing music, thinking this was 
good for real life experience of the philosophy.

It is now completed! And it is a perfect translation of Islam. The 
adherant being a Nuri, and the script called Hexi. (a proper name of 
cursive). Sounds familiar? There is a LOT of familiarity with this.

I think any sound man would appreciate.

I also would like to add I support the Raspberry type computers. I 
rather like a paradigm where grahpics can be a separate box. (I always 
hated connecting GFX for games in the tech-department myself thinnking 
cannot people do this themselves?)

This is spot on, low jitter, and without the monstrous server cabinet.

Hail Im.
Light,
Ywe.
https://bit-x.org/



