Return-Path: <linux-kernel+bounces-540857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FEDA4B5DD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1DBC7A69D4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 01:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C3A14037F;
	Mon,  3 Mar 2025 01:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="rweFE0bt"
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A922C181;
	Mon,  3 Mar 2025 01:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740966696; cv=none; b=ZFduWC9rffCn+G2GLJG7lQHpuqQSGon5tkQu9o6fz4thK8iWZMO5o7u8XO3RQbK1XE30QK5BbsxP+TH4e4FyPQ0ihYmgr14yE3PRdFx71WVGxLConOKNz0IwkIEatrLlCN92Ea4UGCgAuXN9m4gdbwjPLbHyYxOgpB6P066z9i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740966696; c=relaxed/simple;
	bh=1dqhsBaZYEZSb6IteqyqxDAm7uzt8Usr6U3inQ/QoU4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YKVeu66fSJlEDaLnA2buqsULxaZPNmv9TOZ6cARV9AJti29GxO02BgdmBYUfztaD4NPG4AqfwRAOK2wPHCWsXVq7jVMiJK7AkIacY5kPvTuskLArs+fuEg6P1jVBVtk3mDJK31P+u3SjFPX/YkpPlSBK44A52W3jjRb4LougcyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=rweFE0bt; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5231olc07376833, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740966647; bh=1dqhsBaZYEZSb6IteqyqxDAm7uzt8Usr6U3inQ/QoU4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=rweFE0bt0iwE/dO/Z0KlHqEukRSA6z7NJ0/qIVOzvLSZty7lR3p/tBKsNCHr4NGLx
	 Qk/Xw4WB33ZT1vSjDHbaylUIVRdyOoVIz5d6IMPuZO2Esv3vMWnKFiEllA4RtcYOd8
	 jtTcjGVy5Tomh6KNP0t2JmJQe0CHYzuenEi5MmoPAC3cN6x2c/G3GtaFsx5wqXBuhv
	 tQRqN9ooHxcqqkN2vBZtGn2QrKPNTy7sVSzqr2M/XGA03EdSfHrDEtsMKSkTU9IGQ3
	 9lVvbj4O2vntprvz1cLBHqFlG7oLxszu1wlhDDRKKLQKbOaa09yeqCdRx+JRRdupie
	 bEydzBCHSQRhA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5231olc07376833
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Mar 2025 09:50:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Mar 2025 09:50:48 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 3 Mar 2025 09:50:47 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547]) by
 RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547%5]) with mapi id
 15.01.2507.035; Mon, 3 Mar 2025 09:50:47 +0800
From: =?utf-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>
To: Bard Liao <yung-chuan.liao@linux.intel.com>,
        "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.de" <tiwai@suse.de>, "vkoul@kernel.org" <vkoul@kernel.org>
CC: "vinod.koul@linaro.org" <vinod.koul@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pierre-louis.bossart@linux.dev" <pierre-louis.bossart@linux.dev>,
        "bard.liao@intel.com" <bard.liao@intel.com>
