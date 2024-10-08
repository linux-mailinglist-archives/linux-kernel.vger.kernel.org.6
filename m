Return-Path: <linux-kernel+bounces-354370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 193E7993CB8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 04:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A659CB212BD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 02:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D901DFF8;
	Tue,  8 Oct 2024 02:13:36 +0000 (UTC)
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18D0184D
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 02:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728353615; cv=none; b=rkFsVuQWy/44bgHbBxGootBwIKQXtzigvQaslZcz7mSPHjewPqqVJUn4iznnR6cYvmw1OCvvLI2csLuksC3q/gWW4GMs7I+0leF20/d9a7RbAwf945BfK6R4D9d2Zca3mqUX2Roc5YZCABArld4wHt2QAsQ7SlkpRAgar/qMtfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728353615; c=relaxed/simple;
	bh=DzZT7mO4mkRCGt/zd77/7mwo1WpglM52tD222aB4QFw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HYHkeNQ2F/usQasmyc/+r9gS+QsxOqiAwSWgkqr/cDGvZkncgzTDzD3xOMEvwwoak17hq83Ut+2RpcpDvN776U0P2rf5WacSLajrfzy7zNtJAevDbOTgg1z++s0hO3LK+8wAnKxduhWxgoM6tmF5zY9H3BgbqzDCQzGHxuoGvgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: QStpQ35gRDmSz1Fgk/TOLA==
X-CSE-MsgGUID: LormPlrzQ2e211u92tuIBQ==
X-IronPort-AV: E=Sophos;i="6.11,185,1725292800"; 
   d="scan'208";a="123883873"
From: =?utf-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>
To: Frank van der Linden <fvdl@google.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: David Hildenbrand <david@redhat.com>, Xiang Gao <gxxa03070307@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtFeHRlcm5hbCBNYWlsXVJlOiBbUEFUQ0ggdjJd?=
 =?utf-8?B?IG1tL2NtYTogcHJpbnQgdG90YWwgYW5kIHVzZWQgY291bnQgaW4gY21hX2Fs?=
 =?utf-8?Q?loc()?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbRXh0ZXJuYWwgTWFpbF1SZTogW1BBVENIIHYyXSBtbS9jbWE6?=
 =?utf-8?Q?_print_total_and_used_count_in_cma=5Falloc()?=
Thread-Index: AQHbGSejUXqGmfuj+0Ctu2enzH7obQ==
Date: Tue, 8 Oct 2024 02:13:17 +0000
Message-ID: <65ba1fbcceb64cbdbf33b42787b447e9@xiaomi.com>
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

