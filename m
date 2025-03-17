Return-Path: <linux-kernel+bounces-563689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C47A646B5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B7AE189535A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FE2222594;
	Mon, 17 Mar 2025 09:09:55 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811E3221D99
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742202595; cv=none; b=ieW2wRkRAxYIT6azrcwQKQfCK+jiUVpZiJBMatgdigbgDWajiYxANFqCD2hOtYoQagiboy5iZ8nZBAg6YCpn3B2SCvxqd1JDPDkHtVbwDq+1sMBkreQajZoXABmUFyoZrizOSGsjQYqIvq+dgCzbGBDNzaPxaO5vtT5DrmZd/1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742202595; c=relaxed/simple;
	bh=V4OMMsHgd2ncmt7Zm7PAVTMy8DzAzTHzdg94rKFjnYk=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=JR3OXhvIMGSCzfb4/py8TARcCK7tG7AH25tw9ho+ZrDoZDfGxLIieiehk6i9KaBJHtAYXQRBt0/qnoaNcaErVjVfP+j0jo9HHvYwsYriIqwb+qPaUsvMdutYyFSAEVfry+sKzAtZ1dwIHRwAcoMUVsy2QiqVtVku7uhGUFK3RNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZGTgt0nG6z8RV7X;
	Mon, 17 Mar 2025 17:09:46 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 52H99Zgd060326;
	Mon, 17 Mar 2025 17:09:35 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 17 Mar 2025 17:09:38 +0800 (CST)
Date: Mon, 17 Mar 2025 17:09:38 +0800 (CST)
X-Zmail-TransId: 2afc67d7e6d2ffffffffab0-b2e63
X-Mailer: Zmail v1.0
Message-ID: <20250317170938569jgM2gAWy39rgQQbnOh0Vu@zte.com.cn>
In-Reply-To: <20250317153909901uOL4saBkASEN9kOmQXDoP@zte.com.cn>
References: 20250317153909901uOL4saBkASEN9kOmQXDoP@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <hch@lst.de>
Cc: <sagi@grimberg.me>, <kch@nvidia.com>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yang.tao172@zte.com.cn>,
        <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gbnZtZTogcmVwbGFjZSBtYXgoYSwgbWluKGIsIGMpKSBieSBjbGFtcChiLCBhLCBjKQ==?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl1.zte.com.cn 52H99Zgd060326
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D7E6DA.000/4ZGTgt0nG6z8RV7X



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

