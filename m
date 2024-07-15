Return-Path: <linux-kernel+bounces-252063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 393FC930DC3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 07:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B87E1C20F75
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 05:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899AD13BAEE;
	Mon, 15 Jul 2024 05:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="Thr0n7VF"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560BB291E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 05:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721023151; cv=none; b=H18NuK1sn+jWte8OEcC05y3z2h536rUkRbyZpzEcL3So5sIy6KOOQuzNl+uK/fuNaKZORkOo9zw8pqwh+jmGROAIF43NAA2777COdqI75aeh1aw3Xb7bygO8Z5tHnZCm+KvzPEpSLI/1bUiyYDdxOYz7hWmgs9KaEMd/+x1CpNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721023151; c=relaxed/simple;
	bh=juFR0EYmwIBdOQzNi6lGCppgoAcFrFOOslvOhAh2zmU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=M1aN+ajQX2o0J2U0zSQl1VDVW4f+kvNoGeJDF9ZQ2JDU6GDBJxvKEqVocu1oCTWTRjKJdsTmXN7tCuom/Io6GDRrdJFzTXYKz8QWoWZ7PETMy9IQ2lBbZJnxqUT5uYy9ckNN+7mMq36D1Ed/r2ziOZWBn3ojpW1ptwHk+uXtZUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=Thr0n7VF reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=uJSzFegmGeysIOt5nBiYlkAzmXFoo/+umpO1rSDbX4k=; b=T
	hr0n7VFCQWwsHuUnYx8zGRDpW+A+XR0SFazUjfP5g5RIOhwj5OYXoo/aoEevwCV6
	Yu3t+KzbSuU6pQKR8axnXnLof5ikyteaZJ/n+K6cGc73eAZDULrgRJWPEOxzCadP
	hCRTDlZzxRKhusKMXq06Q2W6jiPkE3ClEj14SYELlA=
Received: from gaoshanliukou$163.com ( [123.150.8.43] ) by
 ajax-webmail-wmsvr-40-131 (Coremail) ; Mon, 15 Jul 2024 13:42:16 +0800
 (CST)
Date: Mon, 15 Jul 2024 13:42:16 +0800 (CST)
From: "yang.zhang" <gaoshanliukou@163.com>
To: patchwork-bot+linux-riscv@kernel.org
Cc: linux-riscv@lists.infradead.org, alexghiti@rivosinc.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-kernel@vger.kernel.org, yang.zhang@hexintek.com
Subject: Re:Re: [PATCH V3] riscv: set trap vector earlier
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <172098903367.7439.15717595350937923936.git-patchwork-notify@kernel.org>
References: <20240508022445.6131-1-gaoshanliukou@163.com>
 <172098903367.7439.15717595350937923936.git-patchwork-notify@kernel.org>
X-NTES-SC: AL_Qu2ZA/yZvUko4CWdYekfmk0bhe05W8a2svgk3YJSP514jA/owAw4dnlnBWvE3/uyMS6cnDyzbRF3ztVBRahlWK4LNXZFKo6r5xdVvznU89w9tA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4d0ea144.51f5.190b4e9c0f6.Coremail.gaoshanliukou@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD33wW4tpRmgJ8uAA--.12011W
X-CM-SenderInfo: pjdr2x5dqox3xnrxqiywtou0bp/1tbiJxEc8mXAmwBdTwABs1
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpoaToKWWVhaCwgdGhhbmtzLgoKCgoKCgoKCgoKCgoKQXQgMjAyNC0wNy0xNSAwNDozMDozMywg
cGF0Y2h3b3JrLWJvdCtsaW51eC1yaXNjdkBrZXJuZWwub3JnIHdyb3RlOgo+SGVsbG86Cj4KPlRo
aXMgcGF0Y2ggd2FzIGFwcGxpZWQgdG8gcmlzY3YvbGludXguZ2l0IChmb3ItbmV4dCkKPmJ5IFBh
bG1lciBEYWJiZWx0IDxwYWxtZXJAcml2b3NpbmMuY29tPjoKPgo+T24gV2VkLCAgOCBNYXkgMjAy
NCAxMDoyNDo0NSArMDgwMCB5b3Ugd3JvdGU6Cj4+IEZyb206ICJ5YW5nLnpoYW5nIiA8eWFuZy56
aGFuZ0BoZXhpbnRlay5jb20+Cj4+IAo+PiBUaGUgZXhjZXB0aW9uIHZlY3RvciBvZiB0aGUgYm9v
dGluZyBoYXJ0IGlzIG5vdCBzZXQgYmVmb3JlIGVuYWJsaW5nCj4+IHRoZSBtbXUgYW5kIHRoZW4g
c3RpbGwgcG9pbnRzIHRvIHRoZSB2YWx1ZSBvZiB0aGUgcHJldmlvdXMgZmlybXdhcmUsCj4+IHR5
cGljYWxseSBfc3RhcnQuIFRoYXQgbWFrZXMgaXQgaGFyZCB0byBkZWJ1ZyBzZXR1cF92bSgpIHdo
ZW4gYmFkCj4+IHRoaW5ncyBoYXBwZW4uIFNvIGZpeCB0aGF0IGJ5IHNldHRpbmcgdGhlIGV4Y2Vw
dGlvbiB2ZWN0b3IgZWFybGllci4KPj4gCj4+IFsuLi5dCj4KPkhlcmUgaXMgdGhlIHN1bW1hcnkg
d2l0aCBsaW5rczoKPiAgLSBbVjNdIHJpc2N2OiBzZXQgdHJhcCB2ZWN0b3IgZWFybGllcgo+ICAg
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcmlzY3YvYy82YWQ4NzM1OTk0YjgKPgo+WW91IGFyZSBh
d2Vzb21lLCB0aGFuayB5b3UhCj4tLSAKPkRlZXQtZG9vdC1kb3QsIEkgYW0gYSBib3QuCj5odHRw
czovL2tvcmcuZG9jcy5rZXJuZWwub3JnL3BhdGNod29yay9wd2JvdC5odG1sCj4K

