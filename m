Return-Path: <linux-kernel+bounces-408562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C41A49C8073
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 03:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73EBA1F22716
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D481E883F;
	Thu, 14 Nov 2024 02:20:05 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25F32F5A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 02:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731550804; cv=none; b=iuFHYGhmrH6tQDzb8Nd8IQmftLqEa1gQ5j4yHWllBwaLbHGAX2SCdVP3LFLBd4f9S/lqg+JH25WAvSIJU7KKdb6nEVjWauDXZGWR+lfqBWOoig5pCs2wXgmQPb810g96VSxaO31Wu7gYtec/7r5TlsP65xqUNqz5fXRRWOPTg9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731550804; c=relaxed/simple;
	bh=yJsc9JXTixYPnAcberPlBegLEtDVi2FtHs6OvJAiiuM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=hG2/CcVkZkdaoubEwqUoq0vm7ZrclZ6LaYrhvnwyOlILeE4pbLkxI/WbsC3P6wsZ28qRva1hDGa4glWBY3aYwpnRwPJ7HtiOUscZ1OvhUTjtan8y6TK087BjJ7E+eh4ughilVKuPJbjWfb9Sp5PY2afJTOIMGquYH7hzXtS8aDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: eeb7edb8a22e11efa216b1d71e6e1362-20241114
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:6420481d-1376-4910-bc4c-8d3060e7e67f,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:82c5f88,CLOUDID:2c02bbe398a17ca75c600c68fa437743,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: eeb7edb8a22e11efa216b1d71e6e1362-20241114
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1633908147; Thu, 14 Nov 2024 10:19:52 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id B710C16002081;
	Thu, 14 Nov 2024 10:19:52 +0800 (CST)
X-ns-mid: postfix-67355E48-626503522
Received: from [10.42.116.241] (unknown [10.42.116.241])
	by node4.com.cn (NSMail) with ESMTPA id 40EBB16002081;
	Thu, 14 Nov 2024 02:19:52 +0000 (UTC)
Message-ID: <6b1277a8-30a6-4d2b-9b25-93d105503ea3@kylinos.cn>
Date: Thu, 14 Nov 2024 10:19:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: 67321ded.050a0220.a83d0.0016.GAE@google.com,
 syzbot+3fa2af55f15bd21cada9@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org
From: Pei Xiao <xiaopei01@kylinos.cn>
Subject: Re: [syzbot] [input?] [usb?] UBSAN: shift-out-of-bounds in s32ton
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

s32ton always be 0 when n>=32,add check n.

#syz test

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 81d6c734c8bc..ead1d338fa58 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -66,8 +66,11 @@ static s32 snto32(__u32 value, unsigned int n)

  static u32 s32ton(__s32 value, unsigned int n)
  {
-       s32 a = value >> (n - 1);
+       s32 a;

+       if (n >= 32)
+               return value;
+       a = value >> (n - 1);
         if (a && a != -1)
                 return value < 0 ? 1 << (n - 1) : (1 << (n - 1)) - 1;
         return value & ((1 << n) - 1);

