Return-Path: <linux-kernel+bounces-228266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28419915D6C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 05:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0501F22682
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C4476033;
	Tue, 25 Jun 2024 03:44:48 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECC12F56
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 03:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719287088; cv=none; b=JqGsszc0A3C7vafbJZiu/MYPhRoXIr8rQOT54SdFD7cMXqf1SFVbphw6pJmreaPtGTEZXPnXIByaBQRCY30jJy8Q+K3PJX4GR2iBg3XDlJE7i583CQi2LD4Qi/8BMJqIujAH6pO2es8kcKqzFwxlsC9lbVdQ5efm2QDpg0E/Ozc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719287088; c=relaxed/simple;
	bh=3Kvs+mYkE7tvzWw+1nCQmDF5YnLkFg9jBHqNnjazxRU=;
	h=From:Subject:To:Cc:Date:Message-ID:References:MIME-Version:
	 Content-Type; b=nOeiuyPnP55MX/fgcqVkrhCLNINnVojQWRycOQrJMvYj6S6JMdbnrRh+EeYixIJ3ALngFKzNLO8DVQWhZmlOh8W69cTny91I2r6BfGu0qaqzFXcCK6ElNfc/gQPrVhohGdZYnr2aE42iYrQL4QaAZmz+Wji10ytygfC8jeSRv8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c0824e5c32a311ef9305a59a3cc225df-20240625
X-QC-Scan-Result: 0
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:94f83f07-0be2-4b29-91c3-1c7648708e1b,IP:20,
	URL:0,TC:11,Content:0,EDM:0,RT:0,SF:-15,FILE:5,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:21
X-CID-INFO: VERSION:1.1.38,REQID:94f83f07-0be2-4b29-91c3-1c7648708e1b,IP:20,UR
	L:0,TC:11,Content:0,EDM:0,RT:0,SF:-15,FILE:5,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:21
X-CID-META: VersionHash:82c5f88,CLOUDID:cd9f31ea82404ef1671e978470a70f13,BulkI
	D:240625113357MCBYHV85,BulkQuantity:0,Recheck:0,SF:44|66|24|17|19|102,TC:0
	,Content:0,EDM:-3,IP:-2,URL:0,File:2,RT:nil,Bulk:nil,QS:0,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: c0824e5c32a311ef9305a59a3cc225df-20240625
