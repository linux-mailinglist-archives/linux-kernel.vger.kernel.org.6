Return-Path: <linux-kernel+bounces-213533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5855A90768B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC381C22978
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615AD1494D1;
	Thu, 13 Jun 2024 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b="lfbBGsPk"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4DC143724
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292344; cv=none; b=qt4cq0ovbMiPgAoQPOLfVlJHBW0qM8ckipw1fbF98tV/3XiFhcXJplb/8cV3vAe5oX1XC46QMwMJ1ZAe2zvjfLBgehA3joDpPbnGj6C/qkoBGRANVZxZVI31jrXAz+aH1DV+bDyyYfl0XoW181aXT+Cnr6eFXQkhTCgKA00ITkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292344; c=relaxed/simple;
	bh=SgEJ2ArjUh5vk1nxaTV96c7J0UGDKG9ggNn/hv9QBVQ=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJ/OMgumPU/D9C2+8ks01ExZqaZLU2meQYuM5/7XlieWBgmOWtmtnTM9nc3SW+OIDXIRT4JqPzEuful0TZq2O8v0SuG745Rux9auW1stB2ioQFzkKXH3mz1nC5lXncc4D6u5TQbcxFdqh7vENhB8U58wo+0ZqM9jN5w0g6sttqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b=lfbBGsPk; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1718292299; x=1718897099; i=aros@gmx.com;
	bh=Ygb1KSvOtuF6EFCGpBLSYEHo0+xaQK9o8HMczXZcc2U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lfbBGsPkPtGJJ+B9Y0PJoGY6Iiy1R9useqy8g9/usgSUvkKzXVMgPCz/YeloQDlS
	 Q1NTOfy+AuxQJeuoZutFs/yfUAIwL9NfsoVZz86XXAVxaeF1w26/pPo55sIeUqmMe
	 a7c4UZoC08QtZg9debjYIr2TIoqzMRJoWdqscxAtaLbzqxFLWM8h1GN95aIvcmq4K
	 Ff+xEt9hIv/dfBtU+rbTNC+zN37BuCQFiXWnV5xxXKZlpjpJ9tn+09rxEthh1y0nN
	 azKCw0affhr02Kuq0WpH12MlF0HnxhTcnp76tSsfWiYGqbby6PJubdZwQSuJ/u10K
	 dGYFyqDFnuR/fbjvZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.69.110.7] ([89.149.39.109]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M59C2-1sIsFb0vH2-000nHx; Thu, 13
 Jun 2024 17:24:59 +0200
Message-ID: <c87eae55-8159-4623-b68d-149ce8af590b@gmx.com>
Date: Thu, 13 Jun 2024 15:24:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: PC speaker doesn't work under Linux, works in GRUB/EFI
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Takashi Iwai <tiwai@suse.de>, Stas Sergeev <stsp@users.sourceforge.net>,
 Vsevolod Volkov <home+kernel@vvv.kiev.ua>
References: <186367bb-9ed4-42de-add2-59d3f50ec170@gmx.com>
 <ZmrWlflQxZa0rdv1@duo.ucw.cz>
Content-Language: en-US
From: "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <ZmrWlflQxZa0rdv1@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YlAaT/+X+GDvxD8jKFeumB3IEpWx0im190sFGMoiThjB0pgU51O
 mlwGQsbqAuE+ZXUnOqFKc91TNeDXLD4dAwqJ1+jZGqyYZkESkPBriG121wnbziD39lliwkf
 vfl+1DZnGs++9uCYy6xtexBgtQj1f00C6K+S3MTsti1SSR92ZsNrIHRhHsU6iCbB7ayWmtE
 462V6GvtpXKwkDgAfkXkA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gqOacp/jg6E=;FcmKKx7sFuqXmVcPFTY4tnlsZzz
 cRjdvf/04M+g1V/t5xg1ioU6wCN7toGeMTvWEHyIaME26UINU5UZPz6VwtaW/mnt3NZ6ri91k
 vtG3YhuijbRxL37oAGDmm26TZnERJiJZzIBwgfZai/l0wZy0/dMwlFP6+FaynE36Hwvtu3aig
 GL+WSj1TCntJsppjjLatI9CV5BfeAL4jaRX2BpS6x4sCJiytkgtfsiJ1WFaM7y3o9kT3D9qCU
 S8vVUwDkg0JomOEtvxPFVgKVLeiSZ9LZpXzH+5Um38EhLkJycFF8u1gtLYUr2i3duaqss79mZ
 4RD4/kIyBotqOG79sKMfnPw8TqMpTRG0MmTPJL6wFDpC3sHy/Ylo5DGpAh8gEb2W9evD6dm0S
 ml8lSZt+aaX3sGiYjiIOg5uBb1UzWxw5RsY7juO6a3AsF4p8Hmbv3G6mDM+6e+6GqQGu9sHs1
 b//HfwL9MoKEmfn13nyaUdC0i1Vjr5DfKJw2d02H53agzkjiFEXdFgUOGx80Swi7h80YAcsjj
 6pBw0M+WSGwUoMuhEl++dfePu5O674lfKKhWaKeRMb59smY5KvZq1CuFnyW9TxakLjTC+ArmK
 ZB6IQpPre2kUYCF+EXKcTs1jR9lnmrPp1BVA645U8Cdo+jyE8ukNqaFWEC3TsSMUwfCI2G/4u
 9zz1cyW50qvJTkhKiNBQKg5VMQaVnPj3STWLJuutgHvO+MW6Y8jQZrYx83niCN8YFSlbPpJuR
 8ghxNL4RNMWDnSZr7L/WDBoA51ajQ34oE3ohL+wIZcLo0Ld48QTSjCyIpj+C1Y3fCA2PyYWsu
 X+kd5Ai55xVyuzcWtQZ+Bi6557CdMfsDXLidougrQdSKc=

Works for me.

Regards,
Artem

On 6/13/24 11:23 AM, Pavel Machek wrote:
> On Sun 2024-06-02 12:53:26, Artem S. Tashkinov wrote:
>> Hello,
>>
>> There's a bug filed in the kernel bugzilla where Vsevolod is unable to
>> figure out why he cannot make his pc speaker work under Linux:
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D218918
>>
>> Strangely, it works just fine as an EFI module and a GRUB module.
>>
>> What are the ways to debug the issue?
>
> Is PC speaker even expected to work under linux?
> 								Pavel

