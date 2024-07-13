Return-Path: <linux-kernel+bounces-251497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E892E930590
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 14:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C629282351
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 12:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2BD12E1D2;
	Sat, 13 Jul 2024 12:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="rPY00GjR"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEAF125B9;
	Sat, 13 Jul 2024 12:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720873598; cv=none; b=BS/n87BgXt0m42YCyIagimYNX7Eu+8NOBeTvEgBa8Y4IgB63kii2M7xVEHO4aSO5MvTGssfoLh5RcdA46aBpxjeNiydGt6vU6wpM+GGwB4DKJnZ+XuN4pKClo+duZ8o78YkrCbzOiwRUan9VfvIjFE57uPh3eXTC1NPXqusak6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720873598; c=relaxed/simple;
	bh=c7d5FFu4/4QR50/cDz1H5YRI4DQGYwqJXU/vWU59WeQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ckuUkP+X7I/v5gy1gOo2zCgA06ijt+3++9zLNnnbNEu9Ts8pSNXD28B2QDkNBn7o7lhmg26TlDt0B8y+IMlTBdpDszliUf2EH3gN8RcMyN4scUMzSBrh9Q91fQXyds3QFdZNJjj7zAyKr13+RqVrqd2pQ3V1+KX4180ArUTHm0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=rPY00GjR; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=P1XV7Rv5uafTDVUfOke6IbO5Jkmk6GUZlP0DD1NBgEQ=; t=1720873595;
	x=1721305595; b=rPY00GjRZml2eeut+Pg2oNobHXHKQLClgmIJrCcuU98GMqS3E8Ua5fSNabEVu
	x9ITO+R2TWvJpYXUrVrn/xYFPtJdV901oH9jYizalHk3IRuDxUQYq9HS1JvVVYsD8kEE+T222sazY
	fpZEIbBznyfUuP2se//o9iEA4yo0Ajvvq4RGYCQ7KyjeWkZoXRFAJB5jTz0pD2VwUthZ9qe0Pz4qg
	RjHS63QowxSplmE2n6xFpEzZPipnmIAJECSg9F5h2dQi0SXIYXjzZfDxq+CE8PPEGO4l7wYfK/WpU
	ZQJHm08JLsojevBJe4jBss3672TYnTqY+7Qg+WZpphGkXpM3Bw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sSbpc-0003rk-9X; Sat, 13 Jul 2024 14:26:28 +0200
Message-ID: <ac5d5415-bcc5-4db0-b1bb-6a8d193d43a7@leemhuis.info>
Date: Sat, 13 Jul 2024 14:26:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Quick extra regression report listing regression which available
 fixes
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>
References: <64d01ac5-9a84-44db-be72-ef22e6e5fc07@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <64d01ac5-9a84-44db-be72-ef22e6e5fc07@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1720873595;0efdb3bf;
X-HE-SMSGID: 1sSbpc-0003rk-9X

Quick update:

On 10.07.24 17:15, Thorsten Leemhuis wrote:

> There are two issues that worry me somewhat:
> 
> * A btrfs regression that leads to increased execution time of the
> kswapd0 process and symptoms as if there is not enough memory;
> [...]
> * bpf: build error with CONFIG_WERROR and CONFIG_BPF. 

Fixers for those to were mainlined, yeah. \o/

> There are a few regressions with available fixes, which seem to be
> unlikely to be submitted for mainline inclusion during this week afaics:
> 
> * net: dsa: mt7530-mdio: mt7531 switch on Bananapi-R64 not detected
> (known for 8 weeks already):
> https://lore.kernel.org/lkml/20240516204847.171029-1-linux@fw-web.de/
> https://lore.kernel.org/lkml/f485d1d4f7b34cc2ebf3d60030d1c67b4016af3c.1720107535.git.daniel@makrotopia.org/

No progress here afaics. This BTW is caused by 868ff5f4944aa9 ("net:
dsa: mt7530-mdio: read PHY address of switch from device tree")
[v6.10-rc1], which brings support for MT7530 and is part of a small
patch-set:
https://lore.kernel.org/all/20240418-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v3-0-3b5fb249b004@arinc9.com/
Makes me wonder if this could be fixed through a temporary revert; I
argued for that some time ago, but in the end found no support for it:
https://lore.kernel.org/lkml/2cac4cf68304e81abffbd9ff0387ee100323c2b7.camel@redhat.com/

> * drm/qxl: VM graphics often malfunction after boot and sometimes
> shutdowns occur (known for 5 weeks already):
> https://lore.kernel.org/regressions/DS7PR12MB57665F9F4BDF0598D7CC53DD94FF2@DS7PR12MB5766.namprd12.prod.outlook.com/
> https://lore.kernel.org/dri-devel/20240708142208.194361-1-tzimmermann@suse.de/

That issue is caused by b33651a5c98dbd ("drm/qxl: Do not pin buffer
objects for vmap") [v6.10-rc1]; the fix was queued for -next a few days
ago as c537fb4e3d36e7 ("drm/qxl: Pin buffer objects for internal
mappings") [next-20240711]

> There are a few regressions for which fixes are available, but those
> might or might not will be submitted for mainline inclusion during this
> week:
> 
> * ASoC: SOF: Intel: Lenovo Thinkpad X1 Carbon Gen 10 first S2idle fails,
> S0ix not even tried to enter from there on:
> https://github.com/thesofproject/linux/issues/5072
> https://bugzilla.kernel.org/show_bug.cgi?id=218961#c10

This issue is caused by d5263dbbd8af02 ("ASoC: SOF: Intel: don't ignore
IOC interrupts for non-audio transfers"); the fix "ASOC: SOF: Intel:
hda-loader: only wait for HDaudio IOC for IPC4 devices" is in a github
repo for more than a week already:
https://github.com/plbossart/sound/commit/7a8379a0d960ea48ef4ec8e682f0ea46e27e8020

> * pinctrl: rockchip: boot broke on RK3328 / Rock64
> https://lore.kernel.org/all/705544af-d615-4ff0-a54c-72a69140ce6d@eh5.me/
> https://lore.kernel.org/lkml/20240709105428.1176375-1-i@eh5.me/

That fix is still waiting for review.

> * drm/bridge: adv7511: Intermittent EDID failures; the fix after six
> weeks finally made it to a branch that likely will be submitted for
> mainline inclusion later this week.
> https://lore.kernel.org/lkml/20240521011614.496421-1-aford173@gmail.com/
> https://lore.kernel.org/lkml/20240630221931.1650565-1-aford173@gmail.com/

That fix is in the DRM PR airlied sent on Friday morning.

Ciao, Thorsten

