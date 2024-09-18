Return-Path: <linux-kernel+bounces-332734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB5097BE01
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65F6D1F21C59
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC641B9B56;
	Wed, 18 Sep 2024 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="XNorqU35"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ADC1078B;
	Wed, 18 Sep 2024 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726669969; cv=none; b=L+EzGvKol87E6034dSY4FWOXEblUdCtIXveqCh8UC4YSg8y/wARSZ6E0QPcnrD/VolnHN/lK2oHQkqDMzaEjtTFLjBIgpDzRcG08kfPhz7aLsUAM0FY2kMLT7760nEe83GK+4LXnrR+ylkhohx3yxde6BCglQHyHPuGhSTSiqQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726669969; c=relaxed/simple;
	bh=HLsSFckZHFLqqJp1HDY+obF+7l3joF1Krbq1k3Vx6Dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y73s2AlqlWmt/hNQaWtxZiWk1ujUPor/3Tzck7qq9J6h0yh73nen38mCSNucRedCjAxRhz+ch8Bdh4cwYkRcXPHSeYDQOjVHjCuJvCvogzHK1DfyylyW1cptONrEf6gX8F9tObWBPCodiaiNSG9dkzM1KfkKn14xFVd4+w8NHuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=XNorqU35; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726669950; x=1727274750; i=markus.elfring@web.de;
	bh=HLsSFckZHFLqqJp1HDY+obF+7l3joF1Krbq1k3Vx6Dk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XNorqU3592/PtfT5gLG/jjFvPjUSACtCt8PRSyBJSkqKClx7eRUmxMESbylzH/xX
	 +wjdAY0kIkAJfbhDaPZ3nrhztFXlKdfSqQWIB+yh8ziWKGnFo8oGkx2VD/3oZIgJK
	 9a8n1Jzd+7bS7qLP9AagvuGTKYOZrMZs/Rl3Zi9DDLJ7lAc1Ew2H5rFN3g2YhZDD3
	 Nty0sQLBOqEVuIw36cJ74vPjJ4jJaU659bq25YYM/ACEeYByWYpapbLX7dNRo8dXf
	 HiPNmZQ+b33feDcsN+KvGGVjYuSD+4hUYKlzIdZesCkmh9H2Me1ctXILBW/IP8sP+
	 EF2dTHMJjFXbxHQ8XA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgzaT-1sLC0O45uP-00jn6Z; Wed, 18
 Sep 2024 16:32:30 +0200
Message-ID: <ec3de20e-92cc-4e22-a30f-a9f57588278c@web.de>
Date: Wed, 18 Sep 2024 16:32:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: at91: pmc: Use common error handling code in
 pmc_register_ops()
To: Nicolas Ferre <nicolas.ferre@microchip.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <4a82fe70-b07c-4878-bd31-6ae07b61f522@web.de>
 <672befa1-cefb-480e-b474-ff40e4fe80ed@microchip.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <672befa1-cefb-480e-b474-ff40e4fe80ed@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:xFjXp6WJvmmw9/6U30mEFomelHGFihD2zd0VY1pqpUY+HqpGKJ/
 QvUwZKT5zGhqVtqRYbk85KfuROV8mgU7L7+rkgipouQltIXpbo8fygl1IlGXbJ8l1EhXkk+
 PKHL4oFb6Rq/1tk0C4fDTQx0Sj5J5NMWQK3jNcqXWSK7GgQgDbaq/7kBExW9ts6KticT6bT
 AETRKG4muajTKCPzKlh2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:l2cN09HSVLY=;/qlCOanEJ1TbXfJi2E/B9HRyK6p
 a+7lsriMukrbKeajJDd2z4MYzpc5BZRf6pup0u0duKNZM6iGOjNTsQQlB/Qyc1hYyuf3Aydot
 vJy5xh7Thr78HczTD05dL24yL8FuPysWR9vR3XIhvKzKuvKtfetzQevPF+UpXiaen5WbpYhB1
 uisF2gly0qKVngmV3Qwrphf7lsl0Nx01Uw6rB8UdZPq98XL3WV9srmuCNPU21rFmii/aopPqM
 Fa1O4MJiY2rBW3daNIqryq3NvUKDtd+O8Z2fOd5SKT0sWfBhmD4iMALBtGkQSSux6bM8W+Aso
 CepvflRO4amxTVqWjmffiEWmnVmirwRmNtuFUpMO/CC9saNb/EQTgpdH/hOV1mYjQitGe0laZ
 tHvdQiAPc16mevxqlA/fbfigYgNpgxIuutJVd3kPevV/rGlPm1UVQ9/3rKXaJAVmB6evbNJ2n
 q4GettBPuetzE2YnbJJiqLO1HxfHsIMpPrsRt0h626baJ2bFd4YquxBPX36tZjBlCJUFrJPUQ
 R/9IpaO060H1qMlBJQLg9WrjMfija48dyHbHeJBXrzX5vn9O+gLRIPt0XJdF4SD28nKbigeNe
 FMaRrvGLpBpWqaC1eJbBGvlAN78Ql3Twq909FjhW1BTwZsyuPctsPJWYM4ipzR77ZVzfqH70z
 v5WdH60i1QSgKj7IE3QbmCEDsLhQPZ70Eu+cQFwz/KMByEQLIOC3fwWe0NLxqRfeiyZnFmd9S
 RwI6V2cWBSj+50ic8k6X2t+y0tUg+vImxblX9+mWuiD1XqSUNXowu53O3282z3qAJA/emXNtV
 eRQAdy8g6yER/yexViTokJmw==

