Return-Path: <linux-kernel+bounces-367420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F90E9A0210
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36381C21EEF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB59519939D;
	Wed, 16 Oct 2024 07:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="RUgsdyGu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J/vHIZOD"
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6895818C907;
	Wed, 16 Oct 2024 07:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729062181; cv=none; b=b3DGPVFLHYu+i3iXhuDOCa0sMRyIS8aa43JlvNj6ZQBajY4Hckwju/TQCqyOPClEO+ex/Jsh1nq9g+q6L4N+82+uwdEwePJXvsKgm379TLzo6xV+r+0Na+O65++0aFHzCkgmc37bJcnzh1IbkuGeqU8LkhhN7ZqaGGIMoqeH+YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729062181; c=relaxed/simple;
	bh=vOmqBFohwMz5om2jTIAbn8gvHHOtB1xyydrLvP/NKIY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=l4WreYkOWlQoyPMNAKOkhSvKpLC47jEOCt99VirO+SaLiKb8KvNy4usyFfKWp4phlgFYqNzwrLlwzfBm6vGVyWAmfE+dSrzSjKUwbce3XQyMjcFxJc7kao1xIF6mBKznUbb90vI5nf4uAJ0+qFKSx+gAlG3baUSuxjO0Xk0riX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=RUgsdyGu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J/vHIZOD; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4BB1F11400D2;
	Wed, 16 Oct 2024 03:02:58 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 16 Oct 2024 03:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729062178;
	 x=1729148578; bh=yfkfEvsulpe40ONpIh6p7Wb0oQQcNhxsy2JlWSdG6Pg=; b=
	RUgsdyGu5X+4CqLh3g0P5xGmAml4PJGaG8h9Fi0ii+zu0vnSkM3kgoqV/rjPxpZv
	XA/jIfRPWq6ZXjjP76ymf0UJW0KlmRDxh8f4Jyo2xD/uULqJRGfpkvVoy5oZHt0w
	fyNtW9xDhUPv0wxA9b5rrkN2S4epU0f/d1gaOliaQiIMb0V7gHtJ5BYE2x5NCNQy
	6u20VLDHN440dFXy9g2LiCRus/yysqg5n1TU+sn/oW/XcbCjZTF/5FKluxqnCIzk
	1UmY7VxkuJUHKhkn9sVv81qHhmOwS/C9TpdJQUc4Uwo1xRbkGIAqiHhws2C1ArPQ
	2+dHpglZPCJQgE8pmTQeEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729062178; x=
	1729148578; bh=yfkfEvsulpe40ONpIh6p7Wb0oQQcNhxsy2JlWSdG6Pg=; b=J
	/vHIZOD/izVSs59AOmMgEZvs8hND9bpyjcE8z3EAJ++qFJkAgeBtW5mz3vHBtsS9
	9iknqgRkHnu4Zqj/2usWsYf+G488u3vIQT5lB02WRVS5uC4MASkq/PhLfHwP33Zn
	Uxt7Etc56bvcQK6YCARWeC0ezVr+x+duQ24Wjz4lXRaiL/7gg4+8FUYYYEq9eCQB
	1oxsDJRDxtdE7G7egvcN+IqOxzkEJKEeUbFRol2U3F5PCvW/jReIwXxC9GUR47z1
	mOphIZZfMt8UOF07834hyTdTuGWwUA6mZBd00WpaoM6id7+v7zXqoTxAUzBO8ACA
	iNlp+SL5+0Ic0fHAWMljA==
X-ME-Sender: <xms:IGUPZwzcZQDJH_Rp2qqVuO54sAeKLzifNIwVlThOq9uNTi_CNav20Q>
    <xme:IGUPZ0SVFzpO5dCQoIioSdFWsceP6lFMmLd0iZhXuxmGwIUXi0b56RDMPb6mX-TBs
    bvH4RlFNPSBMsAyDnU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegkedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvleehvddv
    geejvdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthgrnhhgsghinhestghmshhsrd
    gthhhinhgrmhhosghilhgvrdgtohhmpdhrtghpthhtoheplhhgihhrugifohhougesghhm
    rghilhdrtghomhdprhgtphhtthhopeiihhhouhgssgdrrggrrhhonhesghhmrghilhdrtg
    homhdprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghr
    ohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepiihhohhusghinhgsihhnse
    hlohhonhhgshhonhdrtghnpdhrtghpthhtohepphgvrhgvgiesphgvrhgvgidrtgiipdhr
    tghpthhtohepthhifigrihesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:IGUPZyX-NXbXIZFvnPA4Xe1gLkjbJ6nzZgfqoiitlEvDTQITxwCHaA>
    <xmx:IGUPZ-jfUXznyru26e5LBdrAp2pOzRVWIzD3D0e7qFfJ7JfdSm33WQ>
    <xmx:IGUPZyCKKlRQfrpA2ibKxeuRiEs59Uomz66pQc6hq9gNhXXX5yREiw>
    <xmx:IGUPZ_IrnKQUTD-Dp3tutlk5g6X6rV-XMXZVkdpyp181c68xfrdBrg>
    <xmx:ImUPZ6vKvsYyYnooOo7XkkINPrddZDK7rMZwUNSXnrNP2qRqGUkY9fqm>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 72BD62220071; Wed, 16 Oct 2024 03:02:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 16 Oct 2024 07:02:36 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Binbin Zhou" <zhoubinbin@loongson.cn>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Liam Girdwood" <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>,
 "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 "Tang Bin" <tangbin@cmss.chinamobile.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Binbin Zhou" <zhoubb.aaron@gmail.com>
Message-Id: <887501dc-6bcc-4f98-b472-af609c4c370b@app.fastmail.com>
In-Reply-To: <52c7e318.434f.192941d2bee.Coremail.zhoubinbin@loongson.cn>
References: <20241015150958.2294155-1-arnd@kernel.org>
 <52c7e318.434f.192941d2bee.Coremail.zhoubinbin@loongson.cn>
Subject: Re: [PATCH] ASoC: loongson: make loongson-i2s.o a separate module
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024, at 06:56, =E5=91=A8=E5=BD=AC=E5=BD=AC wrote:
>> -----Original Messages-----
>> From: "Arnd Bergmann" <arnd@kernel.org>
>> Send time:Tuesday, 10/15/2024 23:09:54
>> To: "Liam Girdwood" <lgirdwood@gmail.com>, "Mark Brown" <broonie@kern=
el.org>, "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.=
com>, "Binbin Zhou" <zhoubinbin@loongson.cn>
>> Cc: "Arnd Bergmann" <arnd@arndb.de>, tangbin <tangbin@cmss.chinamobil=
e.com>, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
>> Subject: [PATCH] ASoC: loongson: make loongson-i2s.o a separate module
>>=20
>> From: Arnd Bergmann <arnd@arndb.de>
>>=20
>> An object file should not be linked into multiple modules and/or
>> vmlinux:
>>=20
>> scripts/Makefile.build:221: /home/arnd/arm-soc/sound/soc/loongson/Mak=
efile: loongson_i2s.o is added to multiple modules: snd-soc-loongson-i2s=
-pci snd-soc-loongson-i2s-plat
>
> I would like to ask for some advice.
> I didn't notice this warning before when I submitted the patch, is=20
> there some specific compilation option that needs to be turned on?

I think this is one of the warnings that are currently
only enabled when building with "make W=3D1". I have this enabled
by default as I hope to make it a default warning soon.

In general, I would recommend to build new driver code with W=3D1
before submitting.=20

     Arnd