Subject: RE: [PATCH v4 00/16] SoundWire/ASoC: add SDW BPT/BRA support
Thread-Topic: [PATCH v4 00/16] SoundWire/ASoC: add SDW BPT/BRA support
Thread-Index: AQHbiSO5uVBBh0byzkCS/q05z6djELNgqnxg
Date: Mon, 3 Mar 2025 01:50:47 +0000
Message-ID: <4d9e4190e4d749b6944408859d660643@realtek.com>
References: <20250227140615.8147-1-yung-chuan.liao@linux.intel.com>
In-Reply-To: <20250227140615.8147-1-yung-chuan.liao@linux.intel.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiBUaGlzIHNlcmllcyBhZGRzIHN1cHBvcnQgZm9yIFNvdW5kV2lyZSBCUFQvQlJBLiBUaGUgY2hh
bmdlIGlzIG1haW5seSBvbiB0aGUNCj4gU291bmRXaXJlIHRyZWUuIEl0IGlzIGJldHRlciB0byBn
byB0aHJvdWdoIHRoZSBTb3VuZFdpcmUgdHJlZSB3aXRoIE1hcmsncw0KPiBBY2tlZC1ieSB0YWcu
DQo+IA0KPiB2MjoNCj4gIC0gQWRkIE1PRFVMRV9ERVNDUklQVElPTiBpbiB0aGUgIkFTb0M6IFNP
RjogSW50ZWw6IGhkYS1zZHctYnB0OiBhZGQNCj4gICAgaGVscGVycyBmb3IgU291bmRXaXJlIEJQ
VCBETUEiIHBhdGNoLg0KPiANCj4gdjM6DQo+ICAtIENoYW5nZSBzZHdfY2Ruc193cml0ZV9wZGkx
X2J1ZmZlcl9zaXplIGFuZA0KPiAgICBzZHdfY2Ruc19yZWFkX3BkaTBfYnVmZmVyX3NpemUgdG8g
c3RhdGljIHZhbHVlcy4NCj4gDQo+IHY0Og0KPiAgLSBSZXZpc2UgYnJhLnJzdCBhcyBzdWdnZXN0
ZWQuDQo+IA0KPiBCYXJkIExpYW8gKDEpOg0KPiAgIEFTb0M6IFNPRjogSW50ZWw6IGhkYS1zZHct
YnB0OiBhZGQgQ0hBSU5fRE1BIHN1cHBvcnQNCj4gDQo+IFBpZXJyZS1Mb3VpcyBCb3NzYXJ0ICgx
NSk6DQo+ICAgRG9jdW1lbnRhdGlvbjogZHJpdmVyOiBhZGQgU291bmRXaXJlIEJSQSBkZXNjcmlw
dGlvbg0KPiAgIHNvdW5kd2lyZTogY2FkZW5jZTogYWRkIEJUUCBzdXBwb3J0IGZvciBEUDANCj4g
ICBzb3VuZHdpcmU6IGV4dGVuZCBzZHdfc3RyZWFtX3R5cGUgdG8gQlBUDQo+ICAgc291bmR3aXJl
OiBzdHJlYW06IGV4dGVuZCBzZHdfYWxsb2Nfc3RyZWFtKCkgdG8gdGFrZSAndHlwZScgcGFyYW1l
dGVyDQo+ICAgc291bmR3aXJlOiBzdHJlYW06IHNwZWNpYWwtY2FzZSB0aGUgYnVzIGNvbXB1dGVf
cGFyYW1zKCkgcm91dGluZQ0KPiAgIHNvdW5kd2lyZTogc3RyZWFtOiByZXVzZSBleGlzdGluZyBj
b2RlIGZvciBCUFQgc3RyZWFtDQo+ICAgc291bmR3aXJlOiBidXM6IGFkZCBzZW5kX2FzeW5jL3dh
aXQgQVBJcyBmb3IgQlBUIHByb3RvY29sDQo+ICAgc291bmR3aXJlOiBidXM6IGFkZCBicHRfc3Ry
ZWFtIHBvaW50ZXINCj4gICBzb3VuZHdpcmU6IGNhZGVuY2U6IGFkZCBCVFAvQlJBIGhlbHBlcnMg
dG8gZm9ybWF0IGRhdGENCj4gICBzb3VuZHdpcmU6IGludGVsX2F1eGRldmljZTogYWRkIGluZGly
ZWN0aW9uIGZvciBCUFQgc2VuZF9hc3luYy93YWl0DQo+ICAgQVNvQzogU09GOiBJbnRlbDogaGRh
LXNkdy1icHQ6IGFkZCBoZWxwZXJzIGZvciBTb3VuZFdpcmUgQlBUIERNQQ0KPiAgIHNvdW5kd2ly
ZTogaW50ZWw6IGFkZCBCUFQgY29udGV4dCBkZWZpbml0aW9uDQo+ICAgc291bmR3aXJlOiBpbnRl
bF9hY2UyeDogYWRkIEJQVCBzZW5kX2FzeW5jL3dhaXQgY2FsbGJhY2tzDQo+ICAgc291bmR3aXJl
OiBkZWJ1Z2ZzOiBhZGQgaW50ZXJmYWNlIGZvciBCUFQvQlJBIHRyYW5zZmVycw0KPiAgIEFTb0M6
IHJ0NzExLXNkY2E6IGFkZCBEUDAgc3VwcG9ydA0KDQpUZXN0ZWQtYnk6IHNodW1pbmdmQHJlYWx0
ZWsuY29tDQoNCg0K