Received: from node2.com.cn [(39.156.73.10)] by mailgw.kylinos.cn
	(envelope-from <lizhenneng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1029634221; Tue, 25 Jun 2024 11:33:56 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id EC7A9B803C9B;
	Tue, 25 Jun 2024 11:33:55 +0800 (CST)
Received: by node2.com.cn (NSMail, from userid 0)
	id E021DB803C9B; Tue, 25 Jun 2024 11:33:55 +0800 (CST)
From: =?UTF-8?B?5p2O55yf6IO9?= <lizhenneng@kylinos.cn>
Subject: =?UTF-8?B?5Zue5aSNOiBSZTogW1BBVENIXSBtaWdyYXRlX3BhZ2VzOiBtb2RpZnkgbWF4IG51bWJlciBvZiBwYWdlcyB0byBtaWdyYXRlIGluIGJhdGNo?=
To: 	=?UTF-8?B?eWluZy5odWFuZw==?= <ying.huang@intel.com>,
Cc: 	=?UTF-8?B?QW5kcmV3IE1vcnRvbg==?= <akpm@linux-foundation.org>,
	=?UTF-8?B?bGludXgtbW0=?= <linux-mm@kvack.org>,
	=?UTF-8?B?bGludXgta2VybmVs?= <linux-kernel@vger.kernel.org>,
Date: Tue, 25 Jun 2024 11:33:54 +0800
X-Mailer: NSMAIL 7.0.0
Message-ID: <7ii375j23j-7ikn2sd5r4@nsmail7.0.0--kylin--1>
References: 87o77pzuq3.fsf@yhuang6-desk2.ccr.corp.intel.com
X-Israising: 0
X-Seclevel-1: 0
X-Seclevel: 0
X-Delaysendtime: Tue, 25 Jun 2024 11:33:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=nsmail-ai4b42t5cy-ai5l1w876r
X-ns-mid: webmail-667a3aa3-aaqvq3ul
X-ope-from: <lizhenneng@kylinos.cn>

This message is in MIME format.

--nsmail-ai4b42t5cy-ai5l1w876r
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PHA+PGJyPjxicj48YnI+PGJyPjxicj48YnI+LS0tLTwvcD4KPGRpdiBpZD0i
Y3MyY19tYWlsX3NpZ2F0dXJlIj48L2Rpdj4KPHA+Jm5ic3A7PC9wPgo8ZGl2
IHN0eWxlPSJtYXJnaW4tbGVmdDogMC41ZW07IHBhZGRpbmctbGVmdDogMC41
ZW07IGJvcmRlci1sZWZ0OiAxcHggc29saWQgZ3JlZW47Ij4mbmJzcDs8L2Rp
dj4KPGRpdiBpZD0icmUiIHN0eWxlPSJtYXJnaW4tbGVmdDogMC41ZW07IHBh
ZGRpbmctbGVmdDogMC41ZW07IGJvcmRlci1sZWZ0OiAxcHggc29saWQgZ3Jl
ZW47Ij48YnI+PGJyPjxicj4KPGRpdiBzdHlsZT0iYmFja2dyb3VuZC1jb2xv
cjogI2Y1ZjdmYTsiPjxzdHJvbmc+5Li744CA6aKY77yaPC9zdHJvbmc+PHNw
YW4gaWQ9InN1YmplY3QiPlJlOiBbUEFUQ0hdIG1pZ3JhdGVfcGFnZXM6IG1v
ZGlmeSBtYXggbnVtYmVyIG9mIHBhZ2VzIHRvIG1pZ3JhdGUgaW4gYmF0Y2g8
L3NwYW4+IDxicj48c3Ryb25nPuaXpeOAgOacn++8mjwvc3Ryb25nPjxzcGFu
IGlkPSJkYXRlIj4yMDI0LTA2LTI1IDA5OjE3PC9zcGFuPiA8YnI+PHN0cm9u
Zz7lj5Hku7bkurrvvJo8L3N0cm9uZz48c3BhbiBpZD0iZnJvbSI+eWluZy5o
dWFuZzwvc3Bhbj4gPGJyPjxzdHJvbmc+5pS25Lu25Lq677yaPC9zdHJvbmc+
PHNwYW4gaWQ9InRvIiBzdHlsZT0id29yZC1icmVhazogYnJlYWstYWxsOyI+
5p2O55yf6IO9Ozwvc3Bhbj48L2Rpdj4KPGJyPgo8ZGl2IGlkPSJjb250ZW50
Ij4KPGRpdiBjbGFzcz0idmlld2VyX3BhcnQiIHN0eWxlPSJwb3NpdGlvbjog
cmVsYXRpdmU7Ij4KPGRpdj5IaSwgWmhlbm5lbmcsPGJyPjxicj5aaGVubmVu
ZyBMaSB3cml0ZXM6PGJyPjxicj4mZ3Q7IFdlIHJlc3RyaWN0IHRoZSBudW1i
ZXIgb2YgcGFnZXMgdG8gYmUgbWlncmF0ZWQgdG8gbm8gbW9yZSB0aGFuPGJy
PiZndDsgSFBBR0VfUE1EX05SIG9yIE5SX01BWF9CQVRDSEVEX01JR1JBVElP
TiwgYnV0IGluIGZhY3QsIHRoZTxicj4mZ3Q7IG51bWJlciBvZiBwYWdlcyB0
byBiZSBtaWdyYXRlZCBtYXkgcmVhY2ggMipIUEFHRV9QTURfTlItMSBvciAy
PGJyPiZndDsgKk5SX01BWF9CQVRDSEVEX01JR1JBVElPTi0xLCBpdCdzIG5v
dCBpbiBpbmNvbnNpc3RlbnQgd2l0aCB0aGUgY29udGV4dC48YnI+PGJyPlll
cy4gSXQncyBub3QgSFBBR0VfUE1EX05SIGV4YWN0bHkuPGJyPjxicj4mZ3Q7
IFBsZWFzZSByZWZlciB0byB0aGUgcGF0Y2g6IDQyMDEyZTA0MzZkNChtaWdy
YXRlX3BhZ2VzOiByZXN0cmljdCBudW1iZXI8YnI+Jmd0OyBvZiBwYWdlcyB0
byBtaWdyYXRlIGluIGJhdGNoKTxicj4mZ3Q7PGJyPiZndDsgU2lnbmVkLW9m
Zi1ieTogWmhlbm5lbmcgTGkgPGJyPiZndDsgLS0tPGJyPiZndDsgbW0vbWln
cmF0ZS5jIHwgMiArLTxicj4mZ3Q7IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKTxicj4mZ3Q7PGJyPiZndDsgZGlmZiAt
LWdpdCBhL21tL21pZ3JhdGUuYyBiL21tL21pZ3JhdGUuYzxicj4mZ3Q7IGlu
ZGV4IDc4MTk3OTU2N2Y2NC4uN2E0YjM3YWFjOWU4IDEwMDY0NDxicj4mZ3Q7
IC0tLSBhL21tL21pZ3JhdGUuYzxicj4mZ3Q7ICsrKyBiL21tL21pZ3JhdGUu
Yzxicj4mZ3Q7IEBAIC0xOTYxLDcgKzE5NjEsNyBAQCBpbnQgbWlncmF0ZV9w
YWdlcyhzdHJ1Y3QgbGlzdF9oZWFkICpmcm9tLCBuZXdfZm9saW9fdCBnZXRf
bmV3X2ZvbGlvLDxicj4mZ3Q7IGJyZWFrOzxicj4mZ3Q7IH08YnI+Jmd0OyBp
ZiAobnJfcGFnZXMgJmd0Oz0gTlJfTUFYX0JBVENIRURfTUlHUkFUSU9OKTxi
cj4mZ3Q7IC0gbGlzdF9jdXRfYmVmb3JlKCZhbXA7Zm9saW9zLCBmcm9tLCAm
YW1wO2ZvbGlvMi0mZ3Q7bHJ1KTs8YnI+Jmd0OyArIGxpc3RfY3V0X2JlZm9y
ZSgmYW1wO2ZvbGlvcywgZnJvbSwgJmFtcDtmb2xpby0mZ3Q7bHJ1KTs8YnI+
PGJyPklmIHRoZSBmaXJzdCBlbnRyeSBvZiB0aGUgbGlzdCAiZnJvbSIgaXMg
YSBUSFAgd2l0aCBzaXplIEhQQUdFX1BNRF9OUiw8YnI+ImZvbGlvIiB3aWxs
IGJlIHRoZSBmaXJzdCBlbnRyeSBvZiBmcm9tLCBzbyB0aGF0ICJmb2xpb3Mi
IHdpbGwgYmUgZW1wdHkuPGJyPlJpZ2h0PzwvZGl2Pgo8L2Rpdj4KPC9kaXY+
CjwvZGl2Pgo8ZGl2PiZuYnNwOzwvZGl2Pgo8ZGl2PlllcywgSXQncyByaWdo
dCwgc28gd2UgY2FuIGNoZWNrIHdoZXRoZXIgaXQgaXMgdGhlIGZpcnN0IGVu
dHJ5IG9mIHRoZSBsaXN0ICJmcm9tIiwgbmV3IHBhdGNoIGFyZSBhcyBmb2xs
b3dzKGF0dGFjaG1lbnQgaXMgcGF0Y2ggZmlsZSk6PC9kaXY+CjxkaXY+ZGlm
ZiAtLWdpdCBhL21tL21pZ3JhdGUuYyBiL21tL21pZ3JhdGUuYzxicj5pbmRl
eCA3ODE5Nzk1NjdmNjQuLmNjZThlMmI4NWU4OSAxMDA2NDQ8YnI+LS0tIGEv
bW0vbWlncmF0ZS5jPGJyPisrKyBiL21tL21pZ3JhdGUuYzxicj5AQCAtMTk1
NywxMSArMTk1NywxMiBAQCBpbnQgbWlncmF0ZV9wYWdlcyhzdHJ1Y3QgbGlz
dF9oZWFkICpmcm9tLCBuZXdfZm9saW9fdCBnZXRfbmV3X2ZvbGlvLDxicj59
PGJyPjxicj5ucl9wYWdlcyArPSBmb2xpb19ucl9wYWdlcyhmb2xpbyk7PGJy
Pi0gaWYgKG5yX3BhZ2VzICZndDs9IE5SX01BWF9CQVRDSEVEX01JR1JBVElP
Tik8YnI+KyBpZiAoKG5yX3BhZ2VzICZndDs9IE5SX01BWF9CQVRDSEVEX01J
R1JBVElPTikgJmFtcDsmYW1wOzxicj4rICghbGlzdF9maXJzdF9lbnRyeShm
cm9tLCBzdHJ1Y3QgZm9saW8sIGxydSkpKTxicj5icmVhazs8YnI+fTxicj5p
ZiAobnJfcGFnZXMgJmd0Oz0gTlJfTUFYX0JBVENIRURfTUlHUkFUSU9OKTxi
cj4tIGxpc3RfY3V0X2JlZm9yZSgmYW1wO2ZvbGlvcywgZnJvbSwgJmFtcDtm
b2xpbzItJmd0O2xydSk7PGJyPisgbGlzdF9jdXRfYmVmb3JlKCZhbXA7Zm9s
aW9zLCBmcm9tLCAmYW1wO2ZvbGlvLSZndDtscnUpOzxicj5lbHNlPGJyPmxp
c3Rfc3BsaWNlX2luaXQoZnJvbSwgJmFtcDtmb2xpb3MpOzxicj5pZiAobW9k
ZSA9PSBNSUdSQVRFX0FTWU5DKTwvZGl2Pgo8ZGl2PiZuYnNwOzwvZGl2Pgo8
ZGl2IGlkPSJyZSIgc3R5bGU9Im1hcmdpbi1sZWZ0OiAwLjVlbTsgcGFkZGlu
Zy1sZWZ0OiAwLjVlbTsgYm9yZGVyLWxlZnQ6IDFweCBzb2xpZCBncmVlbjsi
Pgo8ZGl2IGlkPSJjb250ZW50Ij4KPGRpdiBjbGFzcz0idmlld2VyX3BhcnQi
IHN0eWxlPSJwb3NpdGlvbjogcmVsYXRpdmU7Ij4KPGRpdj48YnI+Jmd0OyBl
bHNlPGJyPiZndDsgbGlzdF9zcGxpY2VfaW5pdChmcm9tLCAmYW1wO2ZvbGlv
cyk7PGJyPiZndDsgaWYgKG1vZGUgPT0gTUlHUkFURV9BU1lOQyk8YnI+PGJy
Pi0tPGJyPkJlc3QgUmVnYXJkcyw8YnI+SHVhbmcsIFlpbmc8L2Rpdj4KPC9k
aXY+CjwvZGl2Pgo8L2Rpdj4=

--nsmail-ai4b42t5cy-ai5l1w876r
Content-Type: application/octet-stream; name="=?UTF-8?B?bWlncmF0ZV9wYWdlcy1tb2RpZnktbWF4LW51bWJlci1vZi1wYWdlcy10by1taWdyYXRlLWluLWJhdGNoLnBhdGNo?="
Content-Transfer-Encoding: base64
Content-Disposition: attachment; size=1364; seclevel=0; filename="=?UTF-8?B?bWlncmF0ZV9wYWdlcy1tb2RpZnktbWF4LW51bWJlci1vZi1wYWdlcy10by1taWdyYXRlLWluLWJhdGNoLnBhdGNo?="
X-Seclevel-1: 0
X-Seclevel: 0

RnJvbSAyNWMzZDJkZjFkMzhiNDlmMzg5MjM0ZTA3NDk3OGQwNTk0NmEwYTYz
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBaaGVubmVuZyBMaSA8
bGl6aGVubmVuZ0BreWxpbm9zLmNuPgpEYXRlOiBNb24sIDI0IEp1biAyMDI0
IDEyOjE5OjA4ICswODAwClN1YmplY3Q6IFtQQVRDSF0gbWlncmF0ZV9wYWdl
czogbW9kaWZ5IG1heCBudW1iZXIgb2YgcGFnZXMgdG8gbWlncmF0ZSBpbiBi
YXRjaAoKV2UgcmVzdHJpY3QgdGhlIG51bWJlciBvZiBwYWdlcyB0byBiZSBt
aWdyYXRlZCB0byBubyBtb3JlIHRoYW4KSFBBR0VfUE1EX05SIG9yIE5SX01B
WF9CQVRDSEVEX01JR1JBVElPTiwgYnV0IGluIGZhY3QsIHRoZQpudW1iZXIg
b2YgcGFnZXMgdG8gYmUgbWlncmF0ZWQgbWF5IHJlYWNoIDIqSFBBR0VfUE1E
X05SLTEgb3IgMgoqTlJfTUFYX0JBVENIRURfTUlHUkFUSU9OLTEsIGl0J3Mg
bm90IGluIGluY29uc2lzdGVudCB3aXRoIHRoZSBjb250ZXh0LgoKUGxlYXNl
IHJlZmVyIHRvIHRoZSBwYXRjaDogNDIwMTJlMDQzNmQ0KG1pZ3JhdGVfcGFn
ZXM6IHJlc3RyaWN0IG51bWJlcgpvZiBwYWdlcyB0byBtaWdyYXRlIGluIGJh
dGNoKQoKU2lnbmVkLW9mZi1ieTogWmhlbm5lbmcgTGkgPGxpemhlbm5lbmdA
a3lsaW5vcy5jbj4KLS0tCiBtbS9taWdyYXRlLmMgfCA1ICsrKy0tCiAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL21tL21pZ3JhdGUuYyBiL21tL21pZ3JhdGUuYwppbmRl
eCA3ODE5Nzk1NjdmNjQuLmNjZThlMmI4NWU4OSAxMDA2NDQKLS0tIGEvbW0v
bWlncmF0ZS5jCisrKyBiL21tL21pZ3JhdGUuYwpAQCAtMTk1NywxMSArMTk1
NywxMiBAQCBpbnQgbWlncmF0ZV9wYWdlcyhzdHJ1Y3QgbGlzdF9oZWFkICpm
cm9tLCBuZXdfZm9saW9fdCBnZXRfbmV3X2ZvbGlvLAogCQl9CiAKIAkJbnJf
cGFnZXMgKz0gZm9saW9fbnJfcGFnZXMoZm9saW8pOwotCQlpZiAobnJfcGFn
ZXMgPj0gTlJfTUFYX0JBVENIRURfTUlHUkFUSU9OKQorCQlpZiAoKG5yX3Bh
Z2VzID49IE5SX01BWF9CQVRDSEVEX01JR1JBVElPTikgJiYKKwkJICAgICgh
bGlzdF9maXJzdF9lbnRyeShmcm9tLCBzdHJ1Y3QgZm9saW8sIGxydSkpKQog
CQkJYnJlYWs7CiAJfQogCWlmIChucl9wYWdlcyA+PSBOUl9NQVhfQkFUQ0hF
RF9NSUdSQVRJT04pCi0JCWxpc3RfY3V0X2JlZm9yZSgmZm9saW9zLCBmcm9t
LCAmZm9saW8yLT5scnUpOworCQlsaXN0X2N1dF9iZWZvcmUoJmZvbGlvcywg
ZnJvbSwgJmZvbGlvLT5scnUpOwogCWVsc2UKIAkJbGlzdF9zcGxpY2VfaW5p
dChmcm9tLCAmZm9saW9zKTsKIAlpZiAobW9kZSA9PSBNSUdSQVRFX0FTWU5D
KQotLSAKMi4yNS4xCgo=

--nsmail-ai4b42t5cy-ai5l1w876r--