Pj4gQWRkIGEganVtcCB0YXJnZXQgc28gdGhhdCBhIGJpdCBvZiBleGNlcHRpb24gaGFuZGxpbmcg
Y2FuIGJlIGJldHRlciByZXVzZWQNCj4+IGF0IHRoZSBlbmQgb2YgdGhpcyBmdW5jdGlvbiBpbXBs
ZW1lbnRhdGlvbi4NCuKApg0KPiBCYWQgdHJhY2sgcmVjb3JkIGFuZCBubyByZWFsIGJlbmVmaXQg
ZnJvbSB0aGUgcGF0Y2g6DQo+IE5BQ0ssIHNvcnJ5Lg0K4oCmDQo+PiArKysgYi9kcml2ZXJzL2Ns
ay9hdDkxL3BtYy5jDQo+PiBAQCAtMTYyLDIwICsxNjIsMTggQEAgc3RhdGljIGludCBfX2luaXQg
cG1jX3JlZ2lzdGVyX29wcyh2b2lkKQ0KPj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAoIW5wKQ0KPj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9ERVY7DQo+Pg0KPj4g
LcKgwqDCoMKgwqDCoCBpZiAoIW9mX2RldmljZV9pc19hdmFpbGFibGUobnApKSB7DQo+PiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvZl9ub2RlX3B1dChucCk7DQo+PiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT0RFVjsNCj4+IC3CoMKgwqDCoMKgwqAgfQ0K
Pj4gK8KgwqDCoMKgwqDCoCBpZiAoIW9mX2RldmljZV9pc19hdmFpbGFibGUobnApKQ0KPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBwdXRfbm9kZTsNCj4+ICsNCj4+IMKgwqDC
oMKgwqDCoMKgwqAgb2Zfbm9kZV9wdXQobnApOw0KPj4NCj4+IMKgwqDCoMKgwqDCoMKgwqAgbnAg
PSBvZl9maW5kX2NvbXBhdGlibGVfbm9kZShOVUxMLCBOVUxMLCAiYXRtZWwsc2FtYTVkMi1zZWN1
cmFtIik7DQo+PiDCoMKgwqDCoMKgwqDCoMKgIGlmICghbnApDQo+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT0RFVjsNCj4+DQo+PiAtwqDCoMKgwqDCoMKgIGlm
ICghb2ZfZGV2aWNlX2lzX2F2YWlsYWJsZShucCkpIHsNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIG9mX25vZGVfcHV0KG5wKTsNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldHVybiAtRU5PREVWOw0KPj4gLcKgwqDCoMKgwqDCoCB9DQo+PiArwqDCoMKgwqDCoMKg
IGlmICghb2ZfZGV2aWNlX2lzX2F2YWlsYWJsZShucCkpDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBnb3RvIHB1dF9ub2RlOw0KPj4gKw0KPj4gwqDCoMKgwqDCoMKgwqDCoCBvZl9u
b2RlX3B1dChucCk7DQo+Pg0KPj4gwqDCoMKgwqDCoMKgwqDCoCBhdDkxX3BtY19iYWNrdXBfc3Vz
cGVuZCA9IG9mX2lvbWFwKG5wLCAwKTsNCj4+IEBAIC0xODcsNiArMTg1LDEwIEBAIHN0YXRpYyBp
bnQgX19pbml0IHBtY19yZWdpc3Rlcl9vcHModm9pZCkNCj4+IMKgwqDCoMKgwqDCoMKgwqAgcmVn
aXN0ZXJfc3lzY29yZV9vcHMoJnBtY19zeXNjb3JlX29wcyk7DQo+Pg0KPj4gwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gMDsNCj4+ICsNCj4+ICtwdXRfbm9kZToNCj4+ICvCoMKgwqDCoMKgwqAgb2Zf
bm9kZV9wdXQobnApOw0KPj4gK8KgwqDCoMKgwqDCoCByZXR1cm4gLUVOT0RFVjsNCj4+IMKgIH0N
CuKApg0KDQoqIERvIHlvdSByZWFsbHkgZGlzYWdyZWUgdG8gYWR2aWNlIGZyb20gcmVsYXRlZCBp
bmZvcm1hdGlvbiBzb3VyY2VzPw0KICBodHRwczovL3dpa2kuc2VpLmNtdS5lZHUvY29uZmx1ZW5j
ZS9kaXNwbGF5L2MvTUVNMTItQy4rQ29uc2lkZXIrdXNpbmcrYStnb3RvK2NoYWluK3doZW4rbGVh
dmluZythK2Z1bmN0aW9uK29uK2Vycm9yK3doZW4rdXNpbmcrYW5kK3JlbGVhc2luZytyZXNvdXJj
ZXM/DQoNCiogSG93IGRvIHlvdSB0aGluayBhYm91dCB0byBpbmNyZWFzZSB0aGUgYXBwbGljYXRp
b24gb2Ygc2NvcGUtYmFzZWQgcmVzb3VyY2UgbWFuYWdlbWVudD8NCg0KDQpSZWdhcmRzLA0KTWFy
a3VzDQo=