DQotLS0tLemCruS7tuWOn+S7ti0tLS0tDQrlj5Hku7bkuro6IEZyYW5rIHZhbiBkZXIgTGluZGVu
IDxmdmRsQGdvb2dsZS5jb20+IA0K5Y+R6YCB5pe26Ze0OiAyMDI05bm0MTDmnIg15pelIDY6NTYN
CuaUtuS7tuS6ujogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4NCuaK
hOmAgTog6auY57+UIDxnYW94aWFuZzE3QHhpYW9taS5jb20+OyBEYXZpZCBIaWxkZW5icmFuZCA8
ZGF2aWRAcmVkaGF0LmNvbT47IFhpYW5nIEdhbyA8Z3h4YTAzMDcwMzA3QGdtYWlsLmNvbT47IGxp
bnV4LW1tQGt2YWNrLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K5Li76aKYOiBS
ZTog5Zue5aSNOiBbRXh0ZXJuYWwgTWFpbF1SZTogW1BBVENIIHYyXSBtbS9jbWE6IHByaW50IHRv
dGFsIGFuZCB1c2VkIGNvdW50IGluIGNtYV9hbGxvYygpDQoNClvlpJbpg6jpgq7ku7ZdIOatpOmC
ruS7tuadpea6kOS6juWwj+exs+WFrOWPuOWklumDqO+8jOivt+iwqOaFjuWkhOeQhuOAguiLpeWv
uemCruS7tuWuieWFqOaAp+WtmOeWke+8jOivt+WwhumCruS7tui9rOWPkee7mW1pc2VjQHhpYW9t
aS5jb23ov5vooYzlj43ppogNCg0KT24gRnJpLCBPY3QgNCwgMjAyNCBhdCAzOjM54oCvUE0gQW5k
cmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+DQo+IE9uIEZy
aSwgNCBPY3QgMjAyNCAxMjoyMzozMCArMDAwMCDpq5jnv5QgPGdhb3hpYW5nMTdAeGlhb21pLmNv
bT4gd3JvdGU6DQo+DQo+ID4gPiA+ICtzdGF0aWMgdW5zaWduZWQgbG9uZyBjbWFfZ2V0X3VzZWRf
cGFnZXMoc3RydWN0IGNtYSAqY21hKSB7DQo+ID4gPiA+ICsgICAgIHVuc2lnbmVkIGxvbmcgdXNl
ZDsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICBzcGluX2xvY2tfaXJxKCZjbWEtPmxvY2spOw0K
PiA+ID4gPiArICAgICB1c2VkID0gYml0bWFwX3dlaWdodChjbWEtPmJpdG1hcCwgKGludCljbWFf
Yml0bWFwX21heG5vKGNtYSkpOw0KPiA+ID4gPiArICAgICBzcGluX3VubG9ja19pcnEoJmNtYS0+
bG9jayk7DQo+ID4gPg0KPiA+ID4gVGhpcyBhZGRzIG92ZXJoZWFkIHRvIGVhY2ggYWxsb2NhdGlv
biwgZXZlbiBpZiBkZWJ1ZyBvdXRwdXRzIGFyZSANCj4gPiA+IGlnbm9yZWQgSSBhc3N1bWU/DQo+
ID4gPg0KPiA+ID4gSSB3b25kZXIgaWYgd2UnZCB3YW50IHRvIHByaW50IHRoZXNlIGRldGFpbHMg
b25seSB3aGVuIG91ciANCj4gPiA+IGFsbG9jYXRpb24gZmFpbGVkPw0KPiA+ID4NCj4gPiA+IEFs
dGVybmF0aXZlbHksIHdlIGNvdWxkIGFjdHVhbGx5IHRyYWNrIGhvdyBtYW55IHBhZ2VzIGFyZSAN
Cj4gPiA+IGFsbG9jYXRlZCBpbiB0aGUgY21hLCBzbyB3ZSBkb24ndCBoYXZlIHRvIHRyYXZlcnNl
IHRoZSBjb21wbGV0ZSANCj4gPiA+IGJpdG1hcCBvbiBldmVyeSBhbGxvY2F0aW9uLg0KPiA+ID4N
Cj4gPg0KPiA+IFllcCwgdGhhdCdzIHdoYXQgSSBkaWQgYXMgcGFydCBvZg0KPiA+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDcyNDEyNDg0NS42MTRjMDNhZDM5ZjhhZjM3MjljZWJl
ZTZADQo+ID4gbGludXgtZm91bmRhdGlvbi5vcmcvVC8NCj4gPg0KPiA+IFRoYXQgcGF0Y2ggZGlk
bid0IG1ha2UgaXQgaW4gKHlldCkuIEknbSBoYXBweSBmb3IgaXQgdG8gYmUgY29tYmluZWQgd2l0
aCB0aGlzIG9uZSBpZiB0aGF0J3MgZWFzaWVyLg0KPg0KPiBUaGF0IHBhdGNoIGhhcyBiZWVuIGZv
cmdvdHRlbiBhYm91dC4gIEFzIEkgYXNrZWQgaW4gSnVseSwgIkkgc3VnZ2VzdCBhIA0KPiByZXNl
bmQsIGFuZCBhZGQgc29tZSBDYzpzIGZvciBsaWtlbHkgcmV2aWV3ZXJzLiINCg0KPiBJbmRlZWQg
LSBJIGNlcnRhaW5seSB3YXNuJ3Qgc3VnZ2VzdGluZyB0aGF0IGFueW9uZSBlbHNlIGZvcmdvdCBh
Ym91dCBpdCwgaXQncyB1cCB0byBtZSB0byBmb2xsb3cgdXAgaGVyZSwgYW5kIEkgaGF2ZW4ndCB5
ZXQuDQoNCkZvciBub3csIGl0J3MgYmV0dGVyIHRvIGFkZCBtZW1iZXJzIHRvICJzdHJ1Y3QgY21h
Ii4gRG8gSSBuZWVkIHRvIGNoYW5nZSBpdCBhZ2Fpbj8gDQo=

