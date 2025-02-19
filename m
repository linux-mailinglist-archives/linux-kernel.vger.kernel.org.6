Return-Path: <linux-kernel+bounces-520855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10404A3B01B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 04:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476E81898299
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 03:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4CA1A317F;
	Wed, 19 Feb 2025 03:39:48 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17C51925BF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 03:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739936388; cv=none; b=eDIQJXnFSTL88JR6l8fvHkFjx4qu5CK1iNIR/46nIvaNByrgyUvVZjpy3gDDEAEShP5P1TS0YwRgb9KQSX3Xsu6pOMlszSEn8B9O4YSs7m2mfeT0SMrbJDtX0ekWgNj6Yf4RDiu+aYyXbGzB83dZqxI4ZSvEN9hDJ92KnbK5HQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739936388; c=relaxed/simple;
	bh=Iy6mpYlnebc+TXjjtdmoz978j1nFFTXwWxdN+7o7nqo=;
	h=From:Subject:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=ji1Jt87QkEQ2bOc/D9kaGsNR6Q6mRs0tmH2sT3/2EjhfV2bT56sEleif3P468WBoQyvSTlT/cYQSMuV8XdOsgWgIlIDcnMuLwm8XIwJ38a8BwTi/qaLpxknDAuuR1NGZ2RbvHVZovnBffmmdE7S3Z8THsHw17Vav7Rn6ZUVgGyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 20490d40ee7311efa216b1d71e6e1362-20250219
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:45fa74c7-696a-4246-adbd-113ac2d3daef,IP:0,U
	RL:0,TC:1,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-4
X-CID-META: VersionHash:6493067,CLOUDID:1fc538adc181258657f126e9e7e46fad,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:83|102,TC:0,Content:0|52,EDM:40,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 20490d40ee7311efa216b1d71e6e1362-20250219
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2062266954; Wed, 19 Feb 2025 11:39:30 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 054E4B807587;
	Wed, 19 Feb 2025 11:39:30 +0800 (CST)
Received: by node2.com.cn (NSMail, from userid 0)
	id DF2D8B807587; Wed, 19 Feb 2025 11:39:29 +0800 (CST)
From: =?UTF-8?B?5YiY54Oo?= <liuye@kylinos.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzJdIG1tL2ZvbGlvX3F1ZXVlOiBEZWxldGUgX19mb2xpb19vcmRlciBhbmQgdXNlIGZvbGlvX29yZGVyIGRpcmVjdGx5?=
To: 	=?UTF-8?B?YnJhdW5lcg==?= <brauner@kernel.org>,
	=?UTF-8?B?ZGhvd2VsbHM=?= <dhowells@redhat.com>,
	=?UTF-8?B?YWtwbQ==?= <akpm@linux-foundation.org>,
Cc: 	=?UTF-8?B?bGludXgta2VybmVs?= <linux-kernel@vger.kernel.org>,
	=?UTF-8?B?bGludXgtbW0=?= <linux-mm@kvack.org>,
	=?UTF-8?B?U2hpdmFuayBHYXJn?= <shivankg@amd.com>,
	=?UTF-8?B?RGV2IEphaW4=?= <dev.jain@arm.com>,
	=?UTF-8?B?ZGhvd2VsbHM=?= <dhowells@redhat.com>,
Date: Wed, 19 Feb 2025 11:39:29 +0800
X-Mailer: NSMAIL 7.0.0
Message-ID: <19qu8zljqzv-19qwsv8dung@nsmail7.0.0--kylin--1>
X-Israising: 0
X-Seclevel-1: 0
X-Seclevel: 0
X-Delaysendtime: Wed, 19 Feb 2025 11:39:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=nsmail-1ct9a42uulq-1ctak1w9wfj
X-ns-mid: webmail-67b55271-1cnjtvij
X-ope-from: <liuye@kylinos.cn>

This message is in MIME format.