RGVhciBiZXN0LA0KUGxlYXNlIGlnbm9yZSB0aGlzIHBhdGNoLiBXZSB3aWxsIHN1Ym1pdCBhIHYy
IHBhdGNoIGluc3RlYWQuDQo+RnJvbTogTGlIYW9yYW4gPGxpLmhhb3JhbjdAenRlLmNvbS5jbj4N
Cj4NCj5UaGlzIHBhdGNoIHJlcGxhY2VzIG1heChhLCBtaW4oYiwgYykpIGJ5IGNsYW1wKGIsIGEs
IGMpIGluIHRoZSBudm1lDQo+ZHJpdmVyLiBUaGlzIGltcHJvdmVzIHRoZSByZWFkYWJpbGl0eS4N
Cj4NCj5TaWduZWQtb2ZmLWJ5OiBMaUhhb3JhbiA8bGkuaGFvcmFuN0B6dGUuY29tLmNuPg0KPkNj
OiBTaGFvTWluZ3lpbiA8c2hhby5taW5neWluQHp0ZS5jb20uY24+DQo+LS0tDQo+IGRyaXZlcnMv
bnZtZS90YXJnZXQvbnZtZXQuaCB8IDIgKy0NCj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQv
bnZtZXQuaCBiL2RyaXZlcnMvbnZtZS90YXJnZXQvbnZtZXQuaA0KPmluZGV4IGZjZjRmNDYwZGM5
YS4uMzA4MDRiMGNhNjZlIDEwMDY0NA0KPi0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvbnZtZXQu
aA0KPisrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvbnZtZXQuaA0KPkBAIC04MTksNyArODE5LDcg
QEAgc3RhdGljIGlubGluZSB1OCBudm1ldF9jY19pb2NxZXModTMyIGNjKQ0KPiAvKiBDb252ZXJ0
IGEgMzItYml0IG51bWJlciB0byBhIDE2LWJpdCAwJ3MgYmFzZWQgbnVtYmVyICovDQo+IHN0YXRp
YyBpbmxpbmUgX19sZTE2IHRvMGJhc2VkKHUzMiBhKQ0KPiB7DQo+LSByZXR1cm4gY3B1X3RvX2xl
MTYobWF4KDFVLCBtaW4oMVUgPDwgMTYsIGEpKSAtIDEpOw0KPisgcmV0dXJuIGNwdV90b19sZTE2
KGNsYW1wKDFVIDw8IDE2LCAxVSwgYSkgLSAxKTsNCj4gfQ0KPg0KPiBzdGF0aWMgaW5saW5lIGJv
b2wgbnZtZXRfbnNfaGFzX3BpKHN0cnVjdCBudm1ldF9ucyAqbnMpDQo+LS0NCj4yLjI1LjE=


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iemNvbnRlbnRSb3ciPjxwPkRlYXIgYmVzdCw8L3A+PHA+UGxlYXNlIGlnbm9y
ZSB0aGlzIHBhdGNoLiBXZSB3aWxsIHN1Ym1pdCBhIHYyIHBhdGNoIGluc3RlYWQuPC9wPjxwPiZn
dDtGcm9tOiBMaUhhb3JhbiAmbHQ7bGkuaGFvcmFuN0B6dGUuY29tLmNuJmd0OzwvcD48cD4mZ3Q7
PC9wPjxwPiZndDtUaGlzIHBhdGNoIHJlcGxhY2VzIG1heChhLCBtaW4oYiwgYykpIGJ5IGNsYW1w
KGIsIGEsIGMpIGluIHRoZSBudm1lPC9wPjxwPiZndDtkcml2ZXIuIFRoaXMgaW1wcm92ZXMgdGhl
IHJlYWRhYmlsaXR5LjwvcD48cD4mZ3Q7PC9wPjxwPiZndDtTaWduZWQtb2ZmLWJ5OiBMaUhhb3Jh
biAmbHQ7bGkuaGFvcmFuN0B6dGUuY29tLmNuJmd0OzwvcD48cD4mZ3Q7Q2M6IFNoYW9NaW5neWlu
ICZsdDtzaGFvLm1pbmd5aW5AenRlLmNvbS5jbiZndDs8L3A+PHA+Jmd0Oy0tLTwvcD48cD4mZ3Q7
IGRyaXZlcnMvbnZtZS90YXJnZXQvbnZtZXQuaCB8IDIgKy08L3A+PHA+Jmd0OyAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSk8L3A+PHA+Jmd0OzwvcD48cD4mZ3Q7
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQvbnZtZXQuaCBiL2RyaXZlcnMvbnZtZS90
YXJnZXQvbnZtZXQuaDwvcD48cD4mZ3Q7aW5kZXggZmNmNGY0NjBkYzlhLi4zMDgwNGIwY2E2NmUg
MTAwNjQ0PC9wPjxwPiZndDstLS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0L252bWV0Lmg8L3A+PHA+
Jmd0OysrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvbnZtZXQuaDwvcD48cD4mZ3Q7QEAgLTgxOSw3
ICs4MTksNyBAQCBzdGF0aWMgaW5saW5lIHU4IG52bWV0X2NjX2lvY3Flcyh1MzIgY2MpPC9wPjxw
PiZndDsgLyogQ29udmVydCBhIDMyLWJpdCBudW1iZXIgdG8gYSAxNi1iaXQgMCdzIGJhc2VkIG51
bWJlciAqLzwvcD48cD4mZ3Q7IHN0YXRpYyBpbmxpbmUgX19sZTE2IHRvMGJhc2VkKHUzMiBhKTwv
cD48cD4mZ3Q7IHs8L3A+PHA+Jmd0Oy0gcmV0dXJuIGNwdV90b19sZTE2KG1heCgxVSwgbWluKDFV
ICZsdDsmbHQ7IDE2LCBhKSkgLSAxKTs8L3A+PHA+Jmd0OysgcmV0dXJuIGNwdV90b19sZTE2KGNs
YW1wKDFVICZsdDsmbHQ7IDE2LCAxVSwgYSkgLSAxKTs8L3A+PHA+Jmd0OyB9PC9wPjxwPiZndDs8
L3A+PHA+Jmd0OyBzdGF0aWMgaW5saW5lIGJvb2wgbnZtZXRfbnNfaGFzX3BpKHN0cnVjdCBudm1l
dF9ucyAqbnMpPC9wPjxwPiZndDstLTwvcD48cD4mZ3Q7Mi4yNS4xPC9wPjxwIHN0eWxlPSJmb250
LXNpemU6MTRweDtmb250LWZhbWlseTrlvq7ova/pm4Xpu5EsTWljcm9zb2Z0IFlhSGVpOyI+PGJy
PjwvcD48L2Rpdj4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


