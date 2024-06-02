Return-Path: <linux-kernel+bounces-198240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 955C08D7570
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 14:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2491F22374
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 12:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723EE39FDD;
	Sun,  2 Jun 2024 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b="eDWE9+jc"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210B317C7C
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717332859; cv=none; b=CdRaJLcUc2qMBOpjKgcY52AadkPikuRKDCfxqDnhutyqL0CVx46ptzGAf6RFRG0wdIaI8TPUbgyQmBFZ58PgF/mKFLE1SSvb3rM4HT29XCkqudNWF3nPe9CVr/53dYcFB53wN+7uptjADGlC7o6ENtt03PLptAx28WabFVkYK/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717332859; c=relaxed/simple;
	bh=L++Vl/erQjkskbQxCxntq27twJw2gmNgkcz1HQ53or0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=HPSZe+A9zXeI7HO+46o9p5foteK1+miMQUmAUxgnTqfXWuCX2K+xZRad4ExDmsT+Rt3WSBfBatAxVyzUF7w3zV1aWE/4PR8W3H5dmLu5xV85ObLwUR+9pis53/Ky3mJS9R2G7M0LQfElW7sJUOu7EjjnXIRPzTsn8HKYNdM+/is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b=eDWE9+jc; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1717332809; x=1717937609; i=aros@gmx.com;
	bh=L++Vl/erQjkskbQxCxntq27twJw2gmNgkcz1HQ53or0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eDWE9+jc8Q01zvaYC3SWFSU3RwSltHtfPOBRfPTiNyWJHH8e7uWiJOkquWDJml5e
	 mFSDWw7mK+ewlX7/Y4ddaHK2oxveUaLAQtu0rM2rXXUmRHY4fOcbsjeS587TAlY8t
	 Edua59Z58f4jR1PRDMRY/fJNZDg10LStnlO1Vny1Nrfsn26jOg4bEdi426NQvEkRb
	 uwlRaSF7EgYyOVx2fDRGYp0cl3bPt6gMP6RpTey5zYomZrX38tsU1cAiCNSMgHlUk
	 18T8OopqndVIcJio9FISPjXejsijtBa0pzfz2liKkNEGxwvKMcTsXJbRP2FurhYIx
	 Yj5Y4WIu+sfMpuCzUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.23.110.14] ([98.159.234.106]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtwYu-1sS7Ge3Gdo-00uLrS; Sun, 02
 Jun 2024 14:53:29 +0200
Message-ID: <186367bb-9ed4-42de-add2-59d3f50ec170@gmx.com>
Date: Sun, 2 Jun 2024 12:53:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Content-Language: en-US
From: "Artem S. Tashkinov" <aros@gmx.com>
Subject: PC speaker doesn't work under Linux, works in GRUB/EFI
Cc: Thomas Gleixner <tglx@linutronix.de>, Takashi Iwai <tiwai@suse.de>,
 Stas Sergeev <stsp@users.sourceforge.net>,
 Vsevolod Volkov <home+kernel@vvv.kiev.ua>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:je52DwnSR5G4iUagH8spFTHJc9zmcLOiDELvQnN2QyCHt+5k3cl
 pShrIaxiddqQmMZ5H+WI2NN8PFgOaijFqu6GUSYl0fqm5RbZZIzNaX6we/iim0sPvabGLza
 IvysNdFG3j9qbCQVeTGqGVfD09LfEawif5BOJoaKGrNTY+jM2P/5xHJ6xF2BnH6RU+nOqSA
 lFOT2i4IJIF06iffbdeXQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:r8vVeyy8+U4=;8EFD7OfhPC6+D/yN0YV6Bz+5f7y
 342LloUVMoD3QTPiDvalKFmGooOn9vNiC5Ld/jIJ9wqaoDUcsbkR2wRKgblBcpryMd4pV88MP
 kiLT4WFPEcYEFCQEE2K95Yg91sTxjtjBk3RQh48EXjkEddojeOCcjqxcJtpOrp0w1DJhkKIkg
 hE0eMqjUMcdGmvzXpTh6ZvbAURUmIukp0B0fbEVEDn7OUr5XbJfg9wf7iLQUR9qsr0sKEv844
 H3upsdILrLnHoFjWYEdAb5apJEgUTu3GaRgnF2cso9NdW2MJRYf1W4Evs9x8imAV9lpDs8W/l
 4A+Ad8JhlAivEZXhvrSJshq66Tdb2tpZi0Cvu/d7Yqc4KN1px8ihIUsqVtvk81kAJWuxnpmfA
 35X6IoxQLUMQ92qqvLu7TJOPdNze36RPlCM3yMuPiq+/JhqK879da+OFuXHbupo4A8ukNkPta
 ol5SvyMpRCPiH9Twz5cva0AZjoEdMX+d/Jhnt7w53bnmJ7qiM1q14DhioPZveN/ZuFvl9949s
 +8apIIzC7d52/XjPQ75v9ATgyjYxAXRFyPjtxHgXUYYnASXz6Y+n6D3DfpYv+IYOuFUYdytqJ
 qJmMQVc0E3t8fbxHFjNUqhGP6pp6o1NAHIwTyFZfixsVPrktUwxKeM/0Nl/hbi+rt75oMFP0X
 DFejEYCBUbw3zTeCHnYPEUaqfONc2Q7K4UpNdgeqoXZ7zzaDEPtomQPAbchyhtMvNEFt40Zr3
 3vkqJyKsBuqgk8k03Zfs8tIMuhyPXJg4Pua7toXPF26/WLqRWO0+bk4pEDLVzSQHyGm6rV63g
 +416MNc8l0PSeIDvuBGc5fEpSHCQ03/FnA+Cy80mbmhH0=

Hello,

There's a bug filed in the kernel bugzilla where Vsevolod is unable to
figure out why he cannot make his pc speaker work under Linux:

https://bugzilla.kernel.org/show_bug.cgi?id=3D218918

Strangely, it works just fine as an EFI module and a GRUB module.

What are the ways to debug the issue?

Best regards,
Artem

