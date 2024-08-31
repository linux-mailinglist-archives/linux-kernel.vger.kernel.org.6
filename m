Return-Path: <linux-kernel+bounces-309756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FF0967019
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 09:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7855BB22D17
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 07:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD58763F8;
	Sat, 31 Aug 2024 07:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="igESTTyU"
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3665E16F0CA
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725089459; cv=none; b=HlGtWcwdMhe2a+c4tnhC/Yj7/h/DLUOaKrz+us9235+xn2I4tJI4v6pmIuHU8avANW+lCw93Se0qh5jhj+dELM+WFKWv0aDWjeU9Eeild2ECiV2hPeokDJupfuPqERH5Fe9ClcnPhwItBQK9x0K32FsZGQN7cwf1f9LEw+LF4hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725089459; c=relaxed/simple;
	bh=Gkra1YiN/w/SiSVPP8T77PQM1c0ma4c1DIP7FLEARtg=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=PlXizOmOCeIC/YKVCyAWwRKGIx+0bGIQC9+aXbzAgeXLPxt02RdxE+tOm3T25aEdYOfg9NluDmryGsSlri6GnrUSB02WSIfkSArtfK95e8h2cOzqPO9M6LNRBtvvsbektaaL99iKV64n4Z1CHRup5k5yDHifOmD0SLa41uw5yeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=igESTTyU; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1725089423;
	bh=Gkra1YiN/w/SiSVPP8T77PQM1c0ma4c1DIP7FLEARtg=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=igESTTyUD/s3UqdTSn6Hb2FkkE4BnbaNqzFb9plblaURzFB1dmhNyvz//UQtK/oxs
	 4A9JoKmgDfEKFs7SoFbdFIJrvI+KnS1+EyTpCyjP5gh1bLPJEz4hBMq/Q3Gn6u01Qu
	 XIaYgVsTvIrKCf8l8MAzcV4H89y1wc2O5MMo2e7I=
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-XMAILINFO: Mf2c2cXG8XEiUih0wcAqWP57XOAsJfGo1jk3RHuaBV5V6ndPJl0NdvbE
	9/iqfVcoeJvIiWS9plL1k+jSnnP/c+YnHbWLF9d2Jq44QZ5728zyGziFrmpxKFaFGJW5tBY
	lVF7Ymowd2yB56GwjF7LQjtGgpK/0JnF1flcH3tgopCn5bRObCzSQwI99kdepXEnhzwhTuo
	Jpl6C34mfPzXvNalRUv4L7nDQhBvqJTIeu4SSJXmxFbVTFPnu5rGTPgcLFzoqzKg08xqBZl
	Pmww+sMxBVFPZjZolcHKWdeTA3t4cLctEXEqjCHD/sfTkuTz/jypnZ6JySm5wmGHC+/sTuT
	TesqiQGPrie7cZepmxxR4+SEMNvPGDQ79Egnh3HODvVcPLe4wIv3+ebFygNLw9nSSflc5xA
	l1No1WvzSS++qAf8f+Ywob8ojR9HoJgqsK5wHVYL6EuZXmapHKsAeMwmSsZrHggrrOY4JzQ
	1D9W4T+xFhXg0sbZDxNIl6RYnrwmfiVYKS/5W4Sw0O454qJPXrSFKw8dx4kcgZ+HSGx8PgG
	3Z3qB8u/CGI/dgYCPjwBF52zKbuymHnVDJnXuS7CxUNL8nzKu8yoQ6I4PfNCSqCyjmY6g/q
	/2GxkqZUXpwZ3pnewstTBkAF7pBuQ3tH5ISHBOxrfEKcKmUViuL6o5AzPuDqRqoaYBP4qhR
	k7eP4bxYvF3Kl/oetMWUMMwRzl7UkvOfTo+SHHxfR/9rL7ZWczoCn7IrvkQaSiyBpfZyBzj
	ZBDMsd2q9gAJFeVzf4y3sH22yIoVREgIvhGLSoAVpZdXpS4lm2GHLsaKCPRat100MPLwzZB
	wdAlhEiuzusCxkVwuxRTnNGMM+OEOKvMQKdfLCxGjaS4mGqp1+MeqkyXkMxmGTIW/CQPJBT
	0MiBvHU7wP6yMsZnFcJzGYTErbzsQVjVCCHcnBkIrwsSm8Htshnzh15MwDlj9CKr9Wo7Et8
	6OsHTcn2M2BncNvXvfHI0B+CeGQQxC7Eru+CR0s7yuUICNg==
