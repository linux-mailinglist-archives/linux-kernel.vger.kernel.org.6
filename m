Return-Path: <linux-kernel+bounces-367378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 294FA9A017B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C791E1F26E4E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A92518DF72;
	Wed, 16 Oct 2024 06:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QNu60d5B"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B786860B8A;
	Wed, 16 Oct 2024 06:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729060431; cv=none; b=jYLulQTzJou427hDWjk02SSyZm1bkVCzDrZaml+7eILUSDMsbD5CNbT4x4z8ET/zY6kvojnpqAVt37EkZC5nQfBKImJEQEei8MfNey3CBRB9YMt/tgdUoEghW8CqKp0mNx1yenmXBypa5gIuwS3Ij7ckt+rxBZA6xmuOnyuBjHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729060431; c=relaxed/simple;
	bh=hJGCmCAm0+NrnhXdFEaREIKUcpTvYTP9lgQfeLpFNF4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LNVnFy+Y6CBOzmly4MonJ0N0bNG2qP8rfgsfeyXgF3I/91Aa6CDTlbMk95w5BhvgKTTDs/DJqGWdd1/KKWwzrUJXEewcYpk8jLQ5m82+7s/zvGXa+ugp3eqd8UwC+TuFRYbiqzQbz/gDQdOK5127hLEYelPq18lLyS8hM0Xd3Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QNu60d5B; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=xEnXy
	AUa3ZKHeWOZg2rReBIpcGcdsVLQBUE0WU79xmo=; b=QNu60d5BSKdZnbdYdIozO
	ONW6xt8H4wOAsgOu0X3pxouY5VztDko1KFpr/hLQsoqZZ2LnsLF/VfPVNcP7ujIY
	lRCcKvlau6RbB8eISziOZsmUGel59DzreFIzyRWaXUPvWv+3U4YUEthkbBfqY++N
	/JGUPLzoB/IO3OFf6zRP8k=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDnj60tXg9n+bvABQ--.63225S4;
	Wed, 16 Oct 2024 14:33:19 +0800 (CST)
From: yaxin_wang <yaxin_wang_uestc@163.com>
To: alexs@kernel.org,
	siyanteng@loongson.cn,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mudongliangabcd@gmail.com,
	seakeel@gmail.com
Cc: wang.yaxin@zte.com.cn,
	fan.yu9@zte.com.cn,
	xu.xin16@zte.com.cn,
	he.peilin@zte.com.cn,
	tu.qiang35@zte.com.cn,
	qiu.yutan@zte.com.cn,
	zhang.yunkai@zte.com.cn
Subject: Re: [PATCH v5] Docs/zh_CN: Translate physical_memory.rst to Simplified Chinese
Date: Wed, 16 Oct 2024 06:33:16 +0000
Message-Id: <20241016063316.2792999-1-yaxin_wang_uestc@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnj60tXg9n+bvABQ--.63225S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kry8tFyUWw1DKr45KF17ZFb_yoW8Jw4fpF
	Wru3ZFgF4kJw13GF1jkryUZFy8Kas3Jryakan3Wr1xZrWUGa4q9r9xKrZ09F98uFs5Kr4S
	yw12kFn7Jr98ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRO_-QUUUUU=
X-CM-SenderInfo: p1d0x0xbzd0wpbxh23rf6rljoofrz/1tbi7g96xGcPTcHz-AABs1

>> Alex Shi <seakeel@gmail.com> writes:
>>
>>> Hi Jiang,
>>>
>>> Your patch format is still odd in 'Subject':
>>> Subject: =?UTF-8?B?wqBbUEFUQ0ggdjVdIERvY3MvemhfQ046IFRyYW5zbGF0ZSBwaHlzaWNhbF9tZW1vcnkucnN0IHRvIFNpbXBsaWZpZWTCoENoaW5lc2U=?=
>>> Content-Type: text/plain;
>>>          charset="UTF-8"
>>> X-MAIL:mse-fl2.zte.com.cn 49C9DsLB077233
>>> X-Fangmail-Anti-Spam-Filtered: true
>>> X-Fangmail-MID-QID: 670A3DD9.001/4XQd8n4BCPz5B1DK
>>>
>>> It should a English word.
>>> You need to send patch to yourself and apply it to check if
>>> everything all right.
>> I think the formatting is OK - the patch applies fine here.  I would
>> appreciate a review of the actual content, though...:)
><https://lore.kernel.org/linux-doc/1add7be9-0da0-4463-a3ea-80e2fd99bd19@gmail.com/>
> From the very beginning, we have reviewed the content. Moving forward,
>we will continue with the review process, but we would really appreciate
>receiving feedback from the translator, even if it's just a simple "OK".
>
>Alex, I believe we need to draft a Chinese translation guide, in order to
>minimize the review work that is unrelated to the content itself.
>
>Thanks,
>Yanteng
>
>>
>> Thanks,
>>
>> jon
>>
I think it's ok, and I will send a new patch to fix the problem pointed by Alex.

Thanks,
Yaxin


