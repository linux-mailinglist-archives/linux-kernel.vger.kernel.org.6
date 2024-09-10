Return-Path: <linux-kernel+bounces-322550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8453F972AB1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B630F1C24232
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8077D17C7C2;
	Tue, 10 Sep 2024 07:28:28 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85259171671
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725953308; cv=none; b=ok8a4kUD699AkUj5O9HOyH5TOI3Rbt3XRlKhqt2KjhvWKv44x14J1rMzOUbNih1v57avkxbIIhLcHFBMABCIuBkNZ6OktecqRmV39Py3BBcof/+M/73Qjvw2dW2iUDpcnU8eP4ZGiGDx2MmPC5mdzPJ8VfPYFMq9w1boJDzKSGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725953308; c=relaxed/simple;
	bh=MFqXUSqMnWd5kb/XHHgGfobm/9JFGuanOt7xNLiORDU=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To; b=TGzcxT92NliYB24hzQpu+8iOQarzqLGb7yzIfin9cJsYSTjYhyCnnqz9GsHCylv6ArmyTGEtz/yCfFpEnY6eC/gcMC8W6EuEYydWwA6NoHA9iiY/5hiS2IlzvL+9ZOPzCtStTFNeCQz7NkAyEsuNJ8PemwHlfVrdQXDBqBmCiHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3fbdeeb86f4611efa216b1d71e6e1362-20240910
X-QC-Scan-Result: 0
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:dd4a77c7-3700-44f3-9f6e-ca79e80dd828,IP:10,
	URL:0,TC:0,Content:5,EDM:0,RT:0,SF:-5,FILE:5,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:15
X-CID-INFO: VERSION:1.1.38,REQID:dd4a77c7-3700-44f3-9f6e-ca79e80dd828,IP:10,UR
	L:0,TC:0,Content:5,EDM:0,RT:0,SF:-5,FILE:5,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:15
X-CID-META: VersionHash:82c5f88,CLOUDID:016b2c20e0ac158f5f43d1fc851f963c,BulkI
	D:240910152819U9USM7Y9,BulkQuantity:0,Recheck:0,SF:19|43|74|66|23|17|102,T
	C:nil,Content:4|-5,EDM:-3,IP:-2,URL:0,File:2,RT:nil,Bulk:nil,QS:0,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 3fbdeeb86f4611efa216b1d71e6e1362-20240910
X-User: zhaomengmeng@kylinos.cn
Received: from [192.168.109.86] [(123.149.251.227)] by mailgw.kylinos.cn
	(envelope-from <zhaomengmeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1185552756; Tue, 10 Sep 2024 15:28:17 +0800
Content-Type: multipart/mixed; boundary="------------Tdcq1JiFtJ0apQYUwmJ0WCr2"
Message-ID: <bab2637d-45a0-4f45-8488-6a56b4feaf4e@kylinos.cn>
Date: Tue, 10 Sep 2024 15:28:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+7a4842f0b1801230a989@syzkaller.appspotmail.com
Cc: jack@suse.com, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <0000000000005093590621340ecf@google.com>
Subject: Re: [syzbot] [udf?] KASAN: slab-out-of-bounds Read in
 udf_get_filelongad (2)
From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
In-Reply-To: <0000000000005093590621340ecf@google.com>

This is a multi-part message in MIME format.
--------------Tdcq1JiFtJ0apQYUwmJ0WCr2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test
--------------Tdcq1JiFtJ0apQYUwmJ0WCr2
Content-Type: text/x-patch; charset=UTF-8; name="test.patch"
Content-Disposition: attachment; filename="test.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2ZzL3VkZi9pbm9kZS5jIGIvZnMvdWRmL2lub2RlLmMKaW5kZXggNDcy
NmE0ZDAxNGI2Li4zNTA5NjJiZmM3MWYgMTAwNjQ0Ci0tLSBhL2ZzL3VkZi9pbm9kZS5jCisr
KyBiL2ZzL3VkZi9pbm9kZS5jCkBAIC02NjYsNyArNjY2LDcgQEAgc3RhdGljIGludCB1ZGZf
ZXh0ZW5kX2ZpbGUoc3RydWN0IGlub2RlICppbm9kZSwgbG9mZl90IG5ld3NpemUpCiAJCSAg
ICAgZWxlbiA+ICgobG9mZl90KW9mZnNldCArIDEpIDw8IGlub2RlLT5pX2Jsa2JpdHMpOwog
CiAJaWYgKCghZXBvcy5iaCAmJiBlcG9zLm9mZnNldCA9PSB1ZGZfZmlsZV9lbnRyeV9hbGxv
Y19vZmZzZXQoaW5vZGUpKSB8fAotCSAgICAoZXBvcy5iaCAmJiBlcG9zLm9mZnNldCA9PSBz
aXplb2Yoc3RydWN0IGFsbG9jRXh0RGVzYykpKSB7CisJICAgIChlcG9zLm9mZnNldCA9PSBz
aXplb2Yoc3RydWN0IGFsbG9jRXh0RGVzYykpKSB7CiAJCS8qIEZpbGUgaGFzIG5vIGV4dGVu
dHMgYXQgYWxsIG9yIGhhcyBlbXB0eSBsYXN0CiAJCSAqIGluZGlyZWN0IGV4dGVudCEgQ3Jl
YXRlIGEgZmFrZSBleHRlbnQuLi4gKi8KIAkJZXh0ZW50LmV4dExvY2F0aW9uLmxvZ2ljYWxC
bG9ja051bSA9IDA7Cg==

--------------Tdcq1JiFtJ0apQYUwmJ0WCr2--

