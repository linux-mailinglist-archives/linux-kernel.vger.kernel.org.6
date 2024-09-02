Return-Path: <linux-kernel+bounces-310651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CC2967FA4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F20AC1C21DFB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934CF15688F;
	Mon,  2 Sep 2024 06:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="JnTHhCqP"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C2113C80E;
	Mon,  2 Sep 2024 06:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725259628; cv=none; b=mSdx4sOv4dBNHDFLAQoUS3wuwl5PhiFdcKsmyF3xT14E93nVVW4zX8NuzZspgVT0mxUbr1iv4zucxvj3K1GivVVzdVGR55ENpMmTioT8Nzz3eHvjgMt0s4nQLi7dExx3ZGdyDTaToeLR07D9T95nriIYEDMWQrdsqhsxQD17l44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725259628; c=relaxed/simple;
	bh=Ret7zFwxCYQcGF4d0fXMLdocIH0wzq4DLfMcNCBze+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=CpNfPYvREHSnDqx5oreAzKU8Iw/mKEBY/H8MkuLGWu2NAwZGNU8P16zEg9ZMAG90WshT+Y3dEUnAT8ZgqzGRpf1RRs+nyy+G3C+9vxnBBfNShC0Z/Lyf8Y5+Fk6Qcjlgjlnp/CXUiw0nzHr/NpsZiL3+B/39oEXdmfuenVwyDyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=JnTHhCqP reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=0xFQuaIPpT0coRgUUTskLytqClpw0Z8btfuptZXm+3w=; b=J
	nTHhCqP/UB6cpeGA4gvnWhrBs6tW3zfNDS27QcGN8Bgp82b5VV5qONAPVyakRyOE
	aDZ0qktL14UzXFGq4a3+01hEcz0/RTBCdGfzzk0n46mQiNO5S55bxZ1NEZdrQhJ4
	xkgRnt/gKfePV05TO7XmKcgs3nNKszHd9HjmlhuJvk=
Received: from slark_xiao$163.com ( [112.97.47.204] ) by
 ajax-webmail-wmsvr-40-143 (Coremail) ; Mon, 2 Sep 2024 14:46:04 +0800 (CST)
Date: Mon, 2 Sep 2024 14:46:04 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Greg KH" <gregkh@linuxfoundation.org>
Cc: "Johan Hovold" <johan@kernel.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re:Re: Re: Re: Re: [PATCH] USB: serial: option: add support for
 Foxconn T99W651
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <2024090237-pacemaker-natural-e0ff@gregkh>
References: <20240705081709.105496-1-slark_xiao@163.com>
 <Zoe3qBwWG33AZaU9@hovoldconsulting.com>
 <5b098485.965d.190822996fc.Coremail.slark_xiao@163.com>
 <Zoe7RT7o39C7iXmA@hovoldconsulting.com>
 <43cc2529.9d61.190823e694a.Coremail.slark_xiao@163.com>
 <2024070538-circling-ambiguity-908f@gregkh>
 <6c85e8f3.4bab.191b0e374ee.Coremail.slark_xiao@163.com>
 <2024090237-pacemaker-natural-e0ff@gregkh>
