Return-Path: <linux-kernel+bounces-195495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B06068D4D92
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654FB1F21B50
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CF9186E5C;
	Thu, 30 May 2024 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="jnzqorce"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A9D186E4C
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717078215; cv=none; b=L3rEMWk00KbxRrHQfxcE2asuQkCcahgVe6x3JCABbQAdnK4h+8BO9DC1Luupoa+claFJ7tNJevEMP9hllKQLynA2CcyhyHa4hl5hVBULQ0KXt+5qWaoC+MOiYherxN5ibiIEKwN1lnmD6KulKuG12zO7VD6M5es3Ukj1mwMoj7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717078215; c=relaxed/simple;
	bh=lJgkFmQAER2nocbB4Xots0SgtiMUfHc2h2KJ00LgsEU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=BqGT06VWJ4dtx5ZJLXA3H2N7ADAvKlA23b1DxHoM7XCi51cF8iQBp+gMy4n2o65Zx7Mmx+2daL5QVMDZ9XNVfxhW5MbWrRVsRRI72lul0EdWr7ApS/gWRs/fqGvWwcEvJk74sCEu5AzdZAeVaTZGeMhA+n50jNkkfphTO/DF6dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=jnzqorce reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=fqFBptFQdOFCKWxc0MG/C410x89u/n1T/+2yMEieJtc=; b=j
	nzqorcewGvb/wPhS7wS7UtME3cx76S7C4V89AuAcOyTL8V9anq56eQPCiOxOhrEY
	N2AG2C1wjDKnwPRJXA5JMIoQ4IyCrADYCCEuGWKFhUMRdsHTyizt01piGm23rE6Q
	Ez7YCJLFwQtBUTolk42Y/lYXCGzwmhszuYxM09TG4k=
Received: from 00107082$163.com ( [111.35.185.173] ) by
 ajax-webmail-wmsvr-40-121 (Coremail) ; Thu, 30 May 2024 22:09:46 +0800
 (CST)
Date: Thu, 30 May 2024 22:09:46 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Dimitri Sivanich" <sivanich@hpe.com>
Cc: kevin.tian@intel.com, baolu.lu@linux.intel.com, jroedel@suse.de, 
	linux-kernel@vger.kernel.org
Subject: Re: [Regression] 6.10-rc1: Fail to resurrect from suspend.
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <ZlhtwDqFek7lP+9X@hpe.com>
References: <20240530120110.22141-1-00107082@163.com>
 <ZlhtwDqFek7lP+9X@hpe.com>
X-NTES-SC: AL_Qu2aBfyct0kj4CeYZekXn0oTju85XMCzuv8j3YJeN500kiTT2ScZbWZcDVDzzsWQKgGlqQGGSgBS2N5bTLNoRKlB+nw1TUazE9I3l8InILJS
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <31f16e4e.afe2.18fc9d5dad0.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3X+ariFhm6JYkAA--.39977W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0gvuqmWXyDovmwAEst
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjQtMDUtMzAgMjA6MTQ6NTYsICJEaW1pdHJpIFNpdmFuaWNoIiA8c2l2YW5pY2hAaHBl
LmNvbT4gd3JvdGU6Cj5IaSBEYXZpZCwKPgo+VGhlcmUgaXMgYSBmaXggdG8gY29tbWl0IGQ3NDE2
OWNlYjAsIHdoaWNoIEknbGwgYmUgcG9zdGluZyBzaG9ydGx5LiAgSG9wZWZ1bGx5Cj50aGF0IHdp
bGwgcmVzb2x2ZSB5b3VyIGlzc3VlLgo+CgpIaSwgSSBqdXN0IGFwcGxpZWQgdGhhdCBwYXRjaCBv
biA2LjEwLXJjMSwgaXQgZG9zZSBmaXggbXkgcHJvYmxlbSEKClRoeH4KRGF2aWQKCg==

