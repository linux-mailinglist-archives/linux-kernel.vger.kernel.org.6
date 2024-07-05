Return-Path: <linux-kernel+bounces-242195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 089679284D5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 394431C24649
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6F31465BF;
	Fri,  5 Jul 2024 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="HeJfC9Uh"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9BC14659D;
	Fri,  5 Jul 2024 09:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720170710; cv=none; b=sw4MIABavMSRZI2ireWkmiBFT+X7DH9DCkd839X+mD7wchygLG0TUSjV4ezr1oqWUJgNeD7CDmz+3xbesszFIMFTQYeYDMzNWGF9Vt4CsJDbZGn1j2ty6+/yWxWEFoxMQykwvf+sPSAnH4+vNyBkzLdB7Mvw2ao4doQWgCVeIWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720170710; c=relaxed/simple;
	bh=ZxOkMPLLO4TWWVtV0zDTV13SIp/eIXM0dGLkQvxSFN4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Y1AhI9tPrvup4UXxC8Q6bCdWvJkFcmD2NMLk5V/NhCu/VJT54dS5mCHmphcI+JKqh4Rn64QSFrMIHFaJwvyqbQh7o44PtOQaM6C84cSwdyCSKEe3v5ZGvV3SwlUgzp7fbNNRQ7Je6TgmgcbBgEjia6lbevdc9iUBt436vJIPaeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=HeJfC9Uh reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=Nw8Y/d4fbRo5a9YCTwvqTSz2Pd/J8LfElH2weiOPuv8=; b=H
	eJfC9UhSb2PC+0t5FQctqlhhDZLstB+SAaTzB+genXBO7lqZPiysxfpoMRxZZf8Y
	OJP6wqCC1L1EhmbruNX0YVwWPNDWZqxcpNNlth5WngGlbwZYC8bVpNoT2aTj+saz
	q+QDfIMBI2NN/1V1Pbt15netWcZlW3PuWudRgsHuwI=
Received: from slark_xiao$163.com ( [223.104.68.157] ) by
 ajax-webmail-wmsvr-40-111 (Coremail) ; Fri, 5 Jul 2024 17:11:22 +0800 (CST)
Date: Fri, 5 Jul 2024 17:11:22 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Johan Hovold" <johan@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] USB: serial: option: add support for Foxconn T99W651
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <Zoe3qBwWG33AZaU9@hovoldconsulting.com>
References: <20240705081709.105496-1-slark_xiao@163.com>
 <Zoe3qBwWG33AZaU9@hovoldconsulting.com>
X-NTES-SC: AL_Qu2ZAv2cv04j5CGYZOkfmk8Sg+84W8K3v/0v1YVQOpF8jDjp+j0MYERlA2nE9/KtDiu+jT6xbAlu2slFYrRcX6QNh9WsPIF2YjLRd0MMcCBMIA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5b098485.965d.190822996fc.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3_766uIdmZWQoAA--.26909W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiow0TZGVOEPiVBAACsJ
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjQtMDctMDUgMTc6MDY6NDgsICJKb2hhbiBIb3ZvbGQiIDxqb2hhbkBrZXJuZWwub3Jn
PiB3cm90ZToKPk9uIEZyaSwgSnVsIDA1LCAyMDI0IGF0IDA0OjE3OjA5UE0gKzA4MDAsIFNsYXJr
IFhpYW8gd3JvdGU6Cj4+IFQ5OVc2NTEgaXMgYSBSTkRJUyBiYXNlZCBtb2RlbSBkZXZpY2UuIFRo
ZXJlIGFyZSAzIHNlcmlhbCBwb3J0cwo+PiBuZWVkIHRvIGJlIGVudW1lcmF0ZWQ6IERpYWcsIE5N
RUEgYW5kIEFULgo+Cj4+IFNpZ25lZC1vZmYtYnk6IFNsYXJrIFhpYW8gPHNsYXJrX3hpYW9AMTYz
LmNvbT4KPgo+QXBwbGllZCwgdGhhbmtzLgo+Cj5Kb2hhbgpIaSBKb2hhbiwKSSBoYXZlIGEgY29u
Y2VybiBhYm91dCB0aGUgdGVzdCByZXN1bHQgb2YgInVzYi1kZXZpY2VzIiBpbiBVYnVudHUKMjIu
MDQuIERvIHlvdSBrbm93IHdoeSBpdCB3b3VsZG4ndCBzaG93IG91ciBkZXZpY2VzIGFueSBtb3Jl
PyAK

