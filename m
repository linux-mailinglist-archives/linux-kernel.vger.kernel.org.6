Return-Path: <linux-kernel+bounces-178253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 082DC8C4B23
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 04:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8007328618E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 02:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732A9B662;
	Tue, 14 May 2024 02:15:41 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BB1B645
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 02:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715652941; cv=none; b=aMGg2X9F448WF9TdXuT5a+2I//WwIveD/PoO1mAiJocgdvxMqsiw3MdlTV4/bXR3umjK3lcVPkddk6+i3RegqaI8A5SwTlEJ3i44s0UCYUefWO40Hsnqa0NK6fsmaJJ//33SUtcv0hT/K3mSKTsmcyPlQ7GeaJwRcAFHcwHJLnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715652941; c=relaxed/simple;
	bh=ZFj90tcc6DCZPul7tNZULC7jeoV3sQ05SiShGbBA1tM=;
	h=From:Subject:To:Cc:Date:Message-ID:References:MIME-Version:
	 Content-Type; b=uz/ib1YN+1psHGOv+/6LQ+k6eAl3o2QomAW4F39BGa5DCtQprEh5eveGvyMOlwngme2KydYHVH9tI8IAyiqny8XVIN5sY80Vu4h+0ZbZ9bDduiVC96MQpQOMnxZeCBG4FBJ00KLL1ufMYWun9XK55SLBE1WeGcekW+QuO2t1WFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cf8af8cc119711ef9305a59a3cc225df-20240514
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:5a6287b0-9667-4d3a-8655-21ddd07b874d,IP:30,
	URL:0,TC:4,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:14
X-CID-INFO: VERSION:1.1.38,REQID:5a6287b0-9667-4d3a-8655-21ddd07b874d,IP:30,UR
	L:0,TC:4,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:14
X-CID-META: VersionHash:82c5f88,CLOUDID:142b61dd6cc60b734346e31b2cc88622,BulkI
	D:240428152805F31X7C1F,BulkQuantity:2,Recheck:0,SF:66|24|17|19|44|102,TC:0
	,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: cf8af8cc119711ef9305a59a3cc225df-20240514
