Return-Path: <linux-kernel+bounces-323249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED55C973A12
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320EC282FFF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87741194C8B;
	Tue, 10 Sep 2024 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=milecki.pl header.i=@milecki.pl header.b="EBjkt3PQ"
Received: from 12.mo584.mail-out.ovh.net (12.mo584.mail-out.ovh.net [178.33.104.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473FE193078
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.104.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979128; cv=none; b=KoOLH7wvG6m9xfROard9sIkIZqs74SWU5bkZILWBobJ6W/ABLD7MWivlwFYDaJmkn74D8kGtPU3kOHvPq6YH04aCDz13Z5XhB3SpFQNY9sdJAZCQtnCWFbJiB0OHpRrCz7lTrNnNXaeKTgZokGOLjlxHKtJ/RiYnSW28rjPbMZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979128; c=relaxed/simple;
	bh=MJt3Rru+uBpgUMua6KIX87xgyktXxLOqWjYIto//Djo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=k9V2O3GPf2GfSn2GCmOKqc9PrGzeH18eYT/nJ9qx9oQctb1Sy442/zjY6ktjPhvnVhzUODjAsseS1sCAiuneFwI7zrMAKyEgFeW0u0+z7Bhk/qfmY8fPSZGtXeOeeNa+9Jm85ut59jaiMSfm/z3rnlb/MW5JXd0H3rEHcf2RF04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=milecki.pl; spf=pass smtp.mailfrom=milecki.pl; dkim=pass (2048-bit key) header.d=milecki.pl header.i=@milecki.pl header.b=EBjkt3PQ; arc=none smtp.client-ip=178.33.104.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=milecki.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=milecki.pl
Received: from director8.ghost.mail-out.ovh.net (unknown [10.108.25.248])
	by mo584.mail-out.ovh.net (Postfix) with ESMTP id 4X34Df486pz160B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 13:24:34 +0000 (UTC)
Received: from ghost-submission-55b549bf7b-d9sjh (unknown [10.108.54.212])
	by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 0D0071FEA4;
	Tue, 10 Sep 2024 13:24:34 +0000 (UTC)
Received: from milecki.pl ([37.59.142.102])
	by ghost-submission-55b549bf7b-d9sjh with ESMTPSA
	id anSoL5FI4GZYvwEANbIJUw
	(envelope-from <rafal@milecki.pl>); Tue, 10 Sep 2024 13:24:34 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-102R004c171e367-4634-4f63-8ed1-ddbcd6b90eaf,
                    A78C61619C53E008915EB46F0F7CF9E5D291930A) smtp.auth=rafal@milecki.pl
X-OVh-ClientIp:151.80.29.18
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Sep 2024 15:24:33 +0200
From: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org, Miquel
 Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 4/9] nvmem: layouts: add U-Boot env layout
In-Reply-To: <2024090303-provider-humbly-17e2@gregkh>
References: <20240902142952.71639-1-srinivas.kandagatla@linaro.org>
 <20240902142952.71639-5-srinivas.kandagatla@linaro.org>
 <2024090308-smasher-craftwork-0db5@gregkh>
 <ef6d4f332224bd7a8c1c4244047bf0ea@milecki.pl>
 <2024090303-provider-humbly-17e2@gregkh>
