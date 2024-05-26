Return-Path: <linux-kernel+bounces-189784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329318CF4E5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 18:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62CDE1C20B55
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 16:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836BA1C69E;
	Sun, 26 May 2024 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="meYLVjXQ"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEC618EAF;
	Sun, 26 May 2024 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716741624; cv=none; b=dbuuoXp1SChdbSyoojBzDnNB/7+yrGIPQflLqWoKF5nn+QdMr6R1V+v7SFj6ZIDBOPDc5Lc/JZC4y50nm9Vsn/tnR3/9a+vB4ZBFUP6bl4PALbexCtFBXdYuJHLldjfD8S85riKwm5xN/4E3VhV9zYwvZ3yRCbVxbQ9WZ1IgKh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716741624; c=relaxed/simple;
	bh=yOm6cdxOJDaW3vY/3rDEchTDMZQvn9FaKFIVCGigcZo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=OtKlCeSq4LYnbiXre8XwbNW98VM+sEO7KO66ObZirfbw0s00wYXdtbyjgobMdxR5n/fFwi9SMIzPE3KGMidKsD0jHiCQezlxm1352TOU39oMimNuijuKmaqP84Dbi0Y3w/IHj4I39JHHZzm5ipIte1QuM5fQwy1m8kMEKuIX9Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=meYLVjXQ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716741613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j3lZcgRjy9m9i6VrLn+CFxC//39rHct7UpondOikJUI=;
	b=meYLVjXQ14iHnjjG6vi6dXbEFJAFzMA7Dpk4lIIyPVVPoFpaMHYdL8m6kOW0lWbCeEM9+F
	lu9ivY3Sl+YlcdpQCiaV7XVlwHdp501iTC97XUQ+ezqRzM9el9N+hc/5Zx6Zds377cFE3M
	spGVPG4Sfo6QsbtJv56iEovKliySDyLg5LDhFi5Ul18YZj8EpymjWCc4PcgcDg8GgZpFbb
	vJ2W8n+rTj+C2JELC6Nb1f7hG8jAX9LvZV/PDU21534fV4cIgu0XijTnzjHxhxK8rUjjZs
	RUNWKOqJKVZWsYOo5qN4c12ptoCjx/g12xbp5reZ60XbMQRy+xWPt0zxA0A5IA==
Date: Sun, 26 May 2024 18:40:12 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Icenowy Zheng <uwu@icenowy.me>, linux-sunxi@lists.linux.dev,
 wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh+dt@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, didi.debian@cknow.org, Marek Kraus
 <gamiee@pine64.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: sunxi: Correct the descriptions for
 Pine64 boards
In-Reply-To: <90fada7d9a37a5e413b16bc176ec2f8d@manjaro.org>
References: <d2943d9f4c99a239f86188eaf45a73972685c255.1713833436.git.dsimic@manjaro.org>
 <057b4a5504656bb7455ead39768d9e7167fb724b.camel@icenowy.me>
 <5635a6e79427e43ef20b690c766267d0@manjaro.org>
 <20240522110507.51b12966@donnerap.manchester.arm.com>
 <90fada7d9a37a5e413b16bc176ec2f8d@manjaro.org>
Message-ID: <eeb46ba769f6ee9a1972cd104f0de19d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Andre and Icenowy,

On 2024-05-22 15:06, Dragan Simic wrote:
> On 2024-05-22 12:05, Andre Przywara wrote:
>> On Wed, 22 May 2024 08:10:21 +0200
>> Dragan Simic <dsimic@manjaro.org> wrote:
>>> On 2024-05-22 02:48, Icenowy Zheng wrote:
>>> > 在 2024-04-23星期二的 03:00 +0200，Dragan Simic写道：
>>> >> Correct the descriptions of a few Pine64 boards and devices,
>>> >> according
>>> >> to their official names used on the Pine64 wiki.  This ensures
>>> >> consistency
>>> >> between the officially used names and the names in the source code.
>>> >>
>>> >> [...]
>>> >>
>>> >> -      - description: Pine64 PineH64 model A
>>> >> +      - description: Pine64 H64 Model A
>>> >>          items:
>>> >>            - const: pine64,pine-h64
>>> >>            - const: allwinner,sun50i-h6
>>> >>  
>>> >> -      - description: Pine64 PineH64 model B
>>> >> +      - description: Pine64 H64 Model B
>>> >
>>> > Sorry for replying so late, but I don't think there is a Pine64 H64
>>> > board. The Pine64 wiki calls it Pine H64. [1]
>>> >
>>> > [1] https://wiki.pine64.org/wiki/PINE_H64
>>> 
>>> Good point, thanks.  Though, this board is really an exception to
>>> the naming scheme employed for the Pine64 boards, so perhaps it would
>>> actually be better to rename the board in the Pine64 wiki, by adding
>>> "64" to "Pine", to ensure consistency.
>> 
>> I am sorry, but I don't think this is how it works. The board is 
>> really
>> called "Pine H64", that's printed on the board [1] and everywhere else 
>> [2].
>> That's a choice the manufacturer made, and renaming some Wiki page 
>> won't
>> change that. I understand the engineer's desire to make everything 
>> nice and
>> consistent ;-) , but I am afraid that's not our call. After all this 
>> file
>> is to document the device naming, not to be an example of consistent
>> naming schemes.
>> 
>> [1] https://linux-sunxi.org/images/5/53/Pineh64_top.jpg
>> [2] https://pine64.org/devices/pine_h64_model_a/
> 
> Those are all valid concerns.  Though, when it comes to the 
> silkscreened
> labels on PCBs, sometimes they have no connection with the real, 
> official
> board names.  An almost funny example :) is the QuartzPro64 board, also
> from Pine64. [3]
> 
> I'll check with Pine64 are there some intentions for unifying the 
> officially
> used board names, and if there aren't, I'll submit the v2 of this 
> series
> with the corrected board names.
> 
> [3] 
> https://wiki.pine64.org/images/f/fe/Quartzpro64_whole_board_top_resized.jpeg

It's been decided that the history should be preserved, so I'll prepare
and submit the v2 of this series with the original Pine64 board names 
that
are currently used officially.

>>> Alas, the Pine64 wiki is currently in read-only mode, due to some
>>> recent issues with the underlying hardware that runs it.  Migration 
>>> to
>>> another form of documentation for Pine64 boards is also a 
>>> possibility,
>>> which makes the updates even more complicated.
>>> 
>>> With all this in mind, I think it would be the best to rename the 
>>> board
>>> on the Pine64 side, to ensure consistency, and keep this patch as-is.
>>> I'll make a mental note to do that on the Pine64 side once the 
>>> current
>>> situation with the Pine64 wiki is resolved.