X-NTES-SC: AL_Qu2ZB/6etk0t5SmRYekfmk8Sg+84W8K3v/0v1YVQOpF8jC/rxA8yTV9qJ1fT6uWPMgypvjG+TwFc5vldb4Rber8LJE2CpuyFzurFtgbYiNI5wA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4669a740.6a05.191b17bc3e0.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3v8csX9VmoiRJAA--.3802W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiow5OZGVOFRisawACsk
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjQtMDktMDIgMTM6NTk6MjgsICJHcmVnIEtIIiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc+IHdyb3RlOgo+T24gTW9uLCBTZXAgMDIsIDIwMjQgYXQgMTE6NTk6NDJBTSArMDgwMCwg
U2xhcmsgWGlhbyB3cm90ZToKPj4gQXQgMjAyNC0wNy0wNSAxNzozOTo1NiwgIkdyZWcgS0giIDxn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6Cj4+ID5PbiBGcmksIEp1bCAwNSwgMjAy
NCBhdCAwNTozNDowNlBNICswODAwLCBTbGFyayBYaWFvIHdyb3RlOgo+PiA+PiAKPj4gPj4gQXQg
MjAyNC0wNy0wNSAxNzoyMjoxMywgIkpvaGFuIEhvdm9sZCIgPGpvaGFuQGtlcm5lbC5vcmc+IHdy
b3RlOgo+PiA+PiA+T24gRnJpLCBKdWwgMDUsIDIwMjQgYXQgMDU6MTE6MjJQTSArMDgwMCwgU2xh
cmsgWGlhbyB3cm90ZToKPj4gPj4gPgo+PiA+PiA+PiBJIGhhdmUgYSBjb25jZXJuIGFib3V0IHRo
ZSB0ZXN0IHJlc3VsdCBvZiAidXNiLWRldmljZXMiIGluIFVidW50dQo+PiA+PiA+PiAyMi4wNC4g
RG8geW91IGtub3cgd2h5IGl0IHdvdWxkbid0IHNob3cgb3VyIGRldmljZXMgYW55IG1vcmU/IAo+
PiA+PiA+Cj4+ID4+ID5Obywgc29ycnksIG5vIGlkZWEuIEV2ZXJ5dGhpbmcgc2VlbXMgdG8gd29y
ayBoZXJlIHdpdGggdGhlIGxhdGVzdAo+PiA+PiA+dXNidXRpbHMtMDE3Lgo+PiA+PiA+Cj4+ID4+
ID5JcyBpdCBqdXN0IHlvdXIgZGV2aWNlcyB0aGF0IG5vIGxvbmdlciBzaG93IHVwIG9yIGRvZXNu
J3QgaXQgd29yayBhdAo+PiA+PiA+YWxsPwo+PiA+PiA+Cj4+ID4+IEEgbG90IG9mIGRldmljZXMg
bWlzc2VkIGluIFVidW50dSAyMi4wNCwgZXNwZWNpYWxseSBmb3IgbW9kZW0gZGV2aWNlcy4KPj4g
Pj4gTm90aGluZyB3b3VsZCBiZSBwcmludGVkIGZvciBtb2RlbSBkZXZpY2VzLgo+PiA+Cj4+ID5X
aGF0IHNwZWNpZmljIHZlcnNpb24gb2YgdXNidXRpbHMgYXJlIHlvdSB1c2luZz8KPj4gPgo+PiA+
SWYgeW91IHB1bGwgZnJvbSB0aGUgZ2l0aHViIHJlcG8sIGNhbiB5b3UgdHJ5IHRoZSB2ZXJzaW9u
IHRoZXJlPwo+PiA+Cj4+ID5BbmQgaWYgdGhhdCBoYXMgcHJvYmxlbXMsIGEgZGlmZiBvZiBib3Ro
IHdvcmtpbmcgYW5kIG5vdC13b3JraW5nIHdvdWxkCj4+ID5iZSBncmVhdC4KPj4gPgo+PiA+dGhh
bmtzLAo+PiA+Cj4+ID5ncmVnIGstaAo+PiBIaSBHcmVnLAo+PiBJIHJlcHJvZHVjZWQgdGhpcyBp
c3N1ZSBhZ2Fpbi4gQW5kIG5vdyBJIGNoZWNrZWQgaXQgd2l0aCBkaWZmZXJlbnQgdXNidXRpbHMK
Pj4gdmVyc2lvbiBvbmUgYnkgb25lLiAgVmVyc2lvbiAwMTQgaGFzIHRoaXMgaXNzdWUuIEJvdGgg
MDEzIGFuZCAwMTUgd29ya3Mgd2VsbC4KPj4gUGxlYXNlIHNlZSBhdHRhY2hlZCBsb2c6Cj4KPlNv
IHRoaXMgaXMgZmluZSBub3cgd2l0aCB0aGUgbGF0ZXN0IHZlcnNpb24/ICBOb3RlIHRoYXQgMDE1
IHdhcyByZWxlYXNlZAo+d2F5IGJhY2sgaW4gMjAyMiBhbmQgdGhhdCBpcyBldmVuIHF1aXRlIG9s
ZCwgMDE3IGlzIHRoZSBsYXRlc3QgcmVsZWFzZQo+b2YgdXNidXRpbHMuCj4KPkEgcHJvYmxlbSBp
biB1c2ItZGV2aWNlcyB3YXMgZml4ZWQgaW4gdGhlIDAxNSByZWxlYXNlLCBkZWFsaW5nIHdpdGgK
PnJlY3Vyc2lvbiBhbmQgb3ZlcndyaXRpbmcgZXhpc3RpbmcgdmFyaWFibGVzLCBzbyBvZGRzIGFy
ZSB0aGF0IGlzIHdoYXQKPmZpeGVkIHRoZSBwcm9ibGVtIHlvdSB3ZXJlIGhhdmluZy4gIFBsZWFz
ZSBqdXN0IHVzZSB0aGF0IG9yIG5ld2VyIGFuZAo+YWxsIHNob3VsZCBiZSBmaW5lLgo+Cj50aGFu
a3MsCj4KPmdyZWcgay1oClllYWgsIG5vdyBJIGFtIHVzaW5nIFYwMTcuIEJUVywgdGhlIGRlZmF1
bHQgb2YgdXNidXRpbHMgb2YgVWJ1bnR1IDIyLjA0LjQgTFRTIGlzIDAxNC4KU28gbWF5IEkga25v
dyBkbyB5b3UgaGF2ZSBhbnkgcGxhbiB0byBmaXggaXQgc2luY2UgMjIuMDQgTFRTIHN0aWxsIHVu
ZGVyIG1haW50YWluLgoKVGhhbmtzCg==