Message-ID: <f4268b9f5ffc320320ef9a97902d3521@milecki.pl>
X-Sender: rafal@milecki.pl
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 5229242121419926308
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiledgheeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghfkfigihgtgfesthekjhdttddtjeenucfhrhhomheptfgrfhgrlhcuofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepjeejkeekgeejtdffffevffeivedtueeifeeuffegkeehkeeliedugfelfedutdeunecukfhppeduvdejrddtrddtrddupdefuddruddurddvudekrddutdeipdduhedurdektddrvdelrddukedpfeejrdehledrudegvddruddtvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheprhgrfhgrlhesmhhilhgvtghkihdrphhlpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkeegpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=Kdzm8axb8KA3W+gAi1rctb9WVIBGg4j1HlFHdZwn7N4=;
 c=relaxed/relaxed; d=milecki.pl; h=From; s=ovhmo3028686-selector1;
 t=1725974674; v=1;
 b=EBjkt3PQ8Ib9fl5O9zRpsflfuP3Wgj8IYhXoobfX9G6oua6eksCU+AkH2hjBnppxhfxWcNBt
 F18gLv3E61YnVKLJjyati2W1XOtji+LTouM20WkPN/R/svvTn/26AbLduHlBb77Tj6gCD+hfISH
 0wSt0njbh0I2ktxSukECTnkhHA2siST4CAm9sZ7QFNKgy9itRilwi5AKIq404VBrWCxoYA08uiM
 eYh9pRISX5MBLT615TccXjeCazKK/a+3kmbCUAWfELTV8AIpBdRw05eQ8L1h0lpE/H5B2gdqPXU
 n0s8NVbtfkwvjyuJNwBuHO54mspfFSLtlFGsLv3jTWIBg==

On 2024-09-03 13:24, Greg KH wrote:
> On Tue, Sep 03, 2024 at 01:04:20PM +0200, Rafał Miłecki wrote:
>> Hi Greg,
>> 
>> On 2024-09-03 12:12, Greg KH wrote:
>> > On Mon, Sep 02, 2024 at 03:29:47PM +0100, srinivas.kandagatla@linaro.org
>> > wrote:
>> > > From: Rafał Miłecki <rafal@milecki.pl>
>> > >
>> > > U-Boot environment variables are stored in a specific format. Actual
>> > > data can be placed in various storage sources (MTD, UBI volume,
>> > > EEPROM,
>> > > NVRAM, etc.).
>> > >
>> > > Move all generic (NVMEM device independent) code from NVMEM device
>> > > driver to an NVMEM layout driver. Then add a simple NVMEM layout
>> > > code on
>> > > top of it.
>> > >
>> > > This allows using NVMEM layout for parsing U-Boot env data stored in
>> > > any
>> > > kind of NVMEM device.
>> > >
>> > > The old NVMEM glue driver stays in place for handling bindings in the
>> > > MTD context. To avoid code duplication it uses exported layout parsing
>> > > function. Please note that handling MTD & NVMEM layout bindings may be
>> > > refactored in the future.
>> > >
>> > > Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> > > Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> > > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> > > ---
>> > >  MAINTAINERS                        |   1 +
>> > >  drivers/nvmem/Kconfig              |   3 +-
>> > >  drivers/nvmem/layouts/Kconfig      |  11 ++
>> > >  drivers/nvmem/layouts/Makefile     |   1 +
>> > >  drivers/nvmem/layouts/u-boot-env.c | 211
>> > > +++++++++++++++++++++++++++++
>> > >  drivers/nvmem/layouts/u-boot-env.h |  15 ++
>> > >  drivers/nvmem/u-boot-env.c         | 165 +---------------------
>> > >  7 files changed, 242 insertions(+), 165 deletions(-)
>> > >  create mode 100644 drivers/nvmem/layouts/u-boot-env.c
>> > >  create mode 100644 drivers/nvmem/layouts/u-boot-env.h
>> >
>> > This patch doesn't apply to my tree :(
>> >
>> > Also, if you generate patches with 'git format-patch -M' you can see
>> > when files move easier (if that's what happened here, hard to tell..)
>> 
>> It's because it was developed on top of "nvmem: u-boot-env: error if 
>> NVMEM
>> device is too small" which you applied to the "char-misc-linus" 
>> branch.
>> Perhaps you could push that fix ("error if...") to your both branches
>> somehow?
> 
> I can pull the char-misc-linus branch into my -next branch if that 
> would
> help out here?  Give me a few days to let 0-day run on things to make
> sure they are all sane first.

FWIW I can confirm that
[PATCH 4/9] nvmem: layouts: add U-Boot env layout
[PATCH 5/9] MAINTAINERS: Update path for U-Boot environment variables 
YAML
apply cleanly on top of the "char-misc-next".

-- 
Rafał Miłecki

