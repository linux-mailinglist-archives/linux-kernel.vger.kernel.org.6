Return-Path: <linux-kernel+bounces-528136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C19A413F7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 04:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC81A1887644
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D9019CCEA;
	Mon, 24 Feb 2025 03:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="C+dvIbRi"
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1027C4C8F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 03:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740367496; cv=none; b=mZpfOYoJ7ksG2bMxu24wiwHQTUtAgqPSO3mz3CikR+40V8ZIEHTbWLvhmoikA3Ii7ku7nbOylIPTdcXA7A5eKnta5jZGEz1+ftDkllAMY6zjv6OIuwEt+XfRONJQXHtjtdXy/DmRxj4i9dqj1Wpw0dqcWEhuTguXQ8eJdkklaUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740367496; c=relaxed/simple;
	bh=oxZb3NGR4x3YYL/zZagdSQa6mqqbAyNLJv61QzOZ4Io=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=h7dNd0ukZjTHk7wZ3HghFygEHlQegTjlMFVA1z4O3xuf3l+M6zJoj9zP1O62bigWHOge3cVrXJaV6LkwDGxl5vzumzXJtHhIrnCpcirU2VcpNPNlO3qgpEsQsI8EMDvk8xvHQ87TxuQZftU7mowxHjEA8UcUP/kWGTCgsoL6e9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=C+dvIbRi reason="signature verification failed"; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
X-QQ-mid: bizesmtp81t1740367425tg4asb5k
X-QQ-Originating-IP: ZkaKH/ISpVdkmt68KPcNZokERWIJF0eZeUbkPJ3qMZc=
Received: from m16.mail.163.com ( [220.197.31.2])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 24 Feb 2025 11:23:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14636056029384634111
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=ye3RU8vT1u8/qsJfOrpGN+ECvbBKWobIPkH89ZQnQNA=; b=C
	+dvIbRiBYT0H6luww6kHiV/jCZystX3gLDe2kkMk6hqPVOz41dl8MHa+07/IUmeq
	LR7FZMBdOVNAvxfpne5WONTgTQPXGrydGUlNMUCZMOEPgt4CUdgRzHtmzDUU2pjy
	vKixDI7xeKhAV/L6r0EUaiO64jgjeyRnbGcU21CpTQ=
Received: from kxwang23$m.fudan.edu.cn (
 [2001:da8:8001:864:ec9b:b92c:3d64:f9df] ) by ajax-webmail-wmsvr-40-124
 (Coremail) ; Mon, 24 Feb 2025 11:23:06 +0800 (CST)
Date: Mon, 24 Feb 2025 11:23:06 +0800 (CST)
From: "Kaixin Wang" <kxwang23@m.fudan.edu.cn>
To: "Kaixin Wang" <kxwang23@m.fudan.edu.cn>
Cc: sre@kernel.org, andriy.shevchenko@linux.intel.com, rdunlap@infradead.org,
	linux-kernel@vger.kernel.org, 21210240012@m.fudan.edu.cn,
	21302010073@m.fudan.edu.cn
