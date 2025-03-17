Return-Path: <linux-kernel+bounces-563602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 950E4A64532
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489A2189429F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7F621D3CD;
	Mon, 17 Mar 2025 08:22:53 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B5A21A452
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742199772; cv=none; b=VqIEBIVdk47AKMFdu3UURvO7WMDxbaT4WzY4EM4mHL7gA1HQrg/rp7H1BKpc56VEJHsdNJ//zWIsD8Ukly39jkwpHxy6fwDA2JMfb+O7By6Bbj02HOHUsdD2WELWRoiCZ9QK5Y8lQPO7KN3clF2zDlyr6tRhgJyIuf2BOZRGTS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742199772; c=relaxed/simple;
	bh=CqCkp7KD/P1wOllHefbnVfJ74h8eMcvNsq4V5FqNitc=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=HIKUu0Z8Y4BOVaR4hosyN7qPu1M2bk8NXXhGNE6loHkySjADOzbHLlJvTxqgAczqlV2QspSqHMaGPVJaCtAtoWHP9Nj+B5vVXoqdcnpPG7PjCz8uojzIEyh+Rq+qA388utMiR1bg7i2ls4ZD8Fyr1xa6nYQOQQLPPLKQT0vPAmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZGSdc4KX2z8R042;
	Mon, 17 Mar 2025 16:22:44 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 52H8MaoT026738;
	Mon, 17 Mar 2025 16:22:36 +0800 (+08)
	(envelope-from xie.ludan@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 17 Mar 2025 16:22:38 +0800 (CST)
Date: Mon, 17 Mar 2025 16:22:38 +0800 (CST)
X-Zmail-TransId: 2afc67d7dbce7e9-58bf6
X-Mailer: Zmail v1.0
Message-ID: <20250317162238425-kqmo4SSrhMo3_UytWSPc@zte.com.cn>
In-Reply-To: <bc7d8174-f0dc-4976-8040-cfd50c04c25d@kernel.org>
References: 20250317145456376WIxu0TMZrHMod4XZCbh2g@zte.com.cn,bc7d8174-f0dc-4976-8040-cfd50c04c25d@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xie.ludan@zte.com.cn>
To: <jirislaby@kernel.org>
Cc: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eC1uZXh0XSBnZW5pcnE6IHVzZSBzeXNmc19lbWl0KCkvc3lzZnNfZW1pdF9hdCgpIGluc3RlYWQgb2Ygc2NucHJpbnRmKCku?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl2.zte.com.cn 52H8MaoT026738
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D7DBD4.000/4ZGSdc4KX2z8R042



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

PiBBcmUgeW91IGEgYm90PwoKPiBPbiAxNy4gMDMuIDI1LCA3OjU0LCB4aWUubHVkYW5AenRlLmNv
bS5jbiB3cm90ZTo+IEZyb206IFhpZUx1ZGFuIDx4aWUubHVkYW5AenRlLmNvbS5jbj4KPiA+IAo+
ID4gCj4gPiBGb2xsb3cgdGhlIGFkdmljZSBpbiBEb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL3N5
c2ZzLnJzdDogc2hvdygpIHNob3VsZAo+ID4gCj4gPiBvbmx5IHVzZSBzeXNmc19lbWl0KCkgb3Ig
c3lzZnNfZW1pdF9hdCgpIHdoZW4gZm9ybWF0dGluZyB0aGUgdmFsdWUgdG8gYmUKPiA+IAo+ID4g
cmV0dXJuZWQgdG8gdXNlciBzcGFjZS4NCg0KSSdtIHNvcnJ5IGlmIEkgbWFrZSBhbnkgbWlzdGFr
ZXMuIEknbSBqdXN0IHN0YXJ0aW5nIHRvIGxlYXJuIGhvdyB0byBzdWJtaXQgcGF0Y2hlcyB0byB0
aGUgY29tbXVuaXR5IGFuZCBJJ20gc3RpbGwgbGVhcm5pbmcgdGhlIHByb3BlciBzdWJtaXNzaW9u
IHByb2Nlc3MuIA0KSSB3b3VsZCBncmVhdGx5IGFwcHJlY2lhdGUgeW91ciBwYXRpZW5jZSBhbmQg
Z3VpZGFuY2UgZHVyaW5nIHRoaXMgbGVhcm5pbmcgcGhhc2UuIFRoYW5rIHlvdSBmb3IgeW91ciB1
bmRlcnN0YW5kaW5nIQ0KDQpCZXN0IFJlZ2FyZHMNClhpZSBMdWRhbg0KDQoNCg0KT3JpZ2luYWwN
Cg0KDQpGcm9tOiBqaXJpc2xhYnkgPGppcmlzbGFieUBrZXJuZWwub3JnPg0KVG86IFhpZSBMdWRh
bjAwMjk3MDYxO3RnbHggPHRnbHhAbGludXRyb25peC5kZT47DQpDYzogbGludXgta2VybmVsIDxs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjtYdSBYaW4xMDMxMTU4NztZYW5nIFlhbmcxMDE5
MjAyMTsNCkRhdGU6IDIwMjUvMDMvMTcgMTU6MTUNClN1YmplY3Q6IFJlOiBbUEFUQ0ggbGludXgt
bmV4dF0gZ2VuaXJxOiB1c2Ugc3lzZnNfZW1pdCgpL3N5c2ZzX2VtaXRfYXQoKSBpbnN0ZWFkIG9m
IHNjbnByaW50ZigpLg0KDQpBcmUgeW91IGEgYm90Pw0KIA0KT24gMTcuIDAzLiAyNSwgNzo1NCwg
eGllLmx1ZGFuQHp0ZS5jb20uY24gd3JvdGU6DQo+IEZyb206IFhpZUx1ZGFuIDx4aWUubHVkYW5A
enRlLmNvbS5jbj4gDQo+ICANCj4gIA0KPiBGb2xsb3cgdGhlIGFkdmljZSBpbiBEb2N1bWVudGF0
aW9uL2ZpbGVzeXN0ZW1zL3N5c2ZzLnJzdDogc2hvdygpIHNob3VsZA0KPiAgDQo+IG9ubHkgdXNl
IHN5c2ZzX2VtaXQoKSBvciBzeXNmc19lbWl0X2F0KCkgd2hlbiBmb3JtYXR0aW5nIHRoZSB2YWx1
ZSB0byBiZQ0KPiAgDQo+IHJldHVybmVkIHRvIHVzZXIgc3BhY2UuDQogDQogDQotLSAgDQpqcw0K
c3VzZSBsYWJz


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iemNvbnRlbnRSb3ciPjxwcmUgaWQ9ImIiIHN0eWxlPSJmb250LXNpemU6IDEz
cHg7IGJhY2tncm91bmQtY29sb3I6IHJnYigyNTUsIDI1NSwgMjU1KTsgY29sb3I6IHJnYigwLCAw
LCA1MSk7IHdoaXRlLXNwYWNlOiBwcmUtd3JhcDsiPiZndDsgQXJlIHlvdSBhIGJvdD8KCiZndDsg
T24gMTcuIDAzLiAyNSwgNzo1NCwgeGllLmx1ZGFuQHp0ZS5jb20uY24gd3JvdGU6PHNwYW4gY2xh
c3M9InEiIHN0eWxlPSJiYWNrZ3JvdW5kLWltYWdlOiBpbml0aWFsOyBiYWNrZ3JvdW5kLXBvc2l0
aW9uOiBpbml0aWFsOyBiYWNrZ3JvdW5kLXNpemU6IGluaXRpYWw7IGJhY2tncm91bmQtcmVwZWF0
OiBpbml0aWFsOyBiYWNrZ3JvdW5kLWF0dGFjaG1lbnQ6IGluaXRpYWw7IGJhY2tncm91bmQtb3Jp
Z2luOiBpbml0aWFsOyBiYWNrZ3JvdW5kLWNsaXA6IGluaXRpYWw7IGNvbG9yOiByZ2IoMCwgMCwg
MTAyKTsiPiZndDsgRnJvbTogWGllTHVkYW4gJmx0O3hpZS5sdWRhbkB6dGUuY29tLmNuJmd0Owom
Z3Q7ICZndDsgCiZndDsgJmd0OyAKJmd0OyAmZ3Q7IEZvbGxvdyB0aGUgYWR2aWNlIGluIERvY3Vt
ZW50YXRpb24vZmlsZXN5c3RlbXMvc3lzZnMucnN0OiBzaG93KCkgc2hvdWxkCiZndDsgJmd0OyAK
Jmd0OyAmZ3Q7IG9ubHkgdXNlIHN5c2ZzX2VtaXQoKSBvciBzeXNmc19lbWl0X2F0KCkgd2hlbiBm
b3JtYXR0aW5nIHRoZSB2YWx1ZSB0byBiZQomZ3Q7ICZndDsgCiZndDsgJmd0OyByZXR1cm5lZCB0
byB1c2VyIHNwYWNlLjwvc3Bhbj48L3ByZT48cCBzdHlsZT0iZm9udC1zaXplOjE0cHg7Zm9udC1m
YW1pbHk65b6u6L2v6ZuF6buRLE1pY3Jvc29mdCBZYUhlaTsiPjxicj48L3A+PHA+SSdtIHNvcnJ5
IGlmIEkgbWFrZSBhbnkgbWlzdGFrZXMuIEknbSBqdXN0IHN0YXJ0aW5nIHRvIGxlYXJuIGhvdyB0
byBzdWJtaXQgcGF0Y2hlcyB0byB0aGUgY29tbXVuaXR5IGFuZCBJJ20gc3RpbGwgbGVhcm5pbmcg
dGhlIHByb3BlciBzdWJtaXNzaW9uIHByb2Nlc3MuJm5ic3A7PC9wPjxwPkkgd291bGQgZ3JlYXRs
eSBhcHByZWNpYXRlIHlvdXIgcGF0aWVuY2UgYW5kIGd1aWRhbmNlIGR1cmluZyB0aGlzIGxlYXJu
aW5nIHBoYXNlLiBUaGFuayB5b3UgZm9yIHlvdXIgdW5kZXJzdGFuZGluZyE8L3A+PHA+PGJyPjwv
cD48cD5CZXN0IFJlZ2FyZHM8L3A+PHA+WGllIEx1ZGFuPC9wPjxwIHN0eWxlPSJmb250LXNpemU6
MTRweDtmb250LWZhbWlseTrlvq7ova/pm4Xpu5EsTWljcm9zb2Z0IFlhSGVpOyI+PGJyPjwvcD48
cCBzdHlsZT0iZm9udC1zaXplOjE0cHg7Zm9udC1mYW1pbHk65b6u6L2v6ZuF6buRLE1pY3Jvc29m
dCBZYUhlaTsiPjxicj48L3A+PGRpdiBjbGFzcz0iemhpc3RvcnlSb3ciIHN0eWxlPSJkaXNwbGF5
OmJsb2NrIj48ZGl2IGNsYXNzPSJ6aGlzdG9yeURlcyIgc3R5bGU9IndpZHRoOiAxMDAlOyBoZWln
aHQ6IDI4cHg7IGxpbmUtaGVpZ2h0OiAyOHB4OyBiYWNrZ3JvdW5kLWNvbG9yOiAjRTBFNUU5OyBj
b2xvcjogIzEzODhGRjsgdGV4dC1hbGlnbjogY2VudGVyOyIgbGFuZ3VhZ2UtZGF0YT0iSGlzdG9y
eU9yZ1R4dCI+T3JpZ2luYWw8L2Rpdj48ZGl2IGlkPSJ6d3JpdGVIaXN0b3J5Q29udGFpbmVyIj48
ZGl2IGNsYXNzPSJjb250cm9sLWdyb3VwIHpoaXN0b3J5UGFuZWwiPjxkaXYgY2xhc3M9InpoaXN0
b3J5SGVhZGVyIiBzdHlsZT0icGFkZGluZzogOHB4OyBiYWNrZ3JvdW5kLWNvbG9yOiAjRjVGNkY4
OyI+PGRpdj48c3Ryb25nIGxhbmd1YWdlLWRhdGE9Ikhpc3RvcnlTZW5kZXJUeHQiPkZyb206Jm5i
c3A7PC9zdHJvbmc+PHNwYW4gY2xhc3M9InpyZWFkVXNlck5hbWUiPmppcmlzbGFieSAmbHQ7amly
aXNsYWJ5QGtlcm5lbC5vcmcmZ3Q7PC9zcGFuPjwvZGl2PjxkaXY+PHN0cm9uZyBsYW5ndWFnZS1k
YXRhPSJIaXN0b3J5VE9UeHQiPlRvOiZuYnNwOzwvc3Ryb25nPjxzcGFuIGNsYXNzPSJ6cmVhZFVz
ZXJOYW1lIiBzdHlsZT0iZGlzcGxheTogaW5saW5lOyI+WGllIEx1ZGFuMDAyOTcwNjE7PC9zcGFu
PjxzcGFuIGNsYXNzPSJ6cmVhZFVzZXJOYW1lIiBzdHlsZT0iZGlzcGxheTogaW5saW5lOyI+dGds
eCAmbHQ7dGdseEBsaW51dHJvbml4LmRlJmd0Ozs8L3NwYW4+PC9kaXY+PGRpdj48c3Ryb25nIGxh
bmd1YWdlLWRhdGE9Ikhpc3RvcnlDQ1R4dCI+Q2M6Jm5ic3A7PC9zdHJvbmc+PHNwYW4gY2xhc3M9
InpyZWFkVXNlck5hbWUiIHN0eWxlPSJkaXNwbGF5OiBpbmxpbmU7Ij5saW51eC1rZXJuZWwgJmx0
O2xpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcmZ3Q7Ozwvc3Bhbj48c3BhbiBjbGFzcz0ienJl
YWRVc2VyTmFtZSIgc3R5bGU9ImRpc3BsYXk6IGlubGluZTsiPlh1IFhpbjEwMzExNTg3Ozwvc3Bh
bj48c3BhbiBjbGFzcz0ienJlYWRVc2VyTmFtZSIgc3R5bGU9ImRpc3BsYXk6IGlubGluZTsiPllh
bmcgWWFuZzEwMTkyMDIxOzwvc3Bhbj48L2Rpdj48ZGl2PjxzdHJvbmcgbGFuZ3VhZ2UtZGF0YT0i
SGlzdG9yeURhdGVUeHQiPkRhdGU6Jm5ic3A7PC9zdHJvbmc+PHNwYW4gY2xhc3M9IiI+MjAyNS8w
My8xNyAxNToxNTwvc3Bhbj48L2Rpdj48ZGl2PjxzdHJvbmcgbGFuZ3VhZ2UtZGF0YT0iSGlzdG9y
eVN1YmplY3RUeHQiPlN1YmplY3Q6Jm5ic3A7PC9zdHJvbmc+PHNwYW4gY2xhc3M9InpyZWFkVGl0
bGUiPjxzdHJvbmc+UmU6IFtQQVRDSCBsaW51eC1uZXh0XSBnZW5pcnE6IHVzZSBzeXNmc19lbWl0
KCkvc3lzZnNfZW1pdF9hdCgpIGluc3RlYWQgb2Ygc2NucHJpbnRmKCkuPC9zdHJvbmc+PC9zcGFu
PjwvZGl2PjwvZGl2PjxkaXYgY2xhc3M9InpoaXN0b3J5Q29udGVudCI+QXJlJm5ic3A7eW91Jm5i
c3A7YSZuYnNwO2JvdD88YnI+IDxicj5PbiZuYnNwOzE3LiZuYnNwOzAzLiZuYnNwOzI1LCZuYnNw
Ozc6NTQsJm5ic3A7eGllLmx1ZGFuQHp0ZS5jb20uY24mbmJzcDt3cm90ZTo8YnI+Jmd0OyZuYnNw
O0Zyb206Jm5ic3A7WGllTHVkYW4mbmJzcDsmbHQ7eGllLmx1ZGFuQHp0ZS5jb20uY24mZ3Q7IDxi
cj4mZ3Q7Jm5ic3A7IDxicj4mZ3Q7Jm5ic3A7IDxicj4mZ3Q7Jm5ic3A7Rm9sbG93Jm5ic3A7dGhl
Jm5ic3A7YWR2aWNlJm5ic3A7aW4mbmJzcDtEb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL3N5c2Zz
LnJzdDombmJzcDtzaG93KCkmbmJzcDtzaG91bGQ8YnI+Jmd0OyZuYnNwOyA8YnI+Jmd0OyZuYnNw
O29ubHkmbmJzcDt1c2UmbmJzcDtzeXNmc19lbWl0KCkmbmJzcDtvciZuYnNwO3N5c2ZzX2VtaXRf
YXQoKSZuYnNwO3doZW4mbmJzcDtmb3JtYXR0aW5nJm5ic3A7dGhlJm5ic3A7dmFsdWUmbmJzcDt0
byZuYnNwO2JlPGJyPiZndDsmbmJzcDsgPGJyPiZndDsmbmJzcDtyZXR1cm5lZCZuYnNwO3RvJm5i
c3A7dXNlciZuYnNwO3NwYWNlLjxicj4gPGJyPiA8YnI+LS0mbmJzcDsgPGJyPmpzPGJyPnN1c2Um
bmJzcDtsYWJzPGJyPjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjxwPjxicj48L3A+PC9kaXY+


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