X-QQ-FEAT: D4aqtcRDiqRprBrzF3WAKrTVkjK5ocIr1dSI9KzQHZY=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: N7aDhGZZwp9WjsKwwbS5R4bvGsxcZTf/E9G0BxNpJr4=
X-QQ-STYLE: 
X-QQ-mid: t5gz7a-2t1725089410t8633867
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?SHVhY2FpIENoZW4=?=" <chenhuacai@kernel.org>
Cc: "=?utf-8?B?V0FORyBYdWVydWk=?=" <kernel@xen0n.name>, "=?utf-8?B?bG9vbmdhcmNo?=" <loongarch@lists.linux.dev>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?546L5pix5Yqb?=" <wangyuli@uniontech.com>
Subject: Re: [PATCH] Loongarch64: pci: fix memleak in pci_acpi_scan_root
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sat, 31 Aug 2024 15:30:10 +0800
X-Priority: 3
Message-ID: <tencent_3F6931DF7E765EB870FD970A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20240831052157.13532-1-guanwentao@uniontech.com>
	<CAAhV-H7GptUdpKScV1AuZZm7w-F5oUXHRmaT9BFCZV4HuQExJg@mail.gmail.com>
In-Reply-To: <CAAhV-H7GptUdpKScV1AuZZm7w-F5oUXHRmaT9BFCZV4HuQExJg@mail.gmail.com>
X-QQ-ReplyHash: 3505280181
X-BIZMAIL-ID: 3004264844035363075
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Sat, 31 Aug 2024 15:30:11 +0800 (CST)
Feedback-ID: t:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

SGVsbG8gSHVhY2FpOg0KDQpPa2F5Li4uIEl0IGlzIG15IGNvZGUgc21lbGwsIGhlcmUgaXMg
dGhlIHBhdGNoIGFmdGVyIGNoYW5nZS4NCg0KRnJvbSA3MzQyNjAxOWE4M2E3N2I0NTAyNDkx
ZmM5NmQxNDVlNjY2YjE2OTM2IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogV2Vu
dGFvIEd1YW4gPGd1YW53ZW50YW9AdW5pb250ZWNoLmNvbT4NCkRhdGU6IFNhdCwgMzEgQXVn
IDIwMjQgMDA6MTc6MTAgKzA4MDANClN1YmplY3Q6IFtQQVRDSF0gTG9vbmdhcmNoNjQ6IHBj
aTogZml4IG1lbWxlYWsgaW4gcGNpX2FjcGlfc2Nhbl9yb290DQoNCkFkZCBrZnJlZShyb290
X29wcykgaW4gdGhpcyBjYXNlIHRvIGF2b2lkIG1lbWxlYWsgcm9vdF9vcHMsDQpsZWFrcyB3
aGVuIHBjaV9maW5kX2J1cygpICE9IDAuDQoNClNpZ25lZC1vZmYtYnk6IFdhbmd5dWxpIDx3
YW5neXVsaUB1bmlvbnRlY2guY29tPg0KU2lnbmVkLW9mZi1ieTogV2VudGFvIEd1YW4gPGd1
YW53ZW50YW9AdW5pb250ZWNoLmNvbT4NCi0tLQ0KIGFyY2gvbG9vbmdhcmNoL3BjaS9hY3Bp
LmMgfCAxICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdp
dCBhL2FyY2gvbG9vbmdhcmNoL3BjaS9hY3BpLmMgYi9hcmNoL2xvb25nYXJjaC9wY2kvYWNw
aS5jDQppbmRleCAzZWI2MWI4Y2Q1ZTMuLmY0MDU0MDlhMzQ5MSAxMDA2NDQNCi0tLSBhL2Fy
Y2gvbG9vbmdhcmNoL3BjaS9hY3BpLmMNCisrKyBiL2FyY2gvbG9vbmdhcmNoL3BjaS9hY3Bp
LmMNCkBAIC0yMjcsNiArMjI3LDcgQEAgc3RydWN0IHBjaV9idXMgKnBjaV9hY3BpX3NjYW5f
cm9vdChzdHJ1Y3QgYWNwaV9wY2lfcm9vdCAqcm9vdCkNCiAgICAgICAgaWYgKGJ1cykgew0K
ICAgICAgICAgICAgICAgIG1lbWNweShidXMtPnN5c2RhdGEsIGluZm8tPmNmZywgc2l6ZW9m
KHN0cnVjdCBwY2lfY29uZmlnX3dpbmRvdykpOw0KICAgICAgICAgICAgICAgIGtmcmVlKGlu
Zm8pOw0KKyAgICAgICAgICAgICAgIGtmcmVlKHJvb3Rfb3BzKTsNCiAgICAgICAgfSBlbHNl
IHsNCiAgICAgICAgICAgICAgICBzdHJ1Y3QgcGNpX2J1cyAqY2hpbGQ7DQogDQotLSANCjIu
MjAuMQ==