--nsmail-1ct9a42uulq-1ctak1w9wfj
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0idmlld2VyX3BhcnQiIHN0eWxlPSJwb3NpdGlvbjogcmVs
YXRpdmU7Ij4KPGRpdj5GcmllbmRseSBwaW5nLjxicj48YnI+5ZyoIDIwMjUv
Mi8xMiAxMDo1OCwgTGl1IFllIOWGmemBkzo8YnI+Jmd0OyBfX2ZvbGlvX29y
ZGVyIGlzIHRoZSBzYW1lIGFzIGZvbGlvX29yZGVyLCByZW1vdmUgX19mb2xp
b19vcmRlciBhbmQgdGhlbjxicj4mZ3Q7IGp1c3QgaW5jbHVkZSBtbS5oIGFu
ZCB1c2UgZm9saW9fb3JkZXIgZGlyZWN0bHkuPGJyPiZndDsgPGJyPiZndDsg
U2lnbmVkLW9mZi1ieTogTGl1IFllIDxicj4mZ3Q7IC0tLTxicj4mZ3Q7IGlu
Y2x1ZGUvbGludXgvZm9saW9fcXVldWUuaCB8IDEyICsrKy0tLS0tLS0tLTxi
cj4mZ3Q7IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDkgZGVs
ZXRpb25zKC0pPGJyPiZndDsgPGJyPiZndDsgZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGludXgvZm9saW9fcXVldWUuaCBiL2luY2x1ZGUvbGludXgvZm9saW9f
cXVldWUuaDxicj4mZ3Q7IGluZGV4IDRkM2Y4MDc0YzEzNy4uNDVhZDI0MDhh
ODBjIDEwMDY0NDxicj4mZ3Q7IC0tLSBhL2luY2x1ZGUvbGludXgvZm9saW9f
cXVldWUuaDxicj4mZ3Q7ICsrKyBiL2luY2x1ZGUvbGludXgvZm9saW9fcXVl
dWUuaDxicj4mZ3Q7IEBAIC0xNSw2ICsxNSw3IEBAPGJyPiZndDsgI2RlZmlu
ZSBfTElOVVhfRk9MSU9fUVVFVUVfSDxicj4mZ3Q7IDxicj4mZ3Q7ICNpbmNs
dWRlIDxicj4mZ3Q7ICsjaW5jbHVkZSA8YnI+Jmd0OyA8YnI+Jmd0OyAvKjxi
cj4mZ3Q7ICogU2VnbWVudCBpbiBhIHF1ZXVlIG9mIHJ1bm5pbmcgYnVmZmVy
cy4gRWFjaCBzZWdtZW50IGNhbiBob2xkIGEgbnVtYmVyIG9mPGJyPiZndDsg
QEAgLTIxNiwxMyArMjE3LDYgQEAgc3RhdGljIGlubGluZSB2b2lkIGZvbGlv
cV91bm1hcmszKHN0cnVjdCBmb2xpb19xdWV1ZSAqZm9saW9xLCB1bnNpZ25l
ZCBpbnQgc2xvdCk8YnI+Jmd0OyBjbGVhcl9iaXQoc2xvdCwgJmFtcDtmb2xp
b3EtJmd0O21hcmtzMyk7PGJyPiZndDsgfTxicj4mZ3Q7IDxicj4mZ3Q7IC1z
dGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCBfX2ZvbGlvX29yZGVyKHN0cnVj
dCBmb2xpbyAqZm9saW8pPGJyPiZndDsgLXs8YnI+Jmd0OyAtIGlmICghZm9s
aW9fdGVzdF9sYXJnZShmb2xpbykpPGJyPiZndDsgLSByZXR1cm4gMDs8YnI+
Jmd0OyAtIHJldHVybiBmb2xpby0mZ3Q7X2ZsYWdzXzEgJmFtcDsgMHhmZjs8
YnI+Jmd0OyAtfTxicj4mZ3Q7IC08YnI+Jmd0OyAvKio8YnI+Jmd0OyAqIGZv
bGlvcV9hcHBlbmQ6IEFkZCBhIGZvbGlvIHRvIGEgZm9saW8gcXVldWUgc2Vn
bWVudDxicj4mZ3Q7ICogQGZvbGlvcTogVGhlIHNlZ21lbnQgdG8gYWRkIHRv
PGJyPiZndDsgQEAgLTI0MSw3ICsyMzUsNyBAQCBzdGF0aWMgaW5saW5lIHVu
c2lnbmVkIGludCBmb2xpb3FfYXBwZW5kKHN0cnVjdCBmb2xpb19xdWV1ZSAq
Zm9saW9xLCBzdHJ1Y3QgZm9saTxicj4mZ3Q7IHVuc2lnbmVkIGludCBzbG90
ID0gZm9saW9xLSZndDt2ZWMubnIrKzs8YnI+Jmd0OyA8YnI+Jmd0OyBmb2xp
b3EtJmd0O3ZlYy5mb2xpb3Nbc2xvdF0gPSBmb2xpbzs8YnI+Jmd0OyAtIGZv
bGlvcS0mZ3Q7b3JkZXJzW3Nsb3RdID0gX19mb2xpb19vcmRlcihmb2xpbyk7
PGJyPiZndDsgKyBmb2xpb3EtJmd0O29yZGVyc1tzbG90XSA9IGZvbGlvX29y
ZGVyKGZvbGlvKTs8YnI+Jmd0OyByZXR1cm4gc2xvdDs8YnI+Jmd0OyB9PGJy
PiZndDsgPGJyPiZndDsgQEAgLTI2Myw3ICsyNTcsNyBAQCBzdGF0aWMgaW5s
aW5lIHVuc2lnbmVkIGludCBmb2xpb3FfYXBwZW5kX21hcmsoc3RydWN0IGZv
bGlvX3F1ZXVlICpmb2xpb3EsIHN0cnVjdDxicj4mZ3Q7IHVuc2lnbmVkIGlu
dCBzbG90ID0gZm9saW9xLSZndDt2ZWMubnIrKzs8YnI+Jmd0OyA8YnI+Jmd0
OyBmb2xpb3EtJmd0O3ZlYy5mb2xpb3Nbc2xvdF0gPSBmb2xpbzs8YnI+Jmd0
OyAtIGZvbGlvcS0mZ3Q7b3JkZXJzW3Nsb3RdID0gX19mb2xpb19vcmRlcihm
b2xpbyk7PGJyPiZndDsgKyBmb2xpb3EtJmd0O29yZGVyc1tzbG90XSA9IGZv
bGlvX29yZGVyKGZvbGlvKTs8YnI+Jmd0OyBmb2xpb3FfbWFyayhmb2xpb3Es
IHNsb3QpOzxicj4mZ3Q7IHJldHVybiBzbG90Ozxicj4mZ3Q7IH08L2Rpdj4K
PC9kaXY+CjxwPiZuYnNwOzwvcD4KPHA+Jm5ic3A7PC9wPgo8cD4tLS0tPC9w
Pgo8ZGl2IGlkPSJjczJjX21haWxfc2lnYXR1cmUiPjwvZGl2Pgo8cD4mbmJz
cDs8L3A+CjxwPiZuYnNwOzwvcD4KPHA+Jm5ic3A7PC9wPg==

--nsmail-1ct9a42uulq-1ctak1w9wfj--

