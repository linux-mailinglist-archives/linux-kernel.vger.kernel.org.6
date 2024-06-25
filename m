Return-Path: <linux-kernel+bounces-228345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBCA915E80
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358761F23353
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 05:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65158145B33;
	Tue, 25 Jun 2024 05:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="WtK3zRrQ"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1029313C672;
	Tue, 25 Jun 2024 05:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719295011; cv=none; b=F4lVDSaP7mIb4G/kDVeTVUDWSLJysMKEm/8Ej9o/TNTpulBGCyhD7Q4GF/D/FmSlfEQ3rVHgX1q1rBUg1ajYfV+YshZ+SknW86CrEzqEFP4kCtyhEgJEOzBB8UXYAFviuOweCBEDfu9qWvIajdPYvjJyrXjy1sQEUgoglPW/GZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719295011; c=relaxed/simple;
	bh=e0hrp29pJGltLjFx/bA1YnlRBCvvlo7g+owpNA6BfM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yty11959ZEZMsH9ZLc0xemlVY/psejuzf3dDTJF+ZnjlCqZGw/7F+jTti6qDHlDnRJ0Ov/1KbsYSrAr6EQtY1kWnD42kprCegSg35sMMzdxl1hTSuWwgYgjhixt/Ijo3lh7m5/a3ZoJwbA+7FzEe+cwJiWloL/5UEwm9nXx8HfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=WtK3zRrQ; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=Fi0PpkRAy7VQ2C54ZJo6BAKncB41h/I16eVpJYJGK3U=;
	t=1719295009; x=1719727009; b=WtK3zRrQ5t2CsfcpBMn/YxXgnp1YaNsEds/5wVeR7giu74A
	FGNKXRpKR+qkia8UqERgiB4pFQlPvBtQp00TLcbd9J/+KnbuChwn7MqASi23mCGa2BEcbhDiM9GBl
	dFzD+g/BNLlK62YWQUidLdIGqmr82T9UR32mpi/ynIV+7J+3HDrqsymJs1GHecI0uUWpkdLghQKH8
	3eSU5fnDe6kLxzeV+yvTnIsAN6/xTvgoagY+vqhqyEnD3/uMr4gA1cugKZh36/4rY/QpizsLukfI+
	ePnnIBUjksq85SPWNmY46uqbAsPGCAXYHdCSshY63hLToWclOhtzqQ2G+Rwm7CDg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sLzAM-0002GH-6n; Tue, 25 Jun 2024 07:56:30 +0200
Message-ID: <750a60a6-4585-4bd2-97be-cf944e51fbdb@leemhuis.info>
Date: Tue, 25 Jun 2024 07:56:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
To: Paolo Abeni <pabeni@redhat.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>, frank-w@public-files.de,
 Frank Wunderlich <linux@fw-web.de>, =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?=
 <arinc.unal@arinc9.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
References: <20240516204847.171029-1-linux@fw-web.de>
 <a29dd7d1-40a8-4c88-99aa-651a3305b640@arinc9.com>
 <5AEE5668-0C8E-4EE4-A398-66CB99DF5650@public-files.de>
 <43aacd9d-b851-4100-8ccc-878ac6ae10f8@leemhuis.info>
 <698cf562-1ca9-4aa3-be7e-a1474b612c5b@leemhuis.info>
 <0cba095c-3d55-416a-a7ad-b359129731cf@arinc9.com>
 <714da201-654b-4183-8e5e-8ff0b64fe621@leemhuis.info>
 <2cac4cf68304e81abffbd9ff0387ee100323c2b7.camel@redhat.com>
 <b49c801c-6628-40a6-8294-0876d8871ba7@leemhuis.info>
 <e92c3ca0-c9be-44ac-a4fc-57ca5ebedbc5@leemhuis.info>
 <1807a142-1534-4fa4-ad4b-d1c03af014c2@arinc9.com>
 <58d8ddea-71cc-427a-94cc-a95f6bce61d2@collabora.com>
 <16e9c06e-9908-455d-a387-614fefe5bcf8@arinc9.com>
 <5e87d31c-b059-4f9a-93f7-dc87465ed14a@collabora.com>
 <4416ef22-78cc-4ce5-b61d-69ff0903811e@arinc9.com>
 <bd6b6929-d34d-4bd5-9cb0-bc8fe850ee46@leemhuis.info>
 <af561268-9793-4b5d-aa0f-d09698fd6fb0@arinc9.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <af561268-9793-4b5d-aa0f-d09698fd6fb0@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1719295009;5742f5c7;
X-HE-SMSGID: 1sLzAM-0002GH-6n

On 17.06.24 13:08, Arınç ÜNAL wrote:
> On 17/06/2024 11:33, Linux regression tracking (Thorsten Leemhuis) wrote:
> [...]
> I've submitted a patch series that fixes the regression. Angelo argued
> against the way the regression is fixed. I've very clearly argued back why
> I find Angelo's approach wrong. There's been no response back. I don't
> understand why reverting the patch is the likely outcome

Long story short: because that how things like that are handled in the
Linux kernel project, as Linus wants it like that. See some of the
quotes from https://docs.kernel.org/process/handling-regressions.html
for details.

> whilst the
> standing argument points towards applying the said patch series. If a
> revert happens before this discussion with Angelo finalises, this will set
> a precedent that will tell maintainers that they can have their way by just
> not replying to the ongoing discussions.
> 
> That said, the decision of resolving the regression by either reverting the
> patch or applying the patch series shall not depend on whether or not
> Angelo is pleased but rather there're no counter-arguments left on the
> points brought, meaning the decision shall be made depending on the
> argument that stands.
> 
> Therefore, I suggest that unless Angelo responds back with a
> counter-argument in the window of a week or two, as you've described, my
> patch series shall be applied.

It looks more and more like we are stuck here (or was there progress and
I just missed it?) while the 6.10 final is slowly getting closer. Hence:

AngeloGioacchino, should we ask the net maintainers to revert
868ff5f4944aa9 ("net: dsa: mt7530-mdio: read PHY address of switch from
device tree") for now to resolve this regression? Reminder, there is
nothing wrong with that commit per se afaik, it just exposes a problem
that needs to be fixed first before it can be reapplied.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