Subject: Re:[PATCH v3] HSI: ssi_protocol: Fix use after free vulnerability
 in ssi_protocol Driver Due to Race Condition
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <20240918120749.1730-1-kxwang23@m.fudan.edu.cn>
References: <20240918120749.1730-1-kxwang23@m.fudan.edu.cn>
X-NTES-SC: AL_Qu2fAv+duEsj4CGaY+kXn0kbjug3WcW0u/0k3oJUNps0kyTu/R4+QG5DHXLr0fmmNRqmoQmsdxx01dxzUYVXYbkExNIpBpRvPEakkvw/1lmR
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <88CA06F7CB097DC8+6c5e0521.3de0.19535fad611.Coremail.kxwang23@m.fudan.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:fCgvCgD33vka5rtnzmJuAA--.36873W
X-CM-SenderInfo: zprtkiiuqyikitw6il2tof0z/1tbiTRP52Ge2ZWjwKQATsp
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:m.fudan.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: M9cU/d9r+frhYhEpBWZfUO9u4i1IfahZdeMqkyIl0kxizSBdz5IhanUP
	A8V/cmeqOxiBokrSrQseaJf7U6OqP0CZc9GhkmeOFwx+TT6H7x18R9nzhyyS0bFxHRtIZXd
	DGSr19xC5sanTP2pB2KcjhxGAb0fZXyROww6/qun6NEkr1boqOLpAwm9Vi3HgkzP9mpnZeR
	c4h6NK7mEAxlA2zClxZr0C8fhQPOIl9u8H7l77SjVCGgB9whBivSoUNjkv7L1oo6CnhOPIs
	5HNRKWzHinjlernZSwOWZy/q+S/cSJ1SZdYNMmigswqaAM8rI0sk3X9iOADAb6SVUXilA1D
	+GcIKj0EjkfLvt04QLcqhq1EaayBl/++xZZrimtpzzC1j7sb853y5ucFgSBZF9ACyceDOT1
	LeVDlU9XVbSu4sVMyKueiddoCSTAkdrTS9cTtHKbPmjDeqzi216SpZGNuIaMMLS2aN4Xxdc
	odI7Aok+u/AHTEJPgNE2EHFzsLBorvk7lnn6uFsVVjBjJa5+gVIcaEQa3y7Z1upVUwPbrVm
	5NXa0Qx1lMehQhQ/zNqd+M8ktWGTZ7vmzwecPVCOOAzyNzMhUGfQ8mtzHbVaWE+74wdH8uk
	NZJ1cCbe61U8w0m/aU3qIGWzTXoFu+boQ4BRcr0ULUCMKGx4yb92b0+KZ7tDXvWqWaAOr3j
	QG5cp895lUWpcGcjpKatjBVNACWijHKDdyv//nCzf/jDahXPdgXDfqbyPOpZmLaclqiNG4h
	9HHdr3gOSaSp4y+DAfL1+pPfXwMuxZvVhKDX4j9gcefvlAcu8b56PscqtEgT2tNB+vo2j3+
	ms0r+Q58BBap0Eig0/FIpENBrUHZrexVFkwphfoixdZyTEyy8bpv/IWBiPn6Uco4PCN2RxW
	de4OWMwWSSwSRnLN+yOP/8Wi4z3giBH4/ttf+A1YJ3VzL4bTQdknyMqLmXXUiObnujI9olz
	hXOZ71tj/+dS7MYeuK/1OmoS0YBoI3t/MDO0=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

