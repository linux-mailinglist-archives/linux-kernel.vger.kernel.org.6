Return-Path: <linux-kernel+bounces-562426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47433A62714
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 07:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055EA881D7C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 06:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F72194C75;
	Sat, 15 Mar 2025 06:17:11 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED08F18FDAA
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 06:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742019430; cv=none; b=mLjIXI6zWdfc8CpwQwBCwndnYcOyg83Lodhw5wJ+Ua/pcJ2f9pw91cBPUX0qmLYJDB8nhHlVHdn7fDaq2Bc8VR3pLYFjJdX8KOnHaJ25fLuKWnpEzj+9pM5zeWhZDwPujXJQKBuUZwW+Q4MbJQstN88qOlsG320lRMV4mL0PxDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742019430; c=relaxed/simple;
	bh=Pu+EC6ga7XmQdxG/Hm1qrR2by2tSAxdDFhVIeNBXSSU=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=pt7ZHXgyWpzLvLB//feh5H7hSUs7EkDxGe0AbiK3HRhTEDnFh0kUE0aU+v0z8VglVbZQN3abN1MDXOEkDVAmP2G2sOY5JJseh5yrVPsJEchptR0620As8GP1+ysLRzV7lOcIjBztq+43FrQuTdAdNfQjw25fmz/75OB6uWj7t/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZF9xV6b7Rz501gb;
	Sat, 15 Mar 2025 14:17:02 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 52F6H0Eb055318;
	Sat, 15 Mar 2025 14:17:00 +0800 (+08)
	(envelope-from xie.ludan@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 15 Mar 2025 14:17:00 +0800 (CST)
Date: Sat, 15 Mar 2025 14:17:00 +0800 (CST)
X-Zmail-TransId: 2af967d51b5c148-dbec8
X-Mailer: Zmail v1.0
Message-ID: <202503151417004728U9HCHFf6b_zP5GsZuMdu@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xie.ludan@zte.com.cn>
To: <petr.pavlu@suse.com>
Cc: <linux@weissschuh.net>, <mcgrof@kernel.org>, <thorsten.blum@linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHBhcmFtczogdXNlIHN5c2ZzX2VtaXQoKSBpbnN0ZWFkIG9mIHNjbnByaW50ZigpLg==?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl2.zte.com.cn 52F6H0Eb055318
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D51B5E.004/4ZF9xV6b7Rz501gb



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
OiBYaWVMdWRhbiA8eGllLmx1ZGFuQHp0ZS5jb20uY24+DQotLS0NCiBrZXJuZWwvcGFyYW1zLmMg
fCA4ICsrKystLS0tDQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkNCg0KZGlmZiAtLWdpdCBhL2tlcm5lbC9wYXJhbXMuYyBiL2tlcm5lbC9wYXJhbXMuYw0K
aW5kZXggMjUwOWYyMTZjOWYzLi44OWFlNTcxYWYyNjYgMTAwNjQ0DQotLS0gYS9rZXJuZWwvcGFy
YW1zLmMNCisrKyBiL2tlcm5lbC9wYXJhbXMuYw0KQEAgLTIxOSw3ICsyMTksNyBAQCBjaGFyICpw
YXJzZV9hcmdzKGNvbnN0IGNoYXIgKmRvaW5nLA0KIAl9CQkJCQkJCQlcDQogCWludCBwYXJhbV9n
ZXRfIyNuYW1lKGNoYXIgKmJ1ZmZlciwgY29uc3Qgc3RydWN0IGtlcm5lbF9wYXJhbSAqa3ApIFwN
CiAJewkJCQkJCQkJXA0KLQkJcmV0dXJuIHNjbnByaW50ZihidWZmZXIsIFBBR0VfU0laRSwgZm9y
bWF0ICJcbiIsCVwNCisJCXJldHVybiBzeXNmc19lbWl0KGJ1ZmZlciwgZm9ybWF0ICJcbiIsCVwN
CiAJCQkJKigodHlwZSAqKWtwLT5hcmcpKTsJCQlcDQogCX0JCQkJCQkJCVwNCiAJY29uc3Qgc3Ry
dWN0IGtlcm5lbF9wYXJhbV9vcHMgcGFyYW1fb3BzXyMjbmFtZSA9IHsJCQlcDQpAQCAtMjg5LDcg
KzI4OSw3IEBAIEVYUE9SVF9TWU1CT0wocGFyYW1fc2V0X2NoYXJwKTsNCiANCiBpbnQgcGFyYW1f
Z2V0X2NoYXJwKGNoYXIgKmJ1ZmZlciwgY29uc3Qgc3RydWN0IGtlcm5lbF9wYXJhbSAqa3ApDQog
ew0KLQlyZXR1cm4gc2NucHJpbnRmKGJ1ZmZlciwgUEFHRV9TSVpFLCAiJXNcbiIsICooKGNoYXIg
Kiopa3AtPmFyZykpOw0KKwlyZXR1cm4gc3lzZnNfZW1pdChidWZmZXIsICIlc1xuIiwgKigoY2hh
ciAqKilrcC0+YXJnKSk7DQogfQ0KIEVYUE9SVF9TWU1CT0wocGFyYW1fZ2V0X2NoYXJwKTsNCiAN
CkBAIC01MjcsNyArNTI3LDcgQEAgRVhQT1JUX1NZTUJPTChwYXJhbV9zZXRfY29weXN0cmluZyk7
DQogaW50IHBhcmFtX2dldF9zdHJpbmcoY2hhciAqYnVmZmVyLCBjb25zdCBzdHJ1Y3Qga2VybmVs
X3BhcmFtICprcCkNCiB7DQogCWNvbnN0IHN0cnVjdCBrcGFyYW1fc3RyaW5nICprcHMgPSBrcC0+
c3RyOw0KLQlyZXR1cm4gc2NucHJpbnRmKGJ1ZmZlciwgUEFHRV9TSVpFLCAiJXNcbiIsIGtwcy0+
c3RyaW5nKTsNCisJcmV0dXJuIHN5c2ZzX2VtaXQoYnVmZmVyLCAiJXNcbiIsIGtwcy0+c3RyaW5n
KTsNCiB9DQogRVhQT1JUX1NZTUJPTChwYXJhbV9nZXRfc3RyaW5nKTsNCiANCkBAIC04NjAsNyAr
ODYwLDcgQEAgc3NpemVfdCBfX21vZHZlcl92ZXJzaW9uX3Nob3coY29uc3Qgc3RydWN0IG1vZHVs
ZV9hdHRyaWJ1dGUgKm1hdHRyLA0KIAljb25zdCBzdHJ1Y3QgbW9kdWxlX3ZlcnNpb25fYXR0cmli
dXRlICp2YXR0ciA9DQogCQljb250YWluZXJfb2ZfY29uc3QobWF0dHIsIHN0cnVjdCBtb2R1bGVf
dmVyc2lvbl9hdHRyaWJ1dGUsIG1hdHRyKTsNCiANCi0JcmV0dXJuIHNjbnByaW50ZihidWYsIFBB
R0VfU0laRSwgIiVzXG4iLCB2YXR0ci0+dmVyc2lvbik7DQorCXJldHVybiBzeXNmc19lbWl0KGJ1
ZiwgIiVzXG4iLCB2YXR0ci0+dmVyc2lvbik7DQogfQ0KIA0KIGV4dGVybiBjb25zdCBzdHJ1Y3Qg
bW9kdWxlX3ZlcnNpb25fYXR0cmlidXRlIF9fc3RhcnRfX19tb2R2ZXJbXTsNCi0tIA0KMi4yNS4x

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
enRlLmNvbS5jbiZndDs8L3A+PHA+LS0tPC9wPjxwPiZuYnNwO2tlcm5lbC9wYXJhbXMuYyB8IDgg
KysrKy0tLS08L3A+PHA+Jm5ic3A7MSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSk8L3A+PHA+PGJyPjwvcD48cD5kaWZmIC0tZ2l0IGEva2VybmVsL3BhcmFtcy5j
IGIva2VybmVsL3BhcmFtcy5jPC9wPjxwPmluZGV4IDI1MDlmMjE2YzlmMy4uODlhZTU3MWFmMjY2
IDEwMDY0NDwvcD48cD4tLS0gYS9rZXJuZWwvcGFyYW1zLmM8L3A+PHA+KysrIGIva2VybmVsL3Bh
cmFtcy5jPC9wPjxwPkBAIC0yMTksNyArMjE5LDcgQEAgY2hhciAqcGFyc2VfYXJncyhjb25zdCBj
aGFyICpkb2luZyw8L3A+PHA+Jm5ic3A7PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj59PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CQkJCQkJCQk8L3NwYW4+XDwvcD48
cD4mbmJzcDs8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmludCBwYXJhbV9n
ZXRfIyNuYW1lKGNoYXIgKmJ1ZmZlciwgY29uc3Qgc3RydWN0IGtlcm5lbF9wYXJhbSAqa3ApIFw8
L3A+PHA+Jm5ic3A7PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj57PHNwYW4g
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CQkJCQkJCQk8L3NwYW4+XDwvcD48cD4tPHNwYW4gc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CQk8L3NwYW4+cmV0dXJuIHNjbnByaW50ZihidWZmZXIsIFBB
R0VfU0laRSwgZm9ybWF0ICJcbiIsPHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj5cPC9wPjxwPis8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JCTwvc3Bhbj5yZXR1cm4g
c3lzZnNfZW1pdChidWZmZXIsIGZvcm1hdCAiXG4iLDxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+XDwvcD48cD4mbmJzcDs8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
CQkJPC9zcGFuPiooKHR5cGUgKilrcC0mZ3Q7YXJnKSk7PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CQkJPC9zcGFuPlw8L3A+PHA+Jm5ic3A7PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj59PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CQkJCQkJCQk8L3NwYW4+
XDwvcD48cD4mbmJzcDs8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmNvbnN0
IHN0cnVjdCBrZXJuZWxfcGFyYW1fb3BzIHBhcmFtX29wc18jI25hbWUgPSB7PHNwYW4gc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CQkJPC9zcGFuPlw8L3A+PHA+QEAgLTI4OSw3ICsyODksNyBAQCBF
WFBPUlRfU1lNQk9MKHBhcmFtX3NldF9jaGFycCk7PC9wPjxwPiZuYnNwOzwvcD48cD4mbmJzcDtp
bnQgcGFyYW1fZ2V0X2NoYXJwKGNoYXIgKmJ1ZmZlciwgY29uc3Qgc3RydWN0IGtlcm5lbF9wYXJh
bSAqa3ApPC9wPjxwPiZuYnNwO3s8L3A+PHA+LTxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+cmV0dXJuIHNjbnByaW50ZihidWZmZXIsIFBBR0VfU0laRSwgIiVzXG4iLCAqKChj
aGFyICoqKWtwLSZndDthcmcpKTs8L3A+PHA+KzxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+cmV0dXJuIHN5c2ZzX2VtaXQoYnVmZmVyLCAiJXNcbiIsICooKGNoYXIgKiopa3At
Jmd0O2FyZykpOzwvcD48cD4mbmJzcDt9PC9wPjxwPiZuYnNwO0VYUE9SVF9TWU1CT0wocGFyYW1f
Z2V0X2NoYXJwKTs8L3A+PHA+Jm5ic3A7PC9wPjxwPkBAIC01MjcsNyArNTI3LDcgQEAgRVhQT1JU
X1NZTUJPTChwYXJhbV9zZXRfY29weXN0cmluZyk7PC9wPjxwPiZuYnNwO2ludCBwYXJhbV9nZXRf
c3RyaW5nKGNoYXIgKmJ1ZmZlciwgY29uc3Qgc3RydWN0IGtlcm5lbF9wYXJhbSAqa3ApPC9wPjxw
PiZuYnNwO3s8L3A+PHA+Jm5ic3A7PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj5jb25zdCBzdHJ1Y3Qga3BhcmFtX3N0cmluZyAqa3BzID0ga3AtJmd0O3N0cjs8L3A+PHA+LTxz
cGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+cmV0dXJuIHNjbnByaW50ZihidWZm
ZXIsIFBBR0VfU0laRSwgIiVzXG4iLCBrcHMtJmd0O3N0cmluZyk7PC9wPjxwPis8c3BhbiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnJldHVybiBzeXNmc19lbWl0KGJ1ZmZlciwgIiVz
XG4iLCBrcHMtJmd0O3N0cmluZyk7PC9wPjxwPiZuYnNwO308L3A+PHA+Jm5ic3A7RVhQT1JUX1NZ
TUJPTChwYXJhbV9nZXRfc3RyaW5nKTs8L3A+PHA+Jm5ic3A7PC9wPjxwPkBAIC04NjAsNyArODYw
LDcgQEAgc3NpemVfdCBfX21vZHZlcl92ZXJzaW9uX3Nob3coY29uc3Qgc3RydWN0IG1vZHVsZV9h
dHRyaWJ1dGUgKm1hdHRyLDwvcD48cD4mbmJzcDs8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPmNvbnN0IHN0cnVjdCBtb2R1bGVfdmVyc2lvbl9hdHRyaWJ1dGUgKnZhdHRyID08
L3A+PHA+Jm5ic3A7PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CQk8L3NwYW4+Y29udGFp
bmVyX29mX2NvbnN0KG1hdHRyLCBzdHJ1Y3QgbW9kdWxlX3ZlcnNpb25fYXR0cmlidXRlLCBtYXR0
cik7PC9wPjxwPiZuYnNwOzwvcD48cD4tPHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj5yZXR1cm4gc2NucHJpbnRmKGJ1ZiwgUEFHRV9TSVpFLCAiJXNcbiIsIHZhdHRyLSZndDt2
ZXJzaW9uKTs8L3A+PHA+KzxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+cmV0
dXJuIHN5c2ZzX2VtaXQoYnVmLCAiJXNcbiIsIHZhdHRyLSZndDt2ZXJzaW9uKTs8L3A+PHA+Jm5i
c3A7fTwvcD48cD4mbmJzcDs8L3A+PHA+Jm5ic3A7ZXh0ZXJuIGNvbnN0IHN0cnVjdCBtb2R1bGVf
dmVyc2lvbl9hdHRyaWJ1dGUgX19zdGFydF9fX21vZHZlcltdOzwvcD48cD4tLSZuYnNwOzwvcD48
cD4yLjI1LjE8L3A+PHAgc3R5bGU9ImZvbnQtc2l6ZToxNHB4O2ZvbnQtZmFtaWx5OuW+rui9r+mb
hem7kSxNaWNyb3NvZnQgWWFIZWk7Ij48YnI+PC9wPjxwIHN0eWxlPSJmb250LXNpemU6MTRweDtm
b250LWZhbWlseTrlvq7ova/pm4Xpu5EsTWljcm9zb2Z0IFlhSGVpOyI+PGJyPjwvcD48cCBzdHls
ZT0iZm9udC1zaXplOjE0cHg7Zm9udC1mYW1pbHk65b6u6L2v6ZuF6buRLE1pY3Jvc29mdCBZYUhl
aTsiPjxicj48L3A+PHAgc3R5bGU9ImZvbnQtc2l6ZToxNHB4O2ZvbnQtZmFtaWx5OuW+rui9r+mb
hem7kSxNaWNyb3NvZnQgWWFIZWk7Ij48YnI+PC9wPjwvZGl2Pg==


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


