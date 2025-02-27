Return-Path: <linux-kernel+bounces-535343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4182A4716A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCCCA7AEEE5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5933924B28;
	Thu, 27 Feb 2025 01:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Suf/RfRA"
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B58D1A254C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619897; cv=none; b=r+q9qY5cPBzvXsCVnukkBm6hBOpNQVU7Ce24PqS2ju4mgZpz9/3TwNdrx1ij1m/NHPgSMx3liAMWM9YAN45ILO8CAiRXzPFt9xGWXcvZwiKQf7s5l5Z/TQY2IDepcCkcFgyTBu8M6Ex8IXT+ynOqP0xxI6OYcRnxwLHyMs6mh5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619897; c=relaxed/simple;
	bh=ksjkcqmfhO4atwDj2POMFycYt1nSXkzfq5nmkO6iYyM=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JiOQq92RVH2B/H4AO35MR1HVcDoZOhJkA0XfGCF6QVj3LlT7j0QE20Z1rxJ3/NSTqd2I0ng0yOWnF9eVNHdfX9eSjzGGvn6S6dAI9jZgWd+NSvR2GfxGKCLHWiEH2xqzT2g00QOa7Qlp05PLb25jvzFJ9dTtYpzOFf4Ff61f3t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Suf/RfRA; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740619897; x=1772155897;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=ksjkcqmfhO4atwDj2POMFycYt1nSXkzfq5nmkO6iYyM=;
  b=Suf/RfRAj7r5mjTRaF2QHTnzFKqSS2hGnFdsa9T71kUwp7Pwsp7Klurm
   o+kxXQgzfnl8f6A5US7Heh5pJz1RK7K4CWTYHsofb3rKY2GpSuE5Nq4OD
   1hOA3ElAP1s7E8NMXdKFGqQl6xd6YP3ZxF1jWFVKXTuSfUtL6U2v/zLgj
   U=;
X-IronPort-AV: E=Sophos;i="6.13,318,1732579200"; 
   d="scan'208";a="274695816"
Subject: Re: [PATCH] MAINTAINERS: Update Intel LJCA maintainer
Thread-Topic: [PATCH] MAINTAINERS: Update Intel LJCA maintainer
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 01:31:33 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:21059]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.69:2525] with esmtp (Farcaster)
 id 34044be2-5924-4c2f-aaa5-07d674d3f0bc; Thu, 27 Feb 2025 01:31:31 +0000 (UTC)
