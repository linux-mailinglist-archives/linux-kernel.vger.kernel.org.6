Return-Path: <linux-kernel+bounces-563705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAEFA646E6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29DCC16AD04
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5A82206AF;
	Mon, 17 Mar 2025 09:19:30 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCBB1758B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203170; cv=none; b=vFkqX8gphv6U3Wmo3ZT8Xs2AJLQU1h291b4xjMQ7eDQSQj1qlYVB+INmz3q7q0RoZEx3PogmbOP35FxdcbtLUMsNb/eKad4A/XUqvg0pQXKSjiAeGZVK4h5GoshN1lJqFwheV5mQfGSCFY9ZZZ0qjSfirTqS4uJFY2a4N2/aGK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203170; c=relaxed/simple;
	bh=+aWxAnErVi5GE7txTnBs2jmd8zjo2Uzbs2Ddd0ekzUg=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=t6UvtT33KmUtkWi3O3BAftUGL+3GGFCWOJOgr+UD91mWWLw3OHSkojmhijj34ZZBsUYXK4W3knxeAfvAHIKo7+tcyAmssf3rXzoTWpPWxEkFJNmUQlUUbhO9rWwc2rW5439TZ7c43zPB0Dh5621wGqoAGc10kBlAJcxh3Yeuq/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZGTty1W5Cz50FXM;
	Mon, 17 Mar 2025 17:19:22 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 52H9IkvC075214;
	Mon, 17 Mar 2025 17:18:46 +0800 (+08)
	(envelope-from tang.dongxing@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 17 Mar 2025 17:18:49 +0800 (CST)
Date: Mon, 17 Mar 2025 17:18:49 +0800 (CST)
X-Zmail-TransId: 2afa67d7e8f9ffffffff8c9-d0c5e
X-Mailer: Zmail v1.0
Message-ID: <20250317171849700zhgNc5lZvWvM3EepJpYWE@zte.com.cn>
In-Reply-To: <23781043-901b-422c-8199-10aa4a31459e@kernel.org>
References: 20250317151648132Sj7qhbVfKcPYvqCievFUf@zte.com.cn,23781043-901b-422c-8199-10aa4a31459e@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <tang.dongxing@zte.com.cn>
To: <jirislaby@kernel.org>
Cc: <jgross@suse.com>, <sstabellini@kernel.org>,
        <oleksandr_tyshchenko@epam.com>, <jiqian.chen@amd.com>,
        <ray.huang@amd.com>, <jeff.johnson@oss.qualcomm.com>,
        <minhuadotchen@gmail.com>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>, <ye.xingchen@zte.com.cn>,
        <yang.guang5@zte.com.cn>, <yang.yang29@zte.com.cn>,
        <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0geGVuL3BjaWJhY2s6IHVzZSBzeXNmc19lbWl0X2F0KCkgaW5zdGVhZCBvZiBzY25wcmludGYoKQ==?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl1.zte.com.cn 52H9IkvC075214
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D7E91A.000/4ZGTty1W5Cz50FXM



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

Pj4gRnJvbTogVGFuZ0Rvbmd4aW5nIDx0YW5nLmRvbmd4aW5nQHp0ZS5jb20uY24+DQo+PiANCj4+
IEZvbGxvdyB0aGUgYWR2aWNlIGluIERvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvc3lzZnMucnN0
Og0KPj4gc2hvdygpIHNob3VsZCBvbmx5IHVzZSBzeXNmc19lbWl0KCkgb3Igc3lzZnNfZW1pdF9h
dCgpIHdoZW4gZm9ybWF0dGluZw0KPj4gdGhlIHZhbHVlIHRvIGJlIHJldHVybmVkIHRvIHVzZXIg
c3BhY2UuDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IFRhbmdEb25neGluZyA8dGFuZy5kb25neGlu
Z0B6dGUuY29tLmNuPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMveGVuL3hlbi1wY2liYWNrL3BjaV9z
dHViLmMgfCAyICstDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy94ZW4veGVuLXBjaWJhY2svcGNp
X3N0dWIuYyBiL2RyaXZlcnMveGVuL3hlbi1wY2liYWNrL3BjaV9zdHViLmMNCj4+IGluZGV4IGI2
MTZiNzc2OGMzYi4uYTA3ODJhNzRlZDM0IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy94ZW4veGVu
LXBjaWJhY2svcGNpX3N0dWIuYw0KPj4gKysrIGIvZHJpdmVycy94ZW4veGVuLXBjaWJhY2svcGNp
X3N0dWIuYw0KPj4gQEAgLTEyODEsNyArMTI4MSw3IEBAIHN0YXRpYyBzc2l6ZV90IHNsb3RzX3No
b3coc3RydWN0IGRldmljZV9kcml2ZXIgKmRydiwgY2hhciAqYnVmKQ0KPj4gICAgICAgICAgIGlm
IChjb3VudCA+PSBQQUdFX1NJWkUpDQo+PiAgICAgICAgICAgICAgIGJyZWFrOw0KPj4gDQo+PiAt
ICAgICAgICBjb3VudCArPSBzY25wcmludGYoYnVmICsgY291bnQsIFBBR0VfU0laRSAtIGNvdW50
LA0KPj4gKyAgICAgICAgY291bnQgKz0gc3lzZnNfZW1pdF9hdChidWYsIGNvdW50LA0KPg0KPlRo
aXMgaXMgd3JvbmcgdG9vIFsxXS4NCj4NCj5bMV0gDQo+aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsLzljNTUyZDlhLTJkNDYtNDA2OS1hOWM0LTM1ZmFiODU3YmZjM0BrZXJuZWwub3JnLw0KPg0K
PnJlZ2FyZHMsDQo+LS0gDQo+anMNCj5zdXNlIGxhYnMNCg0KRGVhciBKaXJpU2xhYnksDQoNClRo
YW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjayxJIGFtIHNvcnJ5IGZvciBteSBwcmV2aW91cyBzdWJt
aXNzaW9ucy4NCkkgd2lsbCBjaGVjayBteSB3b3JrIGJlZm9yZSBzZW5kaW5nIGFueSBmdXJ0aGVy
IHVwZGF0ZXMuDQoNClRoYW5rIHlvdSBmb3IgeW91ciBndWlkYW5jZS4NCg0KQmVzdCByZWdhcmRz
LA0KVGFuZyBEb25neGluZw==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iemNvbnRlbnRSb3ciPjxwPiZndDsmZ3Q7IEZyb206IFRhbmdEb25neGluZyAm
bHQ7dGFuZy5kb25neGluZ0B6dGUuY29tLmNuJmd0OzwvcD48cD4mZ3Q7Jmd0OyZuYnNwOzwvcD48
cD4mZ3Q7Jmd0OyBGb2xsb3cgdGhlIGFkdmljZSBpbiBEb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1z
L3N5c2ZzLnJzdDo8L3A+PHA+Jmd0OyZndDsgc2hvdygpIHNob3VsZCBvbmx5IHVzZSBzeXNmc19l
bWl0KCkgb3Igc3lzZnNfZW1pdF9hdCgpIHdoZW4gZm9ybWF0dGluZzwvcD48cD4mZ3Q7Jmd0OyB0
aGUgdmFsdWUgdG8gYmUgcmV0dXJuZWQgdG8gdXNlciBzcGFjZS48L3A+PHA+Jmd0OyZndDsmbmJz
cDs8L3A+PHA+Jmd0OyZndDsgU2lnbmVkLW9mZi1ieTogVGFuZ0Rvbmd4aW5nICZsdDt0YW5nLmRv
bmd4aW5nQHp0ZS5jb20uY24mZ3Q7PC9wPjxwPiZndDsmZ3Q7IC0tLTwvcD48cD4mZ3Q7Jmd0OyZu
YnNwOyAmbmJzcDtkcml2ZXJzL3hlbi94ZW4tcGNpYmFjay9wY2lfc3R1Yi5jIHwgMiArLTwvcD48
cD4mZ3Q7Jmd0OyZuYnNwOyAmbmJzcDsxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSk8L3A+PHA+Jmd0OyZndDsmbmJzcDs8L3A+PHA+Jmd0OyZndDsgZGlmZiAtLWdp
dCBhL2RyaXZlcnMveGVuL3hlbi1wY2liYWNrL3BjaV9zdHViLmMgYi9kcml2ZXJzL3hlbi94ZW4t
cGNpYmFjay9wY2lfc3R1Yi5jPC9wPjxwPiZndDsmZ3Q7IGluZGV4IGI2MTZiNzc2OGMzYi4uYTA3
ODJhNzRlZDM0IDEwMDY0NDwvcD48cD4mZ3Q7Jmd0OyAtLS0gYS9kcml2ZXJzL3hlbi94ZW4tcGNp
YmFjay9wY2lfc3R1Yi5jPC9wPjxwPiZndDsmZ3Q7ICsrKyBiL2RyaXZlcnMveGVuL3hlbi1wY2li
YWNrL3BjaV9zdHViLmM8L3A+PHA+Jmd0OyZndDsgQEAgLTEyODEsNyArMTI4MSw3IEBAIHN0YXRp
YyBzc2l6ZV90IHNsb3RzX3Nob3coc3RydWN0IGRldmljZV9kcml2ZXIgKmRydiwgY2hhciAqYnVm
KTwvcD48cD4mZ3Q7Jmd0OyZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
aWYgKGNvdW50ICZndDs9IFBBR0VfU0laRSk8L3A+PHA+Jmd0OyZndDsmbmJzcDsgJm5ic3A7ICZu
YnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7YnJlYWs7PC9wPjxwPiZndDsm
Z3Q7Jm5ic3A7PC9wPjxwPiZndDsmZ3Q7IC0mbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgY291
bnQgKz0gc2NucHJpbnRmKGJ1ZiArIGNvdW50LCBQQUdFX1NJWkUgLSBjb3VudCw8L3A+PHA+Jmd0
OyZndDsgKyZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyBjb3VudCArPSBzeXNmc19lbWl0X2F0
KGJ1ZiwgY291bnQsPC9wPjxwPiZndDs8L3A+PHA+Jmd0O1RoaXMgaXMgd3JvbmcgdG9vIFsxXS48
L3A+PHA+Jmd0OzwvcD48cD4mZ3Q7WzFdJm5ic3A7PC9wPjxwPiZndDtodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9hbGwvOWM1NTJkOWEtMmQ0Ni00MDY5LWE5YzQtMzVmYWI4NTdiZmMzQGtlcm5lbC5v
cmcvPC9wPjxwPiZndDs8L3A+PHA+Jmd0O3JlZ2FyZHMsPC9wPjxwPiZndDstLSZuYnNwOzwvcD48
cD4mZ3Q7anM8L3A+PHA+Jmd0O3N1c2UgbGFiczwvcD48cD48YnI+PC9wPjxwPkRlYXIgSmlyaVNs
YWJ5LDwvcD48cD48YnI+PC9wPjxwPlRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjayxJIGFtIHNv
cnJ5IGZvciBteSBwcmV2aW91cyBzdWJtaXNzaW9ucy48L3A+PHA+SSB3aWxsIGNoZWNrIG15IHdv
cmsgYmVmb3JlIHNlbmRpbmcgYW55IGZ1cnRoZXIgdXBkYXRlcy48L3A+PHA+PGJyPjwvcD48cD5U
aGFuayB5b3UgZm9yIHlvdXIgZ3VpZGFuY2UuPC9wPjxwPjxicj48L3A+PHA+QmVzdCByZWdhcmRz
LDwvcD48cD5UYW5nIERvbmd4aW5nPC9wPjxwPjxicj48L3A+PC9kaXY+


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


