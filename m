Return-Path: <linux-kernel+bounces-242227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C765C92852A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB38288EBD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D34C146D55;
	Fri,  5 Jul 2024 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="StEScppJ"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41972146A8D;
	Fri,  5 Jul 2024 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172073; cv=none; b=aAWWGv6zFu0v/rOQyz+Q8hdDoQjpGOxGdfsyTxB18BjhlJW9c/PY1q39CL+o/AfPQuH5Uf+RPud7j0sHUcXeJWnzOpib3LnspoFMO4QQp+YqGQXHdlJ6MmglHvEknV+eWSxvOHLKWkv8SctfpegGd9OZatsIWkp+4ehRGhqiH5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172073; c=relaxed/simple;
	bh=TyCpmJTsMwpWUgraY8TFXsGwR6zitGR5vj88e/4zNvc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=gFYl5bb69/ulKFk3jfQDUmTcdXZNIMG2BzBNtWtB9VBSKAsj5D8/ooYE01OqvtVuw8kgSo2jeyLc8Wra14leNDZDe2X3xh0wYlgQ6bUzoMmSMk5YW9bIDXfPB0PG+5tli//iUPp/tyA1+h9LVdOkVjKaTAAYQLTa1U/wnJ0ZqBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=StEScppJ reason="signature verification failed"; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=NkLiOAdGhP0gtq/Mz/ex6V68WcmHTlmWQUzNDpbGy6E=; b=S
	tEScppJb3DUafOyVMmnb+2KmHTPeeT73WrN4Wa6t3F7IN/Ioym0KZOLLDszhOsCe
	XqZ+SXsGMXsBY+28Rp2rWJ+qqTd+GB6wpKza+UkjNcA5X9StI5idarRse1MGX8La
	BiqoskT2+Gkv2yEVoqg3c/IkXMbG0jDxC1rfALPEVo=
Received: from slark_xiao$163.com ( [223.104.68.157] ) by
 ajax-webmail-wmsvr-40-111 (Coremail) ; Fri, 5 Jul 2024 17:34:06 +0800 (CST)
Date: Fri, 5 Jul 2024 17:34:06 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Johan Hovold" <johan@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re:Re: Re: [PATCH] USB: serial: option: add support for Foxconn
 T99W651
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <Zoe7RT7o39C7iXmA@hovoldconsulting.com>
References: <20240705081709.105496-1-slark_xiao@163.com>
 <Zoe3qBwWG33AZaU9@hovoldconsulting.com>
 <5b098485.965d.190822996fc.Coremail.slark_xiao@163.com>
 <Zoe7RT7o39C7iXmA@hovoldconsulting.com>
X-NTES-SC: AL_Qu2ZAv2cvUgv4CaeZekfmk8Sg+84W8K3v/0v1YVQOpF8jDjp+j0MYERlA2nE9/KtDiu+jT6xbAlu2slFYrRcX6QNzL/M27ior+29Gi0TLoeIlg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <43cc2529.9d61.190823e694a.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3v0sOvodmMYUeAA--.26709W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiow0TZGVOEPiVBAAGsN
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjQtMDctMDUgMTc6MjI6MTMsICJKb2hhbiBIb3ZvbGQiIDxqb2hhbkBrZXJuZWwub3Jn
PiB3cm90ZToKPk9uIEZyaSwgSnVsIDA1LCAyMDI0IGF0IDA1OjExOjIyUE0gKzA4MDAsIFNsYXJr
IFhpYW8gd3JvdGU6Cj4KPj4gSSBoYXZlIGEgY29uY2VybiBhYm91dCB0aGUgdGVzdCByZXN1bHQg
b2YgInVzYi1kZXZpY2VzIiBpbiBVYnVudHUKPj4gMjIuMDQuIERvIHlvdSBrbm93IHdoeSBpdCB3
b3VsZG4ndCBzaG93IG91ciBkZXZpY2VzIGFueSBtb3JlPyAKPgo+Tm8sIHNvcnJ5LCBubyBpZGVh
LiBFdmVyeXRoaW5nIHNlZW1zIHRvIHdvcmsgaGVyZSB3aXRoIHRoZSBsYXRlc3QKPnVzYnV0aWxz
LTAxNy4KPgo+SXMgaXQganVzdCB5b3VyIGRldmljZXMgdGhhdCBubyBsb25nZXIgc2hvdyB1cCBv
ciBkb2Vzbid0IGl0IHdvcmsgYXQKPmFsbD8KPgpBIGxvdCBvZiBkZXZpY2VzIG1pc3NlZCBpbiBV
YnVudHUgMjIuMDQsIGVzcGVjaWFsbHkgZm9yIG1vZGVtIGRldmljZXMuCk5vdGhpbmcgd291bGQg
YmUgcHJpbnRlZCBmb3IgbW9kZW0gZGV2aWNlcy4KCj5QZXJoYXBzIGEgY2hhbmdlIGxpa2UgdGhp
cyBvbmUgY291bGQgYmUgaW52b2x2ZWQ6Cj4KPglodHRwczovL2dpdGh1Yi5jb20vZ3JlZ2toL3Vz
YnV0aWxzL2NvbW1pdC8zYjc5ZTljODY2YTE3ZjBhNTE3OGIzYjBiZWU2M2ZhYjU5YTAwMDNhCQo+
Cj5JIHN1Z2dlc3QgeW91IHRyeSBhbiBvbGRlciB2ZXJzaW9uIGZpcnN0IGFuZCB0aGVuIGVpdGhl
ciBmaWxlIGEgYnVnIG9uCj5naXRodWIgb3IgdG8gVWJ1bnR1Lgo+Cj5Kb2hhbgoKSSB3aWxsIGNo
ZWNrIG1vcmUgZGV0YWlscyAuIFRoYW5rcyBmb3IgdGhhdCEK

