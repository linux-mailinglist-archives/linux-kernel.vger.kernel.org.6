Return-Path: <linux-kernel+bounces-218894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB87390C775
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D88A284D80
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15764154441;
	Tue, 18 Jun 2024 08:55:09 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B998B15279F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718700908; cv=none; b=p9M/cyeaUDtWmiJVLlI8123T1sp353lK4ZU3OI68xV79O1Hc56c2yp2h5deVloSvY6k95e5EfFAjPsFn/W/SA/we0CB6iqXkilfV+kAMJkcEQOyEepKjuB9zKb8rkS3sNC9JTRR9w3YkEm7Zk8H7yZiY+Az9APUkEecJAHRlOpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718700908; c=relaxed/simple;
	bh=y8PlvAU0VgR0chUfVvr0YAEdh9nUXiMnlakGuwQBFVw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H5NQSIm3RVNwF2V/LVjYvgaw1MT1GDEgnFURONrOYSRZK0DDP/WhkWuomlBFh5IV7yxdQp7VDHdHMXuAjw3BoAQ+ry59ogAkpGEYZilwfuXfOVVAaMvkOyM9xqZElUhB5e53Tifx56T233ePTN2eT3gqFWvG3IgZigXFFSE/Q0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?UkU6IFvlpJbpg6jpgq7ku7ZdIFJlOiBbUEFUQ0hdIHZpcnQvY29jby9zZXYt?=
 =?utf-8?Q?guest:_Don't_free_decrypted_memory?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF0gdmlydC9jb2NvL3Nldi1ndWVz?=
 =?utf-8?Q?t:_Don't_free_decrypted_memory?=
Thread-Index: AQHavhkyJwKNO1r6RkCvvJYikUlP1LHG5/6AgAZVRNA=
Date: Tue, 18 Jun 2024 08:53:37 +0000
Message-ID: <3d379ec5fe19499ca456e1b842ddf3b5@baidu.com>
References: <20240614051036.41983-1-lirongqing@baidu.com>
 <a5326e77-bb19-a92f-6beb-7d2c64866891@amd.com>
In-Reply-To: <a5326e77-bb19-a92f-6beb-7d2c64866891@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.53
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 52:10:53:SYSTEM

PiBPbiA2LzE0LzI0IDAwOjEwLCBMaSBSb25nUWluZyB3cm90ZToNCj4gPiBJbiBDb0NvIFZNcywg
aXQgaXMgcG9zc2libGUgZm9yIHRoZSB1bnRydXN0ZWQgaG9zdCB0byBjYXVzZQ0KPiA+IHNldF9t
ZW1vcnlfZGVjcnlwdGVkKCkgdG8gZmFpbCBzdWNoIHRoYXQgYW4gZXJyb3IgaXMgcmV0dXJuZWQg
YW5kIHRoZQ0KPiA+IHJlc3VsdGluZyBtZW1vcnkgaXMgc2hhcmVkLiBDYWxsZXJzIG5lZWQgdG8g
dGFrZSBjYXJlDQo+IA0KPiBDYW4geW91IGV4cGxhaW4gaG93IGl0IHdvdWxkIGZhaWwgb3Igd2hl
cmUgaW4gdGhlIGNhbGwgcGF0aCBpdCB3b3VsZCBmYWlsPw0KPiBBcmUgeW91IHJlZmVycmluZyB0
byB0aGUgdGhlIFBhZ2UgU3RhdGUgQ2hhbmdlIGJlaW5nIHBlcmZvcm1lZCBieSB0aGUgaG9zdCBi
dXQNCj4gaXQgcmV0dXJucyBhIGZhaWx1cmU/DQo+IA0KPiBBcyBsb25nIGFzIHRoZSBlbmNyeXB0
aW9uIGJpdCBoYXNuJ3QgYmVlbiBjbGVhcmVkIGluIGFueSBvZiB0aGUgZ3Vlc3QgcGFnZXRhYmxl
cw0KPiBmb3IgdGhlIHBhZ2UgcmFuZ2UsIHRoZW4gdGhlcmUgc2hvdWxkIG5vdCBiZSBhbiBpc3N1
ZS4gV2hlbiB0aGUgcGFnZSBpcw0KPiByZWZlcmVuY2VkIGl0IHdpbGwgZ2VuZXJhdGUgYSAjTlBG
IGFuZCB0aGUgaG9zdCB3aWxsIGhhdmUgdG8gbWFrZSB0aGF0IHBhZ2UgYQ0KPiBwcml2YXRlIHBh
Z2UgaW4gb3JkZXIgZm9yIGZvcndhcmQgcHJvZ3Jlc3MgdG8gYmUgbWFkZS4gQnV0LCB0aGF0IHBh
Z2Ugd2lsbA0KPiBhbHJlYWR5IGhhdmUgYmVlbiBQVkFMSURBVEVkIHByZXZpb3VzbHksIHNvIHRo
ZSByZXN1bHRpbmcgI1ZDIGZvciB0aGUgcGFnZSBubw0KPiBsb25nZXIgYmVpbmcgUFZBTElEQVRF
ZCB3aWxsIGFsbG93IHRoZSBndWVzdCB0byBkZXRlY3QgdGhlIG1hbGljaW91cyBoeXBlcnZpc29y
DQo+IGFuZCB0ZXJtaW5hdGUuDQo+IA0KPiBJZiB3ZSBmYWlsIGR1cmluZyB0aGUgX19jaGFuZ2Vf
cGFnZV9hdHRyX3NldF9jbHIoKSBjYWxsIGFuZCB3ZSBnZXQgYSBtaXggb2YNCj4gcGFnZXRhYmxl
IGVudHJpZXMgdGhhdCBjb3VsZCBiZSBhIHByb2JsZW0sIHNvIGxlYWtpbmcgdGhlIHBhZ2VzIHdv
dWxkIGJlIGJlc3QgaW4NCj4gdGhhdCBjYXNlLg0KPiANCj4gQW5kIHNpbmNlIHRoZSBmYWlsdXJl
IHJlYXNvbiBpc24ndCBjbGVhciBhZnRlciB0aGUgY2FsbCwgbGVha2luZyB0aGUgcGFnZXMgaXMN
Cj4gcHJvYmFibHkgdGhlIHNhZmVzdCB0aGluZy4NCg0KDQp5b3VyIGV4cGxhbmF0aW9uIGlzIHZl
cnkgY2xlYXIgOyBJIHdpbGwgcmV3cml0ZSB0aGlzIGNoYW5nZWxvZw0KDQp0aGFuayB5b3UgdmVy
eSBtdWNoLA0KDQotTGkNCg==

