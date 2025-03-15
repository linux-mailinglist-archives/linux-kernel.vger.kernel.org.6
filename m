Return-Path: <linux-kernel+bounces-562392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03939A62535
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 04:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F3119C560B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6FE1898E9;
	Sat, 15 Mar 2025 03:12:08 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D5B178CF8
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 03:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742008328; cv=none; b=oDY2hhs4qBD/XJbkUZn0VK4yjwuWhGx9TnrqWF1Roaui5t2RoOJ05Fw01EeiRtZCx/N6qjix7S1fyEnwU33wmDh94J3l1aKO+lNEglVhLLPpGxk3/9FPDtLLKRbmmIkjObkyEWKQwY5SqI9PbI9xlri99B+xZhws4OmkzUprf0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742008328; c=relaxed/simple;
	bh=Bc0/NYe34crgTMtDQs2p8Qnh6lkzTZtRuifwdVXzd98=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=Pdj/ApYmYT0BifxBMxcBsFURtohG89RTGyyDUoy6CpCu66fVUvQXmc3lSUIKNBfFZdyUef8JV0jDf9hWA0/tMKMbHkjAWxAW25f9TQS8mvsKMkfudwFPsQSvxIEF9jOd0SfAPHgtVBTj2EMwgPqRVwGUy6sKQXJkilrqnCDL0k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZF5qv6lNyz8QrkZ;
	Sat, 15 Mar 2025 11:11:55 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 52F3Bi9W043131;
	Sat, 15 Mar 2025 11:11:44 +0800 (+08)
	(envelope-from feng.wei8@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 15 Mar 2025 11:11:45 +0800 (CST)
Date: Sat, 15 Mar 2025 11:11:45 +0800 (CST)
X-Zmail-TransId: 2afa67d4eff1359-b71fd
X-Mailer: Zmail v1.0
Message-ID: <20250315111145865z64IAaowsh-ET7-jNitd9@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <feng.wei8@zte.com.cn>
To: <kbusch@kernel.org>
Cc: <james.smart@broadcom.com>, <axboe@kernel.dk>, <hch@lst.de>,
        <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBudm1lLWZjOiBSZXBsYWNlIG5lc3RlZCBtaW4oKSB3aXRoIHNpbmdsZSBtaW4zKCk=?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl1.zte.com.cn 52F3Bi9W043131
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D4EFFB.003/4ZF5qv6lNyz8QrkZ



--=====_001_next=====
Content-Type: multipart/related;
	boundary="=====_002_next====="


--=====_002_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbTogRmVuZ1dlaSA8ZmVuZy53ZWk4QHp0ZS5jb20uY24+DQoNClVzZSBtaW4zKCkgbWFjcm8g
aW5zdGVhZCBvZiBuZXN0aW5nIG1pbigpDQoNClNpZ25lZC1vZmYtYnk6IEZlbmdXZWkgPGZlbmcu
d2VpOEB6dGUuY29tLmNuPg0KLS0tDQogZHJpdmVycy9udm1lL2hvc3QvZmMuYyB8IDIgKy0NCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbnZtZS9ob3N0L2ZjLmMgYi9kcml2ZXJzL252bWUvaG9zdC9mYy5jDQppbmRl
eCBiOTkyOWE1YTdmNGUuLmI1YmQ1ODYzOTE1NCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbnZtZS9o
b3N0L2ZjLmMNCisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2ZjLmMNCkBAIC0yOTEyLDcgKzI5MTIs
NyBAQCBudm1lX2ZjX3JlY3JlYXRlX2lvX3F1ZXVlcyhzdHJ1Y3QgbnZtZV9mY19jdHJsICpjdHJs
KQ0KIAl1bnNpZ25lZCBpbnQgbnJfaW9fcXVldWVzOw0KIAlpbnQgcmV0Ow0KIA0KLQlucl9pb19x
dWV1ZXMgPSBtaW4obWluKG9wdHMtPm5yX2lvX3F1ZXVlcywgbnVtX29ubGluZV9jcHVzKCkpLA0K
Kwlucl9pb19xdWV1ZXMgPSBtaW4zKG9wdHMtPm5yX2lvX3F1ZXVlcywgbnVtX29ubGluZV9jcHVz
KCksDQogCQkJCWN0cmwtPmxwb3J0LT5vcHMtPm1heF9od19xdWV1ZXMpOw0KIAlyZXQgPSBudm1l
X3NldF9xdWV1ZV9jb3VudCgmY3RybC0+Y3RybCwgJm5yX2lvX3F1ZXVlcyk7DQogCWlmIChyZXQp
IHsNCi0tIA0KMi4yNS4x


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iemNvbnRlbnRSb3ciPjxwPkZyb206IEZlbmdXZWkgJmx0O2Zlbmcud2VpOEB6
dGUuY29tLmNuJmd0Ozxicj48L3A+PHA+PGJyPjwvcD48cD5Vc2UgbWluMygpIG1hY3JvIGluc3Rl
YWQgb2YgbmVzdGluZyBtaW4oKTwvcD48cD48YnI+PC9wPjxwPlNpZ25lZC1vZmYtYnk6IEZlbmdX
ZWkgJmx0O2Zlbmcud2VpOEB6dGUuY29tLmNuJmd0OzwvcD48cD4tLS08L3A+PHA+Jm5ic3A7ZHJp
dmVycy9udm1lL2hvc3QvZmMuYyB8IDIgKy08L3A+PHA+Jm5ic3A7MSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pPC9wPjxwPjxicj48L3A+PHA+ZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbnZtZS9ob3N0L2ZjLmMgYi9kcml2ZXJzL252bWUvaG9zdC9mYy5jPC9wPjxwPmlu
ZGV4IGI5OTI5YTVhN2Y0ZS4uYjViZDU4NjM5MTU0IDEwMDY0NDwvcD48cD4tLS0gYS9kcml2ZXJz
L252bWUvaG9zdC9mYy5jPC9wPjxwPisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2ZjLmM8L3A+PHA+
QEAgLTI5MTIsNyArMjkxMiw3IEBAIG52bWVfZmNfcmVjcmVhdGVfaW9fcXVldWVzKHN0cnVjdCBu
dm1lX2ZjX2N0cmwgKmN0cmwpPC9wPjxwPiZuYnNwOzxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+dW5zaWduZWQgaW50IG5yX2lvX3F1ZXVlczs8L3A+PHA+Jm5ic3A7PHNwYW4g
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pbnQgcmV0OzwvcD48cD4mbmJzcDs8L3A+
PHA+LTxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+bnJfaW9fcXVldWVzID0g
bWluKG1pbihvcHRzLSZndDtucl9pb19xdWV1ZXMsIG51bV9vbmxpbmVfY3B1cygpKSw8L3A+PHA+
KzxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+bnJfaW9fcXVldWVzID0gbWlu
MyhvcHRzLSZndDtucl9pb19xdWV1ZXMsIG51bV9vbmxpbmVfY3B1cygpLDwvcD48cD4mbmJzcDs8
c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JCQkJPC9zcGFuPmN0cmwtJmd0O2xwb3J0LSZn
dDtvcHMtJmd0O21heF9od19xdWV1ZXMpOzwvcD48cD4mbmJzcDs8c3BhbiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPnJldCA9IG52bWVfc2V0X3F1ZXVlX2NvdW50KCZhbXA7Y3RybC0m
Z3Q7Y3RybCwgJmFtcDtucl9pb19xdWV1ZXMpOzwvcD48cD4mbmJzcDs8c3BhbiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlmIChyZXQpIHs8L3A+PHA+LS0mbmJzcDs8L3A+PHA+Mi4y
NS4xPC9wPjxwIHN0eWxlPSJmb250LXNpemU6MTRweDtmb250LWZhbWlseTrlvq7ova/pm4Xpu5Es
TWljcm9zb2Z0IFlhSGVpOyI+PGJyPjwvcD48cCBzdHlsZT0iZm9udC1zaXplOjE0cHg7Zm9udC1m
YW1pbHk65b6u6L2v6ZuF6buRLE1pY3Jvc29mdCBZYUhlaTsiPjxicj48L3A+PHAgc3R5bGU9ImZv
bnQtc2l6ZToxNHB4O2ZvbnQtZmFtaWx5OuW+rui9r+mbhem7kSxNaWNyb3NvZnQgWWFIZWk7Ij48
YnI+PC9wPjxwIHN0eWxlPSJmb250LXNpemU6MTRweDtmb250LWZhbWlseTrlvq7ova/pm4Xpu5Es
TWljcm9zb2Z0IFlhSGVpOyI+PGJyPjwvcD48L2Rpdj4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


