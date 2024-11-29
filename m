Return-Path: <linux-kernel+bounces-425243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A379DBF38
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 06:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFE85164C22
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 05:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD79715250F;
	Fri, 29 Nov 2024 05:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nh2.me header.i=@nh2.me header.b="leNc4IV8"
Received: from mail.nh2.me (mail.nh2.me [116.202.188.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6723E156C69
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 05:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.188.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732859294; cv=none; b=is8/it64jtuNV61YURP0yjldewGPyDtlYcJubwiG9p9d7iYYFEVYWx0wd9+S/4ddITrTcfhksbFmpalx1IMJJify2Dj+ke+vNGK9R1OcfAsYUzmNS5H4PB+bp0VWdsc+i2l9Y7LEmfr1YhQiu7vxnHHiRJNpf/dzkcxYE+hWtus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732859294; c=relaxed/simple;
	bh=nzuUJOZu4qwwNvn1tpyHAZaecgQ4913O0rPq1LBUu1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kcYQ1BnrjlGersPoYCqwMz4uNjLQbkeBsPu1iaakY/olYUgJR7eOljqhETPLYOSBHW/OpBswFGU6MsLZgJduJJ+HB9x7iOogniS5BjenOCKwDRuNnMmXjMOaTpUQ275up21Nbpkgqf5RCkZZmnn17gEydbV5XqMItm1NbpbatCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nh2.me; spf=pass smtp.mailfrom=nh2.me; dkim=pass (2048-bit key) header.d=nh2.me header.i=@nh2.me header.b=leNc4IV8; arc=none smtp.client-ip=116.202.188.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nh2.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nh2.me
Message-ID: <2c33be3f-8c41-48f1-a6ad-b4ea00ec515f@nh2.me>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nh2.me; s=mail;
	t=1732858728; bh=nzuUJOZu4qwwNvn1tpyHAZaecgQ4913O0rPq1LBUu1c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=leNc4IV80q5makjg4YnsxGTbsurQ6iKrQKq/9/3JsxtOkJmL1/+b4iX5Yl709FfV2
	 cojMrRvgVbFIrG5VgjF0fQiu2K1duy9dyEgRPdklUBCxbxmtC5TitJ3XgoEcBN3peO
	 vSC7+4ZtFLtfauf/dKi15v7vaTHFxdiZIcu9BBolSv2rH9z+bBy4+bkCHvVe7DAH6B
	 AjLS+qIEpzfD2qIKEUJJMjaPEwXV/JRgC5Y7s7VWP4FvD2Fte6CYi0moPysKrlsQyn
	 OnmM7HIgfIISl+5Cj0BRiEsGjGSZD6b7mC9KXsgd+7QrRbh1A4Y2WbY8LKlLms+t4p
	 GjIcTZKHxJeDA==
Date: Fri, 29 Nov 2024 06:38:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Wislist for Linux from the mold linker's POV
To: Rui Ueyama <rui314@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Florian Weimer <fw@deneb.enyo.de>
References: <CACKH++baPUaoQQhL0+qcc_DzX7kGcmAOizgfaCQ8gG=oBKDDYw@mail.gmail.com>
 <87ttbrs1c5.fsf@mid.deneb.enyo.de>
 <CACKH++br0qCHhxsy1kuyK29OB_bgME3FUXA_XepRL=7FYXOvQA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Niklas_Hamb=C3=BCchen?= <mail@nh2.me>
In-Reply-To: <CACKH++br0qCHhxsy1kuyK29OB_bgME3FUXA_XepRL=7FYXOvQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Rui,

On 2024-11-29 01:44, Rui Ueyama wrote:
> ext4 on a PCIe Gen.5 SSD, but I guess it probably doesn't matter much
> because we observed similar results even on tmpfs

When dealing with ext4, there's another behaviour useful to know, which is the opposite of what you observed:

When files are overwritten, it can suddenly be ~10x slower than if they are deleted and written from scratch.

I thought that shouldn't be, because the files are re-written from scratch using `O_WRONLY|O_CREAT|O_TRUNC` in both cases.

Turns out, `ext4` has built in a feature to work around bad applications forgetting `fsync()`:

`close()`ing new files is fast.
But if you `close()` existing files after writing them from scratch, or atomic-rename something replacing them, ext4 will insert an `fsync()`!

Sources:
* https://superuser.com/questions/865710/write-to-newfile-vs-overwriting-performance-issue/872056
* https://www.kernel.org/doc/html/latest/admin-guide/ext4.html section `auto_da_alloc`
* https://en.wikipedia.org/wiki/Ext4#Delayed_allocation_and_potential_data_loss