CgpBdCAyMDI0LTA5LTE4IDIwOjA3OjUwLCAiS2FpeGluIFdhbmciIDxreHdhbmcyM0BtLmZ1ZGFu
LmVkdS5jbj4gd3JvdGU6Cj5JbiB0aGUgc3NpX3Byb3RvY29sX3Byb2JlKCkgZnVuY3Rpb24sICZz
c2ktPndvcmsgaXMgYm91bmQgd2l0aAo+c3NpcF94bWl0X3dvcmsoKSwgSW4gc3NpcF9wbl9zZXR1
cCgpLCB0aGUgc3NpcF9wbl94bWl0KCkgZnVuY3Rpb24KPndpdGhpbiB0aGUgc3NpcF9wbl9vcHMg
c3RydWN0dXJlIGlzIGNhcGFibGUgb2Ygc3RhcnRpbmcgdGhlCj53b3JrLgo+Cj5JZiB3ZSByZW1v
dmUgdGhlIG1vZHVsZSB3aGljaCB3aWxsIGNhbGwgc3NpX3Byb3RvY29sX3JlbW92ZSgpCj50byBt
YWtlIGEgY2xlYW51cCwgaXQgd2lsbCBmcmVlIHNzaSB0aHJvdWdoIGtmcmVlKHNzaSksCj53aGls
ZSB0aGUgd29yayBtZW50aW9uZWQgYWJvdmUgd2lsbCBiZSB1c2VkLiBUaGUgc2VxdWVuY2UKPm9m
IG9wZXJhdGlvbnMgdGhhdCBtYXkgbGVhZCB0byBhIFVBRiBidWcgaXMgYXMgZm9sbG93czoKPgo+
Q1BVMCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIENQVTEKPgo+ICAgICAgICAg
ICAgICAgICAgICAgICAgfCBzc2lwX3htaXRfd29yawo+c3NpX3Byb3RvY29sX3JlbW92ZSAgICAg
fAo+a2ZyZWUoc3NpKTsgICAgICAgICAgICAgfAo+ICAgICAgICAgICAgICAgICAgICAgICAgfCBz
dHJ1Y3QgaHNpX2NsaWVudCAqY2wgPSBzc2ktPmNsOwo+ICAgICAgICAgICAgICAgICAgICAgICAg
fCAvLyB1c2Ugc3NpCj4KPkZpeCBpdCBieSBlbnN1cmluZyB0aGF0IHRoZSB3b3JrIGlzIGNhbmNl
bGVkIGJlZm9yZSBwcm9jZWVkaW5nCj53aXRoIHRoZSBjbGVhbnVwIGluIHNzaV9wcm90b2NvbF9y
ZW1vdmUoKS4KPgo+U2lnbmVkLW9mZi1ieTogS2FpeGluIFdhbmcgPGt4d2FuZzIzQG0uZnVkYW4u
ZWR1LmNuPgo+QWNrZWQtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGlu
dXguaW50ZWwuY29tPgo+Cj4tLS0KPnYzOgo+LSByZWZlciB0byB0aGUgZnVuY3Rpb25zIGluIHRo
ZSBmb3JtIG9mIGZ1bmMoKSBpbiB0aGUgZGVzY3JpcHRpb24gbWVzc2FnZS4KPi0gTGluayB0byB2
MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0MDkxNDE3MjE0Mi4zMjgtMS1reHdhbmcy
M0BtLmZ1ZGFuLmVkdS5jbgo+djI6Cj4tIGNhbmNlbCB0aGUgd29yayBpbiBzc2lwX3Jlc2V0KCks
IHN1Z2dlc3RlZCBieSBTZWJhc3RpYW4KPi0gYWRkIHRoZSBBY2tlZC1ieSBsYWJlbCBmcm9tIEFu
ZHkKPi0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0MDkxMTE1MTkx
NS44NDQ5NTctMS1reHdhbmcyM0BtLmZ1ZGFuLmVkdS5jbgo+LS0tCj4gZHJpdmVycy9oc2kvY2xp
ZW50cy9zc2lfcHJvdG9jb2wuYyB8IDEgKwo+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KQo+Cj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9oc2kvY2xpZW50cy9zc2lfcHJvdG9jb2wuYyBiL2Ry
aXZlcnMvaHNpL2NsaWVudHMvc3NpX3Byb3RvY29sLmMKPmluZGV4IGFmZTQ3MGYzNjYxYy4uNjEw
NWVhOWE2YzZhIDEwMDY0NAo+LS0tIGEvZHJpdmVycy9oc2kvY2xpZW50cy9zc2lfcHJvdG9jb2wu
Ywo+KysrIGIvZHJpdmVycy9oc2kvY2xpZW50cy9zc2lfcHJvdG9jb2wuYwo+QEAgLTQwMSw2ICs0
MDEsNyBAQCBzdGF0aWMgdm9pZCBzc2lwX3Jlc2V0KHN0cnVjdCBoc2lfY2xpZW50ICpjbCkKPiAJ
ZGVsX3RpbWVyKCZzc2ktPnJ4X3dkKTsKPiAJZGVsX3RpbWVyKCZzc2ktPnR4X3dkKTsKPiAJZGVs
X3RpbWVyKCZzc2ktPmtlZXBfYWxpdmUpOwo+KwljYW5jZWxfd29ya19zeW5jKCZzc2ktPndvcmsp
Owo+IAlzc2ktPm1haW5fc3RhdGUgPSAwOwo+IAlzc2ktPnNlbmRfc3RhdGUgPSAwOwo+IAlzc2kt
PnJlY3Zfc3RhdGUgPSAwOwo+LS0gCj4yLjM5LjEud2luZG93cy4xCgo+CkhpLCBJIG5vdGljZWQg
dGhhdCB0aGVyZSBhcmUgbm8gcmVsZXZhbnQgcmVwbGllcyB0byB0aGlzIHBhdGNoIHRoYXQgSSBz
ZW50IHNldmVyYWwgbW9udGhzIGFnby4gSXMgaXQgbWlzc2VkPwoK

