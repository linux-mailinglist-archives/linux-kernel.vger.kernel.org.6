Return-Path: <linux-kernel+bounces-562425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C620BA62712
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 07:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08EEC4204BF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 06:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443311946B1;
	Sat, 15 Mar 2025 06:16:50 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4051F5FD
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 06:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742019409; cv=none; b=kCRDqHZ2qsgWTBhIF+7iCZSe6WRnL77KFQxXh5tf0Q0lkLAC86kcBM6RWh4Sz1JEuuJ3Ht7shmVcjPwH0eouRM0erELVIUXnsavlUC2EMJlr0lIi0kKLHUjywHZSJ9/EfAqUp0aAp9Qhmx9OnIc/XSlG7T9ABbdpENMhWXK4hAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742019409; c=relaxed/simple;
	bh=583kABhI8raiQnwGKga+jZCC+lHUu/5HvgiUa9urVzA=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=MuoU6ikhXPxbFS2X10xPp5neGqSQxwVkVmyVGuPfubpOFQe5whLepj/6b6ZZcQrjezncTPv1M3wrJXDetZuVyH5fg/wCJxjEne/4rcT5SDCL3JoE+KKB8KOqsFvpXPOXLM2cP52qSMlPXOcqmldRGXtvsoDGtFfW7qUNPfiBW1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZF9xB6sDXz5B1J4;
	Sat, 15 Mar 2025 14:16:46 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 52F6Gdbn011369;
	Sat, 15 Mar 2025 14:16:39 +0800 (+08)
	(envelope-from xie.ludan@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 15 Mar 2025 14:16:40 +0800 (CST)
Date: Sat, 15 Mar 2025 14:16:40 +0800 (CST)
X-Zmail-TransId: 2afb67d51b4834b-61146
X-Mailer: Zmail v1.0
Message-ID: <20250315141640564lv7R0CwIRPsmittXXjLbB@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xie.ludan@zte.com.cn>
To: <mark@fasheh.com>
Cc: <jlbec@evilplan.org>, <joseph.qi@linux.alibaba.com>,
        <akpm@linux-foundation.org>, <viro@zeniv.linux.org.uk>,
        <brauner@kernel.org>, <danielyangkang@gmail.com>,
        <dmantipov@yandex.ru>, <ocfs2-devel@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIG9jZnMyOiB1c2Ugc3lzZnNfZW1pdCgpIGluc3RlYWQgb2Ygc2NucHJpbnRmKCku?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl1.zte.com.cn 52F6Gdbn011369
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D51B4E.002/4ZF9xB6sDXz5B1J4



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

RnJvbTogWGllTHVkYW4gPHhpZS5sdWRhbkB6dGUuY29tLmNuPg0KDQpGb2xsb3cgdGhlIGFkdmlj
ZSBpbiBEb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL3N5c2ZzLnJzdDoNCnNob3coKSBzaG91bGQg
b25seSB1c2Ugc3lzZnNfZW1pdCgpIG9yIHN5c2ZzX2VtaXRfYXQoKSB3aGVuIGZvcm1hdHRpbmcN
CnRoZSB2YWx1ZSB0byBiZSByZXR1cm5lZCB0byB1c2VyIHNwYWNlLg0KDQpTaWduZWQtb2ZmLWJ5
OiBYaWVMdWRhbiA8eGllLmx1ZGFuQHp0ZS5jb20uY24+DQotLS0NCiBmcy9vY2ZzMi9jbHVzdGVy
L2hlYXJ0YmVhdC5jIHwgMTAgKysrKystLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKyksIDUgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9mcy9vY2ZzMi9jbHVzdGVyL2hl
YXJ0YmVhdC5jIGIvZnMvb2NmczIvY2x1c3Rlci9oZWFydGJlYXQuYw0KaW5kZXggNzI0MzUwOTI1
YWZmLi44MjgyZmMxOTM5MDYgMTAwNjQ0DQotLS0gYS9mcy9vY2ZzMi9jbHVzdGVyL2hlYXJ0YmVh
dC5jDQorKysgYi9mcy9vY2ZzMi9jbHVzdGVyL2hlYXJ0YmVhdC5jDQpAQCAtMTMwOCw3ICsxMzA4
LDcgQEAgc3RhdGljIGludCBvMmhiX2RlYnVnX29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3Ry
dWN0IGZpbGUgKmZpbGUpDQogDQogCWNhc2UgTzJIQl9EQl9UWVBFX1JFR0lPTl9OVU1CRVI6DQog
CQlyZWcgPSAoc3RydWN0IG8yaGJfcmVnaW9uICopZGItPmRiX2RhdGE7DQotCQlvdXQgKz0gc2Nu
cHJpbnRmKGJ1ZiArIG91dCwgUEFHRV9TSVpFIC0gb3V0LCAiJWRcbiIsDQorCQlvdXQgKz0gc3lz
ZnNfZW1pdChidWYgKyBvdXQsICIlZFxuIiwNCiAJCQkJcmVnLT5ocl9yZWdpb25fbnVtKTsNCiAJ
CWdvdG8gZG9uZTsNCiANCkBAIC0xMzE4LDEyICsxMzE4LDEyIEBAIHN0YXRpYyBpbnQgbzJoYl9k
ZWJ1Z19vcGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlKQ0KIAkJLyog
SWYgMCwgaXQgaGFzIG5ldmVyIGJlZW4gc2V0IGJlZm9yZSAqLw0KIAkJaWYgKGx0cykNCiAJCQls
dHMgPSBqaWZmaWVzX3RvX21zZWNzKGppZmZpZXMgLSBsdHMpOw0KLQkJb3V0ICs9IHNjbnByaW50
ZihidWYgKyBvdXQsIFBBR0VfU0laRSAtIG91dCwgIiVsdVxuIiwgbHRzKTsNCisJCW91dCArPSBz
eXNmc19lbWl0KGJ1ZiArIG91dCwgIiVsdVxuIiwgbHRzKTsNCiAJCWdvdG8gZG9uZTsNCiANCiAJ
Y2FzZSBPMkhCX0RCX1RZUEVfUkVHSU9OX1BJTk5FRDoNCiAJCXJlZyA9IChzdHJ1Y3QgbzJoYl9y
ZWdpb24gKilkYi0+ZGJfZGF0YTsNCi0JCW91dCArPSBzY25wcmludGYoYnVmICsgb3V0LCBQQUdF
X1NJWkUgLSBvdXQsICIldVxuIiwNCisJCW91dCArPSBzeXNmc19lbWl0KGJ1ZiArIG91dCwgIiV1
XG4iLA0KIAkJCQkhIXJlZy0+aHJfaXRlbV9waW5uZWQpOw0KIAkJZ290byBkb25lOw0KIA0KQEAg
LTEzMzIsOCArMTMzMiw4IEBAIHN0YXRpYyBpbnQgbzJoYl9kZWJ1Z19vcGVuKHN0cnVjdCBpbm9k
ZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlKQ0KIAl9DQogDQogCXdoaWxlICgoaSA9IGZpbmRf
bmV4dF9iaXQobWFwLCBkYi0+ZGJfbGVuLCBpICsgMSkpIDwgZGItPmRiX2xlbikNCi0JCW91dCAr
PSBzY25wcmludGYoYnVmICsgb3V0LCBQQUdFX1NJWkUgLSBvdXQsICIlZCAiLCBpKTsNCi0Jb3V0
ICs9IHNjbnByaW50ZihidWYgKyBvdXQsIFBBR0VfU0laRSAtIG91dCwgIlxuIik7DQorCQlvdXQg
Kz0gc3lzZnNfZW1pdChidWYgKyBvdXQsICIlZCAiLCBpKTsNCisJb3V0ICs9IHN5c2ZzX2VtaXQo
YnVmICsgb3V0LCAiXG4iKTsNCiANCiBkb25lOg0KIAlpX3NpemVfd3JpdGUoaW5vZGUsIG91dCk7
DQotLSANCjIuMjUuMQ==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iemNvbnRlbnRSb3ciPjxwPjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTogQXJp
YWwsIEhlbHZldGljYSwgJnF1b3Q7TWljcm9zb2Z0IFlhaGVpJnF1b3Q7LCBzYW5zLXNlcmlmOyBi
YWNrZ3JvdW5kLWNvbG9yOiByZ2IoMjU1LCAyNTUsIDI1NSk7Ij5Gcm9tOiBYaWVMdWRhbiAmbHQ7
eGllLmx1ZGFuQHp0ZS5jb20uY24mZ3Q7PC9zcGFuPjwvcD48cD48YnI+PC9wPjxwPkZvbGxvdyB0
aGUgYWR2aWNlIGluIERvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvc3lzZnMucnN0OjwvcD48cD5z
aG93KCkgc2hvdWxkIG9ubHkgdXNlIHN5c2ZzX2VtaXQoKSBvciBzeXNmc19lbWl0X2F0KCkgd2hl
biBmb3JtYXR0aW5nPC9wPjxwPnRoZSB2YWx1ZSB0byBiZSByZXR1cm5lZCB0byB1c2VyIHNwYWNl
LjwvcD48cD48YnI+PC9wPjxwPlNpZ25lZC1vZmYtYnk6IFhpZUx1ZGFuICZsdDt4aWUubHVkYW5A
enRlLmNvbS5jbiZndDs8L3A+PHA+LS0tPC9wPjxwPiZuYnNwO2ZzL29jZnMyL2NsdXN0ZXIvaGVh
cnRiZWF0LmMgfCAxMCArKysrKy0tLS0tPC9wPjxwPiZuYnNwOzEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pPC9wPjxwPjxicj48L3A+PHA+ZGlmZiAtLWdpdCBh
L2ZzL29jZnMyL2NsdXN0ZXIvaGVhcnRiZWF0LmMgYi9mcy9vY2ZzMi9jbHVzdGVyL2hlYXJ0YmVh
dC5jPC9wPjxwPmluZGV4IDcyNDM1MDkyNWFmZi4uODI4MmZjMTkzOTA2IDEwMDY0NDwvcD48cD4t
LS0gYS9mcy9vY2ZzMi9jbHVzdGVyL2hlYXJ0YmVhdC5jPC9wPjxwPisrKyBiL2ZzL29jZnMyL2Ns
dXN0ZXIvaGVhcnRiZWF0LmM8L3A+PHA+QEAgLTEzMDgsNyArMTMwOCw3IEBAIHN0YXRpYyBpbnQg
bzJoYl9kZWJ1Z19vcGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlKTwv
cD48cD4mbmJzcDs8L3A+PHA+Jm5ic3A7PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj5jYXNlIE8ySEJfREJfVFlQRV9SRUdJT05fTlVNQkVSOjwvcD48cD4mbmJzcDs8c3BhbiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JCTwvc3Bhbj5yZWcgPSAoc3RydWN0IG8yaGJfcmVnaW9u
ICopZGItJmd0O2RiX2RhdGE7PC9wPjxwPi08c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
CTwvc3Bhbj5vdXQgKz0gc2NucHJpbnRmKGJ1ZiArIG91dCwgUEFHRV9TSVpFIC0gb3V0LCAiJWRc
biIsPC9wPjxwPis8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JCTwvc3Bhbj5vdXQgKz0g
c3lzZnNfZW1pdChidWYgKyBvdXQsICIlZFxuIiw8L3A+PHA+Jm5ic3A7PHNwYW4gc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CQkJCTwvc3Bhbj5yZWctJmd0O2hyX3JlZ2lvbl9udW0pOzwvcD48cD4m
bmJzcDs8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JCTwvc3Bhbj5nb3RvIGRvbmU7PC9w
PjxwPiZuYnNwOzwvcD48cD5AQCAtMTMxOCwxMiArMTMxOCwxMiBAQCBzdGF0aWMgaW50IG8yaGJf
ZGVidWdfb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlsZSk8L3A+PHA+
Jm5ic3A7PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CQk8L3NwYW4+LyogSWYgMCwgaXQg
aGFzIG5ldmVyIGJlZW4gc2V0IGJlZm9yZSAqLzwvcD48cD4mbmJzcDs8c3BhbiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JCTwvc3Bhbj5pZiAobHRzKTwvcD48cD4mbmJzcDs8c3BhbiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JCQk8L3NwYW4+bHRzID0gamlmZmllc190b19tc2VjcyhqaWZmaWVz
IC0gbHRzKTs8L3A+PHA+LTxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgkJPC9zcGFuPm91
dCArPSBzY25wcmludGYoYnVmICsgb3V0LCBQQUdFX1NJWkUgLSBvdXQsICIlbHVcbiIsIGx0cyk7
PC9wPjxwPis8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JCTwvc3Bhbj5vdXQgKz0gc3lz
ZnNfZW1pdChidWYgKyBvdXQsICIlbHVcbiIsIGx0cyk7PC9wPjxwPiZuYnNwOzxzcGFuIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgkJPC9zcGFuPmdvdG8gZG9uZTs8L3A+PHA+Jm5ic3A7PC9wPjxw
PiZuYnNwOzxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+Y2FzZSBPMkhCX0RC
X1RZUEVfUkVHSU9OX1BJTk5FRDo8L3A+PHA+Jm5ic3A7PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CQk8L3NwYW4+cmVnID0gKHN0cnVjdCBvMmhiX3JlZ2lvbiAqKWRiLSZndDtkYl9kYXRh
OzwvcD48cD4tPHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CQk8L3NwYW4+b3V0ICs9IHNj
bnByaW50ZihidWYgKyBvdXQsIFBBR0VfU0laRSAtIG91dCwgIiV1XG4iLDwvcD48cD4rPHNwYW4g
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CQk8L3NwYW4+b3V0ICs9IHN5c2ZzX2VtaXQoYnVmICsg
b3V0LCAiJXVcbiIsPC9wPjxwPiZuYnNwOzxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgkJ
CQk8L3NwYW4+ISFyZWctJmd0O2hyX2l0ZW1fcGlubmVkKTs8L3A+PHA+Jm5ic3A7PHNwYW4gc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CQk8L3NwYW4+Z290byBkb25lOzwvcD48cD4mbmJzcDs8L3A+
PHA+QEAgLTEzMzIsOCArMTMzMiw4IEBAIHN0YXRpYyBpbnQgbzJoYl9kZWJ1Z19vcGVuKHN0cnVj
dCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlKTwvcD48cD4mbmJzcDs8c3BhbiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPn08L3A+PHA+Jm5ic3A7PC9wPjxwPiZuYnNwOzxz
cGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+d2hpbGUgKChpID0gZmluZF9uZXh0
X2JpdChtYXAsIGRiLSZndDtkYl9sZW4sIGkgKyAxKSkgJmx0OyBkYi0mZ3Q7ZGJfbGVuKTwvcD48
cD4tPHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CQk8L3NwYW4+b3V0ICs9IHNjbnByaW50
ZihidWYgKyBvdXQsIFBBR0VfU0laRSAtIG91dCwgIiVkICIsIGkpOzwvcD48cD4tPHNwYW4gc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5vdXQgKz0gc2NucHJpbnRmKGJ1ZiArIG91dCwg
UEFHRV9TSVpFIC0gb3V0LCAiXG4iKTs8L3A+PHA+KzxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgkJPC9zcGFuPm91dCArPSBzeXNmc19lbWl0KGJ1ZiArIG91dCwgIiVkICIsIGkpOzwvcD48
cD4rPHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5vdXQgKz0gc3lzZnNfZW1p
dChidWYgKyBvdXQsICJcbiIpOzwvcD48cD4mbmJzcDs8L3A+PHA+Jm5ic3A7ZG9uZTo8L3A+PHA+
Jm5ic3A7PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pX3NpemVfd3JpdGUo
aW5vZGUsIG91dCk7PC9wPjxwPi0tJm5ic3A7PC9wPjxwPjIuMjUuMTwvcD48cCBzdHlsZT0iZm9u
dC1zaXplOjE0cHg7Zm9udC1mYW1pbHk65b6u6L2v6ZuF6buRLE1pY3Jvc29mdCBZYUhlaTsiPjxi
cj48L3A+PHAgc3R5bGU9ImZvbnQtc2l6ZToxNHB4O2ZvbnQtZmFtaWx5OuW+rui9r+mbhem7kSxN
aWNyb3NvZnQgWWFIZWk7Ij48YnI+PC9wPjxwIHN0eWxlPSJmb250LXNpemU6MTRweDtmb250LWZh
bWlseTrlvq7ova/pm4Xpu5EsTWljcm9zb2Z0IFlhSGVpOyI+PGJyPjwvcD48cCBzdHlsZT0iZm9u
dC1zaXplOjE0cHg7Zm9udC1mYW1pbHk65b6u6L2v6ZuF6buRLE1pY3Jvc29mdCBZYUhlaTsiPjxi
cj48L3A+PC9kaXY+


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


