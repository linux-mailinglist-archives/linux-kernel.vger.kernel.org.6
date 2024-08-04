Return-Path: <linux-kernel+bounces-273730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5BF946D04
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 09:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D781F2200E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 07:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12EC182DF;
	Sun,  4 Aug 2024 07:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="0O9wSYA/"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5D280B;
	Sun,  4 Aug 2024 07:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722756393; cv=none; b=EIbjdhV4cl34F73irJ9vX1N3TLeK/SkTx6zhnjcDAt+EtSd5K1tvXWswkaZo2sHuBs4gSQ2Nm7hb4YuylTEgXiWc5fysmMu+Gq/d/fNOTEvWZ+VhN+YrdfoOVMRfAp7rvNB3Y8KzuVk7cWTDIy9lwFIV+PhNJ9JXKz+DOl4fCSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722756393; c=relaxed/simple;
	bh=dAuVDlSyMeZNuLqxSz7NterThlpbjr86z6ZKmpDC2VM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=MhitSZs3mVWwV5rmDi/imDqjv9uLdxepF2KWYgRnGL3Ru7aDWz9IsoHCrVugpKDDXWTYP6iIOzLcmJRJ83hafmPvu7bhHzpEsP+82CGjTfvVRQvHgxP0wYVRFLaEXaP3/y/Ab05aitD2dWUutlcwhxa7Y4Lb1ZVA7UwkMXZUpg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=0O9wSYA/; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:Subject:Cc:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To
	:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=BwTIUcXIVgQHlYGADSPLZfW1MO/RwoZ6H/jWVojHn4c=; t=1722756390;
	x=1723188390; b=0O9wSYA/QdE35yBuFt7AyBNqnU3sOrVuZAJTR+7Dwn12RlW/xO2WNxhJlzzZB
	ceteaH862qKPGu7l50uMzjeMbcblKzplhZF/RM6ZKOYCZk2Gs4w5ksfqp0U0wtlB8wmhub8UiUATk
	tHJ8sjdOfusqU3M595ndhnHE8eNRz+cpkj5yzLAPw4OFOswtntn4f1VP2GhiustCI7uC7qVcrvtFS
	TMVhwcMmQLRjRRQwfCGD1q+KcW51dKXclqpmDoenbtX/pFbKtDh7c2N2zth7bGivowXteUPVFOzCr
	9ILtZhjPzTOt3x5jko5QHhq2uiUybTenxx5IWfJ6KJ3xJXhpfA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1saV2U-00084M-Re; Sun, 04 Aug 2024 08:48:22 +0200
Message-ID: <8a541683-36da-4cea-a8a9-db6ee875c86d@leemhuis.info>
Date: Sun, 4 Aug 2024 08:48:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Christian Heusel <christian@heusel.eu>
Subject: [REGRESSION] Keys register not or only later on the keyboard on the
 2022 Asus Vivobook S15 OLED
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1722756390;825f6818;
X-HE-SMSGID: 1saV2U-00084M-Re

Hi, Thorsten here, the Linux kernel's regression tracker.

Christian, I noticed a report about a regression in bugzilla.kernel.org
that appears to be caused by a change of yours:

de52aca4d9d56c ("usb: typec: ucsi: Never send a lone connector change
ack") [v6.10-rc1]

As many (most?) kernel developers don't keep an eye on the bug tracker,
I decided to write this mail. To quote from
https://bugzilla.kernel.org/show_bug.cgi?id=219108 :

> As the summary says, on the 2022 Asus Vivobook S15 OLED (model
> K3502ZA.306), the inbuilt keyboard has bad key registration after
> plugging the laptop in for charging. Sometimes, the keys pressed do not
> register at all, and sometimes they register very late. The keyboard
> works properly if I don't plug the laptop in to charge, and this issue
> doesn't manifest ever on kernels older than 6.6.37-1.
> 
> I have tested every lts kernel after 6.6.37-1 and all of them have 
> the same problem. I have also tested the latest mainline and zen
> kernels (versions 6.10.1 for both) and they too have the the same
> problem.> Once the laptop is plugged into it's charging cable, the
> keyboard fails and unplugging the laptop doesn't fix the situation.
> However, if I don't plug the laptop into it's charging cable, the
> problem never manifests itself. The charging cable itself is a usb
> type c cable and the laptop charges over thunderbolt.
See the ticket for more details. The problem still happens with
6.11-rc1, a straight revert was not possible.

Note, you have to use bugzilla to reach the reporter, as I sadly[1] can
not CCed them in mails like this.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

[1] because bugzilla.kernel.org tells users upon registration their
"email address will never be displayed to logged out users"

P.S.: let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: de52aca4d9d56c3b2f00b638d457075914b1a227
#regzbot title: usb: typec: ucsi: Keys register not or only later on the
keyboard on the 2022 Asus Vivobook S15 OLED
#regzbot from: No Name
#regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=219108
#regzbot ignore-activity