Received: from node4.com.cn [(39.156.73.12)] by mailgw.kylinos.cn
	(envelope-from <huanglei@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1561294893; Tue, 14 May 2024 10:15:19 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 0036C16002082;
	Tue, 14 May 2024 10:15:18 +0800 (CST)
Received: by node4.com.cn (NSMail, from userid 0)
	id E834F16002082; Tue, 14 May 2024 10:15:18 +0800 (CST)
From: =?UTF-8?B?6buE56OK?= <huanglei@kylinos.cn>
Subject: =?UTF-8?B?W1BBVENIXSBwYXJwb3J0OiBJbmNyZWFzZSBidWZmZXIgbWF4IGxlbmd0aCB0byBhdm9pZCBtZW1vcnkgb3V0IG9mIGJvdW5kcyBvdmVyZmxvdw==?=
To: 	=?UTF-8?B?c3VkaXBtLm11a2hlcmplZQ==?= <sudipm.mukherjee@gmail.com>,
Cc: 	=?UTF-8?B?bGludXgta2VybmVs?= <linux-kernel@vger.kernel.org>,
Date: Tue, 14 May 2024 10:15:17 +0800
X-Mailer: NSMAIL 7.0.0
Message-ID: <2ia1eihqhhv-2ia3ye4kl5g@nsmail7.0.0--kylin--1>
References: 20240507095558.20828-1-huanglei814@163.com
X-Israising: 0
X-Seclevel-1: 0
X-Seclevel: 0
X-Delaysendtime: Tue, 14 May 2024 10:15:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=nsmail-2mc46n1mn86-2mc5gkv1p1z
X-ns-mid: webmail-6642c935-2m2bzdi8
X-ope-from: <huanglei@kylinos.cn>

This message is in MIME format.

--nsmail-2mc46n1mn86-2mc5gkv1p1z
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PHA+RnJvbTogaHVhbmdsZWk8L3A+CjxwPiZuYnNwOzwvcD4KPHA+TW9zdCBv
ZiB0aGUgdGltZe+8jHdpbGwgdXNlIDY0IGJpdCBhZGRyZXNzLjxicj5zdWNo
IGFzIHBvcnQtJmd0O2Jhc2U9MHhmZmZmZmZjMDEwZTIxMjgwIGFuZCB0aGVu
IHVzZTxicj5sZW4gKz0gc3ByaW50ZiAoYnVmZmVyLCAiJWx1XHQlbHVcbiIs
IHBvcnQtJmd0O2Jhc2UsIHBvcnQtJmd0O2Jhc2VfaGkpLDxicj5wb3J0LSZn
dDtiYXNlIGNvbnZlcnQgdG8gc3RyaW5nIGlzICIxODQ0Njc0Mzc5OTExNDg5
NjAwMCIgYWRkPGJyPnBvcnQtJmd0O2Jhc2VfaGkgaXMgIjAiIGFuZCAiXHQi
ICJcbiIgbGVuIHdpbGwgYmUgMjMuPGJyPkJ1dCBidWZmZXIgdGhlIG9yaWdp
bmFsIG1heCBsZW5ndGggaXMgMjAsIGxlbmd0aCAyMyBpcyBvdXQgb2YgYnVm
ZmVyLjxicj5TbyB0byBtYWtlIHN1cmUgNjQgYml0IGFkZHJlc3Mgd2lsbCBu
b3QgZXhwZXJpZW5jZSBidWZmZXIgb3ZlcmZsb3csPGJyPm5lZWQgaW5jcmVh
c2UgYnVmZmVyIHNpemUgdG8gMzIuPGJyPjxicj5TaWduZWQtb2ZmLWJ5OiBo
dWFuZ2xlaSA8YnI+LS0tPGJyPmRyaXZlcnMvcGFycG9ydC9wcm9jZnMuYyB8
IDQgKystLTxicj4xIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKTxicj48YnI+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGFy
cG9ydC9wcm9jZnMuYyBiL2RyaXZlcnMvcGFycG9ydC9wcm9jZnMuYzxicj5p
bmRleCBiZDM4ODU2MGVkNTkuLjY3MjJhZTYyMGI2OCAxMDA2NDQ8YnI+LS0t
IGEvZHJpdmVycy9wYXJwb3J0L3Byb2Nmcy5jPGJyPisrKyBiL2RyaXZlcnMv
cGFycG9ydC9wcm9jZnMuYzxicj5AQCAtMTE3LDcgKzExNyw3IEBAIHN0YXRp
YyBpbnQgZG9faGFyZHdhcmVfYmFzZV9hZGRyKHN0cnVjdCBjdGxfdGFibGUg
KnRhYmxlLCBpbnQgd3JpdGUsPGJyPnZvaWQgKnJlc3VsdCwgc2l6ZV90ICps
ZW5wLCBsb2ZmX3QgKnBwb3MpPGJyPns8YnI+c3RydWN0IHBhcnBvcnQgKnBv
cnQgPSAoc3RydWN0IHBhcnBvcnQgKil0YWJsZS0mZ3Q7ZXh0cmExOzxicj4t
IGNoYXIgYnVmZmVyWzIwXTs8YnI+KyBjaGFyIGJ1ZmZlclszMl07PGJyPmlu
dCBsZW4gPSAwOzxicj48YnI+aWYgKCpwcG9zKSB7PGJyPkBAIC0xNzEsNyAr
MTcxLDcgQEAgc3RhdGljIGludCBkb19oYXJkd2FyZV9kbWEoc3RydWN0IGN0
bF90YWJsZSAqdGFibGUsIGludCB3cml0ZSw8YnI+dm9pZCAqcmVzdWx0LCBz
aXplX3QgKmxlbnAsIGxvZmZfdCAqcHBvcyk8YnI+ezxicj5zdHJ1Y3QgcGFy
cG9ydCAqcG9ydCA9IChzdHJ1Y3QgcGFycG9ydCAqKXRhYmxlLSZndDtleHRy
YTE7PGJyPi0gY2hhciBidWZmZXJbMjBdOzxicj4rIGNoYXIgYnVmZmVyWzMy
XTs8YnI+aW50IGxlbiA9IDA7PGJyPjxicj5pZiAoKnBwb3MpIHs8YnI+LS0g
PGJyPjIuMTcuMTwvcD4=

--nsmail-2mc46n1mn86-2mc5gkv1p1z--