X-Farcaster-Flow-ID: 34044be2-5924-4c2f-aaa5-07d674d3f0bc
Received: from EX19D005ANA002.ant.amazon.com (10.37.240.134) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 27 Feb 2025 01:31:31 +0000
Received: from EX19D005ANA003.ant.amazon.com (10.37.240.150) by
 EX19D005ANA002.ant.amazon.com (10.37.240.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 27 Feb 2025 01:31:30 +0000
Received: from EX19D005ANA003.ant.amazon.com ([fe80::9420:66b0:f4e3:8ec1]) by
 EX19D005ANA003.ant.amazon.com ([fe80::9420:66b0:f4e3:8ec1%8]) with mapi id
 15.02.1544.014; Thu, 27 Feb 2025 01:31:30 +0000
From: "Wu, Wentong" <wentongw@amazon.com>
To: "Zhang, Lixu" <lixu.zhang@intel.com>, Stanislaw Gruszka
	<stanislaw.gruszka@linux.intel.com>, Greg KH <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "brgl@bgdev.pl"
	<brgl@bgdev.pl>, "andi.shyti@kernel.org" <andi.shyti@kernel.org>,
	"broonie@kernel.org" <broonie@kernel.org>, "Wang, Zhifeng"
	<zhifeng.wang@intel.com>
Thread-Index: AQHbhEQbktrAP2Ov+k+5TsSlB7BYu7NRgbOAgAjidnCAAIgRgA==
Date: Thu, 27 Feb 2025 01:31:30 +0000
Message-ID: <72112D7B-8FAC-4106-BE13-9C6BE49650EE@amazon.com>
References: <20250221083713.25947-1-lixu.zhang@intel.com>
 <2025022134-storewide-greedy-8d4d@gregkh> <Z7hK2ZYt4K30ACc1@linux.intel.com>
 <DM4PR11MB59950B45B309F5A10301440793CD2@DM4PR11MB5995.namprd11.prod.outlook.com>
In-Reply-To: <DM4PR11MB59950B45B309F5A10301440793CD2@DM4PR11MB5995.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A57914F1B8C8D44AE4D2020447BBD66@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gMjAyNS8yLzI3LCAwOToyNiwgIlpoYW5nLCBMaXh1IiA8bGl4dS56aGFuZ0BpbnRlbC5jb20g
PG1haWx0bzpsaXh1LnpoYW5nQGludGVsLmNvbT4+IHdyb3RlOg0KPkZyb206IFN0YW5pc2xhdyBH
cnVzemthIDxzdGFuaXNsYXcuZ3J1c3prYUBsaW51eC5pbnRlbC5jb20gPG1haWx0bzpzdGFuaXNs
YXcuZ3J1c3prYUBsaW51eC5pbnRlbC5jb20+Pg0KPlNlbnQ6IEZyaWRheSwgRmVicnVhcnkgMjEs
IDIwMjUgNTo0NCBQTQ0KPlRvOiBHcmVnIEtIIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZyA8
bWFpbHRvOmdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPj4NCj5DYzogWmhhbmcsIExpeHUgPGxp
eHUuemhhbmdAaW50ZWwuY29tIDxtYWlsdG86bGl4dS56aGFuZ0BpbnRlbC5jb20+PjsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZyA8bWFpbHRvOmxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc+Ow0KPnNha2FyaS5haWx1c0BsaW51eC5pbnRlbC5jb20gPG1haWx0bzpzYWthcmkuYWlsdXNA
bGludXguaW50ZWwuY29tPjsgbGludXMud2FsbGVpakBsaW5hcm8ub3JnIDxtYWlsdG86bGludXMu
d2FsbGVpakBsaW5hcm8ub3JnPjsgYnJnbEBiZ2Rldi5wbCA8bWFpbHRvOmJyZ2xAYmdkZXYucGw+
Ow0KPmFuZGkuc2h5dGlAa2VybmVsLm9yZyA8bWFpbHRvOmFuZGkuc2h5dGlAa2VybmVsLm9yZz47
IGJyb29uaWVAa2VybmVsLm9yZyA8bWFpbHRvOmJyb29uaWVAa2VybmVsLm9yZz47IFdhbmcsIFpo
aWZlbmcNCj48emhpZmVuZy53YW5nQGludGVsLmNvbSA8bWFpbHRvOnpoaWZlbmcud2FuZ0BpbnRl
bC5jb20+PjsgV2VudG9uZyBXdSA8d2VudG9uZy53dUBpbnRlbC5jb20gPG1haWx0bzp3ZW50b25n
Lnd1QGludGVsLmNvbT4+DQo+U3ViamVjdDogUmU6IFtQQVRDSF0gTUFJTlRBSU5FUlM6IFVwZGF0
ZSBJbnRlbCBMSkNBIG1haW50YWluZXINCj4NCj5PbiBGcmksIEZlYiAyMSwgMjAyNSBhdCAxMDoz
NjowMkFNICswMTAwLCBHcmVnIEtIIHdyb3RlOg0KPj4gT24gRnJpLCBGZWIgMjEsIDIwMjUgYXQg
MDQ6Mzc6MTJQTSArMDgwMCwgWmhhbmcgTGl4dSB3cm90ZToNCj4+ID4gV2VudG9uZyBpcyBubyBs
b25nZXIgd2l0aCBJbnRlbCwgSSB3aWxsIHRha2Ugb3ZlciBhcyB0aGUgbWFpbnRhaW5lcg0KPj4g
PiBvZiB0aGUgSW50ZWwgTEpDQSBkcml2ZXIuDQo+PiA+DQo+PiA+IFNpZ25lZC1vZmYtYnk6IFpo
YW5nIExpeHUgPGxpeHUuemhhbmdAaW50ZWwuY29tIDxtYWlsdG86bGl4dS56aGFuZ0BpbnRlbC5j
b20+Pg0KPj4gPiBSZXZpZXdlZC1ieTogU3RhbmlzbGF3IEdydXN6a2EgPHN0YW5pc2xhdy5ncnVz
emthQGxpbnV4LmludGVsLmNvbSA8bWFpbHRvOnN0YW5pc2xhdy5ncnVzemthQGxpbnV4LmludGVs
LmNvbT4+DQo+PiA+IEFja2VkLWJ5OiBTYWthcmkgQWlsdXMgPHNha2FyaS5haWx1c0BsaW51eC5p
bnRlbC5jb20gPG1haWx0bzpzYWthcmkuYWlsdXNAbGludXguaW50ZWwuY29tPj4NCg0KQWNrZWQt
Ynk6IFdlbnRvbmcgV3UgPHdlbnRvbmd3QGFtYXpvbi5jb20+DQo+PiA+IC0tLQ0KPj4gPiBNQUlO
VEFJTkVSUyB8IDIgKy0NCj4+ID4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+PiA+DQo+PiA+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlO
RVJTIGluZGV4DQo+PiA+IGQ5ZmQ1NmYyMDVjMC4uZGEwOWY4NGE4N2IxIDEwMDY0NA0KPj4gPiAt
LS0gYS9NQUlOVEFJTkVSUw0KPj4gPiArKysgYi9NQUlOVEFJTkVSUw0KPj4gPiBAQCAtMTE4MTgs
NyArMTE4MTgsNyBAQCBGOiBkcml2ZXJzL2NyeXB0by9pbnRlbC9rZWVtYmF5L29jcy0NCj5oY3Uu
Yw0KPj4gPiBGOiBkcml2ZXJzL2NyeXB0by9pbnRlbC9rZWVtYmF5L29jcy1oY3UuaA0KPj4gPg0K
Pj4gPiBJTlRFTCBMQSBKT0xMQSBDT1ZFIEFEQVBURVIgKExKQ0EpIFVTQiBJL08gRVhQQU5ERVIg
RFJJVkVSUw0KPj4gPiAtTTogV2VudG9uZyBXdSA8d2VudG9uZy53dUBpbnRlbC5jb20gPG1haWx0
bzp3ZW50b25nLnd1QGludGVsLmNvbT4+DQo+PiA+ICtNOiBMaXh1IFpoYW5nIDxsaXh1LnpoYW5n
QGludGVsLmNvbSA8bWFpbHRvOmxpeHUuemhhbmdAaW50ZWwuY29tPj4NCj4+DQo+PiBXZW50b25n
IGFsc28gbmVlZHMgdG8gYWNrIHRoaXMsIGp1c3QgYmVjYXVzZSBzb21lb25lIGxlYXZlcyBhIGNv
bXBhbnkNCj4+IGRvZXMgbm90IG1lYW4gdGhleSBhdXRvbWF0aWNhbGx5IGxvb3NlIG1haW50YWlu
ZXJzaGlwLg0KPg0KPk5vdCBzdXJlIGhvdyB0byBjb25udGFjdCBoaW0sIGhpcyBpbnRlbCBlbWFp
bCBpcyBib3VuY2luZyBub3cgYW5kIGhlIGRpZCBub3QNCj5wcm92aWRlIGFsdGVybmF0aXZlIGVt
YWlsIGJlZm9yZSBoZSBsZWZ0Lg0KPg0KPlJlZ2FyZHMNCj5TdGFuaXNsYXcNCg0KDQoNCg==

