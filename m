Return-Path: <linux-kernel+bounces-216740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0A990A5BB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2DC2855BA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 06:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D588186288;
	Mon, 17 Jun 2024 06:28:25 +0000 (UTC)
Received: from out28-100.mail.aliyun.com (out28-100.mail.aliyun.com [115.124.28.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAF6DDAD
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718605705; cv=none; b=IxRJ39enxaJyPPoTHBQaFgXO6AeHqLHNnn/5izbL0XsVJ4JtV5QbPevmvBzc1x93j1sgmgfW54s0k0X0/o4WHDBMacR6NM2877iteUH14gC0vfBVBX/XkkaoqkmZItUBpdW9lqa5FjZBOw6/KzcnGlSIXzMDWrsbTaorDQ4gai8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718605705; c=relaxed/simple;
	bh=bxuv+KRLC4+RGQNNNfVBzHItWpX86UHlafkvArXBMaw=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=qmJ72xZG/bNYpxmmDRsjQilUnZN24mWUv7Ukh0+yOChvgN7NBLh8QWiLDCMURWef5gtlV6sNsqF6+Vrm/U06C4EadwzZu+NyRZMugelf++Qlc0+VRhyA5EEDgeSQ/LhYRxdx8+0PosnZ9L+4nZ9CtJg3jYJQuO1TNdshx4ofia4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ubisectech.com; spf=pass smtp.mailfrom=ubisectech.com; arc=none smtp.client-ip=115.124.28.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ubisectech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ubisectech.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07386803|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.242902-0.000759734-0.756338;FP=0|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037088118;MF=bugreport@ubisectech.com;NM=1;PH=DW;RN=6;RT=6;SR=0;TI=W4_0.2.3_v5ForWebDing_21126CAB_1718605112440_o7001c878;
Received: from WS-web (bugreport@ubisectech.com[W4_0.2.3_v5ForWebDing_21126CAB_1718605112440_o7001c878]) at Mon, 17 Jun 2024 14:22:53 +0800
Date: Mon, 17 Jun 2024 14:22:53 +0800
From: "Ubisectech Sirius" <bugreport@ubisectech.com>
To: "Dave Airlie" <airlied@gmail.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
  "maarten.lankhorst" <maarten.lankhorst@linux.intel.com>,
  "mripard" <mripard@kernel.org>,
  "tzimmermann" <tzimmermann@suse.de>,
  "dri-devel" <dri-devel@lists.freedesktop.org>
Reply-To: "Ubisectech Sirius" <bugreport@ubisectech.com>
Message-ID: <bf3fa1c7-5fea-4db6-b7df-e7e19b336f27.bugreport@ubisectech.com>
Subject: =?UTF-8?B?5Zue5aSN77yaV0FSTklORyBpbiBkcm1fbW9kZV9jcmVhdGVfbGVhc2VfaW9jdGw=?=
X-Mailer: [Alimail-Mailagent][W4_0.2.3][v5ForWebDing][Chrome]
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"mailThroughImNew":true}
References: <CAPM=9twiDQ0Yv8p-oWWWZnnFViMiN79U6VGSC-wisSE-oYOEqg@mail.gmail.com>
x-aliyun-mail-creator: W4_0.2.3_v5ForWebDing_M3LTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEyNS4wLjAuMCBTYWZhcmkvNTM3LjM2vN
In-Reply-To: <CAPM=9twiDQ0Yv8p-oWWWZnnFViMiN79U6VGSC-wisSE-oYOEqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

PiBDYydpbmcgZHJpLWRldmVsCgo+IERvZXMgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvZHJpLWRl
dmVsLzIwMjQwNjE3MDM1MjU4LjI3NzQwMzItMS1haXJsaWVkQGdtYWlsLmNvbS9ULyN1Cj4gaGVs
cD8KCj4gVGhhbmtzLAoKPiBEYXZlLgoKSGkuIFRoZSBpc3N1ZSBkb2VzIG5vdCBhcHBlYXIgYWZ0
ZXIgYXBwbGllZCB0aGUgcGF0Y2guCgo+IE9uIE1vbiwgMTcgSnVuIDIwMjQgYXQgMTM6MTIsIFVi
aXNlY3RlY2ggU2lyaXVzCj4gPGJ1Z3JlcG9ydEB1YmlzZWN0ZWNoLmNvbT4gd3JvdGU6Cj4+Cj4+
IEhlbGxvLgo+PiBXZSBhcmUgVWJpc2VjdGVjaCBTaXJpdXMgVGVhbSwgdGhlIHZ1bG5lcmFiaWxp
dHkgbGFiIG9mIENoaW5hIFZhbGlhbnRTZWMuIFJlY2VudGx5LCBvdXIgdGVhbSBoYXMgZGlzY292
ZXJlZCBhIGlzc3VlIGluIExpbnV4IGtlcm5lbCA2LjguwqAgQXR0YWNoZWQgdG8gdGhlIGVtYWls
IHdlcmUgYSBQb0MgZmlsZSBvZiB0aGUgaXNzdWUuCj4+Cj4+IFN0YWNrIGR1bXA6Cj4+Cj4+IC0t
LS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQo+PiBXQVJOSU5HOiBDUFU6IDEgUElE
OiAxODkyOSBhdCBtbS9wYWdlX2FsbG9jLmM6NDU0NSBfX2FsbG9jX3BhZ2VzKzB4NDAyLzB4MjFi
MCBtbS9wYWdlX2FsbG9jLmM6NDU0NQo+PiBNb2R1bGVzIGxpbmtlZCBpbjoKPj4gQ1BVOiAxIFBJ
RDogMTg5MjkgQ29tbTogc3l6LWV4ZWN1dG9yLjMgTm90IHRhaW50ZWQgNi44LjAgIzEKPj4gSGFy
ZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1Mg
MS4xNS4wLTEgMDQvMDEvMjAxNAo+PiBSSVA6IDAwMTA6X19hbGxvY19wYWdlcysweDQwMi8weDIx
YjAgbW0vcGFnZV9hbGxvYy5jOjQ1NDUKPj4gQ29kZTogZmYgMDAgMGYgODQgMTUgZmUgZmYgZmYg
ODAgY2UgMDEgZTkgMGQgZmUgZmYgZmYgODMgZmUgMGEgMGYgODYgMGUgZmQgZmYgZmYgODAgM2Qg
YzcgY2YgNmEgMGQgMDAgNzUgMGIgYzYgMDUgYmUgY2YgNmEgMGQgMDEgOTAgPDBmPiAwYiA5MCA0
NSAzMSBlNCBlOSA4NyBmZSBmZiBmZiBlOCA1ZSAzZSA5YiBmZiA4NCBjMCAwZiA4NSA3YSBmZQo+
PiBSU1A6IDAwMTg6ZmZmZmM5MDAwMWNjNzgwOCBFRkxBR1M6IDAwMDEwMjQ2Cj4+IFJBWDogMDAw
MDAwMDAwMDAwMDAwMCBSQlg6IDAwMDAwMDAwMDAwMDAwMDAgUkNYOiAxZmZmZjkyMDAwMzk4ZjE0
Cj4+IFJEWDogMDAwMDAwMDAwMDAwMDAwMSBSU0k6IDAwMDAwMDAwMDAwMDAwMGIgUkRJOiAwMDAw
MDAwMDAwMDQwZGMwCj4+IFJCUDogZmZmZmM5MDAwMWNjN2FiOCBSMDg6IDAwMDAwMDAwMDAwMDAw
MDcgUjA5OiAwMDAwMDAwMDAwMDAwMDAwCj4+IFIxMDogMDAwMDAwMDAwMDAwMDAwMCBSMTE6IDAw
MDAwMDAwMDAwMDAwMDAgUjEyOiAwMDAwMDAwMDAwN2ExMjAwCj4+IFIxMzogMDAwMDAwMDAwMDAw
MDAwYiBSMTQ6IDAwMDAwMDAwMDAwNDBkYzAgUjE1OiAwMDAwMDAwMDAwMDAwMDBiCj4+IEZTOsKg
IDAwMDA3ZjE3MTdiYTU2NDAoMDAwMCkgR1M6ZmZmZjg4ODA3ZWMwMDAwMCgwMDAwKSBrbmxHUzow
MDAwMDAwMDAwMDAwMDAwCj4+IENTOsKgIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAw
MDAwMDgwMDUwMDMzCj4+IENSMjogMDAwMDAwMDAyMDNkMDAwMCBDUjM6IDAwMDAwMDAwMWY1YzAw
MDAgQ1I0OiAwMDAwMDAwMDAwNzUwZWYwCj4+IERSMDogMDAwMDAwMDAwMDAwMDAwMCBEUjE6IDAw
MDAwMDAwMDAwMDAwMDAgRFIyOiAwMDAwMDAwMDAwMDAwMDAwCj4+IERSMzogMDAwMDAwMDAwMDAw
MDAwMCBEUjY6IDAwMDAwMDAwZmZmZTBmZjAgRFI3OiAwMDAwMDAwMDAwMDAwNDAwCj4+IFBLUlU6
IDU1NTU1NTU0Cj4+IENhbGwgVHJhY2U6Cj4+wqAgPFRBU0s+Cj4+wqAgX19hbGxvY19wYWdlc19u
b2RlIGluY2x1ZGUvbGludXgvZ2ZwLmg6MjM4IFtpbmxpbmVdCj4+wqAgYWxsb2NfcGFnZXNfbm9k
ZSBpbmNsdWRlL2xpbnV4L2dmcC5oOjI2MSBbaW5saW5lXQo+PsKgIF9fa21hbGxvY19sYXJnZV9u
b2RlKzB4ODgvMHgxYTAgbW0vc2x1Yi5jOjM5MjYKPj7CoCBfX2RvX2ttYWxsb2Nfbm9kZSBtbS9z
bHViLmM6Mzk2OSBbaW5saW5lXQo+PsKgIF9fa21hbGxvYysweDM3MC8weDQ4MCBtbS9zbHViLmM6
Mzk5NAo+PsKgIGttYWxsb2NfYXJyYXkgaW5jbHVkZS9saW51eC9zbGFiLmg6NjI3IFtpbmxpbmVd
Cj4+wqAga2NhbGxvYyBpbmNsdWRlL2xpbnV4L3NsYWIuaDo2NTggW2lubGluZV0KPj7CoCBmaWxs
X29iamVjdF9pZHIgZHJpdmVycy9ncHUvZHJtL2RybV9sZWFzZS5jOjM4OSBbaW5saW5lXQo+PsKg
IGRybV9tb2RlX2NyZWF0ZV9sZWFzZV9pb2N0bCsweDRjYS8weDFmNzAgZHJpdmVycy9ncHUvZHJt
L2RybV9sZWFzZS5jOjUyMgo+PsKgIGRybV9pb2N0bF9rZXJuZWwrMHgxZWIvMHgzZjAgZHJpdmVy
cy9ncHUvZHJtL2RybV9pb2N0bC5jOjc0NAo+PsKgIGRybV9pb2N0bCsweDU4Mi8weGI3MCBkcml2
ZXJzL2dwdS9kcm0vZHJtX2lvY3RsLmM6ODQxCj4+wqAgdmZzX2lvY3RsIGZzL2lvY3RsLmM6NTEg
W2lubGluZV0KPj7CoCBfX2RvX3N5c19pb2N0bCBmcy9pb2N0bC5jOjg3MSBbaW5saW5lXQo+PsKg
IF9fc2Vfc3lzX2lvY3RsIGZzL2lvY3RsLmM6ODU3IFtpbmxpbmVdCj4+wqAgX194NjRfc3lzX2lv
Y3RsKzB4MWExLzB4MjEwIGZzL2lvY3RsLmM6ODU3Cj4+wqAgZG9fc3lzY2FsbF94NjQgYXJjaC94
ODYvZW50cnkvY29tbW9uLmM6NTIgW2lubGluZV0KPj7CoCBkb19zeXNjYWxsXzY0KzB4ZDUvMHgy
NzAgYXJjaC94ODYvZW50cnkvY29tbW9uLmM6ODMKPj7CoCBlbnRyeV9TWVNDQUxMXzY0X2FmdGVy
X2h3ZnJhbWUrMHg2Zi8weDc3Cj4+IFJJUDogMDAzMzoweDdmMTcxNmU4ZWVlZAo+PiBDb2RlOiBj
MyBlOCA5NyAyYiAwMCAwMCAwZiAxZiA4MCAwMCAwMCAwMCAwMCBmMyAwZiAxZSBmYSA0OCA4OSBm
OCA0OCA4OSBmNyA0OCA4OSBkNiA0OCA4OSBjYSA0ZCA4OSBjMiA0ZCA4OSBjOCA0YyA4YiA0YyAy
NCAwOCAwZiAwNSA8NDg+IDNkIDAxIGYwIGZmIGZmIDczIDAxIGMzIDQ4IGM3IGMxIGIwIGZmIGZm
IGZmIGY3IGQ4IDY0IDg5IDAxIDQ4Cj4+IFJTUDogMDAyYjowMDAwN2YxNzE3YmE1MDI4IEVGTEFH
UzogMDAwMDAyNDYgT1JJR19SQVg6IDAwMDAwMDAwMDAwMDAwMTAKPj4gUkFYOiBmZmZmZmZmZmZm
ZmZmZmRhIFJCWDogMDAwMDdmMTcxNmZlM2Y4MCBSQ1g6IDAwMDA3ZjE3MTZlOGVlZWQKPj4gUkRY
OiAwMDAwMDAwMDIwMDAwM2MwIFJTSTogMDAwMDAwMDBjMDE4NjRjNiBSREk6IDAwMDAwMDAwMDAw
MDAwMDMKPj4gUkJQOiAwMDAwN2YxNzE2ZjEzMDE0IFIwODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6
IDAwMDAwMDAwMDAwMDAwMDAKPiBSMTA6IDAwMDAwMDAwMDAwMDAwMDAgUjExOiAwMDAwMDAwMDAw
MDAwMjQ2IFIxMjogMDAwMDAwMDAwMDAwMDAwMAo+IFIxMzogMDAwMDAwMDAwMDAwMDAwYiBSMTQ6
IDAwMDA3ZjE3MTZmZTNmODAgUjE1OiAwMDAwN2YxNzE3Yjg1MDAwCj4+wqAgPC9UQVNLPgo+Pgo+
Pgo+PiBUaGFuayB5b3UgZm9yIHRha2luZyB0aGUgdGltZSB0byByZWFkIHRoaXMgZW1haWwgYW5k
IHdlIGxvb2sgZm9yd2FyZCB0byB3b3JraW5nIHdpdGggeW91IGZ1cnRoZXIuCj4+Cj4+Cj4+Cj4+
Cj4+Cj4+Cj4+Cj4+Cj4+Cj4+

